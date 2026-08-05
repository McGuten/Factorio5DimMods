#!/usr/bin/env python3
"""Build per-tier recolour overlays for machines that never had 5Dim art.

``extract-tier-overlays.py`` lifts the recoloured region out of the 5Dim art of
``5dim_space_age``.  Some machines have no usable source to lift from: the 5Dim
art of the assembling machine and the oil refinery is from Factorio 1.1 and
draws a different building than the current one, so there is no region to map.

The fallback used to be ``applyTierTint``, which tints the whole machine.  On a
rust-and-brass building that reads as a solid block of colour instead of a
machine, so these two get the same treatment as the Space Age ones: **one part
recoloured, the rest vanilla**.  The part is selected here, from the vanilla
sprite itself:

    region = polygon drawn by hand  ∩  pixels the colour of that part

The polygon says *which part*; the colour test makes the edge follow the part
instead of cutting a rectangle through the pipes crossing in front of it.

The recolour matches the Space Age overlays: hue and saturation are replaced by
the tier's, and the vanilla value (shading) is kept, boosted by the gain the
original art uses.  ``TIER_RECOLOUR`` was measured on
``5dim_space_age/graphics/tier-overlay/fusion-reactor``; see --measure to redo it.

Output: 5dim_automation/graphics/tier-overlay/<entity>/<stem>-NN.png
        5dim_automation/graphics/tier-overlay/manifest.lua

Needs the vanilla art of an installed Factorio. It is located automatically
(``$FACTORIO_DIR``, the Windows workspace next to the repo, or ``~/factorio``)
and can be forced with ``--factorio-dir``.

Use --contact DIR to write a review strip per sprite: vanilla, the region, and
every tier that sprite serves, composited. The final check is visual, in the game.
"""

from __future__ import annotations

import argparse
import os
from dataclasses import dataclass, field
from pathlib import Path

import numpy as np
from matplotlib import colors as mcolors
from PIL import Image, ImageDraw
from scipy import ndimage


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "5dim_automation" / "graphics" / "tier-overlay"
OVERLAY_MOD = "__5dim_automation__"

TIERS = range(1, 11)

# Hue, saturation and the value ramp (V_out = gain * V_in + lift) of each tier,
# fitted over the fusion-reactor overlays (r = 0.91-0.99 against the vanilla
# value). Tier 8 is white, so its saturation is ~0; tier 6 is brown, so it is
# the only one that darkens.
TIER_RECOLOUR = {
    1:  (0.123, 0.887, 1.157, 0.112),
    2:  (0.009, 0.872, 1.204, 0.103),
    3:  (0.535, 0.927, 1.142, 0.090),
    4:  (0.875, 0.620, 1.206, 0.181),
    5:  (0.342, 0.934, 1.134, 0.084),
    6:  (0.060, 0.753, 1.040, -0.019),
    7:  (0.789, 0.831, 1.100, 0.045),
    8:  (0.004, 0.017, 1.096, 0.056),
    9:  (0.067, 0.877, 1.163, 0.098),
    10: (0.668, 0.667, 1.210, 0.154),
}

Box = tuple[int, int, int, int]


@dataclass
class Sprite:
    """One vanilla sprite and the part of it that carries the tier colour."""

    entity: str
    # Ruta del sprite vanilla tal y como la escribe el prototipo: es la clave
    # `match` del manifiesto.
    match: str
    # Poligono de la pieza. Vacio = todo el sprite (se usa con `hole`).
    part: Box | None = None
    # Recorte que se quita del poligono: el mecanismo central de la maquina,
    # que se queda vanilla.
    hole: Box | None = None
    # De donde se toma el color de referencia de la pieza.
    seed: Box = (0, 0, 0, 0)
    # Tolerancia en tono, saturacion y valor respecto a ese color.
    tol: tuple[float, float, float] = (0.08, 0.35, 0.26)
    min_px: int = 150
    # Tiers que se sirven de este sprite. Los tiers 1-3 de la assembling machine
    # son las maquinas vanilla, cada una con su arte, y del 4 al 10 son copias de
    # la 3: generar los diez para cada sprite dejaria ficheros que nadie carga.
    tiers: tuple[int, ...] = tuple(TIERS)
    stem: str = field(init=False)

    def __post_init__(self) -> None:
        self.stem = Path(self.match).stem

    def path(self, vanilla: Path) -> Path:
        rel = self.match.split("__/", 1)[1]
        mod = self.match.split("__")[1]
        return vanilla / mod / rel


