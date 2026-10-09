(*
  FreePascal binding for FMOD Ex Event Network API
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
unit fmdeventnet;

interface

uses
  fmod, fmdevent;

const
{$IF defined(MSWINDOWS)}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fmod_event_netL64.dll';
    {$ELSE}
  FMOD_LIB = 'fmod_event_netL.dll';
    {$ENDIF}
  {$ELSE}
    {$IF defined(WIN64)}
  FMOD_LIB = 'fmod_event_net64.dll';
    {$ELSE}
  FMOD_LIB = 'fmod_event_net.dll';
    {$ENDIF}
  {$ENDIF}
{$ELSEIF defined(DARWIN)}
  {$IF defined(FMOD_LOGGING)}
  FMOD_LIB = 'libfmodeventnetL.dylib';
  {$ELSE}
  FMOD_LIB = 'libfmodeventnet.dylib';
  {$ENDIF}
{$ELSE}
  {$IF defined(FMOD_LOGGING)}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfmodeventnetL64.so';
    {$ELSE}
  FMOD_LIB = 'libfmodeventnetL.so';
    {$ENDIF}
  {$ELSE}
    {$IF defined(CPU64)}
  FMOD_LIB = 'libfmodeventnet64.so';
    {$ELSE}
  FMOD_LIB = 'libfmodeventnet.so';
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IF defined(MSWINDOWS)}
  {$DEFINE FMOD_CC := stdcall}
{$ELSE}
  {$DEFINE FMOD_CC := cdecl}
{$ENDIF}

const
  FMOD_EVENT_NET_VERSION = $00044464;
  FMOD_EVENT_NET_PORT = 17997;



function FMOD_NetEventSystem_Init(eventsystem: PFMOD_EVENTSYSTEM; port: Word): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_NetEventSystem_Init';
function FMOD_NetEventSystem_Update(): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_NetEventSystem_Update';
function FMOD_NetEventSystem_Shutdown(): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_NetEventSystem_Shutdown';
function FMOD_NetEventSystem_GetVersion(version: PCardinal): FMOD_RESULT; FMOD_CC;
  external FMOD_LIB name 'FMOD_NetEventSystem_GetVersion';


implementation

end.
