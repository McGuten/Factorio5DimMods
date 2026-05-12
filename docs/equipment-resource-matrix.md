# Equipment Resource Matrix

Documento de diseno operativo para 5dim_equipment.
Su objetivo es dejar preparadas las rutas objetivo de plataforma, energia, defensa y soporte personal antes de implementarlas en codigo.

Scope:
- battery equipment
- energy shield equipment
- exoskeleton equipment
- fission reactor equipment
- personal laser defense equipment
- personal roboport equipment
- personal tesla defense equipment
- power armor
- solar panel equipment
- night vision equipment

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_equipment/prototypes/.
- Este archivo define la matriz objetivo a implementar y no solo un inventario de familias.
- Los tiers vanilla se respetan intactos.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Power armor no debe compartir exactamente la misma cola tardia que sus equipos internos.
- Las familias de energia, defensa y soporte personal pueden cruzarse en bandas, pero deben mantener identidades materiales distinguibles.
- Fulgora es el eje natural de la mayor parte del modulo; Vulcanus solo entra donde la familia necesita estructura o potencia real; Aquilo solo cierra una vez por familia.

## Regla Operativa De Esta Pasada

- Este documento fija la progresion material objetivo del modulo y deja preparadas las familias para futura implementacion en codigo.
- Si alguna familia de equipo necesita una categoria o un gating excepcional, la excepcion debe documentarse aqui antes de tocar recipes y technologies.

## Bases Vanilla Y Punto De Entrada SA

| Familia | Base vanilla a respetar | Primer tier 5Dim | Primer tier SA | Ruta SA objetivo |
| --- | --- | --- | --- | --- |
| Battery equipment | personal-battery-equipment base correspondiente | T2 | T8 | Fulgora -> Aquilo |
| Energy shield equipment | energy-shield-equipment base correspondiente | T2 | T8 | Fulgora -> Aquilo |
| Exoskeleton equipment | exoskeleton-equipment | T2 | T6 | Vulcanus -> Fulgora -> Aquilo |
| Fission reactor equipment | personal-fission-reactor-equipment base correspondiente | T2 | T6 | Vulcanus -> Fulgora -> Aquilo |
| Personal laser defense equipment | personal-laser-defense-equipment | T2 | T8 | Fulgora -> Aquilo |
| Personal roboport equipment | personal-roboport-equipment base correspondiente | T2 | T7 | Fulgora -> Aquilo |
| Personal tesla defense equipment | personal-tesla-defense-equipment | T2 | T7 | Fulgora -> Aquilo |
| Power armor | power-armor-mk2 | T2 | T6 | Vulcanus -> Fulgora -> Aquilo |
| Solar panel equipment | solar-panel-equipment base correspondiente | T2 | T8 | Fulgora -> Aquilo |
| Night vision equipment | night-vision-equipment | T2 | T8 | Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Plataforma y movilidad | T2-T4 production, T5-T7 utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Energia y soporte | T2-T4 chemical/production, T5-T7 utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Defensa personal | T2-T4 utility, T5-T7 utility alta, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Familia o bloque | Banda | Categoria esperada |
| --- | --- | --- |
| Power armor, exoskeleton, fission reactor equipment | Ruta vanilla | crafting generico de equipo pesado |
| Power armor, exoskeleton, fission reactor equipment | T6-T7 SA | metallurgy |
| Power armor, exoskeleton, fission reactor equipment | T8-T9 SA | electromagnetics |
| Power armor, exoskeleton, fission reactor equipment | T10 SA | cryogenics |
| Resto de equipo personal | Ruta vanilla | crafting generico de equipo electronico |
| Resto de equipo personal | T7-T9 SA segun familia | electromagnetics |
| Resto de equipo personal | T10 SA | cryogenics |

## Matriz Objetivo Por Familia

| Familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Battery equipment | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 speed-module-2 -> T8 efficiency-module-2 -> T9 speed-module-3 -> T10 efficiency-module-3 | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 speed-module-2 -> T8 holmium-plate -> T9 supercapacitor -> T10 fusion-power-cell | Debe leerse como almacenamiento portatil denso y no como copia de accumulator de edificio. |
| Energy shield equipment | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 efficiency-module -> T7 speed-module-2 -> T8 efficiency-module-2 -> T9 speed-module-3 -> T10 efficiency-module-3 | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 efficiency-module -> T7 speed-module-2 -> T8 holmium-plate -> T9 superconductor -> T10 lithium-plate | La familia es de defensa pasiva y debe cerrar mas por material de contencion que por potencia pura. |
| Exoskeleton equipment | T2 steel-plate -> T3 battery -> T4 engine-unit -> T5 electric-engine-unit -> T6 low-density-structure -> T7 speed-module -> T8 speed-module-2 -> T9 speed-module-3 -> T10 productivity-module-3 | T2 steel-plate -> T3 battery -> T4 engine-unit -> T5 electric-engine-unit -> T6 calcite -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 lithium-plate | Necesita una lectura clara de estructura, movimiento y control; no solo electronica. |
| Fission reactor equipment | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 productivity-module-2 -> T7 speed-module-3 -> T8 productivity-module-3 -> T9 speed-module-3 -> T10 fusion-power-cell | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 calcite -> T7 tungsten-plate -> T8 holmium-plate -> T9 superconductor -> T10 fusion-power-cell | Comparte bloque energetico con battery y solar, pero su cierre debe ser de densidad energetica, no de red ligera. |
| Personal laser defense equipment | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 speed-module-2 -> T8 productivity-module-2 -> T9 speed-module-3 -> T10 productivity-module-3 | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 speed-module-2 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Debe sentirse como precision ofensiva y control de disparo. |
| Personal roboport equipment | T2 battery -> T3 advanced-circuit -> T4 electric-engine-unit -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module -> T8 speed-module-2 -> T9 productivity-module-2 -> T10 speed-module-3 | T2 battery -> T3 advanced-circuit -> T4 electric-engine-unit -> T5 processing-unit -> T6 low-density-structure -> T7 holmium-plate -> T8 electrolyte -> T9 supercapacitor -> T10 quantum-processor | Es soporte logistico personal y debe leerse mas como red portatil que como arma o armadura. |
| Personal tesla defense equipment | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 speed-module-2 -> T8 productivity-module-2 -> T9 speed-module-3 -> T10 quantum-processor | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 holmium-plate -> T8 electrolyte -> T9 superconductor -> T10 quantum-processor | Puede entrar antes en Fulgora que laser defense, pero no debe invadir toda la cola del modulo. |
| Power armor | T2 steel-plate -> T3 battery -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module-2 -> T7 productivity-module-2 -> T8 speed-module-3 -> T9 productivity-module-3 -> T10 quantum-processor | T2 steel-plate -> T3 battery -> T4 processing-unit -> T5 low-density-structure -> T6 calcite -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Debe ser plataforma pesada y de control, no un simple contenedor de equipo. |
| Solar panel equipment | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 efficiency-module-2 -> T8 speed-module-2 -> T9 speed-module-3 -> T10 efficiency-module-3 | T2 battery -> T3 advanced-circuit -> T4 processing-unit -> T5 low-density-structure -> T6 speed-module -> T7 efficiency-module-2 -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Debe quedarse como generacion portatil y no compartir cierre exacto con fission reactor. |
| Night vision equipment | T2 electronic-circuit -> T3 advanced-circuit -> T4 battery -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module -> T8 speed-module-2 -> T9 speed-module-3 -> T10 efficiency-module-3 | T2 electronic-circuit -> T3 advanced-circuit -> T4 battery -> T5 processing-unit -> T6 low-density-structure -> T7 speed-module -> T8 holmium-plate -> T9 supercapacitor -> T10 quantum-processor | Es soporte utilitario y debe mantenerse ligero, sin copiar la cola de power armor o roboport. |

## Resumen Del Modulo

- Power armor, exoskeleton y fission reactor equipment forman la rama estructural y energetica pesada del modulo.
- Defensa, vision, energia ligera y soporte personal cargan la mayor parte del peso SA en Fulgora.
- Aquilo cierra una sola vez por familia y con identidades distintas segun plataforma, energia, defensa o soporte.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_equipment/prototypes/.
- Comprobar en juego que las familias de energia portatil, defensa y soporte no converjan en una misma cola tardia.
- Comprobar que power armor y exoskeleton mantengan categorias y gating coherentes con una ruta mas estructural que el resto del modulo.