# Mapa Planetario De Crafteo Detallado

Documento operativo para revisar reparto planetario en 5Dim.

Objetivo:
- decir en que tiers entra cada planeta
- decir con que items concretos entra
- aclarar nombres de bloque que en el resumen modular pueden sonar ambiguos
- dejar a la vista donde esta hoy la concentracion para decidir si hay que repartir mas cosas

Este documento complementa el resumen corto en [design-planets.md](design-planets.md).

## Glosario Rapido

| Bloque | Que significa realmente |
| --- | --- |
| Denegacion quimica | Rama toxica y de control de area: acid turret, poison turret, slow turret, flamethrower turret, acid mine, poison mine, land mine y decoy. |
| Combat support | Capsulas y robots de apoyo: grenade, cluster grenade, poison capsule, slowdown capsule, defender, distractor, destroyer y robot deployer. |
| Sniper branch | sniper gun, sniper ammo y gun turret sniper. |
| Walls y gates | Infraestructura defensiva, no armas electricas. |
| Soporte planetario | Recursos nativos de cada planeta: scrap, Gleba y Aquilo. |
| Dust planetaria | dust-calcite, dust-tungsten, dust-holmium y dust-orbit. |

## Detalle Por Superficie

## Vulcanus

| Modulo | Familia o bloque | Tiers concretos en Vulcanus | Items concretos |
| --- | --- | --- | --- |
| 5dim_automation | Assembling machine | T6 | calcite |
| 5dim_automation | Oil refinery | T4-T6 | calcite, molten-iron, tungsten-plate |
| 5dim_battlefield | Gun y mortar turrets | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_battlefield | Denegacion quimica | T6 | calcite |
| 5dim_battlefield | Walls y gates | T6-T7 | calcite, tungsten-plate |
| 5dim_battlefield | Artillery branch | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_energy | Boiler | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_energy | Steam engine | T5-T7 | calcite, molten-copper, tungsten-plate |
| 5dim_equipment | Exoskeleton equipment | T6-T7 | calcite, tungsten-plate |
| 5dim_equipment | Fission reactor equipment | T6-T7 | calcite, tungsten-plate |
| 5dim_equipment | Power armor | T6-T7 | calcite, tungsten-plate |
| 5dim_mining | Electric mining drill | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_mining | Pumpjack | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_mining | Water pumpjack | T5 | calcite |
| 5dim_nuclear | Centrifuge | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_nuclear | Heat exchanger | T5-T7 | calcite, molten-copper, tungsten-plate |
| 5dim_nuclear | Heat pipe | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_nuclear | Nuclear reactor | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_nuclear | Steam turbine | T5-T7 | calcite, molten-copper, tungsten-plate |
| 5dim_resources | Electric furnace | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_resources | Masher | T5-T6 | calcite, tungsten-plate |
| 5dim_resources | Industrial furnace | T5-T7 | calcite, molten-copper, tungsten-carbide |
| 5dim_resources | Dust metalica | entrada SA visible | primero Vulcanus; luego refinado en Fulgora segun recurso |
| 5dim_resources | Dust planetaria | SA nativa | dust-calcite, dust-tungsten |
| 5dim_storage | Storage tank | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_storage | Storage tank multi | T5-T7 | calcite, molten-copper, tungsten-plate |
| 5dim_trains | Cargo wagon | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_trains | Fluid wagon | T5-T7 | calcite, molten-copper, tungsten-plate |
| 5dim_trains | Locomotive | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_transport | Pump | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_transport | Underground pipe extensions | T5-T7 | calcite, molten-copper, tungsten-plate |
| 5dim_vehicles | Tank | T5-T7 | calcite, molten-iron, tungsten-plate |
| 5dim_space_age | Produccion industrial de Vulcanus | nativo | calcite, molten-iron, molten-copper, tungsten-plate, tungsten-carbide |

Lectura rapida:
- Vulcanus esta bien repartido en maquinaria pesada, calor, contencion y chasis.
- Si quieres repartir mas, no parece ser el cuello principal del repo ahora mismo.

## Fulgora

