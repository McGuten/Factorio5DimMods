# Resources Resource Matrix

Documento de diseno operativo para 5dim_resources.
Su objetivo es dejar preparado el rediseño de fundicion, triturado, dusts y soporte planetario antes de tocar codigo.

Scope:
- dust families
- electric furnace
- masher
- industrial furnace
- industrial recipes and categories
- planetary resource support

## Principios Del Documento

- La fuente de verdad de superficies es la implementacion actual en mods/5dim_resources/prototypes/.
- Este modulo no se trata como una sola familia; el documento separa bloques de implementacion.
- Electric furnace, industrial furnace y masher deben tener matrices propias y visibles.
- Las dust families se implementan por bandas funcionales y no como una lista plana de recetas clonavadas.
- Las recipe categories son parte central del modulo y deben quedar cerradas aqui antes de tocar codigo.
- Los recursos planetarios y orbitales solo deben aparecer cuando la afinidad del proceso lo pida de verdad.
- Aquilo y orbit se reservan a cierres altos o a subfamilias ya plenamente SA; no se apilan por rutina sobre cualquier horno.

## Regla Operativa De Esta Pasada

- Este documento fija la estructura objetivo del modulo y la separacion por bloques que luego debe reflejarse en recipes, categories y tecnologias.
- Si alguna dust o proceso necesita salir del patron del bloque, debe documentarse junto a la razon y no como excepcion silenciosa en codigo.

## Bloques De Implementacion

| Bloque | Superficie real | Punto de entrada SA | Ruta objetivo |
| --- | --- | --- | --- |
| Electric furnace | gen-electric-furnace.lua | T5 | Vulcanus -> Fulgora -> Aquilo |
| Masher | gen-masher.lua | T5 | Vulcanus -> Gleba/Fulgora -> Aquilo |
| Industrial furnace | industrial-furnace.lua + industrial-recipes.lua | T5 | Vulcanus -> Fulgora -> Aquilo |
| Dust basica | dust-stone.lua, dust-coal.lua | Sin SA obligatoria | Vanilla -> proceso industrial |
| Dust metalica | dust-iron.lua, dust-copper.lua, dust-uranium.lua | T6 segun recurso | Vulcanus -> Fulgora |
| Dust planetaria | dust-calcite.lua, dust-tungsten.lua, dust-holmium.lua, dust-orbit.lua | Ya SA nativa | Planeta/orbita propio -> cierre especifico |
| Soporte planetario | resource-scrap.lua, resource-gleba.lua, resource-aquilo.lua | SA nativa | Fulgora/Gleba/Aquilo segun recurso |

## Bandas Tecnologicas Objetivo

| Bloque | Banda base de ciencia | Regla SA aplicada |
| --- | --- | --- |
| Electric furnace e industrial furnace | T2-T4 chemical/production, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack del planeta del delta visible |
| Masher | T2-T4 logistic/chemical, T5-T7 production, T8-T10 utility | Desde el primer tier SA anade space-science-pack y el pack del planeta del delta visible |
| Dust metalica y planetaria | La ciencia se decide por la banda del recurso y por el proceso de recipe category | Cada recurso planetario exige su botella y su proceso real |
| Soporte orbital | utility + space-science-pack como base minima | Los recursos de gravedad cero u orbita exigen gating orbital explicito |

## Politica De Categorias Objetivo

| Bloque | Categoria esperada |
| --- | --- |
| Electric furnace | crafting vanilla para tiers no SA, metallurgy para Vulcanus, electromagnetics para Fulgora, cryogenics para cierre |
| Industrial furnace | Categoria industrial propia y explicita; no puede quedar implicita |
| Masher | Categoria mecanica o industrial propia y explicita; rutas biologicas o planetarias deben mostrarse en recipe category |
| Dusts metalicas | Categoria industrial o metallurgy segun proceso dominante |
| Dusts de Fulgora | electromagnetics si el recurso visible lo exige |
| Dusts orbitales | categoria y restriccion de orbita o gravedad cero cuando proceda |

