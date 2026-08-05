#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path

from PIL import Image, ImageChops, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
FAMILY_NAMES = {"charging", "logistic", "construction", "compact"}


def get_icon_target(family: str) -> Path:
    return ROOT / "5dim_logistic" / "graphics" / "icons" / f"roboport-{family}"


def get_base_target(family: str) -> Path:
    return ROOT / "5dim_logistic" / "graphics" / "entities" / "roboport" / f"roboport-base-{family}"


def get_base_patch_target(family: str) -> Path:
    return ROOT / "5dim_logistic" / "graphics" / "entities" / "roboport" / f"roboport-base-patch-{family}"


def ensure_dirs(family: str) -> tuple[Path, Path, Path]:
    icon_target = get_icon_target(family)
    base_target = get_base_target(family)
    base_patch_target = get_base_patch_target(family)

    icon_target.mkdir(parents=True, exist_ok=True)
    base_target.mkdir(parents=True, exist_ok=True)
    base_patch_target.mkdir(parents=True, exist_ok=True)

    return icon_target, base_target, base_patch_target


def load_image(source: Path) -> Image.Image:
    return Image.open(source).convert("RGBA")


def remove_black_background(image: Image.Image, threshold: int) -> Image.Image:
    rgba = image.convert("RGBA")
    pixels = rgba.load()
    width, height = rgba.size

    for y in range(height):
        for x in range(width):
            red, green, blue, alpha = pixels[x, y]
            if alpha == 0:
                continue

            if red <= threshold and green <= threshold and blue <= threshold:
                pixels[x, y] = (red, green, blue, 0)

    return rgba


def trim(image: Image.Image) -> Image.Image:
    background = Image.new("RGBA", image.size, (0, 0, 0, 0))
    diff = ImageChops.difference(image, background)
    bbox = diff.getbbox()
    if not bbox:
        return image
    return image.crop(bbox)


def crop_relative(image: Image.Image, bounds: tuple[float, float, float, float] | None) -> Image.Image:
    if not bounds:
        return image

    left, top, right, bottom = bounds
    width, height = image.size
    crop_box = (
        max(0, min(width, round(width * left))),
        max(0, min(height, round(height * top))),
        max(0, min(width, round(width * right))),
        max(0, min(height, round(height * bottom))),
    )

    if crop_box[0] >= crop_box[2] or crop_box[1] >= crop_box[3]:
        return image

    return image.crop(crop_box)


def fit_canvas(image: Image.Image, size: tuple[int, int], scale: float, offset_y: float = 0.0) -> Image.Image:
    width, height = size
    trimmed = trim(image)

    target_width = max(1, int(width * scale))
    target_height = max(1, int(height * scale))
    resized = trimmed.copy()
    resized.thumbnail((target_width, target_height), Image.Resampling.LANCZOS)

    canvas = Image.new("RGBA", size, (0, 0, 0, 0))
    pos_x = (width - resized.width) // 2
    pos_y = int((height - resized.height) * 0.5 + offset_y)
    canvas.alpha_composite(resized, (pos_x, pos_y))
    return canvas


def sharpen(image: Image.Image) -> Image.Image:
    return image.filter(ImageFilter.UnsharpMask(radius=1.2, percent=130, threshold=2))


def build_base_sprite(source: Image.Image, scale: float, offset_y: float) -> Image.Image:
    canvas = fit_canvas(source, (228, 277), scale, offset_y=offset_y)
    return sharpen(canvas)


def build_icon(
    source: Image.Image,
    scale: float,
    offset_y: float,
    crop_bounds: tuple[float, float, float, float] | None,
) -> Image.Image:
    icon_source = trim(source)
    icon_source = crop_relative(icon_source, crop_bounds)
    canvas = fit_canvas(icon_source, (64, 64), scale, offset_y=offset_y)
    return sharpen(canvas)


def build_base_patch() -> Image.Image:
    return Image.new("RGBA", (138, 100), (0, 0, 0, 0))


def save_repeated(image: Image.Image, directory: Path, prefix: str) -> None:
    for tier in range(1, 11):
        image.save(directory / f"{prefix}-{tier:02d}.png")


def ensure_deletable_source(source: Path, family: str) -> None:
    forbidden_targets = {
        get_icon_target(family),
        get_base_target(family),
        get_base_patch_target(family),
    }

    source_parent = source.resolve().parent
    if source_parent in forbidden_targets:
        raise SystemExit("Refusing to delete a source file from the generated target directories.")


def main() -> None:
    parser = argparse.ArgumentParser(description="Install custom art for a specialized roboport family.")
    parser.add_argument("source", type=Path, help="Source PNG to use for the charging roboport.")
    parser.add_argument(
        "--family",
        required=True,
        choices=sorted(FAMILY_NAMES),
        help="Target roboport family to update.",
    )
    parser.add_argument(
        "--black-threshold",
        type=int,
        default=12,
        help="Pixels at or below this RGB threshold are made transparent. Default: 12",
    )
    parser.add_argument(
        "--base-scale",
        type=float,
        default=0.82,
        help="Relative scale of the entity sprite inside the 228x277 roboport canvas.",
    )
    parser.add_argument(
        "--base-offset-y",
        type=float,
        default=14,
        help="Vertical offset for the entity sprite inside the 228x277 roboport canvas.",
    )
    parser.add_argument(
        "--icon-scale",
        type=float,
        default=0.78,
        help="Relative scale of the icon sprite inside the 64x64 icon canvas.",
    )
    parser.add_argument(
        "--icon-offset-y",
        type=float,
        default=1,
        help="Vertical offset for the icon sprite inside the 64x64 icon canvas.",
    )
    parser.add_argument(
        "--icon-crop",
        nargs=4,
        type=float,
        metavar=("LEFT", "TOP", "RIGHT", "BOTTOM"),
        help="Relative crop bounds applied only to the trimmed icon source, each between 0 and 1.",
    )
    parser.add_argument(
        "--delete-source",
        action="store_true",
        help="Delete the source image after installing it.",
    )
    args = parser.parse_args()

    icon_target, base_target, base_patch_target = ensure_dirs(args.family)
    source_image = load_image(args.source)
    source_image = remove_black_background(source_image, args.black_threshold)

    base_sprite = build_base_sprite(source_image, args.base_scale, args.base_offset_y)
    base_patch_sprite = build_base_patch()
    icon_crop = tuple(args.icon_crop) if args.icon_crop else None
    icon_sprite = build_icon(source_image, args.icon_scale, args.icon_offset_y, icon_crop)

    save_repeated(base_sprite, base_target, "roboport-base")
    save_repeated(base_patch_sprite, base_patch_target, "roboport-base-patch")
    save_repeated(icon_sprite, icon_target, "roboport-icon")

    if args.delete_source:
        ensure_deletable_source(args.source, args.family)
        args.source.unlink()


if __name__ == "__main__":
    main()