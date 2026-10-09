(*
  FreePascal binding for FMOD Ex Event / Designer API
  API version 4.44.64 (0x00044464)

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
unit fmdevent;

interface

uses
  fmod;

const
{$IF defined(MSWINDOWS)}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fmod_eventL64.dll';
    {$ELSE}
  FMOD_LIB = 'fmod_eventL.dll';
    {$ENDIF}
  {$ELSE}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fmod_event64.dll';
    {$ELSE}
  FMOD_LIB = 'fmod_event.dll';
    {$ENDIF}
  {$ENDIF}
{$ELSEIF defined(DARWIN)}
  {$IF defined(FMOD_LOGGING)}
  FMOD_LIB = 'libfmodeventL.dylib';
  {$ELSE}
  FMOD_LIB = 'libfmodevent.dylib';
  {$ENDIF}
{$ELSE}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfmodeventL64.so';
    {$ELSE}
  FMOD_LIB = 'libfmodeventL.so';
    {$ENDIF}
  {$ELSE}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfmodevent64.so';
    {$ELSE}
  FMOD_LIB = 'libfmodevent.so';
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IF defined(MSWINDOWS)}
  {$DEFINE FMOD_CC := stdcall}
{$ELSE}
  {$DEFINE FMOD_CC := cdecl}
{$ENDIF}

const
  FMOD_EVENT_VERSION = $00044464;
  FMOD_EVENT_INIT_NORMAL = $00000000;
  FMOD_EVENT_INIT_USER_ASSETMANAGER = $00000001;
  FMOD_EVENT_INIT_FAIL_ON_MAXSTREAMS = $00000002;
  FMOD_EVENT_INIT_DONTUSENAMES = $00000004;
  FMOD_EVENT_INIT_UPPERCASE_FILENAMES = $00000008;
  FMOD_EVENT_INIT_LOWERCASE_FILENAMES = $00000080;
  FMOD_EVENT_INIT_SEARCH_PLUGINS = $00000010;
  FMOD_EVENT_INIT_USE_GUIDS = $00000020;
  FMOD_EVENT_INIT_DETAILED_SOUNDDEF_INFO = $00000040;
  FMOD_EVENT_INIT_RESETPARAMSTOMINIMUM = $00000100;
  FMOD_EVENT_INIT_ELEVATION_AFFECTS_LISTENER_ANGLE = $00000200;
  FMOD_EVENT_INIT_DONTUSELOWMEM = $00000400;
  FMOD_EVENT_DEFAULT = $00000000;
  FMOD_EVENT_NONBLOCKING = $00000001;
  FMOD_EVENT_ERROR_ON_DISKACCESS = $00000002;
  FMOD_EVENT_INFOONLY = $00000004;
  FMOD_EVENT_USERDSP = $00000008;
  FMOD_EVENT_NONBLOCKING_THREAD0 = (FMOD_EVENT_NONBLOCKING);
  FMOD_EVENT_NONBLOCKING_THREAD1 = (FMOD_EVENT_NONBLOCKING or $00010000);
  FMOD_EVENT_NONBLOCKING_THREAD2 = (FMOD_EVENT_NONBLOCKING or $00020000);
  FMOD_EVENT_NONBLOCKING_THREAD3 = (FMOD_EVENT_NONBLOCKING or $00040000);
  FMOD_EVENT_NONBLOCKING_THREAD4 = (FMOD_EVENT_NONBLOCKING or $00080000);
  FMOD_EVENT_NONBLOCKING_THREAD_MAX = 5;
  FMOD_EVENT_STATE_READY = $00000001;
  FMOD_EVENT_STATE_LOADING = $00000002;
  FMOD_EVENT_STATE_ERROR = $00000004;
  FMOD_EVENT_STATE_PLAYING = $00000008;
  FMOD_EVENT_STATE_CHANNELSACTIVE = $00000010;
  FMOD_EVENT_STATE_INFOONLY = $00000020;
  FMOD_EVENT_STATE_STARVING = $00000040;
  FMOD_EVENT_STATE_NEEDSTOLOAD = $00000080;

