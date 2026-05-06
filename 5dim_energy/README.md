# 5Dim's Mod - Energy

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.7-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Energy expands power generation and distribution options with 10 tiers of power-related buildings. The current balance keeps steam relevant as a transitional branch, normalizes the pacing of electric distribution, and restores internal coherence between solar panels and accumulators instead of letting one outscale the other.

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
| T5 | 199 kW | 3x3 |
| T10 | 893 kW | 3x3 |

#### Accumulators

| Tier | Capacity | I/O Rate |
|------|----------|----------|
| T1 | 5 MJ | 300 kW |
| T5 | 16.6 MJ | 996 kW |
| T10 | 74.4 MJ | 4.47 MW |

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

Ratio stays effectively constant because solar panel output and accumulator storage now use the same exponential scaling curve.

### Steam Ratios

Optimal boiler to engine ratios:

| Tier | Boilers : Engines |
|------|------------------|
| T1 | 1 : 2 |
| T5 | 1 : 2 |
| T10 | 1 : 2 |

## Balance Notes

- Steam was rebalanced to be less overtaxed in research for a dirty, transitional power branch.
- Medium poles, big poles and substations now enter chemical, production and utility science in a more coherent order.
- Solar panels and accumulators now scale on the same curve, so the branch keeps its planning ratio instead of drifting as tiers rise.
- Late solar is still powerful, but it no longer jumps ahead of storage at a faster rate than the rest of the branch can support.
- Second cross-review with Logistic did not require more numeric changes in poles or substations. The actual mismatch was on the Logistic side, where roboport buffering was too low to support its own charging thresholds.

## Cross-Module Notes

- With 5dim_nuclear installed, late boilers and steam engines now remain relevant even after the player moves into nuclear infrastructure, because higher nuclear heat exchangers and steam turbines consume tiered Energy hardware in their recipes.
- That crossover is conditional. Energy still works as a standalone conventional power branch, but inside the full stack it also becomes part of the build cost of the late nuclear chain instead of being discarded the moment reactors take over.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- `5dim_nuclear` - Recommended pair; the late nuclear thermal chain now consumes tiered boilers and steam engines from Energy.
- `5dim_logistic` - High-tier roboports become substantial burst loads, so stronger distribution coverage matters more in large bot networks
- All other 5Dim modules
- Most power-related mods

## File Structure

```
5dim_energy/
├── changelog.txt
├── data.lua
├── info.json
├── locale/
├── prototypes/
│   ├── gen-boiler.lua
│   ├── gen-steam-engine.lua
│   ├── gen-solar-panel.lua
│   ├── gen-accumulator.lua
│   ├── gen-medium-pole.lua
│   ├── gen-big-pole.lua
│   ├── gen-substation.lua
│   └── gen-lamp.lua
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
