#!/usr/bin/env python3
"""Extract per-tier recolour overlays for 5dim_space_age.

The tier art in ``5dim_space_age/graphics/entity`` is the vanilla art with one
hand-selected region recoloured per tier.  Shipping ten full copies of every
spritesheet costs ~994 MB, which is well over the mod portal's 262 MB limit.

Between tiers only 1-32% of the pixels change, the alpha channel is identical
and the recoloured region is the same for all ten tiers.  So the base image
never has to ship: it is the vanilla sheet, which Factorio already has loaded.
Only the recoloured region does.

Each sheet becomes two prototype layers::

    layer 1 = the vanilla sprite, untouched      -> 0 bytes shipped
    layer 2 = the recoloured region of tier N    -> the only thing shipped

Sheets fall in two groups:

``A``  The 5Dim frame size matches the current vanilla frame, so the region
       transfers straight across.

``B``  Wube re-rendered the art after the 5Dim copies were made (Dec 2024).
       The region has to be rebuilt on top of the current vanilla sheet.

Output: 5dim_space_age/graphics/tier-overlay/<entity>/<stem>-NN.png
        5dim_space_age/graphics/tier-overlay/manifest.lua

Needs the vanilla art of an installed Factorio. It is located automatically
(``$FACTORIO_DIR``, the Windows workspace next to the repo, or ``~/factorio``)
and can be forced with ``--factorio-dir``.

Run with --verify to recompose vanilla+overlay and diff against the original.
"""

from __future__ import annotations

import argparse
import os
import shutil
from dataclasses import dataclass, field
from pathlib import Path

import numpy as np
from PIL import Image
from scipy import ndimage


ROOT = Path(__file__).resolve().parents[1]
# Vanilla data directory of the installed Factorio. Resolved in main(), because
# it depends on the environment: see resolve_vanilla_data().
VANILLA = Path()
SOURCE = ROOT / "5dim_space_age" / "graphics" / "entity"
OUTPUT = ROOT / "5dim_space_age" / "graphics" / "tier-overlay"

TIERS = range(1, 11)

# The tier art was saved through an editor that shifted every channel slightly.
# Group A sheets land anywhere from 4 to 26, so colour drift alone cannot tell a
# re-save from a re-render.  Silhouette overlap can: group A sits at 99.5%+ while
# a genuine Wube re-render drops to 87-90%.
IOU_LIMIT = 0.985
DRIFT_LIMIT = 35.0


@dataclass
class Sheet:
    """One 5Dim spritesheet family (`<stem>-01.png` .. `<stem>-10.png`)."""

    entity: str
    stem: str
    #: vanilla PNGs this sheet maps onto, relative to `data/`.
    vanilla: list[str]
    group: str
    #: sprite grid (cols, rows) of ONE vanilla file; only needed for group B.
    grid: tuple[int, int] | None = None
    #: mod-relative path of the vanilla leaf that owns this sheet.  A single
    #: `util.sprite_load` leaf can span several PNGs (`filenames`), so more than
    #: one 5Dim sheet can belong to the same prototype layer.
    leaf: str = ""
    #: position of this sheet inside that leaf's `filenames` list (1-based).
    leaf_index: int = 1
    notes: str = ""
    #: filled in during processing
    stats: dict = field(default_factory=dict)

    @property
    def key(self) -> str:
        return f"{self.entity}/{self.stem}"


