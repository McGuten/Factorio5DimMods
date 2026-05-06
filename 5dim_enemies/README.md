# 5Dim's Mod - Enemies

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

> ⚠️ **Warning**: This mod significantly increases game difficulty! Recommended for experienced players.

## Overview

5Dim's Enemies is a comprehensive enemy overhaul mod that adds multiple unique enemy types with distinct behaviors, resistances, and visual appearances. The current balance is intended to be read together with 5dim_battlefield: more variants can pressure you from nearer distances than before, suicide is delayed so it stops front-loading explosive punishment, and tank remains a durable all-round attrition enemy without completely blanking every damage type.

## Features

### 🎯 Enemy Types

Each enemy type has unique characteristics, resistances, and visual colors:

#### Biters (Melee Units)

| Type | Color | Health | Speed | Damage | Special Ability |
|------|-------|--------|-------|--------|-----------------|
| **Normal** | Default | 100% | 100% | 100% | Balanced baseline |
| **Laser** | 🔵 Blue (`#4444FF`) | 100% | 100% | 100% | 85%+ laser resistance |
| **Physical** | ⚪ Silver (`#AAAAAA`) | 100% | 100% | 100% | 85%+ bullet resistance |
| **Impact** | 🟤 Brown (`#8B4513`) | 130% | 85% | 150% | Heavy hitter, slow |
| **Broodmother** | 🟣 Magenta (`#FF00FF`) | 150% | 70% | 80% | Spawns offspring on death |
| **Swarm** | 🟡 Gold (`#FFD700`) | 25% | 150% | 50% | 2x spawn rate, 70% size |
| **Regenerator** | 🟢 Lime (`#00FF00`) | 75% | 90% | 80% | 5x healing, weak to fire |
| **Berserker** | 🔴 Red (`#CC0000`) | 50% | 130% | 200% | Glass cannon, no healing |
| **Tank** | 🫒 Olive (`#808000`) | 200% | 80% | 35% | 35% resistance to ALL |

#### Spitters (Ranged Units)

| Type | Color | Health | Damage | Attack Type |
|------|-------|--------|--------|-------------|
| **Normal** | Default | 100% | 100% | Acid projectile |
| **Fire** | 🟠 Orange (`#FF6600`) | 75% | 100% | Fire DoT, burning ground |
| **Rocket** | 🟡 Yellow (`#FFFF66`) | 75% | 100% | Explosive splash damage |
| **Suicide** | 🟣 Purple (`#9900CC`) | 50% | 500% | Explodes on death, delayed to later evolution |
| **Poison** | 🟢 Dark Green (`#006600`) | 90% | 100% | Poison DoT, stacking |
| **Electric** | 🔵 Cyan (`#00FFFF`) | 100% | 100% | Chain lightning |
| **Tank** | 🫒 Olive (`#808000`) | 200% | 35% | 35% resistance to ALL |

#### Worms (Stationary Defense)

| Type | Color | Special |
|------|-------|---------|
| **Fire** | Orange | Fire projectiles |
| **Poison** | Green | Poison clouds |
| **Electric** | Cyan | Lightning attacks |
| **Acid** | Lime | Enhanced corrosive |
| **Explosion** | Purple | Explosive projectiles |
| **Tank** | Olive | 35% all resistance |

#### Space Age Types (Requires Space Age DLC)

| Type | Color | Special |
|------|-------|---------|
| **Railgun** | 🔷 Teal (`#008080`) | High railgun/AP resistance |

### 📊 Tier System (T1-T10 + Boss)

All enemy types scale across **10 tiers** based on evolution:

| Tier | Evolution Range | Scale | Relative Power |
|------|-----------------|-------|----------------|
| T1 | 0% - 10% | Small | Baseline |
| T2 | 10% - 20% | | 1.5x |
| T3 | 20% - 30% | | 2x |
| T4 | 30% - 40% | | 3x |
| T5 | 40% - 50% | Medium | 4x |
| T6 | 50% - 60% | | 5x |
| T7 | 60% - 70% | | 7x |
| T8 | 70% - 80% | | 10x |
| T9 | 80% - 90% | Large | 15x |
| T10 | 90% - 100% | | 20x |
| **Boss** | 90% - 100% | 2x Size | 3x HP/DMG, 40% slower |

### 🗺️ Spawn Pressure Model

The current version relies more on evolution timing than on keeping special enemies far away from the player start.

| Pressure Gate | What It Means |
|---------------|---------------|
| **Near-start pressure** | Many special variants can now appear without a large distance gate, so mixed defenses matter earlier |
| **Evolution gate** | Evolution is now the main limiter for the nastier spikes |
| **Delayed suicide** | Suicide variants start later at 50% evolution instead of arriving in the earlier midgame |
| **Tank persistence** | Tank variants appear from 15% evolution but now resist 35% instead of 50%, so focused mixed fire is more reliable |

### 🖥️ In-Game GUI

