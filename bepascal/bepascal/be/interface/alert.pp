{   BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2003 Olivier Coursiere
                       Eric Jourde
                       Oscar Lesta

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
unit Alert;

interface

uses
  BeObj, Archivable, Button, InterfaceDefs, Invoker, Handler,
  Message, Rect, SupportDefs, TextView, Window;

type
{ enum for flavors of alert }
// enum alert_type
  TAlert_Type = (B_EMPTY_ALERT, B_INFO_ALERT, B_IDEA_ALERT, B_WARNING_ALERT,
                 B_STOP_ALERT);

//enum button_spacing
  TButton_Spacing = (B_EVEN_SPACING, B_OFFSET_SPACING);

  TAlert = class(TWindow)
  private
  public
    // Here we have this name colition: type --> kind
    constructor Create(title : PChar; text : PChar; button1 : PChar;
                       button2 : PChar; button3 : PChar; width : TButton_Width;
                       kind{type} : TAlert_Type);
    constructor Create(title : PChar; text : PChar; button1 : PChar;
                       button2 : PChar; button3 : PChar; width : TButton_Width;
                       spacing : TButton_Spacing; kind{type} : TAlert_Type);
    constructor Create(data : TMessage);

    destructor Destroy; override;

    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure SetShortcut(button_index : integer; key : Char);
    function Shortcut(button_index : integer) : Char;
    function Go : integer;
    function Go(invoker : TInvoker) : TStatus_t;
    procedure MessageReceived(an_event : TMessage); override;
    procedure FrameResized(new_width : double; new_height : double);
    function ButtonAt(index : integer) : TButton;
    function TextView : TTextView;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    procedure DispatchMessage(msg : TMessage; handler : THandler); override;
    procedure Quit;
    function QuitRequested : boolean; override;
    function AlertPosition(width : double; height : double) : TPoint;
{
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;

    procedure _ReservedAlert1;
    procedure _ReservedAlert2;
    procedure _ReservedAlert3;

    procedure InitObject(text : PChar; button1 : PChar; button2 : PChar; button3 : PChar; width : TButton_Width; spacing : TButton_Spacing; type : TAlert_Type);
    function InitIcon : TBitmap;
    procedure sem_id fAlertSem;
    procedure int32 fAlertVal;
    procedure BButton *fButtons[3];
    procedure BTextView *fTextView;
    procedure char fKeys[3];
    procedure alert_type fMsgType;
    procedure button_width fButtonWidth;
    procedure BInvoker *fInvoker;
    procedure uint32 _reserved[4];
}
  end;

function BAlert_Create(AObject : TBeObject; title : PChar; text : PChar;
  button1 : PChar; button2 : PChar; button3 : PChar; width : TButton_Width;
  kind{type} : TAlert_Type) : TCPlusObject; cdecl;
  external BePascalLibName name 'BAlert_Create';
function BAlert_Create_1(AObject : TBeObject; title : PChar; text : PChar;
  button1 : PChar; button2 : PChar; button3 : PChar; width : TButton_Width;
  spacing : TButton_Spacing; kind{type} : TAlert_Type) : TCPlusObject; cdecl;
  external BePascalLibName name 'BAlert_Create_1';
function BAlert_Create_2(AObject : TBeObject; data : TCPlusObject)
  : TCPlusObject; cdecl; external BePascalLibName name 'BAlert_Create_2';

procedure BAlert_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_Free';

function BAlert_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BAlert_Instantiate';
function BAlert_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BAlert_Archive';
procedure BAlert_SetShortcut(AObject : TCPlusObject; button_index : integer; key : Char); cdecl; external BePascalLibName name 'BAlert_SetShortcut';
function BAlert_Shortcut(AObject : TCPlusObject; button_index : integer) : Char; cdecl; external BePascalLibName name 'BAlert_Shortcut';
function BAlert_Go(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BAlert_Go';
function BAlert_Go(AObject : TCPlusObject; invoker : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BAlert_Go';
procedure BAlert_MessageReceived(AObject : TCPlusObject; an_event : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_MessageReceived';
procedure BAlert_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BAlert_FrameResized';
function BAlert_ButtonAt(AObject : TCPlusObject; index : integer) : TButton; cdecl; external BePascalLibName name 'BAlert_ButtonAt';
function BAlert_TextView(AObject : TCPlusObject) : TTextView; cdecl; external BePascalLibName name 'BAlert_TextView';
function BAlert_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BAlert_ResolveSpecifier';
function BAlert_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BAlert_GetSupportedSuites';
procedure BAlert_DispatchMessage(AObject : TCPlusObject; msg : TCPlusObject; handler : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_DispatchMessage';
procedure BAlert_Quit(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_Quit';
function BAlert_QuitRequested(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BAlert_QuitRequested';
function BAlert_AlertPosition(AObject : TCPlusObject; width : double; height : double) : TPoint; cdecl; external BePascalLibName name 'BAlert_AlertPosition';
{
function BAlert_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BAlert_Perform';
procedure BAlert__ReservedAlert1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert__ReservedAlert1';
procedure BAlert__ReservedAlert2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert__ReservedAlert2';
procedure BAlert__ReservedAlert3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert__ReservedAlert3';
procedure BAlert_InitObject(AObject : TCPlusObject; text : PChar; button1 : PChar; button2 : PChar; button3 : PChar; width : TButton_Width; spacing : TButton_Spacing; type : TAlert_Type); cdecl; external BePascalLibName name 'BAlert_InitObject';
function BAlert_InitIcon(AObject : TCPlusObject) : TBitmap; cdecl; external BePascalLibName name 'BAlert_InitIcon';
procedure BAlert_sem_id fAlertSem(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_sem_id fAlertSem';
procedure BAlert_int32 fAlertVal(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_int32 fAlertVal';
procedure BAlert_BButton *fButtons[3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_BButton *fButtons[3]';
procedure BAlert_BTextView *fTextView(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_BTextView *fTextView';
procedure BAlert_char fKeys[3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_char fKeys[3]';
procedure BAlert_alert_type fMsgType(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_alert_type fMsgType';
procedure BAlert_button_width fButtonWidth(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_button_width fButtonWidth';
procedure BAlert_BInvoker *fInvoker(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_BInvoker *fInvoker';
procedure BAlert_uint32 _reserved[4](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_uint32 _reserved[4]';
}
implementation

constructor TAlert.Create(title : PChar; text : PChar; button1 : PChar;
                       button2 : PChar; button3 : PChar; width : TButton_Width;
                       kind{type} : TAlert_Type);
begin
	CPlusObject := BAlert_Create(Self, title, text, button1, button2, button3,
	                             width, kind);
end;

constructor TAlert.Create(title : PChar; text : PChar; button1 : PChar; button2 : PChar; button3 : PChar; width : TButton_Width; spacing : TButton_Spacing; kind{type} : TAlert_Type);
begin
  CPlusObject := BAlert_Create_1(Self, title, text, button1, button2, button3,
                                 width, spacing, kind{type});
end;

constructor TAlert.Create(data : TMessage);
begin
  CPlusObject := BAlert_Create_2(Self, data.CPlusObject);
end;

destructor TAlert.Destroy;
begin
  BAlert_Free(CPlusObject);
end;

function TAlert.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BAlert_Instantiate(CPlusObject, data.CPlusObject);
end;

function TAlert.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BAlert_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TAlert.SetShortcut(button_index : integer; key : Char);
begin
  BAlert_SetShortcut(CPlusObject, button_index, key);
end;

function TAlert.Shortcut(button_index : integer) : Char;
begin
  Result := BAlert_Shortcut(CPlusObject, button_index);
end;

function TAlert.Go : integer;
begin
  Result := BAlert_Go(CPlusObject);
end;

function TAlert.Go(invoker : TInvoker) : TStatus_t;
begin
  Result := BAlert_Go(CPlusObject, invoker.CPlusObject);
end;

procedure TAlert.MessageReceived(an_event : TMessage);
begin
  BAlert_MessageReceived(CPlusObject, an_event.CPlusObject);
end;

procedure TAlert.FrameResized(new_width : double; new_height : double);
begin
  BAlert_FrameResized(CPlusObject, new_width, new_height);
end;

function TAlert.ButtonAt(index : integer) : TButton;
begin
  Result := BAlert_ButtonAt(CPlusObject, index);
end;

function TAlert.TextView : TTextView;
begin
  Result := BAlert_TextView(CPlusObject);
end;

function TAlert.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BAlert_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function TAlert.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BAlert_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure TAlert.DispatchMessage(msg : TMessage; handler : THandler);
begin
  BAlert_DispatchMessage(CPlusObject, msg.CPlusObject, handler.CPlusObject);
end;

procedure TAlert.Quit;
begin
  BAlert_Quit(CPlusObject);
end;

function TAlert.QuitRequested : boolean;
begin
  Result := BAlert_QuitRequested(CPlusObject);
end;

function TAlert.AlertPosition(width : double; height : double) : TPoint;
begin
  Result := BAlert_AlertPosition(CPlusObject, width, height);
end;

{
function TAlert.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BAlert_Perform(CPlusObject, d, arg);
end;

procedure TAlert._ReservedAlert1;
begin
  BAlert__ReservedAlert1(CPlusObject);
end;

procedure TAlert._ReservedAlert2;
begin
  BAlert__ReservedAlert2(CPlusObject);
end;

procedure TAlert._ReservedAlert3;
begin
  BAlert__ReservedAlert3(CPlusObject);
end;

procedure TAlert.InitObject(text : PChar; button1 : PChar; button2 : PChar; button3 : PChar; width : TButton_Width; spacing : TButton_Spacing; type : TAlert_Type);
begin
  BAlert_InitObject(CPlusObject, text, button1, button2, button3, width, spacing, type);
end;

function TAlert.InitIcon : TBitmap;
begin
  Result := BAlert_InitIcon(CPlusObject);
end;

procedure TAlert.sem_id fAlertSem;
begin
  BAlert_sem_id fAlertSem(CPlusObject);
end;

procedure TAlert.int32 fAlertVal;
begin
  BAlert_int32 fAlertVal(CPlusObject);
end;

procedure TAlert.BButton *fButtons[3];
begin
  BAlert_BButton *fButtons[3](CPlusObject);
end;

procedure TAlert.BTextView *fTextView;
begin
  BAlert_BTextView *fTextView(CPlusObject);
end;

procedure TAlert.char fKeys[3];
begin
  BAlert_char fKeys[3](CPlusObject);
end;

procedure TAlert.alert_type fMsgType;
begin
  BAlert_alert_type fMsgType(CPlusObject);
end;

procedure TAlert.button_width fButtonWidth;
begin
  BAlert_button_width fButtonWidth(CPlusObject);
end;

procedure TAlert.BInvoker *fInvoker;
begin
  BAlert_BInvoker *fInvoker(CPlusObject);
end;

procedure TAlert.uint32 _reserved[4];
begin
  BAlert_uint32 _reserved[4](CPlusObject);
end;
}

end.
