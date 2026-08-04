-------------------------------------------------------------------------------
-- 5Dim's Core - Graphics Tree
-- Recorrido compartido del arbol de graphics de una entidad vanilla.
--
-- Cada tipo de entidad coloca su arte en un sitio distinto: graphics_set.animation
-- (biochamber, foundry), graphics_set.animation.<direccion> (crusher),
-- graphics_set.working_visualisations[N].animation (electromagnetic-plant),
-- graphics_set.<direccion>_graphics_set.animation (fusion-generator),
-- graphics_set.structure (fusion-reactor), on_animation / off_animation (biolab),
-- chargable_graphics.picture (lightning-collector)... Enumerar todas las formas
-- es fragil, asi que el recorrido es generico: baja por cualquier tabla y entrega
-- las hojas concretas (filename / filenames / stripes).
--
-- Se saltan los subarboles marcados como sombra, glow o mezcla aditiva, que no
-- deben tintarse ni recolorearse.
--
-- Lo usan [tier-tint.lua] (tinte de reserva sobre arte vanilla) y
-- [space-age/tier-art.lua] (overlay de recolor por tier).
-------------------------------------------------------------------------------

local function isLeaf(node)
    return node.filename ~= nil or node.filenames ~= nil or node.stripes ~= nil
end

local function isDrawnAsEffect(node)
    return node.draw_as_shadow or node.draw_as_glow or node.blend_mode == "additive"
end

-- Recorre `node` y llama a callback(leaf, layers, index) por cada hoja visible.
-- `layers` e `index` solo vienen informados cuando la hoja vive dentro de un
-- array `layers`, que es lo que permite insertar una capa hermana justo detras.
--
-- `seen` evita recorrer dos veces la misma tabla: deepcopy conserva las tablas
-- compartidas, y por ejemplo crusher referencia el mismo sprite desde north y
-- south. Visitarla una sola vez hace que el cambio valga para ambas.
local function forEachLeaf(node, callback, layers, index, seen)
    if type(node) ~= "table" then
        return
    end

    seen = seen or {}
    if seen[node] then
        return
    end
    seen[node] = true

    if isDrawnAsEffect(node) then
        return
    end

    if isLeaf(node) then
        callback(node, layers, index)
        return
    end

    -- Contenedor de capas: se recorre sobre el conteo inicial para que el
    -- callback pueda insertar capas sin afectar a la iteracion.
    if node.layers then
        local count = #node.layers
        for i = 1, count do
            forEachLeaf(node.layers[i], callback, node.layers, i, seen)
        end
        return
    end

    for _, value in pairs(node) do
        if type(value) == "table" then
            forEachLeaf(value, callback, nil, nil, seen)
        end
    end
end

return {
    forEachLeaf = forEachLeaf,
}
