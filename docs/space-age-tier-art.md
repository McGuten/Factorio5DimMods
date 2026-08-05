# Arte Por Tier De Space Age: Capa Base Vanilla + Overlay

Como se cablea el arte por tier de `5dim_space_age` sin pasarse del limite del
Mod Portal. Documenta la decision, la investigacion que la respalda y lo que
queda pendiente, para no repetir callejones sin salida ya explorados.

Fecha del trabajo: 2026-08-04.

## El problema

`5dim_space_age` no se podia publicar: pesaba **953 MiB** y el portal corta en
**262 MB por archivo**. Era el unico de los 22 mods de la familia sin publicar.

La causa era `graphics/entity/`: **994 MB en 414 PNG** de arte recoloreado por
tier que **no estaba cableado a ningun prototipo**. Los generadores de
[../5dim_core/lib/space-age/](../5dim_core/lib/space-age/) clonaban la entidad
vanilla y solo cambiaban el icono, asi que ese arte viajaba en el zip sin que el
juego lo usara nunca. Es decir: se pagaba todo el peso y no se veia nada.

## Lo que resulto ser el arte

Medido pixel a pixel contra `data/space-age/`:

- El arte de 5Dim **es el arte vanilla con una region concreta recoloreada**.
  Mismas dimensiones de fotograma, misma alineacion (shift 0,0), mismo bounding
  box, alpha identico salvo un 0.16-1.5% de pixeles con desviacion media 0.04-0.53.
- Entre los 10 tiers solo cambia el **1-32% de los pixeles** segun la entidad.
- El **canal alpha es identico** en los 10 tiers.
- La **region recoloreada es la misma** para los 10 tiers.
- Los sheets arrastran una deriva global de re-guardado respecto a la vanilla
  (error RGB medio 4-26): se guardaron desde un editor que movio ligeramente
  todos los canales.

De ahi la decision: **la imagen base no hace falta enviarla**, es la vanilla, que
Factorio ya tiene cargada. Solo se envia la region recoloreada.

## La arquitectura

Cada sprite del cuerpo principal pasa a ser dos `layers`:

```
capa 1 = el sprite VANILLA, intacto            -> 0 bytes enviados, ya esta en el atlas
capa 2 = la region recoloreada del tier N      -> lo unico que se envia
```

La capa 2 se construye como **copia de la capa vanilla con las rutas cambiadas**,
asi que hereda `width`, `height`, `line_length`, `frame_count`, `shift`, `scale`,
`repeat_count` y `lines_per_file`. **No se inventa geometria en ningun momento**,
que es lo que mantiene bajo el riesgo.

Son **10 overlays por sheet, tier 1 incluido**: su recolor amarillo forma parte
del diseno. El tier 1 no crea prototipo nuevo (`isVanilla = true`), pero los
generadores ya sobrescriben la entidad vanilla en `data:extend`, asi que encaja.

Piezas:

| archivo | que hace |
| --- | --- |
| [../scripts/extract-tier-overlays.py](../scripts/extract-tier-overlays.py) | genera los overlays y el manifiesto desde los PNG originales |
| [../5dim_core/lib/space-age/tier-art.lua](../5dim_core/lib/space-age/tier-art.lua) | inserta la capa de overlay en el prototipo |
| [../5dim_core/lib/graphics-tree.lua](../5dim_core/lib/graphics-tree.lua) | recorrido generico del arbol de graphics, compartido |
| [../5dim_core/lib/tier-tint.lua](../5dim_core/lib/tier-tint.lua) | **reserva**: tinte sobre arte vanilla para entidades sin overlay |
| `5dim_space_age/graphics/tier-overlay/manifest.lua` | generado; mapea capa vanilla -> overlays |

## Alternativas descartadas, con sus medidas

No volver a intentar estas sin datos nuevos:

| alternativa | por que no |
| --- | --- |
| Reproducir el recolor con `tint` de Factorio | Probados multiply, screen, overlay, hard-light y soft-light contra `tier-colors.lua`, y la hipotesis de que el tier 8 (blanco) fuera la base sin tintar. Todas fallan: los canales que deberian quedar intactos se desvian hasta 128/255. El recolor se hizo con rotacion de tono en un editor. |
| Deducir la region por color (permitiria regenerarla sin mapa posicional) | Falla en dos variantes: regla de rango de tono (IoU 2-34%) y clasificador aprendido sobre color cuantizado a 3/4/5 bits por canal (IoU 1-55%, con 3-46% de colores ambiguos). Dentro y fuera de la region los histogramas de tono son casi iguales: **la seleccion es espacial, hecha a mano**. |
| Trocear el mod por planetas | No resuelve nada: Fulgora sola (recycler 305 MB + electromagnetic-plant 171 MB) son **477 MB**, casi el doble del limite. Ademas multiplica por cinco `info.json`, changelogs, sincronizacion de locale y dependencias. |
| Cuantizar a paleta de 256 colores | Baja a ~155 MB pero **rompe el alpha exacto** en todas las muestras, lo que ensucia los bordes de todas las maquinas. |
| Recortar los overlays para ahorrar VRAM | La region recoloreada esta repartida por el fotograma, no concentrada: el recorte uniforme solo baja al 43-82% del area. No compensa. |
| Enviar la base vieja para el grupo B | Esas maquinas se verian con el render de Factorio 2.0.x, inconsistentes con el resto del juego. |
| Aprender el mapeo de color de una entidad y aplicarlo a otra | El auto-ajuste dentro de una entidad es casi perfecto (error 0.9-9.7) pero **entre entidades no generaliza** (p99 de 30-75). El LUT por luminancia generaliza algo mejor (error medio 6.4-9.4) y es lo que usa la rama B. |

## Coste en VRAM: asumido a proposito

Cablear el arte anade **~858 Mpx al atlas de sprites, unos +860 MB de VRAM** con
DXT. Referencia medida del log: 34 paginas de atlas, 3.74 Gpx ≈ 3.7 GB.

Esto es **independiente del ahorro en disco y no lo arregla ningun empaquetado**:
el atlas se reserva por dimensiones del sprite, no por el peso del PNG. Se
considero un startup setting para desactivarlo y se descarto por decision
explicita del usuario (2026-08-04): arte detallado siempre, una sola ruta de codigo.

## Grupos A y B

La clasificacion se hace **a nivel de fotograma, no de sheet completo**, y el
discriminador bueno es la **IoU de silueta**, no el error de color:

- **Grupo A**: IoU >= 98.5% contra la vanilla actual. Mismo render; la region se
  aplica directa. El error de color va de 4 a 26 (deriva de re-guardado).
- **Grupo B**: Wube volvio a renderizar el arte despues de dic-2024. IoU 87-90%,
  error RGB fuera de la region 45.7. Con reescalado solo sube al 90%, y con
  ratios no uniformes (recycler: ancho x1.15, alto x0.98). No es otro recorte,
  es otro dibujo.

Trampa comprobada: `asteroid-collector` parecia grupo B por dimensiones de sheet
completo, y `crusher` parecia grupo B por error de color. Ambas lecturas eran
falsas. Comparar fotograma contra fotograma y mirar la IoU.

### Grupo A: convertido y validado en juego

biochamber, foundry, biolab, crusher, electromagnetic-plant, fusion-generator,
fusion-reactor, lightning-collector, big-mining-drill, thruster.

**575 MB de originales -> 63 MB de overlays** (24 sheets). Los 230 PNG originales
se borraron del arbol de trabajo.

### Grupo B: parado (2026-08-04)

Plan de ejecucion detallado en
[plans/space-age-tier-art-group-b.md](plans/space-age-tier-art-group-b.md).

| entidad | peso | situacion |
| --- | --- | --- |
| recycler | 291 MB | **caso facil**: conserva la estructura igual que foundry, el metodo ya validado sirve tal cual. Son 8 sheets en vez de 2 |
| agricultural-tower | 40 MB | **cambio estructural**: sus 64 fotogramas animados pasaron a un base estatico (`repeat_count = 64`) mas una capa `anim` aparte de 192x168. No hay donde mapearlos |
| asteroid-collector | 34 MB | mismo cambio estructural: rejilla 4x4 animada frente a un base vanilla estatico, con la animacion movida a `*-anim.png` |
| rocket-silo | 9.4 MB | el arte de 5Dim coincide con la variante `-frozen` (608x596); el sheet real crecio a 628x612 |

Para agricultural-tower y asteroid-collector la salida realista es
`applyTierTint`, que cuesta 0 MB y 0 VRAM.

### Fuera del sistema

- `platform-hub` (4.1 MB): arte huerfano, ningun generador construye un
  `space-platform-hub` por tiers.
- `mech-armor` (160 KB): no es arte de entidad, es un **icono de 120x64 con
  cadena de mipmaps** (64+32+16+8) colocado en `graphics/entity/` por error.
- `big-mining-drill-{N,E,S,W}-top.png`: sin sufijo de tier, no forman familia.
- `fusion-reactor-equipment` (632 KB): ya cableado como arte completo desde
  [../5dim_core/lib/equipment/generation-fusion-reactor-equipment.lua](../5dim_core/lib/equipment/generation-fusion-reactor-equipment.lua).
  Se deja como esta.

