# Resumen General De Diseno Por Modulos

Documento de consolidacion que preserva la informacion util que vivia en las
antiguas matrix por modulo.

Objetivo:
- conservar bloques funcionales, rutas SA, bandas tecnologicas y categorias
  esperadas por modulo
- dejar visibles las excepciones y validaciones que no conviene perder tras el
  borrado de las matrix
- servir como indice rapido junto a [design-guide.md](design-guide.md)

Este archivo no sustituye a los prototipos.

- La implementacion actual sigue viviendo en mods/5dim_core/lib/costs/ y en
  mods/5dim_*/prototypes/.
- Este documento conserva reglas de lectura y estructura por modulo.

## 5dim_automation

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Assembling machine | T6 | Vulcanus -> Fulgora -> Aquilo |
| Chemical plant | T6 | Fulgora -> Aquilo |
| Lab | T7 | Fulgora -> Aquilo |
| Oil refinery | T4 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: assembling machine usa T4-T6 production y T7-T10 utility; chemical plant usa T2 logistic, T3-T4 chemical, T5-T7 production y T8-T10 utility; lab usa T2-T3 logistic, T4-T5 chemical, T6-T7 production y T8-T10 utility; oil refinery usa T2-T4 chemical, T5-T7 production y T8-T10 utility.
- Categorias: assembling machine entra en metallurgy en T6, electromagnetics en T7-T9 y cryogenics en T10; chemical plant usa crafting-with-fluid en T4-T5 vanilla, chemistry en T6, electromagnetics en T7-T9 y cryogenics en T10; lab entra en electromagnetics en T7-T9 y cryogenics en T10; oil refinery usa crafting-with-fluid en T4 vanilla, metallurgy en T4-T6 SA, electromagnetics en T7-T9 y cryogenics en T10.
- Lectura y validacion: oil refinery es la puerta SA mas temprana del modulo; lab conserva mas tiempo una identidad vanilla; chemical plant debe seguir leyendose como proceso quimico real; Aquilo solo debe aparecer en el ultimo tier de cada familia y la recipe category visible debe coincidir con el edificio esperado.

## 5dim_battlefield

| Bloque | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Gun y mortar turrets | T5 | Vulcanus -> Fulgora -> Aquilo |
| Laser y tesla turrets | T7 | Fulgora -> Aquilo |
| Denegacion quimica | T6 | Vulcanus/Gleba -> Fulgora -> Aquilo |
| Sniper branch | T7 | Fulgora -> Aquilo |
| Combat support | T7 | Fulgora -> Aquilo |
| Walls y gates | T5 | Vulcanus -> Fulgora -> Aquilo |
| Radar | T7 | Fulgora -> Aquilo |
| Artillery branch | T5 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: defensas estaticas y precision usan T2-T4 military/chemical, T5-T7 production y T8-T10 utility; soporte movil usa T2-T4 military/logistic, T5-T7 production y T8-T10 utility; infraestructura defensiva usa T2-T4 logistic/military, T5-T7 production y T8-T10 utility; artilleria usa T2-T4 production/military, T5-T7 utility y T8-T10 utility con SA.
- Categorias: gun, mortar, walls, gates y artilleria usan crafting generico en vanilla, metallurgy cuando domine estructura o chasis, electromagnetics en control tardio y cryogenics solo en cierre; laser, tesla, radar, sniper y combat support usan electromagnetics como categoria SA principal; denegacion quimica debe usar crafting-with-fluid o una categoria de proceso real cuando el delta visible sea acido, veneno, combustible o biologia.
- Lectura y validacion: el modulo se lee por bloques funcionales, no por una cola comun; Gleba solo entra en ramas toxicas o biologicas reales; artilleria puede cerrar con densidad energetica fuerte; tesla, laser, artilleria, soporte movil e infraestructura no deben converger en una misma cola tardia solo con cantidades distintas.

## 5dim_energy

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Accumulator | T6 | Fulgora -> Aquilo |
| Big pole | T7 | Fulgora -> Aquilo |
| Boiler | T5 | Vulcanus -> Fulgora -> Aquilo |
| Lamp | T8 | Fulgora -> Aquilo |
| Medium pole | T7 | Fulgora -> Aquilo |
| Solar panel | T6 | Fulgora -> Aquilo |
| Steam engine | T5 | Vulcanus -> Fulgora -> Aquilo |
| Substation | T7 | Fulgora -> Aquilo |

