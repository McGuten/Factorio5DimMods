# 5Dim's Mod - Equipment

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.8-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Equipment expands power armor progression with late-game tiers for combat, mobility, building, and portable power. The current balance keeps the portable power branch, the support branch, and the combat branch in sync: batteries, portable solar and reactors are easier to progress into, non-combat support gear no longer pays needless military gating, and late shields no longer demand absurd recharge spikes compared with the power sources that are supposed to feed them.

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

| Tier | Damage | Range | Cooldown | Energy/Shot | Sustained Draw |
|------|--------|-------|----------|-------------|----------------|
| T1 | 3.00 | 15 | 40 ticks | 50 kJ | 75 kW |
| T5 | 9.50 | 28 | 32 ticks | 130 kJ | 244 kW |
| T10 | 20.00 | 48 | 22 ticks | 230 kJ | 627 kW |

### ⚡ Personal Tesla Defense

Short-range anti-swarm line. With Space Age active it chains through nearby targets and applies Tesla slow/stun effects:

| Tier | Damage | Range | Cooldown | Energy/Shot | Sustained Draw |
|------|--------|-------|----------|-------------|----------------|
| T1 | 2.50 | 12 | 34 ticks | 45 kJ | 79 kW |
| T5 | 6.50 | 16 | 26 ticks | 85 kJ | 196 kW |
| T10 | 11.50 | 22 | 16 ticks | 135 kJ | 506 kW |

When 5dim_battlefield is installed, this branch no longer pretends to be a laser derivative: its recipes consume tesla turrets and its first tier also intersects the battlefield tesla technology line.

### ☀️ Portable Solar Panels

| Tier | Power Output |
|------|-------------|
| T1 | 30 kW |
| T5 | 73.2 kW |
| T10 | 223.5 kW |

### ☢️ Fission Reactors

| Tier | Power Output | Size |
|------|-------------|------|
| T1 | 1.5 MW | 4x4 |
| T5 | 9 MW | 4x4 |
| T10 | 32 MW | 4x4 |

### 🛡️ Energy Shields

| Tier | Shield HP | Recharge Rate | Input Flow |
|------|-----------|---------------|------------|
| T1 | 50 | 12/s | 240 kW |
| T5 | 4125 | 200/s | 6 MW |
| T10 | 56000 | 1200/s | 36 MW |

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
| T10 | +110 | 12x24 |

## Equipment Loadouts

### Combat Build
- 4x Personal Laser Defense T10
- 1x Personal Tesla Defense T10
- 1x Energy Shield T10
- 2x Fission Reactor T10
- Fill with Batteries T9-T10

### Speed Build
- 6x Exoskeleton T10
- 1x Fission Reactor T10
- 2x Battery T10
- Fill with Portable Solar T8-T10 or more Batteries

### Builder Build
- 1x Personal Roboport T10
- 2x Fission Reactor T10
- 2x Exoskeleton T10
- Fill with Batteries T10

### Heavy Combat Build
- 4x Personal Laser Defense T10
- 2x Energy Shield T10
- 3x Fission Reactor T10
- Fill with Batteries T10

## Tips

1. **Power balance** - More equipment = more power needed
2. **Shield stacking** - Multiple shields add HP together
3. **Combat tradeoffs** - Laser favors reach and single-target pressure; Tesla favors short-range control and cleanup
4. **Shield recharge is burst power** - High-tier shields no longer ask for absurd recharge spikes, but they still want reactor support rather than solar-only grids
5. **Solar vs Fission** - Portable solar is efficient support power; fission covers sustained combat, shields and builder bursts
6. **Builder setups spike hard** - Personal roboports use burst-heavy input flow, so dual-roboport armor wants extra reactor or battery headroom

## Balance Notes

- Portable power tech pacing was eased so support energy upgrades do not lag behind the equipment they are supposed to sustain.
- Exoskeletons, personal roboports and power armor now progress as support equipment rather than paying full combat-science pacing.
- Personal laser remains the long-range single-target branch.
- Personal tesla remains the shorter-range anti-swarm and control branch.
- Late shield recharge was flattened so it fits the portable reactor branch better instead of demanding absurd peak input.
- Cross-review with Module now makes late power armor tiers consume current 5Dim speed and efficiency modules in modest amounts, so the armor branch actually intersects with the transversal module branch without inheriting an explosive recursive tax.

### Cross-Module Notes

- With 5dim_battlefield installed, personal tesla now uses tesla turret items and hooks into the first battlefield tesla tech instead of remaining attached only to the personal laser line.
- That keeps the portable combat split coherent: laser stays the longer-range precision branch, while tesla inherits the same short-range anti-swarm identity as the placed turret branch.
- The crossover is conditional, so Equipment still works alone and falls back cleanly when Battlefield is not present.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- `5dim_battlefield` - Personal tesla now consumes battlefield tesla hardware and intersects the battlefield tesla tech branch.
- `5dim_module` - Late power armor tiers consume current 5Dim speed and efficiency modules.
- `5dim_energy` - Portable shields, reactors, batteries and solar panels are balanced to sit on the same power-planning curve.
- All other 5Dim modules

## File Structure

```
5dim_equipment/
├── changelog.txt
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
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
