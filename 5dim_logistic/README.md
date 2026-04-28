# 5Dim's Mod - Logistic

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Logistic enhances the logistics network with upgraded robots and roboports. Build a faster, more efficient automated logistics system!

## Features

### 🤖 Construction Robots

| Tier | Speed | Cargo | Energy |
|------|-------|-------|--------|
| T1 | 3 m/s | 1 | 1.5 kJ/m |
| T5 | 6 m/s | 2 | 1.2 kJ/m |
| T10 | 12 m/s | 4 | 0.8 kJ/m |

### 📦 Logistic Robots

| Tier | Speed | Cargo | Energy |
|------|-------|-------|--------|
| T1 | 3 m/s | 1 | 1.5 kJ/m |
| T5 | 6 m/s | 2 | 1.2 kJ/m |
| T10 | 12 m/s | 4 | 0.8 kJ/m |

### 🏗️ Roboports

| Tier | Robot Slots | Material Slots | Charging Slots | Range |
|------|-------------|---------------|----------------|-------|
| T1 | 10 | 7 | 4 | 50 |
| T5 | 30 | 15 | 8 | 75 |
| T10 | 80 | 30 | 16 | 100 |

## Tips

1. **Upgrade strategically** - Replace robots gradually to avoid logistics gaps
2. **Roboport spacing** - Higher tier roboports cover more area
3. **Mix tiers** - Use T10 robots with T1 roboports for cost efficiency
4. **Construction vs Logistic** - Prioritize construction robot upgrades for building projects

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Related Modules

- `5dim_storage` - Adds tiered logistic chests when both mods are installed

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_logistic/
├── data.lua
├── info.json
├── prototypes/
│   ├── construction-robots/
│   ├── logistic-robots/
│   └── roboports/
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