SHEETS = [
    # --- Phase 0 pilot A: simplest possible case -------------------------
    # 238x268, a single frame, matches vanilla biochamber.png exactly.
    # graphics_set.animation.layers[1], frame_count=1 repeat_count=64.
    Sheet(
        entity="biochamber",
        stem="biochamber",
        vanilla=["space-age/graphics/entity/biochamber/biochamber.png"],
        group="A",
        leaf="__space-age__/graphics/entity/biochamber/biochamber.png",
        notes="biochamber-frozen.png shares these dimensions; the plain file is the body",
    ),
    # --- Phase 0 pilot B: re-rendered by Wube, structure preserved --------
    # 5Dim ships 2 files of 8x8 frames (376x398); vanilla is 2 files of 8x8
    # frames (338x354) via foundry-anim.lua filenames/lines_per_file.
    Sheet(
        entity="foundry",
        stem="foundry-main-1",
        vanilla=["space-age/graphics/entity/foundry/foundry-anim-1.png"],
        group="B",
        grid=(8, 8),
        leaf="__space-age__/graphics/entity/foundry/foundry-anim-1.png",
        leaf_index=1,
    ),
    Sheet(
        entity="foundry",
        stem="foundry-main-2",
        vanilla=["space-age/graphics/entity/foundry/foundry-anim-2.png"],
        group="B",
        grid=(8, 8),
        leaf="__space-age__/graphics/entity/foundry/foundry-anim-1.png",
        leaf_index=2,
    ),

    # --- Group A ---------------------------------------------------------
    # Every sheet below matches its vanilla file frame-for-frame (silhouette
    # IoU >= 99.5%), so the recoloured region transfers straight across.
    # The `leaf` values come from Factorio's own --dump-data output.

    # lab: on_animation / off_animation both point at the same sheet.
    Sheet(
        entity="biolab",
        stem="biolab-anim",
        vanilla=["space-age/graphics/entity/biolab/biolab-anim.png"],
        group="A",
        leaf="__space-age__/graphics/entity/biolab/biolab-anim.png",
    ),
    # assembling-machine with an animation4way; each file serves two directions.
    Sheet(
        entity="crusher",
        stem="crusher-horizontal",
        vanilla=["space-age/graphics/entity/crusher/crusher-horizontal.png"],
        group="A",
        leaf="__space-age__/graphics/entity/crusher/crusher-horizontal.png",
    ),
    Sheet(
        entity="crusher",
        stem="crusher-vertical",
        vanilla=["space-age/graphics/entity/crusher/crusher-vertical.png"],
        group="A",
        leaf="__space-age__/graphics/entity/crusher/crusher-vertical.png",
    ),
    # Art lives in graphics_set.working_visualisations[N].animation.
    Sheet(
        entity="electromagnetic-plant",
        stem="electromagnetic-plant-main-warm-up",
        vanilla=["space-age/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-warm-up.png"],
        group="A",
        leaf="__space-age__/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-warm-up.png",
    ),
    Sheet(
        entity="electromagnetic-plant",
        stem="electromagnetic-plant-main-cool-down",
        vanilla=["space-age/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-cool-down.png"],
        group="A",
        leaf="__space-age__/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-cool-down.png",
    ),
    Sheet(
        entity="electromagnetic-plant",
        stem="electromagnetic-plant-main-rotate-continue",
        vanilla=["space-age/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-rotate-continue.png"],
        group="A",
        leaf="__space-age__/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-rotate-continue.png",
    ),
    # One leaf spanning two files (lines_per_file = 7, 111 frames).
    Sheet(
        entity="electromagnetic-plant",
        stem="electromagnetic-plant-main-rotate-1",
        vanilla=["space-age/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-rotate-1.png"],
        group="A",
        leaf="__space-age__/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-rotate-1.png",
        leaf_index=1,
    ),
    Sheet(
        entity="electromagnetic-plant",
        stem="electromagnetic-plant-main-rotate-2",
        vanilla=["space-age/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-rotate-2.png"],
        group="A",
        leaf="__space-age__/graphics/entity/electromagnetic-plant/electromagnetic-plant-main-rotate-1.png",
        leaf_index=2,
    ),
    # Art lives in graphics_set.<direction>_graphics_set.animation.
    *[
        Sheet(
            entity="fusion-generator",
            stem=f"fusion-generator-{d}",
            vanilla=[f"space-age/graphics/entity/fusion-generator/{d}/fusion-generator-{d}.png"],
            group="A",
            leaf=f"__space-age__/graphics/entity/fusion-generator/{d}/fusion-generator-{d}.png",
        )
        for d in ("north", "east", "south", "west")
    ],
    # Art lives in graphics_set.structure.
    Sheet(
        entity="fusion-reactor",
        stem="fusion-reactor-main",
        vanilla=["space-age/graphics/entity/fusion-reactor/fusion-reactor-main.png"],
        group="A",
        leaf="__space-age__/graphics/entity/fusion-reactor/fusion-reactor-main.png",
    ),
    # lightning-attractor: chargable_graphics.picture.
    Sheet(
        entity="lightning-collector",
        stem="lightning-collector",
        vanilla=["space-age/graphics/entity/lightning-collector/lightning-collector.png"],
        group="A",
        leaf="__space-age__/graphics/entity/lightning-collector/lightning-collector.png",
    ),
    # mining-drill: graphics_set.animation plus working_visualisations.
    *[
        Sheet(
            entity="big-mining-drill",
            stem=f"big-mining-drill-{stem}",
            vanilla=[f"space-age/graphics/entity/big-mining-drill/{folder}/big-mining-drill-{stem}.png"],
            group="A",
            leaf=f"__space-age__/graphics/entity/big-mining-drill/{folder}/big-mining-drill-{stem}.png",
        )
        for folder, stem in (
            ("North", "N-still"),
            ("East", "E-still-front"),
            ("South", "S-still-front"),
            ("West", "W-still-front"),
        )
    ],
    # One leaf spanning two files (lines_per_file = 4, 64 frames).
    Sheet(
        entity="thruster",
        stem="thruster-1",
        vanilla=["space-age/graphics/entity/thruster/thruster-1.png"],
        group="A",
        leaf="__space-age__/graphics/entity/thruster/thruster-1.png",
        leaf_index=1,
    ),
    Sheet(
        entity="thruster",
        stem="thruster-2",
        vanilla=["space-age/graphics/entity/thruster/thruster-2.png"],
        group="A",
        leaf="__space-age__/graphics/entity/thruster/thruster-1.png",
        leaf_index=2,
    ),

    # --- Group B ---------------------------------------------------------
    # recycler: the same case as foundry, one sheet per direction.  Wube
    # re-rendered it, so the frames grew (142x308 -> 170x304 in the north sheet),
    # but the 8x8 grid and the 64 frames survived, which is all the transfer
    # needs.
    #
    # Two things are specific to this entity: the art ships in the `recycler`
    # mod, not in `space-age`, and the four `flipped-*` sheets belong to
    # `graphics_set_flipped`.  The leaf walk is generic, so neither needs special
    # handling beyond being listed here.  The body is
    # `graphics_set.animation.<direction>.layers[0]`; layers[1] is the shadow and
    # the `-lights` sheets are additive glow, both skipped by the walk.
    *[
        Sheet(
            entity="recycler",
            stem=f"recycler-{key}",
            vanilla=[f"recycler/graphics/entity/recycler/recycler-{key}.png"],
            group="B",
            grid=(8, 8),
            leaf=f"__recycler__/graphics/entity/recycler/recycler-{key}.png",
        )
        for key in ("N", "E", "S", "W", "flipped-N", "flipped-E", "flipped-S", "flipped-W")
    ],
    # rocket-silo: two single-frame sprites, `base_day_sprite` and
    # `base_front_sprite`.  Neither lives inside a `layers` array, so tier-art.lua
    # wraps them in one.
    #
    # These sheets happen to have the same dimensions as the `*-frozen` variants,
    # which made it look like the 5Dim art had been built on the wrong file.  It
    # was not: frozen is a sparse frost layer (21.8% silhouette overlap), while
    # the plain sheet is the same render, re-done slightly larger -- the body box
    # grew from 592x597 to 603x606.  So it is an ordinary group B sheet.
    *[
        Sheet(
            entity="rocket-silo",
            stem=stem,
            vanilla=[f"base/graphics/entity/rocket-silo/{stem}.png"],
            group="B",
            grid=(1, 1),
            leaf=f"__base__/graphics/entity/rocket-silo/{stem}.png",
        )
        for stem in ("06-rocket-silo", "14-rocket-silo-front")
    ],
]

