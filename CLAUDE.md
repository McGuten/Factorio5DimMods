# CLAUDE.md

Guia para trabajar en este repositorio. El **proyecto real** son los mods `5dim_*`
dentro de [mods/](mods/). Todo lo demas del workspace que los contiene es una
instalacion de Factorio usada solo para **probar** los mods.

## Que es y que no es el proyecto

- **Proyecto (editable):** [mods/](mods/) — la familia de mods `5dim_*`, su
  documentacion en [mods/docs/](mods/docs/) y sus scripts en [mods/scripts/](mods/scripts/).
- **Solo para probar (NO editar):** `bin/` (ejecutable de Factorio), `data/`
  (datos vanilla), `saves/`, `config/`, `script-output/`, `temp/`, `venv/`,
  `*.dat`, `*.log`. Sirven para cargar y validar los mods, no son codigo del proyecto.
- `doc-html/` es la **referencia local de la API de Factorio** (prototype y
  runtime). Consultala antes de inventar campos, tipos o comportamientos.

## Instrucciones base ya existentes

Antes de empezar, estas fuentes mandan y no deben duplicarse aqui:

- [.github/copilot-instructions.md](.github/copilot-instructions.md): reglas
  repo-wide (arquitectura, flujo, validacion, locales, badges, criterios de edicion).
- [.github/instructions/5dim-locales.instructions.md](.github/instructions/5dim-locales.instructions.md):
  flujo detallado de locales.
- [mods/docs/README.md](mods/docs/README.md): indice de diseno. Empieza por
  [mods/docs/design-guide.md](mods/docs/design-guide.md) y baja a
  [mods/docs/design-modules.md](mods/docs/design-modules.md).
- [mods/5dim_core/lib/README.md](mods/5dim_core/lib/README.md): referencia de
  arquitectura de la libreria compartida (generadores, API de costes, colores de tier).
- [mods/docs/space-age-tier-art.md](mods/docs/space-age-tier-art.md): como se cablea
  el arte por tier de `5dim_space_age` (capa base vanilla + overlay), con las
  alternativas ya descartadas y medidas. **Leelo antes de tocar
  `5dim_space_age/graphics/` o `lib/space-age/tier-art.lua`.**

## Arquitectura

- Familia de mods Factorio bajo el prefijo `5dim_`. `5dim_core` es la base y
  dependencia comun del resto; expone la libreria compartida en
  [mods/5dim_core/lib/](mods/5dim_core/lib/).
- Modulos opcionales amplian un sistema concreto (automation, battlefield, energy,
  equipment, logistic, mining, module, nuclear, resources, space_age, storage,
  trains, transport, vehicles, enemies, infiniteresearch, yeters).
- Modulos utilitarios: `5dim_autofill`, `5dim_compatibility`, `5dim_locale`,
  `5dim_dev`, `5dim_modpack`, `5dim_decoration`, `5dim_quality`.
- Cada modulo declara metadata, version y dependencias en su `info.json` y carga
  prototipos desde `data.lua` / `data-updates.lua` mediante `require`, con
  `prototypes/` separados por dominio.

## Convenciones clave

- Mantener el prefijo `5dim_` en carpetas, nombres y convenciones.
- Los prototipos se generan con la libreria de `5dim_core`: cada
  `lib/<dominio>/generation-*.lua` expone una global `gen<Entity>(inputs)`. El
  modulo aporta la **configuracion de tier**; `core/lib` decide **como** se
  vuelve prototipo. Lee escalado y conteos de tech desde `CostConfig` /
  `CostCalculator` / `RecipeTemplates.baseTechCounts`, nunca hardcodees multiplicadores.
- **Nada de locale inline:** no asignar `localised_name` / `localised_description`
  en `.lua`. Los textos viven en `locale/en/*.cfg` del modulo origen y se
  sincronizan despues con `mods/5dim_locale/locale/en/` y `en.example/`.
- Diseno tiered: tiers vanilla intactos, tiers 5Dim acumulativos, cada tier
  aporta un delta visible no redundante. Reglas completas en
  [mods/docs/design-guide.md](mods/docs/design-guide.md).
- Cambios pequenos y locales en el modulo responsable. Compatibilidad con mods
  externos va preferentemente en `5dim_compatibility`. No mover contenido entre
  modulos ni hacer refactors amplios sin razon funcional clara.

## Control de cambios y versiones

**Cada cambio funcional en un mod se cierra subiendo su version y anotando el
changelog.** No es un paso de publicacion que se hace al final: es parte de
terminar el cambio, en el mismo turno. Un mod tocado y sin subir version es un
cambio que el script de publicacion marcara `SKIP` y que nunca llegara al
usuario, sin que nada falle ni avise.

