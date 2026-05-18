# Comandos

## Generar el bundle de mods 5Dim

Ejecutar desde la carpeta mods:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\package-5dim-mods.ps1 -Force
```

En una sola linea:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; .\mods\scripts\package-5dim-mods.ps1 -Force
```

El bundle se genera como:

```text
5dim_mods_bundle.zip
```
haz el punto 1
## Validar perfiles locales de Factorio

Ejecutar desde la carpeta mods:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\validate-factorio-profiles.ps1 -ListProfiles
.\scripts\validate-factorio-profiles.ps1 -TestSet Smoke
```

Variantes utiles:

```powershell
.\scripts\validate-factorio-profiles.ps1 -TestSet Module
.\scripts\validate-factorio-profiles.ps1 -TestSet All -RunLocaleValidation
.\scripts\validate-factorio-profiles.ps1 -Profiles suite-no-space-age,module-5dim_transport
```

Notas:

- El runner usa [config/validation-automation.ini](../config/validation-automation.ini) como plantilla.
- Los `mod-list.json` y `write-data` temporales se generan fuera del workspace.
- Al terminar, el runner deja un `summary.json` y un `report.txt` en la carpeta temporal de la corrida.
- Las combinaciones invalidas se reportan como omitidas.
- La guia de perfiles y comportamiento esta en [mods/docs/validation-smoke-tests.md](docs/validation-smoke-tests.md).
