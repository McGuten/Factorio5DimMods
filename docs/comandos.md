# Comandos

Indice de todos los comandos del repo, con una descripcion de una linea cada uno.
Todos se ejecutan **desde la raiz del repositorio** y usan rutas relativas.

> Este repositorio es **publico**: no anadas aqui rutas absolutas, nombres de
> usuario, claves ni tokens. Ver [Repo publico](#repo-publico) al final.

## WSL / Linux (bash)

Requieren la instalacion de pruebas descrita en
[entorno-wsl-factorio.md](entorno-wsl-factorio.md) (por defecto `~/factorio`,
configurable con `FACTORIO_DIR`).

| Comando | Que hace |
| --- | --- |
| `./scripts/setup-factorio-wsl.sh` | Instala Factorio desde un `factorio-*.tar.xz`, enlaza los mods y borra el tarball. |
| `./scripts/setup-factorio-wsl.sh --keep-archive` | Igual, pero conserva el tarball de instalacion. |
| `./scripts/setup-factorio-wsl.sh --force` | Reinstala sobre una instalacion existente, renombrando la anterior a `.old.<fecha>`. |
| `./scripts/link-5dim-mods.sh` | Rehace los symlinks de `mods/` tras anadir, renombrar o borrar un mod. |
| `./scripts/link-5dim-mods.sh --no-prune` | Igual, sin borrar los enlaces rotos u obsoletos. |
| `./scripts/run-factorio-wsl.sh` | Abre el juego con GUI (WSLg) y los mods del repo, refrescando enlaces antes. |
| `./scripts/run-factorio-wsl.sh --load-game <nombre>` | Abre el juego cargando directamente una partida guardada. |
| `"$FACTORIO_DIR"/bin/x64/factorio --dump-data --check-unused-prototype-data` | Comprueba a mano que la data stage carga sin errores, sin abrir la GUI. |

Todos aceptan `--factorio-dir DIR` y `-h` / `--help`.

### Lanzar el Factorio de Windows desde WSL

El de WSL renderiza por software y va a tirones. Para jugar o revisar arte en
movimiento se usa el `.exe` nativo, arrancado desde aqui por la interop.

| Comando | Que hace |
| --- | --- |
| `./scripts/run-factorio-windows.sh` | Sincroniza los mods del repo en la instalacion de Windows y arranca su `.exe` con GPU. |
| `./scripts/run-factorio-windows.sh --sync-only` | Solo sincroniza. Con el juego abierto, basta reiniciarlo despues. |
| `./scripts/run-factorio-windows.sh --no-sync` | Arranca sin copiar nada. |
| `./scripts/run-factorio-windows.sh -- --load-game <nombre>` | Lo que va tras `--` se pasa al juego. |

La instalacion destino sale de `--factorio-dir DIR`, `WIN_FACTORIO_DIR`,
`scripts/.factorio-windows-dir` (no versionado) o autodeteccion bajo `/mnt/`.
Desde VSCode las mismas acciones estan como tareas; `Ctrl+Shift+B` sincroniza y
arranca. Detalle en
[entorno-wsl-factorio.md](entorno-wsl-factorio.md#arrancar-el-factorio-de-windows-con-gpu).

## Validacion (Python, WSL y Windows)

Corren igual en los dos entornos: localizan Factorio solos (`$FACTORIO_DIR` o
`~/factorio` en WSL, el propio workspace en Windows) y no tocan nada versionado.
En Windows, anteponer `python` si no se pueden ejecutar directamente.

| Comando | Que hace |
| --- | --- |
| `./scripts/validate-factorio-profiles.py --list-profiles` | Lista los perfiles de validacion disponibles sin ejecutar nada. |
| `./scripts/validate-factorio-profiles.py --test-set smoke` | Valida la carga de la suite completa en las tres combinaciones de DLC. |
| `./scripts/validate-factorio-profiles.py --test-set module` | Valida `5dim_core` solo y `core` + cada modulo por separado. |
| `./scripts/validate-factorio-profiles.py --test-set all --run-locale-validation` | Ejecuta todos los perfiles y ademas la validacion de locales. |
| `./scripts/validate-factorio-profiles.py --profiles <a>,<b>` | Ejecuta solo los perfiles indicados por nombre. |
| `./scripts/validate-factorio-profiles.py --jobs 1` | Fuerza ejecucion en serie (por defecto 4 perfiles en paralelo). |
| `./scripts/validate-locales.py` | Revisa cobertura de locales, sync con `5dim_locale` y `localised_*` inline (solo lectura). |

Detalle de perfiles, warnings y artefactos en
[validation-smoke-tests.md](validation-smoke-tests.md).

## Comparar con lo publicado

| Comando | Que hace |
| --- | --- |
| `./scripts/diff-portal-releases.py` | Descarga la release publicada de cada mod y dice en que difiere del arbol local. |
| `./scripts/diff-portal-releases.py --mods 5dim_core --detail` | Solo un mod, listando los ficheros que cambian. |
| `./scripts/diff-portal-releases.py --cache DIR` | Reutiliza los zips ya descargados (todos son ~400 MB). |

Sirve para confirmar un aviso del dry-run y para saber que entra de verdad en una
release antes de escribir su changelog. `identico (solo saltos de linea)` es ruido
de CRLF entre Windows y WSL: no hay nada que publicar. Las credenciales salen del
`player-data.json` de una instalacion de Factorio (`--factorio-dir`).

## Publicacion en el Mod Portal

Funciona en WSL y en Windows. Sin `--publish` **no se envia nada al portal**: se
consulta, se compara y se muestra el plan.

| Comando | Que hace |
| --- | --- |
| `./scripts/publish-5dim-mods.py` | Dry-run: consulta el portal y muestra que subiria, sin tocar nada. |
| `./scripts/publish-5dim-mods.py --keep-zips <ruta>` | Genera los zips para inspeccionarlos, sin publicar. |
| `./scripts/publish-5dim-mods.py --publish` | Sube los mods cuya version de `info.json` es mayor que la del portal. |
| `./scripts/publish-5dim-mods.py --publish --mods 5dim_core,5dim_mining` | Publica solo los mods indicados. |

Del zip publicado se excluyen `*.zip`, `.git*`, `.vscode` y `.DS_Store`. El
filtro de `*.zip` no es cosmetico: las carpetas de mods acumulan releases
antiguas y sin el se irian cientos de MB en cada subida.

La API key se lee de `scripts/.portal-key` (una sola linea, **ignorado por git**,
nunca se versiona) y solo se abre si pasas `--publish`. Se genera en
<https://factorio.com/profile> con permisos *ModPortal: Upload Mods* y
*ModPortal: Publish Mods*.

## Utilidades de arte (Python)

| Comando | Que hace |
| --- | --- |
| `./scripts/extract-tier-overlays.py` | Regenera los overlays de recoloreado por tier de `5dim_space_age`. |
| `./scripts/extract-tier-overlays.py --verify` | Comprueba que los overlays existentes reproducen el arte esperado. |
| `./scripts/make-region-overlays.py` | Genera los overlays por tier de `5dim_automation` recoloreando una region del sprite vanilla. |
| `./scripts/make-region-overlays.py --contact DIR` | Deja una tira por sprite (vanilla, region y tiers) para revisar el resultado. |
| `./scripts/generate-quality-icons.py` | Genera los iconos de calidad 5Dim con la paleta de tiers de `5dim_core`. |
| `./scripts/generate-specialized-roboport-art.py` | Genera el arte de las familias de roboports especializados de `5dim_logistic`. |
| `./scripts/install-custom-charging-roboport-art.py <origen.png>` | Instala un PNG propio como arte de una familia de roboports. |

Los scripts de validacion tambien son Python: estan en su
[propia seccion](#validacion-python-wsl-y-windows).

Antes de tocar el arte por tier, de Space Age o de automation, leer
[space-age-tier-art.md](space-age-tier-art.md).

## Repo publico

El repositorio esta publicado en GitHub, asi que todo lo que se versiona es
visible. Reglas al escribir codigo, scripts o documentacion:

- **Rutas relativas al repo** (`./scripts/...`, `docs/...`) o placeholders
  (`<workspace>`, `~/factorio`). Nada de rutas absolutas de una maquina concreta
  ni de nombres de usuario, unidades o carpetas personales.
- **Cero secretos versionados**: la API key vive solo en `scripts/.portal-key`, y
  `player-data.json` (login y token de Factorio) nunca entra en el repo. Ambos
  estan en [.gitignore](../.gitignore).
- **Nada de datos personales** en comentarios, changelogs ni docs: ni correos, ni
  rutas de red, ni carpetas de nube.
- Lo que dependa de la maquina se pasa por **parametro o variable de entorno**
  (`FACTORIO_DIR`, `--factorio-dir`, `--mods-root`), con un default neutro.
