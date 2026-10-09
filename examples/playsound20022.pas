(*
  Play one file through FMOD Studio Core 2.00.22.

  fpc -Fu../fmod-2.00.22 playsound20022.pas
  Put libfmod.so / fmod.dll from the SDK next to the binary
  (or on the library path). -dFMOD_LOGGING selects the logging build.
*)
program playsound20022;

{$MODE OBJFPC}{$H+}

uses
  SysUtils, fmod;

procedure Die(r: FMOD_RESULT);
begin
  WriteLn(StdErr, FMOD_ErrorString(r));
  Halt(1);
end;

var
  Audio: PFMOD_SYSTEM;
  Snd: PFMOD_SOUND;
  Ch: PFMOD_CHANNEL;
  Playing: FMOD_BOOL;
  Path: AnsiString;
begin
  if ParamCount < 1 then
  begin
    WriteLn('usage: playsound20022 <file>');
    Halt(1);
  end;
  Path := ParamStr(1);

  if FMOD_System_Create(@Audio) <> FMOD_OK then
    Die(FMOD_ERR_INITIALIZATION);
  if FMOD_System_Init(Audio, 32, FMOD_INIT_NORMAL, nil) <> FMOD_OK then
    Die(FMOD_ERR_INITIALIZATION);
  if FMOD_System_CreateSound(Audio, PAnsiChar(Path), FMOD_DEFAULT, nil, @Snd) <> FMOD_OK then
    Die(FMOD_ERR_FILE_NOTFOUND);
  if FMOD_System_PlaySound(Audio, Snd, nil, 0, @Ch) <> FMOD_OK then
    Die(FMOD_ERR_OUTPUT_INIT);

  Playing := 1;
  while Playing <> 0 do
  begin
    FMOD_System_Update(Audio);
    if FMOD_Channel_IsPlaying(Ch, @Playing) <> FMOD_OK then
      Break;
    Sleep(50);
  end;

  FMOD_Sound_Release(Snd);
  FMOD_System_Release(Audio);
end.