| Modulo | Familia o bloque | Tiers concretos en Fulgora | Items concretos |
| --- | --- | --- | --- |
| 5dim_automation | Assembling machine | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_automation | Chemical plant | T6-T9 | holmium-solution, holmium-plate, superconductor, supercapacitor |
| 5dim_automation | Lab | T7-T9 | holmium-plate, electrolyte, superconductor |
| 5dim_automation | Oil refinery | T7-T9 | electrolyte, supercapacitor, superconductor |
| 5dim_battlefield | Gun y mortar turrets | T8-T9 | holmium-plate, supercapacitor |
| 5dim_battlefield | Laser y tesla turrets | T7-T9 | holmium-plate, electrolyte, superconductor |
| 5dim_battlefield | Denegacion quimica | T8-T9 | holmium-solution, supercapacitor |
| 5dim_battlefield | Sniper branch | T7-T9 | holmium-plate, supercapacitor, superconductor |
| 5dim_battlefield | Combat support | T7-T9 | holmium-plate, electrolyte, superconductor |
| 5dim_battlefield | Walls y gates | T8-T9 | holmium-plate, supercapacitor |
| 5dim_battlefield | Radar | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_battlefield | Artillery branch | T8-T9 | holmium-plate, superconductor |
| 5dim_energy | Accumulator | T6-T9 | holmium-plate, electrolyte, supercapacitor, superconductor |
| 5dim_energy | Big pole | T7-T9 | holmium-plate, supercapacitor, superconductor |
| 5dim_energy | Boiler | T8-T9 | holmium-plate, supercapacitor |
| 5dim_energy | Lamp | T8-T9 | holmium-plate, supercapacitor |
| 5dim_energy | Medium pole | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_energy | Solar panel | T6-T8 | holmium-plate, supercapacitor, superconductor |
| 5dim_energy | Steam engine | T8-T9 | electrolyte, superconductor |
| 5dim_energy | Substation | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_equipment | Battery equipment | T8-T9 | holmium-plate, supercapacitor |
| 5dim_equipment | Energy shield equipment | T8-T9 | holmium-plate, superconductor |
| 5dim_equipment | Exoskeleton equipment | sin presencia directa | redistribuido a Gleba, orbita y Aquilo |
| 5dim_equipment | Fission reactor equipment | T8-T9 | holmium-plate, superconductor |
| 5dim_equipment | Personal laser defense equipment | T8-T9 | holmium-plate, supercapacitor |
| 5dim_equipment | Personal roboport equipment | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_equipment | Personal tesla defense equipment | T7-T9 | holmium-plate, electrolyte, superconductor |
| 5dim_equipment | Power armor | sin presencia directa | redistribuido a Gleba, orbita y Aquilo |
| 5dim_equipment | Solar panel equipment | T8-T9 | holmium-plate, supercapacitor |
| 5dim_logistic | Construction robot | T6, T8 | holmium-plate, supercapacitor |
| 5dim_logistic | Logistic robot | T6 | holmium-plate |
| 5dim_logistic | Roboport | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_mining | Electric mining drill | T8-T9 | holmium-plate, supercapacitor |
| 5dim_mining | Offshore pump | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_mining | Pumpjack | T8-T9 | electrolyte, superconductor |
| 5dim_mining | Water pumpjack | T6-T9 | holmium-solution, electrolyte, supercapacitor, superconductor |
| 5dim_module | Beacon | T8-T9 | holmium-plate, supercapacitor |
| 5dim_module | Speed | T8-T9 | holmium-plate, supercapacitor |
| 5dim_module | Effectivity | T8-T9 | holmium-plate, supercapacitor |
| 5dim_module | Productivity | T8-T9 | holmium-plate, supercapacitor |
| 5dim_module | Pollution | T8-T9 | holmium-plate, supercapacitor |
| 5dim_module | Quality | T8-T9 | holmium-plate, supercapacitor |
| 5dim_module | Merged | T8-T9 | holmium-plate, supercapacitor |
| 5dim_nuclear | Centrifuge | T8-T9 | holmium-plate, superconductor |
| 5dim_nuclear | Heat exchanger | T8-T9 | electrolyte, supercapacitor |
| 5dim_nuclear | Heat pipe | T8-T9 | holmium-plate, supercapacitor |
| 5dim_nuclear | Nuclear reactor | T8-T9 | holmium-plate, superconductor |
| 5dim_nuclear | Steam turbine | T8-T9 | electrolyte, superconductor |
| 5dim_resources | Electric furnace | T8-T9 | holmium-plate, supercapacitor |
| 5dim_resources | Masher | T8-T9 | holmium-plate, superconductor |
| 5dim_resources | Industrial furnace | T8-T9 | holmium-plate, supercapacitor |
| 5dim_resources | Dust metalica | refinado tardio | segun recurso |
| 5dim_resources | Dust planetaria | SA nativa | dust-holmium |
| 5dim_resources | Soporte planetario | SA nativa | scrap |
| 5dim_storage | Logistic chest | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_storage | Steel chest | T8-T9 | holmium-plate, supercapacitor |
| 5dim_storage | Storage tank | T8-T9 | electrolyte, supercapacitor |
| 5dim_storage | Storage tank multi | T8-T9 | holmium-plate, superconductor |
| 5dim_trains | Cargo wagon | T8-T9 | holmium-plate, supercapacitor |
| 5dim_trains | Fluid wagon | T8-T9 | electrolyte, superconductor |
| 5dim_trains | Locomotive | T8-T9 | holmium-plate, superconductor |
| 5dim_transport | Inserter | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_transport | Pump | T8-T9 | electrolyte, superconductor |
| 5dim_transport | Stack inserter | T7-T9 | holmium-plate, supercapacitor, superconductor |
| 5dim_transport | Transport belt | T7-T9 | holmium-plate, electrolyte, supercapacitor |
| 5dim_transport | Underground pipe extensions | T8-T9 | electrolyte, supercapacitor |
| 5dim_vehicles | Tank | T8-T9 | holmium-plate, superconductor |
| 5dim_vehicles | Spidertron | sin presencia directa | redistribuido a Gleba, orbita y Aquilo |
| 5dim_space_age | Produccion electromagnetica de Fulgora | nativo | holmium-plate, electrolyte, supercapacitor, superconductor |
| 5dim_space_age | Tesla turret SA | nativo | rama electromagnetica y de control de Fulgora |
| 5dim_space_age | Mech armor | T1-T4 | holmium-plate, electrolyte, holmium-solution, quantum-processor |