# La assembling machine lleva la carcasa (paredes y faldon frontal); el
# mecanismo central se queda vanilla. Los tiers 1-3 son las maquinas vanilla y
# los tiers 4-10 copian la 3, asi que hacen falta las tres.
#
# La refineria lleva la columna central, la pieza alta que se reconoce en las
# cuatro direcciones. Ahi el poligono es la pieza y no hay recorte.
SPRITES = [
    Sprite(
        entity="assembling-machine",
        match="__base__/graphics/entity/assembling-machine-1/assembling-machine-1-base.png",
        hole=(30, 6, 150, 120),
        seed=(10, 60, 28, 120),
        tol=(0.045, 0.35, 0.30),
        tiers=(1,),
    ),
    Sprite(
        entity="assembling-machine",
        match="__base__/graphics/entity/assembling-machine-2/assembling-machine-2-base.png",
        hole=(30, 6, 152, 126),
        seed=(45, 138, 70, 160),
        tol=(0.20, 0.55, 0.40),
        tiers=(2,),
    ),
    Sprite(
        entity="assembling-machine",
        match="__base__/graphics/entity/assembling-machine-3/assembling-machine-3-base.png",
        hole=(30, 6, 150, 126),
        seed=(10, 58, 28, 120),
        # La pared derecha esta en sombra: sin margen en el valor se queda a
        # medio pintar y deja una franja verde sobre una maquina roja.
        tol=(0.055, 0.45, 0.42),
        tiers=(3, 4, 5, 6, 7, 8, 9, 10),
    ),
    Sprite(
        entity="oil-refinery",
        match="__base__/graphics/entity/oil-refinery/north/oil-refinery-north.png",
        part=(148, 52, 247, 222),
        seed=(170, 90, 225, 180),
    ),
    Sprite(
        entity="oil-refinery",
        match="__base__/graphics/entity/oil-refinery/east/oil-refinery-east.png",
        part=(95, 85, 195, 240),
        seed=(115, 110, 170, 200),
    ),
    Sprite(
        entity="oil-refinery",
        match="__base__/graphics/entity/oil-refinery/south/oil-refinery-south.png",
        part=(103, 26, 188, 216),
        seed=(120, 60, 170, 180),
    ),
    Sprite(
        entity="oil-refinery",
        match="__base__/graphics/entity/oil-refinery/west/oil-refinery-west.png",
        part=(178, 6, 268, 150),
        seed=(195, 25, 250, 85),
        tol=(0.09, 0.38, 0.28),
    ),
]


def load(path: Path) -> np.ndarray:
    return np.array(Image.open(path).convert("RGBA")).astype(np.float32) / 255.0


def save(arr: np.ndarray, path: Path) -> int:
    path.parent.mkdir(parents=True, exist_ok=True)
    Image.fromarray((np.clip(arr, 0, 1) * 255).astype(np.uint8), "RGBA").save(path, optimize=True)
    return path.stat().st_size


def box_mask(shape: tuple[int, int], box: Box) -> np.ndarray:
    im = Image.new("L", (shape[1], shape[0]), 0)
    ImageDraw.Draw(im).rectangle(box, fill=255)
    return np.array(im) > 127


def build_mask(img: np.ndarray, sprite: Sprite) -> np.ndarray:
    """Poligono de la pieza ∩ pixeles del color de la pieza, ya limpiado."""
    shape = img.shape[:2]
    alpha = img[..., 3] > 0.5
    hsv = mcolors.rgb_to_hsv(img[..., :3])

    area = alpha if sprite.part is None else alpha & box_mask(shape, sprite.part)
    if sprite.hole is not None:
        area = area & ~box_mask(shape, sprite.hole)

    ref = np.median(hsv[alpha & box_mask(shape, sprite.seed)], axis=0)
    dh = np.abs(hsv[..., 0] - ref[0])
    dh = np.minimum(dh, 1 - dh)
    close = (
        (dh < sprite.tol[0])
        & (np.abs(hsv[..., 1] - ref[1]) < sprite.tol[1])
        & (np.abs(hsv[..., 2] - ref[2]) < sprite.tol[2])
    )

    mask = ndimage.binary_closing(area & close, np.ones((5, 5)))
    labels, count = ndimage.label(mask)
    if count:
        sizes = ndimage.sum(mask, labels, range(1, count + 1))
        keep = [i + 1 for i, size in enumerate(sizes) if size >= sprite.min_px]
        mask = np.isin(labels, keep)
    return ndimage.binary_fill_holes(mask) & alpha


