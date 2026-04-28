# 5Dim's Mod - Trains

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Trains expands the railway system with faster locomotives and higher-capacity wagons. Move more cargo faster!

## Features

### 🚂 Locomotives

| Tier | Max Speed | Power | Weight |
|------|-----------|-------|--------|
| T1 | 259 km/h | 600 kW | 2000 kg |
| T5 | 388 km/h | 1500 kW | 2000 kg |
| T10 | 518 km/h | 3000 kW | 2000 kg |

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

Higher tier locomotives are more fuel-efficient per cargo moved:

| Tier | Fuel per 1000 items/km |
|------|----------------------|
| T1 | 100% (baseline) |
| T5 | 60% |
| T10 | 30% |

## Tips

1. **Match tiers** - Use same tier locomotives and wagons for consistency
2. **Acceleration** - Higher tier locomotives accelerate faster
3. **Fluid transport** - T10 fluid wagons replace 5 T1 wagons!
4. **Mixed cargo** - Use cargo wagons for variable loads

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_trains/
├── data.lua
├── info.json
├── prototypes/
│   ├── locomotives/
│   ├── cargo-wagons/
│   └── fluid-wagons/
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
