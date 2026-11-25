# Retro-Go SD con traducción española y fuente rock12 propias

Este repositorio no contiene el firmware: solo dos archivos que sustituyen a
los de [sylverb/game-and-watch-retro-go-sd](https://github.com/sylverb/game-and-watch-retro-go-sd)
y un workflow que compila el `retro-go_update.bin` con ellos.

| Archivo | Sustituye a |
|---|---|
| `Core/Src/retro-go/i18n/rg_i18n_es_es.c` | la traducción española |
| `Core/Inc/retro-go/fonts/font_cp1252_rock12.h` | la fuente rock12 (cp1252) |

Además se aplican los parches de `patches/`:

| Parche | Qué cambia |
|---|---|
| `power-button-standby.patch` | El botón power (y el reposo por inactividad o desde el menú de pausa) apaga del todo la consola (STANDBY, ~0,01 mA) en vez de dejarla en reposo (STOP2). Antes guarda la partida; al encender arranca desde cero y la recupera. |

Para quitar un parche, borra su archivo de `patches/`.

## Descargar

Cada compilación se publica en [Releases](../../releases). Descarga
`retro-go_update.bin`, cópialo a la raíz de la SD y enciende la consola.

## Cómo se compila

El workflow `custom update` (`.github/workflows/build-custom-update.yml`):

- **Se ejecuta solo cada día** y comprueba si hay algo nuevo: un commit nuevo
  en la rama `external_cores` de sylverb o un commit nuevo en este repo. Si no
  lo hay, termina sin compilar.
- **Se puede lanzar a mano** en *Actions → custom update → Run workflow*,
  eligiendo otra rama, etiqueta o commit de sylverb (por ejemplo `v2.0.0-rc2`).
- Descarga sylverb, copia encima estos dos archivos y compila con la misma
  imagen y las mismas opciones que la release oficial (SD, banco 2).
- El resumen de cada ejecución indica de qué commit de sylverb sale y cuántos
  textos en español faltan y aparecen en inglés.
- Se detiene con un error claro si sylverb cambia la marca de sección de la
  fuente (`FONT_DATA_CP1252_ROCK12`), elimina alguno de los archivos o cambia
  el código de forma que un parche ya no encaja.

Para cambiar la traducción o la fuente, edita los archivos en este repo: la
siguiente ejecución compilará con ellos.
