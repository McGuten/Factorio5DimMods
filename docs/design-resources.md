# Catalogo De Recursos Para Rediseño De Tiers

Documento de trabajo para el rediseño de costes y progresion tiered de 5Dim.

Objetivo:
- Tener una base comun de recursos candidatos para recetas y gating.
- Separar claramente vanilla y Space Age.
- Separar items y liquidos.
- Etiquetar cada recurso por categoria funcional y por banda de complejidad.
- Fijar una regla acumulativa comun para las matrices: cada tier 5Dim parte de la receta acumulada anterior y suma un unico delta no redundante.

Reglas base del rediseño:
- Los tiers vanilla se respetan intactos.
- Este catalogo se usa solo para tiers propios de 5Dim.
- No todos los modulos deben consumir el mismo recurso en el mismo tier.
- La afinidad tematica del modulo manda mas que la rareza pura del recurso.
- Los liquidos no deben meterse por defecto en todas las recetas; se reservan para familias donde tenga sentido de proceso.
- En familias con base vanilla, el coste del primer tier 5Dim arranca desde la receta vanilla completa del item base y anade un delta propio del tier.
- En familias 100% 5Dim, el T1 define la receta base y cada tier posterior anade un delta nuevo.
- El delta de un tier debe ser un recurso nuevo para esa familia; no puede repetir el item base, el item del tier anterior ni materias primas ya encapsuladas por esos items.
- La ruta Space Age sustituye el delta vanilla del tier por su delta planetario equivalente; no se suma encima del delta vanilla salvo que la familia lo documente expresamente.
- Las matrices deben mostrar las dos cosas: el delta que entra en cada tier y la receta acumulada resultante.
- La receta visible del tier no puede abaratarse de forma brusca respecto a tiers anteriores. El item del tier previo encapsula historia, pero no justifica que el nuevo escalon parezca casi gratis en ingredientes directos.
- Si una familia reutiliza una misma linea de recursos de control o optimizacion, la presion visible no debe caer al subir de banda. No vale pasar de varios modulos medios a una sola unidad tardia sin una justificacion funcional documentada.
- Los modulos se tratan como recursos de ajuste fino, no como descuento de recipe cost. En maquinaria industrial generalista no deberian ser el unico delta visible de un tier alto salvo excepcion muy clara.
- En Space Age, el delta planetario del tier sustituye por completo al delta vanilla directo en la receta visible. Puede quedar el item del tier previo, pero no deben convivir ambos deltas directos del mismo escalon.
- En familias backbone de produccion, proceso o infraestructura generalista, activar Space Age debe aumentar de verdad el peso planetario desde fases medias del arbol 5Dim. No basta con dejar casi toda la receta en vanilla y anadir un cierre simbolico en T8-T10.
- En familias industriales generalistas, Aquilo debe concentrarse preferentemente en un unico tier final visible; dos tiers finales ya son una concesion excepcional y mas de eso cuenta como senal de sobreextension.
- Como heuristica, las maquinas industriales generalistas suelen abrir mejor la rama SA temprana por Vulcanus, pasar por Fulgora para control fino y reservar Aquilo para el cierre final o casi final solo cuando la afinidad del modulo lo sostenga de verdad.

Escala de complejidad:
- Muy baja
- Baja
- Media
- Alta
- Muy alta

Categorias funcionales:
- Estructura
- Metalurgia
- Electronica
- Fluidos y proceso
- Energia
- Logistica
- Ciencia
- Biologico
- Criogenico
- Orbital

Nota:
- Este documento lista recursos reales.
- No se incluyen nombres de recetas como molten-iron-from-lava o molten-copper-from-lava, porque no son recursos sino rutas de produccion.

## Reglas Operativas De Aplicacion

Estas reglas no sustituyen la afinidad del modulo, pero sirven para frenar errores sistemicos al convertir la matriz en recetas reales.