## Detalles de implementacion que costaron encontrarse

**El recorrido del arbol tiene que ser generico.** Cada tipo de entidad coloca su
arte en un sitio distinto y enumerarlos es fragil:

| entidad | donde vive el arte |
| --- | --- |
| biochamber, foundry | `graphics_set.animation.layers[N]` |
| crusher, big-mining-drill | `graphics_set.animation.<direccion>` (animation4way) |
| electromagnetic-plant | `graphics_set.working_visualisations[N].animation` |
| fusion-generator | `graphics_set.<direccion>_graphics_set.animation` |
| fusion-reactor | `graphics_set.structure` |
| biolab (tipo `lab`) | `on_animation` y `off_animation` |
| lightning-collector | `chargable_graphics.picture` |
| space-platform-hub | `graphics_set.picture[3]` |

Se obtuvieron del `--dump-data` de Factorio, que es la fuente autoritativa.

**Tablas compartidas.** `graphics-tree.lua` lleva un registro de tablas visitadas.
Sin el, crusher recibia el overlay dos veces porque referencia el mismo sprite
desde norte y sur.

**Overlays heredados entre tiers.** El tier 1 sobrescribe el prototipo vanilla con
`data:extend`, y los tiers siguientes hacen `table.deepcopy` de `data.raw`, asi
que heredaban el overlay de los anteriores: el tier 5 llevaba amarillo *y* verde
apilados. Se veia bien de casualidad (misma region opaca) pero era VRAM tirada y
habria dado color incorrecto en cualquier pixel semitransparente. `tier-art.lua`
limpia los overlays heredados antes de insertar el suyo.

**Parpadeo en la rama B.** Reconstruir la region fotograma a fotograma la hacia
oscilar un 1.30% de media y hasta 7.87% entre fotogramas consecutivos, mientras
que el arte original era estable al 0.01%. La causa: la region recoloreada es
**estatica** (se mantiene al 99.91% de IoU en los 64 fotogramas aunque el cuerpo
anime). Se resuelve calculandola **una vez** y estampandola en todos los
fotogramas; asi la variacion baja a 0.00%.

**Capas multi-archivo.** Un solo `util.sprite_load` puede abarcar varios PNG
(`filenames` + `lines_per_file`): foundry-anim son 2 archivos y 128 fotogramas;
thruster igual; electromagnetic-plant-main-rotate son 2 archivos y 111 fotogramas.
El manifiesto se indexa por `filenames[1]` y la lista de overlays refleja la del
sheet vanilla.

## Como regenerar los overlays

Los overlays se generan **a partir de los PNG originales**, que ya **no estan en
el arbol de trabajo** pero si en git. Hay que restaurarlos primero:

```powershell
# 1. recuperar los originales de la entidad que toque
git checkout -- 5dim_space_age/graphics/entity/<entidad>

# 2. regenerar (el script se autoverifica: compone vanilla+overlay y lo compara)
wsl -e /mnt/d/factorioDev/venv/bin/python -P mods/scripts/extract-tier-overlays.py --verify

# opciones utiles
#   --only <entidad>   restringe a una entidad (repetible)
#   --clean            limpia el directorio de salida antes
#   --contact <dir>    saca una tira con los 10 tiers para revision visual
```

El script corre en el venv de WSL (`venv/`), que tiene numpy, Pillow y scipy.

## Como validar

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\mods\scripts\validate-factorio-profiles.ps1 -TestSet Smoke
```

El perfil aislado `module-5dim_space_age` falla por `5d-electric-mining-drill-02`,
que es de `5dim_mining`: es un problema de dependencias del perfil, ajeno a esto.

Que las suites pasen **no prueba que los overlays se esten cargando**: si el
`require` del manifiesto fallara, `tier-art.lua` caeria al tinte de reserva y
tambien pasarian. Para prueba positiva, volcar los prototipos y contar las capas:

```powershell
& "d:\factorioDev\bin\x64\factorio.exe" --config <config> --mod-directory "d:\factorioDev\mods" --dump-data
```

y comprobar en `script-output/data-raw-dump.json` que cada tier lleva exactamente
sus overlays y ninguno ajeno.

La revision final es visual, en el juego: colocar los 10 tiers en fila **y dejarlos
funcionando**, no solo parados, porque el parpadeo solo se ve con la animacion en
marcha.

## Estado

Tras el grupo A, el mod esta en **448 MB**: sigue por encima de los 262 MB. **La
publicacion depende de terminar el grupo B**, que es el grueso que queda.
