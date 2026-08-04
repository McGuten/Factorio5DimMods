# Space platform starter pack tiers plan

## Objetivo

Crear una familia 5Dim de `space-platform-starter-pack` por tiers centrada en dos mejoras visibles y faciles de entender:

- Plataforma inicial mas grande al lanzar el pack.
- Mas `space-platform-foundation` iniciales dentro de la plataforma creada.

La progresion debe sentirse como una mejora real para nuevas plataformas sin convertir el pack en un kit industrial completo, sin tocar el hub por ahora y sin cambiar la carga util global de los cohetes.

## Decision de diseno

- Mantener el starter pack vanilla como MK1.
- Generar MK2-MK10 en `5dim_space_age`, siguiendo el patron habitual de familias 5Dim de 10 tiers.
- Usar nombres de prototipo con dos digitos: `5d-space-platform-starter-pack-02` hasta `5d-space-platform-starter-pack-10`.
- Usar tecnologias encadenadas sin cero inicial: `5d-space-platform-starter-pack-2` hasta `5d-space-platform-starter-pack-10`.
- Cada receta debe exigir el pack anterior como primer ingrediente visible, igual que las familias upgrade acumulativas de 5Dim.
- Cada tier debe mantener `weight = 1 * tons` y `stack_size = 1` para que el pack siga siendo lanzable con el limite vanilla de Space Age.
- El beneficio debe estar en `tiles` e `initial_items`, no en abaratar lanzamientos, payload, hubs MK ni scripts runtime.

## Contexto tecnico

El prototipo `space-platform-starter-pack` permite estas palancas propias:

- `surface`: superficie destino, vanilla usa `space-platform`.
- `trigger`: efecto que crea el `space-platform-hub`.
- `tiles`: area inicial de `space-platform-foundation`.
- `initial_items`: items que aparecen en la plataforma creada; la calidad coincide con la calidad del pack.
- `create_electric_network`: vanilla lo tiene en `true`.

La definicion vanilla crea el hub, una zona 10x10 de foundation y 10 foundations extra. La receta vanilla cuesta 60 `space-platform-foundation`, 20 `steel-plate` y 20 `processing-unit`.

## Alcance

### Incluido

- Nuevos starter packs MK2-MK10.
- Nuevas recetas MK2-MK10.
- Nuevas tecnologias MK2-MK10.
- Iconos con badge de tier si no hay graficos dedicados.
- Locale del modulo y sincronizacion con `5dim_locale`.
- Ordenacion en `orbit-platform` junto a `space-platform-foundation` y el pack vanilla.

### Excluido por ahora

- Hubs MK o `space-platform-hub` mejorados.
- Kits iniciales con collectors, crushers, thrusters, energia o defensas.
- Cambios en `UtilityConstants::rocket_lift_weight`.
- Runtime para modificar plataformas existentes.
- Upgrade planner o `next_upgrade`; el item se lanza, no se coloca como entidad normal.

## Curva propuesta

La curva conserva una lectura simple: cada tier aumenta el lado del cuadrado inicial y la reserva de foundations. El valor importante no es solo el area inicial, sino el total practico de suelo disponible al crear la plataforma.

| Tier | Pack | Area inicial | Tiles iniciales | Foundations extra | Total practico |
| --- | --- | ---: | ---: | ---: | ---: |
| MK1 | `space-platform-starter-pack` | 10x10 | 100 | 10 | 110 |
| MK2 | `5d-space-platform-starter-pack-02` | 12x12 | 144 | 20 | 164 |
| MK3 | `5d-space-platform-starter-pack-03` | 14x14 | 196 | 35 | 231 |
| MK4 | `5d-space-platform-starter-pack-04` | 16x16 | 256 | 55 | 311 |
| MK5 | `5d-space-platform-starter-pack-05` | 18x18 | 324 | 80 | 404 |
| MK6 | `5d-space-platform-starter-pack-06` | 20x20 | 400 | 110 | 510 |
| MK7 | `5d-space-platform-starter-pack-07` | 22x22 | 484 | 145 | 629 |
| MK8 | `5d-space-platform-starter-pack-08` | 24x24 | 576 | 185 | 761 |
| MK9 | `5d-space-platform-starter-pack-09` | 26x26 | 676 | 230 | 906 |
| MK10 | `5d-space-platform-starter-pack-10` | 28x28 | 784 | 280 | 1064 |

Lectura de balance:

- MK2-MK4 reducen friccion para plataformas funcionales pequenas.
- MK5-MK7 empiezan a ahorrar muchos lanzamientos de foundations, pero ya deben pedir recursos Space Age visibles.
- MK8-MK10 son packs de megabase espacial; el coste debe ser claramente alto y no solo foundations baratas.

## Recetas objetivo

Crear `Templates.spacePlatformStarterPack` en `mods/5dim_core/lib/costs/templates/space-age.lua`.

Reglas:

- MK1 queda vanilla.
- MK2 usa `space-platform-starter-pack` como primer ingrediente.
- MK3-MK10 usan el pack 5Dim anterior como primer ingrediente.
- La receta visible debe incluir foundations adicionales en cada salto para que el beneficio tenga coste directo.
- Los deltas Space Age deben entrar de forma gradual y tematica: estructura orbital primero, luego control avanzado, y cierre Aquilo/fusion solo en tiers altos.
- Evitar fluidos de thruster como ingrediente inicial salvo decision explicita, porque convertirian el pack en una receta con manejo de fluidos y pueden complicar el lugar de fabricacion.

Matriz base sugerida:

| Tier | Ingrediente acumulativo | Delta principal | Delta Space Age recomendado |
| --- | --- | --- | --- |
| MK2 | vanilla starter pack | `space-platform-foundation`, `low-density-structure`, `processing-unit` | ninguno o `space-science-pack` bajo |
| MK3 | MK2 | mas foundations, `electric-engine-unit`, `accumulator` | `metallic-asteroid-chunk` bajo |
| MK4 | MK3 | mas foundations, control electronico vanilla avanzado | `oxide-asteroid-chunk` / `carbonic-asteroid-chunk` |
| MK5 | MK4 | foundations altas, estructura avanzada | `calcite`, `tungsten-plate` |
| MK6 | MK5 | foundations altas, control avanzado | `tungsten-carbide`, `holmium-plate` |
| MK7 | MK6 | foundations altas, electronica de precision | `supercapacitor` |
| MK8 | MK7 | foundations muy altas, orbital avanzado | `superconductor`, asteroid chunks altos |
| MK9 | MK8 | foundations muy altas, cierre frio | `lithium-plate` y, si hace falta mas peso, `fusion-power-cell` |
| MK10 | MK9 | foundations finales, control extremo | `fusion-power-cell`, `quantum-processor` |

Si se quiere mantener todas las recetas en categoria item-only, preferir `lithium-plate`, `fusion-power-cell` y `quantum-processor` frente a fluidos.

## Tecnologias objetivo

Crear una tecnologia por tier MK2-MK10, encadenada linealmente.

Patron recomendado:

| Tier | Prerrequisito funcional | Motivo |
| --- | --- | --- |
| MK2 | `space-science-pack` | El jugador ya creo una primera plataforma vanilla y empieza a producir ciencia espacial. |
| MK3 | MK2 | Consolidacion orbital temprana. |
| MK4 | `space-platform-thruster` + MK3 | Primera etapa donde una plataforma mayor ayuda a viajar. |
| MK5 | `metallurgic-science-pack` + MK4 | Entrada estructural de Vulcanus. |
| MK6 | `electromagnetic-science-pack` + MK5 | Control avanzado de Fulgora. |
| MK7 | MK6 | Escalon medio-alto sin forzar otro planeta artificial. |
| MK8 | MK7 | Orbital avanzado y coste alto. |
| MK9 | `cryogenic-science-pack` + MK8 | Cierre frio de Aquilo. |
| MK10 | MK9, y opcionalmente tecnologia final de fusion/promethium | Pack final de megabase espacial. |

Antes de implementar, confirmar los IDs exactos de tecnologias en `data.raw.technology` para evitar depender de nombres asumidos.

## Archivos a tocar

### `mods/5dim_space_age`

- Crear `prototypes/gen-space-platform-starter-pack.lua`.
- Anadir `require("prototypes.gen-space-platform-starter-pack")` en el bloque orbital de `data.lua`.
- Reutilizar el patron de generadores existentes: tablas por tier, `CostCalculator.processIngredients`, tecnologias por tier, `icons` con badge si procede.
- Definir cada pack con:
  - `type = "space-platform-starter-pack"`
  - `surface = "space-platform"`
  - `trigger` copiado del starter pack vanilla para crear `space-platform-hub`
  - `tiles = make_tile_area(...)` con el lado del tier
  - `initial_items = {{type = "item", name = "space-platform-foundation", amount = ...}}`
  - `create_electric_network = true`
  - `weight = 1 * tons`
  - `stack_size = 1`
  - `subgroup = "orbit-platform"`

