-------------------------------------------------------------------------------
-- 5Dim's Core - Tier Tint
-- Aplica el color de tier (tier-colors) a las capas visibles del graphics_set
-- de una entidad, reutilizando el arte vanilla para diferenciar tiers.
--
-- Solucion de reserva: se usa cuando una entidad no tiene overlay de recolor
-- propio en [space-age/tier-art.lua]. Tinta el cuerpo principal de la maquina
-- vanilla con el color del tier. Se saltan las capas de sombra y de glow para
-- no ensuciar el resultado.
--
-- El recorrido del arbol de graphics vive en [graphics-tree.lua], compartido
-- con tier-art.lua.
-------------------------------------------------------------------------------

local tierColors = require("__5dim_core__.lib.tier-colors")
local graphicsTree = require("__5dim_core__.lib.graphics-tree")

-- Aplica el tinte del tier al cuerpo principal (graphics_set.animation) de una
-- entidad ya copiada del prototipo vanilla. tier es el numero de tier (1-10).
local function applyTierTint(entity, tier)
    if not entity or not entity.graphics_set then
        return
    end

    local tint = tierColors[tier]
    if not tint then
        return
    end

    graphicsTree.forEachLeaf(entity.graphics_set.animation, function(leaf)
        leaf.tint = tint
        leaf.tint_as_overlay = true
        leaf.apply_runtime_tint = false
    end)
end

return applyTierTint
