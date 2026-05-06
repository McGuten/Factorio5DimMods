# 5Dim's Mod - Transport

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.22-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

> ⚠️ **Requires**: Bob's Inserters mod

## Overview

5Dim's Transport expands item transportation with faster belts, longer underground belts, more capable inserters and stronger pumps. The current balance keeps base logistics throughput high, but no longer lets late inserter tiers stay almost free compared with the rest of the transport stack.

## Features

### 🛤️ Transport Belts

| Tier | Total Throughput | Per Lane |
|------|------------------|----------|
| T1 | 15 items/s | 7.5 items/s |
| T5 | 75 items/s | 37.5 items/s |
| T10 | 150 items/s | 75 items/s |

### 🕳️ Underground Belts

Three range variants for each tier:

| Variant | Range |
|---------|-------|
| **Standard** | 4-10 tiles |
| **Extended (x30)** | 30 tiles |
| **Long (x50)** | 50 tiles |

### 🔀 Splitters

| Tier | Speed | Special |
|------|-------|---------|
| T1-T10 | Matches belt | Filter capability |

### 📥 Loaders

10 tiers of belt loaders:

| Tier | Throughput |
|------|------------|
| T1-T10 | Matches the paired belt tier |

### 🤖 Inserters (Requires Bob's Inserters)

10 tiers of each inserter type:

| Type | Description |
|------|-------------|
| **Standard** | Basic item movement |
| **Filter** | Filtered item selection |
| **Bulk** | High-throughput inserter line |
| **Stack / Stack Filter** | Space Age stack tier line |

| Tier | Extension Speed | Rotation Speed | Movement Energy | Drain |
|------|-----------------|----------------|-----------------|-------|
| T1 | 0.03 | 0.014 | 5 kJ | 0.4 kW |
| T5 | 0.11 | 0.094 | 31 kJ | 0.48 kW |
| T10 | 0.21 | 0.194 | 306 kJ | 0.58 kW |

Bulk and stack inserters share the same movement profile, but use 4x movement and rotation energy.

### 💧 Pumps

| Tier | Pumping Speed | Module Slots | Energy |
|------|---------------|--------------|--------|
| T1 | 200 | 2 | 29 kW |
| T5 | 400 | 4 | 82 kW |
| T10 | 1100 | 7 | 374 kW |

### 🔧 Underground Pipes

Extended underground pipe variants:

| Variant | Range |
|---------|-------|
| **Standard** | 10 tiles |
| **Extended (x30)** | 30 tiles |
| **Long (x50)** | 50 tiles |

## Belt Throughput Reference

| Lanes | T1 | T5 | T10 |
|-------|-----|-----|------|
| 1 lane | 7.5/s | 37.5/s | 75/s |
| 2 lanes | 15/s | 75/s | 150/s |

## Tips

1. **Match belt tiers** - Use same tier underground and splitters
2. **Extended underground** - Save resources on long runs
3. **Stack inserters** - Essential for high-throughput builds
4. **Loader efficiency** - Loaders fill belts perfectly without gaps
5. **Late inserters now cost real materials** - High-tier inserter upgrades are still strong, but they now belong to the same economy as the rest of the transport branch

## Balance Notes

- The main balance pass was on inserter recipes: late standard, bulk and stack inserters were too cheap relative to the throughput they unlocked.
- Belt, splitter and loader progression remains the baseline throughput ladder for the module.
- Pumps were audited as the fluid-side support line and kept on their current curve.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`
- **Required**: `bobinserters >= 1.3.2` (Bob's Inserters)
- **Optional**: `space-age >= 2.0.0`

## Installation

1. Install `5dim_core` first
2. Install `bobinserters` (Bob's Inserters)
3. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
4. Enable in the mod menu

## File Structure

```
5dim_transport/
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── gen-inserter.lua
│   ├── gen-pump.lua
│   ├── gen-stack-inserter.lua
│   ├── gen-transport-belt.lua
│   ├── pipe-ground-1-30.lua
│   ├── pipe-ground-1-50.lua
│   └── tech.lua
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
