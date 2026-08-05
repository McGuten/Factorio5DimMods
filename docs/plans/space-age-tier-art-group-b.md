# Plan: arte por tier de Space Age, grupo B

Continuacion de [../space-age-tier-art.md](../space-age-tier-art.md), que es la
fuente de verdad de como funciona el sistema. Este documento solo cubre **lo que
queda pendiente**: las cuatro entidades cuyo arte Wube volvio a renderizar.

Estado al escribirlo: 2026-08-04. Grupo A terminado y validado en juego.

## Por que importa

`5dim_space_age` esta en **448 MB** y el limite del portal son **262 MB**. Es el
unico de los 22 mods de la familia sin publicar. El grupo B es lo unico que
impide bajar del limite.

## La cuenta, que decide el orden de trabajo

| accion | ahorro | mod queda en |
| --- | ---: | ---: |
| estado actual | — | **448 MB** |
| convertir **solo recycler** (291 MB -> ~27 MB) | 264 MB | **~184 MB** |
| + borrar arte huerfano (platform-hub 4.1, mech-armor 0.16, big-mining-drill-*-top 3.5) | 7.8 MB | ~176 MB |
| + agricultural-tower, asteroid-collector y rocket-silo a `tier-tint` y borrar su arte | 83.4 MB | **~92 MB** |

**Con convertir el recycler ya se puede publicar.** Todo lo demas es limpieza que
puede ir despues. Empezar por ahi.

La estimacion de ~27 MB sale de aplicar al recycler la proporcion medida en
foundry, que es el mismo caso: 9.1% y 8.3% en sus dos sheets.

## Antes de empezar: recuperar los originales

Los PNG del grupo A se borraron del arbol de trabajo, pero **los del grupo B
siguen ahi**. Solo hace falta `git checkout` si alguien los borro despues:

```powershell
git -C mods checkout -- 5dim_space_age/graphics/entity/recycler
```

El script corre en el venv de WSL (`venv/`), que ya tiene numpy, Pillow y scipy.

## Caso 1: recycler — el facil, y el que desbloquea la publicacion

Conserva la estructura exacta del arte antiguo: 8 sheets, rejillas 8x8, 64
fotogramas cada uno. Solo cambio el tamano de fotograma. Es el mismo caso que
foundry, que ya esta validado, con 8 sheets en vez de 2.

### Datos ya medidos

- Prototipo: `data.raw["furnace"]["recycler"]`, generador
  [../../5dim_core/lib/space-age/generation-recycler.lua](../../5dim_core/lib/space-age/generation-recycler.lua).
- **El arte vanilla vive en el mod `__recycler__`, no en `__space-age__`.** Ojo al
  escribir los `leaf` del manifiesto.
- El cuerpo esta en `graphics_set.animation.<direccion>.layers[0]`; `layers[1]` es
  la sombra y el recorrido ya la salta. Las luces son glow aditivo y tambien se
  saltan solas.
- La entidad tiene ademas **`graphics_set_flipped`**, que es donde entran los
  sheets `recycler-flipped-*`. El recorrido de
  [../../5dim_core/lib/graphics-tree.lua](../../5dim_core/lib/graphics-tree.lua)
  es generico, asi que lo cubre sin tocar nada.
- Region recoloreada: 10.44% en `recycler-N`.
- Silueta contra la vanilla actual: **86.76%** solo con traslacion, **90.25%**
  anadiendo escala. Error RGB fuera de la region: **45.72** (el grupo A esta en 4-26).

### Mapeo de sheets

Todos son rejillas 8x8 de 64 fotogramas. La geometria de la capa la hereda el
overlay del sprite vanilla, asi que estas dimensiones solo sirven para alinear:

| sheet 5Dim | fotograma 5Dim | archivo vanilla | fotograma vanilla |
| --- | --- | --- | --- |
| `recycler-N` | 142x308 | `__recycler__/.../recycler-N.png` | 170x304 |
| `recycler-E` | 280x184 | `__recycler__/.../recycler-E.png` | 286x204 |
| `recycler-S` | 142x276 | `__recycler__/.../recycler-S.png` | 168x290 |
| `recycler-W` | 260x172 | `__recycler__/.../recycler-W.png` | 284x186 |
| `recycler-flipped-N` | 142x308 | `__recycler__/.../recycler-flipped-N.png` | 168x300 |
| `recycler-flipped-E` | 260x172 | `__recycler__/.../recycler-flipped-E.png` | 282x184 |
| `recycler-flipped-S` | 140x276 | `__recycler__/.../recycler-flipped-S.png` | 172x288 |
| `recycler-flipped-W` | 280x184 | `__recycler__/.../recycler-flipped-W.png` | 292x202 |

Confirmar los fotogramas vanilla contra el `--dump-data`, no contra estas cifras:
las de la tabla salen de dividir las dimensiones del PNG por 8x8 y podrian no
coincidir si Wube vuelve a reempaquetar.

### Pasos

1. Anadir las 8 entradas `Sheet(...)` a `SHEETS` en
   [../../scripts/extract-tier-overlays.py](../../scripts/extract-tier-overlays.py)
   con `group="B"`, `grid=(8, 8)` y el `leaf` correspondiente.
