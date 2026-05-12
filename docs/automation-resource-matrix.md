# Automation Resource Matrix

Documento de trabajo para Automation.
Su objetivo es describir la progresion material real de las familias del modulo, la bifurcacion vanilla y Space Age, el gating tecnologico visible y la categoria de crafteo esperada por tier.

Scope:
- assembling machine
- chemical plant
- lab
- oil refinery

## Principios Del Documento

- La fuente de verdad inmediata es la implementacion actual en los generadores de Automation y en las plantillas base de costes.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo por familia.
- La ruta Space Age sustituye el delta vanilla visible del tier y no lo apila.
- La tech del tier debe cubrir el delta real, el edificio dominante del proceso y las botellas del planeta cuando proceda.
- La categoria de recipe debe dejar claro donde se fabrica el tier en juego.
- Aquilo se trata como cierre alto por defecto y en Automation queda restringido a un unico tier final por familia en esta pasada.
- Si varias familias convergen por inercia en la misma cola de componentes tardios, el diseno se considera defectuoso aunque las cantidades cambien.
- Una familia no debe quedarse casi toda en solo solidos o casi toda en solo fluidos sin justificacion tematica clara.

## Regla Operativa De Esta Pasada

- Este documento no propone una matriz nueva separada del codigo: documenta la implementacion vigente para poder auditarla, mantenerla y corregirla con trazabilidad.
- Cuando el codigo cambie, este archivo debe actualizarse en la misma pasada si el cambio afecta a deltas, categoria, packs o prerequisitos.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA vigente |
| --- | --- | --- | --- | --- |
| Assembling machine | assembling-machine-3 | T4 | T6 | Vulcanus -> Fulgora -> Aquilo |
| Chemical plant | chemical-plant | T2 | T6 | Fulgora -> Aquilo |
| Lab | lab | T2 | T7 | Fulgora -> Aquilo |
| Oil refinery | oil-refinery | T2 | T4 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Vigentes

| Familia | Tecnologias | Count base | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- | --- | --- |
| Assembling machine | automation-4 -> automation-10 | 150 | T4-T6 production, T7-T10 utility | Desde T6 anade space-science-pack y el pack planetario del delta visible |
| Chemical plant | 5d-chemical-plant-1 -> 5d-chemical-plant-9 | 150 | T2 logistic, T3-T4 chemical, T5-T7 production, T8-T10 utility | Desde T6 anade space-science-pack y el pack planetario del delta visible |
| Lab | 5d-lab-1 -> 5d-lab-9 | 150 | T2-T3 logistic, T4-T5 chemical, T6-T7 production, T8-T10 utility | Desde T7 anade space-science-pack y el pack planetario del delta visible |
| Oil refinery | 5d-oil-refinery-1 -> 5d-oil-refinery-9 | 180 | T2-T4 chemical, T5-T7 production, T8-T10 utility | Desde T4 anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Vigente

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Assembling machine | Ruta vanilla | crafting generico de items solidos |
| Assembling machine | T6 SA | metallurgy |
| Assembling machine | T7-T9 SA | electromagnetics |
| Assembling machine | T10 SA | cryogenics |
| Chemical plant | T4-T5 vanilla | crafting-with-fluid |
| Chemical plant | T6 SA | chemistry |
| Chemical plant | T7-T9 SA | electromagnetics |
| Chemical plant | T10 SA | cryogenics |
| Lab | Ruta vanilla | crafting generico de items solidos |
| Lab | T7-T9 SA | electromagnetics |
| Lab | T10 SA | cryogenics |
| Oil refinery | T4 vanilla | crafting-with-fluid |
| Oil refinery | T4-T6 SA | metallurgy |
| Oil refinery | T7-T9 SA | electromagnetics |
| Oil refinery | T10 SA | cryogenics |

## Assembling Machine

- Base intacta: assembling-machine-3.
- La ruta vanilla sigue una curva industrial de infraestructura, energia, movimiento interno y control de produccion.
- La ruta SA entra en T6 con metalurgia, cambia a electronica de Fulgora en T7-T9 y reserva Aquilo para T10.
- El cierre de Aquilo queda reducido a un unico tier final; si vuelve a crecer, debe justificarse de forma explicita.

Cadena vanilla vigente:
- T4 concrete -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 productivity-module-2 -> T10 productivity-module-3

Cadena SA vigente:
- T4 concrete -> T5 battery -> T6 calcite -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 fusion-power-cell

