# 5Dim's Mod - Logistic

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.3-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Logistic enhances the logistics network with upgraded robots and roboports. The current balance keeps the three infrastructure branches synchronized without making early network upgrades excessively expensive.

## Features

### 🤖 Construction Robots

| Tier | Speed | Cargo | Max Energy |
|------|-------|-------|------------|
| T1 | 3.6 m/s | 1 | 1.5 MJ |
| T5 | 10.8 m/s | 1 | 4.5 MJ |
| T10 | 19.8 m/s | 1 | 8.25 MJ |

### 📦 Logistic Robots

| Tier | Speed | Cargo | Max Energy |
|------|-------|-------|------------|
| T1 | 3.0 m/s | 1 | 1.5 MJ |
| T5 | 9.0 m/s | 1 | 4.5 MJ |
| T10 | 16.5 m/s | 1 | 8.25 MJ |

### 🏗️ Roboports

| Tier | Robot Slots | Charging Slots | Logistic Radius | Construction Radius | Buffer | Input Flow |
|------|-------------|----------------|-----------------|---------------------|--------|------------|
| T1 | 7 | 4 | 25 | 55 | 100 MJ | 100 MW |
| T5 | 35 | 16 | 57 | 123 | 300 MJ | 300 MW |
| T10 | 70 | 31 | 97 | 208 | 550 MJ | 550 MW |

## Tips

1. **Upgrade as a network** - Robot tiers and roboport tiers are designed to progress together, so partial upgrades give less value than coordinated ones.
2. **Construction outruns hauling** - Construction robots scale slightly faster than logistic robots, which fits burst building better than steady hauling.
3. **Coverage stays meaningful** - High-tier roboports cover much more area, but they no longer trivialize the network footprint.
4. **Cargo does not scale** - Throughput gains come from speed, energy headroom and network coverage, not from larger per-trip payloads.

## Balance Notes

- Research pacing was eased for construction robots, logistic robots and roboports so infrastructure upgrades stop lagging behind the rest of the factory.
- The three branches still depend on one another tier by tier, which preserves bundle progression across the logistics network.
- Roboport coverage remains strong late game, but the range curve stays below the old runaway values.
- Cross-review with Energy exposed a broken roboport energy curve: buffer capacity had fallen below recharge_minimum. Roboports now keep enough internal buffer to actually sustain the faster robot branch instead of stalling their own charging logic.

## Cross-Module Notes

- Logistic did not need more robot speed or more coverage in this pass; the real mismatch was the roboport energy buffer.
- Higher-tier roboports are still meaningful electrical loads, but they now behave like burst logistics infrastructure rather than like permanently energy-starved shells.

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Related Modules

- `5dim_storage` - Adds tiered logistic chests when both mods are installed

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu

## File Structure

```
5dim_logistic/
├── README.md
├── data.lua
├── info.json
├── locale/
├── prototypes/
│   ├── changes.lua
│   ├── gen-construction-robot.lua
│   ├── gen-logistic-robot.lua
│   └── gen-roboport.lua
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
