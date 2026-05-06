# 5Dim's Mod - Automation

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Automation expands production capabilities with 10 tiers of core factory infrastructure while keeping most of the power growth weighted toward mid and late game.

## Features

### 🏭 10 Tiers of Crafting Machines

Each machine type has 10 progressive tiers with superlinear energy scaling. Early tiers stay closer to vanilla pacing, while the stronger jumps are pushed later into the tech tree.

#### Assembling Machines

| Tier | Crafting Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 0.5x | 75 kW | 0 |
| T2 | 0.75x | 137 kW | 2 |
| T3 | 1.25x | 296 kW | 4 |
| T4 | 1.5x | 389 kW | 4 |
| T5 | 1.8x | 512 kW | 5 |
| T6 | 2.2x | 692 kW | 5 |
| T7 | 2.8x | 993 kW | 6 |
| T8 | 3.5x | 1389 kW | 6 |
| T9 | 4.2x | 1825 kW | 7 |
| T10 | 5.0x | 2371 kW | 8 |

#### Chemical Plants

| Tier | Crafting Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 1.0x | 210 kW | 3 |
| T2 | 1.5x | 385 kW | 3 |
| T3 | 2.0x | 593 kW | 4 |
| T4 | 2.6x | 880 kW | 4 |
| T5 | 3.3x | 1258 kW | 5 |
| T6 | 4.1x | 1743 kW | 5 |
| T7 | 5.0x | 2347 kW | 6 |
| T8 | 6.0x | 3086 kW | 6 |
| T9 | 7.1x | 3972 kW | 7 |
| T10 | 8.3x | 5021 kW | 8 |

#### Oil Refineries

| Tier | Crafting Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 1.0x | 420 kW | 3 |
| T2 | 1.4x | 695 kW | 3 |
| T3 | 1.8x | 1014 kW | 3 |
| T4 | 2.2x | 1370 kW | 4 |
| T5 | 2.7x | 1863 kW | 4 |
| T6 | 3.3x | 2517 kW | 5 |
| T7 | 4.0x | 3360 kW | 5 |
| T8 | 4.8x | 4416 kW | 6 |
| T9 | 5.7x | 5715 kW | 6 |
| T10 | 6.7x | 7283 kW | 7 |

#### Laboratories

| Tier | Research Speed | Energy Usage | Module Slots |
|------|---------------|--------------|--------------|
| T1 | 1.0x | 60 kW | 2 |
| T2 | 1.15x | 73 kW | 2 |
| T3 | 1.3x | 88 kW | 3 |
| T4 | 1.5x | 110 kW | 3 |
| T5 | 1.75x | 138 kW | 4 |
| T6 | 2.05x | 176 kW | 4 |
| T7 | 2.4x | 223 kW | 5 |
| T8 | 2.8x | 281 kW | 5 |
| T9 | 3.25x | 351 kW | 6 |
| T10 | 3.75x | 435 kW | 7 |

### Balance Notes

- Assembling machine T2 and T3 preserve vanilla pacing and are not intended as silent buffs over base game.
- Chemical plants and oil refineries now ramp more gradually in early tiers so the oil phase stays relevant.
- Laboratories grow more conservatively because their value stacks with vanilla research-speed technologies.
- High tiers are intended to feel powerful, but they pay for it with much steeper power draw and heavier recipes.

### Cross-Module Notes

- When 5dim_module is installed, late assembling machines, chemical plants, labs and refineries stop leaning on vanilla module-3 ingredients and start consuming current 5Dim speed and productivity modules instead.
- That crossover is deliberate: Automation high tiers already pay their Energy tax through superlinear power draw, so the missing link was recipe-side pressure on the Module branch rather than even more raw energy inflation.
- The crossover is conditional. Automation still progresses cleanly on its own, but with 5dim_module enabled it becomes a real late sink for the transversal module economy.

### 📈 Progressive Unlocks

Technologies unlock new tiers as you research:
- Early game: vanilla baseline plus modest optional upgrades
- Mid game: stronger throughput gated by chemical and production science
- Late game: the largest jumps, with utility science and optional Space Age integration

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- `5dim_module` - Late machine tiers consume current 5Dim speed and productivity modules instead of stalling on vanilla module ingredients.
- `5dim_energy` - Automation already scales power aggressively, so stronger machine tiers become meaningful grid loads rather than free throughput.
- All 5Dim's mod modules
- Most production-focused mods
- Space Age DLC

## File Structure

```
5dim_automation/
├── changelog.txt
├── data.lua
├── info.json
├── locale/
├── prototypes/
│   ├── changes.lua
│   ├── gen-assembling-machine.lua
│   ├── gen-chemical-plant.lua
│   ├── gen-lab.lua
│   └── gen-oil-refinery.lua
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
