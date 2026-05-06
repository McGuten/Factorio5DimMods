# 5Dim's Mod - Mining

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.4-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Mining expands resource extraction capabilities with faster miners, pumpjacks, and even water extraction on land. The current balance keeps the throughput fantasy strong, but flattens the late electric mining drill spike so the top tiers do not run away too hard from the rest of the industrial stack.

## Features

### ⛏️ Electric Mining Drills

| Tier | Mining Speed | Power | Module Slots |
|------|-------------|-------|--------------|
| T1 | 0.5/s | 90 kW | 2 |
| T5 | 2.5/s | 1.01 MW | 4 |
| T10 | 7.5/s | 5.23 MW | 6 |

### 🛢️ Pumpjacks

| Tier | Pumping Speed | Power |
|------|--------------|-------|
| T1 | 1.0x | 90 kW |
| T5 | 3.0x | 467 kW |
| T10 | 5.5x | 1.16 MW |

### 💧 Water Pumpjacks

**Extract water anywhere on land!**

| Tier | Output | Power |
|------|--------|-------|
| T1 | 1200/s | 90 kW |
| T5 | 2400/s | 560 kW |
| T10 | 3900/s | 5.52 MW |

*Perfect for deserts or inland bases without water access!*

### 🌊 Offshore Pumps

| Tier | Output |
|------|--------|
| T1 | 1200/s |
| T5 | 2400/s |
| T10 | 3900/s |

## Tips

1. **Module priority** - Put productivity modules in miners for more ore
2. **Water pumpjacks** - Use for Steam power in areas without water
3. **Upgrade timing** - Upgrade miners when ore patches deplete or when beacon and module stacks start bottlenecking raw throughput
4. **Late miners are still expensive to run** - Mining drill power rises superlinearly, so higher tiers want real power infrastructure behind them
5. **Fluid extraction stayed strong** - Pumpjacks, water pumpjacks and offshore pumps remain the high-throughput branch after the drill flattening

## Balance Notes

- The main numerical pass was on electric mining drills: late-tier mining speed and module slot growth were flattened to avoid an excessive T8-T10 spike.
- Pumpjacks, water pumpjacks and offshore pumps were audited but kept as the stronger fluid-throughput branch.
- README values now reflect the real prototype formulas instead of older placeholder numbers.
- Cross-review with Resources and Energy did not require another numeric patch: drill throughput, module slots and power draw now sit in a workable band against the furnace and masher branch, and a single high-tier steam engine can already sustain one top-tier masher or more than one top-tier drill.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## Compatibility

Works with:
- All 5Dim modules
- Most mining-related mods

## File Structure

```
5dim_mining/
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── changes.lua
│   ├── gen-electric-mining-drill.lua
│   ├── gen-offshore-pump.lua
│   ├── gen-pumpjack.lua
│   └── gen-water-pumpjack.lua
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