- Bandas: la red electrica usa T2-T4 logistic, T5-T7 chemical/production y T8-T10 utility; almacenamiento y renovables usan T2-T4 logistic, T5-T7 production y T8-T10 utility; la rama termica usa T2-T4 logistic/chemical, T5-T7 production y T8-T10 utility.
- Categorias: boiler y steam engine usan metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10; accumulator, solar panel, poles, lamp y substation usan electromagnetics en la banda SA de Fulgora y cryogenics solo al cierre.
- Lectura y validacion: boiler y steam engine abren por Vulcanus y no deben volverse simples ramas de control electrico; accumulator, solar panel y la red cargan la mayor parte del peso SA en Fulgora; poles, lamp, substation, accumulator y solar panel no deben convertirse en una misma cola tardia con cantidades distintas.

## 5dim_equipment

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Battery equipment | T8 | Fulgora -> Aquilo |
| Energy shield equipment | T8 | Fulgora -> Aquilo |
| Exoskeleton equipment | T6 | Vulcanus -> Gleba -> Orbita -> Aquilo |
| Fission reactor equipment | T6 | Vulcanus -> Fulgora -> Aquilo |
| Personal laser defense equipment | T8 | Fulgora -> Aquilo |
| Personal roboport equipment | T7 | Fulgora -> Aquilo |
| Personal tesla defense equipment | T7 | Fulgora -> Aquilo |
| Power armor | T6 | Vulcanus -> Gleba -> Orbita -> Aquilo |
| Solar panel equipment | T8 | Fulgora -> Aquilo |
| Night vision equipment | sin ruta SA | MK2 como cap |

- Bandas: plataforma y movilidad usan T2-T4 production, T5-T7 utility y T8-T10 utility con SA; energia y soporte usan T2-T4 chemical/production, T5-T7 utility y T8-T10 utility con SA; defensa personal usa T2-T4 utility, T5-T7 utility alta y T8-T10 utility con SA.
- Categorias: power armor, exoskeleton y fission reactor equipment usan metallurgy en T6-T7 SA y cryogenics en T10; exoskeleton y power armor mantienen crafting generico con gating por carbon-fiber y materiales orbitales en T8-T9; fission reactor equipment usa electromagnetics en T8-T9; el resto del equipo personal usa electromagnetics en su banda SA y cryogenics al final.
- Lectura y validacion: el modulo separa plataforma pesada, energia, defensa y soporte; exoskeleton y power armor son una excepcion canonica que desvia la cola media y tardia a Gleba y orbita; night vision se capea en MK2; power armor no debe recaer por inercia en otra cola Fulgora y las familias de energia portatil, defensa y soporte no deben converger en una sola cola tardia.

## 5dim_logistic

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Construction robot | T6 | Fulgora -> Gleba -> Fulgora -> Orbita -> Aquilo |
| Logistic robot | T6 | Fulgora -> Gleba -> Orbita -> Aquilo |
| Roboport | T7 | Fulgora -> Aquilo |

- Bandas: construction y logistic robot usan T2-T4 logistic/chemical, T5-T7 production y T8-T10 utility; roboport usa T2-T4 production, T5-T7 utility y T8-T10 utility con SA.
- Categorias: robots usan electromagnetics en T6 SA, crafting generico con gating del material visible en T7-T9 redistribuido y cryogenics en T10; roboport usa electromagnetics en T7-T9 y cryogenics en T10.
- Lectura y validacion: construction robot y logistic robot deben divergir de forma material y no solo por cantidades; construction robot es una excepcion canonica porque cruza Gleba y vuelve un escalon a Fulgora antes de orbita; roboport mantiene un cierre mas energetico que los robots; las tres familias no deben converger en la misma cola tardia.