### `mods/5dim_core`

- Anadir `Templates.spacePlatformStarterPack` en `lib/costs/templates/space-age.lua`.
- Revisar `prototypes/item-sort-changes.lua` solo si hace falta reforzar ordenacion del pack vanilla y de los nuevos tiers.

### Locales

- Actualizar locale base en ingles dentro del modulo origen.
- Sincronizar despues con:
  - `mods/5dim_locale/locale/en/space_age.cfg`
  - `mods/5dim_locale/locale/en.example/space_age.cfg`
- Anadir traducciones espanolas si se mantiene el estado actual del modulo.
- No usar `localised_name` ni `localised_description` inline en Lua.

## Detalles de implementacion

### Funcion para tiles

Usar una funcion local para crear cuadrados pares a partir del lado:

```lua
local function makeStarterTiles(side)
    local half = side / 2
    return make_tile_area({ { -half, -half }, { half - 1, half - 1 } }, "space-platform-foundation")
end
```

El resultado para side 10 reproduce vanilla: `{{-5, -5}, {4, 4}}`.

### Trigger

Copiar el trigger vanilla sin cambios salvo que mas adelante se decida crear hubs MK:

```lua
trigger = {
    {
        type = "direct",
        action_delivery = {
            type = "instant",
            source_effects = {
                { type = "create-entity", entity_name = "space-platform-hub" }
            }
        }
    }
}
```

### Iconos

- Si no existen iconos dedicados, usar el helper compartido de badge de tier de `5dim_core`.
- No duplicar badge si en el futuro se anaden iconos propios por tier.

### Orden

Mantener todos los packs en `orbit-platform`:

- `space-platform-foundation`: orden `a`.
- starter pack vanilla: orden `b`.
- starter packs 5Dim: orden `b-02`, `b-03`, etc., o equivalente que los deje juntos despues del vanilla.

## Riesgos y limites

- Cada pack crea mucha foundation virtual comparado con la receta vanilla. Por eso el coste acumulativo y la cantidad adicional de `space-platform-foundation` deben ser visibles.
- El pack solo afecta a plataformas nuevas. No mejora plataformas ya creadas.
- Mantener el peso en `1 * tons` evita romper el lanzamiento, pero tambien significa que la progresion no se expresa por peso del item.
- Si se usan fluidos como ingredientes, habra que revisar categoria de receta y lugar de fabricacion. La primera implementacion deberia evitarlos.
- Si MK10 llega a mas de 1000 foundations practicas, conviene probar que la creacion de la plataforma no produce errores de colocacion, rendimiento o UX.

## Validacion

- Cargar perfil con Space Age y Quality, porque `5dim_space_age` depende de ambos.
- Ejecutar validacion local del workspace si se implementa codigo:

```powershell
Set-Location "d:\factorioDev\mods"
.\validate-factorio-profiles.ps1 -TestSet Module -Profiles module-5dim_space_age -KeepArtifacts
```

- Validar que cada tecnologia desbloquea exactamente una receta nueva.
- Validar que cada pack crea el area esperada y deja la cantidad esperada de `space-platform-foundation` en el hub/plataforma.
- Validar que todos los packs pueden lanzarse con el limite vanilla de cohete.
- Ejecutar `validate-locales.ps1` tras tocar locales.

## Preguntas abiertas

1. Confirmar si la curva 10x10 -> 28x28 es suficiente o si MK10 debe llegar a 30x30.
2. Confirmar si MK10 debe exigir contenido final tipo promethium o quedarse en Aquilo/fusion para no cerrar demasiado tarde.
3. Confirmar si se aceptan asteroid chunks como coste de tiers medios, lo que exige haber usado una primera plataforma antes de mejorar los packs.
4. Confirmar si los packs deben tener iconos dedicados mas adelante o solo badge de tier compartido.

## Orden de trabajo recomendado

1. Confirmar curva final de area y foundations extra.
2. Crear template de costes en `5dim_core`.
3. Crear generador `gen-space-platform-starter-pack.lua` en `5dim_space_age`.
4. Anadir require en `data.lua`.
5. Anadir locale del modulo y sincronizar `5dim_locale`.
6. Revisar ordenacion en `orbit-platform`.
7. Validar carga con Space Age + Quality.
8. Ajustar cantidades si el coste por foundation queda demasiado bajo frente al ahorro de lanzamientos.