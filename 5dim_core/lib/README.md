# 5dim_core/lib — Architecture Reference

This folder contains the **shared library** used by every `5dim_*` mod for prototype
generation, cost balancing, and template lookups. Everything here is intentionally
**data-stage** Lua: it runs during `data.lua` / `data-updates.lua` and produces
prototypes via `data:extend({...})`.

> Loaded into the global Lua environment by `5dim_core/data.lua` (see
> `prototypes/changes.lua` and friends), so consuming mods reach these helpers
> through `require("__5dim_core__.lib.<path>")`.

---

## 1. Folder layout

```
lib/
  tier-colors.lua                 ← Tier 1-10 RGB palette (single source of truth)
  recipe-templates.lua            ← Aggregator: re-exports every cost template module
  costs/
    config.lua                    ← Settings + Space Age toggles + scaling formulas
    calculator.lua                ← Functions that build/scale ingredients & tech packs
    templates/
      base.lua                    ← Common materials, science pack vectors, baseTechCounts
      mining.lua / automation.lua / logistic.lua / transport.lua /
      energy.lua / trains.lua / battlefield.lua / resources.lua /
      storage.lua / nuclear.lua / equipment.lua / module.lua /
      space-age.lua               ← Tier ingredient maps for each entity family
  <domain>/                       ← (automation, battlefield, energy, equipment,
                                    logistic, mining, module, nuclear, resources,
                                    space-age, storage, trains, transport, vehicles,
                                    enemies)
    generation-<entity>.lua       ← Defines a global gen<Entity>(inputs) function
```

Each `lib/<domain>/generation-*.lua` file follows the same convention: it declares
**one or more global generator functions** that callers (mods under `5dim_*`)
invoke with a `inputs` table to produce a full tier of prototypes (item + recipe +
entity + technology).

---

## 2. Generator convention: `gen<Entity>(inputs)`

All `generation-*.lua` files expose a **global function** named `gen<Entity>` that
takes a single `inputs` table. The shape of `inputs` varies per generator, but the
shared keys are:

| Key                  | Type    | Description                                                                 |
|----------------------|---------|-----------------------------------------------------------------------------|
| `copy`               | table   | `{ name = { preName, postName }, tech = "<base-tech-name>" }` — base prototype to clone and rename |
| `number`             | string  | Two-digit tier label (`"01"` … `"10"`)                                       |
| `order`              | string  | Subgroup ordering string (e.g. `"a-a"`)                                      |
| `new`                | boolean | If true, register a brand-new prototype name (e.g. `5d-transport-belt-04`); if false, reuse vanilla name |
| `nextUpdate`         | table   | Map of prototype names → next-tier name for `next_upgrade` chains            |
| `ingredients`        | table   | Recipe ingredient list (already scaled if obtained via `CostCalculator`)    |
| `tech`               | table   | Technology config: `{ prerequisites, packs, count, time }`                  |
| `liquids`            | boolean | If true, recipe requires fluid (`crafting-with-fluid` / SA metallurgy)      |
| Domain-specific keys | varies  | e.g. `speed` (belts), `scan`/`reveal` (radar), `power`/`energy` (machines)  |

The generator usually:
1. `table.deepcopy` the base prototype identified by `copy.*`.
2. Rename it with `preName .. "<entity>" .. postName` (or `5d-<entity>-<NN>`).
3. Apply tier-specific stats (speed, energy, area …).
4. Wire icons (`__5dim_<domain>__/graphics/icon/...`).
5. Wire technology unlock and prerequisites.
6. Push the result via `data:extend({ item, recipe, entity, tech })`.

### Caller pattern (example from `5dim_transport`)

```lua
for tier = 1, 10 do
    local config  = getTierConfig(tier)
    local tierNum = string.format("%02d", tier)

    genTransportBelts {
        copy        = config.copy,
        name        = config.name,
        speed       = config.speed,
        new         = config.new,
        liquids     = config.liquids,
        number      = tierNum,
        nextUpdate  = getNextUpdate(tier),
        order       = config.order,
        ingredients = getIngredients(tier),
        tech        = getTech(tier),
    }
end
```

> The mod owns the **tier configuration** (which vanilla prototype to copy,
> ingredient scaling, prerequisite chain), and `5dim_core/lib` owns **how that
> configuration becomes a prototype**.

---

## 3. Cost API

### 3.1 `CostConfig` — `lib/costs/config.lua`

User-tunable settings + Space Age integration toggles + scaling curves.