#: Sheets deliberately left out, and why.  Revisit these with the group B work.
PARKED = {
    "agricultural-tower": "structural change: the 64 animated frames became a static "
                          "base plus a separate 192x168 anim layer",
    "asteroid-collector": "same structural change: 4x4 animated frames vs a static "
                          "vanilla base, with the animation moved to *-anim.png",
    "mech-armor": "not entity art at all -- a 120x64 icon with a mipmap chain",
    "platform-hub": "orphan art: no generator builds a tiered space-platform-hub",
    "fusion-reactor-equipment": "already wired as full art and only 632 KB; left alone",
}


def load(path: Path) -> np.ndarray:
    return np.array(Image.open(path).convert("RGBA"))


def save(arr: np.ndarray, path: Path) -> int:
    path.parent.mkdir(parents=True, exist_ok=True)
    Image.fromarray(arr, "RGBA").save(path, optimize=True, compress_level=9)
    return path.stat().st_size


def tier_paths(sheet: Sheet) -> dict[int, Path]:
    return {t: SOURCE / sheet.entity / f"{sheet.stem}-{t:02d}.png" for t in TIERS}


def load_tiers(sheet: Sheet) -> dict[int, np.ndarray]:
    """Load the ten tier images, asserting the invariants the plan relies on."""
    paths = tier_paths(sheet)
    missing = [str(p) for p in paths.values() if not p.exists()]
    if missing:
        raise FileNotFoundError(f"{sheet.key}: missing {len(missing)} tier files, e.g. {missing[0]}")

    tiers = {t: load(p) for t, p in paths.items()}
    shapes = {a.shape for a in tiers.values()}
    if len(shapes) != 1:
        raise ValueError(f"{sheet.key}: tiers disagree on shape: {shapes}")

    alpha = tiers[1][:, :, 3]
    for t, a in tiers.items():
        if not np.array_equal(a[:, :, 3], alpha):
            raise ValueError(f"{sheet.key}: tier {t} alpha differs from tier 1")

    return tiers


