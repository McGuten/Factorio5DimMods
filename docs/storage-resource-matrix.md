# Storage Resource Matrix

Documento de diseno operativo para 5dim_storage.
Su objetivo es fijar las rutas objetivo de cofres y tanques antes de implementarlas en codigo.

Scope:
- logistic chest
- steel chest
- storage tank
- storage tank multi

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_storage/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Cofres y tanques no deben compartir cola material por pura comodidad de balance.
- Los tanques pueden usar mas proceso y fluidos; los cofres deben mantenerse estructurales y logistico-mecanicos.
- Aquilo solo debe cerrar familias concretas y nunca convertirse en una cadena larga de storage.

## Regla Operativa De Esta Pasada

- Este documento fija la progresion objetivo del modulo y la separacion entre almacenamiento solido y de fluidos.
- Si una familia de cofre o tanque necesita una excepcion de categoria o planeta, debe quedar documentada aqui antes de codificarla.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Logistic chest | logistic chest base correspondiente | T2 | T7 | Fulgora -> Aquilo |
| Steel chest | steel-chest | T2 | T8 | Fulgora -> Aquilo |
| Storage tank | storage-tank | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Storage tank multi | storage-tank | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Familia o bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Cofres | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Tanques | T2-T4 chemical/production, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Steel chest y logistic chest | Ruta vanilla | crafting generico de items solidos |
| Steel chest y logistic chest | T7-T9 SA | electromagnetics |
| Steel chest y logistic chest | T10 SA | cryogenics |
| Storage tank y storage tank multi | Ruta vanilla con proceso visible | crafting-with-fluid cuando el delta sea de proceso |
| Storage tank y storage tank multi | T5-T7 SA | metallurgy |
| Storage tank y storage tank multi | T8-T9 SA | electromagnetics |
| Storage tank y storage tank multi | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Logistic chest | T2 steel-plate -> T3 advanced-circuit -> T4 battery -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 advanced-circuit -> T4 battery -> T5 processing-unit -> T6 low-density-structure -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 quantum-processor | Debe ser almacenamiento logistico y control de red, no una version mas de steel chest. |
| Steel chest | T2 steel-plate -> T3 concrete -> T4 refined-concrete -> T5 battery -> T6 advanced-circuit -> T7 low-density-structure -> T8 speed-module -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 refined-concrete -> T5 battery -> T6 advanced-circuit -> T7 low-density-structure -> T8 holmium-plate -> T9 supercapacitor -> T10 lithium-plate | Debe mantenerse mas estructural que logistic chest incluso en tiers altos. |
| Storage tank | T2 steel-plate -> T3 pipe-to-ground -> T4 concrete -> T5 refined-concrete -> T6 battery -> T7 electric-engine-unit -> T8 processing-unit -> T9 low-density-structure -> T10 speed-module-2 | T2 steel-plate -> T3 pipe-to-ground -> T4 concrete -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 electrolyte -> T9 supercapacitor -> T10 fluoroketone-cold | Es almacenamiento de fluidos y su SA debe sentirse como contencion y proceso. |
| Storage tank multi | T2 steel-plate -> T3 pipe-to-ground -> T4 refined-concrete -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 pipe-to-ground -> T4 refined-concrete -> T5 calcite -> T6 molten-copper -> T7 tungsten-plate -> T8 holmium-plate -> T9 superconductor -> T10 lithium-plate | Debe leerse como macroalmacenamiento y no como simple storage tank con mas capacidad. |

## Resumen Del Modulo

- Los cofres cargan su peso SA casi entero en Fulgora y reservan Aquilo a un unico cierre final.
- Los tanques abren SA por contencion y material de proceso en Vulcanus antes de pasar por control fino.
- Storage queda dividido en dos curvas visibles: solidos estructurales y fluidos de contencion.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_storage/prototypes/.
- Comprobar en juego que las ramas de tanques muestren su lugar de fabricacion de forma legible.
- Comprobar que steel chest y logistic chest no converjan en la misma cola tardia con cantidades distintas.