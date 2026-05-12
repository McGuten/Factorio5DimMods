# Comandos

## Generar el bundle de mods 5Dim

Ejecutar desde la carpeta mods:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\package-5dim-mods.ps1 -Force
```

En una sola linea:

```powershell
Set-Location "d:\factorioDev\mods"; Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; .\package-5dim-mods.ps1 -Force
```

El bundle se genera como:

```text
5dim_mods_bundle.zip
```

## Validar perfiles locales de Factorio

Ejecutar desde la carpeta mods:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\validate-factorio-profiles.ps1 -ListProfiles
.\validate-factorio-profiles.ps1 -TestSet Smoke
```

Variantes utiles:

```powershell
.\validate-factorio-profiles.ps1 -TestSet Module
.\validate-factorio-profiles.ps1 -TestSet All -RunLocaleValidation
.\validate-factorio-profiles.ps1 -Profiles suite-no-space-age,module-5dim_transport
```

Notas:

- El runner usa [config/validation-automation.ini](../config/validation-automation.ini) como plantilla.
- Los `mod-list.json` y `write-data` temporales se generan fuera del workspace.
- Al terminar, el runner deja un `summary.json` y un `report.txt` en la carpeta temporal de la corrida.
- Las combinaciones invalidas se reportan como omitidas.
- La guia de perfiles y comportamiento esta en [mods/docs/factorio-smoke-tests.md](docs/factorio-smoke-tests.md).
