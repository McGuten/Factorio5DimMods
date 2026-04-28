# 5Dim's Mod - Equipment

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.8-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Equipment enhances your power armor with 10 tiers of all equipment types. Become an unstoppable force!

## Features

### 🔋 Batteries

| Tier | Capacity |
|------|----------|
| T1 | 20 MJ |
| T5 | 100 MJ |
| T10 | 400 MJ |

### 🦿 Exoskeletons

| Tier | Speed Bonus | Energy Usage |
|------|------------|--------------|
| T1 | +30% | 200 kW |
| T5 | +75% | 400 kW |
| T10 | +150% | 800 kW |

### 🤖 Personal Roboports

| Tier | Robot Slots | Construction Range |
|------|------------|-------------------|
| T1 | 10 | 15 tiles |
| T5 | 30 | 25 tiles |
| T10 | 80 | 40 tiles |

### ⚡ Personal Laser Defense

| Tier | Damage | Range | Cooldown |
|------|--------|-------|----------|
| T1 | 25 | 15 | 20 ticks |
| T5 | 75 | 20 | 15 ticks |
| T10 | 200 | 30 | 10 ticks |

### ⚡ Personal Tesla Defense (NEW!)

Chain lightning that hits multiple enemies:

| Tier | Damage | Chain Targets |
|------|--------|--------------|
| T1 | 20 | 3 |
| T5 | 60 | 5 |
| T10 | 150 | 8 |

### ☀️ Portable Solar Panels

| Tier | Power Output |
|------|-------------|
| T1 | 30 kW |
| T5 | 90 kW |
| T10 | 300 kW |

### ☢️ Fission Reactors

| Tier | Power Output | Size |
|------|-------------|------|
| T1 | 750 kW | 4x4 |
| T5 | 2.25 MW | 4x4 |
| T10 | 7.5 MW | 4x4 |

### 🛡️ Energy Shields

| Tier | Shield HP | Recharge Rate |
|------|-----------|--------------|
| T1 | 150 | 120/s |
| T5 | 450 | 300/s |
| T10 | 1500 | 1000/s |

### 🌙 Night Vision

| Tier | Brightness | Color Correction |
|------|-----------|------------------|
| T1 | Standard | Green tint |
| T5 | Improved | Less green |
| T10 | Perfect | No tint |

### 🎖️ Power Armor Variants

New power armor types with more equipment grid space!

## Equipment Loadouts

### Combat Build
- 4x Personal Laser Defense T10
- 2x Energy Shield T10
- 2x Fission Reactor T10
- Fill with Batteries T10

### Speed Build
- 6x Exoskeleton T10
- 2x Fission Reactor T10
- Fill with Batteries T10

### Builder Build
- 2x Personal Roboport T10
- 2x Fission Reactor T10
- 2x Exoskeleton T10
- Fill with Batteries T10

## Tips

1. **Power balance** - More equipment = more power needed
2. **Shield stacking** - Multiple shields add HP together
3. **Exoskeleton limit** - Diminishing returns after 5-6
4. **Solar vs Fission** - Solar for daytime, fission for combat

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_equipment/
├── data.lua
├── info.json
├── prototypes/
│   ├── batteries/
│   ├── exoskeletons/
│   ├── personal-roboports/
│   ├── personal-laser-defense/
│   ├── personal-tesla-defense/
│   ├── solar-panels/
│   ├── fission-reactors/
│   ├── energy-shields/
│   └── night-vision/
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