| Problema a evitar | Regla operativa |
| --- | --- |
| Tier alto aparentemente mas barato que uno medio | Mantener o subir la presion visible del coste directo. Si el tier anterior exigia varios recursos de control o produccion, el siguiente no debe caer a un unico ingrediente simbolico sin compensacion clara. |
| Modulos usados como atajo de cierre | Los modulos no deben abaratar el escalon. Si aparecen como delta de tier alto, su cantidad o su contexto deben seguir sintiendose de coste alto y no como simple token. |
| Receta SA duplicada | En la variante SA se elige delta vanilla o delta planetario, nunca ambos como ingredientes directos del mismo tier. El override debe sustituir, no apilar. |
| Rama SA demasiado tardia | En familias backbone, la rama SA debe sentirse antes del cierre final. Si el modulo ya esta en fase industrial media, conviene introducir coste planetario visible desde ahi. |
| Maquina generalista demasiado vanilla con SA activo | Priorizar primero refuerzo estructural o metalurgico de Vulcanus y despues cierres electromagneticos. Reservar Aquilo preferentemente para el ultimo tier visible y no para una cola larga. |
| Liquidos metidos sin proceso real | Reservar fluidos para familias que realmente se lean como quimica, refino, fundicion, criogenia o espacio. Si un tier usa fluido, la categoria de receta y el gating deben reflejarlo. |

## Vanilla

### Items

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| stone | Estructura | Muy baja | Base de construccion |
| coal | Fluidos y proceso | Muy baja | Combustible y quimica temprana |
| iron-plate | Estructura | Muy baja | Material estructural base |
| copper-plate | Electronica | Muy baja | Base electrica y cableado |
| steel-plate | Estructura | Baja | Salto industrial natural |
| stone-brick | Estructura | Muy baja | Infraestructura temprana |
| concrete | Estructura | Baja | Infraestructura industrial |
| refined-concrete | Estructura | Media | Refuerzo tardio |
| iron-gear-wheel | Estructura | Muy baja | Mecanica comun |
| iron-stick | Estructura | Muy baja | Soporte metalico |
| pipe | Fluidos y proceso | Muy baja | Red de fluidos |
| pipe-to-ground | Fluidos y proceso | Baja | Infra avanzada de fluidos |
| engine-unit | Energia | Media | Maquinaria y vehiculos |
| electric-engine-unit | Energia | Media | Sistemas electricos avanzados |
| battery | Energia | Media | Energia portable e intermedia |
| sulfur | Fluidos y proceso | Media | Quimica industrial |
| plastic-bar | Fluidos y proceso | Media | Quimica y electronica |
| explosives | Fluidos y proceso | Media | Militar y mineria especial |
| electronic-circuit | Electronica | Muy baja | Base de automatizacion |
| advanced-circuit | Electronica | Baja | Salto industrial y control |
| processing-unit | Electronica | Alta | Electronica tardia |
| low-density-structure | Estructura | Alta | Material tardio multiuso |
| speed-module | Electronica | Media | Optimizacion inicial |
| speed-module-2 | Electronica | Alta | Optimizacion tardia |
| speed-module-3 | Electronica | Muy alta | Optimizacion endgame |
| productivity-module | Electronica | Media | Produccion avanzada |
| productivity-module-2 | Electronica | Alta | Produccion tardia |
| productivity-module-3 | Electronica | Muy alta | Produccion endgame |
| efficiency-module | Electronica | Media | Eficiencia energetica |
| flying-robot-frame | Logistica | Alta | Rama robotica |
| transport-belt | Logistica | Muy baja | Logistica temprana y soporte de labs |
| fast-transport-belt | Logistica | Baja | Escalon medio logistico |
| express-transport-belt | Logistica | Alta | Escalon tardio logistico |
| automation-science-pack | Ciencia | Muy baja | Ciencia base |
| logistic-science-pack | Ciencia | Baja | Ciencia temprana |
| chemical-science-pack | Ciencia | Media | Ciencia industrial |
| production-science-pack | Ciencia | Alta | Ciencia de fabrica |
| utility-science-pack | Ciencia | Muy alta | Ciencia tardia |
| space-science-pack | Ciencia | Muy alta | Ciencia orbital vanilla |

### Liquidos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| water | Fluidos y proceso | Muy baja | Fluido universal |
| steam | Energia | Muy baja | Energia termica base |
| crude-oil | Fluidos y proceso | Baja | Inicio de la petroquimica |
| heavy-oil | Fluidos y proceso | Media | Quimica avanzada |
| light-oil | Fluidos y proceso | Media | Combustibles y cracking |
| petroleum-gas | Fluidos y proceso | Media | Base plastico y azufre |
| sulfuric-acid | Fluidos y proceso | Media | Baterias, uranio y quimica |
| lubricant | Energia | Media | Mecanica avanzada |

