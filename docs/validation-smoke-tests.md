# Validacion De Humo De Factorio

## Objetivo

`scripts/validate-factorio-profiles.py` ejecuta validaciones locales de carga
para 5Dim sin modificar nada versionado. Para cada perfil genera fuera del repo
un `mod-list.json`, un `config.ini` y un `write-data` temporales, y lanza
Factorio en modo de validacion de data stage.

El binario corre **headless**: `--dump-data` hace que salga solo al terminar la
data stage y no necesita `DISPLAY`, asi que el mismo script vale para WSL y para
el workspace de Windows. Cada perfil tarda entre 1 y 7 segundos.

Esta version se centra en humo de arranque y carga de prototipos. No crea
partidas, no valida migraciones y no ejecuta pruebas runtime dentro del mapa.

## Perfiles

### Smoke

- `suite-no-dlc`: suite 5Dim sin DLC oficial.
- `suite-no-space-age`: suite 5Dim con `quality`, `recycler` y `elevated-rails`,
  pero sin `space-age`.
- `suite-full`: suite 5Dim completa con todos los mods oficiales.

La suite incluye `5dim_dev` y excluye `5dim_decoration` y `5dim_compatibility`.

### Module

- `module-core-only`: `5dim_core` en solitario.
- `module-5dim_*`: `5dim_core` mas un unico modulo 5Dim por perfil.

Cada perfil por modulo usa la combinacion oficial mas amplia que tenga sentido
para ese modulo: `5dim_space_age` activa `space-age`, y los modulos sin soporte
especifico no lo fuerzan.

## Mods oficiales

La lista de mods oficiales **no esta hardcodeada**: se descubre leyendo los
`info.json` de `<factorio>/data/`, junto con sus dependencias duras. Desde
Factorio 2.1 `quality` y `space-age` requieren `recycler`, y el cierre de
dependencias lo activa solo.

Todos los mods oficiales instalados reciben una entrada explicita en el
`mod-list.json` temporal. Es obligatorio: un mod ausente de la lista se activa
por defecto, asi que sin esa entrada `suite-no-dlc` cargaria DLC sin querer.

## Reglas de dependencia

- Las dependencias duras se resuelven desde los `info.json` reales del repo.
- Si a un modulo le falta un mod oficial, se omite del perfil de suite; el
  perfil individual queda marcado como `Omitido`.
- Las dependencias externas opcionales no se incluyen.
- Las combinaciones invalidas se reportan como omitidas, no como fallo.
- Los mods externos solo cuentan si estan en la raiz del repo como zip. En el
  entorno WSL no lo estan, asi que `5dim_modpack` sale siempre `Omitido` por su
  dependencia dura de `bobinserters`.

## Warnings

`--check-unused-prototype-data` genera cientos de warnings, casi todos
repeticiones del mismo problema una vez por tier. El informe los separa en dos:

- **Warnings 5Dim**: los que nombran un prototipo o mod nuestro. Son los
  accionables.
- **Warnings vanilla**: el resto, ruido de base/DLC.

Los de 5Dim se agrupan colapsando el nombre del prototipo, asi que 384 warnings
se leen como 8 casos distintos:

```text
      88x  Value ROOT.turret.<5d-*>.build_base_evolution_requirement was not used.
       9x  Value ROOT.car.<5d-*>.braking_power was not used.
```

## Artefactos temporales

Por defecto van a `<tmp>/factorio-5dim-validation/run-<timestamp>`, configurable
con `--output-root`. Cada perfil crea su `mods/mod-list.json`, su `config.ini` y
su `write-data` con log propio. Los dumps pesados de `script-output` (~90 MB por
perfil) se borran al terminar salvo con `--keep-artifacts`.

## Modos de uso

```bash
./scripts/validate-factorio-profiles.py --list-profiles
./scripts/validate-factorio-profiles.py --test-set smoke
./scripts/validate-factorio-profiles.py --test-set module --jobs 4
./scripts/validate-factorio-profiles.py --test-set all --run-locale-validation
./scripts/validate-factorio-profiles.py --profiles suite-no-space-age,module-5dim_transport
```

Los perfiles corren en paralelo (`--jobs`, 4 por defecto). `--stop-on-failure`
fuerza ejecucion en serie, porque solo tiene sentido con un orden definido.

Flags principales: `--factorio-dir DIR`, `--factorio-binary RUTA`,
`--mods-root DIR`, `--test-set`, `--profiles`, `--jobs N`, `--timeout S`,
`--output-root DIR`, `--keep-artifacts`, `--stop-on-failure`, `--dry-run`,
`--list-profiles`, `--run-locale-validation`.

## Salida

Cada corrida deja dos artefactos:

- `summary.json`: salida estructurada completa para automatizacion.
- `report.txt`: informe corto y legible.

`summary.json` incluye por perfil: nombre, tipo, estado (`Pasado`, `Fallido`,
`Omitido`, `Timeout`), mods oficiales activos, mods 5Dim activos, duracion,
codigo de salida, conteo de warnings 5Dim y vanilla, los grupos de warnings
completos y el primer error real si lo hubo.

Codigos de salida: `0` todo bien, `1` algun perfil fallido, `2` algun timeout.

## Extension futura

1. Segunda fase con `--create` o `--load-game` para validar runtime.
2. Perfiles de migracion sobre saves de referencia.
3. Baseline vanilla para restar los warnings que ya existen sin mods, en vez de
   clasificarlos por nombre de prototipo.
