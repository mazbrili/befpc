{  BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002 Olivier Coursiere

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit Roster;

interface

uses
  beobj, appdefs, supportdefs, OS, Entry, StorageDefs, List, Messenger,
  message;

type
  PTEntryRef = ^EntryRef;
  
  AppInfoProc = procedure;
  
  AppInfo = record
    thread : Thread_id;
    team : Team_id;
    port : Port_id;
    flags : Cardinal;
    ref : EntryRef;
    signature : Array[0..B_MIME_TYPE_LENGTH] of Char;
  end;
  
  BRoster = class(TBeObject)
  private
  public
  	constructor Create; override;
  	destructor Destroy; override;
//*****************
    function IsRunning(mime_sig : PChar) : boolean;
    function IsRunning(var ref : EntryRef) : boolean;
    function TeamFor(mime_sig : PChar) : Team_id;
    function TeamFor(var ref : EntryRef) : Team_id;
    procedure GetAppList(team_id_list : BList);
    procedure GetAppList(sig : PChar; team_id_list : BList);
    function GeAppInfo(sig : PChar; var info : AppInfo) : Status_t;
    function GeAppInfo(var ref : EntryRef; var info : AppInfo) : Status_t;
    function GetRunningAppInfo(team : Team_id; var info : AppInfo) : Status_t;
    function GetActiveAppInfo(var info : AppInfo) : Status_t;
    function FindApp(mime_type : PChar; var app : EntryRef) : Status_t;
    function FindApp(var ref : EntryRef; var app : EntryRef) : Status_t;
    function Broadcast(msg : BMessage) : Status_t;
    function Broadcast(msg : BMessage; reply_to : BMessenger) : Status_t;
    function StopWatching(target : BMessenger) : Status_t;
    function ActivateApp(team : Team_id) : Status_t;
    function Launch(mime_type : PChar; initial_msgs : BMessage; var app_team : Team_id) : Status_t;
    function Launch(mime_type : PChar; message_list : BList; var app_team : Team_id) : Status_t;
    function Launch(mime_type : PChar; argc : integer; args : PChar; var app_team : Team_id) : Status_t;
    function Launch(var ref : EntryRef; initial_message : BMessage; var app_team : Team_id) : Status_t;
    function Launch(var ref : EntryRef; message_list : BList; var app_team : Team_id) : Status_t;
    function Launch(var ref : EntryRef; argc : integer; args : PChar; var app_team : Team_id) : Status_t;
    procedure GetRecentDocuments(refList : BMessage; maxCount : integer; ofType : PChar; openedByAppSig : PChar);
    procedure GetRecentDocuments(refList : BMessage; maxCount : integer; ofTypeList : PChar; ofTypeListCount : integer; openedByAppSig : PChar);
    procedure GetRecentFolders(refList : BMessage; maxCount : integer; openedByAppSig : PChar);
    procedure GetRecentApps(refList : BMessage; maxCount : integer);
    procedure AddToRecentDocuments(var doc : EntryRef; appSig : PChar);
    procedure AddToRecentFolders(var folder : EntryRef; appSig : PChar);
// private
//    procedure enum mtarget { MAIN_MESSENGER, MIME_MESSENGER, USE_GIVEN };
{    function _StartWatching(t : ; roster_mess : BMessenger; what : Cardinal; notify : BMessenger; event_mask : Cardinal) : Status_t;
    function _StopWatching(t : ; roster_mess : BMessenger; what : Cardinal; notify : BMessenger) : Status_t;
    function AddApplication(mime_sig : PChar; ref : ^EntryRef; flags : Cardinal; team : Team_id; thread : TThread_id; port : TPort_id; full_reg : boolean) : Cardinal;
    procedure SetSignature(team : Team_id; mime_sig : PChar);
    procedure SetThread(team : Team_id; tid : TThread_id);
    procedure SetThreadAndTeam(entry_token : Cardinal; tid : TThread_id; team : Team_id);
    procedure CompleteRegistration(team : Team_id;  : TThread_id; port : TPort_id);
    function IsAppPreRegistered(ref : ^BEntryRef; team : Team_id; info : ^AppInfo) : boolean;
    procedure RemovePreRegApp(entry_token : Cardinal);
    procedure RemoveApp(team : Team_id);
    function xLaunchAppPrivate(mime_sig : PChar; ref : ^BEntryRef; msg_list : BList; cargs : integer; args : PChar; app_team : ^Team_id) : Status_t;
    function UpdateActiveApp(team : Team_id) : boolean;
    procedure SetAppFlags(team : Team_id; flags : Cardinal);
    procedure DumpRoster;
    function resolve_app(in_type : PChar; ref : ^BEntryRef; app_ref : ^BEntryRef; app_sig : PChar; app_flags : Cardinal; was_document : boolean) : Status_t;
    function translate_ref(ref : ^BEntryRef; app_meta : TBMimeType; app_ref : ^BEntryRef; app_file : TBFile; app_sig : PChar; was_document : boolean) : Status_t;
    function translate_type(mime_type : PChar; meta : TBMimeType; app_ref : ^BEntryRef; app_file : TBFile; app_sig : PChar) : Status_t;
    function sniff_file(file : ^BEntryRef; finfo : TBNodeInfo; mime_type : PChar) : Status_t;
    function is_wildcard(sig : PChar) : boolean;
    function get_unique_supporting_app(apps : BMessage; out_sig : PChar) : Status_t;
    function get_random_supporting_app(apps : BMessage; out_sig : PChar) : Status_t;
    function build_arg_vector(args : PChar; pargs : integer; app_ref : ^BEntryRef; doc_ref : ^BEntryRef) : PChar;
    function send_to_running(tema : Team_id; app_ref : ^BEntryRef; cargs : integer; args : PChar; msg_list : BList; ref : ^BEntryRef) : Status_t;
    procedure IniBMessengers;
    procedure BMessenger fMess;
    procedure BMessenger fMimeMess;
    procedure uint32 _fReserved[3];
}
  end;

function Get_be_roster : TCPlusObject; cdecl; external BePascalLibName;
function BRoster_Create(AObject : TObject) : TCPlusObject; cdecl; external BePascalLibName;
procedure BRoster_Destroy(CPlusObject : TCPlusObject); cdecl; external BePascalLibName;

//function app_info_Create(AObject : TBeObject); cdecl; external BePascalLibName name 'app_info_Create';
//procedure app_info_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_Free';
//procedure app_info_thread_id thread(AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_thread_id thread';
//procedure app_info_team_id team(AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_team_id team';
//procedure app_info_port_id port(AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_port_id port';
//procedure app_info_uint32 flags(AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_uint32 flags';
//procedure app_info_entry_ref ref(AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_entry_ref ref';
//procedure app_info_char signature[B_MIME_TYPE_LENGTH](AObject : TCPlusObject); cdecl; external BePascalLibName name 'app_info_char signature[B_MIME_TYPE_LENGTH]';
//function BRoster_Create(AObject : TBeObject); cdecl; external BePascalLibName name 'BRoster_Create';
//procedure BRoster_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_Free';
function BRoster_IsRunning(AObject : TCPlusObject; mime_sig : PChar) : boolean; cdecl; external BePascalLibName name 'BRoster_IsRunning';
function BRoster_IsRunning(AObject : TCPlusObject; var ref : EntryRef) : boolean; cdecl; external BePascalLibName name 'BRoster_IsRunning';
function BRoster_TeamFor(AObject : TCPlusObject; mime_sig : PChar) : Team_id; cdecl; external BePascalLibName name 'BRoster_TeamFor';
function BRoster_TeamFor(AObject : TCPlusObject; var ref : EntryRef) : Team_id; cdecl; external BePascalLibName name 'BRoster_TeamFor';
procedure BRoster_GetAppList(AObject : TCPlusObject; team_id_list : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_GetAppList';
procedure BRoster_GetAppList(AObject : TCPlusObject; sig : PChar; team_id_list : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_GetAppList';
function BRoster_GeAppInfo(AObject : TCPlusObject; sig : PChar; var info : AppInfo) : Status_t; cdecl; external BePascalLibName name 'BRoster_GetAppInfo';
function BRoster_GeAppInfo(AObject : TCPlusObject; var ref : EntryRef; var info : AppInfo) : Status_t; cdecl; external BePascalLibName name 'BRoster_GetAppInfo';
function BRoster_GetRunningAppInfo(AObject : TCPlusObject; team : Team_id; var info : AppInfo) : Status_t; cdecl; external BePascalLibName name 'BRoster_GetRunningAppInfo';
function BRoster_GetActiveAppInfo(AObject : TCPlusObject; var info : AppInfo) : Status_t; cdecl; external BePascalLibName name 'BRoster_GetActiveAppInfo';
function BRoster_FindApp(AObject : TCPlusObject; mime_type : PChar; var app : EntryRef) : Status_t; cdecl; external BePascalLibName name 'BRoster_FindApp';
function BRoster_FindApp_1(AObject : TCPlusObject; var ref : EntryRef; var app : EntryRef) : Status_t; cdecl; external BePascalLibName name 'BRoster_FindApp';
function BRoster_Broadcast(aRoster : TCPlusObject; msg : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BRoster_Broadcast';
function BRoster_Broadcast_1(AObject : TCPlusObject; msg : TCPlusObject; reply_to : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BRoster_Broadcast';
function BRoster_StopWatching(AObject : TCPlusObject; target : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BRoster_StopWatching';
function BRoster_ActivateApp(AObject : TCPlusObject; team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_ActivateApp';
function BRoster_Launch(AObject : TCPlusObject; mime_type : PChar; initial_msgs : TCPlusObject; var app_team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_Launch';
function BRoster_Launch_1(AObject : TCPlusObject; mime_type : PChar; message_list : TCPlusObject; var app_team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_Launch';
function BRoster_Launch_2(AObject : TCPlusObject; mime_type : PChar; argc : integer; args : PChar; var app_team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_Launch';
function BRoster_Launch_3(AObject : TCPlusObject; var ref : EntryRef; initial_message : BMessage; var app_team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_Launch';
function BRoster_Launch_4(AObject : TCPlusObject; var ref : EntryRef; message_list : BList; var app_team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_Launch';
function BRoster_Launch_5(AObject : TCPlusObject; var ref : EntryRef; argc : integer; args : PChar; var app_team : Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_Launch';
procedure BRoster_GetRecentDocuments(AObject : TCPlusObject; refList : TCPlusObject; maxCount : integer; ofType : PChar; openedByAppSig : PChar); cdecl; external BePascalLibName name 'BRoster_GetRecentDocuments';
procedure BRoster_GetRecentDocuments(AObject : TCPlusObject; refList : TCPlusObject; maxCount : integer; ofTypeList : PChar; ofTypeListCount : integer; openedByAppSig : PChar); cdecl; external BePascalLibName name 'BRoster_GetRecentDocuments';
procedure BRoster_GetRecentFolders(AObject : TCPlusObject; refList : TCPlusObject; maxCount : integer; openedByAppSig : PChar); cdecl; external BePascalLibName name 'BRoster_GetRecentFolders';
procedure BRoster_GetRecentApps(AObject : TCPlusObject; refList : TCPlusObject; maxCount : integer); cdecl; external BePascalLibName name 'BRoster_GetRecentApps';
procedure BRoster_AddToRecentDocuments(AObject : TCPlusObject; var doc : EntryRef; appSig : PChar); cdecl; external BePascalLibName name 'BRoster_AddToRecentDocuments';
procedure BRoster_AddToRecentFolders(AObject : TCPlusObject; var folder : EntryRef; appSig : PChar); cdecl; external BePascalLibName name 'BRoster_AddToRecentFolders';
// procedure BRoster_enum mtarget { MAIN_MESSENGER, MIME_MESSENGER, USE_GIVEN }(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_enum mtarget { MAIN_MESSENGER, MIME_MESSENGER, USE_GIVEN }';
{function BRoster__StartWatching(AObject : TCPlusObject; t : ; roster_mess : TCPlusObject; what : Cardinal; notify : TCPlusObject; event_mask : Cardinal) : Status_t; cdecl; external BePascalLibName name 'BRoster__StartWatching';
function BRoster__StopWatching(AObject : TCPlusObject; t : ; roster_mess : TCPlusObject; what : Cardinal; notify : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BRoster__StopWatching';
function BRoster_AddApplication(AObject : TCPlusObject; mime_sig : PChar; ref : ^BEntryRef; flags : Cardinal; team : Team_id; thread : TThread_id; port : TPort_id; full_reg : boolean) : Cardinal; cdecl; external BePascalLibName name 'BRoster_AddApplication';
procedure BRoster_SetSignature(AObject : TCPlusObject; team : Team_id; mime_sig : PChar); cdecl; external BePascalLibName name 'BRoster_SetSignature';
procedure BRoster_SetThread(AObject : TCPlusObject; team : Team_id; tid : TThread_id); cdecl; external BePascalLibName name 'BRoster_SetThread';
procedure BRoster_SetThreadAndTeam(AObject : TCPlusObject; entry_token : Cardinal; tid : TThread_id; team : Team_id); cdecl; external BePascalLibName name 'BRoster_SetThreadAndTeam';
procedure BRoster_CompleteRegistration(AObject : TCPlusObject; team : Team_id;  : TThread_id; port : TPort_id); cdecl; external BePascalLibName name 'BRoster_CompleteRegistration';
function BRoster_IsAppPreRegistered(AObject : TCPlusObject; ref : ^BEntryRef; team : Team_id; info : ^AppInfo) : boolean; cdecl; external BePascalLibName name 'BRoster_IsAppPreRegistered';
procedure BRoster_RemovePreRegApp(AObject : TCPlusObject; entry_token : Cardinal); cdecl; external BePascalLibName name 'BRoster_RemovePreRegApp';
procedure BRoster_RemoveApp(AObject : TCPlusObject; team : Team_id); cdecl; external BePascalLibName name 'BRoster_RemoveApp';
function BRoster_xLaunchAppPrivate(AObject : TCPlusObject; mime_sig : PChar; ref : ^BEntryRef; msg_list : TCPlusObject; cargs : integer; args : PChar; app_team : ^Team_id) : Status_t; cdecl; external BePascalLibName name 'BRoster_xLaunchAppPrivate';
function BRoster_UpdateActiveApp(AObject : TCPlusObject; team : Team_id) : boolean; cdecl; external BePascalLibName name 'BRoster_UpdateActiveApp';
procedure BRoster_SetAppFlags(AObject : TCPlusObject; team : Team_id; flags : Cardinal); cdecl; external BePascalLibName name 'BRoster_SetAppFlags';
procedure BRoster_DumpRoster(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_DumpRoster';
function BRoster_resolve_app(AObject : TCPlusObject; in_type : PChar; ref : ^BEntryRef; app_ref : ^BEntryRef; app_sig : PChar; app_flags : Cardinal; was_document : boolean) : Status_t; cdecl; external BePascalLibName name 'BRoster_resolve_app';
function BRoster_translate_ref(AObject : TCPlusObject; ref : ^BEntryRef; app_meta : TCPlusObject; app_ref : ^BEntryRef; app_file : TCPlusObject; app_sig : PChar; was_document : boolean) : Status_t; cdecl; external BePascalLibName name 'BRoster_translate_ref';
function BRoster_translate_type(AObject : TCPlusObject; mime_type : PChar; meta : TCPlusObject; app_ref : ^BEntryRef; app_file : TCPlusObject; app_sig : PChar) : Status_t; cdecl; external BePascalLibName name 'BRoster_translate_type';
function BRoster_sniff_file(AObject : TCPlusObject; file : ^BEntryRef; finfo : TCPlusObject; mime_type : PChar) : Status_t; cdecl; external BePascalLibName name 'BRoster_sniff_file';
function BRoster_is_wildcard(AObject : TCPlusObject; sig : PChar) : boolean; cdecl; external BePascalLibName name 'BRoster_is_wildcard';
function BRoster_get_unique_supporting_app(AObject : TCPlusObject; apps : BMessage; out_sig : PChar) : Status_t; cdecl; external BePascalLibName name 'BRoster_get_unique_supporting_app';
function BRoster_get_random_supporting_app(AObject : TCPlusObject; apps : BMessage; out_sig : PChar) : Status_t; cdecl; external BePascalLibName name 'BRoster_get_random_supporting_app';
function BRoster_build_arg_vector(AObject : TCPlusObject; args : PChar; pargs : integer; app_ref : ^BEntryRef; doc_ref : ^BEntryRef) : PChar; cdecl; external BePascalLibName name 'BRoster_build_arg_vector';
function BRoster_send_to_running(AObject : TCPlusObject; tema : Team_id; app_ref : ^BEntryRef; cargs : integer; args : PChar; msg_list : BList; ref : ^BEntryRef) : Status_t; cdecl; external BePascalLibName name 'BRoster_send_to_running';
procedure BRoster_IniBMessengers(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_IniBMessengers';
procedure BRoster_BMessenger fMess(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_BMessenger fMess';
procedure BRoster_BMessenger fMimeMess(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_BMessenger fMimeMess';
procedure BRoster_uint32 _fReserved[3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BRoster_uint32 _fReserved[3]';
}

var
  be_roster : BRoster;
  
implementation

constructor BRoster.Create;
begin
  inherited;
  CPlusObject := BRoster_Create(Self);
  be_roster := Self;
end;

destructor BRoster.Destroy;
begin
  BRoster_Destroy(CPlusObject);
  inherited;
end;

function BRoster.IsRunning(mime_sig : PChar) : boolean;
begin
  Result := BRoster_IsRunning(CPlusObject, mime_sig);
end;

function BRoster.IsRunning(var ref : EntryRef) : boolean;
begin
  Result := BRoster_IsRunning(CPlusObject, ref);
end;

function BRoster.TeamFor(mime_sig : PChar) : Team_id;
begin
  Result := BRoster_TeamFor(CPlusObject, mime_sig);
end;

function BRoster.TeamFor(var ref : EntryRef) : Team_id;
begin
  Result := BRoster_TeamFor(CPlusObject, ref);
end;

procedure BRoster.GetAppList(team_id_list : BList);
begin
  BRoster_GetAppList(CPlusObject, team_id_list.CPlusObject);
end;

procedure BRoster.GetAppList(sig : PChar; team_id_list : BList);
begin
  BRoster_GetAppList(CPlusObject, sig, team_id_list.CPlusObject);
end;

function BRoster.GeAppInfo(sig : PChar; var info : AppInfo) : Status_t;
begin
  Result := BRoster_GeAppInfo(CPlusObject, sig, info);
end;

function BRoster.GeAppInfo(var ref : EntryRef; var info : AppInfo) : Status_t;
begin
  Result := BRoster_GeAppInfo(CPlusObject, ref, info);
end;

function BRoster.GetRunningAppInfo(team : Team_id; var info : AppInfo) : Status_t;
begin
  Result := BRoster_GetRunningAppInfo(CPlusObject, team, info);
end;

function BRoster.GetActiveAppInfo(var info : AppInfo) : Status_t;
begin
  Result := BRoster_GetActiveAppInfo(CPlusObject, info);
end;

function BRoster.FindApp(mime_type : PChar; var app : EntryRef) : Status_t;
begin
  Result := BRoster_FindApp(CPlusObject, mime_type, app);
end;

function BRoster.FindApp(var ref : EntryRef; var app : EntryRef) : Status_t;
begin
  Result := BRoster_FindApp_1(CPlusObject, ref, app);
end;

function BRoster.Broadcast(msg : BMessage) : Status_t;
begin
  Result := BRoster_Broadcast(CPlusObject, msg.CPlusObject);
end;

function BRoster.Broadcast(msg : BMessage; reply_to : BMessenger) : Status_t;
begin
  Result := BRoster_Broadcast_1(CPlusObject, msg.CPlusObject, reply_to.CPlusObject);
end;

function BRoster.StopWatching(target : BMessenger) : Status_t;
begin
  Result := BRoster_StopWatching(CPlusObject, target.CPlusObject);
end;

function BRoster.ActivateApp(team : Team_id) : Status_t;
begin
  Result := BRoster_ActivateApp(CPlusObject, team);
end;

function BRoster.Launch(mime_type : PChar; initial_msgs : BMessage; var app_team : Team_id) : Status_t;
begin
  Result := BRoster_Launch(CPlusObject, mime_type, initial_msgs.CPlusObject, app_team);
end;

function BRoster.Launch(mime_type : PChar; message_list : BList; var app_team : Team_id) : Status_t;
begin
  Result := BRoster_Launch_1(CPlusObject, mime_type, message_list.CPlusObject, app_team);
end;

function BRoster.Launch(mime_type : PChar; argc : integer; args : PChar; var app_team : Team_id) : Status_t;
begin
  Result := BRoster_Launch_2(CPlusObject, mime_type, argc, args, app_team);
end;

function BRoster.Launch(var ref : EntryRef; initial_message : BMessage; var app_team : Team_id) : Status_t;
begin
  Result := BRoster_Launch_3(CPlusObject, ref, initial_message, app_team);
end;

function BRoster.Launch(var ref : EntryRef; message_list : BList; var app_team : Team_id) : Status_t;
begin
  Result := BRoster_Launch_4(CPlusObject, ref, message_list, app_team);
end;

function BRoster.Launch(var ref : EntryRef; argc : integer; args : PChar; var app_team : Team_id) : Status_t;
begin
  Result := BRoster_Launch_5(CPlusObject, ref, argc, args, app_team);
end;

procedure BRoster.GetRecentDocuments(refList : BMessage; maxCount : integer; ofType : PChar; openedByAppSig : PChar);
begin
  BRoster_GetRecentDocuments(CPlusObject, refList.CPlusObject, maxCount, ofType, openedByAppSig);
end;

procedure BRoster.GetRecentDocuments(refList : BMessage; maxCount : integer; ofTypeList : PChar; ofTypeListCount : integer; openedByAppSig : PChar);
begin
  BRoster_GetRecentDocuments(CPlusObject, refList.CPlusObject, maxCount, ofTypeList, ofTypeListCount, openedByAppSig);
end;

procedure BRoster.GetRecentFolders(refList : BMessage; maxCount : integer; openedByAppSig : PChar);
begin
  BRoster_GetRecentFolders(CPlusObject, refList.CPlusObject, maxCount, openedByAppSig);
end;

procedure BRoster.GetRecentApps(refList : BMessage; maxCount : integer);
begin
  BRoster_GetRecentApps(CPlusObject, refList.CPlusObject, maxCount);
end;

procedure BRoster.AddToRecentDocuments(var doc : EntryRef; appSig : PChar);
begin
  BRoster_AddToRecentDocuments(CPlusObject, doc, appSig);
end;

procedure BRoster.AddToRecentFolders(var folder : EntryRef; appSig : PChar);
begin
  BRoster_AddToRecentFolders(CPlusObject, folder, appSig);
end;

initialization
  be_roster := BRoster.Wrap(Get_be_roster);

finalization
  be_roster.UnWrap;
  be_roster := nil;
end.
