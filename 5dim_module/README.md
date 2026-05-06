# 5Dim's Mod - Modules

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.9-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Modules expands the module system with 10 tiers of all module types, pollution modules, merged modules and upgraded beacons. The current balance keeps the branch intentionally powerful, but merged modules now inherit the real tradeoffs of the component lines instead of cherry-picking only the upside.

## Features

### ⚡ Speed Modules

| Tier | Speed Bonus | Energy Penalty |
|------|------------|----------------|
| T1 | +12% | +12% |
| T5 | +60% | +60% |
| T10 | +120% | +120% |

### 🏭 Productivity Modules

| Tier | Productivity | Speed Penalty | Energy Penalty |
|------|-------------|---------------|----------------|
| T1 | +2.5% | -5% | +25% |
| T5 | +12.5% | -25% | +125% |
| T10 | +25% | -50% | +250% |

### 💚 Efficiency Modules

| Tier | Energy Reduction | Max Effect |
|------|-----------------|------------|
| T1 | -16% | -80% |
| T5 | -80% | -80% |
| T10 | -160% | -80% cap |

### ⭐ Quality Modules (Requires Quality DLC)

| Tier | Quality Chance |
|------|---------------|
| T1 | +8% |
| T5 | +40% |
| T10 | +80% |

### 🌿 Pollution Modules (NEW!)

Reduce pollution output from machines:

| Tier | Pollution Reduction |
|------|-------------------|
| T1 | -8% |
| T5 | -40% |
| T10 | -80% |

### 🔮 Merged Modules (NEW!)

Combines Speed + Productivity + Efficiency + Pollution in one module, but now keeps the combined penalties instead of inheriting only the best upside:

| Tier | Speed | Productivity | Consumption | Pollution |
|------|-------|-------------|-------------|-----------|
| T1 | +7% | +2.5% | +21% | -5% |
| T5 | +35% | +12.5% | +105% | -25% |
| T10 | +70% | +25% | +210% | -50% |

### 📡 Beacons

| Tier | Module Slots | Transmission | Supply Area |
|------|-------------|--------------|-------------|
| T1 | 2 | 150% | 3 |
| T5 | 5 | 160% | 4 |
| T10 | 8 | 170% | 6 |

## Module Strategy

1. **Speed vs Productivity** - Speed for throughput, productivity for resource efficiency
2. **Efficiency first** - Reduces power costs dramatically
3. **Merged modules** - Good for cramped builds, but they are no longer a free lunch on energy
4. **Pollution modules** - Essential for peaceful coexistence with biters
5. **Beacon placement** - Higher tier beacons affect more machines

## Balance Notes

- The main balance fix was on merged modules: they now combine both the upsides and the penalties of the component module lines.
- The rest of the module branch still uses large numbers and high leverage, so beacons and top-tier modules remain extremely impactful.
- README values now reflect the real prototype formulas instead of older placeholder progression.
- Cross-review with Equipment gives late speed and efficiency modules a real external sink through the higher power armor tiers instead of leaving that branch capped on vanilla module ingredients.

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
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── gen-beacon.lua
│   └── gen-modules.lua
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
