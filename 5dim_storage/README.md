# 5Dim's Mod - Storage

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.1.0-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Storage expands storage capabilities for both fluids and items with multiple tiers of tanks and chests.

## Features

### 🛢️ Storage Tanks

Standard tanks with increased capacity:

| Tier | Capacity | Connections |
|------|----------|-------------|
| T1 | 25,000 | 2 sides |
| T5 | 125,000 | 2 sides |
| T10 | 500,000 | 2 sides |

### 🔄 Multi-Connection Storage Tanks

Tanks with fluid connections on all sides for easier piping:

| Tier | Capacity | Connections |
|------|----------|-------------|
| T1 | 25,000 | 4 sides |
| T5 | 125,000 | 4 sides |
| T10 | 500,000 | 4 sides |

### 📦 Steel Chests

| Tier | Inventory Size |
|------|---------------|
| T1 | 48 slots |
| T5 | 120 slots |
| T10 | 480 slots |

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
| T5 | 120 slots |
| T10 | 480 slots |

## Tips

1. **Multi-connection tanks** - Perfect for fluid bus systems
2. **Large steel chests** - Great for mall outputs or train unloading
3. **Logistic chest upgrades** - Reduce the number of chests needed
4. **Buffer chests** - Use high-tier buffers for frequently-requested items

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
├── data.lua
├── info.json
├── prototypes/
│   ├── storage-tanks/
│   ├── multi-tanks/
│   ├── steel-chests/
│   └── logistic-chests/
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
