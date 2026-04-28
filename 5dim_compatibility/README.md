# 5Dim's Mod - Compatibility

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.1.0-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Compatibility integrates items from popular mods into 5Dim's organized tabs. No more messy inventory screens!

## Supported Mods

### 🔧 Major Overhaul Mods

| Mod | Integration |
|-----|-------------|
| **Krastorio 2** | Full item reorganization |
| **Space Exploration** | Tab integration |
| **Bob's Mods** | All bob modules supported |
| **Angel's Mods** | Ore and processing chains |
| **Omni Mods** | (except Omnifluid) |

### 🏭 Production Mods

| Mod | Integration |
|-----|-------------|
| **AAI Industry** | Buildings and vehicles |
| **AAI Containers** | Storage integration |
| **Bio Industries** | Bio processing |
| **Mod Mash** | Combined features |

### 📦 Logistics Mods

| Mod | Integration |
|-----|-------------|
| **Warehousing** | Large storage |
| **Deadlock Beltboxes** | Stacked items |
| **Deadlock Loaders** | Belt loading |
| **Loader Redux** | Loader variants |
| **Transport Drones** | Drone logistics |

### 🚢 Vehicle Mods

| Mod | Integration |
|-----|-------------|
| **Cargo Ships** | Water transport |

### 🤖 Inserter Mods

| Mod | Integration |
|-----|-------------|
| **Bob Inserters** | Required by 5dim_transport |

## How It Works

The compatibility module:
1. Detects which mods are installed
2. Moves their items to appropriate 5Dim tabs
3. Maintains recipe and technology connections
4. Preserves mod functionality

## Tab Organization

Items are sorted into these main tabs:

| Tab | Contents From |
|-----|--------------|
| **Logistics** | Loaders, drones, warehouses |
| **Production** | Mod machines, processing |
| **Combat** | Mod weapons, defense |
| **Transport** | Cargo ships, vehicles |
| **Resources** | Mod ores, intermediates |

## Dependencies

- **Required**: `5dim_core >= 2.0.42`
- **Optional**: All supported mods (detected automatically)

## Installation

1. Install `5dim_core` first
2. Install any supported mods you want
3. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
4. Enable in the mod menu

## Adding New Mod Support

Want support for another mod? Open an issue at:
- **GitHub**: https://github.com/McGuten/Factorio5DimMods/issues

Include:
- Mod name and portal link
- List of items that need organization
- Suggested tab placement

## File Structure

```
5dim_compatibility/
├── data.lua
├── data-final-fixes.lua
├── info.json
├── prototypes/
│   ├── krastorio2/
│   ├── bobs/
│   ├── angels/
│   ├── aai/
│   └── ...
└── locale/
```

## Contributing

Issues and suggestions welcome at:
- **GitHub**: https://github.com/McGuten/Factorio5DimMods/issues
- **Mod Portal**: https://mods.factorio.com/user/McGuten

## License

See [LICENSE](../LICENSE) for details.

---

*Part of the [5Dim's Mod](https://mods.factorio.com/user/McGuten) collection for Factorio*