def recolour_mask(tiers: dict[int, np.ndarray]) -> np.ndarray:
    """Pixels that differ between any two tiers: the hand-selected region."""
    mask = np.zeros(tiers[1].shape[:2], dtype=bool)
    for t in TIERS:
        if t == 1:
            continue
        mask |= np.any(tiers[t] != tiers[1], axis=2)
    return mask


def build_overlay(tier_img: np.ndarray, mask: np.ndarray) -> np.ndarray:
    """The tier's pixels inside the region, fully transparent everywhere else."""
    overlay = np.zeros_like(tier_img)
    overlay[mask] = tier_img[mask]
    return overlay


def composite(base: np.ndarray, overlay: np.ndarray) -> np.ndarray:
    """Straight alpha-over, matching how Factorio draws stacked layers."""
    b = base.astype(np.float64) / 255.0
    o = overlay.astype(np.float64) / 255.0
    oa = o[:, :, 3:4]
    ba = b[:, :, 3:4]
    out_a = oa + ba * (1 - oa)
    with np.errstate(invalid="ignore", divide="ignore"):
        out_rgb = np.where(
            out_a > 0,
            (o[:, :, :3] * oa + b[:, :, :3] * ba * (1 - oa)) / np.maximum(out_a, 1e-9),
            0.0,
        )
    return (np.clip(np.dstack([out_rgb, out_a]), 0, 1) * 255).round().astype(np.uint8)


def drift(a: np.ndarray, b: np.ndarray, where: np.ndarray) -> float:
    """Mean absolute RGB difference over `where`."""
    if where.sum() == 0:
        return float("nan")
    d = np.abs(a[where][:, :3].astype(np.int16) - b[where][:, :3].astype(np.int16))
    return float(d.mean())


# ---------------------------------------------------------------------------
# Group A: the 5Dim sheet and the vanilla sheet are the same render
# ---------------------------------------------------------------------------

def process_group_a(sheet: Sheet, verify: bool) -> dict:
    tiers = load_tiers(sheet)
    mask = recolour_mask(tiers)

    if len(sheet.vanilla) != 1:
        raise ValueError(f"{sheet.key}: group A expects exactly one vanilla file")
    van_path = VANILLA / sheet.vanilla[0]
    if not van_path.exists():
        raise FileNotFoundError(f"{sheet.key}: vanilla sheet not found at {van_path}")
    van = load(van_path)

    if van.shape != tiers[1].shape:
        raise ValueError(
            f"{sheet.key}: vanilla {van.shape[1]}x{van.shape[0]} != "
            f"5dim {tiers[1].shape[1]}x{tiers[1].shape[0]} -- this is a group B sheet"
        )

    van_solid = van[:, :, 3] > 8
    sa_solid = tiers[1][:, :, 3] > 8
    iou = np.logical_and(van_solid, sa_solid).sum() / max(np.logical_or(van_solid, sa_solid).sum(), 1)
    if iou < IOU_LIMIT:
        raise ValueError(
            f"{sheet.key}: silhouette overlap with vanilla is only {100*iou:.2f}% "
            f"(need {100*IOU_LIMIT:.1f}%); Wube re-rendered this art -- it is a group B sheet"
        )

    visible = (van[:, :, 3] == 255) & (tiers[1][:, :, 3] == 255)
    outside = visible & ~mask
    d = drift(tiers[1], van, outside)
    if not (d < DRIFT_LIMIT):
        raise ValueError(
            f"{sheet.key}: RGB drift outside the region is {d:.2f} (limit {DRIFT_LIMIT}); "
            "the 5Dim art is not the same render as current vanilla -- reclassify as group B"
        )

    stats = {
        "group": "A",
        "shape": f"{van.shape[1]}x{van.shape[0]}",
        "mask_pct": 100 * mask.mean(),
        "iou": 100 * iou,
        "drift": d,
        "orig_bytes": sum(p.stat().st_size for p in tier_paths(sheet).values()),
        "overlay_bytes": 0,
        "worst_residual": 0.0,
    }

    out_dir = OUTPUT / sheet.entity
    for t in TIERS:
        overlay = build_overlay(tiers[t], mask)
        stats["overlay_bytes"] += save(overlay, out_dir / f"{sheet.stem}-{t:02d}.png")

        if verify:
            # What the game will actually draw, versus the original tier art.
            got = composite(van, overlay)
            residual = drift(got, tiers[t], visible)
            stats["worst_residual"] = max(stats["worst_residual"], residual)

    return stats


