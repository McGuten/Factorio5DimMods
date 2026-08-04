# Guia General De Diseno Y Lectura Del Repo

Documento general para leer el rediseño tiered de 5Dim sin tener que entrar
directamente en todas las matrices por modulo.

Objetivo:
- dejar claras las reglas transversales de diseno que hoy se repiten entre docs
  y prototipos
- marcar donde esta la fuente de verdad segun el tipo de duda
- dar un orden de lectura corto para revisar o modificar una familia

Este archivo no sustituye al codigo ni a los planes.

- Los prototipos siguen siendo la fuente de verdad de la implementacion actual.
- Los archivos en docs/plans guardan ideas, exploracion y decisiones aun no
  cerradas en codigo.
- Este documento solo recoge reglas estables de lectura y diseno ya visibles en
  el repo.

## Fuentes De Verdad

Usar esta prioridad:

1. Prototipos y helpers de coste cuando la duda es que hace hoy el mod.
2. Documentos transversales cuando la duda es por que una familia sigue cierta
   ruta o que patron general se espera.
3. docs/plans solo cuando la pregunta es de diseno futuro y todavia no existe
   una implementacion equivalente.

Referencias principales:
- mods/5dim_core/lib/costs/templates/space-age.lua
- mods/5dim_core/lib/costs/
- mods/5dim_*/prototypes/
- [design-modules.md](design-modules.md)
- [design-resources.md](design-resources.md)
- [design-planets.md](design-planets.md)
- [design-planets-detailed.md](design-planets-detailed.md)
- [design-upgrades.md](design-upgrades.md)

## Orden De Lectura Recomendado

Cuando tengas que revisar una familia o preparar un cambio:

1. Identifica el modulo responsable en mods/5dim_*.
2. Decide si la familia es una extension vanilla, una familia 100% 5Dim o una
   familia upgrade de otra base.
3. Usa [design-modules.md](design-modules.md) para ver bloques,
  excepciones, bandas y categorias del modulo antes de bajar a tablas o codigo.
4. Mira despues los prototipos del modulo y, si hay materiales SA o reglas de
  acumulacion, los templates de coste de 5dim_core.
5. Usa [design-planets.md](design-planets.md) para confirmar la
   lectura planetaria general.
6. Usa [design-planets-detailed.md](design-planets-detailed.md) si la
   duda es en que tiers concretos entra cada superficie.
7. Usa [design-resources.md](design-resources.md) si la duda es que
   recurso encaja como delta o que afinidad funcional tiene.
8. Usa [design-upgrades.md](design-upgrades.md) si la familia reutiliza otra
   como base de recipe.

## Reglas Base Del Rediseño Tiered

- Los tiers vanilla se respetan intactos.
- Los tiers propios de 5Dim son acumulativos.
- Cada tier nuevo debe anadir un delta directo visible y no redundante.
- El delta de un tier no debe repetir el item base, el item previo ni un coste
  ya encapsulado por ellos salvo excepcion funcional clara.
- La receta visible no debe perder presion de coste al subir tier.
- Los modulos no deben usarse como simple token barato de tier alto.
- Los fluidos se reservan para familias que realmente se lean como quimica,
  refino, metalurgia, criogenia o espacio.

## Arquitectura Por Bloques

- Si un modulo tiene varias familias con funciones distintas, debe leerse por
  bloques funcionales y no por una sola cola material comun.
- La separacion por bloques es especialmente importante en battlefield, energy,
  resources, space_age, transport, storage y nuclear.
- Un bloque funcional debe mantener una identidad reconocible por ruta SA,
  categoria de recipe, gating y cierre final.
- Si dos familias del mismo modulo solo se distinguen por cantidades, el diseno
  probablemente esta mal aunque las recetas compilen.
- La referencia compacta por modulo vive en
  [design-modules.md](design-modules.md).

## Regla Space Age

- Cuando existe ruta Space Age, el delta planetario sustituye al delta vanilla
  directo del tier visible; no se apila encima por defecto.
- Activar Space Age debe sentirse de verdad en la receta, no solo en un remate
  simbolico al final.
- En familias backbone o industriales generalistas, la presion SA visible debe
  entrar ya en bandas medias del arbol 5Dim.
- Aquilo debe concentrarse preferentemente en un unico tier final visible.
  Dos tiers finales ya cuentan como excepcion; una cola mas larga necesita una
  razon fuerte del propio modulo.

## Lectura Por Superficie

Estas superficies no significan solo rareza. Marcan identidad funcional.

| Superficie | Lectura corta | Senales tipicas |
| --- | --- | --- |
| Vulcanus | Apertura industrial pesada | calcite, molten-iron, molten-copper, tungsten-plate, tungsten-carbide, foundry |
| Fulgora | Control fino y electronica | holmium-plate, electrolyte, supercapacitor, superconductor, electromagnetic plant |
| Gleba | Biologia y desvio organico real | jelly, bioflux, carbon-fiber, biochamber |
| Aquilo | Cierre criogenico y energia extrema | lithium-plate, ammoniacal-solution, fluorine, fluoroketones, fusion-power-cell |
| Orbita y gravedad cero | Gating espacial explicito | asteroid chunks, space-platform-foundation, thruster-fuel, thruster-oxidizer |

Reglas practicas:
- Si una familia aparece en Vulcanus, Fulgora y Aquilo, la lectura normal es
  apertura industrial -> control fino -> cierre criogenico.
