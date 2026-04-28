# 5Dim's Mod - Core

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.42-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

> ⚠️ **Required**: This is the core library required by all 5Dim's modules.

## Overview

5Dim's Core is the foundation module that all other 5Dim's mods depend on. It provides the organizational framework, shared utilities, and item grouping system that makes 5Dim's mod suite work seamlessly together.

## Features

### 📁 Organized Item Groups

The core module reorganizes all items into logical, easy-to-navigate tabs:

| Tab | Contents |
|-----|----------|
| **Logistics** | Belts, inserters, robots, roboports |
| **Production** | Assemblers, furnaces, chemical plants |
| **Combat** | Turrets, walls, armor, weapons |
| **Power** | Steam engines, solar, nuclear, poles |
| **Transport** | Trains, locomotives, wagons |
| **Modules** | Speed, productivity, efficiency, beacons |
| **Resources** | Mining drills, pumpjacks, refineries |
| **Storage** | Chests, tanks, warehouses |

### 🔧 Shared Utilities

- Common functions used by all 5Dim modules
- Tier system framework (T1-T10)
- Recipe and technology generation helpers
- Sprite and icon utilities

### ⚙️ Configuration

Global settings that affect all 5Dim modules:
- Icon display options
- Recipe unlock progression
- Technology tree organization

### 🚀 Space Age Support

Full compatibility with Factorio's Space Age DLC:
- Organized tabs for new planets
- Support for quality system
- New item group integrations

## Dependencies

- **Required**: `base >= 2.0.0`
- **Optional**: `space-age >= 2.0.0` (for DLC features)

## Installation

1. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
2. Place in your Factorio mods folder
3. Enable in the mod menu
4. Install any 5Dim modules you want

## Available Modules

All these modules require 5dim_core:

| Module | Description |
|--------|-------------|
| [5dim_automation](../5dim_automation) | Assemblers, chemical plants, refineries, labs |
| [5dim_battlefield](../5dim_battlefield) | Turrets, walls, radars |
| [5dim_energy](../5dim_energy) | Power generation and distribution |
| [5dim_enemies](../5dim_enemies) | New enemy types and variants |
| [5dim_equipment](../5dim_equipment) | Power armor equipment |
| [5dim_infiniteresearch](../5dim_infiniteresearch) | Late-game infinite research |
| [5dim_logistic](../5dim_logistic) | Robots and roboports |
| [5dim_mining](../5dim_mining) | Mining drills and pumpjacks |
| [5dim_module](../5dim_module) | Modules and beacons |
| [5dim_nuclear](../5dim_nuclear) | Nuclear power systems |
| [5dim_resources](../5dim_resources) | Furnaces and ore processing |
| [5dim_space_age](../5dim_space_age) | Space Age DLC expansion |
| [5dim_storage](../5dim_storage) | Chests and tanks |
| [5dim_trains](../5dim_trains) | Locomotives and wagons |
| [5dim_transport](../5dim_transport) | Belts, inserters, pumps |
| [5dim_decoration](../5dim_decoration) | Decorative elements |
| [5dim_locale](../5dim_locale) | Translations |
| [5dim_compatibility](../5dim_compatibility) | Integration with other mods |
| [5dim_autofill](../5dim_autofill) | Auto-fill fuel and ammo |

## File Structure

```
5dim_core/
├── data.lua              # Main data entry point
├── data-updates.lua      # Data stage updates
├── info.json             # Mod metadata
├── settings.lua          # Global settings
├── thumbnail.png         # Mod portal thumbnail
├── changelog.txt         # Version history
├── lib/                  # Shared libraries
│   ├── functions.lua     # Common functions
│   ├── tier-utils.lua    # Tier generation utilities
│   └── icon-utils.lua    # Icon helpers
├── locale/
│   └── en/
│       └── locale.cfg    # English translations
├── prototypes/
│   ├── groups.lua        # Item group definitions
│   ├── subgroups.lua     # Item subgroup definitions
│   └── changes/          # Vanilla item reorganization
└── graphics/             # Icons and sprites
```

## Contributing

Issues and suggestions welcome at:
- **GitHub**: https://github.com/McGuten/Factorio5DimMods/issues
- **Mod Portal**: https://mods.factorio.com/user/McGuten

## License

This mod is part of the 5Dim's mod collection. See [LICENSE](../LICENSE) for details.

## Credits

- **Author**: 5Dim / McGuten
- **Factorio**: Wube Software

---

*Part of the [5Dim's Mod](https://mods.factorio.com/user/McGuten) collection for Factorio*