# ---------------------------------------------------------------------------
# Group B: Wube re-rendered the art, so the region has to be rebuilt
# ---------------------------------------------------------------------------

#: Group A sheets used to learn what the recolour does, as (entity, stem, vanilla).
#: These have exact vanilla counterparts, so they give clean (source -> tier) pairs.
LUT_SOURCES = [
    ("thruster", "thruster-1", "space-age/graphics/entity/thruster/thruster-1.png"),
    ("biolab", "biolab-anim", "space-age/graphics/entity/biolab/biolab-anim.png"),
    ("crusher", "crusher-horizontal", "space-age/graphics/entity/crusher/crusher-horizontal.png"),
    ("biochamber", "biochamber", "space-age/graphics/entity/biochamber/biochamber.png"),
]

_LUT_CACHE: dict[int, np.ndarray] = {}


def luminance(rgb: np.ndarray) -> np.ndarray:
    """Mean of the channels -- fit the tier recolour better than rec601/rec709."""
    return rgb.astype(np.float64).mean(axis=-1)


def learn_recolour_luts() -> dict[int, np.ndarray]:
    """Per-tier 256-entry gradient map, pooled over the group A sheets.

    The recolour turns out to be close to a luminance gradient map.  Pooling
    several entities keeps one machine's palette from dominating.
    """
    if _LUT_CACHE:
        return _LUT_CACHE

    pooled: dict[int, list[tuple[np.ndarray, np.ndarray]]] = {t: [] for t in TIERS}
    for entity, stem, rel in LUT_SOURCES:
        van_path = VANILLA / rel
        base = SOURCE / entity / f"{stem}-01.png"
        if not van_path.exists() or not base.exists():
            continue
        van = load(van_path)
        tiers = {t: load(SOURCE / entity / f"{stem}-{t:02d}.png") for t in TIERS}
        if van.shape != tiers[1].shape:
            continue
        mask = recolour_mask(tiers)
        for t in TIERS:
            sel = mask & (van[:, :, 3] == 255) & (tiers[t][:, :, 3] == 255)
            if sel.sum():
                pooled[t].append((van[sel][:, :3], tiers[t][sel][:, :3]))

    for t in TIERS:
        if not pooled[t]:
            raise RuntimeError(f"no group A pairs available to learn the tier {t} recolour")
        src = np.concatenate([p[0] for p in pooled[t]])
        dst = np.concatenate([p[1] for p in pooled[t]]).astype(np.float64)
        idx = np.clip(luminance(src).round().astype(int), 0, 255)
        lut = np.zeros((256, 3))
        cnt = np.zeros(256)
        np.add.at(lut, idx, dst)
        np.add.at(cnt, idx, 1.0)
        seen = cnt > 0
        lut[seen] /= cnt[seen][:, None]
        # Fill unseen luminances by interpolating between the ones we saw.
        xs = np.where(seen)[0]
        for c in range(3):
            lut[:, c] = np.interp(np.arange(256), xs, lut[xs, c])
        _LUT_CACHE[t] = lut

    return _LUT_CACHE


