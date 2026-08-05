#!/usr/bin/env python3
from __future__ import annotations

import colorsys
from pathlib import Path

from PIL import Image, ImageDraw, ImageEnhance


ROOT = Path(__file__).resolve().parents[1]
ICON_SOURCE = ROOT / "5dim_logistic" / "graphics" / "icons" / "roboport"
BASE_SOURCE = ROOT / "5dim_logistic" / "graphics" / "entities" / "roboport" / "roboport-base"
PATCH_SOURCE = ROOT / "5dim_logistic" / "graphics" / "entities" / "roboport" / "roboport-base-patch"


FAMILIES = {
    "charging": {
        "accent": (255, 190, 40),
        "secondary": (255, 110, 30),
        "body": (120, 112, 100),
        "overlay": (255, 171, 50, 120),
        "symbol": "charge",
        "icon_boost": 1.05,
    },
    "logistic": {
        "accent": (74, 188, 255),
        "secondary": (46, 116, 255),
        "body": (96, 108, 124),
        "overlay": (70, 205, 255, 110),
        "symbol": "network",
        "icon_boost": 1.04,
    },
    "construction": {
        "accent": (255, 132, 42),
        "secondary": (205, 62, 26),
        "body": (126, 103, 82),
        "overlay": (255, 122, 48, 118),
        "symbol": "hazard",
        "icon_boost": 1.03,
    },
    "compact": {
        "accent": (214, 214, 214),
        "secondary": (122, 166, 214),
        "body": (108, 108, 112),
        "overlay": (210, 220, 235, 105),
        "symbol": "frame",
        "icon_boost": 1.02,
    },
}


def mix(channel_a: int, channel_b: int, factor: float) -> int:
    return max(0, min(255, round(channel_a * (1 - factor) + channel_b * factor)))


def tint_towards(rgb: tuple[int, int, int], target: tuple[int, int, int], factor: float) -> tuple[int, int, int]:
    return tuple(mix(source, destination, factor) for source, destination in zip(rgb, target))


def recolor(image: Image.Image, family: dict, is_icon: bool) -> Image.Image:
    rgba = image.convert("RGBA")
    pixels = rgba.load()
    width, height = rgba.size

    for y in range(height):
        for x in range(width):
            red, green, blue, alpha = pixels[x, y]
            if alpha == 0:
                continue

            hue, saturation, value = colorsys.rgb_to_hsv(red / 255, green / 255, blue / 255)
            new_rgb = (red, green, blue)

            warm_accent = 0.08 <= hue <= 0.19 and saturation >= 0.24 and value >= 0.18
            copperish = 0.04 <= hue <= 0.10 and saturation >= 0.20 and value >= 0.12
            neutral_body = saturation <= 0.14 and 0.12 <= value <= 0.60

            if warm_accent:
                amount = 0.58 if is_icon else 0.48
                new_rgb = tint_towards((red, green, blue), family["accent"], amount)
            elif copperish:
                amount = 0.52 if is_icon else 0.40
                new_rgb = tint_towards((red, green, blue), family["secondary"], amount)
            elif neutral_body:
                amount = 0.12 if is_icon else 0.05
                new_rgb = tint_towards((red, green, blue), family["body"], amount)

            pixels[x, y] = (*new_rgb, alpha)

    return rgba


def draw_charge_symbol(draw: ImageDraw.ImageDraw, width: int, height: int, color: tuple[int, int, int, int], icon: bool) -> None:
    if icon:
        points = [
            (width * 0.56, height * 0.12),
            (width * 0.46, height * 0.39),
            (width * 0.59, height * 0.39),
            (width * 0.40, height * 0.84),
            (width * 0.47, height * 0.53),
            (width * 0.34, height * 0.53),
        ]
    else:
        points = [
            (width * 0.60, height * 0.12),
            (width * 0.52, height * 0.27),
            (width * 0.59, height * 0.27),
            (width * 0.49, height * 0.50),
            (width * 0.53, height * 0.34),
            (width * 0.46, height * 0.34),
        ]
    draw.polygon(points, fill=color)


