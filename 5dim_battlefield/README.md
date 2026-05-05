# 5Dim's Mod - Battlefield

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.7-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Battlefield expands your defensive capabilities with multiple tiers of turrets, walls, and detection systems. Gun and laser defenses now follow a cleaner standard plus sniper split, with a dedicated sniper rifle and custom sniper ammunition for the late-game branch.

## Features

### 🔫 Gun Turrets

10 tiers with 2 variants each:

| Variant | Description |
|---------|-------------|
| **Standard** | Balanced damage and fire rate |
| **Sniper** | Long-range upgrade branch with dedicated sniper magazines |

Sniper progression now unlocks in three steps: sniper rifle, sniper turret, then piercing sniper rounds.

### ⚡ Laser Turrets

10 tiers with 2 variants:

| Variant | Description |
|---------|-------------|
| **Standard** | Gentle per-tier power scaling on top of the vanilla laser baseline |
| **Sniper** | Longer-range branch built from the standard tier-5 turret onward, with a higher energy premium |

Laser sniper turrets keep the simpler two-branch structure without the removed small and big variants.

### ⚡ Tesla Turrets

Electric turrets that fire lightning bolts:

| Tier | Damage | Range | Energy |
|------|--------|-------|--------|
| T1 | 35 | 35 | 3.2 MJ/shot |
| T5 | 42 | 55 | 4.0 MJ/shot |
| T10 | 50.75 | 80 | 4.9 MJ/shot |

Tesla tiers also scale idle drain and recharge requirements with their higher ranges.

### 🔥 Flamethrower Turrets

10 tiers of area denial:

| Tier | Damage/s | Range |
|------|----------|-------|
| T1-T10 | 30 → 150 | 30 → 45 |

### 🧱 Walls and Gates

10 tiers of defensive structures:

| Tier | Wall HP | Gate HP |
|------|---------|---------|
| T1 | 350 | 500 |
| T5 | 1,500 | 2,100 |
| T10 | 5,000 | 7,000 |

### 📡 Radars

10 tiers of detection range:

| Tier | Scan Range | Reveal Range |
|------|-----------|--------------|
| T1 | 7 chunks | 14 chunks |
| T5 | 15 chunks | 30 chunks |
| T10 | 30 chunks | 60 chunks |

## Strategy Tips

1. **Mix turret types** - Gun turrets for physical-resistant enemies, lasers for armored
2. **Layer your walls** - Multiple wall tiers slow down breaches
3. **Radar coverage** - Early warning of attacks saves turrets
4. **Tesla for swarms** - Chain lightning clears groups efficiently
5. **Flamethrower for sustainment** - Fire damage over time handles tankier enemies

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works great with:
- `5dim_enemies` - More enemy types to defend against!
- All other 5Dim modules
- Most defense mods

## File Structure

```
5dim_battlefield/
├── data.lua
├── info.json
├── prototypes/
│   ├── gun-turrets/
│   ├── laser-turrets/
│   ├── tesla-turrets/
│   ├── flamethrower-turrets/
│   ├── walls/
│   └── radars/
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