## 5dim_mining

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Electric mining drill | T5 | Vulcanus -> Fulgora -> Aquilo |
| Offshore pump | T7 | Fulgora -> Aquilo |
| Pumpjack | T5 | Vulcanus -> Fulgora -> Aquilo |
| Water pumpjack | T5 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: electric mining drill usa T2-T4 logistic/chemical, T5-T7 production y T8-T10 utility; pumpjack y water pumpjack siguen la misma banda; offshore pump usa T2-T5 logistic/chemical, T6-T8 production y T9-T10 utility.
- Categorias: electric mining drill usa metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10; pumpjack y water pumpjack usan crafting-with-fluid cuando el delta visible es de proceso y luego la misma secuencia metallurgy -> electromagnetics -> cryogenics; offshore pump entra en electromagnetics desde T7.
- Lectura y validacion: mining drill debe sentirse como maquinaria pesada; offshore pump es captacion y red, mas cercana a Fulgora que a una larga cadena metalurgica; pumpjack y water pumpjack comparten afinidad de fluidos pero no deben copiarse entre si; offshore pump no debe heredar por reutilizacion la misma cola tardia de pumpjack.

## 5dim_module

| Familia o bloque | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Beacon | T8 | Fulgora -> Aquilo |
| Speed | T6 opcional | Vanilla tardio -> Vulcanus -> Fulgora -> Aquilo |
| Effectivity | T6 opcional | Vanilla tardio -> Vulcanus -> Fulgora -> Aquilo |
| Productivity | T6 opcional | Vanilla tardio -> Vulcanus -> Fulgora -> Aquilo |
| Pollution standalone | no aplica | Vanilla temprano tras electronics |
| Quality | T6 opcional | Vanilla tardio -> Vulcanus -> Fulgora -> Aquilo |
| Merged | T6 opcional | Sigue la ruta de las tres familias estandar |

- Bandas: speed, effectivity, productivity y quality usan una progresion propia completa T1-T10. T1 define receta base propia; T2-T5 siguen 4 modulos del tier anterior + 1 delta vanilla; T6-T10 mantienen esa regla y, cuando Space Age esta activo, sustituyen el delta base por la ruta calcite -> tungsten-plate -> holmium-plate -> supercapacitor -> quantum-processor. Beacon sigue separado, con entrada SA tardia en T8.
- Categorias: las ramas de modulos mantienen crafting generico fuera de SA y no adelantan categorias especiales solo por introducir deltas SA en T6-T7; electromagnetics sigue en T8-T9 y cryogenics en T10. Beacon mantiene su lectura propia como infraestructura electronica y no como modulo gigante. El pollution module standalone queda fuera de la escalera tiered y usa crafting vanilla temprano.
- Estadisticas del beacon: es la unica familia de maquina que no pasa por el multiplicador exponencial de trabajo (`calculateMachineWorkValue`) ni por `scaleMachineEnergy`. Huecos de modulo y eficiencia de distribucion se multiplican entre si, asi que crecer los dos en exponencial se vuelve cuadratico: llego a 82 huecos y area 64 en el MK10. Sus cuatro ejes viven en la tabla de tiers de `5dim_module/prototypes/gen-beacon.lua` con la misma forma lineal contenida que la linea de modulos que difunde, y por eso tampoco aplica el capstone `5d-machine-t10-extra-module-slots`: los +2 huecos ya estan repartidos por la escalera. Cierre en MK10: 6 huecos x 3.0 de eficiencia, 6x el beacon vanilla.
- Lectura y validacion: Pollution deja de existir como familia tiered, pero se conserva un modulo standalone temprano desbloqueado tras electronics para dar un -8% de pollution con coste solo de circuitos verdes. Merged deja de fusionar cuatro ramas y pasa a combinar speed, effectivity y productivity con receta premium propia. Los modulos no pueden usarse como atajo para abaratar tiers altos y la rama SA debe sentirse ya desde banda media sin abrir una cola larga de Aquilo.

## 5dim_nuclear

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Centrifuge | T5 | Vulcanus -> Fulgora -> Aquilo |
| Heat exchanger | T5 | Vulcanus -> Fulgora -> Aquilo |
| Heat pipe | T5 | Vulcanus -> Fulgora -> Aquilo |
| Nuclear reactor | T5 | Vulcanus -> Fulgora -> Aquilo |
| Steam turbine | T5 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: proceso nuclear y cadena termica usan T2-T4 chemical/production, T5-T7 production y T8-T10 utility; generacion usa T2-T4 production, T5-T7 utility y T8-T10 utility con SA.
- Categorias: reactor, heat exchanger, heat pipe y steam turbine usan metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10; centrifuge sigue el mismo patron como proceso avanzado.
- Lectura y validacion: Nuclear debe mantener identidad de calor, proceso y densidad energetica en todas las familias; Vulcanus abre por calor y metalurgia, Fulgora entra como control de proceso y seguridad; heat exchanger y heat pipe no pueden cerrar exactamente igual que reactor y centrifuge.

