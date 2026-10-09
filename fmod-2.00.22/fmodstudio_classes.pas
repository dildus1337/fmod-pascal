(*
  Object Pascal wrappers around the flat C API, shaped like the C++ headers
  (fmod.hpp / fmod_studio.hpp / fmod_event.hpp). Methods are not C++ exports;
  each one calls the matching stdcall/cdecl C function.

  FHandle is not owned. Call Release (where it exists) before freeing the
  wrapper, or use the wrapper as a non-owning view of an existing handle.
*)
{$IFDEF FPC}
  {$MODE OBJFPC}{$H+}{$MODESWITCH RESULT+}
{$ENDIF}
unit fmodstudio_classes;

interface

uses
  fmod, fmodstudio;

type

  TFMOD_STUDIO_SYSTEM = class
  public
    FHandle: PFMOD_STUDIO_SYSTEM;
    class function Make(headerversion: Cardinal; out Inst: TFMOD_STUDIO_SYSTEM): FMOD_RESULT;
    function IsValid: FMOD_BOOL;
    function SetAdvancedSettings(settings: PFMOD_STUDIO_ADVANCEDSETTINGS): FMOD_RESULT;
    function GetAdvancedSettings(settings: PFMOD_STUDIO_ADVANCEDSETTINGS): FMOD_RESULT;
    function Initialize(maxchannels: Integer; studioflags: FMOD_STUDIO_INITFLAGS; flags: FMOD_INITFLAGS; extradriverdata: Pointer): FMOD_RESULT;
    function Release: FMOD_RESULT;
    function Update: FMOD_RESULT;
    function GetCoreSystem(coresystem: PPFMOD_SYSTEM): FMOD_RESULT;
    function GetEvent(pathOrID: PAnsiChar; event: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT;
    function GetBus(pathOrID: PAnsiChar; bus: PPFMOD_STUDIO_BUS): FMOD_RESULT;
    function GetVCA(pathOrID: PAnsiChar; vca: PPFMOD_STUDIO_VCA): FMOD_RESULT;
    function GetBank(pathOrID: PAnsiChar; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
    function GetEventByID(id: PFMOD_GUID; event: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT;
    function GetBusByID(id: PFMOD_GUID; bus: PPFMOD_STUDIO_BUS): FMOD_RESULT;
    function GetVCAByID(id: PFMOD_GUID; vca: PPFMOD_STUDIO_VCA): FMOD_RESULT;
    function GetBankByID(id: PFMOD_GUID; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
    function GetSoundInfo(key: PAnsiChar; info: PFMOD_STUDIO_SOUND_INFO): FMOD_RESULT;
    function GetParameterDescriptionByName(name: PAnsiChar; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
    function GetParameterDescriptionByID(id: FMOD_STUDIO_PARAMETER_ID; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
    function GetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
    function SetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
    function SetParametersByIDs(ids: PFMOD_STUDIO_PARAMETER_ID; values: PSingle; count: Integer; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
    function GetParameterByName(name: PAnsiChar; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
    function SetParameterByName(name: PAnsiChar; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
    function LookupID(path: PAnsiChar; id: PFMOD_GUID): FMOD_RESULT;
    function LookupPath(id: PFMOD_GUID; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
    function GetNumListeners(numlisteners: PInteger): FMOD_RESULT;
    function SetNumListeners(numlisteners: Integer): FMOD_RESULT;
    function GetListenerAttributes(index: Integer; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
    function SetListenerAttributes(index: Integer; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
    function GetListenerWeight(index: Integer; weight: PSingle): FMOD_RESULT;
    function SetListenerWeight(index: Integer; weight: Single): FMOD_RESULT;
    function LoadBankFile(filename: PAnsiChar; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
    function LoadBankMemory(buffer: PAnsiChar; length: Integer; mode: FMOD_STUDIO_LOAD_MEMORY_MODE; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
    function LoadBankCustom(info: PFMOD_STUDIO_BANK_INFO; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
    function RegisterPlugin(description: PFMOD_DSP_DESCRIPTION): FMOD_RESULT;
    function UnregisterPlugin(name: PAnsiChar): FMOD_RESULT;
    function UnloadAll: FMOD_RESULT;
    function FlushCommands: FMOD_RESULT;
    function FlushSampleLoading: FMOD_RESULT;
    function StartCommandCapture(filename: PAnsiChar; flags: FMOD_STUDIO_COMMANDCAPTURE_FLAGS): FMOD_RESULT;
    function StopCommandCapture: FMOD_RESULT;
    function LoadCommandReplay(filename: PAnsiChar; flags: FMOD_STUDIO_COMMANDREPLAY_FLAGS; replay: PPFMOD_STUDIO_COMMANDREPLAY): FMOD_RESULT;
    function GetBankCount(count: PInteger): FMOD_RESULT;
    function GetBankList(array_: PPFMOD_STUDIO_BANK; capacity: Integer; count: PInteger): FMOD_RESULT;
    function GetParameterDescriptionCount(count: PInteger): FMOD_RESULT;
    function GetParameterDescriptionList(array_: PFMOD_STUDIO_PARAMETER_DESCRIPTION; capacity: Integer; count: PInteger): FMOD_RESULT;
    function GetCPUUsage(usage: PFMOD_STUDIO_CPU_USAGE): FMOD_RESULT;
    function GetBufferUsage(usage: PFMOD_STUDIO_BUFFER_USAGE): FMOD_RESULT;
    function ResetBufferUsage: FMOD_RESULT;
    function SetCallback(callback: FMOD_STUDIO_SYSTEM_CALLBACK; callbackmask: FMOD_STUDIO_SYSTEM_CALLBACK_TYPE): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryUsage(memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT;
  end;

  TFMOD_STUDIO_EVENTDESCRIPTION = class
  public
    FHandle: PFMOD_STUDIO_EVENTDESCRIPTION;
    function IsValid: FMOD_BOOL;
    function GetID(id: PFMOD_GUID): FMOD_RESULT;
    function GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
    function GetParameterDescriptionCount(count: PInteger): FMOD_RESULT;
    function GetParameterDescriptionByIndex(index: Integer; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
    function GetParameterDescriptionByName(name: PAnsiChar; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
    function GetParameterDescriptionByID(id: FMOD_STUDIO_PARAMETER_ID; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
    function GetUserPropertyCount(count: PInteger): FMOD_RESULT;
    function GetUserPropertyByIndex(index: Integer; property_: PFMOD_STUDIO_USER_PROPERTY): FMOD_RESULT;
    function GetUserProperty(name: PAnsiChar; property_: PFMOD_STUDIO_USER_PROPERTY): FMOD_RESULT;
    function GetLength(length: PInteger): FMOD_RESULT;
    function GetMinimumDistance(distance: PSingle): FMOD_RESULT;
    function GetMaximumDistance(distance: PSingle): FMOD_RESULT;
    function GetSoundSize(size: PSingle): FMOD_RESULT;
    function IsSnapshot(snapshot: PFMOD_BOOL): FMOD_RESULT;
    function IsOneshot(oneshot: PFMOD_BOOL): FMOD_RESULT;
    function IsStream(isStream_: PFMOD_BOOL): FMOD_RESULT;
    function Is3D(is3D_: PFMOD_BOOL): FMOD_RESULT;
    function HasCue(cue: PFMOD_BOOL): FMOD_RESULT;
    function CreateInstance(instance: PPFMOD_STUDIO_EVENTINSTANCE): FMOD_RESULT;
    function GetInstanceCount(count: PInteger): FMOD_RESULT;
    function GetInstanceList(array_: PPFMOD_STUDIO_EVENTINSTANCE; capacity: Integer; count: PInteger): FMOD_RESULT;
    function LoadSampleData: FMOD_RESULT;
    function UnloadSampleData: FMOD_RESULT;
    function GetSampleLoadingState(state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT;
    function ReleaseAllInstances: FMOD_RESULT;
    function SetCallback(callback: FMOD_STUDIO_EVENT_CALLBACK; callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
  end;

  TFMOD_STUDIO_EVENTINSTANCE = class
  public
    FHandle: PFMOD_STUDIO_EVENTINSTANCE;
    function IsValid: FMOD_BOOL;
    function GetDescription(description: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT;
    function GetVolume(volume: PSingle; finalvolume: PSingle): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetPitch(pitch: PSingle; finalpitch: PSingle): FMOD_RESULT;
    function SetPitch(pitch: Single): FMOD_RESULT;
    function Get3DAttributes(attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
    function Set3DAttributes(attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
    function GetListenerMask(mask: PCardinal): FMOD_RESULT;
    function SetListenerMask(mask: Cardinal): FMOD_RESULT;
    function GetProperty(index: FMOD_STUDIO_EVENT_PROPERTY; value: PSingle): FMOD_RESULT;
    function SetProperty(index: FMOD_STUDIO_EVENT_PROPERTY; value: Single): FMOD_RESULT;
    function GetReverbLevel(index: Integer; level: PSingle): FMOD_RESULT;
    function SetReverbLevel(index: Integer; level: Single): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function Start: FMOD_RESULT;
    function Stop(mode: FMOD_STUDIO_STOP_MODE): FMOD_RESULT;
    function GetTimelinePosition(position: PInteger): FMOD_RESULT;
    function SetTimelinePosition(position: Integer): FMOD_RESULT;
    function GetPlaybackState(state: PFMOD_STUDIO_PLAYBACK_STATE): FMOD_RESULT;
    function GetChannelGroup(group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function Release: FMOD_RESULT;
    function IsVirtual(virtualstate: PFMOD_BOOL): FMOD_RESULT;
    function GetParameterByName(name: PAnsiChar; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
    function SetParameterByName(name: PAnsiChar; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
    function GetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
    function SetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
    function SetParametersByIDs(ids: PFMOD_STUDIO_PARAMETER_ID; values: PSingle; count: Integer; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
    function TriggerCue: FMOD_RESULT;
    function SetCallback(callback: FMOD_STUDIO_EVENT_CALLBACK; callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetCPUUsage(exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT;
    function GetMemoryUsage(memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT;
  end;

  TFMOD_STUDIO_BUS = class
  public
    FHandle: PFMOD_STUDIO_BUS;
    function IsValid: FMOD_BOOL;
    function GetID(id: PFMOD_GUID): FMOD_RESULT;
    function GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
    function GetVolume(volume: PSingle; finalvolume: PSingle): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
    function SetMute(mute: FMOD_BOOL): FMOD_RESULT;
    function StopAllEvents(mode: FMOD_STUDIO_STOP_MODE): FMOD_RESULT;
    function LockChannelGroup: FMOD_RESULT;
    function UnlockChannelGroup: FMOD_RESULT;
    function GetChannelGroup(group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function GetCPUUsage(exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT;
    function GetMemoryUsage(memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT;
  end;

  TFMOD_STUDIO_VCA = class
  public
    FHandle: PFMOD_STUDIO_VCA;
    function IsValid: FMOD_BOOL;
    function GetID(id: PFMOD_GUID): FMOD_RESULT;
    function GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
    function GetVolume(volume: PSingle; finalvolume: PSingle): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
  end;

  TFMOD_STUDIO_BANK = class
  public
    FHandle: PFMOD_STUDIO_BANK;
    function IsValid: FMOD_BOOL;
    function GetID(id: PFMOD_GUID): FMOD_RESULT;
    function GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
    function Unload: FMOD_RESULT;
    function LoadSampleData: FMOD_RESULT;
    function UnloadSampleData: FMOD_RESULT;
    function GetLoadingState(state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT;
    function GetSampleLoadingState(state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT;
    function GetStringCount(count: PInteger): FMOD_RESULT;
    function GetStringInfo(index: Integer; id: PFMOD_GUID; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
    function GetEventCount(count: PInteger): FMOD_RESULT;
    function GetEventList(array_: PPFMOD_STUDIO_EVENTDESCRIPTION; capacity: Integer; count: PInteger): FMOD_RESULT;
    function GetBusCount(count: PInteger): FMOD_RESULT;
    function GetBusList(array_: PPFMOD_STUDIO_BUS; capacity: Integer; count: PInteger): FMOD_RESULT;
    function GetVCACount(count: PInteger): FMOD_RESULT;
    function GetVCAList(array_: PPFMOD_STUDIO_VCA; capacity: Integer; count: PInteger): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
  end;

  TFMOD_STUDIO_COMMANDREPLAY = class
  public
    FHandle: PFMOD_STUDIO_COMMANDREPLAY;
    function IsValid: FMOD_BOOL;
    function GetSystem(system: PPFMOD_STUDIO_SYSTEM): FMOD_RESULT;
    function GetLength(length: PSingle): FMOD_RESULT;
    function GetCommandCount(count: PInteger): FMOD_RESULT;
    function GetCommandInfo(commandindex: Integer; info: PFMOD_STUDIO_COMMAND_INFO): FMOD_RESULT;
    function GetCommandString(commandindex: Integer; buffer: PAnsiChar; length: Integer): FMOD_RESULT;
    function GetCommandAtTime(time: Single; commandindex: PInteger): FMOD_RESULT;
    function SetBankPath(bankPath: PAnsiChar): FMOD_RESULT;
    function Start: FMOD_RESULT;
    function Stop: FMOD_RESULT;
    function SeekToTime(time: Single): FMOD_RESULT;
    function SeekToCommand(commandindex: Integer): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPlaybackState(state: PFMOD_STUDIO_PLAYBACK_STATE): FMOD_RESULT;
    function GetCurrentCommand(commandindex: PInteger; currenttime: PSingle): FMOD_RESULT;
    function Release: FMOD_RESULT;
    function SetFrameCallback(callback: FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK): FMOD_RESULT;
    function SetLoadBankCallback(callback: FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK): FMOD_RESULT;
    function SetCreateInstanceCallback(callback: FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
  end;

implementation

class function TFMOD_STUDIO_SYSTEM.Make(headerversion: Cardinal; out Inst: TFMOD_STUDIO_SYSTEM): FMOD_RESULT;
var
  h: PFMOD_STUDIO_SYSTEM;
begin
  Result := FMOD_Studio_System_Create(@h, headerversion);
  if Result = FMOD_OK then
  begin
    Inst := TFMOD_STUDIO_SYSTEM.Create;
    Inst.FHandle := h;
  end
  else
    Inst := nil;
end;

function TFMOD_STUDIO_SYSTEM.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_System_IsValid(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.SetAdvancedSettings(settings: PFMOD_STUDIO_ADVANCEDSETTINGS): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetAdvancedSettings(FHandle, settings);
end;

function TFMOD_STUDIO_SYSTEM.GetAdvancedSettings(settings: PFMOD_STUDIO_ADVANCEDSETTINGS): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetAdvancedSettings(FHandle, settings);
end;

function TFMOD_STUDIO_SYSTEM.Initialize(maxchannels: Integer; studioflags: FMOD_STUDIO_INITFLAGS; flags: FMOD_INITFLAGS; extradriverdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_Initialize(FHandle, maxchannels, studioflags, flags, extradriverdata);
end;

function TFMOD_STUDIO_SYSTEM.Release: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_Release(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.Update: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_Update(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.GetCoreSystem(coresystem: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetCoreSystem(FHandle, coresystem);
end;

function TFMOD_STUDIO_SYSTEM.GetEvent(pathOrID: PAnsiChar; event: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetEvent(FHandle, pathOrID, event);
end;

function TFMOD_STUDIO_SYSTEM.GetBus(pathOrID: PAnsiChar; bus: PPFMOD_STUDIO_BUS): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBus(FHandle, pathOrID, bus);
end;

function TFMOD_STUDIO_SYSTEM.GetVCA(pathOrID: PAnsiChar; vca: PPFMOD_STUDIO_VCA): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetVCA(FHandle, pathOrID, vca);
end;

function TFMOD_STUDIO_SYSTEM.GetBank(pathOrID: PAnsiChar; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBank(FHandle, pathOrID, bank);
end;

function TFMOD_STUDIO_SYSTEM.GetEventByID(id: PFMOD_GUID; event: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetEventByID(FHandle, id, event);
end;

function TFMOD_STUDIO_SYSTEM.GetBusByID(id: PFMOD_GUID; bus: PPFMOD_STUDIO_BUS): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBusByID(FHandle, id, bus);
end;

function TFMOD_STUDIO_SYSTEM.GetVCAByID(id: PFMOD_GUID; vca: PPFMOD_STUDIO_VCA): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetVCAByID(FHandle, id, vca);
end;

function TFMOD_STUDIO_SYSTEM.GetBankByID(id: PFMOD_GUID; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBankByID(FHandle, id, bank);
end;

function TFMOD_STUDIO_SYSTEM.GetSoundInfo(key: PAnsiChar; info: PFMOD_STUDIO_SOUND_INFO): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetSoundInfo(FHandle, key, info);
end;

function TFMOD_STUDIO_SYSTEM.GetParameterDescriptionByName(name: PAnsiChar; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetParameterDescriptionByName(FHandle, name, parameter);
end;

function TFMOD_STUDIO_SYSTEM.GetParameterDescriptionByID(id: FMOD_STUDIO_PARAMETER_ID; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetParameterDescriptionByID(FHandle, id, parameter);
end;

function TFMOD_STUDIO_SYSTEM.GetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetParameterByID(FHandle, id, value, finalvalue);
end;

function TFMOD_STUDIO_SYSTEM.SetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetParameterByID(FHandle, id, value, ignoreseekspeed);
end;

function TFMOD_STUDIO_SYSTEM.SetParametersByIDs(ids: PFMOD_STUDIO_PARAMETER_ID; values: PSingle; count: Integer; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetParametersByIDs(FHandle, ids, values, count, ignoreseekspeed);
end;

function TFMOD_STUDIO_SYSTEM.GetParameterByName(name: PAnsiChar; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetParameterByName(FHandle, name, value, finalvalue);
end;

function TFMOD_STUDIO_SYSTEM.SetParameterByName(name: PAnsiChar; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetParameterByName(FHandle, name, value, ignoreseekspeed);
end;

function TFMOD_STUDIO_SYSTEM.LookupID(path: PAnsiChar; id: PFMOD_GUID): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_LookupID(FHandle, path, id);
end;

function TFMOD_STUDIO_SYSTEM.LookupPath(id: PFMOD_GUID; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_LookupPath(FHandle, id, path, size, retrieved);
end;

function TFMOD_STUDIO_SYSTEM.GetNumListeners(numlisteners: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetNumListeners(FHandle, numlisteners);
end;

function TFMOD_STUDIO_SYSTEM.SetNumListeners(numlisteners: Integer): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetNumListeners(FHandle, numlisteners);
end;

function TFMOD_STUDIO_SYSTEM.GetListenerAttributes(index: Integer; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetListenerAttributes(FHandle, index, attributes);
end;

function TFMOD_STUDIO_SYSTEM.SetListenerAttributes(index: Integer; attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetListenerAttributes(FHandle, index, attributes);
end;

function TFMOD_STUDIO_SYSTEM.GetListenerWeight(index: Integer; weight: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetListenerWeight(FHandle, index, weight);
end;

function TFMOD_STUDIO_SYSTEM.SetListenerWeight(index: Integer; weight: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetListenerWeight(FHandle, index, weight);
end;

function TFMOD_STUDIO_SYSTEM.LoadBankFile(filename: PAnsiChar; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_LoadBankFile(FHandle, filename, flags, bank);
end;

function TFMOD_STUDIO_SYSTEM.LoadBankMemory(buffer: PAnsiChar; length: Integer; mode: FMOD_STUDIO_LOAD_MEMORY_MODE; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_LoadBankMemory(FHandle, buffer, length, mode, flags, bank);
end;

function TFMOD_STUDIO_SYSTEM.LoadBankCustom(info: PFMOD_STUDIO_BANK_INFO; flags: FMOD_STUDIO_LOAD_BANK_FLAGS; bank: PPFMOD_STUDIO_BANK): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_LoadBankCustom(FHandle, info, flags, bank);
end;

function TFMOD_STUDIO_SYSTEM.RegisterPlugin(description: PFMOD_DSP_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_RegisterPlugin(FHandle, description);
end;

function TFMOD_STUDIO_SYSTEM.UnregisterPlugin(name: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_UnregisterPlugin(FHandle, name);
end;

function TFMOD_STUDIO_SYSTEM.UnloadAll: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_UnloadAll(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.FlushCommands: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_FlushCommands(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.FlushSampleLoading: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_FlushSampleLoading(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.StartCommandCapture(filename: PAnsiChar; flags: FMOD_STUDIO_COMMANDCAPTURE_FLAGS): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_StartCommandCapture(FHandle, filename, flags);
end;

function TFMOD_STUDIO_SYSTEM.StopCommandCapture: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_StopCommandCapture(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.LoadCommandReplay(filename: PAnsiChar; flags: FMOD_STUDIO_COMMANDREPLAY_FLAGS; replay: PPFMOD_STUDIO_COMMANDREPLAY): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_LoadCommandReplay(FHandle, filename, flags, replay);
end;

function TFMOD_STUDIO_SYSTEM.GetBankCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBankCount(FHandle, count);
end;

function TFMOD_STUDIO_SYSTEM.GetBankList(array_: PPFMOD_STUDIO_BANK; capacity: Integer; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBankList(FHandle, array_, capacity, count);
end;

function TFMOD_STUDIO_SYSTEM.GetParameterDescriptionCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetParameterDescriptionCount(FHandle, count);
end;

function TFMOD_STUDIO_SYSTEM.GetParameterDescriptionList(array_: PFMOD_STUDIO_PARAMETER_DESCRIPTION; capacity: Integer; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetParameterDescriptionList(FHandle, array_, capacity, count);
end;

function TFMOD_STUDIO_SYSTEM.GetCPUUsage(usage: PFMOD_STUDIO_CPU_USAGE): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetCPUUsage(FHandle, usage);
end;

function TFMOD_STUDIO_SYSTEM.GetBufferUsage(usage: PFMOD_STUDIO_BUFFER_USAGE): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetBufferUsage(FHandle, usage);
end;

function TFMOD_STUDIO_SYSTEM.ResetBufferUsage: FMOD_RESULT;
begin
  Result := FMOD_Studio_System_ResetBufferUsage(FHandle);
end;

function TFMOD_STUDIO_SYSTEM.SetCallback(callback: FMOD_STUDIO_SYSTEM_CALLBACK; callbackmask: FMOD_STUDIO_SYSTEM_CALLBACK_TYPE): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetCallback(FHandle, callback, callbackmask);
end;

function TFMOD_STUDIO_SYSTEM.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_SetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_SYSTEM.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_SYSTEM.GetMemoryUsage(memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT;
begin
  Result := FMOD_Studio_System_GetMemoryUsage(FHandle, memoryusage);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_EventDescription_IsValid(FHandle);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetID(id: PFMOD_GUID): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetID(FHandle, id);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetPath(FHandle, path, size, retrieved);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetParameterDescriptionCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetParameterDescriptionCount(FHandle, count);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetParameterDescriptionByIndex(index: Integer; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetParameterDescriptionByIndex(FHandle, index, parameter);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetParameterDescriptionByName(name: PAnsiChar; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetParameterDescriptionByName(FHandle, name, parameter);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetParameterDescriptionByID(id: FMOD_STUDIO_PARAMETER_ID; parameter: PFMOD_STUDIO_PARAMETER_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetParameterDescriptionByID(FHandle, id, parameter);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetUserPropertyCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetUserPropertyCount(FHandle, count);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetUserPropertyByIndex(index: Integer; property_: PFMOD_STUDIO_USER_PROPERTY): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetUserPropertyByIndex(FHandle, index, property_);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetUserProperty(name: PAnsiChar; property_: PFMOD_STUDIO_USER_PROPERTY): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetUserProperty(FHandle, name, property_);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetLength(length: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetLength(FHandle, length);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetMinimumDistance(distance: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetMinimumDistance(FHandle, distance);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetMaximumDistance(distance: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetMaximumDistance(FHandle, distance);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetSoundSize(size: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetSoundSize(FHandle, size);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.IsSnapshot(snapshot: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_IsSnapshot(FHandle, snapshot);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.IsOneshot(oneshot: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_IsOneshot(FHandle, oneshot);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.IsStream(isStream_: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_IsStream(FHandle, isStream_);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.Is3D(is3D_: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_Is3D(FHandle, is3D_);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.HasCue(cue: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_HasCue(FHandle, cue);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.CreateInstance(instance: PPFMOD_STUDIO_EVENTINSTANCE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_CreateInstance(FHandle, instance);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetInstanceCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetInstanceCount(FHandle, count);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetInstanceList(array_: PPFMOD_STUDIO_EVENTINSTANCE; capacity: Integer; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetInstanceList(FHandle, array_, capacity, count);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.LoadSampleData: FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_LoadSampleData(FHandle);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.UnloadSampleData: FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_UnloadSampleData(FHandle);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetSampleLoadingState(state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetSampleLoadingState(FHandle, state);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.ReleaseAllInstances: FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_ReleaseAllInstances(FHandle);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.SetCallback(callback: FMOD_STUDIO_EVENT_CALLBACK; callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_SetCallback(FHandle, callback, callbackmask);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_GetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_EVENTDESCRIPTION.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventDescription_SetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_EVENTINSTANCE.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_EventInstance_IsValid(FHandle);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetDescription(description: PPFMOD_STUDIO_EVENTDESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetDescription(FHandle, description);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetVolume(volume: PSingle; finalvolume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetVolume(FHandle, volume, finalvolume);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetVolume(FHandle, volume);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetPitch(pitch: PSingle; finalpitch: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetPitch(FHandle, pitch, finalpitch);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetPitch(pitch: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetPitch(FHandle, pitch);
end;

function TFMOD_STUDIO_EVENTINSTANCE.Get3DAttributes(attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_Get3DAttributes(FHandle, attributes);
end;

function TFMOD_STUDIO_EVENTINSTANCE.Set3DAttributes(attributes: PFMOD_3D_ATTRIBUTES): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_Set3DAttributes(FHandle, attributes);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetListenerMask(mask: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetListenerMask(FHandle, mask);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetListenerMask(mask: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetListenerMask(FHandle, mask);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetProperty(index: FMOD_STUDIO_EVENT_PROPERTY; value: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetProperty(FHandle, index, value);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetProperty(index: FMOD_STUDIO_EVENT_PROPERTY; value: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetProperty(FHandle, index, value);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetReverbLevel(index: Integer; level: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetReverbLevel(FHandle, index, level);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetReverbLevel(index: Integer; level: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetReverbLevel(FHandle, index, level);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetPaused(FHandle, paused);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetPaused(FHandle, paused);
end;

function TFMOD_STUDIO_EVENTINSTANCE.Start: FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_Start(FHandle);
end;

function TFMOD_STUDIO_EVENTINSTANCE.Stop(mode: FMOD_STUDIO_STOP_MODE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_Stop(FHandle, mode);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetTimelinePosition(position: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetTimelinePosition(FHandle, position);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetTimelinePosition(position: Integer): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetTimelinePosition(FHandle, position);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetPlaybackState(state: PFMOD_STUDIO_PLAYBACK_STATE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetPlaybackState(FHandle, state);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetChannelGroup(group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetChannelGroup(FHandle, group);
end;

function TFMOD_STUDIO_EVENTINSTANCE.Release: FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_Release(FHandle);
end;

function TFMOD_STUDIO_EVENTINSTANCE.IsVirtual(virtualstate: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_IsVirtual(FHandle, virtualstate);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetParameterByName(name: PAnsiChar; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetParameterByName(FHandle, name, value, finalvalue);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetParameterByName(name: PAnsiChar; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetParameterByName(FHandle, name, value, ignoreseekspeed);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: PSingle; finalvalue: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetParameterByID(FHandle, id, value, finalvalue);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetParameterByID(id: FMOD_STUDIO_PARAMETER_ID; value: Single; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetParameterByID(FHandle, id, value, ignoreseekspeed);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetParametersByIDs(ids: PFMOD_STUDIO_PARAMETER_ID; values: PSingle; count: Integer; ignoreseekspeed: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetParametersByIDs(FHandle, ids, values, count, ignoreseekspeed);
end;

function TFMOD_STUDIO_EVENTINSTANCE.TriggerCue: FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_TriggerCue(FHandle);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetCallback(callback: FMOD_STUDIO_EVENT_CALLBACK; callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetCallback(FHandle, callback, callbackmask);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_EVENTINSTANCE.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_SetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetCPUUsage(exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetCPUUsage(FHandle, exclusive, inclusive);
end;

function TFMOD_STUDIO_EVENTINSTANCE.GetMemoryUsage(memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT;
begin
  Result := FMOD_Studio_EventInstance_GetMemoryUsage(FHandle, memoryusage);
end;

function TFMOD_STUDIO_BUS.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_Bus_IsValid(FHandle);
end;

function TFMOD_STUDIO_BUS.GetID(id: PFMOD_GUID): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetID(FHandle, id);
end;

function TFMOD_STUDIO_BUS.GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetPath(FHandle, path, size, retrieved);
end;

function TFMOD_STUDIO_BUS.GetVolume(volume: PSingle; finalvolume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetVolume(FHandle, volume, finalvolume);
end;

function TFMOD_STUDIO_BUS.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_SetVolume(FHandle, volume);
end;

function TFMOD_STUDIO_BUS.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetPaused(FHandle, paused);
end;

function TFMOD_STUDIO_BUS.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_SetPaused(FHandle, paused);
end;

function TFMOD_STUDIO_BUS.GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetMute(FHandle, mute);
end;

function TFMOD_STUDIO_BUS.SetMute(mute: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_SetMute(FHandle, mute);
end;

function TFMOD_STUDIO_BUS.StopAllEvents(mode: FMOD_STUDIO_STOP_MODE): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_StopAllEvents(FHandle, mode);
end;

function TFMOD_STUDIO_BUS.LockChannelGroup: FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_LockChannelGroup(FHandle);
end;

function TFMOD_STUDIO_BUS.UnlockChannelGroup: FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_UnlockChannelGroup(FHandle);
end;

function TFMOD_STUDIO_BUS.GetChannelGroup(group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetChannelGroup(FHandle, group);
end;

function TFMOD_STUDIO_BUS.GetCPUUsage(exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetCPUUsage(FHandle, exclusive, inclusive);
end;

function TFMOD_STUDIO_BUS.GetMemoryUsage(memoryusage: PFMOD_STUDIO_MEMORY_USAGE): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bus_GetMemoryUsage(FHandle, memoryusage);
end;

function TFMOD_STUDIO_VCA.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_VCA_IsValid(FHandle);
end;

function TFMOD_STUDIO_VCA.GetID(id: PFMOD_GUID): FMOD_RESULT;
begin
  Result := FMOD_Studio_VCA_GetID(FHandle, id);
end;

function TFMOD_STUDIO_VCA.GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_VCA_GetPath(FHandle, path, size, retrieved);
end;

function TFMOD_STUDIO_VCA.GetVolume(volume: PSingle; finalvolume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_VCA_GetVolume(FHandle, volume, finalvolume);
end;

function TFMOD_STUDIO_VCA.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_VCA_SetVolume(FHandle, volume);
end;

function TFMOD_STUDIO_BANK.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_Bank_IsValid(FHandle);
end;

function TFMOD_STUDIO_BANK.GetID(id: PFMOD_GUID): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetID(FHandle, id);
end;

function TFMOD_STUDIO_BANK.GetPath(path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetPath(FHandle, path, size, retrieved);
end;

function TFMOD_STUDIO_BANK.Unload: FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_Unload(FHandle);
end;

function TFMOD_STUDIO_BANK.LoadSampleData: FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_LoadSampleData(FHandle);
end;

function TFMOD_STUDIO_BANK.UnloadSampleData: FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_UnloadSampleData(FHandle);
end;

function TFMOD_STUDIO_BANK.GetLoadingState(state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetLoadingState(FHandle, state);
end;

function TFMOD_STUDIO_BANK.GetSampleLoadingState(state: PFMOD_STUDIO_LOADING_STATE): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetSampleLoadingState(FHandle, state);
end;

function TFMOD_STUDIO_BANK.GetStringCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetStringCount(FHandle, count);
end;

function TFMOD_STUDIO_BANK.GetStringInfo(index: Integer; id: PFMOD_GUID; path: PAnsiChar; size: Integer; retrieved: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetStringInfo(FHandle, index, id, path, size, retrieved);
end;

function TFMOD_STUDIO_BANK.GetEventCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetEventCount(FHandle, count);
end;

function TFMOD_STUDIO_BANK.GetEventList(array_: PPFMOD_STUDIO_EVENTDESCRIPTION; capacity: Integer; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetEventList(FHandle, array_, capacity, count);
end;

function TFMOD_STUDIO_BANK.GetBusCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetBusCount(FHandle, count);
end;

function TFMOD_STUDIO_BANK.GetBusList(array_: PPFMOD_STUDIO_BUS; capacity: Integer; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetBusList(FHandle, array_, capacity, count);
end;

function TFMOD_STUDIO_BANK.GetVCACount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetVCACount(FHandle, count);
end;

function TFMOD_STUDIO_BANK.GetVCAList(array_: PPFMOD_STUDIO_VCA; capacity: Integer; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetVCAList(FHandle, array_, capacity, count);
end;

function TFMOD_STUDIO_BANK.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_GetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_BANK.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_Bank_SetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_COMMANDREPLAY.IsValid: FMOD_BOOL;
begin
  Result := FMOD_Studio_CommandReplay_IsValid(FHandle);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetSystem(system: PPFMOD_STUDIO_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetSystem(FHandle, system);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetLength(length: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetLength(FHandle, length);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetCommandCount(count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetCommandCount(FHandle, count);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetCommandInfo(commandindex: Integer; info: PFMOD_STUDIO_COMMAND_INFO): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetCommandInfo(FHandle, commandindex, info);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetCommandString(commandindex: Integer; buffer: PAnsiChar; length: Integer): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetCommandString(FHandle, commandindex, buffer, length);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetCommandAtTime(time: Single; commandindex: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetCommandAtTime(FHandle, time, commandindex);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SetBankPath(bankPath: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SetBankPath(FHandle, bankPath);
end;

function TFMOD_STUDIO_COMMANDREPLAY.Start: FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_Start(FHandle);
end;

function TFMOD_STUDIO_COMMANDREPLAY.Stop: FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_Stop(FHandle);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SeekToTime(time: Single): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SeekToTime(FHandle, time);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SeekToCommand(commandindex: Integer): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SeekToCommand(FHandle, commandindex);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetPaused(FHandle, paused);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SetPaused(FHandle, paused);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetPlaybackState(state: PFMOD_STUDIO_PLAYBACK_STATE): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetPlaybackState(FHandle, state);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetCurrentCommand(commandindex: PInteger; currenttime: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetCurrentCommand(FHandle, commandindex, currenttime);
end;

function TFMOD_STUDIO_COMMANDREPLAY.Release: FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_Release(FHandle);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SetFrameCallback(callback: FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SetFrameCallback(FHandle, callback);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SetLoadBankCallback(callback: FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SetLoadBankCallback(FHandle, callback);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SetCreateInstanceCallback(callback: FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SetCreateInstanceCallback(FHandle, callback);
end;

function TFMOD_STUDIO_COMMANDREPLAY.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_GetUserData(FHandle, userdata);
end;

function TFMOD_STUDIO_COMMANDREPLAY.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Studio_CommandReplay_SetUserData(FHandle, userdata);
end;

end.