Lectura rapida:
- Fulgora sigue siendo, con diferencia, la superficie mas cargada del repo.
- Aun asi, este lote ya saco de Fulgora la cola SA de exoskeleton, power armor y spidertron, y corto parte de la repeticion tardia en robots.

## Gleba

| Modulo | Familia o bloque | Tiers concretos en Gleba | Items concretos |
| --- | --- | --- | --- |
| 5dim_battlefield | Denegacion quimica | T7 | jelly o carbon-fiber segun subrama |
| 5dim_equipment | Exoskeleton equipment | T8 | carbon-fiber |
| 5dim_equipment | Power armor | T8 | carbon-fiber |
| 5dim_logistic | Construction robot | T7 | carbon-fiber |
| 5dim_logistic | Logistic robot | T7 | carbon-fiber |
| 5dim_resources | Masher | T7 | jelly o carbon-fiber segun subrama |
| 5dim_resources | Soporte planetario | SA nativa | resource-gleba |
| 5dim_vehicles | Spidertron | T8 | carbon-fiber |
| 5dim_space_age | Produccion biologica de Gleba | nativo | jelly, bioflux, carbon-fiber y luego cierres segun familia |
| 5dim_space_age | Mech armor | T5 | carbon-fiber |

Lectura rapida:
- Gleba sigue teniendo hueco, pero ya entra de forma visible en movilidad, armadura pesada, robots y Spidertron.
- Este lote la convierte en una superficie transversal y no solo en soporte del modulo SA nativo y ramas toxicas.

## Aquilo

