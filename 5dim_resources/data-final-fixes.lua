
local function hasLimitationRecipe(limitations, recipe_name)
    local has_it = false
    if limitations and #limitations > 0 then
        for i, name in pairs(limitations) do
        if name == recipe_name then
            has_it = true
            break
        end
        end
    end
    return has_it
end

local function addProductivityLimitation(module, recipe_name)
    local has_it = false

    if module.limitation then
        has_it = hasLimitationRecipe(module.limitation, recipe_name)
      else
        module.limitation = {}
      end

      if not has_it then

        table.insert(module.limitation, recipe_name)

        if not module.limitation_message_key then
          module.limitation_message_key = "production-module-limitation"
        end
      end
end

local function checkModuleHasProductivity(module)
    if module.effect then
        for effect_name, effect in pairs(module.effect) do
          if effect_name == "productivity" and effect.bonus > 0 then
            return true
          end
        end
      end
      return false
end


if mods["5dim_resources"] then
    for _, module in pairs(data.raw.module) do
        if checkModuleHasProductivity(module) then
            addProductivityLimitation(module, '5d-iron-plate')
            addProductivityLimitation(module, '5d-iron-dust')
            addProductivityLimitation(module, '5d-copper-plate')
            addProductivityLimitation(module, '5d-copper-dust')
        end
    end
end