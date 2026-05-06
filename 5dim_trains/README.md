# 5Dim's Mod - Trains

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Trains expands the railway system with faster locomotives and higher-capacity wagons. The current balance keeps wagon throughput large, but now gives late locomotives a real power-to-weight improvement so heavy trains actually feel better to pull.

## Features

### 🚂 Locomotives

| Tier | Max Speed | Power | Weight |
|------|-----------|-------|--------|
| T1 | 259 km/h | 600 kW | 2000 kg |
| T5 | 389 km/h | 1.6 MW | 4000 kg |
| T10 | 551 km/h | 2.85 MW | 6500 kg |

### 📦 Cargo Wagons

| Tier | Inventory Size |
|------|---------------|
| T1 | 40 slots |
| T2 | 80 slots |
| T3 | 120 slots |
| T4 | 160 slots |
| T5 | 200 slots |
| T6 | 240 slots |
| T7 | 280 slots |
| T8 | 320 slots |
| T9 | 360 slots |
| T10 | 400 slots |

### 🛢️ Fluid Wagons

| Tier | Capacity |
|------|---------|
| T1 | 25,000 |
| T2 | 50,000 |
| T3 | 75,000 |
| T4 | 100,000 |
| T5 | 125,000 |
| T6 | 150,000 |
| T7 | 175,000 |
| T8 | 200,000 |
| T9 | 225,000 |
| T10 | 250,000 |

## Train Composition Tips

### Speed vs Capacity

| Priority | Locomotives | Wagons | Result |
|----------|------------|--------|--------|
| Speed | More | Less | Faster acceleration |
| Capacity | Less | More | More cargo per trip |
| Balanced | Equal | Equal | Best of both |

### Fuel Efficiency

Higher tier locomotives move more cargo per train and now also improve heavy-haul pull thanks to better power scaling:

| Tier | Cargo Wagon Capacity | Fluid Wagon Capacity | Locomotive Power |
|------|----------------------|----------------------|------------------|
| T1 | 40 slots | 25,000 | 600 kW |
| T5 | 200 slots | 125,000 | 1.6 MW |
| T10 | 400 slots | 250,000 | 2.85 MW |

## Tips

1. **Match tiers** - Use same tier locomotives and wagons for consistency
2. **Acceleration** - Higher tier locomotives now improve power-to-weight enough to matter on heavy-haul trains
3. **Fluid transport** - T10 fluid wagons replace 5 T1 wagons!
4. **Mixed cargo** - Use cargo wagons for variable loads

## Balance Notes

- The main numerical fix was in locomotives: late tiers now gain power faster than weight, so the branch finally delivers better heavy-load performance instead of just bigger numbers.
- Cargo and fluid wagons were audited and kept as the main source of train throughput.
- README values now reflect the actual prototype formulas and no longer reuse outdated placeholder weights or power values.
- Cross-review with Storage and Transport now gives late wagons a real infrastructure sink: cargo wagons consume stronger chest hardware, and fluid wagons consume stronger tank and pump hardware when those companion mods are installed.
- The Storage and Transport crossover is conditional, so Trains still works cleanly on its own while gaining tighter progression when the broader logistics stack is present.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_trains/
├── README.md
├── data.lua
├── data-updates.lua
├── info.json
├── locale/
├── prototypes/
│   ├── changes.lua
│   ├── gen-cargo-wagon.lua
│   ├── gen-fluid-wagon.lua
│   └── gen-locomotive.lua
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
