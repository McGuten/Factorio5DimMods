# Gleba preservation without runtime plan

## Objetivo

Guardar una propuesta de diseno para reducir la friccion de la podredumbre de
Gleba sin depender de `control.lua` ni de logica runtime. La intencion es dar al
jugador una solucion cara, progresiva y muy 5Dim, pero implementada solo con
prototipos: items, recetas, tecnologias y maquinas.

La idea preferida es estabilizar productos biologicos y despues permitir
desestabilizarlos cuando se necesiten en la cadena normal. Esto evita escanear
inventarios, cintas o superficies y mantiene el comportamiento base de Space Age
fuera de las recetas nuevas.

## Contexto

- La podredumbre real de Factorio vive en stacks runtime. Un edificio que pause
  items dentro de su inventario o en todo Gleba necesita script runtime para
  tocar `spoil_tick`.
- Sin runtime no se puede tener un cofre, congelador o estabilizador pasivo que
  modifique stacks ya existentes.
- Si se quiere evitar runtime, la solucion debe ser productiva: convertir items
  perecederos en variantes estabilizadas mediante recetas, y opcionalmente
  convertirlas de vuelta a su forma normal.
- Factorio Space Age ya aporta campos utiles en prototipos:
  - `ItemPrototype::spoil_ticks`
  - `ItemPrototype::spoil_result`
  - `RecipePrototype::reset_freshness_on_craft`
  - `RecipePrototype::result_is_always_fresh`
  - `ProductPrototype::percent_spoiled`
  - `RecipePrototype::preserve_products_in_machine_output`

## Decision De Diseno Preferida

Usar una familia de maquinas MK1-MK10 llamada provisionalmente `bio-stabilizer` o
`biological-stabilizer`. La maquina no conserva inventarios. Fabrica recetas de
estabilizacion y desestabilizacion.

Flujo principal:

1. Item perecedero normal entra en el estabilizador.
2. El estabilizador consume un agente de preservacion caro.
3. Sale una version estabilizada con mucha mas duracion, o sin podredumbre en el
   cierre MK10.
4. Cerca del consumo final, una receta de desestabilizacion devuelve el item
   normal.

Mi opinion: la desestabilizacion debe ser la ruta principal. Es mas mantenible
que crear duplicados de todas las recetas de Gleba que acepten versiones
estabilizadas. Las recetas directas con items estabilizados pueden existir, pero
solo para cadenas concretas donde aporten mucho valor.

## Por Que Esta Opcion Es Mejor Sin Runtime

- No hay escaneos por tick.
- No hay listas runtime de entidades.
- No hay casos raros con cintas, insertores, robots, jugadores o trenes.
- El coste se expresa con recetas, ingredientes, energia de crafteo y tecnologia.
- La compatibilidad es mas clara: los items vanilla siguen siendo vanilla.
- El jugador decide que estabilizar, cuando desestabilizarlo y donde montar la
  logistica.

## Modelo De Items

### Item normal

El item original de Space Age no se modifica por defecto. Mantiene su
`spoil_ticks`, `spoil_result` y comportamiento vanilla.

Ejemplos:

- `yumako`
- `jellynut`
- `bioflux`
- `nutrients`
- `agricultural-science-pack`
- `pentapod-egg`

### Item estabilizado

Variante nueva con duracion ampliada. Puede tener `spoil_ticks` alto y el mismo
`spoil_result`, o puede degradar a una version menos util.

Ejemplos de nombres provisionales:

- `5d-stabilized-yumako`
- `5d-stabilized-jellynut`
- `5d-stabilized-bioflux`
- `5d-stabilized-nutrients`
- `5d-stabilized-agricultural-science-pack`

### Item criopreservado MK10

Variante final sin `spoil_ticks`. Es la recompensa tardia: no detiene la
podredumbre de todo Gleba, pero permite almacenar y transportar recursos clave
sin presion de tiempo mientras sigan sellados.

Ejemplos:

- `5d-cryo-stabilized-yumako`
- `5d-cryo-stabilized-bioflux`
- `5d-cryo-stabilized-agricultural-science-pack`

## Modelo De Recetas

### Estabilizar

Convierte perecederos normales en variantes estabilizadas.

Ejemplo conceptual:

```lua
{
    type = "recipe",
    name = "5d-stabilize-yumako",
    category = "5d-bio-stabilization",
    ingredients = {
        {type = "item", name = "yumako", amount = 10},
        {type = "item", name = "5d-bio-stabilizer-agent", amount = 1}
    },
    results = {
        {type = "item", name = "5d-stabilized-yumako", amount = 10}
    },
    reset_freshness_on_craft = true
}
```

Balance posible:

- Si se quiere que estabilizar sea una recompensa fuerte, usar
  `reset_freshness_on_craft = true`.
- Si se quiere que no limpie errores del jugador, no usarlo y dejar que la
  frescura de entrada influya en la salida.
- Para estabilizados intermedios, usar `spoil_ticks` largo.
- Para MK10, crear una variante sin `spoil_ticks`.

### Desestabilizar

Convierte la variante estabilizada en el item normal justo antes de consumirlo.

Ejemplo conceptual:

```lua
{
    type = "recipe",
    name = "5d-destabilize-yumako",
    category = "5d-bio-destabilization",
    ingredients = {
        {type = "item", name = "5d-stabilized-yumako", amount = 10}
    },
    results = {
        {type = "item", name = "yumako", amount = 10}
    },
    reset_freshness_on_craft = true
}
```

