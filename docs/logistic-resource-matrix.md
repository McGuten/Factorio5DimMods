# Logistic Resource Matrix

Documento de diseno operativo para 5dim_logistic.
Su objetivo es dejar cerradas las rutas objetivo de robots y roboports antes de implementarlas en codigo.

Scope:
- construction robot
- logistic robot
- roboport

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_logistic/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Construction robot y logistic robot deben divergir de forma material y no solo por cantidades.
- Roboport debe mantener una identidad de infraestructura y potencia distinta de la robotica movil.
- Fulgora es el eje natural del modulo; Aquilo solo cierra la ruta completa y no debe ocupar varios tiers seguidos por familia.

## Regla Operativa De Esta Pasada

- Este documento fija las rutas materiales objetivo que luego deben reflejarse en recipes, technologies y recipe categories.
- Si una familia necesita usar metalurgia pesada de forma relevante, la excepcion debe documentarse aqui antes de llegar a codigo.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Construction robot | construction-robot | T2 | T6 | Fulgora -> Aquilo |
| Logistic robot | logistic-robot | T2 | T6 | Fulgora -> Aquilo |
| Roboport | roboport | T2 | T7 | Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Familia o bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Construction y logistic robot | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Roboport | T2-T4 production, T5-T7 utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Construction robot y logistic robot | Ruta vanilla | crafting generico de robotica logistica |
| Construction robot y logistic robot | T6-T9 SA | electromagnetics |
| Construction robot y logistic robot | T10 SA | cryogenics |
| Roboport | Ruta vanilla | crafting generico de infraestructura logistica |
| Roboport | T7-T9 SA | electromagnetics |
| Roboport | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Construction robot | T2 flying-robot-frame -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module-2 -> T9 efficiency-module-2 -> T10 speed-module-3 | T2 flying-robot-frame -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 holmium-plate -> T7 electrolyte -> T8 supercapacitor -> T9 superconductor -> T10 lithium-plate | Debe sentirse como rama de precision y autonomia, no como clon numerico de logistic robot. |
| Logistic robot | T2 flying-robot-frame -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 flying-robot-frame -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 holmium-plate -> T7 supercapacitor -> T8 superconductor -> T9 lithium-plate -> T10 quantum-processor | Debe leerse mas como throughput y control de red que como precision de obra. |
| Roboport | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 fusion-power-cell | La infraestructura fija debe cerrar por densidad energetica y red, no por la misma cola exacta que los robots. |

## Resumen Del Modulo

- Los robots cargan la mayor parte del peso SA en Fulgora y reservan Aquilo a un unico cierre final.
- Roboport mantiene un cierre propio mas energetico que la robotica movil.
- Construction y logistic robot quedan diferenciados por funcion visible y no solo por cantidades o tiempos.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_logistic/prototypes/.
- Comprobar en juego que construction robot, logistic robot y roboport no converjan en la misma cola tardia.
- Comprobar que el gating tecnologico cubre flying-robot-frame, control electromagnetico y cierre criogenico donde corresponda.