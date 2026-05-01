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
