# Module Resource Matrix

Documento de diseno operativo para 5dim_module.
Su objetivo es dejar preparadas las cadenas objetivo de beacon y de cada rama de modulos antes de llevar el rediseño a codigo.

Scope:
- beacon
- speed modules
- effectivity modules
- productivity modules
- pollution modules
- quality modules
- merged modules

## Principios Del Documento

- La fuente de verdad inmediata es mods/5dim_module/prototypes/gen-beacon.lua y mods/5dim_module/prototypes/gen-modules.lua.
- Este archivo define el objetivo de implementacion y no solo inventaria familias.
- Las ramas speed, effectivity, productivity y quality conservan intacto su tramo vanilla previo a 5Dim.
- Pollution y merged se tratan como ramas propias del modulo y deben documentarse separadas.
- Los modulos no pueden usarse como atajo para abaratar tiers altos: la presion visible debe mantenerse o subir.
- Beacon no debe heredar exactamente el mismo cierre que todas las ramas de modulos solo por vivir en el mismo modulo.
- Fulgora es el eje natural del modulo, pero Aquilo debe cerrar las rutas completas y no quedar sustituido por un tercer tier electromagnetico repetido.

## Regla Operativa De Esta Pasada

- Este documento deja fijada la direccion del rediseño del modulo, incluida la correccion de cierres SA demasiado homogeneos.
- Si una rama conserva un cierre no criogenico, la excepcion debe justificarse de forma explicita aqui antes de codificarla.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Beacon | beacon | T2 | T8 | Fulgora -> Aquilo |
| Speed | speed-module-3 | T4 | T8 | Fulgora -> Aquilo |
| Effectivity | efficiency-module-3 | T4 | T8 | Fulgora -> Aquilo |
| Productivity | productivity-module-3 | T4 | T8 | Fulgora -> Aquilo |
| Pollution | Rama 5Dim propia | T1 | T8 | Fulgora -> Aquilo |
| Quality | quality-module-3 | T4 | T8 | Fulgora -> Aquilo |
| Merged | Rama 5Dim propia | T1 | T8 | Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Ramas de modulos | T1-T3 logistic/chemical/production segun base, T4-T7 production/utility, T8-T10 utility | Desde T8 anade space-science-pack y el pack planetario del delta visible |
| Beacon | T2-T4 production, T5-T7 utility, T8-T10 utility + SA | Desde T8 anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Todas las ramas de modulos | Ruta vanilla y 5Dim no SA | crafting generico de items electronicos |
| Todas las ramas de modulos | T8-T9 SA | electromagnetics |
| Todas las ramas de modulos | T10 SA | cryogenics |
| Beacon | Ruta vanilla y 5Dim no SA | crafting generico de infraestructura electronica |
| Beacon | T8-T9 SA | electromagnetics |
| Beacon | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla o 5Dim objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Beacon | T2 advanced-circuit -> T3 battery -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module-2 -> T7 productivity-module-2 -> T8 speed-module-3 -> T9 productivity-module-3 -> T10 quantum-processor | T2 advanced-circuit -> T3 battery -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module-2 -> T7 productivity-module-2 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Debe leerse como infraestructura de transmision, no como un modulo gigante. |
| Speed | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 speed-module-3 -> T8 speed-module-4 -> T9 speed-module-5 -> T10 speed-module-6 | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 speed-module-3 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | La rama speed debe cerrar en control extremo, no quedarse para siempre en Fulgora. |
| Effectivity | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 efficiency-module-3 -> T8 efficiency-module-4 -> T9 efficiency-module-5 -> T10 efficiency-module-6 | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 efficiency-module-3 -> T8 holmium-plate -> T9 supercapacitor -> T10 lithium-plate | El cierre de eficiencia puede ser mas material que computacional, pero debe entrar ya en Aquilo. |
| Productivity | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 productivity-module-3 -> T8 productivity-module-4 -> T9 productivity-module-5 -> T10 productivity-module-6 | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 productivity-module-3 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Productivity necesita presion visible alta; no debe sentirse mas barata que speed o beacon. |
| Pollution | T1 electronic-circuit -> T2 advanced-circuit -> T3 battery -> T4 processing-unit -> T5 low-density-structure -> T6 efficiency-module-2 -> T7 efficiency-module-3 -> T8 pollution-module-7 -> T9 pollution-module-8 -> T10 pollution-module-9 | T1 electronic-circuit -> T2 advanced-circuit -> T3 battery -> T4 processing-unit -> T5 low-density-structure -> T6 efficiency-module-2 -> T7 efficiency-module-3 -> T8 holmium-plate -> T9 supercapacitor -> T10 lithium-plate | La rama pollution no debe quedarse como tercera copia de speed/effectivity; su cierre puede ser mas de material y filtrado. |
| Quality | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 quality-module-3 -> T8 quality-module-4 -> T9 quality-module-5 -> T10 quality-module-6 | T4 processing-unit -> T5 battery -> T6 low-density-structure -> T7 quality-module-3 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Quality debe compartir base de control fino pero no degradar la presion visible del cierre. |
| Merged | T1 advanced-circuit -> T2 processing-unit -> T3 battery -> T4 low-density-structure -> T5 speed-module-3 -> T6 efficiency-module-3 -> T7 productivity-module-3 -> T8 merged-module-7 -> T9 merged-module-8 -> T10 merged-module-9 | T1 advanced-circuit -> T2 processing-unit -> T3 battery -> T4 low-density-structure -> T5 speed-module-3 -> T6 efficiency-module-3 -> T7 productivity-module-3 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Tiene que sentirse como consolidacion cara de varias ramas y no como un token tardio barato. |

## Resumen Del Modulo

- Todas las rutas SA completas del modulo cierran ya en Aquilo y no en un tercer escalon repetido de Fulgora.
- Beacon queda separado de las ramas de modulos por su funcion de infraestructura.
- Effectivity y pollution pueden usar un cierre criogenico mas material que computacional, pero siguen entrando en Aquilo.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_module/prototypes/gen-modules.lua y mods/5dim_module/prototypes/gen-beacon.lua.
- Comprobar que las ramas T8-T10 muestren un lugar de fabricacion legible y no saltable.
- Comprobar que ninguna rama SA del modulo conserve un cierre puro de Fulgora salvo excepcion documental explicita.