| Modulo | Familia o bloque | Tiers concretos en Aquilo | Items concretos |
| --- | --- | --- | --- |
| 5dim_automation | Assembling machine | T10 | fusion-power-cell |
| 5dim_automation | Chemical plant | T10 | fluoroketone-cold |
| 5dim_automation | Lab | T10 | quantum-processor |
| 5dim_automation | Oil refinery | T10 | fluoroketone-cold |
| 5dim_battlefield | Gun y mortar turrets | T10 | lithium-plate |
| 5dim_battlefield | Laser y tesla turrets | T10 | quantum-processor |
| 5dim_battlefield | Denegacion quimica | T10 | fluoroketone-cold |
| 5dim_battlefield | Sniper branch | T10 | quantum-processor |
| 5dim_battlefield | Combat support | T10 | quantum-processor |
| 5dim_battlefield | Walls y gates | T10 | lithium-plate |
| 5dim_battlefield | Radar | T10 | quantum-processor |
| 5dim_battlefield | Artillery branch | T10 | fusion-power-cell |
| 5dim_energy | Accumulator | T10 | fusion-power-cell |
| 5dim_energy | Big pole | T10 | lithium-plate |
| 5dim_energy | Boiler | T10 | fluoroketone-hot |
| 5dim_energy | Lamp | T10 | quantum-processor |
| 5dim_energy | Medium pole | T10 | lithium-plate |
| 5dim_energy | Solar panel | T9-T10 | lithium-plate, quantum-processor |
| 5dim_energy | Steam engine | T10 | fusion-power-cell |
| 5dim_energy | Substation | T10 | quantum-processor |
| 5dim_equipment | Battery equipment | T10 | fusion-power-cell |
| 5dim_equipment | Energy shield equipment | T10 | lithium-plate |
| 5dim_equipment | Exoskeleton equipment | T10 | lithium-plate |
| 5dim_equipment | Fission reactor equipment | T10 | fusion-power-cell |
| 5dim_equipment | Personal laser defense equipment | T10 | quantum-processor |
| 5dim_equipment | Personal roboport equipment | T10 | quantum-processor |
| 5dim_equipment | Personal tesla defense equipment | T10 | quantum-processor |
| 5dim_equipment | Power armor | T10 | quantum-processor |
| 5dim_equipment | Solar panel equipment | T10 | quantum-processor |
| 5dim_logistic | Construction robot | T10 | lithium-plate |
| 5dim_logistic | Logistic robot | T9-T10 | lithium-plate, quantum-processor |
| 5dim_logistic | Roboport | T10 | fusion-power-cell |
| 5dim_mining | Electric mining drill | T10 | fusion-power-cell |
| 5dim_mining | Offshore pump | T10 | lithium-plate |
| 5dim_mining | Pumpjack | T10 | fluoroketone-cold |
| 5dim_mining | Water pumpjack | T10 | fluoroketone-cold |
| 5dim_module | Beacon | T10 | quantum-processor |
| 5dim_module | Speed | T10 | quantum-processor |
| 5dim_module | Effectivity | T10 | lithium-plate |
| 5dim_module | Productivity | T10 | quantum-processor |
| 5dim_module | Pollution | T10 | lithium-plate |
| 5dim_module | Quality | T10 | quantum-processor |
| 5dim_module | Merged | T10 | quantum-processor |
| 5dim_nuclear | Centrifuge | T10 | fluoroketone-cold |
| 5dim_nuclear | Heat exchanger | T10 | fluoroketone-hot |
| 5dim_nuclear | Heat pipe | T10 | fluoroketone-hot |
| 5dim_nuclear | Nuclear reactor | T10 | fusion-power-cell |
| 5dim_nuclear | Steam turbine | T10 | fusion-power-cell |
| 5dim_resources | Electric furnace | T10 | fluoroketone-hot |
| 5dim_resources | Masher | T10 | lithium-plate |
| 5dim_resources | Industrial furnace | T10 | fusion-power-cell |
| 5dim_resources | Soporte planetario | SA nativa | resource-aquilo, lithium, ammoniacal-solution, fluorine |
| 5dim_storage | Logistic chest | T10 | quantum-processor |
| 5dim_storage | Steel chest | T10 | lithium-plate |
| 5dim_storage | Storage tank | T10 | fluoroketone-cold |
| 5dim_storage | Storage tank multi | T10 | lithium-plate |
| 5dim_trains | Cargo wagon | T10 | lithium-plate |
| 5dim_trains | Fluid wagon | T10 | fluoroketone-cold |
| 5dim_trains | Locomotive | T10 | fusion-power-cell |
| 5dim_transport | Inserter | T10 | quantum-processor |
| 5dim_transport | Pump | T10 | fluoroketone-cold |
| 5dim_transport | Stack inserter | T10 | quantum-processor |
| 5dim_transport | Transport belt | T10 | lithium-plate |
| 5dim_transport | Underground pipe extensions | T10 | lithium-plate |
| 5dim_vehicles | Tank | T10 | fusion-power-cell |
| 5dim_vehicles | Spidertron | T10 | quantum-processor |
| 5dim_space_age | Produccion criogenica de Aquilo | nativo | lithium, lithium-plate, ammoniacal-solution, fluorine, fluoroketones |
| 5dim_space_age | Energia extrema y fusion | nativo | fusion-power-cell, fusion-plasma cuando proceda |
| 5dim_space_age | Mech armor | T6-T10 | lithium-plate, ammoniacal-solution, fluorine, fluoroketone-cold, fusion-power-cell |

