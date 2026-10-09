(*
  FreePascal binding for FMOD FSBank
  API version 2.00.22 (0x00020022)

  Unofficial translation of the C API. FMOD is a trademark of Firelight
  Technologies Pty Ltd. This unit does not include the FMOD library;
  obtain a licensed SDK from https://www.fmod.com/ and ship the matching
  shared library next to your executable.

  Calling convention matches the C headers: stdcall on Windows, cdecl elsewhere.
  Records use PACKRECORDS C so the layout matches the C ABI.

  Define FMOD_LOGGING to link the logging build (fmodL / fmodexL).
*)
{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}{$PACKRECORDS C}{$PACKENUM 4}{$MACRO ON}
  {$MODESWITCH RESULT+}
{$ENDIF}
unit fsbank;

interface

const
{$IF defined(MSWINDOWS)}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fsbank.dll';
    {$ELSE}
  FMOD_LIB = 'fsbank.dll';
    {$ENDIF}
  {$ELSE}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fsbank.dll';
    {$ELSE}
  FMOD_LIB = 'fsbank.dll';
    {$ENDIF}
  {$ENDIF}
{$ELSEIF defined(DARWIN)}
  {$IF defined(FMOD_LOGGING)}
  FMOD_LIB = 'libfsbank.dylib';
  {$ELSE}
  FMOD_LIB = 'libfsbank.dylib';
  {$ENDIF}
{$ELSE}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfsbank.so';
    {$ELSE}
  FMOD_LIB = 'libfsbank.so';
    {$ENDIF}
  {$ELSE}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfsbank.so';
    {$ELSE}
  FMOD_LIB = 'libfsbank.so';
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IF defined(MSWINDOWS)}
  {$DEFINE FMOD_CC := stdcall}
{$ELSE}
  {$DEFINE FMOD_CC := cdecl}
{$ENDIF}

const
  FSBANK_INIT_NORMAL = $00000000;
  FSBANK_INIT_IGNOREERRORS = $00000001;
  FSBANK_INIT_WARNINGSASERRORS = $00000002;
  FSBANK_INIT_CREATEINCLUDEHEADER = $00000004;
  FSBANK_INIT_DONTLOADCACHEFILES = $00000008;
  FSBANK_INIT_GENERATEPROGRESSITEMS = $00000010;
  FSBANK_BUILD_DEFAULT = $00000000;
  FSBANK_BUILD_DISABLESYNCPOINTS = $00000001;
  FSBANK_BUILD_DONTLOOP = $00000002;
  FSBANK_BUILD_FILTERHIGHFREQ = $00000004;
  FSBANK_BUILD_DISABLESEEKING = $00000008;
  FSBANK_BUILD_OPTIMIZESAMPLERATE = $00000010;
  FSBANK_BUILD_FSB5_DONTWRITENAMES = $00000080;
  FSBANK_BUILD_NOGUID = $00000100;
  FSBANK_BUILD_WRITEPEAKVOLUME = $00000200;
  FSBANK_BUILD_OVERRIDE_MASK = (FSBANK_BUILD_DISABLESYNCPOINTS or FSBANK_BUILD_DONTLOOP or FSBANK_BUILD_FILTERHIGHFREQ or FSBANK_BUILD_DISABLESEEKING or FSBANK_BUILD_OPTIMIZESAMPLERATE or FSBANK_BUILD_WRITEPEAKVOLUME);
  FSBANK_BUILD_CACHE_VALIDATION_MASK = (FSBANK_BUILD_DONTLOOP or FSBANK_BUILD_FILTERHIGHFREQ or FSBANK_BUILD_OPTIMIZESAMPLERATE);

