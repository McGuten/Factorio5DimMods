# 5Dim's Mod - Development Tools

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.0-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

> ⚠️ **For Developers Only**: This mod is intended for testing and debugging 5Dim's mods.

## Overview

5Dim's Development Tools provides debugging utilities and testing features for developing and testing 5Dim's mods.

## Features

### 🔍 Debug Console Output

Shows detailed information in the console:
- Entity spawning events
- Evolution factor changes
- Spawner behavior
- Enemy type distribution

### 🎮 Testing Tools

When installed with `5dim_enemies`:
- Evolution slider control
- Enemy type listing
- Spawn testing commands
- Resistance verification

### 📊 Data Inspection

- View internal mod data
- Check configuration values
- Monitor runtime changes

## Usage

### Console Commands

```lua
/5dim-debug           -- Toggle debug mode
/5dim-evolution 0.5   -- Set evolution to 50%
/5dim-spawn laser 5   -- Spawn laser biter T5
/5dim-info            -- Show mod info
```

### GUI Features

When `5dim_enemies` is installed, adds to the enemy GUI:
- Evolution slider
- Enemy type buttons
- Spawn probability display

## Dependencies

- **Required**: `base >= 2.0.0`
- **Required**: `5dim_core`
- **Optional**: `5dim_enemies` (for enemy testing tools)

## Installation

1. Install `5dim_core` first
2. Download from source (not on Mod Portal)
3. Enable in the mod menu

## Warning

⚠️ **Do not use in normal gameplay!**

This mod:
- May cause performance issues
- Outputs lots of console spam
- Can modify game state unexpectedly
- Is intended for development only

## File Structure

```
5dim_developing/
├── control.lua
├── info.json
└── locale/
```

## Contributing

This is an internal development tool. For issues with other 5Dim mods:
- **GitHub**: https://github.com/McGuten/Factorio5DimMods/issues
- **Mod Portal**: https://mods.factorio.com/user/McGuten

## License

See [LICENSE](../LICENSE) for details.

---

*Part of the [5Dim's Mod](https://mods.factorio.com/user/McGuten) collection for Factorio*
