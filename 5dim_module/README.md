# 5Dim's Mod - Modules

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.9-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Modules expands the module system with 10 tiers of all module types, new pollution modules, merged modules that combine all effects, and upgraded beacons!

## Features

### ⚡ Speed Modules

| Tier | Speed Bonus | Energy Penalty |
|------|------------|----------------|
| T1 | +20% | +50% |
| T5 | +60% | +100% |
| T10 | +120% | +150% |

### 🏭 Productivity Modules

| Tier | Productivity | Speed Penalty | Energy Penalty |
|------|-------------|---------------|----------------|
| T1 | +4% | -5% | +40% |
| T5 | +12% | -10% | +80% |
| T10 | +20% | -15% | +120% |

### 💚 Efficiency Modules

| Tier | Energy Reduction | Max Effect |
|------|-----------------|------------|
| T1 | -30% | -80% |
| T5 | -50% | -80% |
| T10 | -80% | -80% |

### ⭐ Quality Modules (Requires Quality DLC)

| Tier | Quality Chance |
|------|---------------|
| T1 | +1% |
| T5 | +3% |
| T10 | +5% |

### 🌿 Pollution Modules (NEW!)

Reduce pollution output from machines:

| Tier | Pollution Reduction |
|------|-------------------|
| T1 | -30% |
| T5 | -60% |
| T10 | -90% |

### 🔮 Merged Modules (NEW!)

Combines Speed + Productivity + Efficiency in one module:

| Tier | Speed | Productivity | Efficiency |
|------|-------|-------------|------------|
| T1 | +10% | +2% | -15% |
| T5 | +30% | +6% | -25% |
| T10 | +60% | +10% | -40% |

### 📡 Beacons

| Tier | Module Slots | Transmission | Supply Area |
|------|-------------|--------------|-------------|
| T1 | 2 | 50% | 3x3 |
| T5 | 4 | 75% | 5x5 |
| T10 | 8 | 100% | 9x9 |

## Module Strategy

1. **Speed vs Productivity** - Speed for throughput, productivity for resource efficiency
2. **Efficiency first** - Reduces power costs dramatically
3. **Merged modules** - Great for machines with limited module slots
4. **Pollution modules** - Essential for peaceful coexistence with biters
5. **Beacon placement** - Higher tier beacons affect more machines

## Dependencies

- **Required**: `5dim_core >= 2.0.42`
- **Optional**: `quality` (for quality modules)
- **Optional**: `space-age` (for additional content)

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_module/
├── data.lua
├── info.json
├── prototypes/
│   ├── speed-modules/
│   ├── productivity-modules/
│   ├── efficiency-modules/
│   ├── quality-modules/
│   ├── pollution-modules/
│   ├── merged-modules/
│   └── beacons/
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