## Matriz Objetivo Por Bloque

| Bloque o familia | Cadena vanilla objetivo | Cadena SA objetivo | Lectura de implementacion |
| --- | --- | --- | --- |
| Electric furnace | T2 steel-plate -> T3 stone-brick -> T4 advanced-circuit -> T5 refined-concrete -> T6 processing-unit -> T7 low-density-structure -> T8 productivity-module-2 -> T9 speed-module-2 -> T10 productivity-module-3 | T2 steel-plate -> T3 stone-brick -> T4 advanced-circuit -> T5 calcite -> T6 molten-iron -> T7 tungsten-plate -> T8 holmium-plate -> T9 supercapacitor -> T10 fluoroketone-hot | Es fundicion y calor; debe abrir SA antes por Vulcanus que por cierres de control. |
| Masher | T2 steel-plate -> T3 iron-gear-wheel -> T4 engine-unit -> T5 concrete -> T6 electric-engine-unit -> T7 processing-unit -> T8 low-density-structure -> T9 speed-module-2 -> T10 productivity-module-2 | T2 steel-plate -> T3 iron-gear-wheel -> T4 engine-unit -> T5 calcite -> T6 tungsten-plate -> T7 jelly o carbon-fiber segun subrama -> T8 holmium-plate -> T9 superconductor -> T10 lithium-plate | Debe separar bien subramas mecanicas y biologicas; Gleba solo entra donde el proceso lo justifique. |
| Industrial furnace | T2 steel-plate -> T3 concrete -> T4 refined-concrete -> T5 electric-engine-unit -> T6 processing-unit -> T7 low-density-structure -> T8 battery -> T9 productivity-module-2 -> T10 speed-module-3 | T2 steel-plate -> T3 concrete -> T4 refined-concrete -> T5 calcite -> T6 molten-copper -> T7 tungsten-carbide -> T8 holmium-plate -> T9 supercapacitor -> T10 fusion-power-cell | Es el cierre de proceso industrial pesado del modulo y puede permitirse mas densidad energetica que electric furnace. |
| Dust basica | stone y coal dust se quedan en una progresion industrial vanilla sin overlay SA obligatorio | Sin SA por defecto; solo usan SA si una category o una subrama lo exige de verdad | No deben contaminar todo el modulo con requisitos planetarios innecesarios. |
| Dust metalica | iron, copper y uranium dust suben por triturado, calor y refinado visible | Si reciben SA, debe entrar primero por Vulcanus y despues por Fulgora segun el refinado del recurso | No documentarlas como una sola receta repetida con otro icono. |
| Dust planetaria | calcite, tungsten, holmium y orbit parten ya de recursos SA y deben mantener su afinidad | Cada una sigue el planeta o contexto propio del recurso; orbit exige gating espacial explicito | Son subfamilias SA nativas, no overrides cosmeticos de dust comun. |
| Soporte planetario | Scrap, Gleba y Aquilo se documentan por recurso y por recipe category propia | Cada recurso exige pack planetario, categoria y restriccion de fabricacion coherente | El soporte planetario no debe quedar escondido como detalle secundario de electric furnace. |

## Resumen Del Modulo

- Electric furnace e industrial furnace quedan separados como dos curvas distintas de calor y proceso.
- Masher conserva una identidad mecanica propia y solo mezcla Gleba cuando la subrama lo justifica.
- Dusts y soporte planetario se implementan por bandas de afinidad, no como copias masivas de una misma plantilla.

## Validacion Esperada

- Contrastar cualquier implementacion futura con mods/5dim_resources/prototypes/ y con las recipe categories del modulo.
- Comprobar en juego que cada proceso muestre un lugar de fabricacion claro y no saltable.
- Comprobar que las dusts planetarias u orbitales exijan su gating real y no puedan fabricarse como si fueran polvo vanilla comun.