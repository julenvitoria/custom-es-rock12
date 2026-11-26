# Retro-Go SD con traducción española y fuente rock12 propias

Este repositorio no contiene el firmware: solo los cambios sobre
[sylverb/game-and-watch-retro-go-sd](https://github.com/sylverb/game-and-watch-retro-go-sd)
y un workflow que compila el `retro-go_update.bin` con ellos.

| Archivo | Sustituye a |
|---|---|
| `Core/Src/retro-go/i18n/rg_i18n_es_es.c` | la traducción española |
| `Core/Inc/retro-go/fonts/font_cp1252_rock12.h` | la fuente rock12 (cp1252) |

## Variantes

Cada compilación genera dos ficheros:

| Fichero | Botón power |
|---|---|
| `retro-go_update_reposo.bin` | Deja la consola en reposo (STOP2), como el firmware original. Despierta al instante. |
| `retro-go_update_apagado.bin` | Apaga del todo la consola (STANDBY, ~0,01 mA). Antes guarda la partida; al encender arranca desde cero y la recupera. También aplica al reposo por inactividad y al del menú de pausa. |

Mientras haya parches en `patches/bateria/`, se generan además
`retro-go_update_reposo_bateria.bin` y `retro-go_update_apagado_bateria.bin`:
las mismas variantes con los arreglos de batería en pruebas, antes de
enviarlos a sylverb. Cuando sylverb los integre, se borra la carpeta y dejan
de generarse.

## Descargar

Cada compilación se publica en [Releases](../../releases). Descarga la
variante que quieras, **renómbrala a `retro-go_update.bin`**, cópiala a la
raíz de la SD y enciende la consola.

## Parches

Los cambios de código que no son archivos enteros van como parches:

- `patches/*.patch`: se aplican a las **dos** variantes.
- `patches/apagado/*.patch`: solo a la variante de **apagado**
  (`power-button-standby.patch`).
- `patches/bateria/*.patch`: solo a las variantes **_bateria** (arreglos en
  pruebas).

Para quitar un parche, borra su archivo. Para añadir uno, deja un `.patch`
(formato `git diff`) en la carpeta que corresponda.

## Cómo se compila

El workflow `custom update` (`.github/workflows/build-custom-update.yml`):

- **Se ejecuta solo cada día** y comprueba si hay algo nuevo: un commit nuevo
  en la rama `external_cores` de sylverb o un commit nuevo en este repo. Si no
  lo hay, termina sin compilar.
- **Se puede lanzar a mano** en *Actions → custom update → Run workflow*,
  eligiendo otra rama, etiqueta o commit de sylverb (por ejemplo `v2.0.0-rc2`).
- Descarga sylverb, copia encima los dos archivos, aplica los parches y
  compila las dos variantes con la misma imagen y las mismas opciones que la
  release oficial (SD, banco 2).
- El resumen de cada ejecución indica de qué commit de sylverb sale y cuántos
  textos en español faltan y aparecen en inglés.
- Se detiene con un error claro si sylverb cambia la marca de sección de la
  fuente (`FONT_DATA_CP1252_ROCK12`), elimina alguno de los archivos o cambia
  el código de forma que un parche ya no encaja.

Para cambiar la traducción, la fuente o los parches, edítalos en este repo:
la siguiente ejecución compilará con ellos.
