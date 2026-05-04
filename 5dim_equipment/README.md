# 5Dim's Mod - Equipment

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.8-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Equipment expands power armor progression with late-game tiers for combat, mobility, building, and portable power.

## Features

### 🔋 Batteries

| Tier | Capacity |
|------|----------|
| T1 | 20 MJ |
| T5 | 600 MJ |
| T10 | 2400 MJ |

### 🦿 Exoskeletons

| Tier | Speed Bonus | Energy Usage |
|------|------------|--------------|
| T1 | +30% | 200 kW |
| T5 | +75% | 500 kW |
| T10 | +150% | 875 kW |

### 🤖 Personal Roboports

| Tier | Robot Slots | Construction Range | Input Flow |
|------|------------|-------------------|-----------|
| T1 | 10 | 15 tiles | 3.5 MW |
| T5 | 55 | 26 tiles | 32 MW |
| T10 | 110 | 36 tiles | 56 MW |

### ⚡ Personal Laser Defense

| Tier | Damage | Range | Cooldown |
|------|--------|-------|----------|
| T1 | 3.00 | 15 | 40 ticks |
| T5 | 9.50 | 28 | 32 ticks |
| T10 | 20.00 | 48 | 22 ticks |

### ⚡ Personal Tesla Defense

Short-range anti-swarm line. With Space Age active it chains through nearby targets and applies Tesla slow/stun effects:

| Tier | Damage | Range | Cooldown |
|------|--------|-------|----------|
| T1 | 2.50 | 12 | 34 ticks |
| T5 | 6.50 | 16 | 26 ticks |
| T10 | 11.50 | 22 | 16 ticks |

### ☀️ Portable Solar Panels

| Tier | Power Output |
|------|-------------|
| T1 | 30 kW |
| T5 | 73 kW |
| T10 | 224 kW |

### ☢️ Fission Reactors

| Tier | Power Output | Size |
|------|-------------|------|
| T1 | 1.5 MW | 4x4 |
| T5 | 9 MW | 4x4 |
| T10 | 32 MW | 4x4 |

### 🛡️ Energy Shields

| Tier | Shield HP | Recharge Rate |
|------|-----------|--------------|
| T1 | 50 | 12/s |
| T5 | 4125 | 270/s |
| T10 | 56000 | 3000/s |

### 🌙 Night Vision

| Tier | Brightness | Color Correction |
|------|-----------|------------------|
| T1 | Standard | Green tint |
| T2 | Improved | Neutral LUT, 10 kW draw |

### 🎖️ Power Armor Variants

| Tier | Inventory Bonus | Equipment Grid |
|------|-----------------|----------------|
| T1 | +20 | 10x10 |
| T5 | +60 | 11x14 |
| T10 | +110 | 10x24 |

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
3. **Combat tradeoffs** - Laser favors reach and single-target pressure; Tesla favors short-range control and cleanup
4. **Solar vs Fission** - Solar is efficient support power; fission covers sustained combat and builder bursts

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
├── data-updates.lua
├── info.json
├── prototypes/
│   ├── gen-battery-equipment.lua
│   ├── gen-energy-shield-equipment.lua
│   ├── gen-exoskeleton-equipment.lua
│   ├── gen-fission-reactor-equipment.lua
│   ├── gen-personal-laser-defense-equipment.lua
│   ├── gen-personal-roboport-equipment.lua
│   ├── gen-personal-tesla-defense-equipment.lua
│   ├── gen-power-armor.lua
│   ├── gen-solar-panel-equipment.lua
│   └── night-vision-equipment.lua
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
