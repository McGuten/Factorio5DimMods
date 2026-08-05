# Entorno De Pruebas De Factorio En WSL

## Objetivo

Poder abrir el juego con los mods de este repo **desde WSL**, sin depender del
workspace de Windows. La instalacion vive fuera del repositorio y los mods se
exponen por symlink, asi que editar un `.lua` y reiniciar Factorio es todo el
ciclo: no hay paso de copia ni de empaquetado.

## Los dos entornos

| | Windows (`<workspace>`) | WSL (`~/factorio`) |
| --- | --- | --- |
| Que es | Workspace completo: juego, `doc-html/`, `config/`, saves y el repo dentro de `mods/` | Solo el juego, autocontenido |
| Repo | `<workspace>\mods` | Un clon aparte, con los `5dim_*` colgando de la raiz |
| Mods | La propia carpeta del repo es la carpeta de mods | Symlinks a las carpetas del repo |
| Render | GPU real (Direct3D) | Por software (`llvmpipe`), va a tirones |
| Para que | `doc-html/`, y **jugar o revisar arte en movimiento** | Editar, validar, publicar y comprobaciones rapidas |

Aunque el juego de Windows sea el bueno para mirar, **el ciclo de trabajo entero
se conduce desde WSL**: `run-factorio-windows.sh` sincroniza los mods del clon de
WSL en el de Windows y arranca su `.exe` por la interop, sin salir de la terminal
ni del editor.

Los dos son clones del mismo repositorio de GitHub, y **ningun script depende ya
de PowerShell**: validacion (`validate-factorio-profiles.py`,
`validate-locales.py`) y publicacion (`publish-5dim-mods.py`) son Python
multiplataforma y localizan Factorio solos, asi que el ciclo completo se puede
hacer desde WSL.

`doc-html/` (referencia local de la API) sigue estando solo en Windows.

## Layout de la instalacion

El paquete `.tar.xz` oficial es autocontenido (`config-path.cfg` con
`use-system-read-write-data-directories=false`), asi que todo lo escribible
cuelga del propio directorio y nada toca el repo:

```text
~/factorio/
├── bin/x64/factorio          # binario (cliente completo)
├── data/                     # base, space-age, quality, elevated-rails
├── config/config.ini         # se genera en el primer arranque
├── mods/
│   ├── 5dim_core -> <repo>/5dim_core   (un symlink por mod)
│   ├── mod-list.json                   (semilla del repo)
│   ├── mod-settings.dat                (semilla del repo)
│   └── *.zip                           (mods externos bajados desde el juego)
├── saves/  script-output/  temp/
├── player-data.json          # login, copiado del workspace de Windows
└── factorio-current.log      # log de la ultima ejecucion
```

La ruta se puede cambiar con la variable de entorno `FACTORIO_DIR` o con
`--factorio-dir` en cualquiera de los scripts.

Los mods externos (dependencias duras como `bobinserters` y cualquier mod de
terceros) se descargan **desde el propio juego**, con el gestor de mods del menu:
sus zips caen directamente en `~/factorio/mods/` y ahi se quedan. Los scripts no
los tocan nunca, porque solo crean y borran symlinks.

Si en algun momento interesa tener zips externos fuera del juego (por ejemplo una
version concreta que no esta en el portal), se pueden dejar en
`~/factorio-mods-externos/` (`EXTERNAL_MODS_DIR` o `--external-mods`) y
`link-5dim-mods.sh` los enlaza solo. Ahora mismo esa carpeta esta vacia.

## Comandos

Todos se ejecutan desde la raiz del repo.

### Instalar (una sola vez)

```bash
./scripts/setup-factorio-wsl.sh
```

Extrae el `factorio-*.tar.xz` de la raiz del repo, verifica que el binario
arranca (`--version`), copia `player-data.json` del workspace de Windows, siembra
`mods/` con `mod-list.json` y `mod-settings.dat`, crea los symlinks y **borra el
tarball** al terminar bien.

Flags: `--factorio-dir DIR`, `--archive FICHERO`, `--player-data RUTA`,
`--external-mods DIR`, `--keep-archive` (no borrar el tarball),
`--no-player-data`, `--force` (reinstalar sobre una instalacion existente; la
anterior se renombra a `.old.<fecha>` en vez de borrarse).

### Refrescar los enlaces de mods

```bash
./scripts/link-5dim-mods.sh
```

Solo hace falta cuando se **anade, renombra o elimina** un mod (o se deja un zip
externo nuevo): al editar ficheros de un mod ya enlazado no hay nada que
sincronizar. Toma el nombre de cada mod de su `info.json`, corrige enlaces que
apunten a otro sitio y borra los rotos u obsoletos. Nunca borra directorios
reales ni ficheros que no sean symlinks. `run-factorio-wsl.sh` ya lo llama solo.

Flags: `--factorio-dir DIR`, `--external-mods DIR`, `--no-external`,
`--no-prune`, `--quiet`.

### Arrancar el juego

```bash
./scripts/run-factorio-wsl.sh
```

Refresca los enlaces y lanza la GUI via WSLg. Cualquier argumento extra va al
binario:

```bash
./scripts/run-factorio-wsl.sh --load-game mi-partida
./scripts/run-factorio-wsl.sh --create /tmp/prueba.zip
```

Flags propios: `--factorio-dir DIR`, `--no-link`.

**El Factorio de WSL renderiza por software** (`llvmpipe`, sin GPU), asi que sirve
para comprobar que los mods cargan y para mirar cosas estaticas, pero va a
tirones. Para jugar de verdad o revisar arte en movimiento, usar el de Windows.

### Arrancar el Factorio de Windows (con GPU)