Press **Shift+E** to open the enemy info panel showing:
- Current evolution factor with breakdown (time, pollution, kills)
- Spawn probability distribution per tier
- Active enemy types list
- Developer tools (when 5dim_dev is installed)

### 📚 Tips & Tricks

Full documentation available in-game under **Tips & Tricks → 5Dim's Mod**:
- Interactive simulations for each enemy type
- Strategy guides and counter-strategies
- Tier system explanation
- Full battle demonstration

## Configuration

All enemy types can be individually enabled/disabled in **Mod Settings → Startup**:

### Biters
- `5d-laser-biter` - Laser resistant biters
- `5d-physical-biter` - Bullet resistant biters
- `5d-impact-biter` - Heavy impact biters
- `5d-broodmother-biter` - Broodmother biters
- `5d-swarm-biter` - Swarm biters
- `5d-regenerator-biter` - Fast healing biters
- `5d-berserker-biter` - Glass cannon biters
- `5d-tank-biter` - Tank biters

### Spitters
- `5d-fire-spitter` - Fire spitters
- `5d-rocket-spitter` - Rocket spitters
- `5d-suicide` - Suicide spitters
- `5d-laser-spitter` - Laser resistant spitters
- `5d-physical-spitter` - Bullet resistant spitters
- `5d-poison-spitter` - Poison spitters
- `5d-electric-spitter` - Electric spitters
- `5d-tank-spitter` - Tank spitters

### Worms
- `5d-worm` - All worm variants
- `5d-tank-worm` - Tank worms

### Space Age (requires DLC)
- `5d-railgun-biter` - Railgun biters
- `5d-railgun-spitter` - Railgun spitters
- `5d-railgun-worm` - Railgun worms

### Bosses
- `5d-boss` - Boss variants for all types

## Strategy Guide

### Counter-Strategies by Type

| Enemy | ❌ Ineffective | ✅ Effective |
|-------|---------------|--------------|
| **Laser** | Laser turrets | Gun turrets, Flamethrowers |
| **Physical** | Gun turrets | Laser turrets, Flamethrowers |
| **Impact** | Melee combat | Kiting, Long-range |
| **Broodmother** | Single-target | AoE, Flamethrowers |
| **Swarm** | Single-target | AoE, Flamethrowers, Grenades |
| **Regenerator** | Low DPS | Fire damage, Focus fire |
| **Berserker** | Slow response | High burst, Walls |
| **Tank** | Single-damage spam | Mixed gun/laser fire, Flamethrowers, sustained focus fire |
| **Suicide** | Close combat, overextended walls | Long-range, Priority targeting, radar-supported early warning |
| **Electric** | Dense turrets | Spread defenses |

### Defense Tips

1. **Mixed defenses** - Use both gun and laser turrets to counter resistant types; the pairing is now more important than pure range stacking.
2. **Flamethrowers** - Effective against most types, especially regenerators
3. **Walls** - Essential against berserkers and still valuable against suicide, but suicide now arrives later instead of punishing the early midgame
4. **Spacing** - Spread turrets to minimize chain lightning damage
5. **Artillery** - Great for thinning distant swarms before they reach your walls

### Battlefield Synergy

- Standard gun turrets are the core answer into laser-resistant enemies.
- Standard laser turrets are the core answer into physical-resistant enemies.
- Tesla turrets are a later anti-swarm branch, not the first tool you should rely on to stabilize pressure.
- Higher-tier radars matter because more enemy variants can pressure you without needing a large distance gate.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`
- **Optional**: `space-age` (for Railgun enemy types)
- **Optional**: `5dim_dev` (for developer GUI tools)

## Installation

1. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
2. Place in your Factorio mods folder
3. Enable in the mod menu
4. Configure enemy types in Mod Settings → Startup

## Compatibility

This mod is compatible with:
- All 5Dim's mod modules
- Most other mods that don't heavily modify the enemy system
- Space Age DLC (adds railgun enemy types)

## File Structure

```
5dim_enemies/
├── data.lua              # Main data entry point
├── data-tiered.lua       # Tier system generation
├── data-final-fixes.lua  # Final adjustments
├── control.lua           # Runtime GUI and events
├── settings.lua          # Mod settings definitions
├── shared-config.lua     # SINGLE SOURCE OF TRUTH for all types
├── info.json             # Mod metadata
├── thumbnail.png         # Mod portal thumbnail
├── changelog.txt         # Version history
├── locale/
│   └── en/
│       └── locale.cfg    # English translations
├── prototypes/
│   ├── config/           # Configuration files
│   │   ├── tiers.lua     # Tier definitions
│   │   ├── biter-types.lua
│   │   ├── spitter-types.lua
│   │   ├── worm-types.lua
│   │   └── spawner-config.lua
│   ├── gen-biters-tiered.lua
│   ├── gen-spitters-tiered.lua
│   ├── gen-worms-tiered.lua
│   ├── gen-spawners.lua
│   ├── tips-and-tricks.lua
│   └── tips-and-tricks-simulations.lua
├── graphics/             # Enemy sprites and icons
└── migrations/           # Save migration scripts
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
