# Graphics Requirements for 5dim_storage Chest Expansion

This document lists all the graphic files needed for the chest expansion.

## Steel Chests

### Icons (64x64 PNG)
Location: `graphics/icon/steel-chest/`
- `steel-chest-icon-01.png` through `steel-chest-icon-10.png`
- `steel-chest-tech-01.png` through `steel-chest-tech-10.png` (256x256 for technology)

### Entities (64x80 PNG, same format as vanilla steel-chest)
Location: `graphics/entities/steel-chest/`
- `steel-chest-01.png` through `steel-chest-10.png`

## Logistic Chests (only needed if 5dim_logistic is installed)

### Icons (64x64 PNG)
Location: `graphics/icon/logistic-chest/`

For each type (passive-provider, active-provider, storage, buffer, requester):
- `{type}-chest-icon-01.png` through `{type}-chest-icon-10.png`
- `{type}-chest-tech-01.png` through `{type}-chest-tech-10.png` (256x256 for technology)

Example files:
- `passive-provider-chest-icon-02.png`
- `active-provider-chest-icon-03.png`
- `storage-chest-icon-04.png`
- `buffer-chest-icon-05.png`
- `requester-chest-icon-06.png`

### Entities (66x74 PNG, 7 frames animation, same format as vanilla logistic chests)
Location: `graphics/entities/logistic-chest/`

For each type:
- `{type}-chest-01.png` through `{type}-chest-10.png`

## Color Coding Suggestions

### Steel Chests
Use progressively more advanced/futuristic looking textures with tier numbers or color gradients:
- Tiers 1-3: Basic steel appearance
- Tiers 4-6: Enhanced with circuit elements
- Tiers 7-10: Advanced with processing unit elements

### Logistic Chests
Maintain the vanilla color scheme for each type but add tier indicators:
- Passive Provider: Yellow/orange tones
- Active Provider: Purple tones
- Storage: Yellow tones
- Buffer: Green tones
- Requester: Blue tones
