# 5Dim's Mod - Autofill

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.0-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Autofill automatically fills turrets with ammo and vehicles with fuel when you place them. No more manually loading each turret!

> Based on the original Autofill mod by folk

## Features

### 🔫 Turret Auto-Fill

When you place a turret, it automatically receives ammo from your inventory:

| Turret Type | Auto-Filled With |
|-------------|-----------------|
| Gun Turret | Best available magazine |
| Flamethrower | Flamethrower ammo |
| Artillery | Artillery shells |

**Priority order for magazines:**
1. Uranium rounds magazine
2. Piercing rounds magazine
3. Firearm magazine

### 🚗 Vehicle Auto-Fill

When you enter a vehicle, it receives fuel:

| Vehicle | Auto-Filled With |
|---------|-----------------|
| Car | Best fuel |
| Tank | Best fuel + shells |
| Locomotive | Best fuel |
| Spidertron | Best fuel |

**Fuel priority:**
1. Nuclear fuel
2. Rocket fuel
3. Solid fuel
4. Coal

### ⚙️ Smart Behavior

- Only fills from your inventory (not logistics)
- Fills appropriate amounts (not all your ammo)
- Respects filter settings
- Works with 5Dim tiered turrets

## Configuration

Settings available in Mod Settings:
- Enable/disable turret autofill
- Enable/disable vehicle autofill
- Set fill amounts
- Exclude specific ammo types

## Tips

1. **Keep ammo stocked** - Autofill only works if you have ammo
2. **Best ammo used** - Always fills with highest-tier available
3. **Partial fills** - Won't empty your inventory completely
4. **Quick defense** - Place turrets rapidly during attacks

## Dependencies

- **Required**: `5dim_core >= 2.0.0`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Credits

- **Original Author**: folk
- **Updated by**: 5Dim

## File Structure

```
5dim_autofill/
├── control.lua
├── info.json
├── settings.lua
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
