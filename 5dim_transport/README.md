# 5Dim's Mod - Transport

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.22-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

> ⚠️ **Requires**: Bob's Inserters mod

## Overview

5Dim's Transport expands item transportation with faster belts, longer underground belts, and more capable inserters. The ultimate logistics expansion!

## Features

### 🛤️ Transport Belts

| Tier | Speed | Items/s |
|------|-------|---------|
| T1 | 15 | 7.5 |
| T2 | 30 | 15 |
| T3 | 45 | 22.5 |
| T4 | 60 | 30 |
| T5 | 75 | 37.5 |
| T6 | 90 | 45 |
| T7 | 105 | 52.5 |
| T8 | 120 | 60 |
| T9 | 135 | 67.5 |
| T10 | 150 | 75 |

### 🕳️ Underground Belts

Three range variants for each tier:

| Variant | Range |
|---------|-------|
| **Standard** | 4-10 tiles |
| **Extended (x30)** | 30 tiles |
| **Long (x50)** | 50 tiles |

### 🔀 Splitters

| Tier | Speed | Special |
|------|-------|---------|
| T1-T10 | Matches belt | Filter capability |

### 📥 Loaders

10 tiers of belt loaders:

| Tier | Speed | Matches Belt |
|------|-------|--------------|
| T1-T10 | Variable | Yes |

### 🤖 Inserters (Requires Bob's Inserters)

10 tiers of each inserter type:

| Type | Description |
|------|-------------|
| **Standard** | Basic item movement |
| **Filter** | Filtered item selection |
| **Stack** | Moves multiple items |
| **Stack Filter** | Stack with filtering |

| Tier | Stack Size (Regular) | Stack Size (Stack) |
|------|---------------------|-------------------|
| T1 | 1 | 2 |
| T5 | 3 | 6 |
| T10 | 6 | 12 |

### 💧 Pumps

| Tier | Flow Rate |
|------|----------|
| T1 | 200/s |
| T2 | 400/s |
| T3 | 600/s |
| T4 | 800/s |
| T5 | 1000/s |
| T6 | 1200/s |
| T7 | 1400/s |
| T8 | 1600/s |
| T9 | 1800/s |
| T10 | 2000/s |

### 🔧 Underground Pipes

Extended underground pipe variants:

| Variant | Range |
|---------|-------|
| **Standard** | 10 tiles |
| **Extended (x30)** | 30 tiles |
| **Long (x50)** | 50 tiles |

## Belt Throughput Reference

| Lanes | T1 | T5 | T10 |
|-------|-----|-----|------|
| 1 lane | 7.5/s | 37.5/s | 75/s |
| 2 lanes | 15/s | 75/s | 150/s |

## Tips

1. **Match belt tiers** - Use same tier underground and splitters
2. **Extended underground** - Save resources on long runs
3. **Stack inserters** - Essential for high-throughput builds
4. **Loader efficiency** - Loaders fill belts perfectly without gaps

## Dependencies

- **Required**: `5dim_core >= 2.0.42`
- **Required**: `bobinserters >= 1.3.2` (Bob's Inserters)
- **Optional**: `space-age >= 2.0.0`

## Installation

1. Install `5dim_core` first
2. Install `bobinserters` (Bob's Inserters)
3. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
4. Enable in the mod menu

## File Structure

```
5dim_transport/
├── data.lua
├── info.json
├── prototypes/
│   ├── transport-belts/
│   ├── underground-belts/
│   ├── splitters/
│   ├── loaders/
│   ├── inserters/
│   ├── pumps/
│   └── underground-pipes/
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
