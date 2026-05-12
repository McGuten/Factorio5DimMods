# Vehicles Resource Matrix

Documento de diseno operativo para 5dim_vehicles.
Su objetivo es fijar las rutas objetivo de tank y spidertron antes de implementarlas en codigo.

Scope:
- tank
- spidertron

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_vehicles/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Tank y spidertron no deben compartir una cola tardia indistinguible.
- Tank debe cargar mas estructura, armadura y potencia; spidertron puede cargar mas control fino y electronica avanzada.
- Aquilo solo debe cerrar una vez cada ruta y no convertirse en una cola larga de ambos vehiculos.

## Regla Operativa De Esta Pasada

- Este documento fija la progresion material objetivo de los dos vehiculos del modulo.
- Si spidertron necesitara una ruta SA mas temprana o mas larga que tank, la diferencia debe justificarse por su naturaleza automatizada y no por comodidad de balance.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Tank | tank | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Spidertron | spidertron | T2 | T6 | Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Familia | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Tank | T2-T4 production, T5-T7 utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Spidertron | T2-T4 utility, T5-T7 utility alta, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Tank | Ruta vanilla | crafting generico de vehiculo pesado |
| Tank | T5-T7 SA | metallurgy |
| Tank | T8-T9 SA | electromagnetics |
| Tank | T10 SA | cryogenics |
| Spidertron | Ruta vanilla | crafting generico de vehiculo avanzado |
| Spidertron | T6-T9 SA | electromagnetics |
| Spidertron | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Tank | T2 steel-plate -> T3 engine-unit -> T4 concrete -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 engine-unit -> T4 concrete -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 superconductor -> T10 fusion-power-cell | Debe sentirse como blindado pesado y por eso abre SA por chasis y potencia de Vulcanus. |
| Spidertron | T2 steel-plate -> T3 engine-unit -> T4 battery -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 engine-unit -> T4 battery -> T5 electric-engine-unit -> T6 holmium-plate -> T7 electrolyte -> T8 supercapacitor -> T9 superconductor -> T10 quantum-processor | Debe leerse como plataforma automatizada y de control tardio, no como segundo tank. |

## Resumen Del Modulo

- Tank recorre una ruta SA de estructura, potencia y cierre energetico.
- Spidertron entra mas directo en control fino y reserva Aquilo a un unico cierre computacional final.
- Los dos vehiculos quedan separados por afinidad material desde el arranque de la rama SA.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_vehicles/prototypes/.
- Comprobar en juego que tank y spidertron no converjan en una cola tardia indistinguible.
- Comprobar que la ruta SA de spidertron no empiece demasiado tarde ni quede reducida a un adorno final.