type
  PFMOD_EVENTSYSTEM = ^FMOD_EVENTSYSTEM;
  PPFMOD_EVENTSYSTEM = ^PFMOD_EVENTSYSTEM;
  PFMOD_EVENTPROJECT = ^FMOD_EVENTPROJECT;
  PPFMOD_EVENTPROJECT = ^PFMOD_EVENTPROJECT;
  PFMOD_EVENTGROUP = ^FMOD_EVENTGROUP;
  PPFMOD_EVENTGROUP = ^PFMOD_EVENTGROUP;
  PFMOD_EVENTCATEGORY = ^FMOD_EVENTCATEGORY;
  PPFMOD_EVENTCATEGORY = ^PFMOD_EVENTCATEGORY;
  PFMOD_EVENT = ^FMOD_EVENT;
  PPFMOD_EVENT = ^PFMOD_EVENT;
  PFMOD_EVENTPARAMETER = ^FMOD_EVENTPARAMETER;
  PPFMOD_EVENTPARAMETER = ^PFMOD_EVENTPARAMETER;
  PFMOD_EVENTREVERB = ^FMOD_EVENTREVERB;
  PPFMOD_EVENTREVERB = ^PFMOD_EVENTREVERB;
  PFMOD_EVENTQUEUE = ^FMOD_EVENTQUEUE;
  PPFMOD_EVENTQUEUE = ^PFMOD_EVENTQUEUE;
  PFMOD_EVENTQUEUEENTRY = ^FMOD_EVENTQUEUEENTRY;
  PPFMOD_EVENTQUEUEENTRY = ^PFMOD_EVENTQUEUEENTRY;
  PFMOD_MUSICPROMPT = ^FMOD_MUSICPROMPT;
  PPFMOD_MUSICPROMPT = ^PFMOD_MUSICPROMPT;
  PFMOD_MUSICSYSTEM = ^FMOD_MUSICSYSTEM;
  PPFMOD_MUSICSYSTEM = ^PFMOD_MUSICSYSTEM;
  PFMOD_EVENT_INITFLAGS = ^FMOD_EVENT_INITFLAGS;
  PPFMOD_EVENT_INITFLAGS = ^PFMOD_EVENT_INITFLAGS;
  PFMOD_EVENT_MODE = ^FMOD_EVENT_MODE;
  PPFMOD_EVENT_MODE = ^PFMOD_EVENT_MODE;
  PFMOD_EVENT_STATE = ^FMOD_EVENT_STATE;
  PPFMOD_EVENT_STATE = ^PFMOD_EVENT_STATE;
  PFMOD_MUSIC_ID = ^FMOD_MUSIC_ID;
  PPFMOD_MUSIC_ID = ^PFMOD_MUSIC_ID;
  PFMOD_MUSIC_CUE_ID = ^FMOD_MUSIC_CUE_ID;
  PPFMOD_MUSIC_CUE_ID = ^PFMOD_MUSIC_CUE_ID;
  PFMOD_MUSIC_PARAM_ID = ^FMOD_MUSIC_PARAM_ID;
  PPFMOD_MUSIC_PARAM_ID = ^PFMOD_MUSIC_PARAM_ID;
  PFMOD_EVENT_PROPERTY = ^FMOD_EVENT_PROPERTY;
  PPFMOD_EVENT_PROPERTY = ^PFMOD_EVENT_PROPERTY;
  PFMOD_EVENTPROPERTY_TYPE = ^FMOD_EVENTPROPERTY_TYPE;
  PPFMOD_EVENTPROPERTY_TYPE = ^PFMOD_EVENTPROPERTY_TYPE;
  PFMOD_EVENT_PITCHUNITS = ^FMOD_EVENT_PITCHUNITS;
  PPFMOD_EVENT_PITCHUNITS = ^PFMOD_EVENT_PITCHUNITS;
  PFMOD_EVENT_RESOURCE = ^FMOD_EVENT_RESOURCE;
  PPFMOD_EVENT_RESOURCE = ^PFMOD_EVENT_RESOURCE;
  PFMOD_EVENT_CALLBACKTYPE = ^FMOD_EVENT_CALLBACKTYPE;
  PPFMOD_EVENT_CALLBACKTYPE = ^PFMOD_EVENT_CALLBACKTYPE;
  PFMOD_EVENT_WAVEBANKINFO = ^FMOD_EVENT_WAVEBANKINFO;
  PPFMOD_EVENT_WAVEBANKINFO = ^PFMOD_EVENT_WAVEBANKINFO;
  PFMOD_EVENT_SYSTEMINFO = ^FMOD_EVENT_SYSTEMINFO;
  PPFMOD_EVENT_SYSTEMINFO = ^PFMOD_EVENT_SYSTEMINFO;
  PFMOD_EVENT_PROJECTINFO = ^FMOD_EVENT_PROJECTINFO;
  PPFMOD_EVENT_PROJECTINFO = ^PFMOD_EVENT_PROJECTINFO;
  PFMOD_EVENT_INFO = ^FMOD_EVENT_INFO;
  PPFMOD_EVENT_INFO = ^PFMOD_EVENT_INFO;
  PFMOD_EVENT_SOUNDDEF_ENTRYTYPE = ^FMOD_EVENT_SOUNDDEF_ENTRYTYPE;
  PPFMOD_EVENT_SOUNDDEF_ENTRYTYPE = ^PFMOD_EVENT_SOUNDDEF_ENTRYTYPE;
  PFMOD_EVENT_SOUNDDEFINFO = ^FMOD_EVENT_SOUNDDEFINFO;
  PPFMOD_EVENT_SOUNDDEFINFO = ^PFMOD_EVENT_SOUNDDEFINFO;
  PFMOD_EVENT_LOADINFO = ^FMOD_EVENT_LOADINFO;
  PPFMOD_EVENT_LOADINFO = ^PFMOD_EVENT_LOADINFO;
  PFMOD_EVENT_CALLBACK = ^FMOD_EVENT_CALLBACK;
  PPFMOD_EVENT_CALLBACK = ^PFMOD_EVENT_CALLBACK;
  PFMOD_EVENTQUEUE_CALLBACKTYPE = ^FMOD_EVENTQUEUE_CALLBACKTYPE;
  PPFMOD_EVENTQUEUE_CALLBACKTYPE = ^PFMOD_EVENTQUEUE_CALLBACKTYPE;
  PFMOD_EVENTQUEUE_CALLBACK = ^FMOD_EVENTQUEUE_CALLBACK;
  PPFMOD_EVENTQUEUE_CALLBACK = ^PFMOD_EVENTQUEUE_CALLBACK;
  PFMOD_MUSIC_INFO = ^FMOD_MUSIC_INFO;
  PPFMOD_MUSIC_INFO = ^PFMOD_MUSIC_INFO;
  PFMOD_MUSIC_ENTITY = ^FMOD_MUSIC_ENTITY;
  PPFMOD_MUSIC_ENTITY = ^PFMOD_MUSIC_ENTITY;
  PFMOD_MUSIC_ITERATOR = ^FMOD_MUSIC_ITERATOR;
  PPFMOD_MUSIC_ITERATOR = ^PFMOD_MUSIC_ITERATOR;
  PFMOD_MUSIC_SAMPLE_INFO = ^FMOD_MUSIC_SAMPLE_INFO;
  PPFMOD_MUSIC_SAMPLE_INFO = ^PFMOD_MUSIC_SAMPLE_INFO;
  PFMOD_MUSIC_SEGMENT_INFO = ^FMOD_MUSIC_SEGMENT_INFO;
  PPFMOD_MUSIC_SEGMENT_INFO = ^PFMOD_MUSIC_SEGMENT_INFO;
  PFMOD_MUSIC_CALLBACKTYPE = ^FMOD_MUSIC_CALLBACKTYPE;
  PPFMOD_MUSIC_CALLBACKTYPE = ^PFMOD_MUSIC_CALLBACKTYPE;
  PFMOD_MUSIC_CALLBACK = ^FMOD_MUSIC_CALLBACK;
  PPFMOD_MUSIC_CALLBACK = ^PFMOD_MUSIC_CALLBACK;
  FMOD_EVENTSYSTEM = record end;
  FMOD_EVENTPROJECT = record end;
  FMOD_EVENTGROUP = record end;
  FMOD_EVENTCATEGORY = record end;
  FMOD_EVENT = record end;
  FMOD_EVENTPARAMETER = record end;
  FMOD_EVENTREVERB = record end;
  FMOD_EVENTQUEUE = record end;
  FMOD_EVENTQUEUEENTRY = record end;
  FMOD_MUSICPROMPT = record end;
  FMOD_MUSICSYSTEM = record end;
  FMOD_EVENT_INITFLAGS = Cardinal;
  FMOD_EVENT_MODE = Cardinal;
  FMOD_EVENT_STATE = Cardinal;
  FMOD_MUSIC_ID = Cardinal;
  FMOD_MUSIC_CUE_ID = FMOD_MUSIC_ID;
  FMOD_MUSIC_PARAM_ID = FMOD_MUSIC_ID;
  FMOD_EVENT_PROPERTY = (
    FMOD_EVENTPROPERTY_NAME = 0,
    FMOD_EVENTPROPERTY_VOLUME,
    FMOD_EVENTPROPERTY_VOLUMERANDOMIZATION,
    FMOD_EVENTPROPERTY_PITCH,
    FMOD_EVENTPROPERTY_PITCH_OCTAVES,
    FMOD_EVENTPROPERTY_PITCH_SEMITONES,
    FMOD_EVENTPROPERTY_PITCH_TONES,
    FMOD_EVENTPROPERTY_PITCHRANDOMIZATION,
    FMOD_EVENTPROPERTY_PITCHRANDOMIZATION_OCTAVES,
    FMOD_EVENTPROPERTY_PITCHRANDOMIZATION_SEMITONES,
    FMOD_EVENTPROPERTY_PITCHRANDOMIZATION_TONES,
    FMOD_EVENTPROPERTY_PRIORITY,
    FMOD_EVENTPROPERTY_MAX_PLAYBACKS,
    FMOD_EVENTPROPERTY_MAX_PLAYBACKS_BEHAVIOR,
    FMOD_EVENTPROPERTY_MODE,
    FMOD_EVENTPROPERTY_3D_IGNORE_GEOMETRY,
    FMOD_EVENTPROPERTY_3D_ROLLOFF,
    FMOD_EVENTPROPERTY_3D_MINDISTANCE,
    FMOD_EVENTPROPERTY_3D_MAXDISTANCE,
    FMOD_EVENTPROPERTY_3D_POSITION,
    FMOD_EVENTPROPERTY_3D_CONEINSIDEANGLE,
    FMOD_EVENTPROPERTY_3D_CONEOUTSIDEANGLE,
    FMOD_EVENTPROPERTY_3D_CONEOUTSIDEVOLUME,
    FMOD_EVENTPROPERTY_3D_DOPPLERSCALE,
    FMOD_EVENTPROPERTY_3D_SPEAKERSPREAD,
    FMOD_EVENTPROPERTY_3D_PANLEVEL,
    FMOD_EVENTPROPERTY_SPEAKER_L,
    FMOD_EVENTPROPERTY_SPEAKER_C,
    FMOD_EVENTPROPERTY_SPEAKER_R,
    FMOD_EVENTPROPERTY_SPEAKER_LS,
    FMOD_EVENTPROPERTY_SPEAKER_RS,
    FMOD_EVENTPROPERTY_SPEAKER_LR,
    FMOD_EVENTPROPERTY_SPEAKER_RR,
    FMOD_EVENTPROPERTY_SPEAKER_LFE,
    FMOD_EVENTPROPERTY_REVERBWETLEVEL,
    FMOD_EVENTPROPERTY_ONESHOT,
    FMOD_EVENTPROPERTY_FADEIN,
    FMOD_EVENTPROPERTY_FADEOUT,
    FMOD_EVENTPROPERTY_REVERBDRYLEVEL,
    FMOD_EVENTPROPERTY_TIMEOFFSET,
    FMOD_EVENTPROPERTY_SPAWNINTENSITY,
    FMOD_EVENTPROPERTY_SPAWNINTENSITY_RANDOMIZATION,
    FMOD_EVENTPROPERTY_WII_CONTROLLERSPEAKERS,
    FMOD_EVENTPROPERTY_3D_POSRANDOMIZATION_MIN,
    FMOD_EVENTPROPERTY_3D_POSRANDOMIZATION_MAX,
    FMOD_EVENTPROPERTY_EVENTTYPE,
    FMOD_EVENTPROPERTY_STEAL_PRIORITY,
    FMOD_EVENTPROPERTY_EFFECTS_AFFECT_REVERB,
    FMOD_EVENTPROPERTY_WILL_TERMINATE,
    FMOD_EVENTPROPERTY_DSPCLOCKSTART_HI,
    FMOD_EVENTPROPERTY_DSPCLOCKSTART_LO,
    FMOD_EVENTPROPERTY_3D_AUTO_DISTANCE_FILTERING,
    FMOD_EVENTPROPERTY_3D_AUTO_DISTANCE_CENTER_FREQ,
    FMOD_EVENTPROPERTY_USER_BASE
  );
  FMOD_EVENTPROPERTY_TYPE = (
    FMOD_EVENTPROPERTY_TYPE_INT = 0,
    FMOD_EVENTPROPERTY_TYPE_FLOAT,
    FMOD_EVENTPROPERTY_TYPE_STRING
  );
  FMOD_EVENT_PITCHUNITS = (
    FMOD_EVENT_PITCHUNITS_RAW = 0,
    FMOD_EVENT_PITCHUNITS_OCTAVES,
    FMOD_EVENT_PITCHUNITS_SEMITONES,
    FMOD_EVENT_PITCHUNITS_TONES
  );
  FMOD_EVENT_RESOURCE = (
    FMOD_EVENT_RESOURCE_STREAMS_AND_SAMPLES,
    FMOD_EVENT_RESOURCE_STREAMS,
    FMOD_EVENT_RESOURCE_SAMPLES
  );
  FMOD_EVENT_CALLBACKTYPE = (
    FMOD_EVENT_CALLBACKTYPE_SYNCPOINT,
    FMOD_EVENT_CALLBACKTYPE_SOUNDDEF_START,
    FMOD_EVENT_CALLBACKTYPE_SOUNDDEF_END,
    FMOD_EVENT_CALLBACKTYPE_STOLEN,
    FMOD_EVENT_CALLBACKTYPE_EVENTFINISHED,
    FMOD_EVENT_CALLBACKTYPE_NET_MODIFIED,
    FMOD_EVENT_CALLBACKTYPE_SOUNDDEF_CREATE,
    FMOD_EVENT_CALLBACKTYPE_SOUNDDEF_RELEASE,
    FMOD_EVENT_CALLBACKTYPE_SOUNDDEF_INFO,
    FMOD_EVENT_CALLBACKTYPE_EVENTSTARTED,
    FMOD_EVENT_CALLBACKTYPE_SOUNDDEF_SELECTINDEX,
    FMOD_EVENT_CALLBACKTYPE_OCCLUSION,
    FMOD_EVENT_CALLBACKTYPE_MAXSTREAMS
  );
  FMOD_EVENT_WAVEBANKINFO = record
    name: array[0..255] of AnsiChar;
    streamrefcnt: Integer;
    samplerefcnt: Integer;
    numstreams: Integer;
    maxstreams: Integer;
    streamsinuse: Integer;
    streammemory: Cardinal;
    samplememory: Cardinal;
    type_: Integer;
  end;
  FMOD_EVENT_SYSTEMINFO = record
    numevents: Integer;
    numinstances: Integer;
    maxwavebanks: Integer;
    wavebankinfo: PFMOD_EVENT_WAVEBANKINFO;
    numplayingevents: Integer;
    playingevents: PPFMOD_EVENT;
    numloadsqueued: array[0..4] of Integer;
  end;
  FMOD_EVENT_PROJECTINFO = record
    index: Integer;
    name: array[0..255] of AnsiChar;
    numevents: Integer;
    numinstances: Integer;
    maxwavebanks: Integer;
    wavebankinfo: PFMOD_EVENT_WAVEBANKINFO;
    numplayingevents: Integer;
    playingevents: PPFMOD_EVENT;
  end;
  FMOD_EVENT_INFO = record
    memoryused: Integer;
    positionms: Integer;
    lengthms: Integer;
    channelsplaying: Integer;
    instancesactive: Integer;
    maxwavebanks: Integer;
    wavebankinfo: PFMOD_EVENT_WAVEBANKINFO;
    projectid: Cardinal;
    systemid: Cardinal;
    audibility: Single;
    numinstances: Integer;
    instances: PPFMOD_EVENT;
    guid: PFMOD_GUID;
  end;
  FMOD_EVENT_SOUNDDEF_ENTRYTYPE = (
    FMOD_EVENT_SOUNDDEF_ENTRYTYPE_WAVETABLE,
    FMOD_EVENT_SOUNDDEF_ENTRYTYPE_OSCILLATOR,
    FMOD_EVENT_SOUNDDEF_ENTRYTYPE_NULL,
    FMOD_EVENT_SOUNDDEF_ENTRYTYPE_PROGRAMMER
  );
  FMOD_EVENT_SOUNDDEFINFO = record
    name: PAnsiChar;
    numentries: Integer;
    entrynames: PPAnsiChar;
    entrytypes: PFMOD_EVENT_SOUNDDEF_ENTRYTYPE;
  end;
  FMOD_EVENT_LOADINFO = record
    size: Cardinal;
    encryptionkey: PAnsiChar;
    sounddefentrylimit: Single;
    loadfrommemory_length: Cardinal;
    override_category_vals: FMOD_BOOL;
    sizeof_instancepool_simple: Cardinal;
  end;
  FMOD_EVENT_CALLBACK = function(event: PFMOD_EVENT; type_: FMOD_EVENT_CALLBACKTYPE; param1: Pointer; param2: Pointer; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  FMOD_EVENTQUEUE_CALLBACKTYPE = (
    FMOD_EVENTQUEUE_CALLBACKTYPE_PREPARE,
    FMOD_EVENTQUEUE_CALLBACKTYPE_ABOUTTOPLAY,
    FMOD_EVENTQUEUE_CALLBACKTYPE_FINISHED,
    FMOD_EVENTQUEUE_CALLBACKTYPE_EXPIRED
  );
  FMOD_EVENTQUEUE_CALLBACK = function(type_: FMOD_EVENTQUEUE_CALLBACKTYPE; queue: PFMOD_EVENTQUEUE; entry: PFMOD_EVENTQUEUEENTRY; callbackuserdata: Pointer): FMOD_RESULT; FMOD_CC;
  FMOD_MUSIC_INFO = record
    starving: FMOD_BOOL;
    all_samples_loaded: FMOD_BOOL;
  end;
  FMOD_MUSIC_ENTITY = record
    name: PAnsiChar;
    id: FMOD_MUSIC_ID;
  end;
  FMOD_MUSIC_ITERATOR = record
    value: PFMOD_MUSIC_ENTITY;
    filter: PAnsiChar;
  end;
  FMOD_MUSIC_SAMPLE_INFO = record
    segment_id: Cardinal;
    index: Cardinal;
    filename: PAnsiChar;
  end;
  FMOD_MUSIC_SEGMENT_INFO = record
    segment_id: Cardinal;
    theme_id: Cardinal;
  end;
  FMOD_MUSIC_CALLBACKTYPE = (
    FMOD_MUSIC_CALLBACKTYPE_SEGMENT_START,
    FMOD_MUSIC_CALLBACKTYPE_SEGMENT_END,
    FMOD_MUSIC_CALLBACKTYPE_SAMPLE_CREATE,
    FMOD_MUSIC_CALLBACKTYPE_SAMPLE_RELEASE,
    FMOD_MUSIC_CALLBACKTYPE_CHANNEL_CREATED,
    FMOD_MUSIC_CALLBACKTYPE_CHANNEL_DESTROYED,
    FMOD_MUSIC_CALLBACKTYPE_RESET,
    FMOD_MUSIC_CALLBACKTYPE_BEAT
  );
  FMOD_MUSIC_CALLBACK = function(type_: FMOD_MUSIC_CALLBACKTYPE; param1: Pointer; param2: Pointer; userdata: Pointer): FMOD_RESULT; FMOD_CC;

function FMOD_EventSystem_Create(eventsystem: PPFMOD_EVENTSYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Create';
function FMOD_EventSystem_Init(eventsystem: PFMOD_EVENTSYSTEM; maxchannels: Integer; flags: FMOD_INITFLAGS; extradriverdata: Pointer; eventflags: FMOD_EVENT_INITFLAGS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Init';
function FMOD_EventSystem_Release(eventsystem: PFMOD_EVENTSYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Release';
function FMOD_EventSystem_Update(eventsystem: PFMOD_EVENTSYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Update';
function FMOD_EventSystem_SetMediaPath(eventsystem: PFMOD_EVENTSYSTEM; path: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_SetMediaPath';
function FMOD_EventSystem_SetPluginPath(eventsystem: PFMOD_EVENTSYSTEM; path: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_SetPluginPath';
function FMOD_EventSystem_GetVersion(eventsystem: PFMOD_EVENTSYSTEM; version: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetVersion';
function FMOD_EventSystem_GetInfo(eventsystem: PFMOD_EVENTSYSTEM; info: PFMOD_EVENT_SYSTEMINFO): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetInfo';
function FMOD_EventSystem_GetSystemObject(eventsystem: PFMOD_EVENTSYSTEM; system: PPFMOD_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetSystemObject';
function FMOD_EventSystem_GetMusicSystem(eventsystem: PFMOD_EVENTSYSTEM; musicsystem: PPFMOD_MUSICSYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetMusicSystem';
function FMOD_EventSystem_SetLanguage(eventsystem: PFMOD_EVENTSYSTEM; language: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_SetLanguage';
function FMOD_EventSystem_GetLanguage(eventsystem: PFMOD_EVENTSYSTEM; language: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetLanguage';
function FMOD_EventSystem_RegisterDSP(eventsystem: PFMOD_EVENTSYSTEM; description: PFMOD_DSP_DESCRIPTION; handle: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_RegisterDSP';
function FMOD_EventSystem_Load(eventsystem: PFMOD_EVENTSYSTEM; name_or_data: PAnsiChar; loadinfo: PFMOD_EVENT_LOADINFO; project: PPFMOD_EVENTPROJECT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Load';
function FMOD_EventSystem_Unload(eventsystem: PFMOD_EVENTSYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Unload';
function FMOD_EventSystem_GetProject(eventsystem: PFMOD_EVENTSYSTEM; name: PAnsiChar; project: PPFMOD_EVENTPROJECT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetProject';
function FMOD_EventSystem_GetProjectByIndex(eventsystem: PFMOD_EVENTSYSTEM; index: Integer; project: PPFMOD_EVENTPROJECT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetProjectByIndex';
function FMOD_EventSystem_GetNumProjects(eventsystem: PFMOD_EVENTSYSTEM; numprojects: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetNumProjects';
function FMOD_EventSystem_GetCategory(eventsystem: PFMOD_EVENTSYSTEM; name: PAnsiChar; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetCategory';
function FMOD_EventSystem_GetCategoryByIndex(eventsystem: PFMOD_EVENTSYSTEM; index: Integer; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetCategoryByIndex';
function FMOD_EventSystem_GetMusicCategory(eventsystem: PFMOD_EVENTSYSTEM; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetMusicCategory';
function FMOD_EventSystem_GetNumCategories(eventsystem: PFMOD_EVENTSYSTEM; numcategories: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetNumCategories';
function FMOD_EventSystem_GetGroup(eventsystem: PFMOD_EVENTSYSTEM; name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetGroup';
function FMOD_EventSystem_GetEvent(eventsystem: PFMOD_EVENTSYSTEM; name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetEvent';
function FMOD_EventSystem_GetEventBySystemID(eventsystem: PFMOD_EVENTSYSTEM; systemid: Cardinal; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetEventBySystemID';
function FMOD_EventSystem_GetEventByGUID(eventsystem: PFMOD_EVENTSYSTEM; guid: PFMOD_GUID; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetEventByGUID';
function FMOD_EventSystem_GetEventByGUIDString(eventsystem: PFMOD_EVENTSYSTEM; guid: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetEventByGUIDString';
function FMOD_EventSystem_GetNumEvents(eventsystem: PFMOD_EVENTSYSTEM; numevents: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetNumEvents';
function FMOD_EventSystem_SetReverbProperties(eventsystem: PFMOD_EVENTSYSTEM; props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_SetReverbProperties';
function FMOD_EventSystem_GetReverbProperties(eventsystem: PFMOD_EVENTSYSTEM; props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetReverbProperties';
function FMOD_EventSystem_GetReverbPreset(eventsystem: PFMOD_EVENTSYSTEM; name: PAnsiChar; props: PFMOD_REVERB_PROPERTIES; index: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetReverbPreset';
function FMOD_EventSystem_GetReverbPresetByIndex(eventsystem: PFMOD_EVENTSYSTEM; index: Integer; props: PFMOD_REVERB_PROPERTIES; name: PPAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetReverbPresetByIndex';
function FMOD_EventSystem_GetNumReverbPresets(eventsystem: PFMOD_EVENTSYSTEM; numpresets: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetNumReverbPresets';
function FMOD_EventSystem_CreateReverb(eventsystem: PFMOD_EVENTSYSTEM; reverb: PPFMOD_EVENTREVERB): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_CreateReverb';
function FMOD_EventSystem_SetReverbAmbientProperties(eventsystem: PFMOD_EVENTSYSTEM; props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_SetReverbAmbientProperties';
function FMOD_EventSystem_GetReverbAmbientProperties(eventsystem: PFMOD_EVENTSYSTEM; props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetReverbAmbientProperties';
function FMOD_EventSystem_CreateEventQueue(eventsystem: PFMOD_EVENTSYSTEM; queue: PPFMOD_EVENTQUEUE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_CreateEventQueue';
function FMOD_EventSystem_CreateEventQueueEntry(eventsystem: PFMOD_EVENTSYSTEM; event: PFMOD_EVENT; entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_CreateEventQueueEntry';
function FMOD_EventSystem_Set3DNumListeners(eventsystem: PFMOD_EVENTSYSTEM; numlisteners: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Set3DNumListeners';
function FMOD_EventSystem_Get3DNumListeners(eventsystem: PFMOD_EVENTSYSTEM; numlisteners: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Get3DNumListeners';
function FMOD_EventSystem_Set3DListenerAttributes(eventsystem: PFMOD_EVENTSYSTEM; listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Set3DListenerAttributes';
function FMOD_EventSystem_Get3DListenerAttributes(eventsystem: PFMOD_EVENTSYSTEM; listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_Get3DListenerAttributes';
function FMOD_EventSystem_SetUserData(eventsystem: PFMOD_EVENTSYSTEM; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_SetUserData';
function FMOD_EventSystem_GetUserData(eventsystem: PFMOD_EVENTSYSTEM; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetUserData';
function FMOD_EventSystem_PreloadFSB(eventsystem: PFMOD_EVENTSYSTEM; filename: PAnsiChar; streaminstance: Integer; sound: PFMOD_SOUND; unloadprevious: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_PreloadFSB';
function FMOD_EventSystem_UnloadFSB(eventsystem: PFMOD_EVENTSYSTEM; filename: PAnsiChar; streaminstance: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_UnloadFSB';
function FMOD_EventSystem_GetMemoryInfo(eventsystem: PFMOD_EVENTSYSTEM; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventSystem_GetMemoryInfo';
function FMOD_EventProject_Release(eventproject: PFMOD_EVENTPROJECT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_Release';
function FMOD_EventProject_GetInfo(eventproject: PFMOD_EVENTPROJECT; info: PFMOD_EVENT_PROJECTINFO): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetInfo';
function FMOD_EventProject_GetGroup(eventproject: PFMOD_EVENTPROJECT; name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetGroup';
function FMOD_EventProject_GetGroupByIndex(eventproject: PFMOD_EVENTPROJECT; index: Integer; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetGroupByIndex';
function FMOD_EventProject_GetNumGroups(eventproject: PFMOD_EVENTPROJECT; numgroups: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetNumGroups';
function FMOD_EventProject_GetEvent(eventproject: PFMOD_EVENTPROJECT; name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetEvent';
function FMOD_EventProject_GetEventByProjectID(eventproject: PFMOD_EVENTPROJECT; projectid: Cardinal; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetEventByProjectID';
function FMOD_EventProject_GetNumEvents(eventproject: PFMOD_EVENTPROJECT; numevents: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetNumEvents';
function FMOD_EventProject_LoadSampleData(eventproject: PFMOD_EVENTPROJECT; eventid_array: PInteger; sizeof_eventid_array: Integer; groupname_array: PPAnsiChar; sizeof_groupname_array: Integer; eventmode: FMOD_EVENT_MODE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_LoadSampleData';
function FMOD_EventProject_StopAllEvents(eventproject: PFMOD_EVENTPROJECT; immediate: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_StopAllEvents';
function FMOD_EventProject_CancelAllLoads(eventproject: PFMOD_EVENTPROJECT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_CancelAllLoads';
function FMOD_EventProject_SetUserData(eventproject: PFMOD_EVENTPROJECT; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_SetUserData';
function FMOD_EventProject_GetUserData(eventproject: PFMOD_EVENTPROJECT; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetUserData';
function FMOD_EventProject_GetMemoryInfo(eventproject: PFMOD_EVENTPROJECT; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventProject_GetMemoryInfo';
function FMOD_EventGroup_GetInfo(eventgroup: PFMOD_EVENTGROUP; index: PInteger; name: PPAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetInfo';
function FMOD_EventGroup_LoadEventData(eventgroup: PFMOD_EVENTGROUP; resource: FMOD_EVENT_RESOURCE; mode: FMOD_EVENT_MODE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_LoadEventData';
function FMOD_EventGroup_FreeEventData(eventgroup: PFMOD_EVENTGROUP; event: PFMOD_EVENT; waituntilready: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_FreeEventData';
function FMOD_EventGroup_GetGroup(eventgroup: PFMOD_EVENTGROUP; name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetGroup';
function FMOD_EventGroup_GetGroupByIndex(eventgroup: PFMOD_EVENTGROUP; index: Integer; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetGroupByIndex';
function FMOD_EventGroup_GetParentGroup(eventgroup: PFMOD_EVENTGROUP; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetParentGroup';
function FMOD_EventGroup_GetParentProject(eventgroup: PFMOD_EVENTGROUP; project: PPFMOD_EVENTPROJECT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetParentProject';
function FMOD_EventGroup_GetNumGroups(eventgroup: PFMOD_EVENTGROUP; numgroups: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetNumGroups';
function FMOD_EventGroup_GetEvent(eventgroup: PFMOD_EVENTGROUP; name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetEvent';
function FMOD_EventGroup_GetEventByIndex(eventgroup: PFMOD_EVENTGROUP; index: Integer; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetEventByIndex';
function FMOD_EventGroup_GetNumEvents(eventgroup: PFMOD_EVENTGROUP; numevents: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetNumEvents';
function FMOD_EventGroup_GetProperty(eventgroup: PFMOD_EVENTGROUP; propertyname: PAnsiChar; value: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetProperty';
function FMOD_EventGroup_GetPropertyByIndex(eventgroup: PFMOD_EVENTGROUP; propertyindex: Integer; value: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetPropertyByIndex';
function FMOD_EventGroup_GetNumProperties(eventgroup: PFMOD_EVENTGROUP; numproperties: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetNumProperties';
function FMOD_EventGroup_GetState(eventgroup: PFMOD_EVENTGROUP; state: PFMOD_EVENT_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetState';
function FMOD_EventGroup_SetUserData(eventgroup: PFMOD_EVENTGROUP; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_SetUserData';
function FMOD_EventGroup_GetUserData(eventgroup: PFMOD_EVENTGROUP; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetUserData';
function FMOD_EventGroup_GetMemoryInfo(eventgroup: PFMOD_EVENTGROUP; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventGroup_GetMemoryInfo';
function FMOD_EventCategory_GetInfo(eventcategory: PFMOD_EVENTCATEGORY; index: PInteger; name: PPAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetInfo';
function FMOD_EventCategory_GetCategory(eventcategory: PFMOD_EVENTCATEGORY; name: PAnsiChar; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetCategory';
function FMOD_EventCategory_GetCategoryByIndex(eventcategory: PFMOD_EVENTCATEGORY; index: Integer; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetCategoryByIndex';
function FMOD_EventCategory_GetNumCategories(eventcategory: PFMOD_EVENTCATEGORY; numcategories: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetNumCategories';
function FMOD_EventCategory_GetEventByIndex(eventcategory: PFMOD_EVENTCATEGORY; index: Integer; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetEventByIndex';
function FMOD_EventCategory_GetNumEvents(eventcategory: PFMOD_EVENTCATEGORY; numevents: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetNumEvents';
function FMOD_EventCategory_GetParentCategory(eventcategory: PFMOD_EVENTCATEGORY; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetParentCategory';
function FMOD_EventCategory_StopAllEvents(eventcategory: PFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_StopAllEvents';
function FMOD_EventCategory_SetVolume(eventcategory: PFMOD_EVENTCATEGORY; volume: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_SetVolume';
function FMOD_EventCategory_GetVolume(eventcategory: PFMOD_EVENTCATEGORY; volume: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetVolume';
function FMOD_EventCategory_SetPitch(eventcategory: PFMOD_EVENTCATEGORY; pitch: Single; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_SetPitch';
function FMOD_EventCategory_GetPitch(eventcategory: PFMOD_EVENTCATEGORY; pitch: PSingle; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetPitch';
function FMOD_EventCategory_SetPaused(eventcategory: PFMOD_EVENTCATEGORY; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_SetPaused';
function FMOD_EventCategory_GetPaused(eventcategory: PFMOD_EVENTCATEGORY; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetPaused';
function FMOD_EventCategory_SetMute(eventcategory: PFMOD_EVENTCATEGORY; mute: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_SetMute';
function FMOD_EventCategory_GetMute(eventcategory: PFMOD_EVENTCATEGORY; mute: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetMute';
function FMOD_EventCategory_GetChannelGroup(eventcategory: PFMOD_EVENTCATEGORY; channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetChannelGroup';
function FMOD_EventCategory_SetUserData(eventcategory: PFMOD_EVENTCATEGORY; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_SetUserData';
function FMOD_EventCategory_GetUserData(eventcategory: PFMOD_EVENTCATEGORY; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetUserData';
function FMOD_EventCategory_GetMemoryInfo(eventcategory: PFMOD_EVENTCATEGORY; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventCategory_GetMemoryInfo';
function FMOD_Event_Release(event: PFMOD_EVENT; freeeventdata: FMOD_BOOL; waituntilready: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Release';
function FMOD_Event_Start(event: PFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Start';
function FMOD_Event_Stop(event: PFMOD_EVENT; immediate: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Stop';
function FMOD_Event_GetInfo(event: PFMOD_EVENT; index: PInteger; name: PPAnsiChar; info: PFMOD_EVENT_INFO): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetInfo';
function FMOD_Event_GetState(event: PFMOD_EVENT; state: PFMOD_EVENT_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetState';
function FMOD_Event_GetParentGroup(event: PFMOD_EVENT; group: PPFMOD_EVENTGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetParentGroup';
function FMOD_Event_GetChannelGroup(event: PFMOD_EVENT; channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetChannelGroup';
function FMOD_Event_SetCallback(event: PFMOD_EVENT; callback: FMOD_EVENT_CALLBACK; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetCallback';
function FMOD_Event_GetParameter(event: PFMOD_EVENT; name: PAnsiChar; parameter: PPFMOD_EVENTPARAMETER): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetParameter';
function FMOD_Event_GetParameterByIndex(event: PFMOD_EVENT; index: Integer; parameter: PPFMOD_EVENTPARAMETER): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetParameterByIndex';
function FMOD_Event_GetNumParameters(event: PFMOD_EVENT; numparameters: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetNumParameters';
function FMOD_Event_GetProperty(event: PFMOD_EVENT; propertyname: PAnsiChar; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetProperty';
function FMOD_Event_GetPropertyByIndex(event: PFMOD_EVENT; propertyindex: Integer; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetPropertyByIndex';
function FMOD_Event_SetProperty(event: PFMOD_EVENT; propertyname: PAnsiChar; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetProperty';
function FMOD_Event_SetPropertyByIndex(event: PFMOD_EVENT; propertyindex: Integer; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetPropertyByIndex';
function FMOD_Event_GetNumProperties(event: PFMOD_EVENT; numproperties: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetNumProperties';
function FMOD_Event_GetPropertyInfo(event: PFMOD_EVENT; propertyindex: PInteger; propertyname: PPAnsiChar; type_: PFMOD_EVENTPROPERTY_TYPE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetPropertyInfo';
function FMOD_Event_GetCategory(event: PFMOD_EVENT; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetCategory';
function FMOD_Event_SetVolume(event: PFMOD_EVENT; volume: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetVolume';
function FMOD_Event_GetVolume(event: PFMOD_EVENT; volume: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetVolume';
function FMOD_Event_SetPitch(event: PFMOD_EVENT; pitch: Single; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetPitch';
function FMOD_Event_GetPitch(event: PFMOD_EVENT; pitch: PSingle; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetPitch';
function FMOD_Event_SetPaused(event: PFMOD_EVENT; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetPaused';
function FMOD_Event_GetPaused(event: PFMOD_EVENT; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetPaused';
function FMOD_Event_SetMute(event: PFMOD_EVENT; mute: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetMute';
function FMOD_Event_GetMute(event: PFMOD_EVENT; mute: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetMute';
function FMOD_Event_Set3DAttributes(event: PFMOD_EVENT; position: PFMOD_VECTOR; velocity: PFMOD_VECTOR; orientation: PFMOD_VECTOR): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Set3DAttributes';
function FMOD_Event_Get3DAttributes(event: PFMOD_EVENT; position: PFMOD_VECTOR; velocity: PFMOD_VECTOR; orientation: PFMOD_VECTOR): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Get3DAttributes';
function FMOD_Event_Set3DOcclusion(event: PFMOD_EVENT; directocclusion: Single; reverbocclusion: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Set3DOcclusion';
function FMOD_Event_Get3DOcclusion(event: PFMOD_EVENT; directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_Get3DOcclusion';
function FMOD_Event_SetReverbProperties(event: PFMOD_EVENT; props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetReverbProperties';
function FMOD_Event_GetReverbProperties(event: PFMOD_EVENT; props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetReverbProperties';
function FMOD_Event_SetUserData(event: PFMOD_EVENT; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_SetUserData';
function FMOD_Event_GetUserData(event: PFMOD_EVENT; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetUserData';
function FMOD_Event_GetMemoryInfo(event: PFMOD_EVENT; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Event_GetMemoryInfo';
function FMOD_EventParameter_GetInfo(eventparameter: PFMOD_EVENTPARAMETER; index: PInteger; name: PPAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetInfo';
function FMOD_EventParameter_GetRange(eventparameter: PFMOD_EVENTPARAMETER; rangemin: PSingle; rangemax: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetRange';
function FMOD_EventParameter_SetValue(eventparameter: PFMOD_EVENTPARAMETER; value: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_SetValue';
function FMOD_EventParameter_GetValue(eventparameter: PFMOD_EVENTPARAMETER; value: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetValue';
function FMOD_EventParameter_SetVelocity(eventparameter: PFMOD_EVENTPARAMETER; value: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_SetVelocity';
function FMOD_EventParameter_GetVelocity(eventparameter: PFMOD_EVENTPARAMETER; value: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetVelocity';
function FMOD_EventParameter_SetSeekSpeed(eventparameter: PFMOD_EVENTPARAMETER; value: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_SetSeekSpeed';
function FMOD_EventParameter_GetSeekSpeed(eventparameter: PFMOD_EVENTPARAMETER; value: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetSeekSpeed';
function FMOD_EventParameter_SetUserData(eventparameter: PFMOD_EVENTPARAMETER; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_SetUserData';
function FMOD_EventParameter_GetUserData(eventparameter: PFMOD_EVENTPARAMETER; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetUserData';
function FMOD_EventParameter_KeyOff(eventparameter: PFMOD_EVENTPARAMETER): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_KeyOff';
function FMOD_EventParameter_DisableAutomation(eventparameter: PFMOD_EVENTPARAMETER; disable: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_DisableAutomation';
function FMOD_EventParameter_GetMemoryInfo(eventparameter: PFMOD_EVENTPARAMETER; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventParameter_GetMemoryInfo';
function FMOD_EventReverb_Release(eventreverb: PFMOD_EVENTREVERB): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_Release';
function FMOD_EventReverb_Set3DAttributes(eventreverb: PFMOD_EVENTREVERB; position: PFMOD_VECTOR; mindistance: Single; maxdistance: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_Set3DAttributes';
function FMOD_EventReverb_Get3DAttributes(eventreverb: PFMOD_EVENTREVERB; position: PFMOD_VECTOR; mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_Get3DAttributes';
function FMOD_EventReverb_SetProperties(eventreverb: PFMOD_EVENTREVERB; props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_SetProperties';
function FMOD_EventReverb_GetProperties(eventreverb: PFMOD_EVENTREVERB; props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_GetProperties';
function FMOD_EventReverb_SetActive(eventreverb: PFMOD_EVENTREVERB; active: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_SetActive';
function FMOD_EventReverb_GetActive(eventreverb: PFMOD_EVENTREVERB; active: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_GetActive';
function FMOD_EventReverb_SetUserData(eventreverb: PFMOD_EVENTREVERB; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_SetUserData';
function FMOD_EventReverb_GetUserData(eventreverb: PFMOD_EVENTREVERB; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_GetUserData';
function FMOD_EventReverb_GetMemoryInfo(eventreverb: PFMOD_EVENTREVERB; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventReverb_GetMemoryInfo';
function FMOD_EventQueue_Release(eventqueue: PFMOD_EVENTQUEUE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_Release';
function FMOD_EventQueue_Add(eventqueue: PFMOD_EVENTQUEUE; entry: PFMOD_EVENTQUEUEENTRY; allow_duplicates: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_Add';
function FMOD_EventQueue_Remove(eventqueue: PFMOD_EVENTQUEUE; entry: PFMOD_EVENTQUEUEENTRY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_Remove';
function FMOD_EventQueue_RemoveHead(eventqueue: PFMOD_EVENTQUEUE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_RemoveHead';
function FMOD_EventQueue_Clear(eventqueue: PFMOD_EVENTQUEUE; stopallevents: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_Clear';
function FMOD_EventQueue_FindFirstEntry(eventqueue: PFMOD_EVENTQUEUE; entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_FindFirstEntry';
function FMOD_EventQueue_FindNextEntry(eventqueue: PFMOD_EVENTQUEUE; entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_FindNextEntry';
function FMOD_EventQueue_SetPaused(eventqueue: PFMOD_EVENTQUEUE; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_SetPaused';
function FMOD_EventQueue_GetPaused(eventqueue: PFMOD_EVENTQUEUE; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_GetPaused';
function FMOD_EventQueue_IncludeDuckingCategory(eventqueue: PFMOD_EVENTQUEUE; category: PFMOD_EVENTCATEGORY; ducked_volume: Single; unducked_volume: Single; duck_time: Cardinal; unduck_time: Cardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_IncludeDuckingCategory';
function FMOD_EventQueue_ExcludeDuckingCategory(eventqueue: PFMOD_EVENTQUEUE; category: PFMOD_EVENTCATEGORY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_ExcludeDuckingCategory';
function FMOD_EventQueue_SetCallback(eventqueue: PFMOD_EVENTQUEUE; callback: FMOD_EVENTQUEUE_CALLBACK; callbackuserdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_SetCallback';
function FMOD_EventQueue_SetUserData(eventqueue: PFMOD_EVENTQUEUE; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_SetUserData';
function FMOD_EventQueue_GetUserData(eventqueue: PFMOD_EVENTQUEUE; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_GetUserData';
function FMOD_EventQueue_Dump(eventqueue: PFMOD_EVENTQUEUE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_Dump';
function FMOD_EventQueue_GetMemoryInfo(eventqueue: PFMOD_EVENTQUEUE; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueue_GetMemoryInfo';
function FMOD_EventQueueEntry_Release(eventqueueentry: PFMOD_EVENTQUEUEENTRY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_Release';
function FMOD_EventQueueEntry_GetInfoOnlyEvent(eventqueueentry: PFMOD_EVENTQUEUEENTRY; infoonlyevent: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetInfoOnlyEvent';
function FMOD_EventQueueEntry_GetRealEvent(eventqueueentry: PFMOD_EVENTQUEUEENTRY; realevent: PPFMOD_EVENT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetRealEvent';
function FMOD_EventQueueEntry_SetPriority(eventqueueentry: PFMOD_EVENTQUEUEENTRY; priority: Byte): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_SetPriority';
function FMOD_EventQueueEntry_GetPriority(eventqueueentry: PFMOD_EVENTQUEUEENTRY; priority: PByte): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetPriority';
function FMOD_EventQueueEntry_SetExpiryTime(eventqueueentry: PFMOD_EVENTQUEUEENTRY; expirytime: Cardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_SetExpiryTime';
function FMOD_EventQueueEntry_GetExpiryTime(eventqueueentry: PFMOD_EVENTQUEUEENTRY; expirytime: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetExpiryTime';
function FMOD_EventQueueEntry_SetDelayTime(eventqueueentry: PFMOD_EVENTQUEUEENTRY; delay: Cardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_SetDelayTime';
function FMOD_EventQueueEntry_GetDelayTime(eventqueueentry: PFMOD_EVENTQUEUEENTRY; delay: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetDelayTime';
function FMOD_EventQueueEntry_SetInterrupt(eventqueueentry: PFMOD_EVENTQUEUEENTRY; interrupt: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_SetInterrupt';
function FMOD_EventQueueEntry_GetInterrupt(eventqueueentry: PFMOD_EVENTQUEUEENTRY; interrupt: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetInterrupt';
function FMOD_EventQueueEntry_SetCrossfadeTime(eventqueueentry: PFMOD_EVENTQUEUEENTRY; crossfade: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_SetCrossfadeTime';
function FMOD_EventQueueEntry_GetCrossfadeTime(eventqueueentry: PFMOD_EVENTQUEUEENTRY; crossfade: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetCrossfadeTime';
function FMOD_EventQueueEntry_SetUserData(eventqueueentry: PFMOD_EVENTQUEUEENTRY; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_SetUserData';
function FMOD_EventQueueEntry_GetUserData(eventqueueentry: PFMOD_EVENTQUEUEENTRY; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetUserData';
function FMOD_EventQueueEntry_GetMemoryInfo(eventqueueentry: PFMOD_EVENTQUEUEENTRY; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_EventQueueEntry_GetMemoryInfo';
function FMOD_MusicSystem_Reset(musicsystem: PFMOD_MUSICSYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_Reset';
function FMOD_MusicSystem_SetVolume(musicsystem: PFMOD_MUSICSYSTEM; volume: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_SetVolume';
function FMOD_MusicSystem_GetVolume(musicsystem: PFMOD_MUSICSYSTEM; volume: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetVolume';
function FMOD_MusicSystem_SetReverbProperties(musicsystem: PFMOD_MUSICSYSTEM; props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_SetReverbProperties';
function FMOD_MusicSystem_GetReverbProperties(musicsystem: PFMOD_MUSICSYSTEM; props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetReverbProperties';
function FMOD_MusicSystem_SetPaused(musicsystem: PFMOD_MUSICSYSTEM; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_SetPaused';
function FMOD_MusicSystem_GetPaused(musicsystem: PFMOD_MUSICSYSTEM; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetPaused';
function FMOD_MusicSystem_SetMute(musicsystem: PFMOD_MUSICSYSTEM; mute: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_SetMute';
function FMOD_MusicSystem_GetMute(musicsystem: PFMOD_MUSICSYSTEM; mute: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetMute';
function FMOD_MusicSystem_GetInfo(musicsystem: PFMOD_MUSICSYSTEM; info: PFMOD_MUSIC_INFO): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetInfo';
function FMOD_MusicSystem_PromptCue(musicsystem: PFMOD_MUSICSYSTEM; id: FMOD_MUSIC_CUE_ID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_PromptCue';
function FMOD_MusicSystem_PrepareCue(musicsystem: PFMOD_MUSICSYSTEM; id: FMOD_MUSIC_CUE_ID; prompt: PPFMOD_MUSICPROMPT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_PrepareCue';
function FMOD_MusicSystem_GetParameterValue(musicsystem: PFMOD_MUSICSYSTEM; id: FMOD_MUSIC_PARAM_ID; parameter: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetParameterValue';
function FMOD_MusicSystem_SetParameterValue(musicsystem: PFMOD_MUSICSYSTEM; id: FMOD_MUSIC_PARAM_ID; parameter: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_SetParameterValue';
function FMOD_MusicSystem_GetCues(musicsystem: PFMOD_MUSICSYSTEM; it: PFMOD_MUSIC_ITERATOR; filter: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetCues';
function FMOD_MusicSystem_GetNextCue(musicsystem: PFMOD_MUSICSYSTEM; it: PFMOD_MUSIC_ITERATOR): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetNextCue';
function FMOD_MusicSystem_GetParameters(musicsystem: PFMOD_MUSICSYSTEM; it: PFMOD_MUSIC_ITERATOR; filter: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetParameters';
function FMOD_MusicSystem_GetNextParameter(musicsystem: PFMOD_MUSICSYSTEM; it: PFMOD_MUSIC_ITERATOR): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetNextParameter';
function FMOD_MusicSystem_LoadSoundData(musicsystem: PFMOD_MUSICSYSTEM; resource: FMOD_EVENT_RESOURCE; mode: FMOD_EVENT_MODE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_LoadSoundData';
function FMOD_MusicSystem_FreeSoundData(musicsystem: PFMOD_MUSICSYSTEM; waituntilready: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_FreeSoundData';
function FMOD_MusicSystem_SetCallback(musicsystem: PFMOD_MUSICSYSTEM; callback: FMOD_MUSIC_CALLBACK; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_SetCallback';
function FMOD_MusicSystem_GetMemoryInfo(musicsystem: PFMOD_MUSICSYSTEM; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicSystem_GetMemoryInfo';
function FMOD_MusicPrompt_Release(musicprompt: PFMOD_MUSICPROMPT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicPrompt_Release';
function FMOD_MusicPrompt_Begin(musicprompt: PFMOD_MUSICPROMPT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicPrompt_Begin';
function FMOD_MusicPrompt_End(musicprompt: PFMOD_MUSICPROMPT): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicPrompt_End';
function FMOD_MusicPrompt_IsActive(musicprompt: PFMOD_MUSICPROMPT; active: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicPrompt_IsActive';
function FMOD_MusicPrompt_GetMemoryInfo(musicprompt: PFMOD_MUSICPROMPT; memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_MusicPrompt_GetMemoryInfo';


implementation

end.
