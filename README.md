# fmod-pascal

Неофициальные биндинги FreePascal для C API FMOD. Pascal-код под MIT. Сами библиотеки FMOD сюда не входят: их нужно взять из SDK на [fmod.com](https://www.fmod.com/).

FMOD — торговая марка Firelight Technologies Pty Ltd. Этот репозиторий не связан с Firelight и не заменяет лицензию на движок.

## Версии

| Каталог | API | Макрос | Откуда |
|---|---|---|---|
| `fmod-4.44.64/` | FMOD Ex 4.44.64 | `FMOD_VERSION = $00044464` | `fmodapi44464` + FMOD Designer (`fmod_event`) |
| `fmod-2.00.22/` | FMOD Studio 2.00.22 | `FMOD_VERSION = $00020022` | `fmodstudioapi20022` (Core, Studio, FSBank) |

В установщике Studio версия записана как `20022`, а не как «5.2». Это линейка FMOD Studio (заголовки `0x00020022`).

Оба дерева объявляют юнит `fmod`. В одном проекте должен быть только один `-Fu`. Иначе подхватится чужой `.ppu`.

## Юниты

FMOD Ex 4.44.64:

| Юнит | Что внутри |
|---|---|
| `fmod` | Core, codec, DSP, memory info, output, `FMOD_ErrorString`, `FMOD_64BIT_ADD` / `SUB` |
| `fmod_classes` | Обёртки-классы над Core |
| `fmdevent` | FMOD Designer / Event |
| `fmdevent_classes` | Обёртки Event |
| `fmdeventnet` | Event Net (`FMOD_EventSystem_Init` / `Update` / `Shutdown` и `Load`) |

FMOD Studio 2.00.22:

| Юнит | Что внутри |
|---|---|
| `fmod` | Core (`fmod_common`, codec, DSP, DSP effects, output) и `FMOD_ErrorString` |
| `fmod_classes` | Обёртки Core |
| `fmodstudio` | Studio |
| `fmodstudio_classes` | Обёртки Studio. `TFMOD_STUDIO_SYSTEM.Make` принимает `headerversion` |
| `fsbank` | FSBank и `FSBank_ErrorString` |

## Сборка

Нужен Free Pascal 3.2 (проверено на 3.2.2).

```bash
fpc -Fufmod-2.00.22 examples/playsound20022.pas
fpc -Fufmod-4.44.64 examples/playsound44464.pas
```

Логирующие сборки (`fmodL`, `fmodexL`, `fmodstudioL`):

```bash
fpc -dFMOD_LOGGING -Fufmod-2.00.22 your.pas
```

Рядом с программой должна лежать библиотека из SDK той же версии API.

| | Windows | Linux | macOS |
|---|---|---|---|
| Ex 4.44 | `fmodex.dll` / `fmodex64.dll` | `libfmodex.so` / `libfmodex64.so` | `libfmodex.dylib` |
| Ex, logging | `fmodexL.dll` / `fmodexL64.dll` | `libfmodexL.so` / `libfmodexL64.so` | `libfmodexL.dylib` |
| Event | `fmod_event.dll` / `fmod_event64.dll` | `libfmodevent.so` / `libfmodevent64.so` | `libfmodevent.dylib` |
| Event Net | `fmod_event_net.dll` / `fmod_event_net64.dll` | `libfmodeventnet.so` / `libfmodeventnet64.so` | `libfmodeventnet.dylib` |
| Studio Core | `fmod.dll` (и 32, и 64) | `libfmod.so` | `libfmod.dylib` |
| Studio | `fmodstudio.dll` | `libfmodstudio.so` | `libfmodstudio.dylib` |
| FSBank | `fsbank.dll` | `libfsbank.so` | `libfsbank.dylib` |

У логирующих вариантов Studio к имени добавляется `L` перед расширением (`fmodL.dll`, `libfmodL.so`).

Имена экспортов без декорирования (`FMOD_System_Create`), как в `.def` из SDK. Импортные `.lib` не нужны.

## Соглашение о вызовах и раскладка

Как в заголовках FMOD: **stdcall** на Windows, **cdecl** на Linux и macOS. Исключение — вариативные колбэки `FMOD_DSP_LOG_FUNC` и `FMOD_OUTPUT_LOG_FUNC`: они всегда cdecl (stdcall с `...` в MSVC не бывает).

`{$PACKRECORDS C}` и `{$PACKENUM 4}`. `FMOD_BOOL` — это `Integer`, не `Boolean`. Неполные структуры хендлов — пустые `record end`. Анонимные union в конце `FMOD_DSP_PARAMETER_DESC` и `FMOD_STUDIO_USER_PROPERTY` переведены в вариантную часть без хранимого тега.

Размеры всех непустых записей и смещения ключевых полей (в том числе union) сверены с `gcc -std=c11` на linux x86_64. Win32/Win64 этим компилятором не собирались.

## Классы — это не C++ ABI

Методы в `fmod.hpp` / `fmod_studio.hpp` / `fmod_event.hpp` в основном не inline. В DLL они сидят под C++-манглингом. Юниты `*_classes` повторяют форму C++ API, но каждый метод вызывает плоскую C-функцию `FMOD_<Class>_<Method>`.

Хендл лежит в поле `FHandle` и обёрткой не владеется: перед `Free` вызовите `Release`, где он есть.

```pascal
var
  Sys: TFMOD_SYSTEM;
  Snd: TFMOD_SOUND;
  Ch: TFMOD_CHANNEL;
begin
  if TFMOD_SYSTEM.Make(Sys) <> FMOD_OK then
    Halt(1);
  Sys.Init(32, FMOD_INIT_NORMAL, nil);
  Sys.CreateSound(PAnsiChar(Path), FMOD_DEFAULT, nil, @Snd);
  { 2.00.22: }
  Sys.PlaySound(Snd, nil, 0, @Ch);
  { 4.44.64: Sys.PlaySound(FMOD_CHANNEL_FREE, Snd, 0, @Ch); }
  Sys.Release;
  Sys.Free;
end.
```

Studio:

```pascal
TFMOD_STUDIO_SYSTEM.Make(FMOD_VERSION, Studio);
```

`FMOD_VERSION` для 2.00.22 объявлен в юните `fmod` (`$00020022`).

## Имена, которые Pascal не принимает как есть

Идентификаторы без учёта регистра. Зарезервированные слова получают суффикс `_`: `type_`, `file_`, `label_`, `string_`, `function_`, `array_`, `property_`. Методы `Begin` / `End` у MusicPrompt называются `Begin_` / `End_`. Параметр, который совпал с именем метода того же класса, тоже с суффиксом (`update_` у `GetCPUUsage`, потому что есть метод `Update`).

Указатели — именованные типы `P…` и `PP…`. Запись `^PFMOD_SYSTEM` в исходнике FPC читает как управляющий символ `^P`.

## Чего в переводе нет

- Библиотеки, заголовки, документация и примеры из SDK. Их публиковать нельзя.
- Функции-макросы плагинов (`FMOD_DSP_ALLOC`, `FMOD_DSP_INIT_PARAMDESC_*`, `FMOD_OUTPUT_READFROMMIXER` и похожие). Поля для них в записях есть; сами макросы в официальном заголовке ещё и с лишней точкой с запятой.
- Динамический загрузчик. Связь только `external`. Имя библиотеки выбирается условной компиляцией и `-dFMOD_LOGGING`.

## Пример

`examples/playsound20022.pas` и `examples/playsound44464.pas` создают систему, открывают файл из аргумента и крутят `FMOD_System_Update`, пока канал играет.

В 4.44 `PlaySound` принимает индекс канала; свободный канал — `FMOD_CHANNEL_FREE` (`-1`). В 2.00 вместо индекса передаётся channel group (`nil` — мастер).

## Генератор

`tools/gen_fmod_pas.py` гоняет заголовки SDK через `gcc -E` и pycparser. Заголовки в репозиторий не кладутся.

```bash
export FMOD_SRC=/path/to/extracted/headers   # каталоги установщиков как есть
python3 tools/gen_fmod_pas.py
```

## English

Unofficial FreePascal bindings for the FMOD **C** API: Ex 4.44.64 (plus Designer event/net) and Studio 2.00.22 (core, studio, fsbank). The Pascal units are MIT. Ship the matching FMOD shared library from your own SDK; it is not in this repo. Windows is stdcall, other platforms cdecl. Class units are thin wrappers over the C functions, not bindings to the C++-mangled exports. Do not put both version directories on the same unit path: both define `unit fmod`.
