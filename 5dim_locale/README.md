# 5Dim's Mod - Locale

![Factorio 2.0](https://img.shields.io/badge/Factorio-2.0-orange)
![Version](https://img.shields.io/badge/Version-2.0.2-blue)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](../LICENSE)

## Overview

5Dim's Locale provides translations for all 5Dim's modules in 28+ languages. Play in your native language!

## Supported Languages

| Language | Code | Status |
|----------|------|--------|
| 🇬🇧 English | en | ✅ Complete |
| 🇪🇸 Spanish | es | ✅ Complete |
| 🇩🇪 German | de | ✅ Complete |
| 🇫🇷 French | fr | ✅ Complete |
| 🇮🇹 Italian | it | ✅ Complete |
| 🇵🇹 Portuguese | pt | ✅ Complete |
| 🇷🇺 Russian | ru | ✅ Complete |
| 🇨🇳 Chinese | zh-CN | ✅ Complete |
| 🇯🇵 Japanese | ja | ✅ Complete |
| 🇰🇷 Korean | ko | ✅ Complete |
| 🇵🇱 Polish | pl | ✅ Complete |
| 🇳🇱 Dutch | nl | ✅ Complete |
| 🇸🇪 Swedish | sv | ✅ Complete |
| 🇳🇴 Norwegian | no | ✅ Complete |
| 🇩🇰 Danish | da | ✅ Complete |
| 🇫🇮 Finnish | fi | ✅ Complete |
| 🇨🇿 Czech | cs | ✅ Complete |
| 🇭🇺 Hungarian | hu | ✅ Complete |
| 🇷🇴 Romanian | ro | ✅ Complete |
| 🇹🇷 Turkish | tr | ✅ Complete |
| 🇺🇦 Ukrainian | uk | ✅ Complete |
| 🇬🇷 Greek | el | ✅ Complete |
| 🇮🇱 Hebrew | he | ✅ Complete |
| 🇸🇦 Arabic | ar | ✅ Complete |
| 🇻🇳 Vietnamese | vi | ✅ Complete |
| 🇿🇦 Afrikaans | af | ✅ Complete |
| 🇪🇸 Catalan | ca | ✅ Complete |
| 🇷🇸 Serbian | sr | ✅ Complete |

## Contributing Translations

### Via Crowdin (Recommended)

1. Visit our [Crowdin Project](https://crowdin.com/project/5dims-mod)
2. Select your language
3. Translate strings
4. Translations are automatically synced

### Via Pull Request

1. Copy `locale/en/locale.cfg` as template
2. Create `locale/[your-language-code]/locale.cfg`
3. Translate all strings
4. Submit a Pull Request

### Translation Guidelines

- Keep `[placeholders]` unchanged
- Preserve `\n` line breaks
- Match original string length when possible
- Test in-game after translating

## File Structure

```
5dim_locale/
├── info.json
├── crowdin.yml
└── locale/
    ├── en/
    │   └── locale.cfg
    ├── es/
    │   └── locale.cfg
    ├── de/
    │   └── locale.cfg
    ├── fr/
    │   └── locale.cfg
    └── ... (28+ languages)
```

## Dependencies

- **Required**: `5dim_core >= 2.0.42`

## Installation

1. Install `5dim_core` first
2. Download from [Factorio Mod Portal](https://mods.factorio.com/user/McGuten)
3. Enable in the mod menu
4. Game language auto-detected

## Contributing

- **Translations**: [Crowdin](https://crowdin.com/project/5dims-mod)
- **Issues**: https://github.com/McGuten/Factorio5DimMods/issues
- **Mod Portal**: https://mods.factorio.com/user/McGuten

## License

See [LICENSE](../LICENSE) for details.

---

*Part of the [5Dim's Mod](https://mods.factorio.com/user/McGuten) collection for Factorio*
