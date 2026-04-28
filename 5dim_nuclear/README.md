# 5Dim's Mod - Nuclear

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.4-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Nuclear expands nuclear power generation with 10 tiers of all nuclear components. Build massive, efficient nuclear power plants!

## Features

### ☢️ Nuclear Reactors

| Tier | Power Output | Neighbor Bonus |
|------|-------------|----------------|
| T1 | 40 MW | 100% |
| T5 | 120 MW | 100% |
| T10 | 400 MW | 100% |

*Neighbor bonus applies when reactors are placed adjacent!*

### 🔥 Heat Exchangers

| Tier | Energy Consumption | Steam Output |
|------|-------------------|--------------|
| T1 | 10 MW | 103/s |
| T5 | 30 MW | 309/s |
| T10 | 100 MW | 1030/s |

### 🔴 Heat Pipes

| Tier | Heat Capacity | Conductivity |
|------|--------------|--------------|
| T1 | 1 MJ | 1 kW/m |
| T5 | 3 MJ | 3 kW/m |
| T10 | 10 MJ | 10 kW/m |

### 💨 Steam Turbines

| Tier | Power Output | Consumption |
|------|-------------|-------------|
| T1 | 5.82 MW | 60/s |
| T5 | 17.5 MW | 120/s |
| T10 | 58.2 MW | 180/s |

### ⚗️ Centrifuges

| Tier | Crafting Speed | Module Slots |
|------|---------------|--------------|
| T1 | 1.0x | 2 |
| T5 | 2.5x | 4 |
| T10 | 5.0x | 6 |

## Nuclear Power Plant Ratios

### Basic 2x2 Reactor Setup

For a standard 2x2 reactor configuration:

| Tier | Reactors | Heat Exchangers | Turbines |
|------|----------|-----------------|----------|
| T1 | 4 | 48 | 83 |
| T5 | 4 | 48 | 83 |
| T10 | 4 | 48 | 83 |

*Higher tiers produce more power with the same ratios!*

### Fuel Efficiency

| Setup | Power Output | Fuel Consumption |
|-------|-------------|------------------|
| 2x2 T1 | 480 MW | 1 cell/200s |
| 2x2 T5 | 1.44 GW | 1 cell/200s |
| 2x2 T10 | 4.8 GW | 1 cell/200s |

## Tips

1. **Neighbor bonus** - Always place reactors adjacent for 100% bonus
2. **Heat pipes** - Upgrade to reduce heat loss over distance
3. **Turbines** - Higher tiers handle more steam per unit
4. **Centrifuges** - Essential for Kovarex enrichment process

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Related Modules

- `5dim_energy` - For steam engines and conventional power

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_nuclear/
├── data.lua
├── info.json
├── prototypes/
│   ├── nuclear-reactors/
│   ├── heat-exchangers/
│   ├── heat-pipes/
│   ├── steam-turbines/
│   └── centrifuges/
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
