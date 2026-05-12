# Transport Resource Matrix

Documento de diseno operativo para 5dim_transport.
Su objetivo es fijar las rutas objetivo de belts, inserters y familias de fluidos antes de implementarlas en codigo.

Scope:
- inserter
- pump
- stack inserter
- transport belt
- underground pipe extensions

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_transport/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Belts e inserters no deben compartir la misma cola tardia por inercia solo porque ambos sean logistica.
- Pump y underground pipe extensions forman un bloque de fluidos separado y no deben arrastrar su identidad al resto del modulo.
- Fulgora es el eje natural del control fino del modulo; Aquilo solo debe cerrar la ruta completa.
- La dependencia externa de Bob Inserters debe reflejarse en gating y prerequisitos cuando afecte a la familia.

## Regla Operativa De Esta Pasada

- Este documento fija la progresion objetivo del modulo y separa con claridad manipulacion de items, transporte continuo y fluidos.
- Si una subfamilia requiere metalurgia visible en SA, la excepcion debe documentarse aqui antes de implementarla.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Inserter | inserter base correspondiente | T2 | T7 | Fulgora -> Aquilo |
| Pump | pump | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Stack inserter | stack-inserter | T2 | T7 | Fulgora -> Aquilo |
| Transport belt | transport-belt base correspondiente | T2 | T7 | Fulgora -> Aquilo |
| Underground pipe extensions | pipe-to-ground | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Familia o bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Inserters y belts | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Pump y underground pipe extensions | T2-T4 chemical/production, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Inserter, stack inserter, transport belt | Ruta vanilla | crafting generico de logistica solida |
| Inserter, stack inserter, transport belt | T7-T9 SA | electromagnetics |
| Inserter, stack inserter, transport belt | T10 SA | cryogenics |
| Pump y underground pipe extensions | Ruta vanilla con proceso visible | crafting-with-fluid cuando el delta sea de proceso |
| Pump y underground pipe extensions | T5-T7 SA | metallurgy |
| Pump y underground pipe extensions | T8-T9 SA | electromagnetics |
| Pump y underground pipe extensions | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Inserter | T2 electronic-circuit -> T3 advanced-circuit -> T4 battery -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 electronic-circuit -> T3 advanced-circuit -> T4 battery -> T5 electric-engine-unit -> T6 processing-unit -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 quantum-processor | Debe reflejar precision y control fino de movimiento, no throughput puro. |
| Pump | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 lubricant -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 electrolyte -> T9 superconductor -> T10 fluoroketone-cold | Es la rama de fluidos mas industrial del modulo y por eso abre SA por Vulcanus. |
| Stack inserter | T2 advanced-circuit -> T3 battery -> T4 electric-engine-unit -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module-2 -> T8 productivity-module-2 -> T9 speed-module-3 -> T10 productivity-module-3 | T2 advanced-circuit -> T3 battery -> T4 electric-engine-unit -> T5 processing-unit -> T6 low-density-structure -> T7 holmium-plate -> T8 supercapacitor -> T9 superconductor -> T10 quantum-processor | Debe sentirse como manipulacion de throughput alto y no como inserter con cantidades distintas. |
| Transport belt | T2 iron-gear-wheel -> T3 steel-plate -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 iron-gear-wheel -> T3 steel-plate -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 lithium-plate | Debe mantener una identidad de transporte continuo, mas estructural que inserter. |
| Underground pipe extensions | T2 pipe-to-ground -> T3 steel-plate -> T4 concrete -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module -> T10 speed-module-2 | T2 pipe-to-ground -> T3 steel-plate -> T4 concrete -> T5 calcite -> T6 molten-copper -> T7 tungsten-plate -> T8 electrolyte -> T9 supercapacitor -> T10 lithium-plate | Es red de fluidos y alcance; no debe copiar la cola exacta de pump. |

## Resumen Del Modulo

- El control fino de logistica de items se concentra en Fulgora y solo cierra en Aquilo al final.
- Las ramas de fluidos abren SA por material y proceso antes de pasar por control electromagnetico.
- Belt, inserter, stack inserter, pump y tuberias quedan separados en identidad funcional y material.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_transport/prototypes/.
- Comprobar en juego que pump y underground pipe extensions muestren un lugar de fabricacion coherente cuando el delta sea metalurgico o de proceso.
- Comprobar que la dependencia de Bob Inserters siga cubierta en prerequisitos y no rompa la progresion visible.