# Space Age Resource Matrix

Documento de diseno operativo para 5dim_space_age.
Su objetivo es dejar preparado el rediseño por bloques de familias SA nativas antes de implementarlo en codigo.

Scope:
- planetary buildings
- orbital and platform logistics
- advanced power and heat
- advanced defense
- biological branch
- equipment and armor

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_space_age/prototypes/.
- Este modulo mezcla familias SA nativas de varios planetas y no debe aplanarse en una sola curva generalista.
- Las categorias de recipe, los edificios de fabricacion y las restricciones de superficie forman parte del comportamiento central del modulo.
- Cuando una familia SA nativa se extienda a una ruta 5Dim completa, Aquilo actua como cierre preferente salvo que la propia identidad de la familia exija quedarse en orbita o en su planeta nativo.
- Las ramas ya nativas de Aquilo, orbita o gravedad cero no deben forzarse a repetir un segundo cierre de Aquilo por puro formalismo.
- Foundry, electromagnetic plant, biochamber, cryogenic plant, fusion, logistica orbital y defensa avanzada deben mantener identidades materiales propias y no converger solo por rareza.

## Regla Operativa De Esta Pasada

- Este documento fija los bloques de implementacion y las reglas de progresion material para cada superficie SA nativa.
- Si una familia necesitara una excepcion de planeta final, de gravedad cero o de edificio de fabricacion, la excepcion debe quedar documentada aqui antes de tocar codigo.

## Bloques De Implementacion

| Bloque | Superficie real | Punto de entrada | Ruta objetivo |
| --- | --- | --- | --- |
| Produccion industrial de Vulcanus | gen-foundry.lua, gen-crusher.lua, gen-big-mining-drill.lua | Vulcanus nativo | Vulcanus -> Fulgora -> Aquilo cuando haya cadena 5Dim completa |
| Produccion electromagnetica de Fulgora | gen-electromagnetic-plant.lua, gen-lightning-rod.lua, gen-lightning-collector.lua, gen-recycler.lua | Fulgora nativo | Fulgora -> Aquilo cuando haya cadena 5Dim completa |
| Produccion biologica de Gleba | gen-biochamber.lua, gen-biolab.lua, gen-agricultural-tower.lua, gen-captive-biter-spawner.lua | Gleba nativo | Gleba -> Fulgora -> Aquilo cuando la familia suba a tiers altos |
| Produccion criogenica de Aquilo | gen-cryogenic-plant.lua, gen-heating-tower.lua | Aquilo nativo | Aquilo nativo; no necesita un segundo cierre planetario |
| Logistica orbital y de plataforma | gen-cargo-bay.lua, gen-cargo-landing-pad.lua, gen-asteroid-collector.lua, gen-thruster.lua | Orbita nativa | Orbita/gravidad cero -> Aquilo o fusion segun familia |
| Energia extrema y fusion | gen-fusion-generator.lua, gen-fusion-reactor-building.lua, gen-fusion-reactor-equipment.lua | Aquilo/orbita nativo | Aquilo -> fusion/orbita; no se reabre por Fulgora salvo control real |
| Defensa avanzada | gen-railgun-turret.lua, gen-rocket-turret.lua, gen-tesla-turret-sa.lua | Vulcanus o Fulgora nativo segun rama | Planeta nativo -> Aquilo en cadenas completas |
| Equipo y movilidad tardia | gen-mech-armor.lua | Fulgora nativo | Fulgora -> Aquilo |

## Bandas Tecnologicas Objetivo

| Bloque | Banda base de ciencia | Regla aplicada |
| --- | --- | --- |
| Familias planetarias nativas | science pack del planeta nativo como base minima | Si suben a cadena 5Dim completa, anaden despues space-science-pack y el pack del nuevo planeta del delta visible |
| Familias orbitales | utility + space-science-pack como base minima | Cualquier salto a gravedad cero u orbita exige gating explicito de superficie |
| Aquilo y fusion | cryogenic-science-pack como base minima y space-science-pack cuando haya contexto espacial | No se debe inventar una ruta previa si la familia ya nace en Aquilo |

## Politica De Categorias Objetivo

