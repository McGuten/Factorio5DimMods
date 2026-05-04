# 5Dim's Mod - Vehicles

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.0-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Vehicles expands your combat vehicle options with multiple tiers of tanks and spidertrons. Each tier brings improved stats, better armor, and larger equipment grids for the ultimate combat experience.

## Features

### 🚂 Tanks T1-T10

Heavy armored combat vehicles with progressive improvements:

| Tier | Health | Consumption | Equipment Grid | Resistances |
|------|--------|-------------|----------------|-------------|
| T1 | 2,000 | 600 kW | 5x6 (30) | 60-80% |
| T2 | 3,000 | 700 kW | 6x9 (54) | 62-82% |
| T3 | 4,200 | 800 kW | 7x9 (63) | 64-84% |
| T4 | 5,600 | 900 kW | 7x10 (70) | 66-86% |
| T5 | 7,500 | 1,000 kW | 8x10 (80) | 68-88% |
| T6 | 9,800 | 1,100 kW | 8x11 (88) | 70-90% |
| T7 | 12,400 | 1,200 kW | 9x11 (99) | 72-90% |
| T8 | 15,200 | 1,300 kW | 9x12 (108) | 74-90% |
| T9 | 18,000 | 1,400 kW | 10x12 (120) | 76-90% |
| T10 | 20,000 | 1,500 kW | 10x13 (130) | 87-99% |

### 🕷️ Spidertrons T1-T10

Spider-legged vehicles with expanded capabilities:

| Tier | Health | Movement Energy | Inventory | Equipment Grid |
|------|--------|-----------------|-----------|----------------|
| T1 | 3,000 | 250 kW | 80 slots | 10x6 (60) |
| T2 | 4,500 | 300 kW | 100 slots | 10x7 (70) |
| T3 | 6,300 | 350 kW | 120 slots | 11x7 (77) |
| T4 | 8,400 | 400 kW | 140 slots | 11x8 (88) |
| T5 | 11,100 | 450 kW | 160 slots | 12x8 (96) |
| T6 | 14,400 | 500 kW | 180 slots | 12x9 (108) |
| T7 | 18,300 | 550 kW | 200 slots | 13x9 (117) |
| T8 | 22,500 | 600 kW | 220 slots | 13x10 (130) |
| T9 | 26,700 | 650 kW | 240 slots | 14x10 (140) |
| T10 | 30,000 | 700 kW | 260 slots | 14x11 (154) |

Spidertron resistances now explicitly cover acid, electric, and poison as well, to better match the special damage mix from 5dim_enemies.

## Progression

### Tank Progression
- **T1-T3**: Early-mid game, requires military science
- **T4-T5**: Mid game, requires production science
- **T6-T7**: Late game, requires utility science
- **T8-T10**: End game, requires space science

### Spidertron Progression
- **T1**: Requires spidertron research (vanilla)
- **T2-T3**: Requires utility science
- **T4-T10**: Requires space science

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works great with:
- `5dim_equipment` - More equipment for your vehicle grids!
- `5dim_battlefield` - Defend your vehicles with turrets
- All other 5Dim modules

## File Structure

```
5dim_vehicles/
├── data.lua
├── info.json
├── changelog.txt
├── prototypes/
│   ├── gen-tank.lua
│   └── gen-spidertron.lua
└── locale/
    └── en/
        └── locale.cfg
```

## Contributing

Issues and suggestions welcome at:
- **GitHub**: https://github.com/McGuten/Factorio5DimMods/issues
- **Mod Portal**: https://mods.factorio.com/user/McGuten

## License

See [LICENSE](../LICENSE) for details.

---

*Part of the [5Dim's Mod](https://mods.factorio.com/user/McGuten) collection for Factorio*
