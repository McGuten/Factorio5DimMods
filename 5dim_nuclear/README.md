# 5Dim's Mod - Nuclear

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.4-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Nuclear expands nuclear power generation with 10 tiers of all major nuclear components. The current balance keeps the numbers intentionally large, but reduces the duplicated research tax across the reactor, heat and turbine lines so late-game nuclear progression is still buildable.

## Features

### ☢️ Nuclear Reactors

| Tier | Approx. Output | Consumption | Module Slots |
|------|----------------|-------------|--------------|
| T1 | 40 MW | 40 MW | 2 |
| T5 | 396 MW | 132 MW | 5 |
| T10 | 3.27 GW | 595 MW | 6 |

Approximate output is based on reactor consumption multiplied by the tiered reactor effectivity. Neighbor bonus still applies on top when reactors are placed adjacent.

### 🔥 Heat Exchangers

| Tier | Heat Transfer | Consumption | Max Temperature |
|------|---------------|-------------|-----------------|
| T1 | 2 GW | 10 MW | 1000 |
| T5 | 6 GW | 62 MW | 1400 |
| T10 | 11 GW | 613 MW | 1900 |

### 🔴 Heat Pipes

| Tier | Max Transfer | Max Temperature |
|------|--------------|-----------------|
| T1 | 1 GW | 1000 |
| T5 | 3 GW | 1400 |
| T10 | 5.5 GW | 1900 |

### 💨 Steam Turbines

| Tier | Effectivity | Steam per Tick |
|------|-------------|----------------|
| T1 | 1.00 | 1.00 |
| T5 | 1.60 | 6.23 |
| T10 | 2.35 | 61.36 |

### ⚗️ Centrifuges

| Tier | Crafting Speed | Module Slots |
|------|---------------|--------------|
| T1 | 1.0x | 2 |
| T5 | 3.0x | 5 |
| T10 | 5.5x | 6 |

## Scaling Notes

- Nuclear tiers are not simple copy-paste ratio upgrades. Reactor effectivity, exchanger transfer, heat pipe transfer and turbine steam usage all scale differently.
- Treat higher tiers as denser nuclear blocks rather than assuming vanilla 2x2 ratios remain exact at every tier.
- The main progression cost is still in building the full thermal chain, not just placing a stronger reactor.

## Tips

1. **Neighbor bonus** - Always place reactors adjacent for 100% bonus
2. **Heat pipes** - Upgrade to reduce heat loss over distance
3. **Turbines** - Higher tiers combine more steam throughput with higher effectivity, so they compress the backend footprint hard
4. **Centrifuges** - Essential for Kovarex enrichment process and for keeping uranium handling aligned with the rest of the nuclear branch

## Balance Notes

- The main balance pass was on research pacing: reactor, exchanger, heat pipe and turbine tiers were charging a duplicated research tax across four linked lines.
- Nuclear remains intentionally large-number late-game infrastructure; the change was about access pacing, not shrinking the power fantasy.
- README values now reflect the real prototype formulas instead of older placeholder ratios.

## Cross-Module Notes

- With 5dim_energy installed, late heat exchanger tiers now consume tiered boilers and late steam turbine tiers consume tiered steam engines, so the conventional steam branch remains a real industrial input instead of staying completely separate from nuclear hardware.
- With 5dim_resources installed, the uranium dust path already crosses naturally through uranium-processing. Higher centrifuge tiers speed up that branch without needing extra numeric changes in this review.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Related Modules

- `5dim_energy` - For steam engines and conventional power
- `5dim_resources` - Adds uranium dust processing that naturally scales with the centrifuge branch

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_nuclear/
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── changes.lua
│   ├── gen-centrifuge.lua
│   ├── gen-heat-exchanger.lua
│   ├── gen-heat-pipe.lua
│   ├── gen-nuclear-reactor.lua
│   └── gen-steam-turbine.lua
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