| Tier | Ruta vanilla | Ruta SA | Categoria | Gating minimo visible |
| --- | --- | --- | --- | --- |
| T1 | No change | No change | vanilla | vanilla |
| T2 | No change | No change | vanilla | vanilla |
| T3 | No change | No change | vanilla | vanilla |
| T4 | concrete x20 | concrete x20 | crafting | concrete |
| T5 | battery x12 | battery x12 | crafting | battery |
| T6 | electric-engine-unit x12 | calcite x20 | crafting / metallurgy | electric-engine o foundry |
| T7 | processing-unit x12 | holmium-plate x16 | crafting / electromagnetics | processing-unit o electromagnetic-plant |
| T8 | low-density-structure x16 | electrolyte x140 | crafting / electromagnetics | low-density-structure + utility o electromagnetic-plant + utility |
| T9 | productivity-module-2 x6 | supercapacitor x12 | crafting / electromagnetics | productivity-module-2 o electromagnetic-plant |
| T10 | productivity-module-3 x8 | fusion-power-cell x6 | crafting / cryogenics | productivity-module-3 o fusion-reactor |

Lectura de la familia:
- T4-T6 consolidan una maquina industrial de produccion seria sin adelantar control planetario excesivo.
- T7-T9 forman el bloque de control fino de Fulgora y rompen la monotonia de solo solidos.
- T10 es el unico cierre de Aquilo de la familia en la implementacion vigente.

## Chemical Plant

- Base intacta: chemical-plant.
- Pipe queda excluido como delta porque ya forma parte de la base vanilla.
- La ruta vanilla mantiene una progresion de proceso quimico real antes del cierre de control industrial.
- La ruta SA entra en T6, cruza Fulgora con una mezcla de fluido e items y reserva Aquilo para T10.

Cadena vanilla vigente:
- T2 sulfur -> T3 plastic-bar -> T4 sulfuric-acid -> T5 lubricant -> T6 refined-concrete -> T7 processing-unit -> T8 low-density-structure -> T9 productivity-module-2 -> T10 speed-module-3

Cadena SA vigente:
- T2 sulfur -> T3 plastic-bar -> T4 sulfuric-acid -> T5 lubricant -> T6 holmium-solution -> T7 holmium-plate -> T8 superconductor -> T9 supercapacitor -> T10 fluoroketone-cold

| Tier | Ruta vanilla | Ruta SA | Categoria | Gating minimo visible |
| --- | --- | --- | --- | --- |
| T1 | No change | No change | vanilla | vanilla |
| T2 | sulfur x20 | sulfur x20 | crafting | sulfur-processing |
| T3 | plastic-bar x30 | plastic-bar x30 | crafting | plastics |
| T4 | sulfuric-acid x120 | sulfuric-acid x120 | crafting-with-fluid | sulfur-processing |
| T5 | lubricant x180 | lubricant x180 | crafting-with-fluid | lubricant |
| T6 | refined-concrete x24 | holmium-solution x160 | crafting / chemistry | refined-concrete o holmium-processing |
| T7 | processing-unit x12 | holmium-plate x16 | crafting / electromagnetics | processing-unit o electromagnetic-plant |
| T8 | low-density-structure x12 | superconductor x10 | crafting / electromagnetics | low-density-structure + utility o electromagnetic-plant + utility |
| T9 | productivity-module-2 x5 | supercapacitor x12 | crafting / electromagnetics | productivity-module-2 o electromagnetic-plant |
| T10 | speed-module-3 x6 | fluoroketone-cold x160 | crafting / cryogenics | speed-module-3 o cryogenic-plant |

Lectura de la familia:
- T2-T5 son quimica visible y no simple relleno estructural.
- T6-T8 forman una ruta SA de proceso y control que cambia de verdad la identidad material del edificio.
- T6-T9 forman una ruta SA de proceso y control que cambia de verdad la identidad material del edificio.
- T10 es el unico cierre criogenico; si Aquilo apareciera antes, esta familia volveria a alargar demasiado la cola final.

## Lab

- Base intacta: lab.
- No se usan transport-belt ni science packs como deltas de construccion.
- La ruta vanilla aguanta mas tiempo en una identidad de instrumentacion y control vanilla.
- La ruta SA entra mas tarde que en chemical y oil, pero ahora deja Aquilo solo en T10.

Cadena vanilla vigente:
- T2 steel-plate -> T3 advanced-circuit -> T4 concrete -> T5 battery -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3

Cadena SA vigente:
- T2 steel-plate -> T3 advanced-circuit -> T4 concrete -> T5 battery -> T6 processing-unit -> T7 holmium-plate -> T8 electrolyte -> T9 superconductor -> T10 quantum-processor