El alcance es **el mod que se ha tocado, y solo ese**. Cada mod se versiona y se
publica por su cuenta: no hay version de familia ni se suben los demas por
acompanar. Un mod con cambios ajenos pendientes **no es asunto de este cambio**;
si los tiene, se avisa y se deja que decida quien los hizo. Una version nueva es
un compromiso de que ese mod esta listo para publicarse, asi que subirla "porque
si" publicaria trabajo a medias.

Al terminar cualquier cambio, y **antes de darlo por hecho**:

1. **Listar los mods que ha tocado este cambio**, no solo el principal, y
   ninguno mas. El caso tipico de mas de uno es tocar `5dim_core` (la libreria
   compartida) para que funcione algo de otro modulo: ahi si van los dos, porque
   los dos se han tocado.
2. **Comprobar si esa version ya esta publicada**, que es lo que decide si hay
   que subirla:
   ```bash
   ./scripts/publish-5dim-mods.py            # dry-run: local vs portal, no envia nada
   ```
   Si el portal ya tiene esa version, hay que subirla; el portal **no** deja
   reemplazar una version publicada.
3. **Subir la version en `info.json`** (patch para correcciones y cambios
   internos, minor para contenido nuevo) y **anadir la entrada al `changelog.txt`
   del mod**.
4. **Revisar las dependencias en `info.json`.** Si el cambio de un modulo
   necesita una version nueva de `5dim_core`, hay que **subir la cota**
   (`5dim_core >= <version nueva>`). Sin eso, quien actualice solo el modulo se
   queda con el core viejo y la funcionalidad no aparece **sin ningun error**:
   carga bien y no se ve.
5. **Volver a pasar el dry-run** y comprobar que el plan incluye los mods de este
   cambio. Que salgan otros como `SKIP` es lo normal y correcto: son mods que
   este cambio no ha tocado.

### El dry-run avisa solo

No hay que fiarlo a la memoria: `publish-5dim-mods.py` compara cada mod `SKIP`
con el commit que subio su version y avisa en la columna `Aviso` si hay ficheros
cambiados despues. Es la red que faltaba cuando esto se colo.

El aviso **sobra avisos pero no se le escapa ninguno**: git no sabe cuando se
subio la release, asi que un mod donde se siguio trabajando entre el bump y la
publicacion tambien sale marcado. Para confirmar o descartar, se compara contra
el zip publicado de verdad:

```bash
./scripts/diff-portal-releases.py --mods 5dim_x --detail
```

Eso dice exactamente que ficheros difieren de la release, sin falsos positivos.
Un `identico (solo saltos de linea)` es ruido de CRLF entre Windows y WSL, no un
cambio: no hay nada que publicar.

Ese mismo comando sirve **antes de escribir el changelog**, y conviene: una
version publicada puede haberse quedado varias tandas atras, y entonces la
entrada tiene que cubrir todo lo que sale, no solo el ultimo cambio.

### El changelog va en ingles

`changelog.txt` es texto **de cara al usuario**: lo muestran el Mod Portal y el
juego. Se escribe **en ingles**, aunque la conversacion y la documentacion
interna del repo esten en castellano. Se respeta el formato del fichero
(separadores de guiones, `Version:`, `Date:` en `YYYY-MM-DD` y las secciones
`Major Features:` / `Features:` / `Changes:` / `Bugfixes:` con dos espacios de
indentacion y los items con cuatro).

### El changelog lo lee un jugador, no un programador

Un changelog **solo lleva lo que cambia para quien juega**, contado como se lo
contarias a alguien que no ha visto el codigo. Si una frase no le dice que va a
notar en su partida, sobra.

Fuera de ahi queda **todo el vocabulario tecnico**: nombres de fichero o de
funcion, prototipos, capas, overlays, tints, sprites, sheets, MB del mod,
`data-updates`, refactors... Nada de explicar *como* esta hecho ni *por que* fue
dificil; eso va en `docs/` y en los comentarios del codigo.

| En vez de | Escribir |
| --- | --- |
| "Tier art is drawn as a recolour overlay on top of the vanilla sprite" | "Every tier now has its own colour" |
| "Wired applyTierArt into generation-recycler.lua" | "Recyclers are coloured by tier" |
| "Supply area values are rounded up to the next aligned distance" | "Pole coverage lines up with the tile grid, with no gaps" |
| "Icons were 600px placeholders, now 64px" | "Sniper magazines now have proper icons" |

Tampoco se cuentan los arreglos de cosas que el jugador nunca llego a ver: si el
fallo no salio de una version publicada, no es una entrada de changelog.

Si la version aun **no** esta publicada (el dry-run la marca `PUBLISH` y el
portal no tiene ninguna), no se sube: se anade la entrada a la seccion de esa
version, que todavia se puede reescribir entera.

## Commits

**Un commit por mod.** Cada mod se versiona y se publica por su cuenta, asi que
su historia tambien va suelta: nada de un commit que toque cinco mods a la vez.
Lo que no es un mod (`docs/`, `scripts/`, `CLAUDE.md`) va en sus propios commits,
igual de separados.

