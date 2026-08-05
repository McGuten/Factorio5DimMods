-------------------------------------------------------------------------------
-- 5Dim's Core - Space Age Tier Art
-- Anade el overlay de recolor de un tier sobre el arte vanilla de la entidad.
--
-- El arte por tier de 5dim_space_age es el arte vanilla con una region concreta
-- recoloreada. En vez de enviar diez copias completas de cada spritesheet
-- (~994 MB, muy por encima del limite de 262 MB del portal), se envia solo la
-- region recoloreada y se apoya en el sprite vanilla, que Factorio ya tiene
-- cargado:
--
--     capa 1 = el sprite vanilla, intacto        -> 0 bytes enviados
--     capa 2 = la region recoloreada del tier N  -> lo unico que se envia
--
-- La capa 2 es una copia de la capa vanilla con las rutas cambiadas, asi que
-- hereda width, height, line_length, frame_count, shift, scale y repeat_count.
-- No se inventa geometria en ningun momento.
--
-- Los overlays y el manifiesto los genera mods/scripts/extract-tier-overlays.py.
-- Si una entidad no esta en el manifiesto se cae a [tier-tint.lua].
-------------------------------------------------------------------------------

local applyTierTint = require("__5dim_core__.lib.tier-tint")
local graphicsTree = require("__5dim_core__.lib.graphics-tree")

-- El manifiesto vive en 5dim_space_age, que depende de core y no al reves. Se
-- carga de forma perezosa y tolerante: si no esta, se usa el tinte de reserva.
local manifestCache = nil

local function getManifest()
    if manifestCache ~= nil then
        return manifestCache or nil
    end

    local ok, result = pcall(require, "__5dim_space_age__.graphics.tier-overlay.manifest")
    manifestCache = ok and type(result) == "table" and result or false

    return manifestCache or nil
end

-- Identidad de una hoja de sprite: lo que el manifiesto usa como `match`.
local function leafFilename(leaf)
    if leaf.filename then
        return leaf.filename
    end
    if leaf.filenames then
        return leaf.filenames[1]
    end
    return nil
end

-- Construye la capa de overlay a partir de la capa vanilla que va debajo.
local function buildOverlay(leaf, entry, tier)
    local overlay = table.deepcopy(leaf)
    local suffix = string.format("%02d.png", tier)

    if #entry.overlays > 1 then
        local names = {}
        for index, prefix in ipairs(entry.overlays) do
            names[index] = prefix .. suffix
        end
        overlay.filenames = names
        overlay.filename = nil
    else
        overlay.filename = entry.overlays[1] .. suffix
        overlay.filenames = nil
    end

    -- El overlay es color plano encima del cuerpo: no es sombra, ni glow, ni
    -- lleva tinte propio. Si la capa vanilla traia algo de eso, se limpia.
    overlay.draw_as_shadow = nil
    overlay.draw_as_glow = nil
    overlay.draw_as_light = nil
    overlay.tint = nil
    overlay.tint_as_overlay = nil
    overlay.apply_runtime_tint = nil

    return overlay
end

-- ¿Es esta hoja un overlay nuestro, de una pasada anterior?
local function isOverlayLeaf(leaf, entries)
    local filename = leaf.filename or (leaf.filenames and leaf.filenames[1])
    if not filename then
        return false
    end

    for _, entry in ipairs(entries) do
        for _, prefix in ipairs(entry.overlays) do
            if filename:sub(1, #prefix) == prefix then
                return true
            end
        end
    end

    return false
end

-- Quita overlays heredados. Los generadores copian con deepcopy desde
-- data.raw, y el tier 1 sobrescribe ahi el prototipo vanilla, asi que del tier
-- 2 en adelante la copia ya trae el overlay del tier 1 pegado. Sin esta pasada
-- cada tier acumularia la capa de todos los anteriores.
local function stripInheritedOverlays(root, entries)
    ---@type { layers: table, index: integer }[]
    local stale = {}

    graphicsTree.forEachLeaf(root, function(leaf, layers, index)
        if layers and index and isOverlayLeaf(leaf, entries) then
            table.insert(stale, { layers = layers, index = index })
        end
    end)

    for i = #stale, 1, -1 do
        table.remove(stale[i].layers, stale[i].index)
    end

    return #stale
end

-- Aplica el overlay del tier al arte de `entity`, que debe venir ya copiada del
-- prototipo vanilla. `entityKey` es la clave del manifiesto (p.ej. "foundry").
-- Devuelve cuantas capas se anadieron; 0 significa que se uso el tinte.
local function applyTierArt(entity, entityKey, tier)
    if not entity or not entityKey or not tier then
        return 0
    end

    local manifest = getManifest()
    local entries = manifest and manifest[entityKey]

    if not entries then
        -- Sin overlay disponible: tinte interino. El tier 1 tambien se tinta (de
        -- amarillo), igual que lleva su overlay amarillo en la rama de arriba.
        -- Que el tier 1 conserve el nombre del prototipo vanilla no lo exime:
        -- sigue siendo el primer tier de la familia y tiene que leerse como tal.
        applyTierTint(entity, tier)
        return 0
    end

    local added = 0

    -- El recorrido es generico sobre toda la entidad: cada tipo coloca su arte
    -- en un sitio distinto y solo se tocan las hojas que el manifiesto nombra.
    stripInheritedOverlays(entity, entries)

    -- Se recogen primero y se insertan despues: insertar durante el recorrido
    -- desplazaria los indices del array `layers`.
    ---@type { leaf: table, layers: table?, index: integer?, entry: table }[]
    local pending = {}

    graphicsTree.forEachLeaf(entity, function(leaf, layers, index)
        local filename = leafFilename(leaf)
        if not filename then
            return
        end

        for _, entry in ipairs(entries) do
            if entry.match == filename then
                table.insert(pending, {
                    leaf = leaf,
                    layers = layers,
                    index = index,
                    entry = entry,
                })
                break
            end
        end
    end)

    -- De atras hacia delante, para que los indices ya recogidos sigan siendo
    -- validos mientras se insertan las capas.
    for i = #pending, 1, -1 do
        local hit = pending[i]
        local overlay = buildOverlay(hit.leaf, hit.entry, tier)

        if hit.layers and hit.index then
            table.insert(hit.layers, hit.index + 1, overlay)
        else
            -- La hoja no vive en un array `layers`: se envuelve en uno.
            local base = table.deepcopy(hit.leaf)
            for key in pairs(hit.leaf) do
                hit.leaf[key] = nil
            end
            hit.leaf.layers = { base, overlay }
        end

        added = added + 1
    end

    return added
end

return applyTierArt