| Tier | Ruta vanilla | Ruta SA | Categoria | Gating minimo visible |
| --- | --- | --- | --- | --- |
| T1 | No change | No change | vanilla | vanilla |
| T2 | steel-plate x15 | steel-plate x15 | crafting | research-speed-1 + steel-processing |
| T3 | advanced-circuit x12 | advanced-circuit x12 | crafting | advanced-circuit |
| T4 | concrete x20 | concrete x20 | crafting | concrete + research-speed-3 |
| T5 | battery x10 | battery x10 | crafting | battery |
| T6 | processing-unit x12 | processing-unit x12 | crafting | processing-unit + research-speed-5 |
| T7 | low-density-structure x10 | holmium-plate x18 | crafting / electromagnetics | low-density-structure o electromagnetic-plant |
| T8 | speed-module-2 x6 | electrolyte x160 | crafting / electromagnetics | speed-module-2 + utility + research-speed-6 o electromagnetic-plant + utility |
| T9 | productivity-module-2 x6 | superconductor x10 | crafting / electromagnetics | productivity-module-2 o electromagnetic-plant |
| T10 | speed-module-3 x8 | quantum-processor x4 | crafting / cryogenics | speed-module-3 o quantum-processor |

Lectura de la familia:
- El laboratorio conserva mas tiempo una progresion vanilla que las familias de proceso pesado.
- T7-T9 introducen Fulgora con presion material visible sin convertir toda la familia en una copia de chemical o assembling.
- T10 es el unico cierre de Aquilo de la familia en la implementacion vigente.

## Oil Refinery

- Base intacta: oil-refinery.
- La ruta vanilla mezcla plataforma, petroquimica y control de proceso.
- La ruta SA es la mas temprana del modulo por game stage y peso industrial de la familia.
- Aun asi, Aquilo no se extiende: la ruta pasa por Vulcanus, luego Fulgora y deja la criogenia para T10.

Cadena vanilla vigente:
- T2 concrete -> T3 sulfur -> T4 lubricant -> T5 refined-concrete -> T6 plastic-bar -> T7 battery -> T8 processing-unit -> T9 low-density-structure -> T10 productivity-module-3

Cadena SA vigente:
- T2 concrete -> T3 sulfur -> T4 calcite -> T5 molten-iron -> T6 tungsten-plate -> T7 electrolyte -> T8 supercapacitor -> T9 superconductor -> T10 fluoroketone-cold

| Tier | Ruta vanilla | Ruta SA | Categoria | Gating minimo visible |
| --- | --- | --- | --- | --- |
| T1 | No change | No change | vanilla | vanilla |
| T2 | concrete x20 | concrete x20 | crafting | advanced-oil-processing + concrete |
| T3 | sulfur x24 | sulfur x24 | crafting | sulfur-processing |
| T4 | lubricant x160 | calcite x20 | crafting-with-fluid / metallurgy | lubricant o foundry |
| T5 | refined-concrete x28 | molten-iron x180 | crafting / metallurgy | refined-concrete o foundry |
| T6 | plastic-bar x30 | tungsten-plate x24 | crafting / metallurgy | plastics o tungsten-steel |
| T7 | battery x16 | electrolyte x180 | crafting / electromagnetics | battery o electromagnetic-plant |
| T8 | processing-unit x12 | supercapacitor x12 | crafting / electromagnetics | processing-unit + utility o electromagnetic-plant + utility |
| T9 | low-density-structure x12 | superconductor x10 | crafting / electromagnetics | low-density-structure o electromagnetic-plant |
| T10 | productivity-module-3 x8 | fluoroketone-cold x160 | crafting / cryogenics | productivity-module-3 o cryogenic-plant |

Lectura de la familia:
- Oil refinery es la puerta SA mas temprana de Automation y por eso puede recorrer mas planetas que el resto.
- T4-T6 forman un bloque metalurgico claro de Vulcanus.
- T7-T9 desplazan la familia a control electromagnetico y T10 cierra con Aquilo sin convertir media curva en criogenia.

## Resumen Del Modulo

- Assembling machine usa una progresion industrial media y un unico cierre final de Aquilo.
- Chemical plant mezcla proceso y control electromagnetico hasta T9 y deja Aquilo solo como cierre final.
- Lab mantiene una entrada SA tardia y controlada, con un unico cierre final de Aquilo.
- Oil refinery sigue siendo la entrada SA mas temprana del modulo, pero deja Aquilo solo como cierre final.

## Validacion Esperada

- Revisar cualquier cambio futuro contra mods/5dim_core/lib/costs/templates/automation.lua y los cuatro generadores del modulo.
- Comprobar en juego que la recipe category visible coincide con el edificio esperado en todos los tiers SA.
- Comprobar que el gating tecnologico real sigue cubriendo el delta visible y el planeta del que depende.
- Si un rediseño vuelve a empujar Aquilo mas alla del ultimo tier en estas familias, documentarlo como excepcion explicita o corregirlo.