def recolour(img: np.ndarray, mask: np.ndarray, tier: int, feather: float) -> np.ndarray:
    """Overlay del tier: la pieza con el tono del tier y el sombreado vanilla."""
    hue, sat, gain, lift = TIER_RECOLOUR[tier]
    hsv = mcolors.rgb_to_hsv(img[..., :3]).copy()
    hsv[..., 0] = hue
    hsv[..., 1] = sat
    hsv[..., 2] = np.clip(gain * hsv[..., 2] + lift, 0, 1)

    # El borde interior de la mascara es duro y se nota como un escalon sobre el
    # arte vanilla; un desenfoque corto lo funde sin comerse la pieza.
    edge = ndimage.gaussian_filter(mask.astype(np.float32), feather) if feather else mask.astype(np.float32)

    out = np.zeros_like(img)
    out[..., :3] = mcolors.hsv_to_rgb(hsv)
    out[..., 3] = img[..., 3] * np.clip(edge, 0, 1)
    return out


def composite(base: np.ndarray, overlay: np.ndarray) -> np.ndarray:
    alpha = overlay[..., 3:4]
    out = base.copy()
    out[..., :3] = base[..., :3] * (1 - alpha) + overlay[..., :3] * alpha
    return out


def contact_strip(base: np.ndarray, mask: np.ndarray, tiers, feather: float, out: Path) -> None:
    height, width = base.shape[:2]
    cells = [base]
    marked = base.copy()
    marked[..., 0] = np.where(mask, 1.0, marked[..., 0] * 0.4)
    marked[..., 1] = np.where(mask, 0.0, marked[..., 1] * 0.4)
    marked[..., 2] = np.where(mask, 1.0, marked[..., 2] * 0.4)
    cells.append(marked)
    cells += [composite(base, recolour(base, mask, tier, feather)) for tier in tiers]

    sheet = Image.new("RGBA", ((width + 10) * len(cells), height), (45, 45, 45, 255))
    for index, cell in enumerate(cells):
        im = Image.fromarray((np.clip(cell, 0, 1) * 255).astype(np.uint8), "RGBA")
        sheet.paste(im, (index * (width + 10), 0), im)
    out.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(out)


def write_manifest(sprites: list[Sprite]) -> Path:
    by_entity: dict[str, list[Sprite]] = {}
    for sprite in sprites:
        by_entity.setdefault(sprite.entity, []).append(sprite)

    lines = [
        "-- Generated by mods/scripts/make-region-overlays.py -- do not edit by hand.",
        "--",
        "-- Maps each vanilla sprite layer to the per-tier recolour overlays that go",
        "-- on top of it.  Same shape as the 5dim_space_age manifest: `match` is the",
        "-- layer's filename and `overlays` the prefix of its ten tier files.",
        "return {",
    ]
    for entity in sorted(by_entity):
        lines.append(f'    ["{entity}"] = {{')
        for sprite in sorted(by_entity[entity], key=lambda s: s.match):
            lines.append("        {")
            lines.append(f'            match = "{sprite.match}",')
            lines.append("            overlays = {")
            lines.append(f'                "{OVERLAY_MOD}/graphics/tier-overlay/{sprite.entity}/{sprite.stem}-",')
            lines.append("            },")
            lines.append("        },")
        lines.append("    },")
    lines.append("}")
    lines.append("")

    path = OUTPUT / "manifest.lua"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines), encoding="utf-8")
    return path


