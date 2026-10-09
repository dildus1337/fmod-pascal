(*
  FreePascal binding for FMOD Studio
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
unit fmodstudio;

interface

uses
  fmod;

const
{$IF defined(MSWINDOWS)}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fmodstudioL.dll';
    {$ELSE}
  FMOD_LIB = 'fmodstudioL.dll';
    {$ENDIF}
  {$ELSE}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fmodstudio.dll';
    {$ELSE}
  FMOD_LIB = 'fmodstudio.dll';
    {$ENDIF}
  {$ENDIF}
{$ELSEIF defined(DARWIN)}
  {$IF defined(FMOD_LOGGING)}
  FMOD_LIB = 'libfmodstudioL.dylib';
  {$ELSE}
  FMOD_LIB = 'libfmodstudio.dylib';
  {$ENDIF}
{$ELSE}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfmodstudioL.so';
    {$ELSE}
  FMOD_LIB = 'libfmodstudioL.so';
    {$ENDIF}
  {$ELSE}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfmodstudio.so';
    {$ELSE}
  FMOD_LIB = 'libfmodstudio.so';
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IF defined(MSWINDOWS)}
  {$DEFINE FMOD_CC := stdcall}
{$ELSE}
  {$DEFINE FMOD_CC := cdecl}
{$ENDIF}

const
  FMOD_STUDIO_LOAD_MEMORY_ALIGNMENT = 32;
  FMOD_STUDIO_INIT_NORMAL = $00000000;
  FMOD_STUDIO_INIT_LIVEUPDATE = $00000001;
  FMOD_STUDIO_INIT_ALLOW_MISSING_PLUGINS = $00000002;
  FMOD_STUDIO_INIT_SYNCHRONOUS_UPDATE = $00000004;
  FMOD_STUDIO_INIT_DEFERRED_CALLBACKS = $00000008;
  FMOD_STUDIO_INIT_LOAD_FROM_UPDATE = $00000010;
  FMOD_STUDIO_INIT_MEMORY_TRACKING = $00000020;
  FMOD_STUDIO_PARAMETER_READONLY = $00000001;
  FMOD_STUDIO_PARAMETER_AUTOMATIC = $00000002;
  FMOD_STUDIO_PARAMETER_GLOBAL = $00000004;
  FMOD_STUDIO_SYSTEM_CALLBACK_PREUPDATE = $00000001;
  FMOD_STUDIO_SYSTEM_CALLBACK_POSTUPDATE = $00000002;
  FMOD_STUDIO_SYSTEM_CALLBACK_BANK_UNLOAD = $00000004;
  FMOD_STUDIO_SYSTEM_CALLBACK_ALL = $FFFFFFFF;
  FMOD_STUDIO_EVENT_CALLBACK_CREATED = $00000001;
  FMOD_STUDIO_EVENT_CALLBACK_DESTROYED = $00000002;
  FMOD_STUDIO_EVENT_CALLBACK_STARTING = $00000004;
  FMOD_STUDIO_EVENT_CALLBACK_STARTED = $00000008;
  FMOD_STUDIO_EVENT_CALLBACK_RESTARTED = $00000010;
  FMOD_STUDIO_EVENT_CALLBACK_STOPPED = $00000020;
  FMOD_STUDIO_EVENT_CALLBACK_START_FAILED = $00000040;
  FMOD_STUDIO_EVENT_CALLBACK_CREATE_PROGRAMMER_SOUND = $00000080;
  FMOD_STUDIO_EVENT_CALLBACK_DESTROY_PROGRAMMER_SOUND = $00000100;
  FMOD_STUDIO_EVENT_CALLBACK_PLUGIN_CREATED = $00000200;
  FMOD_STUDIO_EVENT_CALLBACK_PLUGIN_DESTROYED = $00000400;
  FMOD_STUDIO_EVENT_CALLBACK_TIMELINE_MARKER = $00000800;
  FMOD_STUDIO_EVENT_CALLBACK_TIMELINE_BEAT = $00001000;
  FMOD_STUDIO_EVENT_CALLBACK_SOUND_PLAYED = $00002000;
  FMOD_STUDIO_EVENT_CALLBACK_SOUND_STOPPED = $00004000;
  FMOD_STUDIO_EVENT_CALLBACK_REAL_TO_VIRTUAL = $00008000;
  FMOD_STUDIO_EVENT_CALLBACK_VIRTUAL_TO_REAL = $00010000;
  FMOD_STUDIO_EVENT_CALLBACK_ALL = $FFFFFFFF;
  FMOD_STUDIO_LOAD_BANK_NORMAL = $00000000;
  FMOD_STUDIO_LOAD_BANK_NONBLOCKING = $00000001;
  FMOD_STUDIO_LOAD_BANK_DECOMPRESS_SAMPLES = $00000002;
  FMOD_STUDIO_LOAD_BANK_UNENCRYPTED = $00000004;
  FMOD_STUDIO_COMMANDCAPTURE_NORMAL = $00000000;
  FMOD_STUDIO_COMMANDCAPTURE_FILEFLUSH = $00000001;
  FMOD_STUDIO_COMMANDCAPTURE_SKIP_INITIAL_STATE = $00000002;
  FMOD_STUDIO_COMMANDREPLAY_NORMAL = $00000000;
  FMOD_STUDIO_COMMANDREPLAY_SKIP_CLEANUP = $00000001;
  FMOD_STUDIO_COMMANDREPLAY_FAST_FORWARD = $00000002;
  FMOD_STUDIO_COMMANDREPLAY_SKIP_BANK_LOAD = $00000004;