type
  PFSBANK_INITFLAGS = ^FSBANK_INITFLAGS;
  PPFSBANK_INITFLAGS = ^PFSBANK_INITFLAGS;
  PFSBANK_BUILDFLAGS = ^FSBANK_BUILDFLAGS;
  PPFSBANK_BUILDFLAGS = ^PFSBANK_BUILDFLAGS;
  PFSBANK_RESULT = ^FSBANK_RESULT;
  PPFSBANK_RESULT = ^PFSBANK_RESULT;
  PFSBANK_FORMAT = ^FSBANK_FORMAT;
  PPFSBANK_FORMAT = ^PFSBANK_FORMAT;
  PFSBANK_FSBVERSION = ^FSBANK_FSBVERSION;
  PPFSBANK_FSBVERSION = ^PFSBANK_FSBVERSION;
  PFSBANK_STATE = ^FSBANK_STATE;
  PPFSBANK_STATE = ^PFSBANK_STATE;
  PFSBANK_SUBSOUND = ^FSBANK_SUBSOUND;
  PPFSBANK_SUBSOUND = ^PFSBANK_SUBSOUND;
  PFSBANK_PROGRESSITEM = ^FSBANK_PROGRESSITEM;
  PPFSBANK_PROGRESSITEM = ^PFSBANK_PROGRESSITEM;
  PFSBANK_STATEDATA_FAILED = ^FSBANK_STATEDATA_FAILED;
  PPFSBANK_STATEDATA_FAILED = ^PFSBANK_STATEDATA_FAILED;
  PFSBANK_STATEDATA_WARNING = ^FSBANK_STATEDATA_WARNING;
  PPFSBANK_STATEDATA_WARNING = ^PFSBANK_STATEDATA_WARNING;
  PFSBANK_MEMORY_ALLOC_CALLBACK = ^FSBANK_MEMORY_ALLOC_CALLBACK;
  PPFSBANK_MEMORY_ALLOC_CALLBACK = ^PFSBANK_MEMORY_ALLOC_CALLBACK;
  PFSBANK_MEMORY_REALLOC_CALLBACK = ^FSBANK_MEMORY_REALLOC_CALLBACK;
  PPFSBANK_MEMORY_REALLOC_CALLBACK = ^PFSBANK_MEMORY_REALLOC_CALLBACK;
  PFSBANK_MEMORY_FREE_CALLBACK = ^FSBANK_MEMORY_FREE_CALLBACK;
  PPFSBANK_MEMORY_FREE_CALLBACK = ^PFSBANK_MEMORY_FREE_CALLBACK;
  FSBANK_INITFLAGS = Cardinal;
  FSBANK_BUILDFLAGS = Cardinal;
  FSBANK_RESULT = (
    FSBANK_OK,
    FSBANK_ERR_CACHE_CHUNKNOTFOUND,
    FSBANK_ERR_CANCELLED,
    FSBANK_ERR_CANNOT_CONTINUE,
    FSBANK_ERR_ENCODER,
    FSBANK_ERR_ENCODER_INIT,
    FSBANK_ERR_ENCODER_NOTSUPPORTED,
    FSBANK_ERR_FILE_OS,
    FSBANK_ERR_FILE_NOTFOUND,
    FSBANK_ERR_FMOD,
    FSBANK_ERR_INITIALIZED,
    FSBANK_ERR_INVALID_FORMAT,
    FSBANK_ERR_INVALID_PARAM,
    FSBANK_ERR_MEMORY,
    FSBANK_ERR_UNINITIALIZED,
    FSBANK_ERR_WRITER_FORMAT,
    FSBANK_WARN_CANNOTLOOP,
    FSBANK_WARN_IGNORED_FILTERHIGHFREQ,
    FSBANK_WARN_IGNORED_DISABLESEEKING,
    FSBANK_WARN_FORCED_DONTWRITENAMES,
    FSBANK_ERR_ENCODER_FILE_NOTFOUND,
    FSBANK_ERR_ENCODER_FILE_BAD
  );
  FSBANK_FORMAT = (
    FSBANK_FORMAT_PCM,
    FSBANK_FORMAT_PCM_BIGENDIAN,
    FSBANK_FORMAT_XMA,
    FSBANK_FORMAT_AT9_PSVITA,
    FSBANK_FORMAT_AT9_PS4,
    FSBANK_FORMAT_VORBIS,
    FSBANK_FORMAT_FADPCM,
    FSBANK_FORMAT_OPUS,
    FSBANK_FORMAT_MAX
  );
  FSBANK_FSBVERSION = (
    FSBANK_FSBVERSION_FSB5,
    FSBANK_FSBVERSION_MAX
  );
  FSBANK_STATE = (
    FSBANK_STATE_DECODING,
    FSBANK_STATE_ANALYSING,
    FSBANK_STATE_PREPROCESSING,
    FSBANK_STATE_ENCODING,
    FSBANK_STATE_WRITING,
    FSBANK_STATE_FINISHED,
    FSBANK_STATE_FAILED,
    FSBANK_STATE_WARNING
  );
  FSBANK_SUBSOUND = record
    fileNames: PPAnsiChar;
    fileData: PPointer;
    fileDataLengths: PCardinal;
    numFiles: Cardinal;
    overrideFlags: FSBANK_BUILDFLAGS;
    overrideQuality: Cardinal;
    desiredSampleRate: Single;
    percentOptimizedRate: Single;
  end;
  FSBANK_PROGRESSITEM = record
    subSoundIndex: Integer;
    threadIndex: Integer;
    state: FSBANK_STATE;
    stateData: Pointer;
  end;
  FSBANK_STATEDATA_FAILED = record
    errorCode: FSBANK_RESULT;
    errorString: array[0..255] of AnsiChar;
  end;
  FSBANK_STATEDATA_WARNING = record
    warnCode: FSBANK_RESULT;
    warningString: array[0..255] of AnsiChar;
  end;
  FSBANK_MEMORY_ALLOC_CALLBACK = function(size: Cardinal; type_: Cardinal; sourceStr: PAnsiChar): Pointer; FMOD_CC;
  FSBANK_MEMORY_REALLOC_CALLBACK = function(ptr: Pointer; size: Cardinal; type_: Cardinal; sourceStr: PAnsiChar): Pointer; FMOD_CC;
  FSBANK_MEMORY_FREE_CALLBACK = procedure(ptr: Pointer; type_: Cardinal; sourceStr: PAnsiChar); FMOD_CC;

