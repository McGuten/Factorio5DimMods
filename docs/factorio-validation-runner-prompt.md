# Prompt reutilizable para el runner de validacion Factorio

Usa este prompt cuando quieras extender, revisar o depurar la automatizacion local de validacion de 5Dim dentro de este mismo workspace.

## Prompt

```text
Trabaja solo con la informacion y los archivos de este workspace de Factorio/5Dim. No uses supuestos ni referencias externas al proyecto.

Objetivo:
quiero revisar o ampliar la automatizacion local de validacion de Factorio basada en mods/validate-factorio-profiles.ps1.

Contexto fijo del proyecto:
- El runner debe seguir siendo local y reutilizable.
- No debe modificar archivos versionados como mods/mod-list.json o config/*.ini.
- Debe generar temporales fuera del workspace.
- La matriz base debe mantener estos perfiles:
  1. suite-no-dlc
  2. suite-no-space-age con quality y elevated-rails activos
  3. suite-full con todo activo
  4. module-core-only
  5. core + cada modulo 5Dim por separado
- La suite completa incluye 5dim_dev y excluye 5dim_decoration y 5dim_compatibility.
- No se incluyen compatibilidades externas opcionales.
- Las combinaciones invalidas se marcan como omitidas, no como fallo.
- Hay que priorizar cargas rapidas y validaciones de humo antes de anadir pruebas mas lentas.
- Al terminar una corrida, el runner debe dejar un summary.json y un report.txt cortos y utiles.

Restricciones:
- Mantener cambios pequenos y locales.
- Reutilizar los scripts y convenciones existentes en mods/.
- Si cambias el runner, actualiza tambien la documentacion relevante en mods/comandos.md y mods/docs/factorio-smoke-tests.md.
- Si introduces una nueva opcion o perfil, documenta por que existe y que cubre.

Archivos de referencia:
- mods/validate-factorio-profiles.ps1
- mods/validate-locales.ps1
- mods/package-5dim-mods.ps1
- mods/docs/factorio-smoke-tests.md
- mods/comandos.md
- config/validation-automation.ini
- config/validation-cross-review.ini
- .vscode/settings.json

Proceso esperado:
1. Revisa el codigo actual del runner y detecta el punto exacto a cambiar.
2. Propone o implementa el cambio minimo necesario.
3. Ejecuta al menos un dry-run o una validacion focalizada despues del cambio.
4. Resume el impacto real, los perfiles afectados y cualquier riesgo pendiente.
```