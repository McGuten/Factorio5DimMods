# 5Dim's Mod - Automation

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Automation expands production capabilities with 10 tiers of all major crafting machines, allowing you to scale your factory's throughput as you progress through the game.

## Features

### 🏭 10 Tiers of Crafting Machines

Each machine type has 10 progressive tiers with increasing stats:

#### Assembling Machines

| Tier | Crafting Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 0.5x | 75 kW | 0 |
| T2 | 0.75x | 150 kW | 2 |
| T3 | 1.0x | 225 kW | 2 |
| T4 | 1.5x | 300 kW | 3 |
| T5 | 2.0x | 375 kW | 3 |
| T6 | 2.5x | 450 kW | 4 |
| T7 | 3.0x | 525 kW | 4 |
| T8 | 4.0x | 600 kW | 5 |
| T9 | 5.0x | 675 kW | 5 |
| T10 | 6.0x | 750 kW | 6 |

#### Chemical Plants

| Tier | Crafting Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 1.0x | 210 kW | 2 |
| T2 | 1.5x | 315 kW | 2 |
| T3 | 2.0x | 420 kW | 3 |
| T4 | 2.5x | 525 kW | 3 |
| T5 | 3.0x | 630 kW | 4 |
| T6 | 3.5x | 735 kW | 4 |
| T7 | 4.0x | 840 kW | 5 |
| T8 | 4.5x | 945 kW | 5 |
| T9 | 5.0x | 1050 kW | 6 |
| T10 | 6.0x | 1260 kW | 6 |

#### Oil Refineries

| Tier | Crafting Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 1.0x | 420 kW | 3 |
| T2 | 1.5x | 630 kW | 3 |
| T3 | 2.0x | 840 kW | 4 |
| T4 | 2.5x | 1050 kW | 4 |
| T5 | 3.0x | 1260 kW | 4 |
| T6 | 3.5x | 1470 kW | 5 |
| T7 | 4.0x | 1680 kW | 5 |
| T8 | 4.5x | 1890 kW | 5 |
| T9 | 5.0x | 2100 kW | 6 |
| T10 | 6.0x | 2520 kW | 6 |

#### Laboratories

| Tier | Research Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 1.0x | 60 kW | 2 |
| T2 | 1.5x | 90 kW | 2 |
| T3 | 2.0x | 120 kW | 3 |
| T4 | 2.5x | 150 kW | 3 |
| T5 | 3.0x | 180 kW | 4 |
| T6 | 3.5x | 210 kW | 4 |
| T7 | 4.0x | 240 kW | 5 |
| T8 | 4.5x | 270 kW | 5 |
| T9 | 5.0x | 300 kW | 6 |
| T10 | 6.0x | 360 kW | 6 |

### 📈 Progressive Unlocks

Technologies unlock new tiers as you research:
- Early game: T1-T3 (basic automation)
- Mid game: T4-T6 (advanced materials)
- Late game: T7-T10 (space science)

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- All 5Dim's mod modules
- Most production-focused mods
- Space Age DLC

## File Structure

```
5dim_automation/
├── data.lua
├── info.json
├── prototypes/
│   ├── assembling-machines/
│   ├── chemical-plants/
│   ├── oil-refineries/
│   └── laboratories/
└── graphics/
```

## Contributing

Issues and suggestions welcome at:
- **GitHub**: https://github.com/McGuten/Factorio5DimMods/issues
- **Mod Portal**: https://mods.factorio.com/user/McGuten

## License

See [LICENSE](../LICENSE) for details.

---

*Part of the [5Dim's Mod](https://mods.factorio.com/user/McGuten) collection for Factorio*
