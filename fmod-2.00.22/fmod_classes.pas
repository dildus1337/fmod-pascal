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
unit fmod_classes;

interface

uses
  fmod;

type

  TFMOD_SYSTEM = class
  public
    FHandle: PFMOD_SYSTEM;
    class function Make(out Inst: TFMOD_SYSTEM): FMOD_RESULT;
    function Release: FMOD_RESULT;
    function SetOutput(output: FMOD_OUTPUTTYPE): FMOD_RESULT;
    function GetOutput(output: PFMOD_OUTPUTTYPE): FMOD_RESULT;
    function GetNumDrivers(numdrivers: PInteger): FMOD_RESULT;
    function GetDriverInfo(id: Integer; name: PAnsiChar; namelen: Integer; guid: PFMOD_GUID; systemrate: PInteger; speakermode: PFMOD_SPEAKERMODE; speakermodechannels: PInteger): FMOD_RESULT;
    function SetDriver(driver: Integer): FMOD_RESULT;
    function GetDriver(driver: PInteger): FMOD_RESULT;
    function SetSoftwareChannels(numsoftwarechannels: Integer): FMOD_RESULT;
    function GetSoftwareChannels(numsoftwarechannels: PInteger): FMOD_RESULT;
    function SetSoftwareFormat(samplerate: Integer; speakermode: FMOD_SPEAKERMODE; numrawspeakers: Integer): FMOD_RESULT;
    function GetSoftwareFormat(samplerate: PInteger; speakermode: PFMOD_SPEAKERMODE; numrawspeakers: PInteger): FMOD_RESULT;
    function SetDSPBufferSize(bufferlength: Cardinal; numbuffers: Integer): FMOD_RESULT;
    function GetDSPBufferSize(bufferlength: PCardinal; numbuffers: PInteger): FMOD_RESULT;
    function SetFileSystem(useropen: FMOD_FILE_OPEN_CALLBACK; userclose: FMOD_FILE_CLOSE_CALLBACK; userread: FMOD_FILE_READ_CALLBACK; userseek: FMOD_FILE_SEEK_CALLBACK; userasyncread: FMOD_FILE_ASYNCREAD_CALLBACK; userasynccancel: FMOD_FILE_ASYNCCANCEL_CALLBACK; blockalign: Integer): FMOD_RESULT;
    function AttachFileSystem(useropen: FMOD_FILE_OPEN_CALLBACK; userclose: FMOD_FILE_CLOSE_CALLBACK; userread: FMOD_FILE_READ_CALLBACK; userseek: FMOD_FILE_SEEK_CALLBACK): FMOD_RESULT;
    function SetAdvancedSettings(settings: PFMOD_ADVANCEDSETTINGS): FMOD_RESULT;
    function GetAdvancedSettings(settings: PFMOD_ADVANCEDSETTINGS): FMOD_RESULT;
    function SetCallback(callback: FMOD_SYSTEM_CALLBACK; callbackmask: FMOD_SYSTEM_CALLBACK_TYPE): FMOD_RESULT;
    function SetPluginPath(path: PAnsiChar): FMOD_RESULT;
    function LoadPlugin(filename: PAnsiChar; handle: PCardinal; priority: Cardinal): FMOD_RESULT;
    function UnloadPlugin(handle: Cardinal): FMOD_RESULT;
    function GetNumNestedPlugins(handle: Cardinal; count: PInteger): FMOD_RESULT;
    function GetNestedPlugin(handle: Cardinal; index: Integer; nestedhandle: PCardinal): FMOD_RESULT;
    function GetNumPlugins(plugintype: FMOD_PLUGINTYPE; numplugins: PInteger): FMOD_RESULT;
    function GetPluginHandle(plugintype: FMOD_PLUGINTYPE; index: Integer; handle: PCardinal): FMOD_RESULT;
    function GetPluginInfo(handle: Cardinal; plugintype: PFMOD_PLUGINTYPE; name: PAnsiChar; namelen: Integer; version: PCardinal): FMOD_RESULT;
    function SetOutputByPlugin(handle: Cardinal): FMOD_RESULT;
    function GetOutputByPlugin(handle: PCardinal): FMOD_RESULT;
    function CreateDSPByPlugin(handle: Cardinal; dsp: PPFMOD_DSP): FMOD_RESULT;
    function GetDSPInfoByPlugin(handle: Cardinal; description: PPFMOD_DSP_DESCRIPTION): FMOD_RESULT;
    function RegisterCodec(description: PFMOD_CODEC_DESCRIPTION; handle: PCardinal; priority: Cardinal): FMOD_RESULT;
    function RegisterDSP(description: PFMOD_DSP_DESCRIPTION; handle: PCardinal): FMOD_RESULT;
    function RegisterOutput(description: PFMOD_OUTPUT_DESCRIPTION; handle: PCardinal): FMOD_RESULT;
    function Init(maxchannels: Integer; flags: FMOD_INITFLAGS; extradriverdata: Pointer): FMOD_RESULT;
    function Close: FMOD_RESULT;
    function Update: FMOD_RESULT;
    function SetSpeakerPosition(speaker: FMOD_SPEAKER; x: Single; y: Single; active: FMOD_BOOL): FMOD_RESULT;
    function GetSpeakerPosition(speaker: FMOD_SPEAKER; x: PSingle; y: PSingle; active: PFMOD_BOOL): FMOD_RESULT;
    function SetStreamBufferSize(filebuffersize: Cardinal; filebuffersizetype: FMOD_TIMEUNIT): FMOD_RESULT;
    function GetStreamBufferSize(filebuffersize: PCardinal; filebuffersizetype: PFMOD_TIMEUNIT): FMOD_RESULT;
    function Set3DSettings(dopplerscale: Single; distancefactor: Single; rolloffscale: Single): FMOD_RESULT;
    function Get3DSettings(dopplerscale: PSingle; distancefactor: PSingle; rolloffscale: PSingle): FMOD_RESULT;
    function Set3DNumListeners(numlisteners: Integer): FMOD_RESULT;
    function Get3DNumListeners(numlisteners: PInteger): FMOD_RESULT;
    function Set3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
    function Set3DRolloffCallback(callback: FMOD_3D_ROLLOFF_CALLBACK): FMOD_RESULT;
    function MixerSuspend: FMOD_RESULT;
    function MixerResume: FMOD_RESULT;
    function GetDefaultMixMatrix(sourcespeakermode: FMOD_SPEAKERMODE; targetspeakermode: FMOD_SPEAKERMODE; matrix: PSingle; matrixhop: Integer): FMOD_RESULT;
    function GetSpeakerModeChannels(mode: FMOD_SPEAKERMODE; channels: PInteger): FMOD_RESULT;
    function GetVersion(version: PCardinal): FMOD_RESULT;
    function GetOutputHandle(handle: PPointer): FMOD_RESULT;
    function GetChannelsPlaying(channels: PInteger; realchannels: PInteger): FMOD_RESULT;
    function GetCPUUsage(dsp: PSingle; stream: PSingle; geometry: PSingle; update_: PSingle; total: PSingle): FMOD_RESULT;
    function GetFileUsage(sampleBytesRead: PInt64; streamBytesRead: PInt64; otherBytesRead: PInt64): FMOD_RESULT;
    function CreateSound(name_or_data: PAnsiChar; mode: FMOD_MODE; exinfo: PFMOD_CREATESOUNDEXINFO; sound: PPFMOD_SOUND): FMOD_RESULT;
    function CreateStream(name_or_data: PAnsiChar; mode: FMOD_MODE; exinfo: PFMOD_CREATESOUNDEXINFO; sound: PPFMOD_SOUND): FMOD_RESULT;
    function CreateDSP(description: PFMOD_DSP_DESCRIPTION; dsp: PPFMOD_DSP): FMOD_RESULT;
    function CreateDSPByType(type_: FMOD_DSP_TYPE; dsp: PPFMOD_DSP): FMOD_RESULT;
    function CreateChannelGroup(name: PAnsiChar; channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function CreateSoundGroup(name: PAnsiChar; soundgroup: PPFMOD_SOUNDGROUP): FMOD_RESULT;
    function CreateReverb3D(reverb: PPFMOD_REVERB3D): FMOD_RESULT;
    function PlaySound(sound: PFMOD_SOUND; channelgroup: PFMOD_CHANNELGROUP; paused: FMOD_BOOL; channel: PPFMOD_CHANNEL): FMOD_RESULT;
    function PlayDSP(dsp: PFMOD_DSP; channelgroup: PFMOD_CHANNELGROUP; paused: FMOD_BOOL; channel: PPFMOD_CHANNEL): FMOD_RESULT;
    function GetChannel(channelid: Integer; channel: PPFMOD_CHANNEL): FMOD_RESULT;
    function GetMasterChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function GetMasterSoundGroup(soundgroup: PPFMOD_SOUNDGROUP): FMOD_RESULT;
    function AttachChannelGroupToPort(portType: FMOD_PORT_TYPE; portIndex: FMOD_PORT_INDEX; channelgroup: PFMOD_CHANNELGROUP; passThru: FMOD_BOOL): FMOD_RESULT;
    function DetachChannelGroupFromPort(channelgroup: PFMOD_CHANNELGROUP): FMOD_RESULT;
    function SetReverbProperties(instance: Integer; prop: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function GetReverbProperties(instance: Integer; prop: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function LockDSP: FMOD_RESULT;
    function UnlockDSP: FMOD_RESULT;
    function GetRecordNumDrivers(numdrivers: PInteger; numconnected: PInteger): FMOD_RESULT;
    function GetRecordDriverInfo(id: Integer; name: PAnsiChar; namelen: Integer; guid: PFMOD_GUID; systemrate: PInteger; speakermode: PFMOD_SPEAKERMODE; speakermodechannels: PInteger; state: PFMOD_DRIVER_STATE): FMOD_RESULT;
    function GetRecordPosition(id: Integer; position: PCardinal): FMOD_RESULT;
    function RecordStart(id: Integer; sound: PFMOD_SOUND; loop: FMOD_BOOL): FMOD_RESULT;
    function RecordStop(id: Integer): FMOD_RESULT;
    function IsRecording(id: Integer; recording: PFMOD_BOOL): FMOD_RESULT;
    function CreateGeometry(maxpolygons: Integer; maxvertices: Integer; geometry: PPFMOD_GEOMETRY): FMOD_RESULT;
    function SetGeometrySettings(maxworldsize: Single): FMOD_RESULT;
    function GetGeometrySettings(maxworldsize: PSingle): FMOD_RESULT;
    function LoadGeometry(data: Pointer; datasize: Integer; geometry: PPFMOD_GEOMETRY): FMOD_RESULT;
    function GetGeometryOcclusion(listener: PFMOD_VECTOR; source: PFMOD_VECTOR; direct: PSingle; reverb: PSingle): FMOD_RESULT;
    function SetNetworkProxy(proxy: PAnsiChar): FMOD_RESULT;
    function GetNetworkProxy(proxy: PAnsiChar; proxylen: Integer): FMOD_RESULT;
    function SetNetworkTimeout(timeout: Integer): FMOD_RESULT;
    function GetNetworkTimeout(timeout: PInteger): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
  end;

  TFMOD_SOUND = class
  public
    FHandle: PFMOD_SOUND;
    function Release: FMOD_RESULT;
    function GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
    function Lock(offset: Cardinal; length: Cardinal; ptr1: PPointer; ptr2: PPointer; len1: PCardinal; len2: PCardinal): FMOD_RESULT;
    function Unlock(ptr1: Pointer; ptr2: Pointer; len1: Cardinal; len2: Cardinal): FMOD_RESULT;
    function SetDefaults(frequency: Single; priority: Integer): FMOD_RESULT;
    function GetDefaults(frequency: PSingle; priority: PInteger): FMOD_RESULT;
    function Set3DMinMaxDistance(min: Single; max: Single): FMOD_RESULT;
    function Get3DMinMaxDistance(min: PSingle; max: PSingle): FMOD_RESULT;
    function Set3DConeSettings(insideconeangle: Single; outsideconeangle: Single; outsidevolume: Single): FMOD_RESULT;
    function Get3DConeSettings(insideconeangle: PSingle; outsideconeangle: PSingle; outsidevolume: PSingle): FMOD_RESULT;
    function Set3DCustomRolloff(points: PFMOD_VECTOR; numpoints: Integer): FMOD_RESULT;
    function Get3DCustomRolloff(points: PPFMOD_VECTOR; numpoints: PInteger): FMOD_RESULT;
    function GetSubSound(index: Integer; subsound: PPFMOD_SOUND): FMOD_RESULT;
    function GetSubSoundParent(parentsound: PPFMOD_SOUND): FMOD_RESULT;
    function GetName(name: PAnsiChar; namelen: Integer): FMOD_RESULT;
    function GetLength(length: PCardinal; lengthtype: FMOD_TIMEUNIT): FMOD_RESULT;
    function GetFormat(type_: PFMOD_SOUND_TYPE; format: PFMOD_SOUND_FORMAT; channels: PInteger; bits: PInteger): FMOD_RESULT;
    function GetNumSubSounds(numsubsounds: PInteger): FMOD_RESULT;
    function GetNumTags(numtags: PInteger; numtagsupdated: PInteger): FMOD_RESULT;
    function GetTag(name: PAnsiChar; index: Integer; tag: PFMOD_TAG): FMOD_RESULT;
    function GetOpenState(openstate: PFMOD_OPENSTATE; percentbuffered: PCardinal; starving: PFMOD_BOOL; diskbusy: PFMOD_BOOL): FMOD_RESULT;
    function ReadData(buffer: Pointer; length: Cardinal; read: PCardinal): FMOD_RESULT;
    function SeekData(pcm: Cardinal): FMOD_RESULT;
    function SetSoundGroup(soundgroup: PFMOD_SOUNDGROUP): FMOD_RESULT;
    function GetSoundGroup(soundgroup: PPFMOD_SOUNDGROUP): FMOD_RESULT;
    function GetNumSyncPoints(numsyncpoints: PInteger): FMOD_RESULT;
    function GetSyncPoint(index: Integer; point: PPFMOD_SYNCPOINT): FMOD_RESULT;
    function GetSyncPointInfo(point: PFMOD_SYNCPOINT; name: PAnsiChar; namelen: Integer; offset: PCardinal; offsettype: FMOD_TIMEUNIT): FMOD_RESULT;
    function AddSyncPoint(offset: Cardinal; offsettype: FMOD_TIMEUNIT; name: PAnsiChar; point: PPFMOD_SYNCPOINT): FMOD_RESULT;
    function DeleteSyncPoint(point: PFMOD_SYNCPOINT): FMOD_RESULT;
    function SetMode(mode: FMOD_MODE): FMOD_RESULT;
    function GetMode(mode: PFMOD_MODE): FMOD_RESULT;
    function SetLoopCount(loopcount: Integer): FMOD_RESULT;
    function GetLoopCount(loopcount: PInteger): FMOD_RESULT;
    function SetLoopPoints(loopstart: Cardinal; loopstarttype: FMOD_TIMEUNIT; loopend: Cardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
    function GetLoopPoints(loopstart: PCardinal; loopstarttype: FMOD_TIMEUNIT; loopend: PCardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
    function GetMusicNumChannels(numchannels: PInteger): FMOD_RESULT;
    function SetMusicChannelVolume(channel: Integer; volume: Single): FMOD_RESULT;
    function GetMusicChannelVolume(channel: Integer; volume: PSingle): FMOD_RESULT;
    function SetMusicSpeed(speed: Single): FMOD_RESULT;
    function GetMusicSpeed(speed: PSingle): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
  end;

  TFMOD_CHANNEL = class
  public
    FHandle: PFMOD_CHANNEL;
    function GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
    function Stop: FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetVolume(volume: PSingle): FMOD_RESULT;
    function SetVolumeRamp(ramp: FMOD_BOOL): FMOD_RESULT;
    function GetVolumeRamp(ramp: PFMOD_BOOL): FMOD_RESULT;
    function GetAudibility(audibility: PSingle): FMOD_RESULT;
    function SetPitch(pitch: Single): FMOD_RESULT;
    function GetPitch(pitch: PSingle): FMOD_RESULT;
    function SetMute(mute: FMOD_BOOL): FMOD_RESULT;
    function GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
    function SetReverbProperties(instance: Integer; wet: Single): FMOD_RESULT;
    function GetReverbProperties(instance: Integer; wet: PSingle): FMOD_RESULT;
    function SetLowPassGain(gain: Single): FMOD_RESULT;
    function GetLowPassGain(gain: PSingle): FMOD_RESULT;
    function SetMode(mode: FMOD_MODE): FMOD_RESULT;
    function GetMode(mode: PFMOD_MODE): FMOD_RESULT;
    function SetCallback(callback: FMOD_CHANNELCONTROL_CALLBACK): FMOD_RESULT;
    function IsPlaying(isplaying_: PFMOD_BOOL): FMOD_RESULT;
    function SetPan(pan: Single): FMOD_RESULT;
    function SetMixLevelsOutput(frontleft: Single; frontright: Single; center: Single; lfe: Single; surroundleft: Single; surroundright: Single; backleft: Single; backright: Single): FMOD_RESULT;
    function SetMixLevelsInput(levels: PSingle; numlevels: Integer): FMOD_RESULT;
    function SetMixMatrix(matrix: PSingle; outchannels: Integer; inchannels: Integer; inchannel_hop: Integer): FMOD_RESULT;
    function GetMixMatrix(matrix: PSingle; outchannels: PInteger; inchannels: PInteger; inchannel_hop: Integer): FMOD_RESULT;
    function GetDSPClock(dspclock: PQWord; parentclock: PQWord): FMOD_RESULT;
    function SetDelay(dspclock_start: QWord; dspclock_end: QWord; stopchannels: FMOD_BOOL): FMOD_RESULT;
    function GetDelay(dspclock_start: PQWord; dspclock_end: PQWord; stopchannels: PFMOD_BOOL): FMOD_RESULT;
    function AddFadePoint(dspclock: QWord; volume: Single): FMOD_RESULT;
    function SetFadePointRamp(dspclock: QWord; volume: Single): FMOD_RESULT;
    function RemoveFadePoints(dspclock_start: QWord; dspclock_end: QWord): FMOD_RESULT;
    function GetFadePoints(numpoints: PCardinal; point_dspclock: PQWord; point_volume: PSingle): FMOD_RESULT;
    function GetDSP(index: Integer; dsp: PPFMOD_DSP): FMOD_RESULT;
    function AddDSP(index: Integer; dsp: PFMOD_DSP): FMOD_RESULT;
    function RemoveDSP(dsp: PFMOD_DSP): FMOD_RESULT;
    function GetNumDSPs(numdsps: PInteger): FMOD_RESULT;
    function SetDSPIndex(dsp: PFMOD_DSP; index: Integer): FMOD_RESULT;
    function GetDSPIndex(dsp: PFMOD_DSP; index: PInteger): FMOD_RESULT;
    function Set3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
    function Set3DMinMaxDistance(mindistance: Single; maxdistance: Single): FMOD_RESULT;
    function Get3DMinMaxDistance(mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
    function Set3DConeSettings(insideconeangle: Single; outsideconeangle: Single; outsidevolume: Single): FMOD_RESULT;
    function Get3DConeSettings(insideconeangle: PSingle; outsideconeangle: PSingle; outsidevolume: PSingle): FMOD_RESULT;
    function Set3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
    function Set3DCustomRolloff(points: PFMOD_VECTOR; numpoints: Integer): FMOD_RESULT;
    function Get3DCustomRolloff(points: PPFMOD_VECTOR; numpoints: PInteger): FMOD_RESULT;
    function Set3DOcclusion(directocclusion: Single; reverbocclusion: Single): FMOD_RESULT;
    function Get3DOcclusion(directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT;
    function Set3DSpread(angle: Single): FMOD_RESULT;
    function Get3DSpread(angle: PSingle): FMOD_RESULT;
    function Set3DLevel(level: Single): FMOD_RESULT;
    function Get3DLevel(level: PSingle): FMOD_RESULT;
    function Set3DDopplerLevel(level: Single): FMOD_RESULT;
    function Get3DDopplerLevel(level: PSingle): FMOD_RESULT;
    function Set3DDistanceFilter(custom: FMOD_BOOL; customLevel: Single; centerFreq: Single): FMOD_RESULT;
    function Get3DDistanceFilter(custom: PFMOD_BOOL; customLevel: PSingle; centerFreq: PSingle): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function SetFrequency(frequency: Single): FMOD_RESULT;
    function GetFrequency(frequency: PSingle): FMOD_RESULT;
    function SetPriority(priority: Integer): FMOD_RESULT;
    function GetPriority(priority: PInteger): FMOD_RESULT;
    function SetPosition(position: Cardinal; postype: FMOD_TIMEUNIT): FMOD_RESULT;
    function GetPosition(position: PCardinal; postype: FMOD_TIMEUNIT): FMOD_RESULT;
    function SetChannelGroup(channelgroup: PFMOD_CHANNELGROUP): FMOD_RESULT;
    function GetChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function SetLoopCount(loopcount: Integer): FMOD_RESULT;
    function GetLoopCount(loopcount: PInteger): FMOD_RESULT;
    function SetLoopPoints(loopstart: Cardinal; loopstarttype: FMOD_TIMEUNIT; loopend: Cardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
    function GetLoopPoints(loopstart: PCardinal; loopstarttype: FMOD_TIMEUNIT; loopend: PCardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
    function IsVirtual(isvirtual_: PFMOD_BOOL): FMOD_RESULT;
    function GetCurrentSound(sound: PPFMOD_SOUND): FMOD_RESULT;
    function GetIndex(index: PInteger): FMOD_RESULT;
  end;

  TFMOD_CHANNELGROUP = class
  public
    FHandle: PFMOD_CHANNELGROUP;
    function GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
    function Stop: FMOD_RESULT;
    function SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
    function GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetVolume(volume: PSingle): FMOD_RESULT;
    function SetVolumeRamp(ramp: FMOD_BOOL): FMOD_RESULT;
    function GetVolumeRamp(ramp: PFMOD_BOOL): FMOD_RESULT;
    function GetAudibility(audibility: PSingle): FMOD_RESULT;
    function SetPitch(pitch: Single): FMOD_RESULT;
    function GetPitch(pitch: PSingle): FMOD_RESULT;
    function SetMute(mute: FMOD_BOOL): FMOD_RESULT;
    function GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
    function SetReverbProperties(instance: Integer; wet: Single): FMOD_RESULT;
    function GetReverbProperties(instance: Integer; wet: PSingle): FMOD_RESULT;
    function SetLowPassGain(gain: Single): FMOD_RESULT;
    function GetLowPassGain(gain: PSingle): FMOD_RESULT;
    function SetMode(mode: FMOD_MODE): FMOD_RESULT;
    function GetMode(mode: PFMOD_MODE): FMOD_RESULT;
    function SetCallback(callback: FMOD_CHANNELCONTROL_CALLBACK): FMOD_RESULT;
    function IsPlaying(isplaying_: PFMOD_BOOL): FMOD_RESULT;
    function SetPan(pan: Single): FMOD_RESULT;
    function SetMixLevelsOutput(frontleft: Single; frontright: Single; center: Single; lfe: Single; surroundleft: Single; surroundright: Single; backleft: Single; backright: Single): FMOD_RESULT;
    function SetMixLevelsInput(levels: PSingle; numlevels: Integer): FMOD_RESULT;
    function SetMixMatrix(matrix: PSingle; outchannels: Integer; inchannels: Integer; inchannel_hop: Integer): FMOD_RESULT;
    function GetMixMatrix(matrix: PSingle; outchannels: PInteger; inchannels: PInteger; inchannel_hop: Integer): FMOD_RESULT;
    function GetDSPClock(dspclock: PQWord; parentclock: PQWord): FMOD_RESULT;
    function SetDelay(dspclock_start: QWord; dspclock_end: QWord; stopchannels: FMOD_BOOL): FMOD_RESULT;
    function GetDelay(dspclock_start: PQWord; dspclock_end: PQWord; stopchannels: PFMOD_BOOL): FMOD_RESULT;
    function AddFadePoint(dspclock: QWord; volume: Single): FMOD_RESULT;
    function SetFadePointRamp(dspclock: QWord; volume: Single): FMOD_RESULT;
    function RemoveFadePoints(dspclock_start: QWord; dspclock_end: QWord): FMOD_RESULT;
    function GetFadePoints(numpoints: PCardinal; point_dspclock: PQWord; point_volume: PSingle): FMOD_RESULT;
    function GetDSP(index: Integer; dsp: PPFMOD_DSP): FMOD_RESULT;
    function AddDSP(index: Integer; dsp: PFMOD_DSP): FMOD_RESULT;
    function RemoveDSP(dsp: PFMOD_DSP): FMOD_RESULT;
    function GetNumDSPs(numdsps: PInteger): FMOD_RESULT;
    function SetDSPIndex(dsp: PFMOD_DSP; index: Integer): FMOD_RESULT;
    function GetDSPIndex(dsp: PFMOD_DSP; index: PInteger): FMOD_RESULT;
    function Set3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
    function Set3DMinMaxDistance(mindistance: Single; maxdistance: Single): FMOD_RESULT;
    function Get3DMinMaxDistance(mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
    function Set3DConeSettings(insideconeangle: Single; outsideconeangle: Single; outsidevolume: Single): FMOD_RESULT;
    function Get3DConeSettings(insideconeangle: PSingle; outsideconeangle: PSingle; outsidevolume: PSingle): FMOD_RESULT;
    function Set3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
    function Get3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
    function Set3DCustomRolloff(points: PFMOD_VECTOR; numpoints: Integer): FMOD_RESULT;
    function Get3DCustomRolloff(points: PPFMOD_VECTOR; numpoints: PInteger): FMOD_RESULT;
    function Set3DOcclusion(directocclusion: Single; reverbocclusion: Single): FMOD_RESULT;
    function Get3DOcclusion(directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT;
    function Set3DSpread(angle: Single): FMOD_RESULT;
    function Get3DSpread(angle: PSingle): FMOD_RESULT;
    function Set3DLevel(level: Single): FMOD_RESULT;
    function Get3DLevel(level: PSingle): FMOD_RESULT;
    function Set3DDopplerLevel(level: Single): FMOD_RESULT;
    function Get3DDopplerLevel(level: PSingle): FMOD_RESULT;
    function Set3DDistanceFilter(custom: FMOD_BOOL; customLevel: Single; centerFreq: Single): FMOD_RESULT;
    function Get3DDistanceFilter(custom: PFMOD_BOOL; customLevel: PSingle; centerFreq: PSingle): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function Release: FMOD_RESULT;
    function AddGroup(group: PFMOD_CHANNELGROUP; propagatedspclock: FMOD_BOOL; connection: PPFMOD_DSPCONNECTION): FMOD_RESULT;
    function GetNumGroups(numgroups: PInteger): FMOD_RESULT;
    function GetGroup(index: Integer; group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function GetParentGroup(group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
    function GetName(name: PAnsiChar; namelen: Integer): FMOD_RESULT;
    function GetNumChannels(numchannels: PInteger): FMOD_RESULT;
    function GetChannel(index: Integer; channel: PPFMOD_CHANNEL): FMOD_RESULT;
  end;

  TFMOD_SOUNDGROUP = class
  public
    FHandle: PFMOD_SOUNDGROUP;
    function Release: FMOD_RESULT;
    function GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
    function SetMaxAudible(maxaudible: Integer): FMOD_RESULT;
    function GetMaxAudible(maxaudible: PInteger): FMOD_RESULT;
    function SetMaxAudibleBehavior(behavior: FMOD_SOUNDGROUP_BEHAVIOR): FMOD_RESULT;
    function GetMaxAudibleBehavior(behavior: PFMOD_SOUNDGROUP_BEHAVIOR): FMOD_RESULT;
    function SetMuteFadeSpeed(speed: Single): FMOD_RESULT;
    function GetMuteFadeSpeed(speed: PSingle): FMOD_RESULT;
    function SetVolume(volume: Single): FMOD_RESULT;
    function GetVolume(volume: PSingle): FMOD_RESULT;
    function Stop: FMOD_RESULT;
    function GetName(name: PAnsiChar; namelen: Integer): FMOD_RESULT;
    function GetNumSounds(numsounds: PInteger): FMOD_RESULT;
    function GetSound(index: Integer; sound: PPFMOD_SOUND): FMOD_RESULT;
    function GetNumPlaying(numplaying: PInteger): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
  end;

  TFMOD_DSP = class
  public
    FHandle: PFMOD_DSP;
    function Release: FMOD_RESULT;
    function GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
    function AddInput(input: PFMOD_DSP; connection: PPFMOD_DSPCONNECTION; type_: FMOD_DSPCONNECTION_TYPE): FMOD_RESULT;
    function DisconnectFrom(target: PFMOD_DSP; connection: PFMOD_DSPCONNECTION): FMOD_RESULT;
    function DisconnectAll(inputs: FMOD_BOOL; outputs: FMOD_BOOL): FMOD_RESULT;
    function GetNumInputs(numinputs: PInteger): FMOD_RESULT;
    function GetNumOutputs(numoutputs: PInteger): FMOD_RESULT;
    function GetInput(index: Integer; input: PPFMOD_DSP; inputconnection: PPFMOD_DSPCONNECTION): FMOD_RESULT;
    function GetOutput(index: Integer; output: PPFMOD_DSP; outputconnection: PPFMOD_DSPCONNECTION): FMOD_RESULT;
    function SetActive(active: FMOD_BOOL): FMOD_RESULT;
    function GetActive(active: PFMOD_BOOL): FMOD_RESULT;
    function SetBypass(bypass: FMOD_BOOL): FMOD_RESULT;
    function GetBypass(bypass: PFMOD_BOOL): FMOD_RESULT;
    function SetWetDryMix(prewet: Single; postwet: Single; dry: Single): FMOD_RESULT;
    function GetWetDryMix(prewet: PSingle; postwet: PSingle; dry: PSingle): FMOD_RESULT;
    function SetChannelFormat(channelmask: FMOD_CHANNELMASK; numchannels: Integer; source_speakermode: FMOD_SPEAKERMODE): FMOD_RESULT;
    function GetChannelFormat(channelmask: PFMOD_CHANNELMASK; numchannels: PInteger; source_speakermode: PFMOD_SPEAKERMODE): FMOD_RESULT;
    function GetOutputChannelFormat(inmask: FMOD_CHANNELMASK; inchannels: Integer; inspeakermode: FMOD_SPEAKERMODE; outmask: PFMOD_CHANNELMASK; outchannels: PInteger; outspeakermode: PFMOD_SPEAKERMODE): FMOD_RESULT;
    function Reset: FMOD_RESULT;
    function SetParameterFloat(index: Integer; value: Single): FMOD_RESULT;
    function SetParameterInt(index: Integer; value: Integer): FMOD_RESULT;
    function SetParameterBool(index: Integer; value: FMOD_BOOL): FMOD_RESULT;
    function SetParameterData(index: Integer; data: Pointer; length: Cardinal): FMOD_RESULT;
    function GetParameterFloat(index: Integer; value: PSingle; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
    function GetParameterInt(index: Integer; value: PInteger; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
    function GetParameterBool(index: Integer; value: PFMOD_BOOL; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
    function GetParameterData(index: Integer; data: PPointer; length: PCardinal; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
    function GetNumParameters(numparams: PInteger): FMOD_RESULT;
    function GetParameterInfo(index: Integer; desc: PPFMOD_DSP_PARAMETER_DESC): FMOD_RESULT;
    function GetDataParameterIndex(datatype: Integer; index: PInteger): FMOD_RESULT;
    function ShowConfigDialog(hwnd: Pointer; show: FMOD_BOOL): FMOD_RESULT;
    function GetInfo(name: PAnsiChar; version: PCardinal; channels: PInteger; configwidth: PInteger; configheight: PInteger): FMOD_RESULT;
    function GetType(type_: PFMOD_DSP_TYPE): FMOD_RESULT;
    function GetIdle(idle: PFMOD_BOOL): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
    function SetMeteringEnabled(inputEnabled: FMOD_BOOL; outputEnabled: FMOD_BOOL): FMOD_RESULT;
    function GetMeteringEnabled(inputEnabled: PFMOD_BOOL; outputEnabled: PFMOD_BOOL): FMOD_RESULT;
    function GetMeteringInfo(inputInfo: PFMOD_DSP_METERING_INFO; outputInfo: PFMOD_DSP_METERING_INFO): FMOD_RESULT;
    function GetCPUUsage(exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT;
  end;

  TFMOD_DSPCONNECTION = class
  public
    FHandle: PFMOD_DSPCONNECTION;
    function GetInput(input: PPFMOD_DSP): FMOD_RESULT;
    function GetOutput(output: PPFMOD_DSP): FMOD_RESULT;
    function SetMix(volume: Single): FMOD_RESULT;
    function GetMix(volume: PSingle): FMOD_RESULT;
    function SetMixMatrix(matrix: PSingle; outchannels: Integer; inchannels: Integer; inchannel_hop: Integer): FMOD_RESULT;
    function GetMixMatrix(matrix: PSingle; outchannels: PInteger; inchannels: PInteger; inchannel_hop: Integer): FMOD_RESULT;
    function GetType(type_: PFMOD_DSPCONNECTION_TYPE): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
  end;

  TFMOD_GEOMETRY = class
  public
    FHandle: PFMOD_GEOMETRY;
    function Release: FMOD_RESULT;
    function AddPolygon(directocclusion: Single; reverbocclusion: Single; doublesided: FMOD_BOOL; numvertices: Integer; vertices: PFMOD_VECTOR; polygonindex: PInteger): FMOD_RESULT;
    function GetNumPolygons(numpolygons: PInteger): FMOD_RESULT;
    function GetMaxPolygons(maxpolygons: PInteger; maxvertices: PInteger): FMOD_RESULT;
    function GetPolygonNumVertices(index: Integer; numvertices: PInteger): FMOD_RESULT;
    function SetPolygonVertex(index: Integer; vertexindex: Integer; vertex: PFMOD_VECTOR): FMOD_RESULT;
    function GetPolygonVertex(index: Integer; vertexindex: Integer; vertex: PFMOD_VECTOR): FMOD_RESULT;
    function SetPolygonAttributes(index: Integer; directocclusion: Single; reverbocclusion: Single; doublesided: FMOD_BOOL): FMOD_RESULT;
    function GetPolygonAttributes(index: Integer; directocclusion: PSingle; reverbocclusion: PSingle; doublesided: PFMOD_BOOL): FMOD_RESULT;
    function SetActive(active: FMOD_BOOL): FMOD_RESULT;
    function GetActive(active: PFMOD_BOOL): FMOD_RESULT;
    function SetRotation(forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
    function GetRotation(forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
    function SetPosition(position: PFMOD_VECTOR): FMOD_RESULT;
    function GetPosition(position: PFMOD_VECTOR): FMOD_RESULT;
    function SetScale(scale: PFMOD_VECTOR): FMOD_RESULT;
    function GetScale(scale: PFMOD_VECTOR): FMOD_RESULT;
    function Save(data: Pointer; datasize: PInteger): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
  end;

  TFMOD_REVERB3D = class
  public
    FHandle: PFMOD_REVERB3D;
    function Release: FMOD_RESULT;
    function Set3DAttributes(position: PFMOD_VECTOR; mindistance: Single; maxdistance: Single): FMOD_RESULT;
    function Get3DAttributes(position: PFMOD_VECTOR; mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
    function SetProperties(properties: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function GetProperties(properties: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
    function SetActive(active: FMOD_BOOL): FMOD_RESULT;
    function GetActive(active: PFMOD_BOOL): FMOD_RESULT;
    function SetUserData(userdata: Pointer): FMOD_RESULT;
    function GetUserData(userdata: PPointer): FMOD_RESULT;
  end;

implementation

class function TFMOD_SYSTEM.Make(out Inst: TFMOD_SYSTEM): FMOD_RESULT;
var
  h: PFMOD_SYSTEM;
begin
  Result := FMOD_System_Create(@h);
  if Result = FMOD_OK then
  begin
    Inst := TFMOD_SYSTEM.Create;
    Inst.FHandle := h;
  end
  else
    Inst := nil;
end;

function TFMOD_SYSTEM.Release: FMOD_RESULT;
begin
  Result := FMOD_System_Release(FHandle);
end;

function TFMOD_SYSTEM.SetOutput(output: FMOD_OUTPUTTYPE): FMOD_RESULT;
begin
  Result := FMOD_System_SetOutput(FHandle, output);
end;

function TFMOD_SYSTEM.GetOutput(output: PFMOD_OUTPUTTYPE): FMOD_RESULT;
begin
  Result := FMOD_System_GetOutput(FHandle, output);
end;

function TFMOD_SYSTEM.GetNumDrivers(numdrivers: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetNumDrivers(FHandle, numdrivers);
end;

function TFMOD_SYSTEM.GetDriverInfo(id: Integer; name: PAnsiChar; namelen: Integer; guid: PFMOD_GUID; systemrate: PInteger; speakermode: PFMOD_SPEAKERMODE; speakermodechannels: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetDriverInfo(FHandle, id, name, namelen, guid, systemrate, speakermode, speakermodechannels);
end;

function TFMOD_SYSTEM.SetDriver(driver: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_SetDriver(FHandle, driver);
end;

function TFMOD_SYSTEM.GetDriver(driver: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetDriver(FHandle, driver);
end;

function TFMOD_SYSTEM.SetSoftwareChannels(numsoftwarechannels: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_SetSoftwareChannels(FHandle, numsoftwarechannels);
end;

function TFMOD_SYSTEM.GetSoftwareChannels(numsoftwarechannels: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetSoftwareChannels(FHandle, numsoftwarechannels);
end;

function TFMOD_SYSTEM.SetSoftwareFormat(samplerate: Integer; speakermode: FMOD_SPEAKERMODE; numrawspeakers: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_SetSoftwareFormat(FHandle, samplerate, speakermode, numrawspeakers);
end;

function TFMOD_SYSTEM.GetSoftwareFormat(samplerate: PInteger; speakermode: PFMOD_SPEAKERMODE; numrawspeakers: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetSoftwareFormat(FHandle, samplerate, speakermode, numrawspeakers);
end;

function TFMOD_SYSTEM.SetDSPBufferSize(bufferlength: Cardinal; numbuffers: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_SetDSPBufferSize(FHandle, bufferlength, numbuffers);
end;

function TFMOD_SYSTEM.GetDSPBufferSize(bufferlength: PCardinal; numbuffers: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetDSPBufferSize(FHandle, bufferlength, numbuffers);
end;

function TFMOD_SYSTEM.SetFileSystem(useropen: FMOD_FILE_OPEN_CALLBACK; userclose: FMOD_FILE_CLOSE_CALLBACK; userread: FMOD_FILE_READ_CALLBACK; userseek: FMOD_FILE_SEEK_CALLBACK; userasyncread: FMOD_FILE_ASYNCREAD_CALLBACK; userasynccancel: FMOD_FILE_ASYNCCANCEL_CALLBACK; blockalign: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_SetFileSystem(FHandle, useropen, userclose, userread, userseek, userasyncread, userasynccancel, blockalign);
end;

function TFMOD_SYSTEM.AttachFileSystem(useropen: FMOD_FILE_OPEN_CALLBACK; userclose: FMOD_FILE_CLOSE_CALLBACK; userread: FMOD_FILE_READ_CALLBACK; userseek: FMOD_FILE_SEEK_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_System_AttachFileSystem(FHandle, useropen, userclose, userread, userseek);
end;

function TFMOD_SYSTEM.SetAdvancedSettings(settings: PFMOD_ADVANCEDSETTINGS): FMOD_RESULT;
begin
  Result := FMOD_System_SetAdvancedSettings(FHandle, settings);
end;

function TFMOD_SYSTEM.GetAdvancedSettings(settings: PFMOD_ADVANCEDSETTINGS): FMOD_RESULT;
begin
  Result := FMOD_System_GetAdvancedSettings(FHandle, settings);
end;

function TFMOD_SYSTEM.SetCallback(callback: FMOD_SYSTEM_CALLBACK; callbackmask: FMOD_SYSTEM_CALLBACK_TYPE): FMOD_RESULT;
begin
  Result := FMOD_System_SetCallback(FHandle, callback, callbackmask);
end;

function TFMOD_SYSTEM.SetPluginPath(path: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_System_SetPluginPath(FHandle, path);
end;

function TFMOD_SYSTEM.LoadPlugin(filename: PAnsiChar; handle: PCardinal; priority: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_System_LoadPlugin(FHandle, filename, handle, priority);
end;

function TFMOD_SYSTEM.UnloadPlugin(handle: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_System_UnloadPlugin(FHandle, handle);
end;

function TFMOD_SYSTEM.GetNumNestedPlugins(handle: Cardinal; count: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetNumNestedPlugins(FHandle, handle, count);
end;

function TFMOD_SYSTEM.GetNestedPlugin(handle: Cardinal; index: Integer; nestedhandle: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_GetNestedPlugin(FHandle, handle, index, nestedhandle);
end;

function TFMOD_SYSTEM.GetNumPlugins(plugintype: FMOD_PLUGINTYPE; numplugins: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetNumPlugins(FHandle, plugintype, numplugins);
end;

function TFMOD_SYSTEM.GetPluginHandle(plugintype: FMOD_PLUGINTYPE; index: Integer; handle: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_GetPluginHandle(FHandle, plugintype, index, handle);
end;

function TFMOD_SYSTEM.GetPluginInfo(handle: Cardinal; plugintype: PFMOD_PLUGINTYPE; name: PAnsiChar; namelen: Integer; version: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_GetPluginInfo(FHandle, handle, plugintype, name, namelen, version);
end;

function TFMOD_SYSTEM.SetOutputByPlugin(handle: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_System_SetOutputByPlugin(FHandle, handle);
end;

function TFMOD_SYSTEM.GetOutputByPlugin(handle: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_GetOutputByPlugin(FHandle, handle);
end;

function TFMOD_SYSTEM.CreateDSPByPlugin(handle: Cardinal; dsp: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_System_CreateDSPByPlugin(FHandle, handle, dsp);
end;

function TFMOD_SYSTEM.GetDSPInfoByPlugin(handle: Cardinal; description: PPFMOD_DSP_DESCRIPTION): FMOD_RESULT;
begin
  Result := FMOD_System_GetDSPInfoByPlugin(FHandle, handle, description);
end;

function TFMOD_SYSTEM.RegisterCodec(description: PFMOD_CODEC_DESCRIPTION; handle: PCardinal; priority: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_System_RegisterCodec(FHandle, description, handle, priority);
end;

function TFMOD_SYSTEM.RegisterDSP(description: PFMOD_DSP_DESCRIPTION; handle: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_RegisterDSP(FHandle, description, handle);
end;

function TFMOD_SYSTEM.RegisterOutput(description: PFMOD_OUTPUT_DESCRIPTION; handle: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_RegisterOutput(FHandle, description, handle);
end;

function TFMOD_SYSTEM.Init(maxchannels: Integer; flags: FMOD_INITFLAGS; extradriverdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_System_Init(FHandle, maxchannels, flags, extradriverdata);
end;

function TFMOD_SYSTEM.Close: FMOD_RESULT;
begin
  Result := FMOD_System_Close(FHandle);
end;

function TFMOD_SYSTEM.Update: FMOD_RESULT;
begin
  Result := FMOD_System_Update(FHandle);
end;

function TFMOD_SYSTEM.SetSpeakerPosition(speaker: FMOD_SPEAKER; x: Single; y: Single; active: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_System_SetSpeakerPosition(FHandle, speaker, x, y, active);
end;

function TFMOD_SYSTEM.GetSpeakerPosition(speaker: FMOD_SPEAKER; x: PSingle; y: PSingle; active: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_System_GetSpeakerPosition(FHandle, speaker, x, y, active);
end;

function TFMOD_SYSTEM.SetStreamBufferSize(filebuffersize: Cardinal; filebuffersizetype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_System_SetStreamBufferSize(FHandle, filebuffersize, filebuffersizetype);
end;

function TFMOD_SYSTEM.GetStreamBufferSize(filebuffersize: PCardinal; filebuffersizetype: PFMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_System_GetStreamBufferSize(FHandle, filebuffersize, filebuffersizetype);
end;

function TFMOD_SYSTEM.Set3DSettings(dopplerscale: Single; distancefactor: Single; rolloffscale: Single): FMOD_RESULT;
begin
  Result := FMOD_System_Set3DSettings(FHandle, dopplerscale, distancefactor, rolloffscale);
end;

function TFMOD_SYSTEM.Get3DSettings(dopplerscale: PSingle; distancefactor: PSingle; rolloffscale: PSingle): FMOD_RESULT;
begin
  Result := FMOD_System_Get3DSettings(FHandle, dopplerscale, distancefactor, rolloffscale);
end;

function TFMOD_SYSTEM.Set3DNumListeners(numlisteners: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_Set3DNumListeners(FHandle, numlisteners);
end;

function TFMOD_SYSTEM.Get3DNumListeners(numlisteners: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_Get3DNumListeners(FHandle, numlisteners);
end;

function TFMOD_SYSTEM.Set3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_System_Set3DListenerAttributes(FHandle, listener, pos, vel, forward, up);
end;

function TFMOD_SYSTEM.Get3DListenerAttributes(listener: Integer; pos: PFMOD_VECTOR; vel: PFMOD_VECTOR; forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_System_Get3DListenerAttributes(FHandle, listener, pos, vel, forward, up);
end;

function TFMOD_SYSTEM.Set3DRolloffCallback(callback: FMOD_3D_ROLLOFF_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_System_Set3DRolloffCallback(FHandle, callback);
end;

function TFMOD_SYSTEM.MixerSuspend: FMOD_RESULT;
begin
  Result := FMOD_System_MixerSuspend(FHandle);
end;

function TFMOD_SYSTEM.MixerResume: FMOD_RESULT;
begin
  Result := FMOD_System_MixerResume(FHandle);
end;

function TFMOD_SYSTEM.GetDefaultMixMatrix(sourcespeakermode: FMOD_SPEAKERMODE; targetspeakermode: FMOD_SPEAKERMODE; matrix: PSingle; matrixhop: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_GetDefaultMixMatrix(FHandle, sourcespeakermode, targetspeakermode, matrix, matrixhop);
end;

function TFMOD_SYSTEM.GetSpeakerModeChannels(mode: FMOD_SPEAKERMODE; channels: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetSpeakerModeChannels(FHandle, mode, channels);
end;

function TFMOD_SYSTEM.GetVersion(version: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_GetVersion(FHandle, version);
end;

function TFMOD_SYSTEM.GetOutputHandle(handle: PPointer): FMOD_RESULT;
begin
  Result := FMOD_System_GetOutputHandle(FHandle, handle);
end;

function TFMOD_SYSTEM.GetChannelsPlaying(channels: PInteger; realchannels: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetChannelsPlaying(FHandle, channels, realchannels);
end;

function TFMOD_SYSTEM.GetCPUUsage(dsp: PSingle; stream: PSingle; geometry: PSingle; update_: PSingle; total: PSingle): FMOD_RESULT;
begin
  Result := FMOD_System_GetCPUUsage(FHandle, dsp, stream, geometry, update_, total);
end;

function TFMOD_SYSTEM.GetFileUsage(sampleBytesRead: PInt64; streamBytesRead: PInt64; otherBytesRead: PInt64): FMOD_RESULT;
begin
  Result := FMOD_System_GetFileUsage(FHandle, sampleBytesRead, streamBytesRead, otherBytesRead);
end;

function TFMOD_SYSTEM.CreateSound(name_or_data: PAnsiChar; mode: FMOD_MODE; exinfo: PFMOD_CREATESOUNDEXINFO; sound: PPFMOD_SOUND): FMOD_RESULT;
begin
  Result := FMOD_System_CreateSound(FHandle, name_or_data, mode, exinfo, sound);
end;

function TFMOD_SYSTEM.CreateStream(name_or_data: PAnsiChar; mode: FMOD_MODE; exinfo: PFMOD_CREATESOUNDEXINFO; sound: PPFMOD_SOUND): FMOD_RESULT;
begin
  Result := FMOD_System_CreateStream(FHandle, name_or_data, mode, exinfo, sound);
end;

function TFMOD_SYSTEM.CreateDSP(description: PFMOD_DSP_DESCRIPTION; dsp: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_System_CreateDSP(FHandle, description, dsp);
end;

function TFMOD_SYSTEM.CreateDSPByType(type_: FMOD_DSP_TYPE; dsp: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_System_CreateDSPByType(FHandle, type_, dsp);
end;

function TFMOD_SYSTEM.CreateChannelGroup(name: PAnsiChar; channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_System_CreateChannelGroup(FHandle, name, channelgroup);
end;

function TFMOD_SYSTEM.CreateSoundGroup(name: PAnsiChar; soundgroup: PPFMOD_SOUNDGROUP): FMOD_RESULT;
begin
  Result := FMOD_System_CreateSoundGroup(FHandle, name, soundgroup);
end;

function TFMOD_SYSTEM.CreateReverb3D(reverb: PPFMOD_REVERB3D): FMOD_RESULT;
begin
  Result := FMOD_System_CreateReverb3D(FHandle, reverb);
end;

function TFMOD_SYSTEM.PlaySound(sound: PFMOD_SOUND; channelgroup: PFMOD_CHANNELGROUP; paused: FMOD_BOOL; channel: PPFMOD_CHANNEL): FMOD_RESULT;
begin
  Result := FMOD_System_PlaySound(FHandle, sound, channelgroup, paused, channel);
end;

function TFMOD_SYSTEM.PlayDSP(dsp: PFMOD_DSP; channelgroup: PFMOD_CHANNELGROUP; paused: FMOD_BOOL; channel: PPFMOD_CHANNEL): FMOD_RESULT;
begin
  Result := FMOD_System_PlayDSP(FHandle, dsp, channelgroup, paused, channel);
end;

function TFMOD_SYSTEM.GetChannel(channelid: Integer; channel: PPFMOD_CHANNEL): FMOD_RESULT;
begin
  Result := FMOD_System_GetChannel(FHandle, channelid, channel);
end;

function TFMOD_SYSTEM.GetMasterChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_System_GetMasterChannelGroup(FHandle, channelgroup);
end;

function TFMOD_SYSTEM.GetMasterSoundGroup(soundgroup: PPFMOD_SOUNDGROUP): FMOD_RESULT;
begin
  Result := FMOD_System_GetMasterSoundGroup(FHandle, soundgroup);
end;

function TFMOD_SYSTEM.AttachChannelGroupToPort(portType: FMOD_PORT_TYPE; portIndex: FMOD_PORT_INDEX; channelgroup: PFMOD_CHANNELGROUP; passThru: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_System_AttachChannelGroupToPort(FHandle, portType, portIndex, channelgroup, passThru);
end;

function TFMOD_SYSTEM.DetachChannelGroupFromPort(channelgroup: PFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_System_DetachChannelGroupFromPort(FHandle, channelgroup);
end;

function TFMOD_SYSTEM.SetReverbProperties(instance: Integer; prop: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_System_SetReverbProperties(FHandle, instance, prop);
end;

function TFMOD_SYSTEM.GetReverbProperties(instance: Integer; prop: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_System_GetReverbProperties(FHandle, instance, prop);
end;

function TFMOD_SYSTEM.LockDSP: FMOD_RESULT;
begin
  Result := FMOD_System_LockDSP(FHandle);
end;

function TFMOD_SYSTEM.UnlockDSP: FMOD_RESULT;
begin
  Result := FMOD_System_UnlockDSP(FHandle);
end;

function TFMOD_SYSTEM.GetRecordNumDrivers(numdrivers: PInteger; numconnected: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetRecordNumDrivers(FHandle, numdrivers, numconnected);
end;

function TFMOD_SYSTEM.GetRecordDriverInfo(id: Integer; name: PAnsiChar; namelen: Integer; guid: PFMOD_GUID; systemrate: PInteger; speakermode: PFMOD_SPEAKERMODE; speakermodechannels: PInteger; state: PFMOD_DRIVER_STATE): FMOD_RESULT;
begin
  Result := FMOD_System_GetRecordDriverInfo(FHandle, id, name, namelen, guid, systemrate, speakermode, speakermodechannels, state);
end;

function TFMOD_SYSTEM.GetRecordPosition(id: Integer; position: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_System_GetRecordPosition(FHandle, id, position);
end;

function TFMOD_SYSTEM.RecordStart(id: Integer; sound: PFMOD_SOUND; loop: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_System_RecordStart(FHandle, id, sound, loop);
end;

function TFMOD_SYSTEM.RecordStop(id: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_RecordStop(FHandle, id);
end;

function TFMOD_SYSTEM.IsRecording(id: Integer; recording: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_System_IsRecording(FHandle, id, recording);
end;

function TFMOD_SYSTEM.CreateGeometry(maxpolygons: Integer; maxvertices: Integer; geometry: PPFMOD_GEOMETRY): FMOD_RESULT;
begin
  Result := FMOD_System_CreateGeometry(FHandle, maxpolygons, maxvertices, geometry);
end;

function TFMOD_SYSTEM.SetGeometrySettings(maxworldsize: Single): FMOD_RESULT;
begin
  Result := FMOD_System_SetGeometrySettings(FHandle, maxworldsize);
end;

function TFMOD_SYSTEM.GetGeometrySettings(maxworldsize: PSingle): FMOD_RESULT;
begin
  Result := FMOD_System_GetGeometrySettings(FHandle, maxworldsize);
end;

function TFMOD_SYSTEM.LoadGeometry(data: Pointer; datasize: Integer; geometry: PPFMOD_GEOMETRY): FMOD_RESULT;
begin
  Result := FMOD_System_LoadGeometry(FHandle, data, datasize, geometry);
end;

function TFMOD_SYSTEM.GetGeometryOcclusion(listener: PFMOD_VECTOR; source: PFMOD_VECTOR; direct: PSingle; reverb: PSingle): FMOD_RESULT;
begin
  Result := FMOD_System_GetGeometryOcclusion(FHandle, listener, source, direct, reverb);
end;

function TFMOD_SYSTEM.SetNetworkProxy(proxy: PAnsiChar): FMOD_RESULT;
begin
  Result := FMOD_System_SetNetworkProxy(FHandle, proxy);
end;

function TFMOD_SYSTEM.GetNetworkProxy(proxy: PAnsiChar; proxylen: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_GetNetworkProxy(FHandle, proxy, proxylen);
end;

function TFMOD_SYSTEM.SetNetworkTimeout(timeout: Integer): FMOD_RESULT;
begin
  Result := FMOD_System_SetNetworkTimeout(FHandle, timeout);
end;

function TFMOD_SYSTEM.GetNetworkTimeout(timeout: PInteger): FMOD_RESULT;
begin
  Result := FMOD_System_GetNetworkTimeout(FHandle, timeout);
end;

function TFMOD_SYSTEM.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_System_SetUserData(FHandle, userdata);
end;

function TFMOD_SYSTEM.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_System_GetUserData(FHandle, userdata);
end;

function TFMOD_SOUND.Release: FMOD_RESULT;
begin
  Result := FMOD_Sound_Release(FHandle);
end;

function TFMOD_SOUND.GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetSystemObject(FHandle, system);
end;

function TFMOD_SOUND.Lock(offset: Cardinal; length: Cardinal; ptr1: PPointer; ptr2: PPointer; len1: PCardinal; len2: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_Sound_Lock(FHandle, offset, length, ptr1, ptr2, len1, len2);
end;

function TFMOD_SOUND.Unlock(ptr1: Pointer; ptr2: Pointer; len1: Cardinal; len2: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_Sound_Unlock(FHandle, ptr1, ptr2, len1, len2);
end;

function TFMOD_SOUND.SetDefaults(frequency: Single; priority: Integer): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetDefaults(FHandle, frequency, priority);
end;

function TFMOD_SOUND.GetDefaults(frequency: PSingle; priority: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetDefaults(FHandle, frequency, priority);
end;

function TFMOD_SOUND.Set3DMinMaxDistance(min: Single; max: Single): FMOD_RESULT;
begin
  Result := FMOD_Sound_Set3DMinMaxDistance(FHandle, min, max);
end;

function TFMOD_SOUND.Get3DMinMaxDistance(min: PSingle; max: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Sound_Get3DMinMaxDistance(FHandle, min, max);
end;

function TFMOD_SOUND.Set3DConeSettings(insideconeangle: Single; outsideconeangle: Single; outsidevolume: Single): FMOD_RESULT;
begin
  Result := FMOD_Sound_Set3DConeSettings(FHandle, insideconeangle, outsideconeangle, outsidevolume);
end;

function TFMOD_SOUND.Get3DConeSettings(insideconeangle: PSingle; outsideconeangle: PSingle; outsidevolume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Sound_Get3DConeSettings(FHandle, insideconeangle, outsideconeangle, outsidevolume);
end;

function TFMOD_SOUND.Set3DCustomRolloff(points: PFMOD_VECTOR; numpoints: Integer): FMOD_RESULT;
begin
  Result := FMOD_Sound_Set3DCustomRolloff(FHandle, points, numpoints);
end;

function TFMOD_SOUND.Get3DCustomRolloff(points: PPFMOD_VECTOR; numpoints: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_Get3DCustomRolloff(FHandle, points, numpoints);
end;

function TFMOD_SOUND.GetSubSound(index: Integer; subsound: PPFMOD_SOUND): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetSubSound(FHandle, index, subsound);
end;

function TFMOD_SOUND.GetSubSoundParent(parentsound: PPFMOD_SOUND): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetSubSoundParent(FHandle, parentsound);
end;

function TFMOD_SOUND.GetName(name: PAnsiChar; namelen: Integer): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetName(FHandle, name, namelen);
end;

function TFMOD_SOUND.GetLength(length: PCardinal; lengthtype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetLength(FHandle, length, lengthtype);
end;

function TFMOD_SOUND.GetFormat(type_: PFMOD_SOUND_TYPE; format: PFMOD_SOUND_FORMAT; channels: PInteger; bits: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetFormat(FHandle, type_, format, channels, bits);
end;

function TFMOD_SOUND.GetNumSubSounds(numsubsounds: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetNumSubSounds(FHandle, numsubsounds);
end;

function TFMOD_SOUND.GetNumTags(numtags: PInteger; numtagsupdated: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetNumTags(FHandle, numtags, numtagsupdated);
end;

function TFMOD_SOUND.GetTag(name: PAnsiChar; index: Integer; tag: PFMOD_TAG): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetTag(FHandle, name, index, tag);
end;

function TFMOD_SOUND.GetOpenState(openstate: PFMOD_OPENSTATE; percentbuffered: PCardinal; starving: PFMOD_BOOL; diskbusy: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetOpenState(FHandle, openstate, percentbuffered, starving, diskbusy);
end;

function TFMOD_SOUND.ReadData(buffer: Pointer; length: Cardinal; read: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_Sound_ReadData(FHandle, buffer, length, read);
end;

function TFMOD_SOUND.SeekData(pcm: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_Sound_SeekData(FHandle, pcm);
end;

function TFMOD_SOUND.SetSoundGroup(soundgroup: PFMOD_SOUNDGROUP): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetSoundGroup(FHandle, soundgroup);
end;

function TFMOD_SOUND.GetSoundGroup(soundgroup: PPFMOD_SOUNDGROUP): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetSoundGroup(FHandle, soundgroup);
end;

function TFMOD_SOUND.GetNumSyncPoints(numsyncpoints: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetNumSyncPoints(FHandle, numsyncpoints);
end;

function TFMOD_SOUND.GetSyncPoint(index: Integer; point: PPFMOD_SYNCPOINT): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetSyncPoint(FHandle, index, point);
end;

function TFMOD_SOUND.GetSyncPointInfo(point: PFMOD_SYNCPOINT; name: PAnsiChar; namelen: Integer; offset: PCardinal; offsettype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetSyncPointInfo(FHandle, point, name, namelen, offset, offsettype);
end;

function TFMOD_SOUND.AddSyncPoint(offset: Cardinal; offsettype: FMOD_TIMEUNIT; name: PAnsiChar; point: PPFMOD_SYNCPOINT): FMOD_RESULT;
begin
  Result := FMOD_Sound_AddSyncPoint(FHandle, offset, offsettype, name, point);
end;

function TFMOD_SOUND.DeleteSyncPoint(point: PFMOD_SYNCPOINT): FMOD_RESULT;
begin
  Result := FMOD_Sound_DeleteSyncPoint(FHandle, point);
end;

function TFMOD_SOUND.SetMode(mode: FMOD_MODE): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetMode(FHandle, mode);
end;

function TFMOD_SOUND.GetMode(mode: PFMOD_MODE): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetMode(FHandle, mode);
end;

function TFMOD_SOUND.SetLoopCount(loopcount: Integer): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetLoopCount(FHandle, loopcount);
end;

function TFMOD_SOUND.GetLoopCount(loopcount: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetLoopCount(FHandle, loopcount);
end;

function TFMOD_SOUND.SetLoopPoints(loopstart: Cardinal; loopstarttype: FMOD_TIMEUNIT; loopend: Cardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetLoopPoints(FHandle, loopstart, loopstarttype, loopend, loopendtype);
end;

function TFMOD_SOUND.GetLoopPoints(loopstart: PCardinal; loopstarttype: FMOD_TIMEUNIT; loopend: PCardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetLoopPoints(FHandle, loopstart, loopstarttype, loopend, loopendtype);
end;

function TFMOD_SOUND.GetMusicNumChannels(numchannels: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetMusicNumChannels(FHandle, numchannels);
end;

function TFMOD_SOUND.SetMusicChannelVolume(channel: Integer; volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetMusicChannelVolume(FHandle, channel, volume);
end;

function TFMOD_SOUND.GetMusicChannelVolume(channel: Integer; volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetMusicChannelVolume(FHandle, channel, volume);
end;

function TFMOD_SOUND.SetMusicSpeed(speed: Single): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetMusicSpeed(FHandle, speed);
end;

function TFMOD_SOUND.GetMusicSpeed(speed: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetMusicSpeed(FHandle, speed);
end;

function TFMOD_SOUND.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Sound_SetUserData(FHandle, userdata);
end;

function TFMOD_SOUND.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Sound_GetUserData(FHandle, userdata);
end;

function TFMOD_CHANNEL.GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetSystemObject(FHandle, system);
end;

function TFMOD_CHANNEL.Stop: FMOD_RESULT;
begin
  Result := FMOD_Channel_Stop(FHandle);
end;

function TFMOD_CHANNEL.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetPaused(FHandle, paused);
end;

function TFMOD_CHANNEL.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetPaused(FHandle, paused);
end;

function TFMOD_CHANNEL.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetVolume(FHandle, volume);
end;

function TFMOD_CHANNEL.GetVolume(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetVolume(FHandle, volume);
end;

function TFMOD_CHANNEL.SetVolumeRamp(ramp: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetVolumeRamp(FHandle, ramp);
end;

function TFMOD_CHANNEL.GetVolumeRamp(ramp: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetVolumeRamp(FHandle, ramp);
end;

function TFMOD_CHANNEL.GetAudibility(audibility: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetAudibility(FHandle, audibility);
end;

function TFMOD_CHANNEL.SetPitch(pitch: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetPitch(FHandle, pitch);
end;

function TFMOD_CHANNEL.GetPitch(pitch: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetPitch(FHandle, pitch);
end;

function TFMOD_CHANNEL.SetMute(mute: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetMute(FHandle, mute);
end;

function TFMOD_CHANNEL.GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetMute(FHandle, mute);
end;

function TFMOD_CHANNEL.SetReverbProperties(instance: Integer; wet: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetReverbProperties(FHandle, instance, wet);
end;

function TFMOD_CHANNEL.GetReverbProperties(instance: Integer; wet: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetReverbProperties(FHandle, instance, wet);
end;

function TFMOD_CHANNEL.SetLowPassGain(gain: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetLowPassGain(FHandle, gain);
end;

function TFMOD_CHANNEL.GetLowPassGain(gain: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetLowPassGain(FHandle, gain);
end;

function TFMOD_CHANNEL.SetMode(mode: FMOD_MODE): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetMode(FHandle, mode);
end;

function TFMOD_CHANNEL.GetMode(mode: PFMOD_MODE): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetMode(FHandle, mode);
end;

function TFMOD_CHANNEL.SetCallback(callback: FMOD_CHANNELCONTROL_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetCallback(FHandle, callback);
end;

function TFMOD_CHANNEL.IsPlaying(isplaying_: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_IsPlaying(FHandle, isplaying_);
end;

function TFMOD_CHANNEL.SetPan(pan: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetPan(FHandle, pan);
end;

function TFMOD_CHANNEL.SetMixLevelsOutput(frontleft: Single; frontright: Single; center: Single; lfe: Single; surroundleft: Single; surroundright: Single; backleft: Single; backright: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetMixLevelsOutput(FHandle, frontleft, frontright, center, lfe, surroundleft, surroundright, backleft, backright);
end;

function TFMOD_CHANNEL.SetMixLevelsInput(levels: PSingle; numlevels: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetMixLevelsInput(FHandle, levels, numlevels);
end;

function TFMOD_CHANNEL.SetMixMatrix(matrix: PSingle; outchannels: Integer; inchannels: Integer; inchannel_hop: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetMixMatrix(FHandle, matrix, outchannels, inchannels, inchannel_hop);
end;

function TFMOD_CHANNEL.GetMixMatrix(matrix: PSingle; outchannels: PInteger; inchannels: PInteger; inchannel_hop: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetMixMatrix(FHandle, matrix, outchannels, inchannels, inchannel_hop);
end;

function TFMOD_CHANNEL.GetDSPClock(dspclock: PQWord; parentclock: PQWord): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetDSPClock(FHandle, dspclock, parentclock);
end;

function TFMOD_CHANNEL.SetDelay(dspclock_start: QWord; dspclock_end: QWord; stopchannels: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetDelay(FHandle, dspclock_start, dspclock_end, stopchannels);
end;

function TFMOD_CHANNEL.GetDelay(dspclock_start: PQWord; dspclock_end: PQWord; stopchannels: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetDelay(FHandle, dspclock_start, dspclock_end, stopchannels);
end;

function TFMOD_CHANNEL.AddFadePoint(dspclock: QWord; volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_AddFadePoint(FHandle, dspclock, volume);
end;

function TFMOD_CHANNEL.SetFadePointRamp(dspclock: QWord; volume: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetFadePointRamp(FHandle, dspclock, volume);
end;

function TFMOD_CHANNEL.RemoveFadePoints(dspclock_start: QWord; dspclock_end: QWord): FMOD_RESULT;
begin
  Result := FMOD_Channel_RemoveFadePoints(FHandle, dspclock_start, dspclock_end);
end;

function TFMOD_CHANNEL.GetFadePoints(numpoints: PCardinal; point_dspclock: PQWord; point_volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetFadePoints(FHandle, numpoints, point_dspclock, point_volume);
end;

function TFMOD_CHANNEL.GetDSP(index: Integer; dsp: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetDSP(FHandle, index, dsp);
end;

function TFMOD_CHANNEL.AddDSP(index: Integer; dsp: PFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_Channel_AddDSP(FHandle, index, dsp);
end;

function TFMOD_CHANNEL.RemoveDSP(dsp: PFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_Channel_RemoveDSP(FHandle, dsp);
end;

function TFMOD_CHANNEL.GetNumDSPs(numdsps: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetNumDSPs(FHandle, numdsps);
end;

function TFMOD_CHANNEL.SetDSPIndex(dsp: PFMOD_DSP; index: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetDSPIndex(FHandle, dsp, index);
end;

function TFMOD_CHANNEL.GetDSPIndex(dsp: PFMOD_DSP; index: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetDSPIndex(FHandle, dsp, index);
end;

function TFMOD_CHANNEL.Set3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DAttributes(FHandle, pos, vel);
end;

function TFMOD_CHANNEL.Get3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DAttributes(FHandle, pos, vel);
end;

function TFMOD_CHANNEL.Set3DMinMaxDistance(mindistance: Single; maxdistance: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DMinMaxDistance(FHandle, mindistance, maxdistance);
end;

function TFMOD_CHANNEL.Get3DMinMaxDistance(mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DMinMaxDistance(FHandle, mindistance, maxdistance);
end;

function TFMOD_CHANNEL.Set3DConeSettings(insideconeangle: Single; outsideconeangle: Single; outsidevolume: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DConeSettings(FHandle, insideconeangle, outsideconeangle, outsidevolume);
end;

function TFMOD_CHANNEL.Get3DConeSettings(insideconeangle: PSingle; outsideconeangle: PSingle; outsidevolume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DConeSettings(FHandle, insideconeangle, outsideconeangle, outsidevolume);
end;

function TFMOD_CHANNEL.Set3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DConeOrientation(FHandle, orientation);
end;

function TFMOD_CHANNEL.Get3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DConeOrientation(FHandle, orientation);
end;

function TFMOD_CHANNEL.Set3DCustomRolloff(points: PFMOD_VECTOR; numpoints: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DCustomRolloff(FHandle, points, numpoints);
end;

function TFMOD_CHANNEL.Get3DCustomRolloff(points: PPFMOD_VECTOR; numpoints: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DCustomRolloff(FHandle, points, numpoints);
end;

function TFMOD_CHANNEL.Set3DOcclusion(directocclusion: Single; reverbocclusion: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DOcclusion(FHandle, directocclusion, reverbocclusion);
end;

function TFMOD_CHANNEL.Get3DOcclusion(directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DOcclusion(FHandle, directocclusion, reverbocclusion);
end;

function TFMOD_CHANNEL.Set3DSpread(angle: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DSpread(FHandle, angle);
end;

function TFMOD_CHANNEL.Get3DSpread(angle: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DSpread(FHandle, angle);
end;

function TFMOD_CHANNEL.Set3DLevel(level: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DLevel(FHandle, level);
end;

function TFMOD_CHANNEL.Get3DLevel(level: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DLevel(FHandle, level);
end;

function TFMOD_CHANNEL.Set3DDopplerLevel(level: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DDopplerLevel(FHandle, level);
end;

function TFMOD_CHANNEL.Get3DDopplerLevel(level: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DDopplerLevel(FHandle, level);
end;

function TFMOD_CHANNEL.Set3DDistanceFilter(custom: FMOD_BOOL; customLevel: Single; centerFreq: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_Set3DDistanceFilter(FHandle, custom, customLevel, centerFreq);
end;

function TFMOD_CHANNEL.Get3DDistanceFilter(custom: PFMOD_BOOL; customLevel: PSingle; centerFreq: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_Get3DDistanceFilter(FHandle, custom, customLevel, centerFreq);
end;

function TFMOD_CHANNEL.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetUserData(FHandle, userdata);
end;

function TFMOD_CHANNEL.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetUserData(FHandle, userdata);
end;

function TFMOD_CHANNEL.SetFrequency(frequency: Single): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetFrequency(FHandle, frequency);
end;

function TFMOD_CHANNEL.GetFrequency(frequency: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetFrequency(FHandle, frequency);
end;

function TFMOD_CHANNEL.SetPriority(priority: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetPriority(FHandle, priority);
end;

function TFMOD_CHANNEL.GetPriority(priority: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetPriority(FHandle, priority);
end;

function TFMOD_CHANNEL.SetPosition(position: Cardinal; postype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetPosition(FHandle, position, postype);
end;

function TFMOD_CHANNEL.GetPosition(position: PCardinal; postype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetPosition(FHandle, position, postype);
end;

function TFMOD_CHANNEL.SetChannelGroup(channelgroup: PFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetChannelGroup(FHandle, channelgroup);
end;

function TFMOD_CHANNEL.GetChannelGroup(channelgroup: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetChannelGroup(FHandle, channelgroup);
end;

function TFMOD_CHANNEL.SetLoopCount(loopcount: Integer): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetLoopCount(FHandle, loopcount);
end;

function TFMOD_CHANNEL.GetLoopCount(loopcount: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetLoopCount(FHandle, loopcount);
end;

function TFMOD_CHANNEL.SetLoopPoints(loopstart: Cardinal; loopstarttype: FMOD_TIMEUNIT; loopend: Cardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Channel_SetLoopPoints(FHandle, loopstart, loopstarttype, loopend, loopendtype);
end;

function TFMOD_CHANNEL.GetLoopPoints(loopstart: PCardinal; loopstarttype: FMOD_TIMEUNIT; loopend: PCardinal; loopendtype: FMOD_TIMEUNIT): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetLoopPoints(FHandle, loopstart, loopstarttype, loopend, loopendtype);
end;

function TFMOD_CHANNEL.IsVirtual(isvirtual_: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Channel_IsVirtual(FHandle, isvirtual_);
end;

function TFMOD_CHANNEL.GetCurrentSound(sound: PPFMOD_SOUND): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetCurrentSound(FHandle, sound);
end;

function TFMOD_CHANNEL.GetIndex(index: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Channel_GetIndex(FHandle, index);
end;

function TFMOD_CHANNELGROUP.GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetSystemObject(FHandle, system);
end;

function TFMOD_CHANNELGROUP.Stop: FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Stop(FHandle);
end;

function TFMOD_CHANNELGROUP.SetPaused(paused: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetPaused(FHandle, paused);
end;

function TFMOD_CHANNELGROUP.GetPaused(paused: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetPaused(FHandle, paused);
end;

function TFMOD_CHANNELGROUP.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetVolume(FHandle, volume);
end;

function TFMOD_CHANNELGROUP.GetVolume(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetVolume(FHandle, volume);
end;

function TFMOD_CHANNELGROUP.SetVolumeRamp(ramp: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetVolumeRamp(FHandle, ramp);
end;

function TFMOD_CHANNELGROUP.GetVolumeRamp(ramp: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetVolumeRamp(FHandle, ramp);
end;

function TFMOD_CHANNELGROUP.GetAudibility(audibility: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetAudibility(FHandle, audibility);
end;

function TFMOD_CHANNELGROUP.SetPitch(pitch: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetPitch(FHandle, pitch);
end;

function TFMOD_CHANNELGROUP.GetPitch(pitch: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetPitch(FHandle, pitch);
end;

function TFMOD_CHANNELGROUP.SetMute(mute: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetMute(FHandle, mute);
end;

function TFMOD_CHANNELGROUP.GetMute(mute: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetMute(FHandle, mute);
end;

function TFMOD_CHANNELGROUP.SetReverbProperties(instance: Integer; wet: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetReverbProperties(FHandle, instance, wet);
end;

function TFMOD_CHANNELGROUP.GetReverbProperties(instance: Integer; wet: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetReverbProperties(FHandle, instance, wet);
end;

function TFMOD_CHANNELGROUP.SetLowPassGain(gain: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetLowPassGain(FHandle, gain);
end;

function TFMOD_CHANNELGROUP.GetLowPassGain(gain: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetLowPassGain(FHandle, gain);
end;

function TFMOD_CHANNELGROUP.SetMode(mode: FMOD_MODE): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetMode(FHandle, mode);
end;

function TFMOD_CHANNELGROUP.GetMode(mode: PFMOD_MODE): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetMode(FHandle, mode);
end;

function TFMOD_CHANNELGROUP.SetCallback(callback: FMOD_CHANNELCONTROL_CALLBACK): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetCallback(FHandle, callback);
end;

function TFMOD_CHANNELGROUP.IsPlaying(isplaying_: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_IsPlaying(FHandle, isplaying_);
end;

function TFMOD_CHANNELGROUP.SetPan(pan: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetPan(FHandle, pan);
end;

function TFMOD_CHANNELGROUP.SetMixLevelsOutput(frontleft: Single; frontright: Single; center: Single; lfe: Single; surroundleft: Single; surroundright: Single; backleft: Single; backright: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetMixLevelsOutput(FHandle, frontleft, frontright, center, lfe, surroundleft, surroundright, backleft, backright);
end;

function TFMOD_CHANNELGROUP.SetMixLevelsInput(levels: PSingle; numlevels: Integer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetMixLevelsInput(FHandle, levels, numlevels);
end;

function TFMOD_CHANNELGROUP.SetMixMatrix(matrix: PSingle; outchannels: Integer; inchannels: Integer; inchannel_hop: Integer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetMixMatrix(FHandle, matrix, outchannels, inchannels, inchannel_hop);
end;

function TFMOD_CHANNELGROUP.GetMixMatrix(matrix: PSingle; outchannels: PInteger; inchannels: PInteger; inchannel_hop: Integer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetMixMatrix(FHandle, matrix, outchannels, inchannels, inchannel_hop);
end;

function TFMOD_CHANNELGROUP.GetDSPClock(dspclock: PQWord; parentclock: PQWord): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetDSPClock(FHandle, dspclock, parentclock);
end;

function TFMOD_CHANNELGROUP.SetDelay(dspclock_start: QWord; dspclock_end: QWord; stopchannels: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetDelay(FHandle, dspclock_start, dspclock_end, stopchannels);
end;

function TFMOD_CHANNELGROUP.GetDelay(dspclock_start: PQWord; dspclock_end: PQWord; stopchannels: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetDelay(FHandle, dspclock_start, dspclock_end, stopchannels);
end;

function TFMOD_CHANNELGROUP.AddFadePoint(dspclock: QWord; volume: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_AddFadePoint(FHandle, dspclock, volume);
end;

function TFMOD_CHANNELGROUP.SetFadePointRamp(dspclock: QWord; volume: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetFadePointRamp(FHandle, dspclock, volume);
end;

function TFMOD_CHANNELGROUP.RemoveFadePoints(dspclock_start: QWord; dspclock_end: QWord): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_RemoveFadePoints(FHandle, dspclock_start, dspclock_end);
end;

function TFMOD_CHANNELGROUP.GetFadePoints(numpoints: PCardinal; point_dspclock: PQWord; point_volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetFadePoints(FHandle, numpoints, point_dspclock, point_volume);
end;

function TFMOD_CHANNELGROUP.GetDSP(index: Integer; dsp: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetDSP(FHandle, index, dsp);
end;

function TFMOD_CHANNELGROUP.AddDSP(index: Integer; dsp: PFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_AddDSP(FHandle, index, dsp);
end;

function TFMOD_CHANNELGROUP.RemoveDSP(dsp: PFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_RemoveDSP(FHandle, dsp);
end;

function TFMOD_CHANNELGROUP.GetNumDSPs(numdsps: PInteger): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetNumDSPs(FHandle, numdsps);
end;

function TFMOD_CHANNELGROUP.SetDSPIndex(dsp: PFMOD_DSP; index: Integer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetDSPIndex(FHandle, dsp, index);
end;

function TFMOD_CHANNELGROUP.GetDSPIndex(dsp: PFMOD_DSP; index: PInteger): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetDSPIndex(FHandle, dsp, index);
end;

function TFMOD_CHANNELGROUP.Set3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DAttributes(FHandle, pos, vel);
end;

function TFMOD_CHANNELGROUP.Get3DAttributes(pos: PFMOD_VECTOR; vel: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DAttributes(FHandle, pos, vel);
end;

function TFMOD_CHANNELGROUP.Set3DMinMaxDistance(mindistance: Single; maxdistance: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DMinMaxDistance(FHandle, mindistance, maxdistance);
end;

function TFMOD_CHANNELGROUP.Get3DMinMaxDistance(mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DMinMaxDistance(FHandle, mindistance, maxdistance);
end;

function TFMOD_CHANNELGROUP.Set3DConeSettings(insideconeangle: Single; outsideconeangle: Single; outsidevolume: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DConeSettings(FHandle, insideconeangle, outsideconeangle, outsidevolume);
end;

function TFMOD_CHANNELGROUP.Get3DConeSettings(insideconeangle: PSingle; outsideconeangle: PSingle; outsidevolume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DConeSettings(FHandle, insideconeangle, outsideconeangle, outsidevolume);
end;

function TFMOD_CHANNELGROUP.Set3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DConeOrientation(FHandle, orientation);
end;

function TFMOD_CHANNELGROUP.Get3DConeOrientation(orientation: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DConeOrientation(FHandle, orientation);
end;

function TFMOD_CHANNELGROUP.Set3DCustomRolloff(points: PFMOD_VECTOR; numpoints: Integer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DCustomRolloff(FHandle, points, numpoints);
end;

function TFMOD_CHANNELGROUP.Get3DCustomRolloff(points: PPFMOD_VECTOR; numpoints: PInteger): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DCustomRolloff(FHandle, points, numpoints);
end;

function TFMOD_CHANNELGROUP.Set3DOcclusion(directocclusion: Single; reverbocclusion: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DOcclusion(FHandle, directocclusion, reverbocclusion);
end;

function TFMOD_CHANNELGROUP.Get3DOcclusion(directocclusion: PSingle; reverbocclusion: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DOcclusion(FHandle, directocclusion, reverbocclusion);
end;

function TFMOD_CHANNELGROUP.Set3DSpread(angle: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DSpread(FHandle, angle);
end;

function TFMOD_CHANNELGROUP.Get3DSpread(angle: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DSpread(FHandle, angle);
end;

function TFMOD_CHANNELGROUP.Set3DLevel(level: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DLevel(FHandle, level);
end;

function TFMOD_CHANNELGROUP.Get3DLevel(level: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DLevel(FHandle, level);
end;

function TFMOD_CHANNELGROUP.Set3DDopplerLevel(level: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DDopplerLevel(FHandle, level);
end;

function TFMOD_CHANNELGROUP.Get3DDopplerLevel(level: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DDopplerLevel(FHandle, level);
end;

function TFMOD_CHANNELGROUP.Set3DDistanceFilter(custom: FMOD_BOOL; customLevel: Single; centerFreq: Single): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Set3DDistanceFilter(FHandle, custom, customLevel, centerFreq);
end;

function TFMOD_CHANNELGROUP.Get3DDistanceFilter(custom: PFMOD_BOOL; customLevel: PSingle; centerFreq: PSingle): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Get3DDistanceFilter(FHandle, custom, customLevel, centerFreq);
end;

function TFMOD_CHANNELGROUP.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_SetUserData(FHandle, userdata);
end;

function TFMOD_CHANNELGROUP.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetUserData(FHandle, userdata);
end;

function TFMOD_CHANNELGROUP.Release: FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_Release(FHandle);
end;

function TFMOD_CHANNELGROUP.AddGroup(group: PFMOD_CHANNELGROUP; propagatedspclock: FMOD_BOOL; connection: PPFMOD_DSPCONNECTION): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_AddGroup(FHandle, group, propagatedspclock, connection);
end;

function TFMOD_CHANNELGROUP.GetNumGroups(numgroups: PInteger): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetNumGroups(FHandle, numgroups);
end;

function TFMOD_CHANNELGROUP.GetGroup(index: Integer; group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetGroup(FHandle, index, group);
end;

function TFMOD_CHANNELGROUP.GetParentGroup(group: PPFMOD_CHANNELGROUP): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetParentGroup(FHandle, group);
end;

function TFMOD_CHANNELGROUP.GetName(name: PAnsiChar; namelen: Integer): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetName(FHandle, name, namelen);
end;

function TFMOD_CHANNELGROUP.GetNumChannels(numchannels: PInteger): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetNumChannels(FHandle, numchannels);
end;

function TFMOD_CHANNELGROUP.GetChannel(index: Integer; channel: PPFMOD_CHANNEL): FMOD_RESULT;
begin
  Result := FMOD_ChannelGroup_GetChannel(FHandle, index, channel);
end;

function TFMOD_SOUNDGROUP.Release: FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_Release(FHandle);
end;

function TFMOD_SOUNDGROUP.GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetSystemObject(FHandle, system);
end;

function TFMOD_SOUNDGROUP.SetMaxAudible(maxaudible: Integer): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_SetMaxAudible(FHandle, maxaudible);
end;

function TFMOD_SOUNDGROUP.GetMaxAudible(maxaudible: PInteger): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetMaxAudible(FHandle, maxaudible);
end;

function TFMOD_SOUNDGROUP.SetMaxAudibleBehavior(behavior: FMOD_SOUNDGROUP_BEHAVIOR): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_SetMaxAudibleBehavior(FHandle, behavior);
end;

function TFMOD_SOUNDGROUP.GetMaxAudibleBehavior(behavior: PFMOD_SOUNDGROUP_BEHAVIOR): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetMaxAudibleBehavior(FHandle, behavior);
end;

function TFMOD_SOUNDGROUP.SetMuteFadeSpeed(speed: Single): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_SetMuteFadeSpeed(FHandle, speed);
end;

function TFMOD_SOUNDGROUP.GetMuteFadeSpeed(speed: PSingle): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetMuteFadeSpeed(FHandle, speed);
end;

function TFMOD_SOUNDGROUP.SetVolume(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_SetVolume(FHandle, volume);
end;

function TFMOD_SOUNDGROUP.GetVolume(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetVolume(FHandle, volume);
end;

function TFMOD_SOUNDGROUP.Stop: FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_Stop(FHandle);
end;

function TFMOD_SOUNDGROUP.GetName(name: PAnsiChar; namelen: Integer): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetName(FHandle, name, namelen);
end;

function TFMOD_SOUNDGROUP.GetNumSounds(numsounds: PInteger): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetNumSounds(FHandle, numsounds);
end;

function TFMOD_SOUNDGROUP.GetSound(index: Integer; sound: PPFMOD_SOUND): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetSound(FHandle, index, sound);
end;

function TFMOD_SOUNDGROUP.GetNumPlaying(numplaying: PInteger): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetNumPlaying(FHandle, numplaying);
end;

function TFMOD_SOUNDGROUP.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_SetUserData(FHandle, userdata);
end;

function TFMOD_SOUNDGROUP.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_SoundGroup_GetUserData(FHandle, userdata);
end;

function TFMOD_DSP.Release: FMOD_RESULT;
begin
  Result := FMOD_DSP_Release(FHandle);
end;

function TFMOD_DSP.GetSystemObject(system: PPFMOD_SYSTEM): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetSystemObject(FHandle, system);
end;

function TFMOD_DSP.AddInput(input: PFMOD_DSP; connection: PPFMOD_DSPCONNECTION; type_: FMOD_DSPCONNECTION_TYPE): FMOD_RESULT;
begin
  Result := FMOD_DSP_AddInput(FHandle, input, connection, type_);
end;

function TFMOD_DSP.DisconnectFrom(target: PFMOD_DSP; connection: PFMOD_DSPCONNECTION): FMOD_RESULT;
begin
  Result := FMOD_DSP_DisconnectFrom(FHandle, target, connection);
end;

function TFMOD_DSP.DisconnectAll(inputs: FMOD_BOOL; outputs: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_DisconnectAll(FHandle, inputs, outputs);
end;

function TFMOD_DSP.GetNumInputs(numinputs: PInteger): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetNumInputs(FHandle, numinputs);
end;

function TFMOD_DSP.GetNumOutputs(numoutputs: PInteger): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetNumOutputs(FHandle, numoutputs);
end;

function TFMOD_DSP.GetInput(index: Integer; input: PPFMOD_DSP; inputconnection: PPFMOD_DSPCONNECTION): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetInput(FHandle, index, input, inputconnection);
end;

function TFMOD_DSP.GetOutput(index: Integer; output: PPFMOD_DSP; outputconnection: PPFMOD_DSPCONNECTION): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetOutput(FHandle, index, output, outputconnection);
end;

function TFMOD_DSP.SetActive(active: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetActive(FHandle, active);
end;

function TFMOD_DSP.GetActive(active: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetActive(FHandle, active);
end;

function TFMOD_DSP.SetBypass(bypass: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetBypass(FHandle, bypass);
end;

function TFMOD_DSP.GetBypass(bypass: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetBypass(FHandle, bypass);
end;

function TFMOD_DSP.SetWetDryMix(prewet: Single; postwet: Single; dry: Single): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetWetDryMix(FHandle, prewet, postwet, dry);
end;

function TFMOD_DSP.GetWetDryMix(prewet: PSingle; postwet: PSingle; dry: PSingle): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetWetDryMix(FHandle, prewet, postwet, dry);
end;

function TFMOD_DSP.SetChannelFormat(channelmask: FMOD_CHANNELMASK; numchannels: Integer; source_speakermode: FMOD_SPEAKERMODE): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetChannelFormat(FHandle, channelmask, numchannels, source_speakermode);
end;

function TFMOD_DSP.GetChannelFormat(channelmask: PFMOD_CHANNELMASK; numchannels: PInteger; source_speakermode: PFMOD_SPEAKERMODE): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetChannelFormat(FHandle, channelmask, numchannels, source_speakermode);
end;

function TFMOD_DSP.GetOutputChannelFormat(inmask: FMOD_CHANNELMASK; inchannels: Integer; inspeakermode: FMOD_SPEAKERMODE; outmask: PFMOD_CHANNELMASK; outchannels: PInteger; outspeakermode: PFMOD_SPEAKERMODE): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetOutputChannelFormat(FHandle, inmask, inchannels, inspeakermode, outmask, outchannels, outspeakermode);
end;

function TFMOD_DSP.Reset: FMOD_RESULT;
begin
  Result := FMOD_DSP_Reset(FHandle);
end;

function TFMOD_DSP.SetParameterFloat(index: Integer; value: Single): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetParameterFloat(FHandle, index, value);
end;

function TFMOD_DSP.SetParameterInt(index: Integer; value: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetParameterInt(FHandle, index, value);
end;

function TFMOD_DSP.SetParameterBool(index: Integer; value: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetParameterBool(FHandle, index, value);
end;

function TFMOD_DSP.SetParameterData(index: Integer; data: Pointer; length: Cardinal): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetParameterData(FHandle, index, data, length);
end;

function TFMOD_DSP.GetParameterFloat(index: Integer; value: PSingle; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetParameterFloat(FHandle, index, value, valuestr, valuestrlen);
end;

function TFMOD_DSP.GetParameterInt(index: Integer; value: PInteger; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetParameterInt(FHandle, index, value, valuestr, valuestrlen);
end;

function TFMOD_DSP.GetParameterBool(index: Integer; value: PFMOD_BOOL; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetParameterBool(FHandle, index, value, valuestr, valuestrlen);
end;

function TFMOD_DSP.GetParameterData(index: Integer; data: PPointer; length: PCardinal; valuestr: PAnsiChar; valuestrlen: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetParameterData(FHandle, index, data, length, valuestr, valuestrlen);
end;

function TFMOD_DSP.GetNumParameters(numparams: PInteger): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetNumParameters(FHandle, numparams);
end;

function TFMOD_DSP.GetParameterInfo(index: Integer; desc: PPFMOD_DSP_PARAMETER_DESC): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetParameterInfo(FHandle, index, desc);
end;

function TFMOD_DSP.GetDataParameterIndex(datatype: Integer; index: PInteger): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetDataParameterIndex(FHandle, datatype, index);
end;

function TFMOD_DSP.ShowConfigDialog(hwnd: Pointer; show: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_ShowConfigDialog(FHandle, hwnd, show);
end;

function TFMOD_DSP.GetInfo(name: PAnsiChar; version: PCardinal; channels: PInteger; configwidth: PInteger; configheight: PInteger): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetInfo(FHandle, name, version, channels, configwidth, configheight);
end;

function TFMOD_DSP.GetType(type_: PFMOD_DSP_TYPE): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetType(FHandle, type_);
end;

function TFMOD_DSP.GetIdle(idle: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetIdle(FHandle, idle);
end;

function TFMOD_DSP.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetUserData(FHandle, userdata);
end;

function TFMOD_DSP.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetUserData(FHandle, userdata);
end;

function TFMOD_DSP.SetMeteringEnabled(inputEnabled: FMOD_BOOL; outputEnabled: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_SetMeteringEnabled(FHandle, inputEnabled, outputEnabled);
end;

function TFMOD_DSP.GetMeteringEnabled(inputEnabled: PFMOD_BOOL; outputEnabled: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetMeteringEnabled(FHandle, inputEnabled, outputEnabled);
end;

function TFMOD_DSP.GetMeteringInfo(inputInfo: PFMOD_DSP_METERING_INFO; outputInfo: PFMOD_DSP_METERING_INFO): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetMeteringInfo(FHandle, inputInfo, outputInfo);
end;

function TFMOD_DSP.GetCPUUsage(exclusive: PCardinal; inclusive: PCardinal): FMOD_RESULT;
begin
  Result := FMOD_DSP_GetCPUUsage(FHandle, exclusive, inclusive);
end;

function TFMOD_DSPCONNECTION.GetInput(input: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_GetInput(FHandle, input);
end;

function TFMOD_DSPCONNECTION.GetOutput(output: PPFMOD_DSP): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_GetOutput(FHandle, output);
end;

function TFMOD_DSPCONNECTION.SetMix(volume: Single): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_SetMix(FHandle, volume);
end;

function TFMOD_DSPCONNECTION.GetMix(volume: PSingle): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_GetMix(FHandle, volume);
end;

function TFMOD_DSPCONNECTION.SetMixMatrix(matrix: PSingle; outchannels: Integer; inchannels: Integer; inchannel_hop: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_SetMixMatrix(FHandle, matrix, outchannels, inchannels, inchannel_hop);
end;

function TFMOD_DSPCONNECTION.GetMixMatrix(matrix: PSingle; outchannels: PInteger; inchannels: PInteger; inchannel_hop: Integer): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_GetMixMatrix(FHandle, matrix, outchannels, inchannels, inchannel_hop);
end;

function TFMOD_DSPCONNECTION.GetType(type_: PFMOD_DSPCONNECTION_TYPE): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_GetType(FHandle, type_);
end;

function TFMOD_DSPCONNECTION.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_SetUserData(FHandle, userdata);
end;

function TFMOD_DSPCONNECTION.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_DSPConnection_GetUserData(FHandle, userdata);
end;

function TFMOD_GEOMETRY.Release: FMOD_RESULT;
begin
  Result := FMOD_Geometry_Release(FHandle);
end;

function TFMOD_GEOMETRY.AddPolygon(directocclusion: Single; reverbocclusion: Single; doublesided: FMOD_BOOL; numvertices: Integer; vertices: PFMOD_VECTOR; polygonindex: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Geometry_AddPolygon(FHandle, directocclusion, reverbocclusion, doublesided, numvertices, vertices, polygonindex);
end;

function TFMOD_GEOMETRY.GetNumPolygons(numpolygons: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetNumPolygons(FHandle, numpolygons);
end;

function TFMOD_GEOMETRY.GetMaxPolygons(maxpolygons: PInteger; maxvertices: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetMaxPolygons(FHandle, maxpolygons, maxvertices);
end;

function TFMOD_GEOMETRY.GetPolygonNumVertices(index: Integer; numvertices: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetPolygonNumVertices(FHandle, index, numvertices);
end;

function TFMOD_GEOMETRY.SetPolygonVertex(index: Integer; vertexindex: Integer; vertex: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetPolygonVertex(FHandle, index, vertexindex, vertex);
end;

function TFMOD_GEOMETRY.GetPolygonVertex(index: Integer; vertexindex: Integer; vertex: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetPolygonVertex(FHandle, index, vertexindex, vertex);
end;

function TFMOD_GEOMETRY.SetPolygonAttributes(index: Integer; directocclusion: Single; reverbocclusion: Single; doublesided: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetPolygonAttributes(FHandle, index, directocclusion, reverbocclusion, doublesided);
end;

function TFMOD_GEOMETRY.GetPolygonAttributes(index: Integer; directocclusion: PSingle; reverbocclusion: PSingle; doublesided: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetPolygonAttributes(FHandle, index, directocclusion, reverbocclusion, doublesided);
end;

function TFMOD_GEOMETRY.SetActive(active: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetActive(FHandle, active);
end;

function TFMOD_GEOMETRY.GetActive(active: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetActive(FHandle, active);
end;

function TFMOD_GEOMETRY.SetRotation(forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetRotation(FHandle, forward, up);
end;

function TFMOD_GEOMETRY.GetRotation(forward: PFMOD_VECTOR; up: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetRotation(FHandle, forward, up);
end;

function TFMOD_GEOMETRY.SetPosition(position: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetPosition(FHandle, position);
end;

function TFMOD_GEOMETRY.GetPosition(position: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetPosition(FHandle, position);
end;

function TFMOD_GEOMETRY.SetScale(scale: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetScale(FHandle, scale);
end;

function TFMOD_GEOMETRY.GetScale(scale: PFMOD_VECTOR): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetScale(FHandle, scale);
end;

function TFMOD_GEOMETRY.Save(data: Pointer; datasize: PInteger): FMOD_RESULT;
begin
  Result := FMOD_Geometry_Save(FHandle, data, datasize);
end;

function TFMOD_GEOMETRY.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Geometry_SetUserData(FHandle, userdata);
end;

function TFMOD_GEOMETRY.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Geometry_GetUserData(FHandle, userdata);
end;

function TFMOD_REVERB3D.Release: FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_Release(FHandle);
end;

function TFMOD_REVERB3D.Set3DAttributes(position: PFMOD_VECTOR; mindistance: Single; maxdistance: Single): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_Set3DAttributes(FHandle, position, mindistance, maxdistance);
end;

function TFMOD_REVERB3D.Get3DAttributes(position: PFMOD_VECTOR; mindistance: PSingle; maxdistance: PSingle): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_Get3DAttributes(FHandle, position, mindistance, maxdistance);
end;

function TFMOD_REVERB3D.SetProperties(properties: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_SetProperties(FHandle, properties);
end;

function TFMOD_REVERB3D.GetProperties(properties: PFMOD_REVERB_PROPERTIES): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_GetProperties(FHandle, properties);
end;

function TFMOD_REVERB3D.SetActive(active: FMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_SetActive(FHandle, active);
end;

function TFMOD_REVERB3D.GetActive(active: PFMOD_BOOL): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_GetActive(FHandle, active);
end;

function TFMOD_REVERB3D.SetUserData(userdata: Pointer): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_SetUserData(FHandle, userdata);
end;

function TFMOD_REVERB3D.GetUserData(userdata: PPointer): FMOD_RESULT;
begin
  Result := FMOD_Reverb3D_GetUserData(FHandle, userdata);
end;

end.
