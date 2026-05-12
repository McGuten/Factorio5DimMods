# Energy Resource Matrix

Documento de diseno operativo para 5dim_energy.
Su objetivo es fijar la progresion material objetivo de cada familia para que el rediseño pueda implementarse en codigo sin reabrir despues las decisiones base de ruta, categoria y gating.

Scope:
- accumulator
- big pole
- boiler
- lamp
- medium pole
- solar panel
- steam engine
- substation

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_energy/prototypes/.
- Este archivo deja definida la matriz objetivo a implementar; no se limita a inventariar familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim anade un unico delta directo nuevo por familia.
- La ruta SA sustituye el delta vanilla visible del tier y no lo apila.
- Las familias termicas deben abrir SA por Vulcanus cuando el proceso dominante sea calor o metalurgia.
- Las familias de red y almacenamiento deben cargar mas peso de Fulgora que de Vulcanus.
- Aquilo se reserva a cierres concretos y cortos; en este modulo la opcion por defecto es un unico tier final visible por familia.

## Regla Operativa De Esta Pasada

- Este documento define la matriz que deberia terminar en codigo cuando se aborde Energy.
- Si durante la implementacion una familia necesita una excepcion real, la excepcion debe documentarse aqui junto con su motivo funcional.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Accumulator | accumulator | T2 | T6 | Fulgora -> Aquilo |
| Big pole | big-electric-pole | T2 | T7 | Fulgora -> Aquilo |
| Boiler | boiler | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Lamp | small-lamp | T2 | T8 | Fulgora -> Aquilo |
| Medium pole | medium-electric-pole | T2 | T7 | Fulgora -> Aquilo |
| Solar panel | solar-panel | T2 | T6 | Fulgora -> Aquilo |
| Steam engine | steam-engine | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Substation | substation | T2 | T7 | Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Bloque | Tecnologias 5Dim | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- | --- |
| Red electrica | T2-T4 logistic, T5-T7 chemical/production, T8-T10 utility | La red sube por control y distribucion, no por proceso termico | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Almacenamiento y renovables | T2-T4 logistic, T5-T7 production, T8-T10 utility | Accumulator y solar panel suben por control energetico | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Termica | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Boiler y steam engine deben mostrar antes estructura y calor que control fino | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Boiler | Ruta vanilla | crafting generico de item estructural |
| Boiler | T5-T7 SA | metallurgy |
| Boiler | T8-T9 SA | electromagnetics |
| Boiler | T10 SA | cryogenics |
| Steam engine | Ruta vanilla | crafting generico de item estructural |
| Steam engine | T5-T7 SA | metallurgy |
| Steam engine | T8-T9 SA | electromagnetics |
| Steam engine | T10 SA | cryogenics |
| Accumulator, solar panel, poles, lamp, substation | Ruta vanilla | crafting generico de items solidos |
| Accumulator, solar panel, poles, lamp, substation | Banda SA de Fulgora | electromagnetics |
| Accumulator, solar panel, poles, lamp, substation | Cierre SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Accumulator | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module-2 -> T9 efficiency-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 holmium-plate -> T7 electrolyte -> T8 supercapacitor -> T9 superconductor -> T10 fusion-power-cell | Debe leerse como almacenamiento y control de energia; no como una mini central termica. |
| Big pole | T2 steel-plate -> T3 concrete -> T4 battery -> T5 advanced-circuit -> T6 processing-unit -> T7 low-density-structure -> T8 efficiency-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 battery -> T5 advanced-circuit -> T6 processing-unit -> T7 holmium-plate -> T8 supercapacitor -> T9 superconductor -> T10 lithium-plate | La identidad es de distribucion robusta; Aquilo entra solo como refuerzo final de red. |
| Boiler | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 concrete -> T6 refined-concrete -> T7 electric-engine-unit -> T8 processing-unit -> T9 low-density-structure -> T10 speed-module-3 | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 fluoroketone-hot | La rama SA debe sentirse como maquinaria termica reforzada por metalurgia, no como simple control electrico. |
| Lamp | T2 steel-plate -> T3 electronic-circuit -> T4 battery -> T5 advanced-circuit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 electronic-circuit -> T4 battery -> T5 advanced-circuit -> T6 processing-unit -> T7 low-density-structure -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Debe quedarse como rama ligera de red y visibilidad, sin compartir cola estructural de boilers o steam engines. |
| Medium pole | T2 steel-plate -> T3 concrete -> T4 advanced-circuit -> T5 battery -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 advanced-circuit -> T5 battery -> T6 processing-unit -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 lithium-plate | Necesita una curva de control y distribucion visible, no solo un aumento estructural plano. |
| Solar panel | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module -> T8 speed-module-2 -> T9 efficiency-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 processing-unit -> T6 holmium-plate -> T7 supercapacitor -> T8 superconductor -> T9 lithium-plate -> T10 quantum-processor | La ruta SA debe reforzar control y gestion de energia solar; no necesita pasar por Vulcanus. |
| Steam engine | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 battery -> T6 electric-engine-unit -> T7 concrete -> T8 refined-concrete -> T9 low-density-structure -> T10 speed-module-2 | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 calcite -> T6 molten-copper -> T7 tungsten-plate -> T8 electrolyte -> T9 superconductor -> T10 fusion-power-cell | Comparte familia termica con boiler, pero debe cerrar con potencia y conversion, no con la misma cola exacta. |
| Substation | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 battery -> T4 advanced-circuit -> T5 processing-unit -> T6 low-density-structure -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 quantum-processor | Es la rama de red mas densa del modulo y por eso puede cargar mas control tardio que medium y big pole. |

## Resumen Del Modulo

- Boiler y steam engine abren SA por Vulcanus y la cierran en Aquilo sin convertir media curva en criogenia.
- Accumulator, solar panel y la red electrica cargan la mayor parte del peso SA en Fulgora.
- Aquilo queda reservado a un unico cierre final por familia y con funciones distintas segun almacenamiento, red o potencia.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_energy/prototypes/ y ajustar los generadores en la misma pasada.
- Comprobar en juego que las familias termicas usen foundry o categorias equivalentes cuando el delta visible sea metalurgico.
- Comprobar que poles, lamp, substation, accumulator y solar panel no se conviertan en la misma cola tardia con cantidades distintas.