| Bloque | Categoria esperada |
| --- | --- |
| Produccion industrial de Vulcanus | foundry o categoria metalurgica explicita |
| Produccion electromagnetica de Fulgora | electromagnetic-plant o categoria electromagnetica explicita |
| Produccion biologica de Gleba | biochamber o categoria biologica explicita |
| Produccion criogenica de Aquilo | cryogenic-plant o categoria criogenica explicita |
| Logistica orbital y thruster | categoria orbital o de gravedad cero explicita, con restriccion de superficie cuando proceda |
| Energia extrema y fusion | categoria de fusion o energia extrema explicita |
| Defensa avanzada y mech armor | la categoria debe seguir el recurso dominante del tier: metalurgia, electromagnetismo o criogenia |

## Matriz Objetivo Por Bloque

| Bloque | Cadena objetivo | Lectura de implementacion |
| --- | --- | --- |
| Produccion industrial de Vulcanus | calcite -> molten-iron o molten-copper -> tungsten-plate -> tungsten-carbide -> holmium-plate -> supercapacitor -> fluoroketone-hot o fusion-power-cell segun familia | Foundry, crusher y big mining drill deben abrir por metalurgia y solo cargar electronica cuando aparezca control real. |
| Produccion electromagnetica de Fulgora | holmium-plate -> electrolyte -> supercapacitor -> superconductor -> lithium-plate o quantum-processor segun familia | Electromagnetic plant, lightning y recycler deben mantenerse como bloque de control electrico y no mezclarse con metalurgia salvo necesidad real. |
| Produccion biologica de Gleba | jelly -> carbon-fiber -> holmium-plate cuando aparezca control -> supercapacitor -> quantum-processor o lithium-plate segun cierre | Biochamber, biolab, agricultural tower y captive biter spawner deben mantener identidad biologica visible incluso cuando entren en Fulgora o Aquilo. |
| Produccion criogenica de Aquilo | lithium -> lithium-plate -> ammoniacal-solution -> fluorine -> fluoroketone-cold o fluoroketone-hot -> fusion-power-cell si la familia escala a energia extrema | Cryogenic plant y heating tower nacen ya en Aquilo y no necesitan un rodeo artificial por otros planetas. |
| Logistica orbital y de plataforma | metallic-asteroid-chunk o oxide-asteroid-chunk -> thruster-fuel o thruster-oxidizer cuando proceda -> fusion-power-cell -> quantum-processor si la familia necesita control final | Cargo bay, landing pad, collector y thruster deben mostrar de forma explicita su gating orbital o de gravedad cero. |
| Energia extrema y fusion | lithium-plate -> fluoroketone-hot -> fluoroketone-cold -> fusion-power-cell -> fusion-plasma cuando proceda | Fusion generator y reactores de fusion deben mantenerse como bloque energetico extremo, no como un epilogo de Fulgora. |
| Defensa avanzada | tungsten-plate o holmium-plate segun rama -> supercapacitor -> superconductor -> quantum-processor o fusion-power-cell segun arma | Railgun, rocket y tesla SA deben distinguirse por afinidad de arma y no compartir cierre por pura rareza. |
| Equipo y movilidad tardia | holmium-plate -> electrolyte -> supercapacitor -> superconductor -> quantum-processor -> fusion-power-cell solo si la familia lo necesita de verdad | Mech armor debe sentirse como plataforma tardia de control y movilidad, no como una armadura cualquiera con icono SA. |

## Resumen Del Modulo

- Space Age queda separado por planeta, proceso y restriccion de fabricacion en lugar de por una sola escala lineal.
- Las familias SA nativas de Aquilo, orbita y fusion se tratan como excepciones estructurales y no se fuerzan a pasar por rutas artificiales.
- Cuando un bloque nativo sube a una cadena 5Dim completa, Aquilo sigue siendo el cierre preferente salvo que la propia superficie ya nazca alli o exija orbita/gravedad cero.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_space_age/prototypes/.
- Comprobar en juego que cada bloque muestre su edificio de fabricacion y su restriccion de superficie de forma legible y no saltable.
- Comprobar que ningun bloque SA nativo pierda su identidad planetaria por converger artificialmente en una cola comun.