```bash
./scripts/run-factorio-windows.sh
```

Sincroniza los mods del repo en la instalacion de Windows y arranca su `.exe` por
la interop de WSL, que lo ejecuta nativo y con la GPU real (Direct3D). El script
corre en WSL; el juego, no.

La instalacion destino se resuelve, por este orden: `--factorio-dir DIR`, la
variable `WIN_FACTORIO_DIR`, el fichero `scripts/.factorio-windows-dir` (una
linea con la ruta, no se versiona) o autodeteccion bajo `/mnt/<unidad>/`. Si hay
varias instalaciones, las lista y pide elegir en vez de adivinar.

Flags propios: `--no-sync` (arrancar sin copiar), `--sync-only` (copiar sin
arrancar, util con el juego ya abierto para solo reiniciarlo), `--quiet`. Lo que
vaya tras `--` se pasa al juego:

```bash
./scripts/run-factorio-windows.sh -- --load-game mi-partida
```

Dos cosas que hace y conviene saber:

- **Copia carpeta a carpeta, nunca el `mods/` entero.** En el workspace de Windows
  ese directorio es a la vez el clon de git y la carpeta de mods, con los zips de
  terceros, `mod-list.json`, `mod-settings.dat` y el propio `.git` dentro. Nada de
  eso se toca.
- **Dentro de cada mod si borra lo que sobra** (`rsync --delete`). Es
  imprescindible: los cambios de arte eliminan ficheros, y una copia sin borrado
  dejaria PNG viejos y el mod seguiria pesando lo que no debe.

Tambien desactiva en `mod-list.json` los dos mods que impiden cargar, los mismos
que quedan fuera del enlazado de WSL y de las suites de validacion:
`5dim_compatibility` (solo actua sobre mods de terceros) y `5dim_decoration`
(sigue en sintaxis de Factorio 1.x, con `result` en vez de `results`, asi que sus
recetas quedan sin resultado y el mod `recycler` de Space Age aborta la carga al
generar su receta de reciclaje).

Desde VSCode hay tareas para esto en `.vscode/tasks.json`, que **no se versiona**
porque `.vscode` esta en `.gitignore` (ajustes locales con rutas de maquina). La
tarea de build por defecto sincroniza y arranca, asi que `Ctrl+Shift+B` es todo.
Si el fichero no esta, crearlo con una tarea `shell` que llame al script.

### Validar sin abrir el juego

```bash
./scripts/validate-factorio-profiles.py --test-set smoke
./scripts/validate-locales.py
```

Lanza Factorio headless con `--dump-data` sobre un `write-data` temporal, una vez
por combinacion de DLC, y parsea el log. No necesita `DISPLAY` ni toca
`~/factorio/mods`: cada perfil monta su propia carpeta de mods en `/tmp`. El set
`smoke` tarda unos 7 segundos y el set `module` (23 perfiles) menos de 10.

Detalle completo en [validation-smoke-tests.md](validation-smoke-tests.md).

## Ciclo de trabajo

1. Editar los mods en el repo.
2. `./scripts/validate-factorio-profiles.py --test-set smoke` para descartar
   errores de carga en segundos.
3. Comprobar en el juego:
   - `./scripts/run-factorio-windows.sh` para jugar o revisar arte en movimiento,
     que es lo que necesita GPU.
   - `./scripts/run-factorio-wsl.sh` si basta con mirar algo estatico sin salir
     de WSL.
4. Al cerrar, revisar el `factorio-current.log` de la instalacion que se haya
   usado si algo no cargo.
5. Si se ha creado un mod nuevo: `./scripts/link-5dim-mods.sh` (solo afecta a
   WSL; el lanzador de Windows sincroniza los mods nuevos solo).

## Troubleshooting

- **El binario no arranca por librerias**: `ldd ~/factorio/bin/x64/factorio | grep 'not found'`
  e instalar lo que falte con `apt`. Los scripts no instalan paquetes por su cuenta.
- **No hay ventana / error de SDL**: WSLg necesita `DISPLAY` (normalmente `:0`).
  `run-factorio-wsl.sh` avisa si no hay ni `DISPLAY` ni `WAYLAND_DISPLAY`.
- **El juego de WSL va a tirones**: es lo esperado, renderiza por CPU. Se confirma
  en el log con `Initialised OpenGL: llvmpipe`; el de Windows pone
  `Initialised Direct3D` y el nombre de la GPU. Usar
  `./scripts/run-factorio-windows.sh`.
- **Los cambios no aparecen en el Factorio de Windows**: ese no lee del repo por
  symlink, hay que sincronizar. Lanzarlo con el script, o
  `./scripts/run-factorio-windows.sh --sync-only` y reiniciar el juego.
- **El DLC space-age no carga o pide login**: falta o esta caducado
  `~/factorio/player-data.json`. Volver a copiarlo del workspace de Windows
  (`--player-data <ruta>`) o
  iniciar sesion una vez en el juego.
- **`5dim_modpack` se desactiva solo**: le falta su dependencia dura
  `bobinserters`. Se descarga desde el gestor de mods del juego.
- **Enlaces rotos tras mover el repo**: reejecutar `./scripts/link-5dim-mods.sh`,
  que los detecta y los rehace.
- **Reinstalar desde cero**: borrar `~/factorio` y volver a ejecutar el setup con
  `--archive` apuntando a un tarball descargado de <https://factorio.com/download>.
- **`module-5dim_modpack` sale siempre `Omitido`**: es correcto. Su dependencia
  dura `bobinserters` es un zip descargado desde el juego, y el runner solo
  cuenta los mods que estan en el repo.
