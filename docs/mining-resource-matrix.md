# Mining Resource Matrix

Documento de diseno operativo para 5dim_mining.
Su objetivo es fijar la progresion material objetivo de extraccion solida, extraccion de fluidos y captacion de agua antes de llevarla a codigo.

Scope:
- electric mining drill
- offshore pump
- pumpjack
- water pumpjack

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_mining/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del escalon.
- Electric mining drill debe cargar mas peso estructural y metalurgico que offshore pump.
- Pumpjack y water pumpjack pueden usar mas proceso, pero no deben compartir una cola exacta con offshore pump.
- Aquilo se reserva a cierres puntuales; la mayor parte del arco SA del modulo debe sentirse antes en Vulcanus o Fulgora segun la familia.

## Regla Operativa De Esta Pasada

- Este documento deja decididas las rutas materiales objetivo del modulo.
- Si la implementacion futura exige desviar una familia, la desviacion debe justificarse por afinidad de proceso y no por comodidad de reutilizacion.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Electric mining drill | electric-mining-drill | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Offshore pump | offshore-pump | T2 | T7 | Fulgora -> Aquilo |
| Pumpjack | pumpjack | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Water pumpjack | water-pumpjack | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Familia o bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Electric mining drill | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Pumpjack y water pumpjack | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Offshore pump | T2-T5 logistic/chemical, T6-T8 production, T9-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Electric mining drill | Ruta vanilla | crafting generico de item estructural |
| Electric mining drill | T5-T7 SA | metallurgy |
| Electric mining drill | T8-T9 SA | electromagnetics |
| Electric mining drill | T10 SA | cryogenics |
| Pumpjack y water pumpjack | Ruta vanilla con fluidos visibles | crafting-with-fluid cuando el delta sea de proceso |
| Pumpjack y water pumpjack | T5-T7 SA | metallurgy |
| Pumpjack y water pumpjack | T8-T9 SA | electromagnetics |
| Pumpjack y water pumpjack | T10 SA | cryogenics |
| Offshore pump | Ruta vanilla | crafting generico de item estructural |
| Offshore pump | T7-T9 SA | electromagnetics |
| Offshore pump | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Electric mining drill | T2 steel-plate -> T3 concrete -> T4 engine-unit -> T5 electric-engine-unit -> T6 advanced-circuit -> T7 processing-unit -> T8 low-density-structure -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 engine-unit -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 fusion-power-cell | Debe sentirse como maquinaria pesada con control creciente, no como una variante menor de pumpjack. |
| Offshore pump | T2 pipe-to-ground -> T3 steel-plate -> T4 engine-unit -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 speed-module-3 | T2 pipe-to-ground -> T3 steel-plate -> T4 engine-unit -> T5 battery -> T6 electric-engine-unit -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 lithium-plate | Es captacion y bombeo de borde; debe diferenciarse tanto de mining drill como de water pumpjack. |
| Pumpjack | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 lubricant -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 electrolyte -> T9 superconductor -> T10 fluoroketone-cold | Es la rama de extraccion de fluidos mas industrial y puede cargar mas proceso que offshore pump. |
| Water pumpjack | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 productivity-module-2 | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 calcite -> T6 holmium-solution -> T7 electrolyte -> T8 supercapacitor -> T9 superconductor -> T10 fluoroketone-cold | Comparte afinidad de fluidos con pumpjack, pero debe leerse mas como captacion especializada que como refino petrolifero. |

## Resumen Del Modulo

- Electric mining drill abre la rama SA por maquinaria pesada de Vulcanus y la cierra una sola vez en Aquilo.
- Pumpjack y water pumpjack usan mas proceso y fluidos que offshore pump, pero sin copiarse entre si.
- Offshore pump se queda como rama de captacion y red, mas cercana a Fulgora que a una cadena larga de metalurgia.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_mining/prototypes/.
- Comprobar en juego que los tiers SA de mining drill, pumpjack y water pumpjack indiquen de forma visible su edificio dominante.
- Comprobar que offshore pump no acabe heredando la misma cola tardia de pumpjack solo por reutilizacion de costes.