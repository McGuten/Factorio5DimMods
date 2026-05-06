# 5Dim's Mod - Battlefield

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.7-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Battlefield expands your defensive capabilities with multiple tiers of turrets, walls, and detection systems. In the current balance pass, the module is tuned together with 5dim_enemies: standard gun and laser lines are your main answer to resistant enemy variants, radar is deliberately restrained on nearby reveal for performance, and tesla now fills a clearer late-game anti-swarm role instead of arriving after the danger spike has already passed.

## Features

### 🔫 Gun Turrets

10 tiers with 2 variants each:

| Variant | Description |
|---------|-------------|
| **Standard** | Ammo-based mixed-defense backbone; best paired against laser-resistant and fragile enemy waves |
| **Sniper** | Long-range upgrade branch with dedicated sniper magazines for priority picks and outer-line defense |

Standard gun tiers now keep the range pacing needed to stay relevant against late 5dim_enemies variants while paying noticeably steeper late-tier recipe costs.

| Tier | Range | Damage Modifier | HP |
|------|-------|-----------------|----|
| T1 | 22 | 1.00x | 480 |
| T5 | 34 | 1.20x | 1332 |
| T10 | 49 | 1.45x | 2397 |

Sniper progression still unlocks in three steps: sniper rifle, sniper turret, then piercing sniper rounds.

### ⚡ Laser Turrets

10 tiers with 2 variants:

| Variant | Description |
|---------|-------------|
| **Standard** | Main counter-line into physical-resistant enemies, with higher power demand and heavier late-tier electronics |
| **Sniper** | Longer-range branch built from the standard tier-5 turret onward, with a higher energy premium |

Laser sniper turrets keep the simpler two-branch structure without the removed small and big variants.

| Tier | Range | Damage | HP |
|------|-------|--------|----|
| T1 | 26 | 20 | 1000 |
| T5 | 38 | 24 | 2776 |
| T10 | 53 | 29 | 4996 |

### ⚡ Tesla Turrets

Electric turrets that fire lightning bolts:

| Tier | Damage | Range | Energy |
|------|--------|-------|--------|
| T1 | 35 | 35 | 3.2 MJ/shot |
| T5 | 42 | 55 | 4.0 MJ/shot |
| T10 | 50.75 | 80 | 4.9 MJ/shot |

Tesla is now positioned as a late utility-science branch after laser tier 6. It is no longer meant to be the first serious answer to midgame enemy pressure; its job is to clear dense mixed swarms and punish stacked late waves once your standard gun and laser backbone is already online.

Tesla tiers also scale idle drain and recharge requirements with their higher ranges.

When 5dim_energy is installed, tesla recipes also start consuming tiered accumulators from T2 onward, so the turret line is tied to the same electrical storage branch that is expected to feed its burst-heavy shots.

### 🔥 Flamethrower Turrets

10 tiers of area denial:

| Tier | Damage/s | Range |
|------|----------|-------|
| T1-T10 | 30 → 150 | 30 → 45 |

Flamethrowers remain the broad anti-wave sustain option, especially into regenerators, swarm-heavy pushes and any lane where raw turret attrition matters more than target selection. Their late tiers now pay more honestly in engines, pipes and advanced materials instead of coasting on a flat recipe curve.

### ☣️ Acid Turrets

10 tiers of corrosive support fire:

| Tier | Range | HP | Notes |
|------|-------|----|-------|
| T1 | 22 | 420 | Early special turret branch after military science |
| T5 | 34 | 1168 | Midgame corrosive support with faster cadence |
| T10 | 49 | 2103 | Late support line without needing space science |

Acid turrets are now easier to keep in progression through late utility science. They are not meant to replace the standard gun line; they are a specialist branch for corrosive chip damage and splash pressure on mixed packs.

### ☠️ Poison Turrets

10 tiers of lingering damage support:

| Tier | Range | HP | Notes |
|------|-------|----|-------|
| T1 | 24 | 400 | Early special turret branch after military science |
| T5 | 36 | 1112 | Midgame denial and damage-over-time support |
| T10 | 51 | 2002 | Late support line without needing space science |

Poison turrets sit in the same support tier as acid: useful for area denial and attrition, but intentionally worse as a universal answer because poison enemies themselves resist that damage type heavily.

### 🧱 Walls and Gates

10 tiers of defensive structures:

| Tier | Wall HP | Gate HP |
|------|---------|---------|
| T1 | 350 | 500 |
| T5 | 1,500 | 2,100 |
| T10 | 5,000 | 7,000 |

### 📡 Radars

10 tiers of detection range:

| Tier | Sector Scan | Nearby Reveal | Energy |
|------|-------------|---------------|--------|
| T1 | 14 | 3 | 300 kW |
| T5 | 22 | 5 | 1500 kW |
| T10 | 32 | 7 | 3000 kW |

Nearby reveal grows conservatively on purpose. The expensive part for performance is nearby charting, so the high tiers focus more on long-range scanning than on aggressively expanding the local reveal radius.

The second balance pass also makes radar research a bit less punishing, because information is an indirect defense tool rather than direct combat power.

## Strategy Tips

1. **Mix gun and laser lines** - Gun turrets answer laser-resistant enemies; laser turrets answer physical-resistant enemies.
2. **Use flamethrowers for sustain lanes** - They are still the most generally useful anti-wave support branch once pressure stops being purely early game.
3. **Treat acid and poison as support, not backbone** - They help wear down mixed packs, but standard gun and laser lines still carry the main resistance matchups.
4. **Do not treat tesla as your first spike** - It is a late branch for dense swarms, not a replacement for your core defensive grid.
5. **Use radar as a pacing tool** - Early warning matters more once more enemy variants can appear closer to your base.
6. **Layer walls behind the firing line** - The recent wall and gate durability bump is there to buy time for mixed turrets, not to replace them.
7. **Tank enemies still need focus fire** - Their universal resistance is lower now, but they are still attrition units, not trash mobs.

## Cross-Module Notes

- With 5dim_energy installed, tesla turret recipes now escalate through tiered accumulators instead of staying on a nearly flat battery-only curve.
- With 5dim_equipment installed, the portable tesla branch now intersects this tesla turret line instead of remaining a laser-only derivative.
- These crossovers are conditional, so Battlefield still works as a standalone combat module while gaining a more honest late-game infrastructure cost inside the full 5Dim stack.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works great with:
- `5dim_enemies` - Recommended pair; battlefield is currently balanced around resistant variants, delayed suicide waves, and the toned-down but still durable tank line.
- `5dim_energy` - Recommended for tesla-heavy late defenses, because higher accumulator tiers now feed directly into tesla turret recipes.
- `5dim_equipment` - Personal tesla now follows the battlefield tesla branch when both modules are present.
- All other 5Dim modules
- Most defense mods

## File Structure

```
5dim_battlefield/
├── data.lua
├── data-final-fixes.lua
├── info.json
├── changelog.txt
├── locale/
├── prototypes/
│   ├── gen-gun-turret.lua
│   ├── gen-gun-turret-sniper.lua
│   ├── gen-laser-turret.lua
│   ├── gen-laser-turret-sniper.lua
│   ├── gen-tesla-turret.lua
│   ├── gen-radar.lua
│   ├── gen-wall.lua
│   └── ...
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