## Space Age

### Vulcanus

#### Items

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| calcite | Metalurgia | Media | Entrada a rutas metalurgicas |
| tungsten-plate | Metalurgia | Media | Material estructural pesado |
| tungsten-carbide | Metalurgia | Media | Escalon metalurgico tardio |

#### Liquidos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| lava | Fluidos y proceso | Media | Fluido planetario base de Vulcanus |
| molten-iron | Metalurgia | Media | Fundicion avanzada |
| molten-copper | Metalurgia | Media | Fundicion avanzada |

### Fulgora

#### Items

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| scrap | Electronica | Media | Recurso base de reciclaje |
| holmium-plate | Electronica | Alta | Entrada electromagnetica |
| supercapacitor | Electronica | Muy alta | Almacenamiento energetico avanzado |
| superconductor | Electronica | Muy alta | Material electromagnetico avanzado que luego cruza con Aquilo |

#### Liquidos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| holmium-solution | Electronica | Alta | Proceso intermedio de Fulgora |
| electrolyte | Electronica | Alta | Base de supercapacitores y superconductores |

### Gleba

#### Items

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| jelly | Biologico | Media | Intermedio organico |
| bioflux | Biologico | Alta | Intermedio biologico central de Gleba |
| carbon-fiber | Biologico | Alta | Material avanzado organico |

#### Liquidos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| Ninguno nuevo de uso general | Biologico | Alta | Gleba se apoya en jelly, bioflux y carbon-fiber; no se consideran fluidos propios como recurso de diseño general |

### Aquilo

#### Items

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| lithium | Criogenico | Muy alta | Materia prima de Aquilo |
| lithium-plate | Criogenico | Muy alta | Entrada criogenica |
| quantum-processor | Criogenico | Muy alta | Computacion endgame |
| fusion-power-cell | Energia | Muy alta | Fusion y endgame espacial |

#### Liquidos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| ammoniacal-solution | Criogenico | Muy alta | Fluido de entrada de Aquilo |
| ammonia | Criogenico | Muy alta | Quimica y combustible |
| fluorine | Criogenico | Muy alta | Quimica avanzada de Aquilo |
| lithium-brine | Criogenico | Muy alta | Intermedio de litio |
| fluoroketone-cold | Criogenico | Muy alta | Variante fria de ciclo criogenico |
| fluoroketone-hot | Criogenico | Muy alta | Variante caliente de ciclo criogenico |
| fusion-plasma | Energia | Muy alta | Fluido extremo de fusion |

### Recursos Orbitales Y Espaciales

#### Recursos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| metallic-asteroid-chunk | Orbital | Media | Recoleccion espacial |
| carbonic-asteroid-chunk | Orbital | Media | Recoleccion espacial |
| oxide-asteroid-chunk | Orbital | Media | Recoleccion espacial |
| promethium-asteroid-chunk | Orbital | Muy alta | Recurso espacial tardio |

### Fluidos Fabricados En Gravedad Cero

Estos fluidos no son solo "espaciales" por uso: en vanilla Space Age sus recetas exigen gravedad 0, asi que conviene tratarlos como una familia separada de proceso.

#### Fluidos

| Recurso | Categoria | Complejidad | Notas |
| --- | --- | --- | --- |
| thruster-fuel | Gravedad cero | Alta | Propulsion espacial; su receta vanilla de Space Age exige gravedad 0 |
| thruster-oxidizer | Gravedad cero | Alta | Propulsion espacial; su receta vanilla de Space Age exige gravedad 0 |

## Uso Recomendado En Diseño

### Reglas Practicas