def resolve_vanilla_data(explicit: str | None) -> Path:
    """Localiza el `data/` de una instalacion de Factorio.

    Igual que en extract-tier-overlays.py: si se pide una instalacion concreta y
    no vale, se falla en vez de tirar de otra por detras.
    """
    requested = explicit or os.environ.get("FACTORIO_DIR")
    if requested:
        data = Path(requested).expanduser().resolve() / "data"
        if not (data / "base" / "info.json").exists():
            raise SystemExit(f"No hay arte vanilla de Factorio en {data}.")
        return data

    candidates = [ROOT.parent, Path.home() / "factorio"]
    for candidate in candidates:
        data = candidate.resolve() / "data"
        if (data / "base" / "info.json").exists():
            return data

    raise SystemExit(
        "No se encuentra el arte vanilla de Factorio.\n"
        "Probado en: " + ", ".join(str(c / "data") for c in candidates) + "\n"
        "Indica la instalacion con --factorio-dir DIR o la variable FACTORIO_DIR."
    )


def measure(vanilla: Path) -> None:
    """Reajusta TIER_RECOLOUR contra los overlays ya existentes de Space Age."""
    source = vanilla / "space-age" / "graphics" / "entity" / "fusion-reactor" / "fusion-reactor-main.png"
    base = load(source)
    print("tier |   H     S   |  V = gain*V + lift |    r")
    for tier in TIERS:
        art = ROOT / "5dim_space_age" / "graphics" / "tier-overlay" / "fusion-reactor"
        overlay = load(art / f"fusion-reactor-main-{tier:02d}.png")
        inside = overlay[..., 3] > 0.8
        b = mcolors.rgb_to_hsv(base[inside][:, :3])
        o = mcolors.rgb_to_hsv(overlay[inside][:, :3])
        hue = (np.angle(np.exp(2j * np.pi * o[:, 0]).mean()) / (2 * np.pi)) % 1.0
        gain, lift = np.polyfit(b[:, 2], o[:, 2], 1)
        r = np.corrcoef(b[:, 2], o[:, 2])[0, 1]
        print(f"  {tier:2d} | {hue:.3f} {o[:, 1].mean():.3f} | {gain:.3f} {lift:+.3f} | {r:.3f}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--factorio-dir", help="Instalacion de Factorio de la que leer el arte vanilla.")
    parser.add_argument("--only", action="append", help="Solo esta entidad (repetible).")
    parser.add_argument("--contact", help="Directorio donde dejar las tiras de revision.")
    parser.add_argument("--feather", type=float, default=0.8, help="Suavizado del borde de la region, en pixeles.")
    parser.add_argument("--measure", action="store_true", help="Solo medir el recoloreado de Space Age y salir.")
    args = parser.parse_args()

    vanilla = resolve_vanilla_data(args.factorio_dir)
    if args.measure:
        measure(vanilla)
        return 0

    selected = [s for s in SPRITES if not args.only or s.entity in args.only]
    if not selected:
        raise SystemExit("Ninguna entidad coincide con --only.")

    total = 0
    for sprite in selected:
        source = sprite.path(vanilla)
        if not source.exists():
            raise SystemExit(f"Falta el arte vanilla: {source}")

        base = load(source)
        mask = build_mask(base, sprite)
        area = mask.sum() / max((base[..., 3] > 0.5).sum(), 1)
        if not mask.any():
            raise SystemExit(f"{sprite.stem}: la region ha salido vacia, revisa el poligono o la tolerancia.")

        size = 0
        for tier in sprite.tiers:
            out = OUTPUT / sprite.entity / f"{sprite.stem}-{tier:02d}.png"
            size += save(recolour(base, mask, tier, args.feather), out)
        total += size
        print(f"{sprite.entity:20s} {sprite.stem:34s} region {area:5.1%}  {size / 1024:7.0f} KiB")

        if args.contact:
            contact_strip(base, mask, sprite.tiers, args.feather, Path(args.contact) / f"{sprite.stem}.png")

    if args.only:
        print("\nmanifest sin tocar: --only solo escribiria las entidades filtradas.")
    else:
        print(f"\nmanifest -> {write_manifest(selected)}")
    print(f"total overlays: {total / 1024 / 1024:.1f} MiB")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
