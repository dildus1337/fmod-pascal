(*
  Play one file through FMOD Ex 4.44.64.

  fpc -Fu../fmod-4.44.64 playsound44464.pas
  Put libfmodex.so / fmodex.dll (or the *64 variant) from the SDK
  next to the binary. -dFMOD_LOGGING selects the logging build.
*)
program playsound44464;

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
    WriteLn('usage: playsound44464 <file>');
    Halt(1);
  end;
  Path := ParamStr(1);

  if FMOD_System_Create(@Audio) <> FMOD_OK then
    Die(FMOD_ERR_INITIALIZATION);
  if FMOD_System_Init(Audio, 32, FMOD_INIT_NORMAL, nil) <> FMOD_OK then
    Die(FMOD_ERR_INITIALIZATION);
  if FMOD_System_CreateSound(Audio, PAnsiChar(Path), FMOD_DEFAULT, nil, @Snd) <> FMOD_OK then
    Die(FMOD_ERR_FILE_NOTFOUND);
  if FMOD_System_PlaySound(Audio, FMOD_CHANNEL_FREE, Snd, 0, @Ch) <> FMOD_OK then
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