- Si aparece en Fulgora y Aquilo, suele ser una rama de control, red,
  robotica, modulos o soporte personal.
- Gleba debe entrar por afinidad biologica, toxica o por una desviacion
  organica con sentido real, no por rareza gratuita.
- Orbita debe entrar por restriccion de superficie explicita o por uso real de
  materiales orbitales, no solo para decorar el ultimo tier.
- Las familias nativas de un planeta o de gravedad cero deben conservar esa
  identidad aunque luego crucen a otra superficie.

## Regla De Categorias SA Por Arquetipo

- Estructura, calor, chasis y maquinaria pesada suelen abrir SA por metallurgy,
  pasar por electromagnetics cuando aparece control fino y cerrar con
  cryogenics solo al final.
- Red, robotica, modulos, precision y control suelen entrar en SA por
  electromagnetics y reservar cryogenics para el cierre.
- Biologia y toxico real deben mostrar biochamber, organic o una categoria de
  proceso equivalente antes de mezclarse con Fulgora o Aquilo.
- Fluidos, refino, quimica y contencion deben usar crafting-with-fluid o una
  categoria de proceso explicita cuando el delta visible lo exija.
- Orbita y gravedad cero deben mostrar categoria y restriccion de superficie
  explicitas cuando el proceso sea realmente espacial.

## Regla De Upgrades

Cuando una familia se construye como upgrade de otra:

- La MK1 pone primero el item base mejorado y despues los deltas propios.
- La MK2+ pone primero el tier anterior de la propia familia y despues el item
  base equivalente del mismo MK.
- El item base se mantiene en cantidad 1.
- Si una familia hibrida conserva intacta la recipe vanilla, el patron de
  upgrade puede empezar en MK2.

Mapa de referencia:
- [design-upgrades.md](design-upgrades.md)

## Categorias Y Gating

- La categoria de recipe no es decoracion: forma parte del comportamiento.
- Si una familia usa fluidos, electromagnetismo, biochamber, foundry,
  criogenia u orbita, la categoria y el gating deben hacerlo visible.
- No conviene esconder una familia planetaria dentro de crafting generico si el
  tier se apoya de verdad en un proceso especializado.
- En 5dim_space_age, planeta, categoria y restriccion de superficie se leen
  como parte del mismo bloque de identidad.

## Excepciones Canonicas

- Exoskeleton equipment y power armor desvian su tramo SA medio y tardio a
  Gleba y orbita; no siguen una cola Fulgora estandar.
- Construction robot cruza Gleba y vuelve un escalon a Fulgora antes de orbita;
  esa vuelta no debe perderse por simplificacion documental.
- Spidertron entra en SA real tarde y por una ruta propia de Gleba -> orbita ->
  Aquilo; no es un segundo tank.
- Mech armor arranca en Fulgora, cruza un desvio biologico corto por Gleba y
  cierra en Aquilo con una cadena de fluidos propia.
- Night vision equipment queda capado en MK2 y no debe recibir una ruta SA por
  inercia.
- En resources, dust planetaria y soporte planetario se tratan como subfamilias
  SA nativas, no como sobrecapas cosmeticas de recetas comunes.

## Anti-Patrones Comunes

- Hacer que varias familias converjan en una misma cola tardia solo cambiando
  cantidades.
- Meter Gleba por rareza o exotismo sin afinidad biologica, toxica u organica
  real.
- Usar orbita como decoracion del ultimo tier sin gating espacial explicito.
- Repetir varios cierres de Aquilo en paralelo dentro de la misma familia sin
  una razon estructural fuerte.
- Dejar un modulo entero en un tercer escalon repetido de Fulgora cuando la
  regla del bloque pide ya un cierre criogenico.
- Usar modulos o recursos muy concentrados como atajo para abaratar tiers altos.
- Esconder categorias de proceso, metalurgia, criogenia u orbita dentro de
  crafting generico cuando el delta visible depende de ellas.

## Politica Documental

- La implementacion actual se confirma en prototipos y helpers, no en tablas
  narrativas duplicadas.
- Los docs generales deben guardar reglas transversales, mapas de lectura y
  excepciones reales.
- Los docs/plans pueden guardar exploracion y decisiones futuras, pero no deben
  mezclarse con la fuente de verdad del comportamiento actual.
- Si un cambio de codigo altera una regla global, una ruta planetaria o un
  patron de upgrade, conviene actualizar este archivo y el documento
  transversal correspondiente en la misma pasada.

## Mapa Minimo De Consulta

Si solo necesitas una respuesta rapida:

- Que bloques, bandas, categorias y excepciones tiene un modulo: [design-modules.md](design-modules.md)
- Que recurso encaja como delta: [design-resources.md](design-resources.md)
- Que planeta deberia entrar y por que: [design-planets.md](design-planets.md)
- En que tiers concretos entra una superficie: [design-planets-detailed.md](design-planets-detailed.md)
- Como se encadena una familia upgrade: [design-upgrades.md](design-upgrades.md)
- Que hace hoy el repo de verdad: mods/5dim_core/lib/costs/ y mods/5dim_*/prototypes/

## Estado De Las Matrices Por Modulo

La informacion transversal y modular minima para seguir leyendo el repo vive en
este archivo, en [design-modules.md](design-modules.md) y en los
mapas transversales.

Las antiguas matrix por modulo ya fueron absorbidas y eliminadas. Si en el
futuro reaparece documentacion modular detallada, deberia nacer ya como resumen
o excepcion puntual y no como duplicado completo de tablas visibles en codigo.