def draw_network_symbol(draw: ImageDraw.ImageDraw, width: int, height: int, color: tuple[int, int, int, int], icon: bool) -> None:
    if icon:
        points = [(0.30, 0.72), (0.54, 0.46), (0.74, 0.72)]
        radius = width * 0.08
        line_width = max(2, round(width * 0.08))
    else:
        points = [(0.38, 0.35), (0.52, 0.24), (0.65, 0.35)]
        radius = width * 0.030
        line_width = max(2, round(width * 0.012))

    scaled = [(width * x, height * y) for x, y in points]
    draw.line([scaled[0], scaled[1], scaled[2]], fill=color, width=line_width, joint="curve")
    for cx, cy in scaled:
        draw.ellipse((cx - radius, cy - radius, cx + radius, cy + radius), fill=color)


def draw_hazard_symbol(draw: ImageDraw.ImageDraw, width: int, height: int, color: tuple[int, int, int, int], icon: bool) -> None:
    if icon:
        top = height * 0.56
        band_height = height * 0.18
        stripe_width = width * 0.12
    else:
        top = height * 0.56
        band_height = height * 0.08
        stripe_width = width * 0.06

    bottom = top + band_height
    position = -stripe_width * 2
    while position < width + stripe_width * 2:
        draw.polygon(
            [
                (position, bottom),
                (position + stripe_width, bottom),
                (position + stripe_width * 2.2, top),
                (position + stripe_width * 1.2, top),
            ],
            fill=color,
        )
        position += stripe_width * 2


def draw_frame_symbol(draw: ImageDraw.ImageDraw, width: int, height: int, color: tuple[int, int, int, int], icon: bool) -> None:
    if icon:
        margin_x = width * 0.22
        margin_y = height * 0.22
        line_width = max(2, round(width * 0.09))
    else:
        margin_x = width * 0.38
        margin_y = height * 0.16
        line_width = max(2, round(width * 0.012))

    draw.rounded_rectangle(
        (margin_x, margin_y, width - margin_x, height - margin_y),
        radius=min(width, height) * 0.06,
        outline=color,
        width=line_width,
    )


def add_overlay(image: Image.Image, family: dict, is_icon: bool) -> Image.Image:
    output = image.copy()
    overlay = Image.new("RGBA", output.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(overlay)
    width, height = output.size
    overlay_color = family["overlay"]

    symbol = family["symbol"]
    if symbol == "charge":
        draw_charge_symbol(draw, width, height, overlay_color, is_icon)
    elif symbol == "network":
        draw_network_symbol(draw, width, height, overlay_color, is_icon)
    elif symbol == "hazard":
        draw_hazard_symbol(draw, width, height, overlay_color, is_icon)
    elif symbol == "frame":
        draw_frame_symbol(draw, width, height, overlay_color, is_icon)

    if not is_icon:
        ring_bounds = (
            width * 0.34,
            height * 0.06,
            width * 0.68,
            height * 0.20,
        )
        draw.ellipse(ring_bounds, outline=overlay_color, width=max(2, round(width * 0.015)))

    return Image.alpha_composite(output, overlay)


def finish_image(image: Image.Image, family: dict, is_icon: bool) -> Image.Image:
    if is_icon:
        image = ImageEnhance.Color(image).enhance(family["icon_boost"])
        image = ImageEnhance.Contrast(image).enhance(1.08)
    else:
        image = ImageEnhance.Contrast(image).enhance(1.02)

    return image


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def process_family_asset(source_dir: Path, target_dir: Path, family: dict, prefix: str) -> None:
    ensure_dir(target_dir)

    for tier in range(1, 11):
        filename = f"{prefix}-{tier:02d}.png"
        source_path = source_dir / filename
        target_path = target_dir / filename
        image = Image.open(source_path).convert("RGBA")
        recolored = recolor(image, family, source_dir == ICON_SOURCE)
        with_overlay = add_overlay(recolored, family, source_dir == ICON_SOURCE)
        finished = finish_image(with_overlay, family, source_dir == ICON_SOURCE)
        finished.save(target_path)


def main() -> None:
    for family_name, family in FAMILIES.items():
        process_family_asset(
            ICON_SOURCE,
            ROOT / "5dim_logistic" / "graphics" / "icons" / f"roboport-{family_name}",
            family,
            "roboport-icon",
        )
        process_family_asset(
            BASE_SOURCE,
            ROOT / "5dim_logistic" / "graphics" / "entities" / "roboport" / f"roboport-base-{family_name}",
            family,
            "roboport-base",
        )
        process_family_asset(
            PATCH_SOURCE,
            ROOT / "5dim_logistic" / "graphics" / "entities" / "roboport" / f"roboport-base-patch-{family_name}",
            family,
            "roboport-base-patch",
        )


if __name__ == "__main__":
    main()