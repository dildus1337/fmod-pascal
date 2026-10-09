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
unit fmdevent_classes;

interface

uses
  fmod, fmdevent;

type

  TFMOD_EVENTSYSTEM = class
  public
    FHandle: PFMOD_EVENTSYSTEM;
    class function Make(out Inst: TFMOD_EVENTSYSTEM): FMOD_RESULT;
    function Init(maxchannels: Integer; flags: FMOD_INITFLAGS; extradriverdata: Pointer; eventflags: FMOD_EVENT_INITFLAGS): FMOD_RESULT;
    function Release: FMOD_RESULT;
    function Update: FMOD_RESULT;
    function SetMediaPath(path: PAnsiChar): FMOD_RESULT;
    function SetPluginPath(path: PAnsiChar): FMOD_RESULT;
    function GetVersion(version: PCardinal): FMOD_RESULT;
    function GetInfo(info: PFMOD_EVENT_SYSTEMINFO): FMOD_RESULT;
    function GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
    function GetMusicSystem(musicsystem: PPFMOD_MUSICSYSTEM): FMOD_RESULT;
    function SetLanguage(language: PAnsiChar): FMOD_RESULT;
    function GetLanguage(language: PAnsiChar): FMOD_RESULT;
    function RegisterDSP(description: PFMOD_DSP_DESCRIPTION; handle: PCardinal): FMOD_RESULT;
    function Load(name_or_data: PAnsiChar; loadinfo: PFMOD_EVENT_LOADINFO; project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
    function Unload: FMOD_RESULT;
    function GetProject(name: PAnsiChar; project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
    function GetProjectByIndex(index: Integer; project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
    function GetNumProjects(numprojects: PInteger): FMOD_RESULT;
    function GetCategory(name: PAnsiChar; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function GetCategoryByIndex(index: Integer; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function GetMusicCategory(category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function GetNumCategories(numcategories: PInteger): FMOD_RESULT;
    function GetGroup(name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetEvent(name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetEventBySystemID(systemid: Cardinal; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetEventByGUID(guid: PFMOD_GUID; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetEventByGUIDString(guid: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetNumEvents(numevents: PInteger): FMOD_RESULT;
    function SetReverbProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function GetReverbProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function GetReverbPreset(name: PAnsiChar; props: PFMOD_REVERB_PROPERTIES; index: PInteger): FMOD_RESULT;
    function GetReverbPresetByIndex(index: Integer; props: PFMOD_REVERB_PROPERTIES; name: PPAnsiChar): FMOD_RESULT;
    function GetNumReverbPresets(numpresets: PInteger): FMOD_RESULT;
    function CreateReverb(reverb: PPFMOD_EVENTREVERB): FMOD_RESULT;
    function SetReverbAmbientProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function GetReverbAmbientProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function CreateEventQueue(queue: PPFMOD_EVENTQUEUE): FMOD_RESULT;
    function CreateEventQueueEntry(event: PFMOD_EVENT; entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
    function Set3DNumListeners(numlisteners: Integer): FMOD_RESULT;
    function Get3DNumListeners(numlisteners: PInteger): FMOD_RESULT;
    function Set3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function PreloadFSB(filename: PAnsiChar; streaminstance: Integer; sound: PFMOD_SOUND; unloadprevious: FMOD_BOOL): FMOD_RESULT;
    function UnloadFSB(filename: PAnsiChar; streaminstance: Integer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTPROJECT = class
  public
    FHandle: PFMOD_EVENTPROJECT;
    function Release: FMOD_RESULT;
    function GetInfo(info: PFMOD_EVENT_PROJECTINFO): FMOD_RESULT;
    function GetGroup(name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetGroupByIndex(index: Integer; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetNumGroups(numgroups: PInteger): FMOD_RESULT;
    function GetEvent(name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetEventByProjectID(projectid: Cardinal; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetNumEvents(numevents: PInteger): FMOD_RESULT;
    function LoadSampleData(eventid_array: PInteger; sizeof_eventid_array: Integer; groupname_array: PPAnsiChar; sizeof_groupname_array: Integer; eventmode: FMOD_EVENT_MODE): FMOD_RESULT;
    function StopAllEvents(immediate: FMOD_BOOL): FMOD_RESULT;
    function CancelAllLoads: FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTGROUP = class
  public
    FHandle: PFMOD_EVENTGROUP;
    function GetInfo(index: PInteger; name: PPAnsiChar): FMOD_RESULT;
    function LoadEventData(resource: FMOD_EVENT_RESOURCE; mode: FMOD_EVENT_MODE): FMOD_RESULT;
    function FreeEventData(event: PFMOD_EVENT; waituntilready: FMOD_BOOL): FMOD_RESULT;
    function GetGroup(name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetGroupByIndex(index: Integer; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetParentGroup(group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetParentProject(project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
    function GetNumGroups(numgroups: PInteger): FMOD_RESULT;
    function GetEvent(name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetEventByIndex(index: Integer; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetNumEvents(numevents: PInteger): FMOD_RESULT;
    function GetProperty(propertyname: PAnsiChar; value: Pointer): FMOD_RESULT;
    function GetPropertyByIndex(propertyindex: Integer; value: Pointer): FMOD_RESULT;
    function GetNumProperties(numproperties: PInteger): FMOD_RESULT;
    function GetState(state: PFMOD_EVENT_STATE): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTCATEGORY = class
  public
    FHandle: PFMOD_EVENTCATEGORY;
    function GetInfo(index: PInteger; name: PPAnsiChar): FMOD_RESULT;
    function GetCategory(name: PAnsiChar; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function GetCategoryByIndex(index: Integer; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function GetNumCategories(numcategories: PInteger): FMOD_RESULT;
    function GetEventByIndex(index: Integer; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
    function GetNumEvents(numevents: PInteger): FMOD_RESULT;
    function GetParentCategory(category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function StopAllEvents: FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetVolume(volume: PSingle): FMOD_RESULT;
    function SetPitch(pitch: Single; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
    function GetPitch(pitch: PSingle; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetMute(mute: FMOD_BOOL): FMOD_RESULT;
    function GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
    function GetChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENT = class
  public
    FHandle: PFMOD_EVENT;
    function Release(freeeventdata: FMOD_BOOL; waituntilready: FMOD_BOOL): FMOD_RESULT;
    function Start: FMOD_RESULT;
    function Stop(immediate: FMOD_BOOL): FMOD_RESULT;
    function GetInfo(index: PInteger; name: PPAnsiChar; info: PFMOD_EVENT_INFO): FMOD_RESULT;
    function GetState(state: PFMOD_EVENT_STATE): FMOD_RESULT;
    function GetParentGroup(group: PPFMOD_EVENTGROUP): FMOD_RESULT;
    function GetChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function SetCallback(callback: FMOD_EVENT_CALLBACK; userdata: Pointer): FMOD_RESULT;
    function GetParameter(name: PAnsiChar; parameter: PPFMOD_EVENTPARAMETER): FMOD_RESULT;
    function GetParameterByIndex(index: Integer; parameter: PPFMOD_EVENTPARAMETER): FMOD_RESULT;
    function GetNumParameters(numparameters: PInteger): FMOD_RESULT;
    function GetProperty(propertyname: PAnsiChar; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
    function GetPropertyByIndex(propertyindex: Integer; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
    function SetProperty(propertyname: PAnsiChar; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
    function SetPropertyByIndex(propertyindex: Integer; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
    function GetNumProperties(numproperties: PInteger): FMOD_RESULT;
    function GetPropertyInfo(propertyindex: PInteger; propertyname: PPAnsiChar; type_: PFMOD_EVENTPROPERTY_TYPE): FMOD_RESULT;
    function GetCategory(category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetVolume(volume: PSingle): FMOD_RESULT;
    function SetPitch(pitch: Single; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
    function GetPitch(pitch: PSingle; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetMute(mute: FMOD_BOOL): FMOD_RESULT;
    function GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
    function Set3DAttributes(position: PFMOD_VECTOR; velocity: PFMOD_VECTOR; orientation: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DAttributes(position: PFMOD_VECTOR; velocity: PFMOD_VECTOR; orientation: PFMOD_VECTOR): FMOD_RESULT;
    function Set3DOcclusion(directocclusion: Single; reverbocclusion: Single): FMOD_RESULT;
    function Get3DOcclusion(directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT;
    function SetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
    function GetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTPARAMETER = class
  public
    FHandle: PFMOD_EVENTPARAMETER;
    function GetInfo(index: PInteger; name: PPAnsiChar): FMOD_RESULT;
    function GetRange(rangemin: PSingle; rangemax: PSingle): FMOD_RESULT;
    function SetValue(value: Single): FMOD_RESULT;
    function GetValue(value: PSingle): FMOD_RESULT;
    function SetVelocity(value: Single): FMOD_RESULT;
    function GetVelocity(value: PSingle): FMOD_RESULT;
    function SetSeekSpeed(value: Single): FMOD_RESULT;
    function GetSeekSpeed(value: PSingle): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function KeyOff: FMOD_RESULT;
    function DisableAutomation(disable: FMOD_BOOL): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTREVERB = class
  public
    FHandle: PFMOD_EVENTREVERB;
    function Release: FMOD_RESULT;
    function Set3DAttributes(position: PFMOD_VECTOR; mindistance: Single; maxdistance: Single): FMOD_RESULT;
    function Get3DAttributes(position: PFMOD_VECTOR; mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
    function SetProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function GetProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function SetActive(active: FMOD_BOOL): FMOD_RESULT;
    function GetActive(active: PFMOD_BOOL): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTQUEUE = class
  public
    FHandle: PFMOD_EVENTQUEUE;
    function Release: FMOD_RESULT;
    function Add(entry: PFMOD_EVENTQUEUEENTRY; allow_duplicates: FMOD_BOOL): FMOD_RESULT;
    function Remove(entry: PFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
    function RemoveHead: FMOD_RESULT;
    function Clear(stopallevents: FMOD_BOOL): FMOD_RESULT;
    function FindFirstEntry(entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
    function FindNextEntry(entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function IncludeDuckingCategory(category: PFMOD_EVENTCATEGORY; ducked_volume: Single; unducked_volume: Single; duck_time: Cardinal; unduck_time: Cardinal): FMOD_RESULT;
    function ExcludeDuckingCategory(category: PFMOD_EVENTCATEGORY): FMOD_RESULT;
    function SetCallback(callback: FMOD_EVENTQUEUE_CALLBACK; callbackuserdata: Pointer): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function Dump: FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_EVENTQUEUEENTRY = class
  public
    FHandle: PFMOD_EVENTQUEUEENTRY;
    function Release: FMOD_RESULT;
    function GetInfoOnlyEvent(infoonlyevent: PPFMOD_EVENT): FMOD_RESULT;
    function GetRealEvent(realevent: PPFMOD_EVENT): FMOD_RESULT;
    function SetPriority(priority: Byte): FMOD_RESULT;
    function GetPriority(priority: PByte): FMOD_RESULT;
    function SetExpiryTime(expirytime: Cardinal): FMOD_RESULT;
    function GetExpiryTime(expirytime: PCardinal): FMOD_RESULT;
    function SetDelayTime(delay: Cardinal): FMOD_RESULT;
    function GetDelayTime(delay: PCardinal): FMOD_RESULT;
    function SetInterrupt(interrupt: FMOD_BOOL): FMOD_RESULT;
    function GetInterrupt(interrupt: PFMOD_BOOL): FMOD_RESULT;
    function SetCrossfadeTime(crossfade: Integer): FMOD_RESULT;
    function GetCrossfadeTime(crossfade: PInteger): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_MUSICSYSTEM = class
  public
    FHandle: PFMOD_MUSICSYSTEM;
    function Reset: FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetVolume(volume: PSingle): FMOD_RESULT;
    function SetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
    function GetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetMute(mute: FMOD_BOOL): FMOD_RESULT;
    function GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
    function GetInfo(info: PFMOD_MUSIC_INFO): FMOD_RESULT;
    function PromptCue(id: FMOD_MUSIC_CUE_ID): FMOD_RESULT;
    function PrepareCue(id: FMOD_MUSIC_CUE_ID; prompt: PPFMOD_MUSICPROMPT): FMOD_RESULT;
    function GetParameterValue(id: FMOD_MUSIC_PARAM_ID; parameter: PSingle): FMOD_RESULT;
    function SetParameterValue(id: FMOD_MUSIC_PARAM_ID; parameter: Single): FMOD_RESULT;
    function GetCues(it: PFMOD_MUSIC_ITERATOR; filter: PAnsiChar): FMOD_RESULT;
    function GetNextCue(it: PFMOD_MUSIC_ITERATOR): FMOD_RESULT;
    function GetParameters(it: PFMOD_MUSIC_ITERATOR; filter: PAnsiChar): FMOD_RESULT;
    function GetNextParameter(it: PFMOD_MUSIC_ITERATOR): FMOD_RESULT;
    function LoadSoundData(resource: FMOD_EVENT_RESOURCE; mode: FMOD_EVENT_MODE): FMOD_RESULT;
    function FreeSoundData(waituntilready: FMOD_BOOL): FMOD_RESULT;
    function SetCallback(callback: FMOD_MUSIC_CALLBACK; userdata: Pointer): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

  TFMOD_MUSICPROMPT = class
  public
    FHandle: PFMOD_MUSICPROMPT;
    function Release: FMOD_RESULT;
    function Begin_: FMOD_RESULT;
    function End_: FMOD_RESULT;
    function IsActive(active: PFMOD_BOOL): FMOD_RESULT;
    function GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
  end;

implementation

class function TFMOD_EVENTSYSTEM.Make(out Inst: TFMOD_EVENTSYSTEM): FMOD_RESULT;
var
  h: PFMOD_EVENTSYSTEM;
begin
  Result := FMOD_EventSystem_Create(@h);
  if Result = FMOD_OK then
  begin
    Inst := TFMOD_EVENTSYSTEM.Create;
    Inst.FHandle := h;
  end
  else
    Inst := nil;
end;

function TFMOD_EVENTSYSTEM.Init(maxchannels: Integer; flags: FMOD_INITFLAGS; extradriverdata: Pointer; eventflags: FMOD_EVENT_INITFLAGS): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Init(FHandle, maxchannels, flags, extradriverdata, eventflags);
end;

function TFMOD_EVENTSYSTEM.Release: FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Release(FHandle);
end;

function TFMOD_EVENTSYSTEM.Update: FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Update(FHandle);
end;

function TFMOD_EVENTSYSTEM.SetMediaPath(path: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_SetMediaPath(FHandle, path);
end;

function TFMOD_EVENTSYSTEM.SetPluginPath(path: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_SetPluginPath(FHandle, path);
end;

function TFMOD_EVENTSYSTEM.GetVersion(version: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetVersion(FHandle, version);
end;

function TFMOD_EVENTSYSTEM.GetInfo(info: PFMOD_EVENT_SYSTEMINFO): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetInfo(FHandle, info);
end;

function TFMOD_EVENTSYSTEM.GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetSystemObject(FHandle, system);
end;

function TFMOD_EVENTSYSTEM.GetMusicSystem(musicsystem: PPFMOD_MUSICSYSTEM): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetMusicSystem(FHandle, musicsystem);
end;

function TFMOD_EVENTSYSTEM.SetLanguage(language: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_SetLanguage(FHandle, language);
end;

function TFMOD_EVENTSYSTEM.GetLanguage(language: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetLanguage(FHandle, language);
end;

function TFMOD_EVENTSYSTEM.RegisterDSP(description: PFMOD_DSP_DESCRIPTION; handle: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_RegisterDSP(FHandle, description, handle);
end;

function TFMOD_EVENTSYSTEM.Load(name_or_data: PAnsiChar; loadinfo: PFMOD_EVENT_LOADINFO; project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Load(FHandle, name_or_data, loadinfo, project);
end;

function TFMOD_EVENTSYSTEM.Unload: FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Unload(FHandle);
end;

function TFMOD_EVENTSYSTEM.GetProject(name: PAnsiChar; project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetProject(FHandle, name, project);
end;

function TFMOD_EVENTSYSTEM.GetProjectByIndex(index: Integer; project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetProjectByIndex(FHandle, index, project);
end;

function TFMOD_EVENTSYSTEM.GetNumProjects(numprojects: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetNumProjects(FHandle, numprojects);
end;

function TFMOD_EVENTSYSTEM.GetCategory(name: PAnsiChar; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetCategory(FHandle, name, category);
end;

function TFMOD_EVENTSYSTEM.GetCategoryByIndex(index: Integer; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetCategoryByIndex(FHandle, index, category);
end;

function TFMOD_EVENTSYSTEM.GetMusicCategory(category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetMusicCategory(FHandle, category);
end;

function TFMOD_EVENTSYSTEM.GetNumCategories(numcategories: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetNumCategories(FHandle, numcategories);
end;

function TFMOD_EVENTSYSTEM.GetGroup(name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetGroup(FHandle, name, cacheevents, group);
end;

function TFMOD_EVENTSYSTEM.GetEvent(name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetEvent(FHandle, name, mode, event);
end;

function TFMOD_EVENTSYSTEM.GetEventBySystemID(systemid: Cardinal; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetEventBySystemID(FHandle, systemid, mode, event);
end;

function TFMOD_EVENTSYSTEM.GetEventByGUID(guid: PFMOD_GUID; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetEventByGUID(FHandle, guid, mode, event);
end;

function TFMOD_EVENTSYSTEM.GetEventByGUIDString(guid: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetEventByGUIDString(FHandle, guid, mode, event);
end;

function TFMOD_EVENTSYSTEM.GetNumEvents(numevents: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetNumEvents(FHandle, numevents);
end;

function TFMOD_EVENTSYSTEM.SetReverbProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_SetReverbProperties(FHandle, props);
end;

function TFMOD_EVENTSYSTEM.GetReverbProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetReverbProperties(FHandle, props);
end;

function TFMOD_EVENTSYSTEM.GetReverbPreset(name: PAnsiChar; props: PFMOD_REVERB_PROPERTIES; index: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetReverbPreset(FHandle, name, props, index);
end;

function TFMOD_EVENTSYSTEM.GetReverbPresetByIndex(index: Integer; props: PFMOD_REVERB_PROPERTIES; name: PPAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetReverbPresetByIndex(FHandle, index, props, name);
end;

function TFMOD_EVENTSYSTEM.GetNumReverbPresets(numpresets: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetNumReverbPresets(FHandle, numpresets);
end;

function TFMOD_EVENTSYSTEM.CreateReverb(reverb: PPFMOD_EVENTREVERB): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_CreateReverb(FHandle, reverb);
end;

function TFMOD_EVENTSYSTEM.SetReverbAmbientProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_SetReverbAmbientProperties(FHandle, props);
end;

function TFMOD_EVENTSYSTEM.GetReverbAmbientProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetReverbAmbientProperties(FHandle, props);
end;

function TFMOD_EVENTSYSTEM.CreateEventQueue(queue: PPFMOD_EVENTQUEUE): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_CreateEventQueue(FHandle, queue);
end;

function TFMOD_EVENTSYSTEM.CreateEventQueueEntry(event: PFMOD_EVENT; entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_CreateEventQueueEntry(FHandle, event, entry);
end;

function TFMOD_EVENTSYSTEM.Set3DNumListeners(numlisteners: Integer): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Set3DNumListeners(FHandle, numlisteners);
end;

function TFMOD_EVENTSYSTEM.Get3DNumListeners(numlisteners: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Get3DNumListeners(FHandle, numlisteners);
end;

function TFMOD_EVENTSYSTEM.Set3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Set3DListenerAttributes(FHandle, listener, pos, vel, forward, up);
end;

function TFMOD_EVENTSYSTEM.Get3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_Get3DListenerAttributes(FHandle, listener, pos, vel, forward, up);
end;

function TFMOD_EVENTSYSTEM.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTSYSTEM.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTSYSTEM.PreloadFSB(filename: PAnsiChar; streaminstance: Integer; sound: PFMOD_SOUND; unloadprevious: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_PreloadFSB(FHandle, filename, streaminstance, sound, unloadprevious);
end;

function TFMOD_EVENTSYSTEM.UnloadFSB(filename: PAnsiChar; streaminstance: Integer): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_UnloadFSB(FHandle, filename, streaminstance);
end;

function TFMOD_EVENTSYSTEM.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventSystem_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTPROJECT.Release: FMOD_RESULT;
begin
  Result := FMOD_EventProject_Release(FHandle);
end;

function TFMOD_EVENTPROJECT.GetInfo(info: PFMOD_EVENT_PROJECTINFO): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetInfo(FHandle, info);
end;

function TFMOD_EVENTPROJECT.GetGroup(name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetGroup(FHandle, name, cacheevents, group);
end;

function TFMOD_EVENTPROJECT.GetGroupByIndex(index: Integer; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetGroupByIndex(FHandle, index, cacheevents, group);
end;

function TFMOD_EVENTPROJECT.GetNumGroups(numgroups: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetNumGroups(FHandle, numgroups);
end;

function TFMOD_EVENTPROJECT.GetEvent(name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetEvent(FHandle, name, mode, event);
end;

function TFMOD_EVENTPROJECT.GetEventByProjectID(projectid: Cardinal; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetEventByProjectID(FHandle, projectid, mode, event);
end;

function TFMOD_EVENTPROJECT.GetNumEvents(numevents: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetNumEvents(FHandle, numevents);
end;

function TFMOD_EVENTPROJECT.LoadSampleData(eventid_array: PInteger; sizeof_eventid_array: Integer; groupname_array: PPAnsiChar; sizeof_groupname_array: Integer; eventmode: FMOD_EVENT_MODE): FMOD_RESULT;
begin
  Result := FMOD_EventProject_LoadSampleData(FHandle, eventid_array, sizeof_eventid_array, groupname_array, sizeof_groupname_array, eventmode);
end;

function TFMOD_EVENTPROJECT.StopAllEvents(immediate: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventProject_StopAllEvents(FHandle, immediate);
end;

function TFMOD_EVENTPROJECT.CancelAllLoads: FMOD_RESULT;
begin
  Result := FMOD_EventProject_CancelAllLoads(FHandle);
end;

function TFMOD_EVENTPROJECT.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventProject_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTPROJECT.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTPROJECT.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventProject_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTGROUP.GetInfo(index: PInteger; name: PPAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetInfo(FHandle, index, name);
end;

function TFMOD_EVENTGROUP.LoadEventData(resource: FMOD_EVENT_RESOURCE; mode: FMOD_EVENT_MODE): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_LoadEventData(FHandle, resource, mode);
end;

function TFMOD_EVENTGROUP.FreeEventData(event: PFMOD_EVENT; waituntilready: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_FreeEventData(FHandle, event, waituntilready);
end;

function TFMOD_EVENTGROUP.GetGroup(name: PAnsiChar; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetGroup(FHandle, name, cacheevents, group);
end;

function TFMOD_EVENTGROUP.GetGroupByIndex(index: Integer; cacheevents: FMOD_BOOL; group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetGroupByIndex(FHandle, index, cacheevents, group);
end;

function TFMOD_EVENTGROUP.GetParentGroup(group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetParentGroup(FHandle, group);
end;

function TFMOD_EVENTGROUP.GetParentProject(project: PPFMOD_EVENTPROJECT): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetParentProject(FHandle, project);
end;

function TFMOD_EVENTGROUP.GetNumGroups(numgroups: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetNumGroups(FHandle, numgroups);
end;

function TFMOD_EVENTGROUP.GetEvent(name: PAnsiChar; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetEvent(FHandle, name, mode, event);
end;

function TFMOD_EVENTGROUP.GetEventByIndex(index: Integer; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetEventByIndex(FHandle, index, mode, event);
end;

function TFMOD_EVENTGROUP.GetNumEvents(numevents: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetNumEvents(FHandle, numevents);
end;

function TFMOD_EVENTGROUP.GetProperty(propertyname: PAnsiChar; value: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetProperty(FHandle, propertyname, value);
end;

function TFMOD_EVENTGROUP.GetPropertyByIndex(propertyindex: Integer; value: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetPropertyByIndex(FHandle, propertyindex, value);
end;

function TFMOD_EVENTGROUP.GetNumProperties(numproperties: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetNumProperties(FHandle, numproperties);
end;

function TFMOD_EVENTGROUP.GetState(state: PFMOD_EVENT_STATE): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetState(FHandle, state);
end;

function TFMOD_EVENTGROUP.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTGROUP.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTGROUP.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventGroup_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTCATEGORY.GetInfo(index: PInteger; name: PPAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetInfo(FHandle, index, name);
end;

function TFMOD_EVENTCATEGORY.GetCategory(name: PAnsiChar; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetCategory(FHandle, name, category);
end;

function TFMOD_EVENTCATEGORY.GetCategoryByIndex(index: Integer; category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetCategoryByIndex(FHandle, index, category);
end;

function TFMOD_EVENTCATEGORY.GetNumCategories(numcategories: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetNumCategories(FHandle, numcategories);
end;

function TFMOD_EVENTCATEGORY.GetEventByIndex(index: Integer; mode: FMOD_EVENT_MODE; event: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetEventByIndex(FHandle, index, mode, event);
end;

function TFMOD_EVENTCATEGORY.GetNumEvents(numevents: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetNumEvents(FHandle, numevents);
end;

function TFMOD_EVENTCATEGORY.GetParentCategory(category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetParentCategory(FHandle, category);
end;

function TFMOD_EVENTCATEGORY.StopAllEvents: FMOD_RESULT;
begin
  Result := FMOD_EventCategory_StopAllEvents(FHandle);
end;

function TFMOD_EVENTCATEGORY.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_SetVolume(FHandle, volume);
end;

function TFMOD_EVENTCATEGORY.GetVolume(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetVolume(FHandle, volume);
end;

function TFMOD_EVENTCATEGORY.SetPitch(pitch: Single; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_SetPitch(FHandle, pitch, units);
end;

function TFMOD_EVENTCATEGORY.GetPitch(pitch: PSingle; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetPitch(FHandle, pitch, units);
end;

function TFMOD_EVENTCATEGORY.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_SetPaused(FHandle, paused);
end;

function TFMOD_EVENTCATEGORY.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetPaused(FHandle, paused);
end;

function TFMOD_EVENTCATEGORY.SetMute(mute: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_SetMute(FHandle, mute);
end;

function TFMOD_EVENTCATEGORY.GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetMute(FHandle, mute);
end;

function TFMOD_EVENTCATEGORY.GetChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetChannelGroup(FHandle, channelgroup);
end;

function TFMOD_EVENTCATEGORY.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTCATEGORY.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTCATEGORY.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventCategory_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENT.Release(freeeventdata: FMOD_BOOL; waituntilready: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_Release(FHandle, freeeventdata, waituntilready);
end;

function TFMOD_EVENT.Start: FMOD_RESULT;
begin
  Result := FMOD_Event_Start(FHandle);
end;

function TFMOD_EVENT.Stop(immediate: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_Stop(FHandle, immediate);
end;

function TFMOD_EVENT.GetInfo(index: PInteger; name: PPAnsiChar; info: PFMOD_EVENT_INFO): FMOD_RESULT;
begin
  Result := FMOD_Event_GetInfo(FHandle, index, name, info);
end;

function TFMOD_EVENT.GetState(state: PFMOD_EVENT_STATE): FMOD_RESULT;
begin
  Result := FMOD_Event_GetState(FHandle, state);
end;

function TFMOD_EVENT.GetParentGroup(group: PPFMOD_EVENTGROUP): FMOD_RESULT;
begin
  Result := FMOD_Event_GetParentGroup(FHandle, group);
end;

function TFMOD_EVENT.GetChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_Event_GetChannelGroup(FHandle, channelgroup);
end;

function TFMOD_EVENT.SetCallback(callback: FMOD_EVENT_CALLBACK; userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Event_SetCallback(FHandle, callback, userdata);
end;

function TFMOD_EVENT.GetParameter(name: PAnsiChar; parameter: PPFMOD_EVENTPARAMETER): FMOD_RESULT;
begin
  Result := FMOD_Event_GetParameter(FHandle, name, parameter);
end;

function TFMOD_EVENT.GetParameterByIndex(index: Integer; parameter: PPFMOD_EVENTPARAMETER): FMOD_RESULT;
begin
  Result := FMOD_Event_GetParameterByIndex(FHandle, index, parameter);
end;

function TFMOD_EVENT.GetNumParameters(numparameters: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Event_GetNumParameters(FHandle, numparameters);
end;

function TFMOD_EVENT.GetProperty(propertyname: PAnsiChar; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_GetProperty(FHandle, propertyname, value, this_instance);
end;

function TFMOD_EVENT.GetPropertyByIndex(propertyindex: Integer; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_GetPropertyByIndex(FHandle, propertyindex, value, this_instance);
end;

function TFMOD_EVENT.SetProperty(propertyname: PAnsiChar; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_SetProperty(FHandle, propertyname, value, this_instance);
end;

function TFMOD_EVENT.SetPropertyByIndex(propertyindex: Integer; value: Pointer; this_instance: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_SetPropertyByIndex(FHandle, propertyindex, value, this_instance);
end;

function TFMOD_EVENT.GetNumProperties(numproperties: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Event_GetNumProperties(FHandle, numproperties);
end;

function TFMOD_EVENT.GetPropertyInfo(propertyindex: PInteger; propertyname: PPAnsiChar; type_: PFMOD_EVENTPROPERTY_TYPE): FMOD_RESULT;
begin
  Result := FMOD_Event_GetPropertyInfo(FHandle, propertyindex, propertyname, type_);
end;

function TFMOD_EVENT.GetCategory(category: PPFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_Event_GetCategory(FHandle, category);
end;

function TFMOD_EVENT.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Event_SetVolume(FHandle, volume);
end;

function TFMOD_EVENT.GetVolume(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Event_GetVolume(FHandle, volume);
end;

function TFMOD_EVENT.SetPitch(pitch: Single; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
begin
  Result := FMOD_Event_SetPitch(FHandle, pitch, units);
end;

function TFMOD_EVENT.GetPitch(pitch: PSingle; units: FMOD_EVENT_PITCHUNITS): FMOD_RESULT;
begin
  Result := FMOD_Event_GetPitch(FHandle, pitch, units);
end;

function TFMOD_EVENT.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_SetPaused(FHandle, paused);
end;

function TFMOD_EVENT.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_GetPaused(FHandle, paused);
end;

function TFMOD_EVENT.SetMute(mute: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_SetMute(FHandle, mute);
end;

function TFMOD_EVENT.GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Event_GetMute(FHandle, mute);
end;

function TFMOD_EVENT.Set3DAttributes(position: PFMOD_VECTOR; velocity: PFMOD_VECTOR; orientation: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Event_Set3DAttributes(FHandle, position, velocity, orientation);
end;

function TFMOD_EVENT.Get3DAttributes(position: PFMOD_VECTOR; velocity: PFMOD_VECTOR; orientation: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Event_Get3DAttributes(FHandle, position, velocity, orientation);
end;

function TFMOD_EVENT.Set3DOcclusion(directocclusion: Single; reverbocclusion: Single): FMOD_RESULT;
begin
  Result := FMOD_Event_Set3DOcclusion(FHandle, directocclusion, reverbocclusion);
end;

function TFMOD_EVENT.Get3DOcclusion(directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Event_Get3DOcclusion(FHandle, directocclusion, reverbocclusion);
end;

function TFMOD_EVENT.SetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_Event_SetReverbProperties(FHandle, props);
end;

function TFMOD_EVENT.GetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_Event_GetReverbProperties(FHandle, props);
end;

function TFMOD_EVENT.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Event_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENT.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Event_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENT.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_Event_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTPARAMETER.GetInfo(index: PInteger; name: PPAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetInfo(FHandle, index, name);
end;

function TFMOD_EVENTPARAMETER.GetRange(rangemin: PSingle; rangemax: PSingle): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetRange(FHandle, rangemin, rangemax);
end;

function TFMOD_EVENTPARAMETER.SetValue(value: Single): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_SetValue(FHandle, value);
end;

function TFMOD_EVENTPARAMETER.GetValue(value: PSingle): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetValue(FHandle, value);
end;

function TFMOD_EVENTPARAMETER.SetVelocity(value: Single): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_SetVelocity(FHandle, value);
end;

function TFMOD_EVENTPARAMETER.GetVelocity(value: PSingle): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetVelocity(FHandle, value);
end;

function TFMOD_EVENTPARAMETER.SetSeekSpeed(value: Single): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_SetSeekSpeed(FHandle, value);
end;

function TFMOD_EVENTPARAMETER.GetSeekSpeed(value: PSingle): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetSeekSpeed(FHandle, value);
end;

function TFMOD_EVENTPARAMETER.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTPARAMETER.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTPARAMETER.KeyOff: FMOD_RESULT;
begin
  Result := FMOD_EventParameter_KeyOff(FHandle);
end;

function TFMOD_EVENTPARAMETER.DisableAutomation(disable: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_DisableAutomation(FHandle, disable);
end;

function TFMOD_EVENTPARAMETER.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventParameter_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTREVERB.Release: FMOD_RESULT;
begin
  Result := FMOD_EventReverb_Release(FHandle);
end;

function TFMOD_EVENTREVERB.Set3DAttributes(position: PFMOD_VECTOR; mindistance: Single; maxdistance: Single): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_Set3DAttributes(FHandle, position, mindistance, maxdistance);
end;

function TFMOD_EVENTREVERB.Get3DAttributes(position: PFMOD_VECTOR; mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_Get3DAttributes(FHandle, position, mindistance, maxdistance);
end;

function TFMOD_EVENTREVERB.SetProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_SetProperties(FHandle, props);
end;

function TFMOD_EVENTREVERB.GetProperties(props: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_GetProperties(FHandle, props);
end;

function TFMOD_EVENTREVERB.SetActive(active: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_SetActive(FHandle, active);
end;

function TFMOD_EVENTREVERB.GetActive(active: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_GetActive(FHandle, active);
end;

function TFMOD_EVENTREVERB.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTREVERB.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTREVERB.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventReverb_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTQUEUE.Release: FMOD_RESULT;
begin
  Result := FMOD_EventQueue_Release(FHandle);
end;

function TFMOD_EVENTQUEUE.Add(entry: PFMOD_EVENTQUEUEENTRY; allow_duplicates: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_Add(FHandle, entry, allow_duplicates);
end;

function TFMOD_EVENTQUEUE.Remove(entry: PFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_Remove(FHandle, entry);
end;

function TFMOD_EVENTQUEUE.RemoveHead: FMOD_RESULT;
begin
  Result := FMOD_EventQueue_RemoveHead(FHandle);
end;

function TFMOD_EVENTQUEUE.Clear(stopallevents: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_Clear(FHandle, stopallevents);
end;

function TFMOD_EVENTQUEUE.FindFirstEntry(entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_FindFirstEntry(FHandle, entry);
end;

function TFMOD_EVENTQUEUE.FindNextEntry(entry: PPFMOD_EVENTQUEUEENTRY): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_FindNextEntry(FHandle, entry);
end;

function TFMOD_EVENTQUEUE.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_SetPaused(FHandle, paused);
end;

function TFMOD_EVENTQUEUE.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_GetPaused(FHandle, paused);
end;

function TFMOD_EVENTQUEUE.IncludeDuckingCategory(category: PFMOD_EVENTCATEGORY; ducked_volume: Single; unducked_volume: Single; duck_time: Cardinal; unduck_time: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_IncludeDuckingCategory(FHandle, category, ducked_volume, unducked_volume, duck_time, unduck_time);
end;

function TFMOD_EVENTQUEUE.ExcludeDuckingCategory(category: PFMOD_EVENTCATEGORY): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_ExcludeDuckingCategory(FHandle, category);
end;

function TFMOD_EVENTQUEUE.SetCallback(callback: FMOD_EVENTQUEUE_CALLBACK; callbackuserdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_SetCallback(FHandle, callback, callbackuserdata);
end;

function TFMOD_EVENTQUEUE.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTQUEUE.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTQUEUE.Dump: FMOD_RESULT;
begin
  Result := FMOD_EventQueue_Dump(FHandle);
end;

function TFMOD_EVENTQUEUE.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventQueue_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_EVENTQUEUEENTRY.Release: FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_Release(FHandle);
end;

function TFMOD_EVENTQUEUEENTRY.GetInfoOnlyEvent(infoonlyevent: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetInfoOnlyEvent(FHandle, infoonlyevent);
end;

function TFMOD_EVENTQUEUEENTRY.GetRealEvent(realevent: PPFMOD_EVENT): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetRealEvent(FHandle, realevent);
end;

function TFMOD_EVENTQUEUEENTRY.SetPriority(priority: Byte): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_SetPriority(FHandle, priority);
end;

function TFMOD_EVENTQUEUEENTRY.GetPriority(priority: PByte): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetPriority(FHandle, priority);
end;

function TFMOD_EVENTQUEUEENTRY.SetExpiryTime(expirytime: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_SetExpiryTime(FHandle, expirytime);
end;

function TFMOD_EVENTQUEUEENTRY.GetExpiryTime(expirytime: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetExpiryTime(FHandle, expirytime);
end;

function TFMOD_EVENTQUEUEENTRY.SetDelayTime(delay: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_SetDelayTime(FHandle, delay);
end;

function TFMOD_EVENTQUEUEENTRY.GetDelayTime(delay: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetDelayTime(FHandle, delay);
end;

function TFMOD_EVENTQUEUEENTRY.SetInterrupt(interrupt: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_SetInterrupt(FHandle, interrupt);
end;

function TFMOD_EVENTQUEUEENTRY.GetInterrupt(interrupt: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetInterrupt(FHandle, interrupt);
end;

function TFMOD_EVENTQUEUEENTRY.SetCrossfadeTime(crossfade: Integer): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_SetCrossfadeTime(FHandle, crossfade);
end;

function TFMOD_EVENTQUEUEENTRY.GetCrossfadeTime(crossfade: PInteger): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetCrossfadeTime(FHandle, crossfade);
end;

function TFMOD_EVENTQUEUEENTRY.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_SetUserData(FHandle, userdata);
end;

function TFMOD_EVENTQUEUEENTRY.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetUserData(FHandle, userdata);
end;

function TFMOD_EVENTQUEUEENTRY.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_EventQueueEntry_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_MUSICSYSTEM.Reset: FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_Reset(FHandle);
end;

function TFMOD_MUSICSYSTEM.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_SetVolume(FHandle, volume);
end;

function TFMOD_MUSICSYSTEM.GetVolume(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetVolume(FHandle, volume);
end;

function TFMOD_MUSICSYSTEM.SetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_SetReverbProperties(FHandle, props);
end;

function TFMOD_MUSICSYSTEM.GetReverbProperties(props: PFMOD_REVERB_CHANNELPROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetReverbProperties(FHandle, props);
end;

function TFMOD_MUSICSYSTEM.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_SetPaused(FHandle, paused);
end;

function TFMOD_MUSICSYSTEM.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetPaused(FHandle, paused);
end;

function TFMOD_MUSICSYSTEM.SetMute(mute: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_SetMute(FHandle, mute);
end;

function TFMOD_MUSICSYSTEM.GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetMute(FHandle, mute);
end;

function TFMOD_MUSICSYSTEM.GetInfo(info: PFMOD_MUSIC_INFO): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetInfo(FHandle, info);
end;

function TFMOD_MUSICSYSTEM.PromptCue(id: FMOD_MUSIC_CUE_ID): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_PromptCue(FHandle, id);
end;

function TFMOD_MUSICSYSTEM.PrepareCue(id: FMOD_MUSIC_CUE_ID; prompt: PPFMOD_MUSICPROMPT): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_PrepareCue(FHandle, id, prompt);
end;

function TFMOD_MUSICSYSTEM.GetParameterValue(id: FMOD_MUSIC_PARAM_ID; parameter: PSingle): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetParameterValue(FHandle, id, parameter);
end;

function TFMOD_MUSICSYSTEM.SetParameterValue(id: FMOD_MUSIC_PARAM_ID; parameter: Single): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_SetParameterValue(FHandle, id, parameter);
end;

function TFMOD_MUSICSYSTEM.GetCues(it: PFMOD_MUSIC_ITERATOR; filter: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetCues(FHandle, it, filter);
end;

function TFMOD_MUSICSYSTEM.GetNextCue(it: PFMOD_MUSIC_ITERATOR): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetNextCue(FHandle, it);
end;

function TFMOD_MUSICSYSTEM.GetParameters(it: PFMOD_MUSIC_ITERATOR; filter: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetParameters(FHandle, it, filter);
end;

function TFMOD_MUSICSYSTEM.GetNextParameter(it: PFMOD_MUSIC_ITERATOR): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetNextParameter(FHandle, it);
end;

function TFMOD_MUSICSYSTEM.LoadSoundData(resource: FMOD_EVENT_RESOURCE; mode: FMOD_EVENT_MODE): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_LoadSoundData(FHandle, resource, mode);
end;

function TFMOD_MUSICSYSTEM.FreeSoundData(waituntilready: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_FreeSoundData(FHandle, waituntilready);
end;

function TFMOD_MUSICSYSTEM.SetCallback(callback: FMOD_MUSIC_CALLBACK; userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_SetCallback(FHandle, callback, userdata);
end;

function TFMOD_MUSICSYSTEM.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_MusicSystem_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

function TFMOD_MUSICPROMPT.Release: FMOD_RESULT;
begin
  Result := FMOD_MusicPrompt_Release(FHandle);
end;

function TFMOD_MUSICPROMPT.Begin_: FMOD_RESULT;
begin
  Result := FMOD_MusicPrompt_Begin(FHandle);
end;

function TFMOD_MUSICPROMPT.End_: FMOD_RESULT;
begin
  Result := FMOD_MusicPrompt_End(FHandle);
end;

function TFMOD_MUSICPROMPT.IsActive(active: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_MusicPrompt_IsActive(FHandle, active);
end;

function TFMOD_MUSICPROMPT.GetMemoryInfo(memorybits: Cardinal; event_memorybits: Cardinal; memoryused: PCardinal; memoryused_details: PFMOD_MEMORY_USAGE_DETAILS): FMOD_RESULT;
begin
  Result := FMOD_MusicPrompt_GetMemoryInfo(FHandle, memorybits, event_memorybits, memoryused, memoryused_details);
end;

end.