function FSBank_MemoryInit(userAlloc: FSBANK_MEMORY_ALLOC_CALLBACK; userRealloc: FSBANK_MEMORY_REALLOC_CALLBACK; userFree: FSBANK_MEMORY_FREE_CALLBACK): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_MemoryInit';
function FSBank_Init(version: FSBANK_FSBVERSION; flags: FSBANK_INITFLAGS; numSimultaneousJobs: Cardinal; cacheDirectory: PAnsiChar): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_Init';
function FSBank_Release(): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_Release';
function FSBank_Build(subSounds: PFSBANK_SUBSOUND; numSubSounds: Cardinal; encodeFormat: FSBANK_FORMAT; buildFlags: FSBANK_BUILDFLAGS; quality: Cardinal; encryptKey: PAnsiChar; outputFileName: PAnsiChar): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_Build';
function FSBank_FetchFSBMemory(data: PPointer; length: PCardinal): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_FetchFSBMemory';
function FSBank_BuildCancel(): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_BuildCancel';
function FSBank_FetchNextProgressItem(progressItem: PPFSBANK_PROGRESSITEM): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_FetchNextProgressItem';
function FSBank_ReleaseProgressItem(progressItem: PFSBANK_PROGRESSITEM): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_ReleaseProgressItem';
function FSBank_MemoryGetStats(currentAllocated: PCardinal; maximumAllocated: PCardinal): FSBANK_RESULT; FMOD_CC;
  external FMOD_LIB name 'FSBank_MemoryGetStats';

function FSBank_ErrorString(errcode: FSBANK_RESULT): AnsiString;


implementation

function FSBank_ErrorString(errcode: FSBANK_RESULT): AnsiString;
begin
  case errcode of
    FSBANK_OK: Result := 'No errors.';
    FSBANK_ERR_CACHE_CHUNKNOTFOUND: Result := 'An expected chunk is missing from the cache, perhaps try deleting cache files.';
    FSBANK_ERR_CANCELLED: Result := 'The build process was cancelled during compilation by the user.';
    FSBANK_ERR_CANNOT_CONTINUE: Result := 'The build process cannot continue due to previously ignored errors.';
    FSBANK_ERR_ENCODER: Result := 'Encoder for chosen format has encountered an unexpected error.';
    FSBANK_ERR_ENCODER_INIT: Result := 'Encoder initialization failed.';
    FSBANK_ERR_ENCODER_NOTSUPPORTED: Result := 'Encoder for chosen format is not supported on this platform.';
    FSBANK_ERR_FILE_OS: Result := 'An operating system based file error was encountered.';
    FSBANK_ERR_FILE_NOTFOUND: Result := 'A specified file could not be found.';
    FSBANK_ERR_FMOD: Result := 'Internal error from FMOD sub-system.';
    FSBANK_ERR_INITIALIZED: Result := 'Already initialized.';
    FSBANK_ERR_INVALID_FORMAT: Result := 'The format of the source file is invalid.';
    FSBANK_ERR_INVALID_PARAM: Result := 'An invalid parameter has been passed to this function.';
    FSBANK_ERR_MEMORY: Result := 'Run out of memory.';
    FSBANK_ERR_UNINITIALIZED: Result := 'Not initialized yet.';
    FSBANK_ERR_WRITER_FORMAT: Result := 'Chosen encode format is not supported by this FSB version.';
    FSBANK_WARN_CANNOTLOOP: Result := 'Source file is too short for seamless looping. Looping disabled.';
    FSBANK_WARN_IGNORED_FILTERHIGHFREQ: Result := 'FSBANK_BUILD_FILTERHIGHFREQ flag ignored: feature only supported by XMA format.';
    FSBANK_WARN_IGNORED_DISABLESEEKING: Result := 'FSBANK_BUILD_DISABLESEEKING flag ignored: feature only supported by XMA format.';
    FSBANK_WARN_FORCED_DONTWRITENAMES: Result := 'FSBANK_BUILD_FSB5_DONTWRITENAMES flag forced: cannot write names when source is from memory.';
    FSBANK_ERR_ENCODER_FILE_NOTFOUND: Result := 'External encoder dynamic library not found.';
    FSBANK_ERR_ENCODER_FILE_BAD: Result := 'External encoder dynamic library could not be loaded, possibly incorrect binary format, incorrect architecture, or file corruption.';
  else
    Result := 'Unknown error.';
  end;
end;

end.
