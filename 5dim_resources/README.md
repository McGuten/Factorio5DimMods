# 5Dim's Mod - Resources

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.6-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Resources expands smelting and ore processing with tiered furnaces, mashers and a dust system for bonus yield. The current balance keeps the throughput branch strong, but flattens the late furnace and masher spike so the top tiers stay within the same industrial frame as Mining and Energy.

## Features

### 🔥 Electric Furnaces

| Tier | Smelting Speed | Energy | Module Slots |
|------|---------------|--------|--------------|
| T1 | 2.0x | 180 kW | 2 |
| T5 | 9.5x | 1.86 MW | 4 |
| T10 | 17.0x | 4.46 MW | 6 |

### ⚙️ Mashers (Ore Grinders)

Convert ore into dust for bonus yield:

| Tier | Processing Speed | Energy Usage | Module Slots |
|------|-----------------|--------------|-------------|
| T1 | 2.0x | 360 kW | 2 |
| T5 | 9.5x | 3.73 MW | 4 |
| T10 | 17.0x | 8.92 MW | 6 |

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
3. **Electric furnaces** - High tiers are strong throughput tools, but their power cost rises fast enough that they need real grid support
4. **Dust lines pay off later** - Mashers are worth the extra logistics when ore pressure or mining footprint starts to matter
5. **Industrial furnace is separate** - The industrial furnace remains the dedicated bulk-processing endpoint rather than being replaced by raw tier inflation alone

## Balance Notes

- The main numerical pass was on electric furnaces and mashers: the late throughput curve was flattened while keeping the branch decisively stronger than vanilla.
- Tech pacing stayed largely intact because the main problem was stat runaway, not access timing.
- README values now reflect the real prototype formulas instead of old placeholder numbers.

## Cross-Module Notes

- With 5dim_nuclear installed, Resources already intersects the nuclear branch through uranium-processing: uranium dust and the dust-based uranium processing recipe are unlocked from that same technology gate.
- That means the centrifuge line in Nuclear already scales a real Resources-side throughput option without needing extra recipe inflation or forced prerequisites in this review.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- `5dim_nuclear` - Uranium dust processing plugs directly into the centrifuge branch through uranium-processing.
- All other 5Dim modules

## File Structure

```
5dim_resources/
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── gen-electric-furnace.lua
│   ├── gen-masher.lua
│   ├── industrial-furnace.lua
│   ├── industrial-recipes.lua
│   └── dust-*.lua / tech*.lua / resource-*.lua helpers
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
