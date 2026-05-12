# Trains Resource Matrix

Documento de diseno operativo para 5dim_trains.
Su objetivo es dejar cerradas las rutas objetivo de locomotora y vagones antes de implementarlas en codigo.

Scope:
- cargo wagon
- fluid wagon
- locomotive

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_trains/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Locomotive debe mantener una identidad de potencia y traccion distinta de los vagones.
- Cargo wagon y fluid wagon deben diferenciarse por funcion visible, no solo por el tipo de carga transportada.
- Vulcanus es la apertura SA natural del modulo; Fulgora entra despues en control y Aquilo solo cierra la ruta completa.

## Regla Operativa De Esta Pasada

- Este documento fija la progresion material objetivo de locomotora, cargo wagon y fluid wagon.
- Si alguna familia necesitara desviarse de la apertura por Vulcanus, la excepcion debe justificarse por afinidad funcional real.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Cargo wagon | cargo-wagon | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Fluid wagon | fluid-wagon | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |
| Locomotive | locomotive | T2 | T5 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Familia | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Cargo wagon y fluid wagon | T2-T4 chemical/production, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Locomotive | T2-T4 production, T5-T7 production/utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia | Banda | Categoria esperada |
| --- | --- | --- |
| Cargo wagon y locomotive | Ruta vanilla | crafting generico de infraestructura y vehiculo pesado |
| Cargo wagon y locomotive | T5-T7 SA | metallurgy |
| Cargo wagon y locomotive | T8-T9 SA | electromagnetics |
| Cargo wagon y locomotive | T10 SA | cryogenics |
| Fluid wagon | Ruta vanilla con proceso visible | crafting-with-fluid cuando el delta sea de proceso |
| Fluid wagon | T5-T7 SA | metallurgy |
| Fluid wagon | T8-T9 SA | electromagnetics |
| Fluid wagon | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Cargo wagon | T2 steel-plate -> T3 concrete -> T4 iron-gear-wheel -> T5 battery -> T6 engine-unit -> T7 electric-engine-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 iron-gear-wheel -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 lithium-plate | Debe sentirse como estructura y capacidad, no como locomotora sin motor. |
| Fluid wagon | T2 steel-plate -> T3 pipe-to-ground -> T4 concrete -> T5 engine-unit -> T6 lubricant -> T7 electric-engine-unit -> T8 low-density-structure -> T9 processing-unit -> T10 speed-module-2 | T2 steel-plate -> T3 pipe-to-ground -> T4 concrete -> T5 calcite -> T6 molten-copper -> T7 tungsten-plate -> T8 electrolyte -> T9 superconductor -> T10 fluoroketone-cold | Debe reflejar contencion y fluidos; no puede copiar la ruta de cargo wagon. |
| Locomotive | T2 steel-plate -> T3 engine-unit -> T4 concrete -> T5 battery -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 productivity-module-3 | T2 steel-plate -> T3 engine-unit -> T4 concrete -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 superconductor -> T10 fusion-power-cell | Es la rama de potencia del modulo y por eso puede cerrar con densidad energetica maxima. |

## Resumen Del Modulo

- El modulo ferroviario abre SA por chasis y material de Vulcanus.
- Fulgora entra como control y señalizacion avanzada, y Aquilo solo cierra cada familia una vez.
- Locomotive, cargo wagon y fluid wagon quedan separados por potencia, capacidad y contencion.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_trains/prototypes/.
- Comprobar en juego que fluid wagon no reutilice por inercia la misma cola tardia que cargo wagon o storage tank.
- Comprobar que locomotive mantenga un cierre propio y no termine convergiendo con los vagones.