2. Generar y sacar tiras de contacto:
   ```powershell
   wsl -e /mnt/d/factorioDev/venv/bin/python -P mods/scripts/extract-tier-overlays.py `
       --only recycler --verify --contact <dir>
   ```
3. **Revisar las tiras a ojo** antes de cablear. Es la unica verificacion posible:
   la rama B no tiene comparacion numerica contra el original porque la region se
   reconstruye, no se copia.
4. Cablear el generador, igual que las demas:
   ```lua
   applyTierArt(entity, "recycler", tonumber(inputs.number))
   ```
   Va **fuera** del `if inputs.new`, porque el tier 1 tambien lleva overlay.
5. Validar (ver seccion final).
6. Borrar los originales: `find recycler -name "*-[0-9][0-9].png" -delete`.

## Caso 2: agricultural-tower y asteroid-collector — sin solucion directa

No es que su arte sea distinto: es que **cambio la estructura**, y por eso no hay
donde mapear los fotogramas.

- **agricultural-tower**: en dic-2024 `agricultural-tower-base` era una animacion
  de 64 fotogramas (8x8 de 248x336). Hoy vanilla tiene un **fotograma unico**
  estatico de 228x330 con `repeat_count = 64`, y la animacion se movio a
  `agricultural-tower-anim.png`, de 192x168. Comprobado que los 64 fotogramas del
  arte de 5Dim **no son identicos** (solo 1/64 coincide con el fotograma 0), asi
  que no se pueden colapsar a uno.
- **asteroid-collector**: lo mismo. Sus sheets son rejillas 4x4 de 16 fotogramas
  animados (1/16 identicos al 0), mientras que en vanilla el `-base` es estatico y
  la animacion vive en `*-anim.png`.

Trampa a evitar: por dimensiones de **sheet completo** asteroid-collector parece
grupo A (su fotograma coincide exacto con el `-base` vanilla, silueta 98-100%).
Solo se ve el problema al comprobar si los fotogramas son identicos entre si.

**Recomendacion: `applyTierTint`.** Ya existe, cuesta 0 MB y 0 VRAM, y basta con
no anadir esas entidades al manifiesto: `tier-art.lua` cae solo al tinte cuando no
encuentra la clave. Solo hay que borrar su arte.

Si algun dia se quiere arte propio, la unica via realista es rehacer la seleccion
a mano sobre el sprite nuevo. No hay atajo automatico: se descarto deducir la
region por color con dos metodos distintos (IoU 2-34% y 1-55%).

## Caso 3: rocket-silo — verificar primero de donde salio

Los sheets de 5Dim (`06-rocket-silo` 608x596, `14-rocket-silo-front` 580x262)
coinciden **exactamente con las variantes `-frozen`** de Space Age, mientras que
los reales de `base` crecieron a 628x612 y 586x262.

Antes de decidir nada, aclarar si el arte se hizo sobre la variante congelada por
error o si el sheet real medía eso en 2024. Segun la respuesta, o se trata como
grupo B normal contra el archivo correcto, o cae a `tier-tint` como los dos
anteriores.

Son 9.4 MB: no bloquea nada y puede ir al final.

## Metodo de la rama B, ya validado con foundry

Lo implementa `process_group_b` en el script. Resumen de por que hace lo que hace:

1. **Mapeo de color**: se aprende un gradient map por luminancia (media de canales)
   con los pares exactos del grupo A, agrupando varias entidades. Se probo el LUT
   de color completo y generaliza peor entre entidades (p99 de 30-75 frente a
   error medio 6.4-9.4 del de luminancia).
2. **Traslado de la region**: consenso de la region entre fotogramas, alineacion
   por bbox de silueta con escala, y ajuste a los bordes de color del sprite nuevo
   con `scipy.ndimage.label`. El ajuste corrige justo el ~10% de contorno que la
   alineacion bruta no acierta.
3. **Una sola region para todos los fotogramas.** Esto es lo importante: la region
   recoloreada es **estatica** (se mantiene al 99.91% de IoU en los 64 fotogramas
   aunque el cuerpo anime), asi que se calcula una vez y se estampa en todos.
   Reconstruirla fotograma a fotograma la hacia oscilar 1.30% de media y hasta
   7.87%, y eso se ve como parpadeo. Con el metodo actual la variacion es 0.00%.

## Validacion

```powershell
# 1. carga real
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\mods\scripts\validate-factorio-profiles.ps1 -TestSet Smoke

# 2. tamano final
.\mods\scripts\package-5dim-mods.ps1 -Force
```

Que las suites pasen **no prueba que los overlays se carguen**: si el `require` del
manifiesto fallara, `tier-art.lua` caeria al tinte y tambien pasarian. Para prueba
positiva, volcar prototipos y contar capas por tier:

```powershell
& "d:\factorioDev\bin\x64\factorio.exe" --config <config> `
    --mod-directory "d:\factorioDev\mods" --dump-data
```

En `script-output/data-raw-dump.json`, cada tier debe llevar **exactamente sus
overlays y ninguno ajeno**. Vigilar en concreto que no se acumulen los de tiers
anteriores: el tier 1 sobrescribe el prototipo vanilla y los siguientes hacen
`deepcopy` de `data.raw`, asi que heredan lo ya insertado. `tier-art.lua` lo limpia
con `stripInheritedOverlays`, pero conviene comprobarlo al anadir entidades nuevas.

Y la revision final es visual, en el juego: los 10 tiers en fila **y funcionando**,
porque el parpadeo solo se ve con la animacion en marcha.

## Al terminar

- Borrar los originales convertidos y el arte huerfano.
- Actualizar el estado en [../space-age-tier-art.md](../space-age-tier-art.md).
- Publicar: `.\mods\scripts\publish-5dim-mods.ps1 -Publish -Mods 5dim_space_age`.
- Borrar este plan, que deja de tener sentido una vez ejecutado.