Esta ruta mantiene compatibilidad con recetas existentes porque el output vuelve
a ser el item vanilla.

Pregunta de balance pendiente: la desestabilizacion puede devolver el item
fresco al 100%, devolverlo con una frescura fija usando `percent_spoiled`, o
perder una parte del material para pagar la comodidad logistica.

### Recetas Directas Con Estabilizados

Alternativa o complemento: algunas recetas podrian aceptar directamente la
version estabilizada.

Uso recomendado:

- Recetas nuevas 5Dim donde el estabilizado sea parte de la identidad.
- Rutas logisticas tardias donde desempaquetar siempre sea ruido.
- Cadenas de science agricola si se decide que el sistema debe aliviar esa parte
  de forma explicita.

Uso no recomendado:

- Duplicar todas las recetas vanilla de Gleba solo para aceptar cada variante
  estabilizada. Eso aumenta mantenimiento, ruido de recetas y riesgo de balance.

## Progresion MK1-MK10

| Tier | Rol | Resultado objetivo |
| --- | --- | --- |
| MK1 | Preservacion basica de Gleba | Estabilizados con duracion corta-media |
| MK2 | Mejor sellado biologico | Mas rendimiento o menor coste por lote |
| MK3 | Preservacion industrial | Duracion claramente superior a vanilla |
| MK4 | Control bioquimico | Entra carbon fiber o bioflux como coste visible |
| MK5 | Logistica interplanetaria temprana | Estabilizados pensados para transporte |
| MK6 | Integracion electromagnetica | Entra Fulgora como control de proceso |
| MK7 | Preservacion avanzada | Duracion muy alta, coste notable |
| MK8 | Integracion criogenica | Entra Aquilo/criogenia |
| MK9 | Pre-criopreservacion | Duracion casi definitiva |
| MK10 | Criopreservacion completa | Variantes sin podredumbre mientras esten selladas |

Regla de identidad: aunque los tiers altos pidan Fulgora o Aquilo, la familia
debe seguir leyendo como solucion biologica de Gleba.

## Agente De Estabilizacion

Para evitar que la maquina sea solo un convertidor gratis, conviene crear uno o
varios intermediarios consumibles.

Opciones:

- `5d-bio-stabilizer-agent`: agente base de Gleba.
- `5d-advanced-stabilizer-agent`: agente con materiales de Fulgora.
- `5d-cryo-stabilizer-agent`: agente final con materiales de Aquilo.

Esto permite que MK10 no sea simplemente una receta barata que borra la
podredumbre, sino una cadena industrial propia.

## Familias Candidatas

Prioridad alta:

- `agricultural-science-pack`: es la friccion logistica mas visible.
- `bioflux`: recurso central y transportable.
- `nutrients`: util si el objetivo es suavizar arranques y buffers.
- `yumako` y `jellynut`: entrada clara del sistema.

Prioridad media:

- productos intermedios derivados de yumako/jellynut si causan cuellos de
  botella reales.

Prioridad delicada:

- `pentapod-egg`: tiene implicaciones de enemigos, cautiverio y riesgo. Debe
  decidirse aparte si se permite criopreservarlo o si solo se le da una
  extension limitada.

## Implementacion Esperada

Archivos probables si se implementa:

- `mods/5dim_space_age/prototypes/gen-bio-stabilizer.lua`
- `mods/5dim_space_age/prototypes/gen-bio-stabilization-recipes.lua`
- `mods/5dim_space_age/data.lua`
- `mods/5dim_core/lib/costs/templates/space-age.lua`
- `mods/5dim_space_age/locale/en/locale.cfg`
- `mods/5dim_space_age/locale/es/locale.cfg`
- `mods/5dim_locale/locale/en/5dim_space_age.cfg`
- `mods/5dim_locale/locale/en.example/5dim_space_age.cfg`

No deberia requerir:

- `control.lua`
- eventos runtime
- escaneo de inventarios
- seguimiento de entidades construidas
- cambios globales a `spoil_time_modifier`

## Riesgos De Diseno

- Si la estabilizacion devuelve siempre items frescos sin coste alto, puede
  convertir Gleba en una cadena normal sin presion.
- Si se duplican demasiadas recetas para aceptar estabilizados directamente, el
  menu de recetas puede volverse pesado.
- Si MK10 llega demasiado pronto, borra la identidad de Gleba antes de que el
  jugador la haya resuelto.
- Si el coste usa demasiados materiales tardios genericos, la familia pierde su
  identidad biologica.

## Dudas Pendientes

- Nombre final: estabilizador biologico, conservador biologico, criosellador o
  bio-preservador.
- Si la desestabilizacion devuelve frescura completa, frescura fija o aplica
  perdida de material.
- Si MK10 debe cubrir huevos de pentapodo o dejarlos fuera por balance.
- Si se quiere una sola variante estabilizada por item o dos escalones:
  estabilizado y criopreservado.
- Si algunas recetas clave deben aceptar estabilizados directamente o si todo
  debe pasar por desestabilizacion.

## Resumen

La mejor ruta sin runtime es tratar la preservacion como una cadena industrial,
no como un efecto pasivo de edificio. El estabilizador MK1-MK10 crea variantes
estabilizadas; la desestabilizacion devuelve items vanilla cerca del punto de
consumo; y MK10 permite variantes criopreservadas sin podredumbre mientras sigan
selladas.
