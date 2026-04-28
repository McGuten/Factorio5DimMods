# 5Dim's Mod - Energy

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.7-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Energy expands power generation and distribution options with 10 tiers of all power-related buildings. Scale your power grid from early steam engines to massive late-game solar farms.

## Features

### 🔥 Steam Power

#### Boilers

| Tier | Energy Output | Efficiency |
|------|--------------|------------|
| T1 | 1.8 MW | 50% |
| T5 | 5.4 MW | 75% |
| T10 | 18 MW | 90% |

#### Steam Engines

| Tier | Power Output | Fluid Usage |
|------|-------------|-------------|
| T1 | 900 kW | 30/s |
| T5 | 2.7 MW | 60/s |
| T10 | 9 MW | 90/s |

### ☀️ Solar Power

#### Solar Panels

| Tier | Power Output | Size |
|------|-------------|------|
| T1 | 60 kW | 3x3 |
| T5 | 180 kW | 3x3 |
| T10 | 600 kW | 3x3 |

#### Accumulators

| Tier | Capacity | I/O Rate |
|------|----------|----------|
| T1 | 5 MJ | 300 kW |
| T5 | 15 MJ | 900 kW |
| T10 | 50 MJ | 3 MW |

### ⚡ Power Distribution

#### Medium Electric Poles

| Tier | Wire Reach | Supply Area |
|------|-----------|-------------|
| T1 | 9 tiles | 7x7 |
| T5 | 13 tiles | 11x11 |
| T10 | 18 tiles | 16x16 |

#### Big Electric Poles

| Tier | Wire Reach | Supply Area |
|------|-----------|-------------|
| T1 | 30 tiles | 4x4 |
| T5 | 45 tiles | 6x6 |
| T10 | 64 tiles | 8x8 |

#### Substations

| Tier | Wire Reach | Supply Area |
|------|-----------|-------------|
| T1 | 18 tiles | 18x18 |
| T5 | 27 tiles | 27x27 |
| T10 | 36 tiles | 36x36 |

### 💡 Lamps

| Tier | Light Radius | Energy |
|------|-------------|--------|
| T1 | Small | 5 kW |
| T5 | Medium | 8 kW |
| T10 | Large | 12 kW |

## Power Planning

### Solar Ratios

For continuous power with accumulators:

| Tier | Panels : Accumulators |
|------|----------------------|
| T1 | 21 : 25 |
| T5 | 21 : 25 |
| T10 | 21 : 25 |

*Ratio stays the same, but higher tiers produce more power per tile.*

### Steam Ratios

Optimal boiler to engine ratios:

| Tier | Boilers : Engines |
|------|------------------|
| T1 | 1 : 2 |
| T5 | 1 : 2 |
| T10 | 1 : 2 |

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- `5dim_nuclear` - For nuclear power options
- All other 5Dim modules
- Most power-related mods

## File Structure

```
5dim_energy/
├── data.lua
├── info.json
├── prototypes/
│   ├── boilers/
│   ├── steam-engines/
│   ├── solar-panels/
│   ├── accumulators/
│   ├── electric-poles/
│   ├── substations/
│   └── lamps/
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
