# Battlefield Resource Matrix

Documento de diseno operativo para 5dim_battlefield.
Su objetivo es dejar preparado el rediseño por bloques funcionales de defensa, precision, soporte e infraestructura antes de implementarlo en codigo.

Scope:
- static defenses
- sniper branch
- mines and denial
- combat support
- walls, gates and radar
- artillery branch

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_battlefield/prototypes/.
- Este modulo se define por bloques funcionales y no por una sola cola material comun.
- Los tiers vanilla se respetan intactos dentro de cada superficie que ya exista en vanilla.
- Cada tier 5Dim introduce un unico delta directo nuevo.
- La ruta SA sustituye el delta vanilla visible del tier.
- Gun, laser, tesla, quimica, soporte movil, infraestructura y artilleria necesitan identidades materiales diferenciadas.
- Vulcanus encaja en chasis pesados, municion estructural y artilleria; Fulgora en control, radar y defensa electrica; Gleba solo entra en ramas realmente toxicas o biologicas; Aquilo solo debe cerrar rutas completas concretas.

## Regla Operativa De Esta Pasada

- Este documento deja preparados bloques de implementacion cerrados y evita que Battlefield se convierta en una lista plana de recetas casi identicas.
- Cuando una rama se implemente en codigo, debe respetar el bloque al que pertenece salvo excepcion documentada aqui.

## Bloques De Implementacion

| Bloque | Superficie real | Primer tier SA | Ruta objetivo |
| --- | --- | --- | --- |
| Gun y mortar turrets | gen-gun-turret.lua, gen-mortar-turret.lua, gen-flare-turret.lua | T5 | Vulcanus -> Fulgora -> Aquilo |
| Laser y tesla turrets | gen-laser-turret.lua, gen-tesla-turret.lua, gen-laser-turret-sniper.lua | T7 | Fulgora -> Aquilo |
| Denegacion quimica | gen-acid-turret.lua, gen-poison-turret.lua, gen-slow-turret.lua, gen-flamethrower-turret.lua, gen-acid-mine.lua, gen-poison-mine.lua, gen-land-mine.lua, gen-decoy.lua | T6 | Vulcanus/Gleba -> Fulgora -> Aquilo |
| Sniper branch | gen-sniper-gun.lua, gen-sniper-ammo.lua, gen-gun-turret-sniper.lua | T7 | Fulgora -> Aquilo |
| Combat support | gen-combat-capsules.lua, gen-combat-robots.lua, gen-robot-deployer.lua | T7 | Fulgora -> Aquilo |
| Walls y gates | gen-wall.lua, gen-gate.lua | T5 | Vulcanus -> Aquilo |
| Radar | gen-radar.lua | T7 | Fulgora -> Aquilo |
| Artillery branch | gen-artillery-ammo.lua, gen-artillery-turret.lua, gen-artillery-wagon.lua | T5 | Vulcanus -> Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Defensas estaticas y precision | T2-T4 military/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Soporte movil | T2-T4 military/logistic, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Infraestructura defensiva | T2-T4 logistic/military, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |
| Artilleria | T2-T4 production/military, T5-T7 utility, T8-T10 utility + SA | Desde el primer tier SA anade space-science-pack y el pack planetario del delta visible |

## Politica De Categorias Objetivo

| Bloque | Categoria esperada |
| --- | --- |
| Gun, mortar, walls, gates y artilleria | crafting generico en vanilla, metallurgy cuando el delta dominante sea estructural o de chasis, electromagnetics en control tardio, cryogenics solo en cierre |
| Laser, tesla, radar, sniper y combat support | crafting generico en vanilla, electromagnetics como categoria SA principal, cryogenics solo en cierre |
| Denegacion quimica | crafting-with-fluid o categoria de proceso cuando el delta dominante sea acido, veneno, combustible o biologia; cryogenics solo en cierre |

## Matriz Objetivo Por Bloque

