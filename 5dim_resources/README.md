# 5Dim's Mod - Resources

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.6-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Resources expands smelting and ore processing with tiered furnaces, mashers (ore grinders), and a dust system for bonus yield!

## Features

### 🔥 Electric Furnaces

| Tier | Smelting Speed | Energy | Module Slots |
|------|---------------|--------|--------------|
| T1 | 2.0x | 180 kW | 2 |
| T5 | 5.0x | 450 kW | 4 |
| T10 | 10.0x | 900 kW | 6 |

### ⚙️ Mashers (Ore Grinders)

Convert ore into dust for bonus yield:

| Tier | Processing Speed | Energy Usage | Module Slots |
|------|-----------------|--------------|-------------|
| T1 | 1.0x | 100 kW | 2 |
| T2 | 1.5x | 200 kW | 2 |
| T3 | 2.0x | 300 kW | 3 |
| T4 | 2.5x | 400 kW | 3 |
| T5 | 3.0x | 500 kW | 4 |
| T6 | 3.5x | 600 kW | 4 |
| T7 | 4.0x | 700 kW | 5 |
| T8 | 4.5x | 800 kW | 5 |
| T9 | 5.0x | 900 kW | 6 |
| T10 | 6.0x | 1000 kW | 6 |

### 💎 Dust Processing System

**Get more plates from your ore!**

```
Ore → Masher → Dust → Furnace → Plates
```

| Process | Input | Output |
|---------|-------|--------|
| Standard | 1 ore | 1 plate |
| With Dust | 1 ore | 1.2 plates |

*20% bonus yield when processing through dust!*

### 🏭 Industrial Furnace Recipes

Special recipes for bulk processing:
- Batch smelting (process 100 at once)
- Mixed ore recipes
- Advanced alloy creation

## Resource Efficiency

### Comparison: Direct vs Dust Processing

| Method | Ore In | Plates Out | Efficiency |
|--------|--------|------------|------------|
| Direct Smelting | 100 | 100 | 100% |
| Dust Processing | 100 | 120 | 120% |

### Setup Cost vs Benefit

The dust system requires:
1. Mashers to process ore to dust
2. Extra power for the mashers
3. More belt/logistics infrastructure

**Worth it when**: You have limited ore patches or expensive mining setups.

## Tips

1. **Module priority** - Put productivity in furnaces, speed in mashers
2. **Dust batching** - Process ore to dust in bulk, then smelt as needed
3. **Electric furnaces** - Always better than stone/steel furnaces
4. **T10 furnaces** - One T10 replaces 5 T1 furnaces!

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_resources/
├── data.lua
├── info.json
├── prototypes/
│   ├── electric-furnaces/
│   ├── mashers/
│   ├── dust-items/
│   └── recipes/
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