def frames(arr: np.ndarray, grid: tuple[int, int]):
    """Yield (index, slice_y, slice_x) for each cell of a cols x rows sheet."""
    cols, rows = grid
    h, w = arr.shape[:2]
    if h % rows or w % cols:
        raise ValueError(f"grid {cols}x{rows} does not divide a {w}x{h} sheet")
    fh, fw = h // rows, w // cols
    for i in range(cols * rows):
        r, c = divmod(i, cols)
        yield i, slice(r * fh, (r + 1) * fh), slice(c * fw, (c + 1) * fw)


def bbox(alpha: np.ndarray) -> tuple[int, int, int, int] | None:
    ys, xs = np.where(alpha > 8)
    if len(ys) == 0:
        return None
    return int(ys.min()), int(xs.min()), int(ys.max()), int(xs.max())


def snap_to_colour_regions(mask: np.ndarray, frame: np.ndarray, coverage: float = 0.5) -> np.ndarray:
    """Pull the transferred region onto the new art's own colour boundaries.

    The alignment is only good to ~90%, so the transferred edge cuts across
    shapes.  Labelling the frame into flat-colour blobs and keeping the blobs
    that are mostly covered moves the edge back onto real art edges.
    """
    opaque = frame[:, :, 3] > 8
    if not opaque.any():
        return np.zeros_like(mask)

    quant = (frame[:, :, :3] >> 4).astype(np.int32)
    code = (quant[:, :, 0] << 8) | (quant[:, :, 1] << 4) | quant[:, :, 2]
    code = np.where(opaque, code + 1, 0)

    out = np.zeros_like(mask)
    for value in np.unique(code):
        if value == 0:
            continue
        labels, count = ndimage.label(code == value)
        if count == 0:
            continue
        total = ndimage.sum_labels(np.ones_like(mask, dtype=np.float64), labels, range(1, count + 1))
        inside = ndimage.sum_labels(mask.astype(np.float64), labels, range(1, count + 1))
        keep = np.zeros(count + 1, dtype=bool)
        keep[1:] = (inside / np.maximum(total, 1)) >= coverage
        out |= keep[labels]
    return out


def transfer_mask(sheet: Sheet, mask_old: np.ndarray, old: np.ndarray,
                  new: np.ndarray) -> tuple[np.ndarray, dict]:
    """Move the recoloured region from the old render onto the new one.

    The region is a static part of the machine: across the old sheet's frames
    it holds at 99.9% IoU even though the body animates.  So it is resolved
    exactly once and stamped onto every frame.  Rebuilding it per frame makes
    the edge wobble by a few percent between frames, which reads as flicker.
    """
    grid = sheet.grid
    old_cells = list(frames(old, grid))
    new_cells = list(frames(new, grid))
    if len(old_cells) != len(new_cells):
        raise ValueError(f"{sheet.key}: frame counts differ ({len(old_cells)} vs {len(new_cells)})")

    # Consensus of the old region across frames, in frame-local coordinates.
    votes = None
    for _, sy, sx in old_cells:
        cell = mask_old[sy, sx].astype(np.float64)
        votes = cell if votes is None else votes + cell
    consensus = votes >= (len(old_cells) * 0.5)
    agreement = float((votes[consensus] / len(old_cells)).mean()) if consensus.any() else 0.0

    old_boxes = [b for _, sy, sx in old_cells if (b := bbox(old[sy, sx, 3]))]
    new_boxes = [b for _, sy, sx in new_cells if (b := bbox(new[sy, sx, 3]))]
    if not old_boxes or not new_boxes:
        raise ValueError(f"{sheet.key}: could not find silhouettes to align")

    ob = np.median(np.array(old_boxes), axis=0).astype(int)
    nb = np.median(np.array(new_boxes), axis=0).astype(int)
    old_h, old_w = ob[2] - ob[0] + 1, ob[3] - ob[1] + 1
    new_h, new_w = nb[2] - nb[0] + 1, nb[3] - nb[1] + 1

    # Rescale the region from the old silhouette box onto the new one.
    crop = consensus[ob[0]:ob[0] + old_h, ob[1]:ob[1] + old_w]
    resized = np.array(
        Image.fromarray((crop * 255).astype(np.uint8), "L")
        .resize((int(new_w), int(new_h)), Image.NEAREST)
    ) > 127

    _, fsy, fsx = new_cells[0]
    local = np.zeros(new[fsy, fsx].shape[:2], dtype=bool)
    y1 = min(nb[0] + resized.shape[0], local.shape[0])
    x1 = min(nb[1] + resized.shape[1], local.shape[1])
    local[nb[0]:y1, nb[1]:x1] = resized[:y1 - nb[0], :x1 - nb[1]]

    # Snap once, against the first frame, then stamp the same region everywhere.
    snapped = snap_to_colour_regions(local, new[fsy, fsx])

    out = np.zeros(new.shape[:2], dtype=bool)
    for _, sy, sx in new_cells:
        out[sy, sx] = snapped

    return out, {
        "frame_agreement": agreement,
        "scale": (float(new_w / old_w), float(new_h / old_h)),
        "snapped_delta": float(snapped.sum() - local.sum()) / max(local.sum(), 1),
    }