| Bloque | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Gun y mortar turrets | steel-plate -> concrete -> advanced-circuit -> battery -> engine-unit -> electric-engine-unit -> processing-unit -> low-density-structure -> speed-module-2 | steel-plate -> concrete -> advanced-circuit -> calcite -> molten-iron -> tungsten-plate -> holmium-plate -> supercapacitor -> lithium-plate | Deben leerse como defensas fisicas y de plataforma, no como armas electricas. |
| Laser y tesla turrets | battery -> advanced-circuit -> processing-unit -> low-density-structure -> speed-module -> speed-module-2 -> productivity-module-2 -> speed-module-3 -> productivity-module-3 | battery -> advanced-circuit -> processing-unit -> low-density-structure -> speed-module -> holmium-plate -> electrolyte -> superconductor -> quantum-processor | El bloque electrico debe cargar casi todo su peso SA en Fulgora y reservar Aquilo solo al final. |
| Denegacion quimica | steel-plate -> pipe-to-ground -> sulfur -> plastic-bar -> sulfuric-acid -> explosives -> battery -> processing-unit -> low-density-structure | steel-plate -> pipe-to-ground -> sulfur -> plastic-bar -> calcite -> jelly o carbon-fiber segun subrama -> holmium-solution -> supercapacitor -> fluoroketone-cold | El bloque toxico no debe convertirse en otra rama tesla con un poco de acido encima. |
| Sniper branch | steel-plate -> advanced-circuit -> battery -> processing-unit -> low-density-structure -> speed-module -> speed-module-2 -> speed-module-3 -> productivity-module-3 | steel-plate -> advanced-circuit -> battery -> processing-unit -> low-density-structure -> holmium-plate -> supercapacitor -> superconductor -> quantum-processor | Debe leerse como precision, control y alcance, no como artilleria compacta. |
| Combat support | flying-robot-frame -> battery -> advanced-circuit -> electric-engine-unit -> processing-unit -> low-density-structure -> speed-module-2 -> productivity-module-2 -> speed-module-3 | flying-robot-frame -> battery -> advanced-circuit -> electric-engine-unit -> processing-unit -> holmium-plate -> electrolyte -> superconductor -> quantum-processor | Tiene que mantenerse como apoyo movil y no compartir cierre con torretas fisicas. |
| Walls y gates | stone-brick -> concrete -> refined-concrete -> steel-plate -> battery -> advanced-circuit -> low-density-structure -> speed-module -> speed-module-2 | stone-brick -> concrete -> refined-concrete -> steel-plate -> calcite -> tungsten-plate -> holmium-plate -> supercapacitor -> lithium-plate | Es infraestructura defensiva: debe verse mas estructural que el resto del modulo. |
| Radar | advanced-circuit -> battery -> processing-unit -> low-density-structure -> speed-module -> speed-module-2 -> productivity-module-2 -> speed-module-3 -> productivity-module-3 | advanced-circuit -> battery -> processing-unit -> low-density-structure -> speed-module -> holmium-plate -> electrolyte -> supercapacitor -> quantum-processor | Debe cerrarse por informacion y control, no por armadura o chasis. |
| Artillery branch | steel-plate -> concrete -> explosives -> engine-unit -> electric-engine-unit -> processing-unit -> low-density-structure -> speed-module-2 -> productivity-module-3 | steel-plate -> concrete -> explosives -> calcite -> molten-iron -> tungsten-plate -> holmium-plate -> superconductor -> fusion-power-cell | Es la rama de potencia extrema del modulo y puede usar el cierre energetico mas fuerte. |

## Resumen Del Modulo

- Battlefield queda separado en bloques funcionales reales y no como una sola familia gigante.
- Las ramas electricas y de control cargan Fulgora; las ramas de chasis, muralla y artilleria abren SA por Vulcanus.
- Gleba solo aparece en denegacion quimica o biologica; Aquilo se reserva a cierres concretos y no a media docena de ramas en paralelo.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_battlefield/prototypes/.
- Comprobar en juego que cada bloque muestre un lugar de fabricacion coherente y legible.
- Comprobar que tesla, laser, artilleria, soporte movil e infraestructura no converjan en una misma cola tardia solo con cambios de cantidades.