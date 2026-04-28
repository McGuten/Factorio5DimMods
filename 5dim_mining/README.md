# 5Dim's Mod - Mining

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.4-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Mining expands resource extraction capabilities with faster miners, pumpjacks, and even water extraction on land!

## Features

### ⛏️ Electric Mining Drills

| Tier | Mining Speed | Power | Module Slots |
|------|-------------|-------|--------------|
| T1 | 0.5/s | 90 kW | 0 |
| T2 | 0.75/s | 135 kW | 1 |
| T3 | 1.0/s | 180 kW | 2 |
| T4 | 1.5/s | 270 kW | 2 |
| T5 | 2.0/s | 360 kW | 3 |
| T6 | 2.5/s | 450 kW | 3 |
| T7 | 3.0/s | 540 kW | 4 |
| T8 | 4.0/s | 720 kW | 4 |
| T9 | 5.0/s | 900 kW | 5 |
| T10 | 6.0/s | 1.08 MW | 6 |

### 🛢️ Pumpjacks

| Tier | Pumping Speed | Power |
|------|--------------|-------|
| T1 | 1.0x | 90 kW |
| T5 | 2.5x | 225 kW |
| T10 | 5.0x | 450 kW |

### 💧 Water Pumpjacks

**Extract water anywhere on land!**

| Tier | Output | Power |
|------|--------|-------|
| T1 | 600/m | 90 kW |
| T5 | 1500/m | 225 kW |
| T10 | 3000/m | 450 kW |

*Perfect for deserts or inland bases without water access!*

### 🌊 Offshore Pumps

| Tier | Output |
|------|--------|
| T1 | 1200/m |
| T5 | 3000/m |
| T10 | 6000/m |

## Tips

1. **Module priority** - Put productivity modules in miners for more ore
2. **Water pumpjacks** - Use for Steam power in areas without water
3. **Upgrade timing** - Upgrade miners when ore patches deplete for sustained throughput

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
├── data.lua
├── info.json
├── prototypes/
│   ├── mining-drills/
│   ├── pumpjacks/
│   ├── water-pumpjacks/
│   └── offshore-pumps/
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