**El mensaje es una linea, y una sola.** Corta, que de contexto de que cambia y
por que se entiende, sin extenderse. Sin cuerpo ni parrafos debajo.

```text
5dim_core: colorea por tier las maquinas de Space Age
5dim_battlefield: iconos propios para la munición de sniper de tungsteno
scripts: avisa de mods cambiados sin subir version
```

## Validacion y publicacion

No hay suite de tests automatizada del juego; la validacion es cargar los mods en
Factorio. El runner lo hace headless, sin abrir la GUI, y funciona igual en WSL y
en Windows (Python, localiza Factorio solo):

```bash
# Perfiles disponibles, sin ejecutar nada
./scripts/validate-factorio-profiles.py --list-profiles

# Suite completa en las tres combinaciones de DLC (unos 7 segundos)
./scripts/validate-factorio-profiles.py --test-set smoke

# Cada modulo por separado sobre 5dim_core
./scripts/validate-factorio-profiles.py --test-set module

# Locales: cobertura, sync con 5dim_locale y localised_* inline
./scripts/validate-locales.py
```

La publicacion al Mod Portal tambien es Python y funciona en los dos entornos.
Sin `--publish` no envia nada: solo consulta el portal y muestra el plan.

```bash
./scripts/publish-5dim-mods.py              # dry-run
./scripts/publish-5dim-mods.py --publish    # sube de verdad
```

En el dry-run, `SKIP` significa que local y portal estan en la misma version. Es
lo esperado en la mayoria de mods, que no entran en el cambio; solo es un fallo
**si ese mod es de los que se han tocado**, y entonces le falta subir la version
(ver [Control de cambios y versiones](#control-de-cambios-y-versiones)).
`UPLOAD` es una version nueva de un mod ya publicado y `PUBLISH` un mod que aun
no existe en el portal.

Detalle de comandos y perfiles en [docs/comandos.md](docs/comandos.md)
y [docs/validation-smoke-tests.md](docs/validation-smoke-tests.md).

## Entorno de pruebas en WSL

Este repositorio se clona en dos sitios: dentro del workspace de Windows descrito
arriba (`<workspace>\mods`) y en un clon propio de WSL, donde los `5dim_*` cuelgan
**de la raiz del repo**, no de `mods/`, y no existen `bin/`, `data/`, `config/` ni
`doc-html/`.

Desde WSL hay una instalacion propia de Factorio en `~/factorio` (fuera del repo)
con los mods enlazados por symlink. Para probar los cambios en el juego:

```bash
./scripts/run-factorio-windows.sh        # sincroniza y abre el Factorio de Windows (GPU)
./scripts/run-factorio-wsl.sh            # abre la GUI via WSLg con los mods del repo
./scripts/link-5dim-mods.sh              # solo al anadir, renombrar o borrar un mod
./scripts/setup-factorio-wsl.sh          # instalacion inicial (una sola vez)
```

El Factorio de WSL renderiza por software (`llvmpipe`) y va a tirones: vale para
ver que los mods cargan, no para revisar arte en movimiento. Para eso esta
`run-factorio-windows.sh`, que copia los mods a la instalacion de Windows y
arranca su `.exe` por la interop, con GPU real.

Editar un mod ya enlazado no necesita ningun paso de copia: basta reiniciar
Factorio. La validacion y la publicacion son Python y corren en los dos
entornos, asi que no queda nada atado a PowerShell. Detalle en
[docs/entorno-wsl-factorio.md](docs/entorno-wsl-factorio.md) y lista completa de
comandos en [docs/comandos.md](docs/comandos.md).

## Repositorio publico

Este repo se publica en GitHub: todo lo versionado es visible. Al escribir codigo,
scripts o documentacion:

- **Rutas relativas al repo** (`./scripts/...`, `docs/...`), `~` o placeholders
  (`<workspace>`, `<repo>`). Nunca rutas absolutas de una maquina concreta, ni
  nombres de usuario, unidades o carpetas de nube.
- **Cero secretos versionados**: la API key del portal vive solo en
  `scripts/.portal-key` y `player-data.json` (login y token) nunca entra en el
  repo; ambos estan en `.gitignore`.
- Lo que dependa de la maquina se pasa por **parametro o variable de entorno**
  (`FACTORIO_DIR`, `--factorio-dir`, `--mods-root`), con default neutro.
- Antes de commitear, revisar que el diff no arrastre rutas personales ni datos
  privados en comentarios, changelogs o docs.

## Cuando haya dudas

Si falta contexto, hay ambiguedad funcional, o una decision afecta compatibilidad,
balance, traducciones o estructura entre modulos: detente y pregunta antes de
elegir un default. No asumas nombres, comportamiento ni alcance del cambio cuando
el repositorio no lo deje claro.