type
  PFMOD_STUDIO_SYSTEM = ^FMOD_STUDIO_SYSTEM;
  PPFMOD_STUDIO_SYSTEM = ^PFMOD_STUDIO_SYSTEM;
  PFMOD_STUDIO_EVENTDESCRIPTION = ^FMOD_STUDIO_EVENTDESCRIPTION;
  PPFMOD_STUDIO_EVENTDESCRIPTION = ^PFMOD_STUDIO_EVENTDESCRIPTION;
  PFMOD_STUDIO_EVENTINSTANCE = ^FMOD_STUDIO_EVENTINSTANCE;
  PPFMOD_STUDIO_EVENTINSTANCE = ^PFMOD_STUDIO_EVENTINSTANCE;
  PFMOD_STUDIO_BUS = ^FMOD_STUDIO_BUS;
  PPFMOD_STUDIO_BUS = ^PFMOD_STUDIO_BUS;
  PFMOD_STUDIO_VCA = ^FMOD_STUDIO_VCA;
  PPFMOD_STUDIO_VCA = ^PFMOD_STUDIO_VCA;
  PFMOD_STUDIO_BANK = ^FMOD_STUDIO_BANK;
  PPFMOD_STUDIO_BANK = ^PFMOD_STUDIO_BANK;
  PFMOD_STUDIO_COMMANDREPLAY = ^FMOD_STUDIO_COMMANDREPLAY;
  PPFMOD_STUDIO_COMMANDREPLAY = ^PFMOD_STUDIO_COMMANDREPLAY;
  PFMOD_STUDIO_INITFLAGS = ^FMOD_STUDIO_INITFLAGS;
  PPFMOD_STUDIO_INITFLAGS = ^PFMOD_STUDIO_INITFLAGS;
  PFMOD_STUDIO_PARAMETER_FLAGS = ^FMOD_STUDIO_PARAMETER_FLAGS;
  PPFMOD_STUDIO_PARAMETER_FLAGS = ^PFMOD_STUDIO_PARAMETER_FLAGS;
  PFMOD_STUDIO_SYSTEM_CALLBACK_TYPE = ^FMOD_STUDIO_SYSTEM_CALLBACK_TYPE;
  PPFMOD_STUDIO_SYSTEM_CALLBACK_TYPE = ^PFMOD_STUDIO_SYSTEM_CALLBACK_TYPE;
  PFMOD_STUDIO_EVENT_CALLBACK_TYPE = ^FMOD_STUDIO_EVENT_CALLBACK_TYPE;
  PPFMOD_STUDIO_EVENT_CALLBACK_TYPE = ^PFMOD_STUDIO_EVENT_CALLBACK_TYPE;
  PFMOD_STUDIO_LOAD_BANK_FLAGS = ^FMOD_STUDIO_LOAD_BANK_FLAGS;
  PPFMOD_STUDIO_LOAD_BANK_FLAGS = ^PFMOD_STUDIO_LOAD_BANK_FLAGS;
  PFMOD_STUDIO_COMMANDCAPTURE_FLAGS = ^FMOD_STUDIO_COMMANDCAPTURE_FLAGS;
  PPFMOD_STUDIO_COMMANDCAPTURE_FLAGS = ^PFMOD_STUDIO_COMMANDCAPTURE_FLAGS;
  PFMOD_STUDIO_COMMANDREPLAY_FLAGS = ^FMOD_STUDIO_COMMANDREPLAY_FLAGS;
  PPFMOD_STUDIO_COMMANDREPLAY_FLAGS = ^PFMOD_STUDIO_COMMANDREPLAY_FLAGS;
  PFMOD_STUDIO_LOADING_STATE = ^FMOD_STUDIO_LOADING_STATE;
  PPFMOD_STUDIO_LOADING_STATE = ^PFMOD_STUDIO_LOADING_STATE;
  PFMOD_STUDIO_LOAD_MEMORY_MODE = ^FMOD_STUDIO_LOAD_MEMORY_MODE;
  PPFMOD_STUDIO_LOAD_MEMORY_MODE = ^PFMOD_STUDIO_LOAD_MEMORY_MODE;
  PFMOD_STUDIO_PARAMETER_TYPE = ^FMOD_STUDIO_PARAMETER_TYPE;
  PPFMOD_STUDIO_PARAMETER_TYPE = ^PFMOD_STUDIO_PARAMETER_TYPE;
  PFMOD_STUDIO_USER_PROPERTY_TYPE = ^FMOD_STUDIO_USER_PROPERTY_TYPE;
  PPFMOD_STUDIO_USER_PROPERTY_TYPE = ^PFMOD_STUDIO_USER_PROPERTY_TYPE;
  PFMOD_STUDIO_EVENT_PROPERTY = ^FMOD_STUDIO_EVENT_PROPERTY;
  PPFMOD_STUDIO_EVENT_PROPERTY = ^PFMOD_STUDIO_EVENT_PROPERTY;
  PFMOD_STUDIO_PLAYBACK_STATE = ^FMOD_STUDIO_PLAYBACK_STATE;
  PPFMOD_STUDIO_PLAYBACK_STATE = ^PFMOD_STUDIO_PLAYBACK_STATE;
  PFMOD_STUDIO_STOP_MODE = ^FMOD_STUDIO_STOP_MODE;
  PPFMOD_STUDIO_STOP_MODE = ^PFMOD_STUDIO_STOP_MODE;
  PFMOD_STUDIO_INSTANCETYPE = ^FMOD_STUDIO_INSTANCETYPE;
  PPFMOD_STUDIO_INSTANCETYPE = ^PFMOD_STUDIO_INSTANCETYPE;
  PFMOD_STUDIO_BANK_INFO = ^FMOD_STUDIO_BANK_INFO;
  PPFMOD_STUDIO_BANK_INFO = ^PFMOD_STUDIO_BANK_INFO;
  PFMOD_STUDIO_PARAMETER_ID = ^FMOD_STUDIO_PARAMETER_ID;
  PPFMOD_STUDIO_PARAMETER_ID = ^PFMOD_STUDIO_PARAMETER_ID;
  PFMOD_STUDIO_PARAMETER_DESCRIPTION = ^FMOD_STUDIO_PARAMETER_DESCRIPTION;
  PPFMOD_STUDIO_PARAMETER_DESCRIPTION = ^PFMOD_STUDIO_PARAMETER_DESCRIPTION;
  PFMOD_STUDIO_USER_PROPERTY = ^FMOD_STUDIO_USER_PROPERTY;
  PPFMOD_STUDIO_USER_PROPERTY = ^PFMOD_STUDIO_USER_PROPERTY;
  PFMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES = ^FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES;
  PPFMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES = ^PFMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES;
  PFMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES = ^FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES;
  PPFMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES = ^PFMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES;
  PFMOD_STUDIO_TIMELINE_MARKER_PROPERTIES = ^FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES;
  PPFMOD_STUDIO_TIMELINE_MARKER_PROPERTIES = ^PFMOD_STUDIO_TIMELINE_MARKER_PROPERTIES;
  PFMOD_STUDIO_TIMELINE_BEAT_PROPERTIES = ^FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES;
  PPFMOD_STUDIO_TIMELINE_BEAT_PROPERTIES = ^PFMOD_STUDIO_TIMELINE_BEAT_PROPERTIES;
  PFMOD_STUDIO_ADVANCEDSETTINGS = ^FMOD_STUDIO_ADVANCEDSETTINGS;
  PPFMOD_STUDIO_ADVANCEDSETTINGS = ^PFMOD_STUDIO_ADVANCEDSETTINGS;
  PFMOD_STUDIO_CPU_USAGE = ^FMOD_STUDIO_CPU_USAGE;
  PPFMOD_STUDIO_CPU_USAGE = ^PFMOD_STUDIO_CPU_USAGE;
  PFMOD_STUDIO_BUFFER_INFO = ^FMOD_STUDIO_BUFFER_INFO;
  PPFMOD_STUDIO_BUFFER_INFO = ^PFMOD_STUDIO_BUFFER_INFO;
  PFMOD_STUDIO_BUFFER_USAGE = ^FMOD_STUDIO_BUFFER_USAGE;
  PPFMOD_STUDIO_BUFFER_USAGE = ^PFMOD_STUDIO_BUFFER_USAGE;
  PFMOD_STUDIO_SOUND_INFO = ^FMOD_STUDIO_SOUND_INFO;
  PPFMOD_STUDIO_SOUND_INFO = ^PFMOD_STUDIO_SOUND_INFO;
  PFMOD_STUDIO_COMMAND_INFO = ^FMOD_STUDIO_COMMAND_INFO;
  PPFMOD_STUDIO_COMMAND_INFO = ^PFMOD_STUDIO_COMMAND_INFO;
  PFMOD_STUDIO_MEMORY_USAGE = ^FMOD_STUDIO_MEMORY_USAGE;
  PPFMOD_STUDIO_MEMORY_USAGE = ^PFMOD_STUDIO_MEMORY_USAGE;
  PFMOD_STUDIO_SYSTEM_CALLBACK = ^FMOD_STUDIO_SYSTEM_CALLBACK;
  PPFMOD_STUDIO_SYSTEM_CALLBACK = ^PFMOD_STUDIO_SYSTEM_CALLBACK;
  PFMOD_STUDIO_EVENT_CALLBACK = ^FMOD_STUDIO_EVENT_CALLBACK;
  PPFMOD_STUDIO_EVENT_CALLBACK = ^PFMOD_STUDIO_EVENT_CALLBACK;
  PFMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK = ^FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK;
  PPFMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK = ^PFMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK;
  PFMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK = ^FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK;
  PPFMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK = ^PFMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK;
  PFMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK = ^FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK;
  PPFMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK = ^PFMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK;
  FMOD_STUDIO_SYSTEM = record end;
  FMOD_STUDIO_EVENTDESCRIPTION = record end;
  FMOD_STUDIO_EVENTINSTANCE = record end;
  FMOD_STUDIO_BUS = record end;
  FMOD_STUDIO_VCA = record end;
  FMOD_STUDIO_BANK = record end;
  FMOD_STUDIO_COMMANDREPLAY = record end;
  FMOD_STUDIO_INITFLAGS = Cardinal;
  FMOD_STUDIO_PARAMETER_FLAGS = Cardinal;
  FMOD_STUDIO_SYSTEM_CALLBACK_TYPE = Cardinal;
  FMOD_STUDIO_EVENT_CALLBACK_TYPE = Cardinal;
  FMOD_STUDIO_LOAD_BANK_FLAGS = Cardinal;
  FMOD_STUDIO_COMMANDCAPTURE_FLAGS = Cardinal;
  FMOD_STUDIO_COMMANDREPLAY_FLAGS = Cardinal;
  FMOD_STUDIO_LOADING_STATE = (
    FMOD_STUDIO_LOADING_STATE_UNLOADING,
    FMOD_STUDIO_LOADING_STATE_UNLOADED,
    FMOD_STUDIO_LOADING_STATE_LOADING,
    FMOD_STUDIO_LOADING_STATE_LOADED,
    FMOD_STUDIO_LOADING_STATE_ERROR,
    FMOD_STUDIO_LOADING_STATE_FORCEINT = 65536
  );
  FMOD_STUDIO_LOAD_MEMORY_MODE = (
    FMOD_STUDIO_LOAD_MEMORY,
    FMOD_STUDIO_LOAD_MEMORY_POINT,
    FMOD_STUDIO_LOAD_MEMORY_FORCEINT = 65536
  );
  FMOD_STUDIO_PARAMETER_TYPE = (
    FMOD_STUDIO_PARAMETER_GAME_CONTROLLED,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_DISTANCE,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_EVENT_CONE_ANGLE,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_EVENT_ORIENTATION,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_DIRECTION,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_ELEVATION,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_LISTENER_ORIENTATION,
    FMOD_STUDIO_PARAMETER_AUTOMATIC_SPEED,
    FMOD_STUDIO_PARAMETER_MAX,
    FMOD_STUDIO_PARAMETER_FORCEINT = 65536
  );
  FMOD_STUDIO_USER_PROPERTY_TYPE = (
    FMOD_STUDIO_USER_PROPERTY_TYPE_INTEGER,
    FMOD_STUDIO_USER_PROPERTY_TYPE_BOOLEAN,
    FMOD_STUDIO_USER_PROPERTY_TYPE_FLOAT,
    FMOD_STUDIO_USER_PROPERTY_TYPE_STRING,
    FMOD_STUDIO_USER_PROPERTY_TYPE_FORCEINT = 65536
  );
  FMOD_STUDIO_EVENT_PROPERTY = (
    FMOD_STUDIO_EVENT_PROPERTY_CHANNELPRIORITY,
    FMOD_STUDIO_EVENT_PROPERTY_SCHEDULE_DELAY,
    FMOD_STUDIO_EVENT_PROPERTY_SCHEDULE_LOOKAHEAD,
    FMOD_STUDIO_EVENT_PROPERTY_MINIMUM_DISTANCE,
    FMOD_STUDIO_EVENT_PROPERTY_MAXIMUM_DISTANCE,
    FMOD_STUDIO_EVENT_PROPERTY_COOLDOWN,
    FMOD_STUDIO_EVENT_PROPERTY_MAX,
    FMOD_STUDIO_EVENT_PROPERTY_FORCEINT = 65536
  );
  FMOD_STUDIO_PLAYBACK_STATE = (
    FMOD_STUDIO_PLAYBACK_PLAYING,
    FMOD_STUDIO_PLAYBACK_SUSTAINING,
    FMOD_STUDIO_PLAYBACK_STOPPED,
    FMOD_STUDIO_PLAYBACK_STARTING,
    FMOD_STUDIO_PLAYBACK_STOPPING,
    FMOD_STUDIO_PLAYBACK_FORCEINT = 65536
  );
  FMOD_STUDIO_STOP_MODE = (
    FMOD_STUDIO_STOP_ALLOWFADEOUT,
    FMOD_STUDIO_STOP_IMMEDIATE,
    FMOD_STUDIO_STOP_FORCEINT = 65536
  );
  FMOD_STUDIO_INSTANCETYPE = (
    FMOD_STUDIO_INSTANCETYPE_NONE,
    FMOD_STUDIO_INSTANCETYPE_SYSTEM,
    FMOD_STUDIO_INSTANCETYPE_EVENTDESCRIPTION,
    FMOD_STUDIO_INSTANCETYPE_EVENTINSTANCE,
    FMOD_STUDIO_INSTANCETYPE_PARAMETERINSTANCE,
    FMOD_STUDIO_INSTANCETYPE_BUS,
    FMOD_STUDIO_INSTANCETYPE_VCA,
    FMOD_STUDIO_INSTANCETYPE_BANK,
    FMOD_STUDIO_INSTANCETYPE_COMMANDREPLAY,
    FMOD_STUDIO_INSTANCETYPE_FORCEINT = 65536
  );
  FMOD_STUDIO_BANK_INFO = record
    size: Integer;
    userdata: Pointer;
    userdatalength: Integer;
    opencallback: FMOD_FILE_OPEN_CALLBACK;
    closecallback: FMOD_FILE_CLOSE_CALLBACK;
    readcallback: FMOD_FILE_READ_CALLBACK;
    seekcallback: FMOD_FILE_SEEK_CALLBACK;
  end;
  FMOD_STUDIO_PARAMETER_ID = record
    data1: Cardinal;
    data2: Cardinal;
  end;
  FMOD_STUDIO_PARAMETER_DESCRIPTION = record
    name: PAnsiChar;
    id: FMOD_STUDIO_PARAMETER_ID;
    minimum: Single;
    maximum: Single;
    defaultvalue: Single;
    type_: FMOD_STUDIO_PARAMETER_TYPE;
    flags: FMOD_STUDIO_PARAMETER_FLAGS;
  end;
  FMOD_STUDIO_USER_PROPERTY = record
    name: PAnsiChar;
    type_: FMOD_STUDIO_USER_PROPERTY_TYPE;
    case Integer of
      0: (intvalue: Integer);
      1: (boolvalue: FMOD_BOOL);
      2: (floatvalue: Single);
      3: (stringvalue: PAnsiChar);
  end;
  FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES = record
    name: PAnsiChar;
    sound: PFMOD_SOUND;
    subsoundIndex: Integer;
  end;
  FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES = record
    name: PAnsiChar;
    dsp: PFMOD_DSP;
  end;
  FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES = record
    name: PAnsiChar;
    position: Integer;
  end;
  FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES = record
    bar: Integer;
    beat: Integer;
    position: Integer;
    tempo: Single;
    timesignatureupper: Integer;
    timesignaturelower: Integer;
  end;
  FMOD_STUDIO_ADVANCEDSETTINGS = record
    cbsize: Integer;
    commandqueuesize: Cardinal;
    handleinitialsize: Cardinal;
    studioupdateperiod: Integer;
    idlesampledatapoolsize: Integer;
    streamingscheduledelay: Cardinal;
    encryptionkey: PAnsiChar;
  end;
  FMOD_STUDIO_CPU_USAGE = record
    dspusage: Single;
    streamusage: Single;
    geometryusage: Single;
    updateusage: Single;
    studiousage: Single;
  end;
  FMOD_STUDIO_BUFFER_INFO = record
    currentusage: Integer;
    peakusage: Integer;
    capacity: Integer;
    stallcount: Integer;
    stalltime: Single;
  end;
  FMOD_STUDIO_BUFFER_USAGE = record
    studiocommandqueue: FMOD_STUDIO_BUFFER_INFO;
    studiohandle: FMOD_STUDIO_BUFFER_INFO;
  end;
  FMOD_STUDIO_SOUND_INFO = record
    name_or_data: PAnsiChar;
    mode: FMOD_MODE;
    exinfo: FMOD_CREATESOUNDEXINFO;
    subsoundindex: Integer;
  end;
  FMOD_STUDIO_COMMAND_INFO = record
    commandname: PAnsiChar;
    parentcommandindex: Integer;
    framenumber: Integer;
    frametime: Single;
    instancetype: FMOD_STUDIO_INSTANCETYPE;
    outputtype: FMOD_STUDIO_INSTANCETYPE;
    instancehandle: Cardinal;
    outputhandle: Cardinal;
  end;
  FMOD_STUDIO_MEMORY_USAGE = record
    exclusive: Integer;
    inclusive: Integer;
    sampledata: Integer;
  end;
  FMOD_STUDIO_SYSTEM_CALLBACK = function(system: PFMOD_STUDIO_SYSTEM; type_: FMOD_STUDIO_SYSTEM_CALLBACK_TYPE; commanddata: Pointer; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  FMOD_STUDIO_EVENT_CALLBACK = function(type_: FMOD_STUDIO_EVENT_CALLBACK_TYPE; event: PFMOD_STUDIO_EVENTINSTANCE; parameters: Pointer): FMOD_RESULT; FMOD_CC;
  FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK = function(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: Integer; currenttime: Single; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK = function(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: Integer; bankguid: PFMOD_GUID; bankfilename: PAnsiChar; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK = function(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: Integer; eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; instance: PPFMOD_STUDIO_EVENTINSTANCE; userdata: Pointer): FMOD_RESULT; FMOD_CC;

function FMOD_Studio_ParseID(idstring: PAnsiChar; id: PFMOD_GUID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_ParseID';
function FMOD_Studio_System_Create(system: PPFMOD_STUDIO_SYSTEM; headerversion: Cardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_Create';
function FMOD_Studio_System_IsValid(system: PFMOD_STUDIO_SYSTEM): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_IsValid';
function FMOD_Studio_System_SetAdvancedSettings(system: PFMOD_STUDIO_SYSTEM; settings: PFMOD_STUDIO_ADVANCEDSETTINGS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetAdvancedSettings';
function FMOD_Studio_System_GetAdvancedSettings(system: PFMOD_STUDIO_SYSTEM; settings: PFMOD_STUDIO_ADVANCEDSETTINGS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetAdvancedSettings';
function FMOD_Studio_System_Initialize(system: PFMOD_STUDIO_SYSTEM; maxchannels: Integer; studioflags: FMOD_STUDIO_INITFLAGS; flags: FMOD_INITFLAGS; extradriverdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_Initialize';
function FMOD_Studio_System_Release(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_Release';
function FMOD_Studio_System_Update(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_Update';
function FMOD_Studio_System_GetCoreSystem(system: PFMOD_STUDIO_SYSTEM; coresystem: PPFMOD_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetCoreSystem';
function FMOD_Studio_System_GetEvent(system: PFMOD_STUDIO_SYSTEM; pathOrID: PAnsiChar; event: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetEvent';
function FMOD_Studio_System_GetBus(system: PFMOD_STUDIO_SYSTEM; pathOrID: PAnsiChar; bus: PPFMOD_STUDIO_BUS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBus';
function FMOD_Studio_System_GetVCA(system: PFMOD_STUDIO_SYSTEM; pathOrID: PAnsiChar; vca: PPFMOD_STUDIO_VCA): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetVCA';
function FMOD_Studio_System_GetBank(system: PFMOD_STUDIO_SYSTEM; pathOrID: PAnsiChar; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBank';
function FMOD_Studio_System_GetEventByID(system: PFMOD_STUDIO_SYSTEM; id: PFMOD_GUID; event: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetEventByID';
function FMOD_Studio_System_GetBusByID(system: PFMOD_STUDIO_SYSTEM; id: PFMOD_GUID; bus: PPFMOD_STUDIO_BUS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBusByID';
function FMOD_Studio_System_GetVCAByID(system: PFMOD_STUDIO_SYSTEM; id: PFMOD_GUID; vca: PPFMOD_STUDIO_VCA): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetVCAByID';
function FMOD_Studio_System_GetBankByID(system: PFMOD_STUDIO_SYSTEM; id: PFMOD_GUID; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBankByID';
function FMOD_Studio_System_GetSoundInfo(system: PFMOD_STUDIO_SYSTEM; key: PAnsiChar; info: PFMOD_STUDIO_SOUND_INFO): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetSoundInfo';
function FMOD_Studio_System_GetParameterDescriptionByName(system: PFMOD_STUDIO_SYSTEM; name: PAnsiChar; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetParameterDescriptionByName';
function FMOD_Studio_System_GetParameterDescriptionByID(system: PFMOD_STUDIO_SYSTEM; id: FMOD_STUDIO_PARAMETER_ID; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetParameterDescriptionByID';
function FMOD_Studio_System_GetParameterByID(system: PFMOD_STUDIO_SYSTEM; id: FMOD_STUDIO_PARAMETER_ID; value: PSingle; finalvalue: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetParameterByID';
function FMOD_Studio_System_SetParameterByID(system: PFMOD_STUDIO_SYSTEM; id: FMOD_STUDIO_PARAMETER_ID; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetParameterByID';
function FMOD_Studio_System_SetParametersByIDs(system: PFMOD_STUDIO_SYSTEM; ids: PFMOD_STUDIO_PARAMETER_ID; values: PSingle; count: Integer; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetParametersByIDs';
function FMOD_Studio_System_GetParameterByName(system: PFMOD_STUDIO_SYSTEM; name: PAnsiChar; value: PSingle; finalvalue: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetParameterByName';
function FMOD_Studio_System_SetParameterByName(system: PFMOD_STUDIO_SYSTEM; name: PAnsiChar; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetParameterByName';
function FMOD_Studio_System_LookupID(system: PFMOD_STUDIO_SYSTEM; path: PAnsiChar; id: PFMOD_GUID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_LookupID';
function FMOD_Studio_System_LookupPath(system: PFMOD_STUDIO_SYSTEM; id: PFMOD_GUID; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_LookupPath';
function FMOD_Studio_System_GetNumListeners(system: PFMOD_STUDIO_SYSTEM; numlisteners: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetNumListeners';
function FMOD_Studio_System_SetNumListeners(system: PFMOD_STUDIO_SYSTEM; numlisteners: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetNumListeners';
function FMOD_Studio_System_GetListenerAttributes(system: PFMOD_STUDIO_SYSTEM; index: Integer; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetListenerAttributes';
function FMOD_Studio_System_SetListenerAttributes(system: PFMOD_STUDIO_SYSTEM; index: Integer; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetListenerAttributes';
function FMOD_Studio_System_GetListenerWeight(system: PFMOD_STUDIO_SYSTEM; index: Integer; weight: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetListenerWeight';
function FMOD_Studio_System_SetListenerWeight(system: PFMOD_STUDIO_SYSTEM; index: Integer; weight: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetListenerWeight';
function FMOD_Studio_System_LoadBankFile(system: PFMOD_STUDIO_SYSTEM; filename: PAnsiChar; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_LoadBankFile';
function FMOD_Studio_System_LoadBankMemory(system: PFMOD_STUDIO_SYSTEM; buffer: PAnsiChar; length: Integer; mode: FMOD_STUDIO_LOAD_MEMORY_MODE; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_LoadBankMemory';
function FMOD_Studio_System_LoadBankCustom(system: PFMOD_STUDIO_SYSTEM; info: PFMOD_STUDIO_BANK_INFO; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_LoadBankCustom';
function FMOD_Studio_System_RegisterPlugin(system: PFMOD_STUDIO_SYSTEM; description: PFMOD_DSP_DESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_RegisterPlugin';
function FMOD_Studio_System_UnregisterPlugin(system: PFMOD_STUDIO_SYSTEM; name: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_UnregisterPlugin';
function FMOD_Studio_System_UnloadAll(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_UnloadAll';
function FMOD_Studio_System_FlushCommands(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_FlushCommands';
function FMOD_Studio_System_FlushSampleLoading(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_FlushSampleLoading';
function FMOD_Studio_System_StartCommandCapture(system: PFMOD_STUDIO_SYSTEM; filename: PAnsiChar; flags: FMOD_STUDIO_COMMANDCAPTURE_FLAGS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_StartCommandCapture';
function FMOD_Studio_System_StopCommandCapture(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_StopCommandCapture';
function FMOD_Studio_System_LoadCommandReplay(system: PFMOD_STUDIO_SYSTEM; filename: PAnsiChar; flags: FMOD_STUDIO_COMMANDREPLAY_FLAGS; replay: PPFMOD_STUDIO_COMMANDREPLAY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_LoadCommandReplay';
function FMOD_Studio_System_GetBankCount(system: PFMOD_STUDIO_SYSTEM; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBankCount';
function FMOD_Studio_System_GetBankList(system: PFMOD_STUDIO_SYSTEM; array_: PPFMOD_STUDIO_BANK; capacity: Integer; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBankList';
function FMOD_Studio_System_GetParameterDescriptionCount(system: PFMOD_STUDIO_SYSTEM; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetParameterDescriptionCount';
function FMOD_Studio_System_GetParameterDescriptionList(system: PFMOD_STUDIO_SYSTEM; array_: PFMOD_STUDIO_PARAMETER_DESCRIPTION; capacity: Integer; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetParameterDescriptionList';
function FMOD_Studio_System_GetCPUUsage(system: PFMOD_STUDIO_SYSTEM; usage: PFMOD_STUDIO_CPU_USAGE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetCPUUsage';
function FMOD_Studio_System_GetBufferUsage(system: PFMOD_STUDIO_SYSTEM; usage: PFMOD_STUDIO_BUFFER_USAGE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetBufferUsage';
function FMOD_Studio_System_ResetBufferUsage(system: PFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_ResetBufferUsage';
function FMOD_Studio_System_SetCallback(system: PFMOD_STUDIO_SYSTEM; callback: FMOD_STUDIO_SYSTEM_CALLBACK; callbackmask: FMOD_STUDIO_SYSTEM_CALLBACK_TYPE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetCallback';
function FMOD_Studio_System_SetUserData(system: PFMOD_STUDIO_SYSTEM; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_SetUserData';
function FMOD_Studio_System_GetUserData(system: PFMOD_STUDIO_SYSTEM; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetUserData';
function FMOD_Studio_System_GetMemoryUsage(system: PFMOD_STUDIO_SYSTEM; memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_System_GetMemoryUsage';
function FMOD_Studio_EventDescription_IsValid(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_IsValid';
function FMOD_Studio_EventDescription_GetID(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; id: PFMOD_GUID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetID';
function FMOD_Studio_EventDescription_GetPath(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetPath';
function FMOD_Studio_EventDescription_GetParameterDescriptionCount(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetParameterDescriptionCount';
function FMOD_Studio_EventDescription_GetParameterDescriptionByIndex(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; index: Integer; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetParameterDescriptionByIndex';
function FMOD_Studio_EventDescription_GetParameterDescriptionByName(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; name: PAnsiChar; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetParameterDescriptionByName';
function FMOD_Studio_EventDescription_GetParameterDescriptionByID(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; id: FMOD_STUDIO_PARAMETER_ID; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetParameterDescriptionByID';
function FMOD_Studio_EventDescription_GetUserPropertyCount(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetUserPropertyCount';
function FMOD_Studio_EventDescription_GetUserPropertyByIndex(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; index: Integer; property_: PFMOD_STUDIO_USER_PROPERTY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetUserPropertyByIndex';
function FMOD_Studio_EventDescription_GetUserProperty(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; name: PAnsiChar; property_: PFMOD_STUDIO_USER_PROPERTY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetUserProperty';
function FMOD_Studio_EventDescription_GetLength(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; length: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetLength';
function FMOD_Studio_EventDescription_GetMinimumDistance(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; distance: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetMinimumDistance';
function FMOD_Studio_EventDescription_GetMaximumDistance(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; distance: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetMaximumDistance';
function FMOD_Studio_EventDescription_GetSoundSize(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; size: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetSoundSize';
function FMOD_Studio_EventDescription_IsSnapshot(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; snapshot: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_IsSnapshot';
function FMOD_Studio_EventDescription_IsOneshot(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; oneshot: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_IsOneshot';
function FMOD_Studio_EventDescription_IsStream(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; isStream: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_IsStream';
function FMOD_Studio_EventDescription_Is3D(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; is3D: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_Is3D';
function FMOD_Studio_EventDescription_HasCue(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; cue: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_HasCue';
function FMOD_Studio_EventDescription_CreateInstance(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; instance: PPFMOD_STUDIO_EVENTINSTANCE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_CreateInstance';
function FMOD_Studio_EventDescription_GetInstanceCount(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetInstanceCount';
function FMOD_Studio_EventDescription_GetInstanceList(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; array_: PPFMOD_STUDIO_EVENTINSTANCE; capacity: Integer; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetInstanceList';
function FMOD_Studio_EventDescription_LoadSampleData(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_LoadSampleData';
function FMOD_Studio_EventDescription_UnloadSampleData(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_UnloadSampleData';
function FMOD_Studio_EventDescription_GetSampleLoadingState(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetSampleLoadingState';
function FMOD_Studio_EventDescription_ReleaseAllInstances(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_ReleaseAllInstances';
function FMOD_Studio_EventDescription_SetCallback(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; callback: FMOD_STUDIO_EVENT_CALLBACK; callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_SetCallback';
function FMOD_Studio_EventDescription_GetUserData(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_GetUserData';
function FMOD_Studio_EventDescription_SetUserData(eventdescription: PFMOD_STUDIO_EVENTDESCRIPTION; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventDescription_SetUserData';
function FMOD_Studio_EventInstance_IsValid(eventinstance: PFMOD_STUDIO_EVENTINSTANCE): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_IsValid';
function FMOD_Studio_EventInstance_GetDescription(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; description: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetDescription';
function FMOD_Studio_EventInstance_GetVolume(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; volume: PSingle; finalvolume: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetVolume';
function FMOD_Studio_EventInstance_SetVolume(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; volume: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetVolume';
function FMOD_Studio_EventInstance_GetPitch(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; pitch: PSingle; finalpitch: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetPitch';
function FMOD_Studio_EventInstance_SetPitch(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; pitch: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetPitch';
function FMOD_Studio_EventInstance_Get3DAttributes(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_Get3DAttributes';
function FMOD_Studio_EventInstance_Set3DAttributes(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_Set3DAttributes';
function FMOD_Studio_EventInstance_GetListenerMask(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; mask: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetListenerMask';
function FMOD_Studio_EventInstance_SetListenerMask(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; mask: Cardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetListenerMask';
function FMOD_Studio_EventInstance_GetProperty(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; index: FMOD_STUDIO_EVENT_PROPERTY; value: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetProperty';
function FMOD_Studio_EventInstance_SetProperty(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; index: FMOD_STUDIO_EVENT_PROPERTY; value: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetProperty';
function FMOD_Studio_EventInstance_GetReverbLevel(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; index: Integer; level: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetReverbLevel';
function FMOD_Studio_EventInstance_SetReverbLevel(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; index: Integer; level: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetReverbLevel';
function FMOD_Studio_EventInstance_GetPaused(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetPaused';
function FMOD_Studio_EventInstance_SetPaused(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetPaused';
function FMOD_Studio_EventInstance_Start(eventinstance: PFMOD_STUDIO_EVENTINSTANCE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_Start';
function FMOD_Studio_EventInstance_Stop(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; mode: FMOD_STUDIO_STOP_MODE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_Stop';
function FMOD_Studio_EventInstance_GetTimelinePosition(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; position: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetTimelinePosition';
function FMOD_Studio_EventInstance_SetTimelinePosition(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; position: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetTimelinePosition';
function FMOD_Studio_EventInstance_GetPlaybackState(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; state: PFMOD_STUDIO_PLAYBACK_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetPlaybackState';
function FMOD_Studio_EventInstance_GetChannelGroup(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; group: PPFMOD_CHANNELGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetChannelGroup';
function FMOD_Studio_EventInstance_Release(eventinstance: PFMOD_STUDIO_EVENTINSTANCE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_Release';
function FMOD_Studio_EventInstance_IsVirtual(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; virtualstate: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_IsVirtual';
function FMOD_Studio_EventInstance_GetParameterByName(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; name: PAnsiChar; value: PSingle; finalvalue: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetParameterByName';
function FMOD_Studio_EventInstance_SetParameterByName(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; name: PAnsiChar; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetParameterByName';
function FMOD_Studio_EventInstance_GetParameterByID(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; id: FMOD_STUDIO_PARAMETER_ID; value: PSingle; finalvalue: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetParameterByID';
function FMOD_Studio_EventInstance_SetParameterByID(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; id: FMOD_STUDIO_PARAMETER_ID; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetParameterByID';
function FMOD_Studio_EventInstance_SetParametersByIDs(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; ids: PFMOD_STUDIO_PARAMETER_ID; values: PSingle; count: Integer; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetParametersByIDs';
function FMOD_Studio_EventInstance_TriggerCue(eventinstance: PFMOD_STUDIO_EVENTINSTANCE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_TriggerCue';
function FMOD_Studio_EventInstance_SetCallback(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; callback: FMOD_STUDIO_EVENT_CALLBACK; callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetCallback';
function FMOD_Studio_EventInstance_GetUserData(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetUserData';
function FMOD_Studio_EventInstance_SetUserData(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_SetUserData';
function FMOD_Studio_EventInstance_GetCPUUsage(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetCPUUsage';
function FMOD_Studio_EventInstance_GetMemoryUsage(eventinstance: PFMOD_STUDIO_EVENTINSTANCE; memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_EventInstance_GetMemoryUsage';
function FMOD_Studio_Bus_IsValid(bus: PFMOD_STUDIO_BUS): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_IsValid';
function FMOD_Studio_Bus_GetID(bus: PFMOD_STUDIO_BUS; id: PFMOD_GUID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetID';
function FMOD_Studio_Bus_GetPath(bus: PFMOD_STUDIO_BUS; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetPath';
function FMOD_Studio_Bus_GetVolume(bus: PFMOD_STUDIO_BUS; volume: PSingle; finalvolume: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetVolume';
function FMOD_Studio_Bus_SetVolume(bus: PFMOD_STUDIO_BUS; volume: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_SetVolume';
function FMOD_Studio_Bus_GetPaused(bus: PFMOD_STUDIO_BUS; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetPaused';
function FMOD_Studio_Bus_SetPaused(bus: PFMOD_STUDIO_BUS; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_SetPaused';
function FMOD_Studio_Bus_GetMute(bus: PFMOD_STUDIO_BUS; mute: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetMute';
function FMOD_Studio_Bus_SetMute(bus: PFMOD_STUDIO_BUS; mute: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_SetMute';
function FMOD_Studio_Bus_StopAllEvents(bus: PFMOD_STUDIO_BUS; mode: FMOD_STUDIO_STOP_MODE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_StopAllEvents';
function FMOD_Studio_Bus_LockChannelGroup(bus: PFMOD_STUDIO_BUS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_LockChannelGroup';
function FMOD_Studio_Bus_UnlockChannelGroup(bus: PFMOD_STUDIO_BUS): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_UnlockChannelGroup';
function FMOD_Studio_Bus_GetChannelGroup(bus: PFMOD_STUDIO_BUS; group: PPFMOD_CHANNELGROUP): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetChannelGroup';
function FMOD_Studio_Bus_GetCPUUsage(bus: PFMOD_STUDIO_BUS; exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetCPUUsage';
function FMOD_Studio_Bus_GetMemoryUsage(bus: PFMOD_STUDIO_BUS; memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bus_GetMemoryUsage';
function FMOD_Studio_VCA_IsValid(vca: PFMOD_STUDIO_VCA): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_VCA_IsValid';
function FMOD_Studio_VCA_GetID(vca: PFMOD_STUDIO_VCA; id: PFMOD_GUID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_VCA_GetID';
function FMOD_Studio_VCA_GetPath(vca: PFMOD_STUDIO_VCA; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_VCA_GetPath';
function FMOD_Studio_VCA_GetVolume(vca: PFMOD_STUDIO_VCA; volume: PSingle; finalvolume: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_VCA_GetVolume';
function FMOD_Studio_VCA_SetVolume(vca: PFMOD_STUDIO_VCA; volume: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_VCA_SetVolume';
function FMOD_Studio_Bank_IsValid(bank: PFMOD_STUDIO_BANK): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_IsValid';
function FMOD_Studio_Bank_GetID(bank: PFMOD_STUDIO_BANK; id: PFMOD_GUID): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetID';
function FMOD_Studio_Bank_GetPath(bank: PFMOD_STUDIO_BANK; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetPath';
function FMOD_Studio_Bank_Unload(bank: PFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_Unload';
function FMOD_Studio_Bank_LoadSampleData(bank: PFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_LoadSampleData';
function FMOD_Studio_Bank_UnloadSampleData(bank: PFMOD_STUDIO_BANK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_UnloadSampleData';
function FMOD_Studio_Bank_GetLoadingState(bank: PFMOD_STUDIO_BANK; state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetLoadingState';
function FMOD_Studio_Bank_GetSampleLoadingState(bank: PFMOD_STUDIO_BANK; state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetSampleLoadingState';
function FMOD_Studio_Bank_GetStringCount(bank: PFMOD_STUDIO_BANK; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetStringCount';
function FMOD_Studio_Bank_GetStringInfo(bank: PFMOD_STUDIO_BANK; index: Integer; id: PFMOD_GUID; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetStringInfo';
function FMOD_Studio_Bank_GetEventCount(bank: PFMOD_STUDIO_BANK; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetEventCount';
function FMOD_Studio_Bank_GetEventList(bank: PFMOD_STUDIO_BANK; array_: PPFMOD_STUDIO_EVENTDESCRIPTION; capacity: Integer; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetEventList';
function FMOD_Studio_Bank_GetBusCount(bank: PFMOD_STUDIO_BANK; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetBusCount';
function FMOD_Studio_Bank_GetBusList(bank: PFMOD_STUDIO_BANK; array_: PPFMOD_STUDIO_BUS; capacity: Integer; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetBusList';
function FMOD_Studio_Bank_GetVCACount(bank: PFMOD_STUDIO_BANK; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetVCACount';
function FMOD_Studio_Bank_GetVCAList(bank: PFMOD_STUDIO_BANK; array_: PPFMOD_STUDIO_VCA; capacity: Integer; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetVCAList';
function FMOD_Studio_Bank_GetUserData(bank: PFMOD_STUDIO_BANK; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_GetUserData';
function FMOD_Studio_Bank_SetUserData(bank: PFMOD_STUDIO_BANK; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_Bank_SetUserData';
function FMOD_Studio_CommandReplay_IsValid(replay: PFMOD_STUDIO_COMMANDREPLAY): FMOD_BOOL; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_IsValid';
function FMOD_Studio_CommandReplay_GetSystem(replay: PFMOD_STUDIO_COMMANDREPLAY; system: PPFMOD_STUDIO_SYSTEM): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetSystem';
function FMOD_Studio_CommandReplay_GetLength(replay: PFMOD_STUDIO_COMMANDREPLAY; length: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetLength';
function FMOD_Studio_CommandReplay_GetCommandCount(replay: PFMOD_STUDIO_COMMANDREPLAY; count: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetCommandCount';
function FMOD_Studio_CommandReplay_GetCommandInfo(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: Integer; info: PFMOD_STUDIO_COMMAND_INFO): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetCommandInfo';
function FMOD_Studio_CommandReplay_GetCommandString(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: Integer; buffer: PAnsiChar; length: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetCommandString';
function FMOD_Studio_CommandReplay_GetCommandAtTime(replay: PFMOD_STUDIO_COMMANDREPLAY; time: Single; commandindex: PInteger): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetCommandAtTime';
function FMOD_Studio_CommandReplay_SetBankPath(replay: PFMOD_STUDIO_COMMANDREPLAY; bankPath: PAnsiChar): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SetBankPath';
function FMOD_Studio_CommandReplay_Start(replay: PFMOD_STUDIO_COMMANDREPLAY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_Start';
function FMOD_Studio_CommandReplay_Stop(replay: PFMOD_STUDIO_COMMANDREPLAY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_Stop';
function FMOD_Studio_CommandReplay_SeekToTime(replay: PFMOD_STUDIO_COMMANDREPLAY; time: Single): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SeekToTime';
function FMOD_Studio_CommandReplay_SeekToCommand(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: Integer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SeekToCommand';
function FMOD_Studio_CommandReplay_GetPaused(replay: PFMOD_STUDIO_COMMANDREPLAY; paused: PFMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetPaused';
function FMOD_Studio_CommandReplay_SetPaused(replay: PFMOD_STUDIO_COMMANDREPLAY; paused: FMOD_BOOL): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SetPaused';
function FMOD_Studio_CommandReplay_GetPlaybackState(replay: PFMOD_STUDIO_COMMANDREPLAY; state: PFMOD_STUDIO_PLAYBACK_STATE): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetPlaybackState';
function FMOD_Studio_CommandReplay_GetCurrentCommand(replay: PFMOD_STUDIO_COMMANDREPLAY; commandindex: PInteger; currenttime: PSingle): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetCurrentCommand';
function FMOD_Studio_CommandReplay_Release(replay: PFMOD_STUDIO_COMMANDREPLAY): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_Release';
function FMOD_Studio_CommandReplay_SetFrameCallback(replay: PFMOD_STUDIO_COMMANDREPLAY; callback: FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SetFrameCallback';
function FMOD_Studio_CommandReplay_SetLoadBankCallback(replay: PFMOD_STUDIO_COMMANDREPLAY; callback: FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SetLoadBankCallback';
function FMOD_Studio_CommandReplay_SetCreateInstanceCallback(replay: PFMOD_STUDIO_COMMANDREPLAY; callback: FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SetCreateInstanceCallback';
function FMOD_Studio_CommandReplay_GetUserData(replay: PFMOD_STUDIO_COMMANDREPLAY; userdata: PPointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_GetUserData';
function FMOD_Studio_CommandReplay_SetUserData(replay: PFMOD_STUDIO_COMMANDREPLAY; userdata: Pointer): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_Studio_CommandReplay_SetUserData';


implementation

end.