| Member                                   | Description |
|------------------------------------------|-------------|
| `CostConfig.hasSpaceAge`                 | `mods["space-age"] ~= nil` (computed once) |
| `CostConfig.spaceAgeMaterials_enabled`   | Setting `5d-space-age-materials` |
| `CostConfig.spaceAgeSciencePacks_enabled`| Setting `5d-space-age-science-packs` |
| `CostConfig.techMultiplier`              | Setting `5d-tech-cost-multiplier` |
| `CostConfig.recipeMultiplier`            | Setting `5d-recipe-cost-multiplier` |
| `CostConfig.craftingTimeMultiplier`      | Setting `5d-crafting-time-multiplier` |
| `CostConfig.spaceAgeMaterials[tier]`     | `{ material, amount }` per tier 5-10 (Vulcanus → Aquilo) |
| `CostConfig.spaceAgeMaterialsBulk[tier]` | Same as above with smaller amounts (robots/ammo) |
| `CostConfig.spaceAgeSciencePacks[tier]`  | `{ {pack, 1} }` per tier 5-10 (metallurgic / electromagnetic / cryogenic) |
| `CostConfig.getTierMultiplier(tier)`     | `1.0 + (tier-1)*0.2 + ((tier-1)/10)^2` (T1 = 1×, T5 ≈ 2×, T10 ≈ 4×) |
| `CostConfig.getTechCountMultiplier(tier)`| `tier * (1 + tier/20)` (quadratic) |
| `CostConfig.shouldUseSpaceAgeMaterials()`| `hasSpaceAge AND spaceAgeMaterials_enabled` |
| `CostConfig.shouldUseSpaceAgeSciencePacks()`| `hasSpaceAge AND spaceAgeSciencePacks_enabled` |

### 3.2 `CostCalculator` — `lib/costs/calculator.lua`

| Function                                                          | Returns |
|-------------------------------------------------------------------|---------|
| `scaleIngredientAmount(baseAmount, tier, isBulk)`                 | `math.ceil` scaled amount |
| `scaleIngredients(ingredients, tier, isBulk)`                     | New ingredient table |
| `addSpaceAgeMaterials(ingredients, tier, isBulk)`                 | Ingredients + planetary material (if SA enabled) |
| `processIngredients(baseIngredients, tier, options)`              | One-shot: scale + add SA material. `options = { isBulkItem, skipTierScaling, skipSpaceAgeMaterials }` |
| `getTechPacks(basePacks, tier, options)`                          | Base packs + `spaceAgeSciencePacks[tier]` (when applicable) |

### 3.3 `RecipeTemplates` — `lib/recipe-templates.lua`

A flat aggregate of every per-domain template module. Most useful members:

- `RecipeTemplates.baseTechCounts[entityKey]` — central table of starting tech counts
  (e.g. `assemblingMachine = 150`, `nuclearReactor = 500`). **Use this instead of
  hard-coding tech counts.**
- Per-entity tier ingredient maps (e.g. `RecipeTemplates.miningDrillIngredients[tier]`),
  see each `templates/<domain>.lua` for the exact shape.

```lua
local RecipeTemplates = require("__5dim_core__.lib.recipe-templates")
local count = RecipeTemplates.baseTechCounts.assemblingMachine -- 150
```

---

## 4. Tier color palette

`lib/tier-colors.lua` returns a `tier → {r,g,b,a}` table with the canonical
5Dim palette (T1 yellow, T2 red, T3 cyan, T4 pink, T5 green, T6 brown,
T7 purple, T8 white, T9 orange, T10 blue). Use this for any tier-tinted
icon overlay or chart color so changes propagate everywhere.

```lua
local tierColors = require("__5dim_core__.lib.tier-colors")
local c = tierColors[5]   -- green
```

---

## 5. Conventions for new generation files

When adding a new `lib/<domain>/generation-<entity>.lua`:

1. **Expose one global** `gen<Entity>(inputs)` function (no module table).
2. Accept the standard `inputs` keys above; add domain-specific keys as needed.
3. Read tier scaling from `CostConfig` / `CostCalculator`, never hard-code
   multipliers in the generator itself.
4. Read tech counts from `RecipeTemplates.baseTechCounts` when there is a
   suitable entry; add a new entry to `templates/<domain>.lua` otherwise.
5. **Do not** set `localised_name` / `localised_description` inline. Names live in
   the mod's `locale/en/*.cfg` (see [.github/instructions/5dim-locales.instructions.md](../../../.github/instructions/5dim-locales.instructions.md)).
   The only legitimate inline assignment is `prototype.localised_* = nil` to force
   a fresh locale lookup after a `table.deepcopy`.
6. Hook into `data.lua` / `data-updates.lua` of the calling mod via `require`.
   Generators must produce prototypes synchronously (no `on_init` / runtime hooks).

---

## 6. Related references

- [mods/README.md](../../README.md) — module list, external dependencies.
- [.github/copilot-instructions.md](../../../.github/copilot-instructions.md) — repo-wide rules.
- [.github/instructions/5dim-locales.instructions.md](../../../.github/instructions/5dim-locales.instructions.md) — locale workflow.
- [doc-html/index-prototype.html](../../../doc-html/index-prototype.html) — local Factorio prototype API.
- [doc-html/index-runtime.html](../../../doc-html/index-runtime.html) — local Factorio runtime API.