## 5dim_resources

| Bloque | Punto de entrada SA | Ruta SA |
| --- | --- | --- |
| Electric furnace | T5 | Vulcanus -> Fulgora -> Aquilo |
| Masher | T5 | Vulcanus -> Gleba/Fulgora -> Aquilo |
| Industrial furnace | T5 | Vulcanus -> Fulgora -> Aquilo |
| Dust basica | sin SA obligatoria | Vanilla -> proceso industrial |
| Dust metalica | T6 segun recurso | Vulcanus -> Fulgora |
| Dust planetaria | SA nativa | planeta u orbita propios |
| Soporte planetario | SA nativa | Fulgora, Gleba o Aquilo segun recurso |

- Bandas: electric furnace e industrial furnace usan T2-T4 chemical/production, T5-T7 production y T8-T10 utility; masher usa T2-T4 logistic/chemical, T5-T7 production y T8-T10 utility; dust metalica y planetaria dependen de la banda del recurso y del proceso; el soporte orbital parte de utility con space-science-pack.
- Categorias: electric furnace usa crafting vanilla en tiers no SA, metallurgy para Vulcanus, electromagnetics para Fulgora y cryogenics para cierre; industrial furnace y masher necesitan categorias propias explicitas; dusts metalicas usan categoria industrial o metallurgy; dusts de Fulgora y orbitales deben mostrar electromagnetics u orbita cuando el recurso lo exija.
- Lectura y validacion: el modulo se divide por bloques y no por una sola familia; dust basica no debe contaminar el modulo con requisitos SA innecesarios; dust planetaria y soporte planetario son subfamilias SA nativas, no overrides cosmeticos; las recipe categories son parte central del comportamiento y cada proceso debe mostrar un lugar de fabricacion claro y no saltable.

## 5dim_space_age

| Bloque | Punto de entrada | Ruta |
| --- | --- | --- |
| Produccion industrial de Vulcanus | Vulcanus nativo | Vulcanus -> Fulgora -> Aquilo cuando haya cadena 5Dim completa |
| Produccion electromagnetica de Fulgora | Fulgora nativo | Fulgora -> Aquilo cuando haya cadena 5Dim completa |
| Produccion biologica de Gleba | Gleba nativo | Gleba -> Fulgora -> Aquilo cuando la familia suba a tiers altos |
| Produccion criogenica de Aquilo | Aquilo nativo | Aquilo nativo |
| Logistica orbital y de plataforma | Orbita nativa | Orbita o gravedad cero -> Aquilo o fusion |
| Energia extrema y fusion | Aquilo u orbita nativos | Aquilo -> fusion u orbita |
| Defensa avanzada | Vulcanus o Fulgora nativos | planeta nativo -> Aquilo |
| Equipo y movilidad tardia | Fulgora nativo | Fulgora -> Gleba -> Aquilo |

- Bandas: familias planetarias nativas usan la botella del planeta nativo como base minima y anaden space-science-pack y la nueva botella planetaria cuando escalan; familias orbitales parten de utility con space-science-pack; Aquilo y fusion parten de cryogenic-science-pack y anaden contexto espacial cuando toca.
- Categorias: cada bloque debe mostrar su edificio o categoria propia de superficie; defensa avanzada sigue el recurso dominante del tier; mech armor usa crafting-with-fluid desde que entra en su cadena propia con fluidos.
- Lectura y validacion: el modulo se lee por superficie real, proceso y restriccion de fabricacion; las familias nativas de Aquilo, orbita y fusion son excepciones estructurales; mech armor es una excepcion canonica porque arranca en Fulgora, cruza Gleba y cierra en Aquilo con una cadena de fluidos; ningun bloque SA nativo debe perder su identidad planetaria por converger artificialmente en una cola comun.