def process_group_b(sheet: Sheet, verify: bool) -> dict:
    if sheet.grid is None:
        raise ValueError(f"{sheet.key}: group B needs an explicit sprite grid")
    if len(sheet.vanilla) != 1:
        raise ValueError(f"{sheet.key}: group B expects exactly one vanilla file per sheet")

    tiers = load_tiers(sheet)
    mask_old = recolour_mask(tiers)

    van_path = VANILLA / sheet.vanilla[0]
    if not van_path.exists():
        raise FileNotFoundError(f"{sheet.key}: vanilla sheet not found at {van_path}")
    van = load(van_path)

    mask_new, align = transfer_mask(sheet, mask_old, tiers[1], van)
    luts = learn_recolour_luts()

    stats = {
        "group": "B",
        "shape": f"{van.shape[1]}x{van.shape[0]}",
        "mask_pct": 100 * mask_new.mean(),
        "drift": float("nan"),
        "orig_bytes": sum(p.stat().st_size for p in tier_paths(sheet).values()),
        "overlay_bytes": 0,
        "worst_residual": float("nan"),
        "mask_pct_old": 100 * mask_old.mean(),
        **align,
    }

    lum = np.clip(luminance(van[:, :, :3]).round().astype(int), 0, 255)
    out_dir = OUTPUT / sheet.entity
    for t in TIERS:
        overlay = np.zeros_like(van)
        recoloured = luts[t][lum[mask_new]]
        overlay[mask_new, :3] = np.clip(recoloured, 0, 255).round().astype(np.uint8)
        overlay[mask_new, 3] = van[mask_new, 3]
        stats["overlay_bytes"] += save(overlay, out_dir / f"{sheet.stem}-{t:02d}.png")

    return stats


# ---------------------------------------------------------------------------

def process(sheet: Sheet, verify: bool) -> dict:
    if sheet.group == "A":
        return process_group_a(sheet, verify)
    return process_group_b(sheet, verify)


def contact_sheet(sheet: Sheet, out_path: Path) -> None:
    """Tile vanilla+overlay for all ten tiers so the result can be eyeballed.

    Group B has no numeric ground truth -- the region is rebuilt rather than
    copied -- so this is the only way to judge it.
    """
    van = load(VANILLA / sheet.vanilla[0])
    grid = sheet.grid or (1, 1)
    _, sy, sx = next(iter(frames(van, grid)))
    base_frame = van[sy, sx]

    cells = []
    for t in TIERS:
        overlay = load(OUTPUT / sheet.entity / f"{sheet.stem}-{t:02d}.png")[sy, sx]
        cells.append(composite(base_frame, overlay))

    fh, fw = base_frame.shape[:2]
    pad = 8
    strip = np.zeros((fh + 2 * pad, (fw + pad) * len(cells) + pad, 4), dtype=np.uint8)
    for i, cell in enumerate(cells):
        x = pad + i * (fw + pad)
        strip[pad:pad + fh, x:x + fw] = cell

    out_path.parent.mkdir(parents=True, exist_ok=True)
    Image.fromarray(strip, "RGBA").save(out_path)


