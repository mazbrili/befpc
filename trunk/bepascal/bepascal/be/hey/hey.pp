unit hey;

interface

uses
  beobj, SysUtils, Messenger, Message, SupportDefs, Roster, OS, List, fdblib;
 
type
  BHey = class
  public
    class function Hey(atarget : TMessenger; aarg : string; areply : TMessage) : TStatus_t;
    class function Hey(AppName : string; aarg : string; areply : TMessage) : TStatus_t;
    class function GetMessenger(AppName : string) : TMessenger;
  end;

implementation

function InternalHey(target : TCPlusObject; arg : PChar; reply : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'Hey__FP10BMessengerPCcP8BMessage';//'Hey__FP10BMessengerPPcPllP8BMessage';

class function BHey.Hey(AppName : string; aArg : string; aReply : TMessage) : TStatus_t;
var
  Messenger : TMessenger;
begin
  Messenger := BHey.GetMessenger(AppName);
  if Messenger <> nil then
    Result := BHey.Hey(Messenger, aArg, aReply);
end;

class function BHey.Hey(atarget : TMessenger; aarg : string; areply : TMessage) : TStatus_t;
var
  local : string;
begin
  local := aarg + #0;
  Result := InternalHey(atarget.CPlusObject, @local[1], areply.CPlusObject);
end;

class function BHey.GetMessenger(AppName : string) : TMessenger;
var
  List : TList;
  i : integer;
  Team_id : TTeam_id;
  AppInfo : TAppInfo;
  Status_t : TStatus_t;
begin
  Result := nil;
  List := TList.Create;
  try
    be_roster.GetAppList(List);		    
    for i := 0 to List.CountItems - 1 do
    begin
      Team_id := TTeam_id(List.ItemAt(i));
      be_roster.GetRunningAppInfo(Team_id, AppInfo);
      if AppName = PChar(AppInfo.Signature) then
      begin
        Result := TMessenger.Create(PChar(AppInfo.Signature), -1, Status_t);
        Break;
      end
      else if PChar(AppInfo.ref.name) = AppName then
      begin
        Result := TMessenger.Create(0, Team_id, Status_t);
        Break;
      end;
    end;
  finally
    List.Free;
  end;
end;


end.  