- Storage, trenes y transporte pesado deben priorizar estructura y metalurgia.
- Labs, modulos, robots y edificios de control deben priorizar electronica y electromagnetismo.
- Gleba se apoya en jelly, bioflux y carbon-fiber, y debe quedarse casi siempre dentro de familias biologicas o muy tematizadas.
- Aquilo, orbital y procesos de gravedad cero deben reservarse para cierres altos o para familias propias de Space Age. En familias generalistas, Aquilo deberia aparecer idealmente solo en el ultimo tier visible.
- Los liquidos tienen mas sentido en quimica, refino, criogenia, fundicion y espacio que en cofres, belts o entidades puramente mecanicas.
- No se usan ores como recurso de diseño en las matrices; solo materiales ya procesados o intermediarios con identidad funcional clara.
- Los fluidos de thruster conviene separarlos de los recursos orbitales generales: su identidad mecanica real es de fabricacion en gravedad cero.
- Si un candidato de tier resulta redundante por venir ya absorbido en la receta base o en el item previo, hay que reemplazarlo por otro recurso de complejidad comparable, no duplicarlo.
- En familias industriales generalistas con Space Age activo, conviene que la primera presion SA visible entre antes por Vulcanus que por cierres muy tardios de Fulgora o Aquilo.
- Si una familia generalista ya uso Vulcanus y Fulgora para construir identidad SA, no hace falta alargar Aquilo: un unico tier final suele ser la forma preferente de cierre.
- Si una rama SA existe, debe sentirse en la receta visible; no deberia quedar reducida a un adorno tardio mientras casi toda la curva sigue siendo puramente vanilla.
- Si el delta de un tier es un modulo o un recurso de control muy concentrado, comprobar que el coste directo visible no se hunda frente al tier anterior.

### Atajos Por Afinidad

- Estructural y metalurgica: steel-plate, concrete, refined-concrete, low-density-structure, calcite, tungsten-plate, tungsten-carbide, molten-iron, molten-copper.
- Electronica y electromagnetica: electronic-circuit, advanced-circuit, processing-unit, holmium-plate, electrolyte, superconductor, supercapacitor.
- Biologica: jelly, bioflux, carbon-fiber.
- Criogenica: lithium-plate, ammoniacal-solution, ammonia, fluorine, lithium-brine, fluoroketone-cold, fluoroketone-hot, quantum-processor.
- Orbital: asteroid chunks, fusion-power-cell, space-science-pack.
- Gravedad cero: thruster-fuel, thruster-oxidizer.

### Recursos A Usar Con Cuidado Como Gating Global

- processing-unit
- low-density-structure
- speed-module-2
- speed-module-3
- productivity-module-2
- productivity-module-3
- tungsten-carbide
- supercapacitor
- superconductor
- quantum-processor
- fluoroketone-cold
- fluoroketone-hot
- fusion-plasma

### Recursos Seguros Para Introduccion Temprana O Media En Tiers 5Dim

- steel-plate
- concrete
- refined-concrete
- pipe
- battery
- engine-unit
- electric-engine-unit
- advanced-circuit
- calcite
- molten-iron y molten-copper en ramas claramente metalurgicas
- holmium-plate en ramas claramente electromagneticas

### Recursos Recomendados Para Presion SA Temprana En Familias Backbone

- Vulcanus temprano: calcite, molten-iron, molten-copper y, con mas cuidado, tungsten-plate.
- Fulgora media: holmium-plate y electrolyte cuando la familia ya este claramente en fase de control fino o proceso avanzado.
- Aquilo tardio: fluoroketone, lithium y quantum-processor como cierres, no como parche para ramas que aun no hayan ganado peso planetario antes. En familias generalistas, preferir un unico tier final de Aquilo y tratar un segundo tier como excepcion a justificar.

### Recursos Poco Adecuados Como Unico Delta Visible De Tier Alto

- speed-module-2
- speed-module-3
- productivity-module-2
- productivity-module-3
- supercapacitor
- superconductor

Nota:
- Pueden usarse como parte del cierre de una familia, pero no deberian aparecer como unico salto visible si eso hace que el tier alto se perciba mas barato que los anteriores.

### Sugerencia De Uso Por Fase

| Fase | Recursos candidatos |
| --- | --- |
| Muy baja | iron-plate, copper-plate, stone-brick, pipe, electronic-circuit |
| Baja | steel-plate, concrete, battery, advanced-circuit |
| Media | refined-concrete, electric-engine-unit, sulfur, plastic-bar, calcite, tungsten-plate, tungsten-carbide, lava, molten metals, orbital chunks |
| Alta | processing-unit, low-density-structure, holmium-plate, zero-g crafted fluids |
| Muy alta | lithium-plate, ammoniacal-solution, ammonia, fluorine, lithium-brine, supercapacitor, superconductor, quantum-processor, fluoroketone, fusion-plasma, promethium |