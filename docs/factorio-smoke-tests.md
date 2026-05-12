# Factorio Smoke Tests

## Objetivo

`validate-factorio-profiles.ps1` ejecuta validaciones locales de carga para 5Dim sin modificar archivos versionados del workspace. Genera un `mod-list.json`, un `config.ini` y un `write-data` temporales fuera del proyecto para cada perfil y lanza Factorio en modo de validacion de data stage.

La primera version esta enfocada a humo de arranque y carga de prototipos. No crea partidas, no valida migraciones y no ejecuta pruebas runtime dentro del mapa.

## Perfiles

### Smoke

- `suite-no-dlc`: suite 5Dim sin DLC oficial. Omite `5dim_space_age` como combinacion invalida esperada.
- `suite-no-space-age`: suite 5Dim con `quality` y `elevated-rails`, pero sin `space-age`.
- `suite-full`: suite 5Dim completa con `space-age`, `quality` y `elevated-rails`.

La suite completa incluye `5dim_dev` y excluye `5dim_decoration` y `5dim_compatibility`.

### Module

- `module-core-only`: `5dim_core` en solitario.
- `module-5dim_*`: `5dim_core` mas un unico modulo 5Dim por perfil.

Los perfiles por modulo usan la combinacion oficial mas amplia que tenga sentido para ese modulo. Por ejemplo, `5dim_space_age` activa `space-age`, mientras que otros modulos sin soporte especifico de Space Age no lo fuerzan.

## Reglas de dependencia

- Las dependencias duras se resuelven desde los `info.json` reales del repo.
- Las dependencias oficiales faltantes hacen que el modulo se omita del perfil de suite o que el perfil individual quede marcado como omitido.
- Las dependencias externas opcionales no se incluyen.
- Las combinaciones invalidas se reportan como omitidas, no como fallo del runner.
- `5dim_transport` incluye `bobinserters` porque es dependencia dura.

## Artefactos temporales

Por defecto, los artefactos se escriben bajo `%TEMP%\factorio-5dim-validation\run-<timestamp>`.

Cada perfil crea:

- `mods/mod-list.json` temporal.
- `config.ini` temporal derivado de [config/validation-automation.ini](../../config/validation-automation.ini).
- `write-data` temporal con logs propios.

Los dumps pesados de `script-output` se eliminan automaticamente salvo que uses `-KeepArtifacts`.

## Modos de uso

```powershell
.\validate-factorio-profiles.ps1 -ListProfiles
.\validate-factorio-profiles.ps1 -TestSet Smoke
.\validate-factorio-profiles.ps1 -TestSet Module
.\validate-factorio-profiles.ps1 -TestSet All -RunLocaleValidation
.\validate-factorio-profiles.ps1 -Profiles suite-no-space-age,module-5dim_transport
```

## Salida

Cada corrida deja dos artefactos principales:

- `summary.json`: salida estructurada completa para automatizacion.
- `report.txt`: informe corto y legible para revisar rapidamente como fue la corrida.

`summary.json` incluye:

- perfil
- tipo de perfil
- estado (`Passed`, `Failed`, `Skipped`, `Timeout`)
- mods oficiales activos
- mods 5Dim y dependencias duras activas
- tiempo total
- codigo de salida
- numero de warnings
- resumen del primer error real si lo hubo

`report.txt` resume:

- cuantos perfiles se ejecutaron
- cuantos pasaron, fallaron, se omitieron o hicieron timeout
- warnings acumulados y tiempo total
- lista breve de fallos, omitidos o perfiles pasados

## Extension futura

Si mas adelante quieres ampliar cobertura sin rehacer el runner, el siguiente orden natural es:

1. Crear una segunda fase para `--create` o `--load-game`.
2. Añadir perfiles de migracion sobre saves de referencia.
3. Introducir un modo paralelo reutilizando una segunda plantilla de config.