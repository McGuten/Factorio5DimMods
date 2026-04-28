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
| T2 | 2,500 | 700 kW | 5x6 (30) | 62-82% |
| T3 | 3,000 | 800 kW | 6x7 (42) | 64-84% |
| T4 | 3,500 | 900 kW | 6x7 (42) | 66-86% |
| T5 | 4,000 | 1,000 kW | 7x8 (56) | 68-88% |
| T6 | 4,500 | 1,100 kW | 7x8 (56) | 70-90% |
| T7 | 5,000 | 1,200 kW | 8x9 (72) | 72-90% |
| T8 | 5,500 | 1,300 kW | 8x9 (72) | 74-90% |
| T9 | 6,000 | 1,400 kW | 9x10 (90) | 76-90% |
| T10 | 6,500 | 1,500 kW | 9x10 (90) | 78-95% |

### 🕷️ Spidertrons T1-T10

Spider-legged vehicles with expanded capabilities:

| Tier | Health | Movement Energy | Inventory | Equipment Grid |
|------|--------|-----------------|-----------|----------------|
| T1 | 3,000 | 250 kW | 80 slots | 10x6 (60) |
| T2 | 3,750 | 300 kW | 100 slots | 11x6 (66) |
| T3 | 4,500 | 350 kW | 120 slots | 12x7 (84) |
| T4 | 5,250 | 400 kW | 140 slots | 13x7 (91) |
| T5 | 6,000 | 450 kW | 160 slots | 14x8 (112) |
| T6 | 6,750 | 500 kW | 180 slots | 15x8 (120) |
| T7 | 7,500 | 550 kW | 200 slots | 16x9 (144) |
| T8 | 8,250 | 600 kW | 220 slots | 17x9 (153) |
| T9 | 9,000 | 650 kW | 240 slots | 18x10 (180) |
| T10 | 9,750 | 700 kW | 260 slots | 18x10 (180) |

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