Lectura rapida:
- Aquilo esta muy extendido como cierre final y eso encaja con la politica actual.
- Si quieres mas identidad propia de Aquilo fuera del cierre, el hueco esta sobre todo fuera de las familias SA nativas de criogenia y fusion.

## Orbita Y Gravedad Cero

| Modulo | Familia o bloque | Tiers concretos en orbita o gravedad cero | Items concretos |
| --- | --- | --- | --- |
| 5dim_equipment | Exoskeleton equipment | T9 | metallic-asteroid-chunk |
| 5dim_equipment | Power armor | T9 | carbon |
| 5dim_logistic | Construction robot | T9 | oxide-asteroid-chunk |
| 5dim_logistic | Logistic robot | T8 | metallic-asteroid-chunk |
| 5dim_resources | Dust planetaria | SA nativa | dust-orbit |
| 5dim_vehicles | Spidertron | T9 | space-platform-foundation |
| 5dim_space_age | Logistica orbital y de plataforma | nativo | metallic-asteroid-chunk, oxide-asteroid-chunk, thruster-fuel, thruster-oxidizer |
| 5dim_space_age | Energia extrema y fusion | nativo parcial | fusion-power-cell y cadenas orbitales asociadas |

Lectura rapida:
- Orbita ya no vive solo dentro de 5dim_space_age y dust-orbit: este lote la mete en equipment, robots y Spidertron.
- Sigue teniendo margen para crecer, pero ya deja de ser un bloque casi aislado del resto de 5Dim.

## Que Significa Esto Para Repartir Mas

## Sobrecargas Actuales

| Superficie | Que esta pasando |
| --- | --- |
| Fulgora | Esta absorbiendo casi toda la electronica avanzada del repo: modulos, logistica, equipos personales, red electrica, radar, belts, inserters y gran parte del control militar. |
| Aquilo | Funciona sobre todo como cierre final, lo cual esta bien para muchas familias generalistas, pero deja poco espacio a una identidad media de Aquilo fuera de cryogenic/fusion. |

## Huecos Claros

| Superficie | Hueco visible |
| --- | --- |
| Gleba | Ya entro en mobility, armadura pesada, robots y Spidertron, pero todavia tiene hueco para crecer fuera de esas primeras familias. |
| Orbita | Ya entro en equipment, robots y Spidertron, pero sigue teniendo menos presencia transversal que Fulgora o Aquilo. |

## Checklist De Siguientes Decisiones

1. Decidir si quieres que Gleba entre en alguna rama no toxica ni biologica. Ahora mismo casi no existe fuera de esos casos.
2. Decidir si alguna familia muy cargada en Fulgora deberia mover un tier a orbita o a Vulcanus para romper la repeticion T7-T9 de holmium/electrolyte/supercapacitor.
3. Revisar si algunas familias con cierre T10 en quantum-processor estan demasiado homogeneizadas y necesitan un cierre material distinto en Aquilo.
4. Revisar si quieres que Orbita entre antes en alguna rama de logistica avanzada, modulos o equipo tardio en lugar de dejarla casi solo en el modulo 5dim_space_age.
5. Mantener Gleba restringido si esa es la intencion de diseno. Si no, este documento deja muy visible donde no esta entrando.

## Lectura Rapida Final

- Si tu duda es donde esta peor repartido: Fulgora.
- Si tu duda es que planeta sigue teniendo mas hueco para crecer: Gleba.
- Si tu duda es que superficie especial ya empezo a salir del modulo SA nativo pero aun puede crecer mas: orbita.
- Si tu duda es que nombre raro habia en esta documentacion: Denegacion quimica es simplemente la rama toxica y de control de area del modulo battlefield.

## Fuentes

- design-guide.md
- design-modules.md
- design-resources.md
- design-upgrades.md
- design-planets.md