def write_manifest(sheets: list[Sheet]) -> Path:
    """Emit the table tier-art.lua reads: vanilla leaf -> overlay files.

    Keyed by the leaf's first filename, because that is what identifies a
    `util.sprite_load` layer once the vanilla prototype has been built.
    """
    by_entity: dict[str, dict[str, list[Sheet]]] = {}
    for sheet in sheets:
        if not sheet.leaf:
            raise ValueError(f"{sheet.key}: no vanilla leaf recorded")
        by_entity.setdefault(sheet.entity, {}).setdefault(sheet.leaf, []).append(sheet)

    lines = [
        "-- Generated by mods/scripts/extract-tier-overlays.py -- do not edit by hand.",
        "--",
        "-- Maps each vanilla sprite layer to the per-tier recolour overlays that go",
        "-- on top of it.  `match` is the layer's filename (or filenames[1]); the",
        "-- `overlays` list mirrors that layer's own filenames list, so a multi-file",
        "-- animation gets a multi-file overlay with the same geometry.",
        "return {",
    ]
    for entity in sorted(by_entity):
        lines.append(f"    [{entity!r}] = {{".replace("'", '"'))
        for leaf in sorted(by_entity[entity]):
            group = sorted(by_entity[entity][leaf], key=lambda s: s.leaf_index)
            lines.append("        {")
            lines.append(f'            match = "{leaf}",')
            lines.append("            overlays = {")
            for sheet in group:
                rel = f"__5dim_space_age__/graphics/tier-overlay/{sheet.entity}/{sheet.stem}-"
                lines.append(f'                "{rel}",')
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
    """Locate the `data/` directory of an installed Factorio.

    The repo is cloned in two shapes: inside the Windows workspace, where it
    sits in `<workspace>/mods` next to `data/`, and on its own in WSL, where
    the install lives outside the repo.
    """
    # --factorio-dir and FACTORIO_DIR are instructions, not hints: if one is
    # given and it is wrong, say so instead of silently using another install.
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


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--factorio-dir", metavar="DIR",
                        help="installed Factorio to read the vanilla art from "
                             "(default: $FACTORIO_DIR, the workspace, or ~/factorio)")
    parser.add_argument("--verify", action="store_true",
                        help="recompose vanilla+overlay and report the residual error")
    parser.add_argument("--only", metavar="ENTITY", action="append",
                        help="restrict to these entities (repeatable)")
    parser.add_argument("--clean", action="store_true",
                        help="wipe the output directory first")
    parser.add_argument("--contact", metavar="DIR",
                        help="write a ten-tier contact strip per sheet into DIR for review")
    args = parser.parse_args()

    global VANILLA
    VANILLA = resolve_vanilla_data(args.factorio_dir)

    if args.clean and OUTPUT.exists():
        shutil.rmtree(OUTPUT)

    selected = [s for s in SHEETS if not args.only or s.entity in args.only]
    if not selected:
        print("nothing selected")
        return 1

    failures = []
    total_orig = total_overlay = 0

    for sheet in selected:
        try:
            stats = process(sheet, args.verify)
        except Exception as exc:  # noqa: BLE001 - report and keep going
            failures.append((sheet.key, exc))
            print(f"FAIL  {sheet.key}: {type(exc).__name__}: {exc}")
            continue

        total_orig += stats["orig_bytes"]
        total_overlay += stats["overlay_bytes"]
        line = (
            f"ok    {sheet.key:34s} [{stats['group']}] {stats['shape']:>11s}  "
            f"region={stats['mask_pct']:5.2f}%  "
            f"{stats['orig_bytes']/1e6:7.2f} MB -> {stats['overlay_bytes']/1e6:6.2f} MB "
            f"({100*stats['overlay_bytes']/stats['orig_bytes']:4.1f}%)"
        )
        if args.verify:
            line += f"  drift={stats['drift']:.2f}  residual={stats['worst_residual']:.2f}"
        print(line)

        if args.contact:
            path = Path(args.contact) / f"{sheet.entity}-{sheet.stem}.png"
            contact_sheet(sheet, path)
            print(f"      contact strip -> {path}")

    if total_orig:
        print("-" * 96)
        print(f"total: {total_orig/1e6:.2f} MB -> {total_overlay/1e6:.2f} MB "
              f"({100*total_overlay/total_orig:.1f}%)")

    if failures:
        pass
    elif args.only:
        # The manifest is rewritten from scratch, so emitting it from a filtered
        # run would drop every other entity from it.  Nothing would break loudly:
        # tier-art.lua just falls back to the tint for whatever went missing.
        print("manifest sin tocar: --only solo escribiria las entidades filtradas.\n"
              "Regeneralo con una pasada completa (sin --only) al terminar.")
    else:
        print(f"manifest -> {write_manifest(selected)}")

    if failures:
        print(f"\n{len(failures)} sheet(s) failed")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
