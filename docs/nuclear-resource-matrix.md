# Nuclear Resource Matrix

Documento de diseno operativo para 5dim_nuclear.
Su objetivo es dejar cerradas las rutas materiales objetivo de proceso nuclear, cadena termica y generacion antes de implementarlas en codigo.

Scope:
- centrifuge
- heat exchanger
- heat pipe
- nuclear reactor
- steam turbine

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_nuclear/prototypes/.
- Este archivo fija la matriz objetivo del modulo y no solo un resumen de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim anade un unico delta nuevo visible.
- Las familias termicas no deben copiar exactamente el mismo cierre que reactor o centrifuge.
- Vulcanus encaja como apertura SA natural de reactor, heat exchanger y heat pipe.
- Fulgora entra como control fino de proceso y seguridad.
- Aquilo debe cerrar la ruta completa, pero sin repetirse como cola larga de varias familias paralelas.

## Regla Operativa De Esta Pasada

- El rediseño de Nuclear debe mantener identidad de calor, proceso y densidad energetica en todas las familias.
- Si una familia salta directamente a Fulgora o Aquilo sin un bloque previo de proceso o estructura, esa decision debe justificarse aqui antes de codificarla.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Centrifuge | centrifuge | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Heat exchanger | heat-exchanger | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Heat pipe | heat-pipe | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Nuclear reactor | nuclear-reactor | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Steam turbine | steam-turbine | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Proceso nuclear | T2-T4 chemical/production, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Cadena termica | T2-T4 chemical/production, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Generacion | T2-T4 production, T5-T7 utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Reactor, heat exchanger, heat pipe, steam turbine | Ruta vanilla | crafting generico de infraestructura energetica |
| Reactor, heat exchanger, heat pipe, steam turbine | T5-T7 SA | metallurgy |
| Reactor, heat exchanger, heat pipe, steam turbine | T8-T9 SA | electromagnetics |
| Reactor, heat exchanger, heat pipe, steam turbine | T10 SA | cryogenics |
| Centrifuge | Ruta vanilla | crafting generico de proceso avanzado |
| Centrifuge | T5-T7 SA | metallurgy |
| Centrifuge | T8-T9 SA | electromagnetics |
| Centrifuge | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Centrifuge | T2 steel-plate -> T3 concrete -> T4 advanced-circuit -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 advanced-circuit -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 superconductor -> T10 fluoroketone-cold | Debe sentirse como proceso nuclear denso y no como copia de reactor. |
| Heat exchanger | T2 steel-plate -> T3 pipe-to-ground -> T4 concrete -> T5 refined-concrete -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 battery -> T10 speed-module-2 | T2 steel-plate -> T3 pipe-to-ground -> T4 concrete -> T5 calcite -> T6 molten-copper -> T7 tungsten-plate -> T8 electrolyte -> T9 supercapacitor -> T10 fluoroketone-hot | El cierre de Aquilo aqui debe leerse como medio termico avanzado, no como control abstracto. |
| Heat pipe | T2 steel-plate -> T3 copper-plate -> T4 concrete -> T5 refined-concrete -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 battery -> T10 speed-module | T2 steel-plate -> T3 copper-plate -> T4 concrete -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 fluoroketone-hot | Es transporte de calor; necesita mas estructura y material termico que computacion dura. |
| Nuclear reactor | T2 concrete -> T3 refined-concrete -> T4 steel-plate -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 battery -> T9 speed-module-2 -> T10 productivity-module-3 | T2 concrete -> T3 refined-concrete -> T4 steel-plate -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 superconductor -> T10 fusion-power-cell | Es la rama de densidad energetica maxima y por eso puede cerrar con fusion-power-cell. |
| Steam turbine | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 pipe-to-ground -> T4 engine-unit -> T5 calcite -> T6 molten-copper -> T7 tungsten-plate -> T8 electrolyte -> T9 superconductor -> T10 fusion-power-cell | Comparte bloque de generacion con reactor, pero debe sentirse mas de conversion que de nucleo. |

## Resumen Del Modulo

- Toda la rama SA de Nuclear abre primero por calor y metalurgia de Vulcanus.
- Fulgora entra como control de proceso y seguridad, no como sustituto completo de la identidad termica del modulo.
- Aquilo cierra cada familia una sola vez y con funciones distintas segun proceso, transporte de calor o generacion.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_nuclear/prototypes/.
- Comprobar en juego que heat exchanger y heat pipe no acaben con el mismo cierre exacto que reactor y centrifuge.
- Comprobar que las recetas con delta fluido o termico muestren una categoria de fabricacion comprensible y coherente.