# 5Dim's Mod - Storage

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.1.0-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Storage expands storage capabilities for both fluids and items with multiple tiers of tanks and chests. The current balance keeps storage upgrades useful without taxing passive infrastructure like active production machines.

## Features

### 🛢️ Storage Tanks

Standard tanks with increased capacity:

| Tier | Capacity | Connections |
|------|----------|-------------|
| T1 | 25,000 | 2 sides |
| T5 | 125,000 | 2 sides |
| T10 | 250,000 | 2 sides |

### 🔄 Multi-Connection Storage Tanks

Tanks with fluid connections on all sides for easier piping:

| Tier | Capacity | Connections |
|------|----------|-------------|
| T1 | 25,000 | 4 sides |
| T5 | 125,000 | 4 sides |
| T10 | 250,000 | 4 sides |

### 📦 Steel Chests

| Tier | Inventory Size |
|------|---------------|
| T1 | 48 slots |
| T5 | 144 slots |
| T10 | 264 slots |

### 📦 Logistic Chests (Requires 5dim_logistic)

When `5dim_logistic` is installed, all logistic chest types get tiers:

| Type | Color | Tier Range |
|------|-------|------------|
| **Passive Provider** | Red | T1-T10 |
| **Active Provider** | Purple | T1-T10 |
| **Storage** | Yellow | T1-T10 |
| **Buffer** | Green | T1-T10 |
| **Requester** | Blue | T1-T10 |

| Tier | Inventory Size |
|------|---------------|
| T1 | 48 slots |
| T5 | 144 slots |
| T10 | 264 slots |

## Tips

1. **Multi-connection tanks** - Perfect for fluid bus systems
2. **Large steel chests** - Great for mall outputs, train unloading and passive bulk buffers
3. **Logistic chest upgrades** - Tiered logistic chests stay valuable, but each family is researched separately so prioritize the ones your network actually uses
4. **Buffer chests** - Use high-tier buffers for frequently-requested items
5. **Storage tanks stay simple** - Late tiers are still passive containers, so their recipes now favor structural and electronic parts instead of production modules

## Balance Notes

- Research pacing was eased across tanks and chests so passive storage no longer pays an out-of-line tax versus the rest of the logistics stack.
- Multi-connection tanks remain an optional routing upgrade, not a separate endgame-only branch.
- Logistic chest technologies remain split by chest family, so their per-tech counts were reduced to keep the full network progression affordable.
- Cross-review with Logistic corrected the basic network gating: passive provider and storage chest tier upgrades now start from logistic-robotics, while active, buffer and requester upgrades remain tied to logistic-system.
- Cross-review with Transport did not require more numeric changes: chest capacities and tank capacities already sit in a workable range for the rebalanced inserter and pump curves.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`
- **Optional**: `5dim_logistic` (for tiered logistic chests)

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_storage/
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── changes.lua
│   ├── gen-logistic-chest.lua
│   ├── gen-steel-chest.lua
│   ├── gen-storage-tank-multi.lua
│   └── gen-storage-tank.lua
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
