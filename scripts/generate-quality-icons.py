#!/usr/bin/env python3
"""Generate 5Dim quality icons (recolour + pips, vanilla circle-cluster style).

Each quality icon is a cluster of N circles (black outline, tier-coloured fill)
rendered on a 64x64 transparent canvas, mirroring the vanilla quality look.
Colours come from the 5Dim tier palette (see 5dim_core/lib/tier-colors.lua).

Output: mods/5dim_quality/graphics/icons/quality-<id>.png
"""

from __future__ import annotations

import math
from pathlib import Path

from PIL import Image, ImageDraw


ROOT = Path(__file__).resolve().parents[1]
OUTPUT_DIR = ROOT / "5dim_quality" / "graphics" / "icons"

CANVAS = 64
SUPERSAMPLE = 4  # render larger then downscale for smooth edges
OUTLINE = (0, 0, 0, 255)

# 5Dim tier palette (tier-colors.lua), 0-255 RGB.
TIER_COLORS = {
    1: (255, 255, 0),    # yellow
    2: (255, 0, 0),      # red
    3: (0, 255, 255),    # cyan
    4: (255, 102, 255),  # pink
    5: (0, 255, 0),      # green
    6: (153, 102, 51),   # brown
    7: (128, 51, 153),   # purple
    8: (255, 255, 255),  # white
    9: (255, 128, 0),    # orange
}

# Dedicated colour for the Eternal star (top of the ladder).
STAR_COLOR = (255, 165, 0)  # orange

# Each quality: output id, tier colour and pip count (number of circles).
# Pip count follows the ladder position (1..9); the final quality (Eternal)
# is rendered as an orange star instead of a 10-circle cluster.
QUALITIES = [
    {"name": "normal", "tier": 1, "pips": 1},
    {"name": "uncommon", "tier": 2, "pips": 2},
    {"name": "rare", "tier": 3, "pips": 3},
    {"name": "epic", "tier": 4, "pips": 4},
    {"name": "legendary", "tier": 5, "pips": 5},
    {"name": "5d-mythic", "tier": 6, "pips": 6},
    {"name": "5d-ascended", "tier": 7, "pips": 7},
    {"name": "5d-divine", "tier": 8, "pips": 8},
    {"name": "5d-cosmic", "tier": 9, "pips": 9},
    {"name": "5d-eternal", "star": True},
]

# Normalised circle-centre layouts (x, y in 0..1) per pip count, plus the
# circle radius (also normalised). Hand-tuned for balanced, legible clusters.
LAYOUTS = {
    1: (0.34, [(0.50, 0.50)]),
    2: (0.30, [(0.50, 0.30), (0.50, 0.70)]),
    3: (0.27, [(0.50, 0.27), (0.30, 0.66), (0.70, 0.66)]),
    4: (0.25, [(0.31, 0.31), (0.69, 0.31), (0.31, 0.69), (0.69, 0.69)]),
    5: (0.22, [(0.30, 0.30), (0.70, 0.30), (0.50, 0.50), (0.30, 0.70), (0.70, 0.70)]),
    6: (0.21, [(0.31, 0.27), (0.69, 0.27), (0.31, 0.50), (0.69, 0.50), (0.31, 0.73), (0.69, 0.73)]),
    7: (0.19, [(0.50, 0.22), (0.27, 0.36), (0.73, 0.36), (0.50, 0.50), (0.27, 0.64), (0.73, 0.64), (0.50, 0.78)]),
    8: (0.165, [(0.28, 0.22), (0.55, 0.22), (0.28, 0.42), (0.55, 0.42), (0.45, 0.58), (0.72, 0.58), (0.45, 0.78), (0.72, 0.78)]),
    9: (0.155, [(0.27, 0.27), (0.50, 0.27), (0.73, 0.27), (0.27, 0.50), (0.50, 0.50), (0.73, 0.50), (0.27, 0.73), (0.50, 0.73), (0.73, 0.73)]),
}


def draw_icon(tier: int, pips: int) -> Image.Image:
    size = CANVAS * SUPERSAMPLE
    image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)

    radius_norm, centres = LAYOUTS[pips]
    radius = radius_norm * size
    outline_width = max(2, round(0.045 * size / SUPERSAMPLE) * SUPERSAMPLE)
    fill = TIER_COLORS[tier] + (255,)

    for cx_norm, cy_norm in centres:
        cx = cx_norm * size
        cy = cy_norm * size
        bbox = (cx - radius, cy - radius, cx + radius, cy + radius)
        draw.ellipse(bbox, fill=fill, outline=OUTLINE, width=outline_width)

    return image.resize((CANVAS, CANVAS), Image.LANCZOS)


def draw_star(color: tuple[int, int, int]) -> Image.Image:
    size = CANVAS * SUPERSAMPLE
    image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)

    centre = size / 2
    outer_r = 0.46 * size
    inner_r = 0.20 * size
    points = []
    for i in range(10):
        radius = outer_r if i % 2 == 0 else inner_r
        angle = -math.pi / 2 + i * math.pi / 5
        points.append((centre + radius * math.cos(angle), centre + radius * math.sin(angle)))

    outline_width = max(2, round(0.05 * size / SUPERSAMPLE) * SUPERSAMPLE)
    draw.polygon(points, fill=color + (255,))
    draw.line(points + [points[0]], fill=OUTLINE, width=outline_width, joint="curve")

    return image.resize((CANVAS, CANVAS), Image.LANCZOS)


def main() -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    for quality in QUALITIES:
        if quality.get("star"):
            icon = draw_star(STAR_COLOR)
        else:
            icon = draw_icon(quality["tier"], quality["pips"])
        target = OUTPUT_DIR / f"quality-{quality['name']}.png"
        icon.save(target)
        print(f"wrote {target.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
