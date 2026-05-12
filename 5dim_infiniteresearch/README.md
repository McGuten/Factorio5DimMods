# 5Dim's Mod - Infinite Research

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.5-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Infinite Research adds infinite research options for late-game progression. Keep researching forever!

## Features

### 🔬 Infinite Research Technologies

All research can be repeated infinitely for stacking bonuses:

| Research | Bonus per Level | Base Value |
|----------|----------------|------------|
| **Crafting Speed** | +10% | Assembly machines |
| **Mining Speed** | +10% | Mining drills |
| **Bullet Damage** | +5% | Gun turrets |
| **Laser Damage** | +5% | Laser turrets |
| **Worker Robot Battery** | +10% | Robot energy |
| **Worker Robot Storage** | +1 slot | Robot cargo |
| **Braking Force** | +5% | Train braking |
| **Stack Size** | +1 | Inventory stacks |
| **Research Productivity** | +1% | Lab productivity |
| **Tech Speed** | +5% | Research speed |

### 📈 Research Scaling

Research cost increases with each level:

| Level | Cost Multiplier |
|-------|----------------|
| 1-10 | 1x |
| 11-20 | 2x |
| 21-50 | 5x |
| 51-100 | 10x |
| 100+ | 20x |

### 🪐 Space Age Integration

When `space-age` is active and `5d-space-age-materials` is enabled, this module
adds a staged planetary science progression instead of a single fixed pack:

- Manual crafting speed and mining speed switch to metallurgic, then
	electromagnetic, then cryogenic science in their late tiers.
- Infinite robot battery and storage upgrades align with the electromagnetic
	stage of Space Age robotics.
- The late infinite military, logistics, train and lab upgrades are pushed to a
	full planetary endgame using metallurgic, electromagnetic and cryogenic
	science packs together.

The DLC-owned `research-productivity` technology is not replaced. In non-Space
Age games this module keeps its own research productivity technology under the
internal key `5d-research-productivity`.

### 🎯 Strategic Research

Which infinite research to prioritize:

| Priority | Research | Why |
|----------|----------|-----|
| **High** | Mining Speed | More resources |
| **High** | Crafting Speed | More throughput |
| **Medium** | Worker Robot | Faster logistics |
| **Medium** | Damage | Better defense |
| **Low** | Stack Size | QoL improvement |

## Mega-Base Considerations

For mega-bases, prioritize:
1. **Crafting Speed** - Fewer machines needed
2. **Mining Speed** - Extend ore patch life
3. **Research Productivity** - More science per pack

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_infiniteresearch/
├── data.lua
├── info.json
├── prototypes/
│   ├── braking.lua
│   ├── crafting-speed.lua
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