## 5dim_storage

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Logistic chest | T7 | Fulgora -> Aquilo |
| Steel chest | T8 | Fulgora -> Aquilo |
| Storage tank | T5 | Vulcanus -> Fulgora -> Aquilo |
| Storage tank multi | T5 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: cofres usan T2-T4 logistic/chemical, T5-T7 production y T8-T10 utility; tanques usan T2-T4 chemical/production, T5-T7 production y T8-T10 utility.
- Categorias: logistic chest y steel chest usan electromagnetics en T7-T9 SA y cryogenics en T10; storage tank y storage tank multi usan crafting-with-fluid cuando el delta es de proceso, metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10.
- Lectura y validacion: el modulo se divide en almacenamiento solido y de fluidos; los cofres cargan su peso SA casi entero en Fulgora; los tanques abren SA por contencion y material de proceso en Vulcanus; steel chest y logistic chest no deben converger en la misma cola tardia y storage tank multi debe leerse como macroalmacenamiento, no como simple storage tank con mas capacidad.

## 5dim_trains

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Cargo wagon | T5 | Vulcanus -> Fulgora -> Aquilo |
| Fluid wagon | T5 | Vulcanus -> Fulgora -> Aquilo |
| Locomotive | T5 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: cargo wagon y fluid wagon usan T2-T4 chemical/production, T5-T7 production y T8-T10 utility; locomotive usa T2-T4 production, T5-T7 production/utility y T8-T10 utility con SA.
- Categorias: cargo wagon y locomotive usan crafting generico de infraestructura y vehiculo pesado, con metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10; fluid wagon usa crafting-with-fluid cuando el delta es de proceso y sigue el mismo patron SA.
- Lectura y validacion: el modulo abre SA por chasis y material de Vulcanus; locomotive debe mantener una identidad de potencia y traccion distinta de los vagones; cargo wagon y fluid wagon deben separarse por capacidad y contencion, no solo por el tipo de carga; fluid wagon no debe reutilizar por inercia la misma cola tardia que cargo wagon o storage tank.

## 5dim_transport

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Inserter | T7 | Fulgora -> Aquilo |
| Pump | T5 | Vulcanus -> Fulgora -> Aquilo |
| Stack inserter | T7 | Fulgora -> Aquilo |
| Transport belt | T7 | Fulgora -> Aquilo |
| Underground pipe extensions | T5 | Vulcanus -> Fulgora -> Aquilo |

- Bandas: inserters y belts usan T2-T4 logistic/chemical, T5-T7 production y T8-T10 utility; pump y underground pipe extensions usan T2-T4 chemical/production, T5-T7 production y T8-T10 utility.
- Categorias: inserter, stack inserter y transport belt usan electromagnetics en T7-T9 SA y cryogenics en T10; pump y underground pipe extensions usan crafting-with-fluid cuando el delta es de proceso, metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10.
- Lectura y validacion: el modulo separa manipulacion de items, transporte continuo y fluidos; Fulgora es el eje del control fino y Vulcanus abre solo las ramas de fluidos; la dependencia de Bob Inserters debe seguir cubierta en prerequisitos y gating; belt, inserter, stack inserter, pump y tuberias no deben colapsar en la misma identidad material.

## 5dim_vehicles

| Familia | Primer tier SA | Ruta SA |
| --- | --- | --- |
| Tank | T5 | Vulcanus -> Fulgora -> Aquilo |
| Spidertron | T8 | Gleba -> Orbita -> Aquilo |

- Bandas: tank usa T2-T4 production, T5-T7 utility y T8-T10 utility con SA; spidertron usa T2-T4 utility, T5-T7 utility alta y T8-T10 utility con SA.
- Categorias: tank usa metallurgy en T5-T7 SA, electromagnetics en T8-T9 y cryogenics en T10; spidertron usa crafting generico con gating por carbon-fiber y materiales orbitales en T8-T9 y cryogenics en T10.
- Lectura y validacion: tank y spidertron no deben compartir una cola tardia indistinguible; spidertron es una excepcion canonica porque entra en SA real desde T8 con huella de Gleba y orbita antes del cierre de Aquilo; tank debe seguir leyendose como blindado pesado de estructura y potencia.

## Patrones Que Conviene Preservar

- Los modulos complejos se leen por bloques funcionales y no por una sola cola material comun.
- Aquilo cierra una vez cada familia o bloque salvo excepcion estructural explicita.
- Gleba solo entra cuando la afinidad biologica, toxica o de material organico es real.
- Orbita y gravedad cero deben aparecer por gating espacial explicito o por materiales orbitales visibles.
- Las recipe categories y restricciones de fabricacion forman parte del comportamiento, no de la presentacion.
- Las validaciones importantes son sobre identidad material, no solo sobre cantidades o posiciones de tier.