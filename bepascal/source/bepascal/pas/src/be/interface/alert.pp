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
  Alert_Type = (B_EMPTY_ALERT, B_INFO_ALERT, B_IDEA_ALERT, B_WARNING_ALERT,
                 B_STOP_ALERT);

//enum button_spacing
  Button_Spacing = (B_EVEN_SPACING, B_OFFSET_SPACING);

  BAlert = class(BWindow)
  private
  public
    // Here we have this name colition: type --> kind
    constructor Create(title : PChar; text : PChar; button1 : PChar;
                       button2 : PChar; button3 : PChar; width : Button_Width;
                       kind{type} : Alert_Type);
    constructor Create(title : PChar; text : PChar; button1 : PChar;
                       button2 : PChar; button3 : PChar; width : Button_Width;
                       spacing : Button_Spacing; kind{type} : Alert_Type);
    constructor Create(data : BMessage);

    destructor Destroy; override;

    function Instantiate(data : BMessage) : BArchivable;
    function Archive(data : BMessage; deep : boolean) : Status_t;
    procedure SetShortcut(button_index : integer; key : Char);
    function Shortcut(button_index : integer) : Char;
    function Go : integer;
    function Go(invoker : BInvoker) : Status_t;
    procedure MessageReceived(an_event : BMessage); override;
    procedure FrameResized(new_width : double; new_height : double);
    function ButtonAt(index : integer) : BButton;
    function TextView : BTextView;
    function ResolveSpecifier(msg : BMessage; index : integer; specifier : BMessage; form : integer; properti : PChar) : BHandler;
    function GetSupportedSuites(data : BMessage) : Status_t;
    procedure DispatchMessage(msg : BMessage; handler : BHandler); override;
    procedure Quit;
    function QuitRequested : boolean; override;
    function AlertPosition(width : double; height : double) : BPoint;
  end;

function BAlert_Create(AObject : TBeObject; title : PChar; text : PChar; button1 : PChar; button2 : PChar; button3 : PChar; width : Button_Width;kind{type} : Alert_Type) : TCPlusObject; cdecl;  external BePascalLibName name 'BAlert_Create';
function BAlert_Create_1(AObject : TBeObject; title : PChar; text : PChar;button1 : PChar; button2 : PChar; button3 : PChar; width : Button_Width;  spacing : Button_Spacing; kind{type} : Alert_Type) : TCPlusObject; cdecl;  external BePascalLibName name 'BAlert_Create_1';
function BAlert_Create_2(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BAlert_Create_2';

procedure BAlert_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_Free';

function BAlert_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : BArchivable; cdecl; external BePascalLibName name 'BAlert_Instantiate';
function BAlert_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : Status_t; cdecl; external BePascalLibName name 'BAlert_Archive';
procedure BAlert_SetShortcut(AObject : TCPlusObject; button_index : integer; key : Char); cdecl; external BePascalLibName name 'BAlert_SetShortcut';
function BAlert_Shortcut(AObject : TCPlusObject; button_index : integer) : Char; cdecl; external BePascalLibName name 'BAlert_Shortcut';
function BAlert_Go(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BAlert_Go';
function BAlert_Go(AObject : TCPlusObject; invoker : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BAlert_Go';
procedure BAlert_MessageReceived(AObject : TCPlusObject; an_event : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_MessageReceived';
procedure BAlert_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BAlert_FrameResized';
function BAlert_ButtonAt(AObject : TCPlusObject; index : integer) : BButton; cdecl; external BePascalLibName name 'BAlert_ButtonAt';
function BAlert_TextView(AObject : TCPlusObject) : BTextView; cdecl; external BePascalLibName name 'BAlert_TextView';
function BAlert_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : BHandler; cdecl; external BePascalLibName name 'BAlert_ResolveSpecifier';
function BAlert_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BAlert_GetSupportedSuites';
procedure BAlert_DispatchMessage(AObject : TCPlusObject; msg : TCPlusObject; handler : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_DispatchMessage';
procedure BAlert_Quit(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BAlert_Quit';
function BAlert_QuitRequested(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BAlert_QuitRequested';
function BAlert_AlertPosition(AObject : TCPlusObject; width : double; height : double) : BPoint; cdecl; external BePascalLibName name 'BAlert_AlertPosition';

implementation

constructor BAlert.Create(title : PChar; text : PChar; button1 : PChar;
                       button2 : PChar; button3 : PChar; width : Button_Width;
                       kind{type} : Alert_Type);
begin
	CPlusObject := BAlert_Create(Self, title, text, button1, button2, button3,
	                             width, kind);
end;

constructor BAlert.Create(title : PChar; text : PChar; button1 : PChar; button2 : PChar; button3 : PChar; width : Button_Width; spacing : Button_Spacing; kind{type} : Alert_Type);
begin
  CPlusObject := BAlert_Create_1(Self, title, text, button1, button2, button3,
                                 width, spacing, kind{type});
end;

constructor BAlert.Create(data : BMessage);
begin
  CPlusObject := BAlert_Create_2(Self, data.CPlusObject);
end;

destructor BAlert.Destroy;
begin
  BAlert_Free(CPlusObject);
end;

function BAlert.Instantiate(data : BMessage) : BArchivable;
begin
  Result := BAlert_Instantiate(CPlusObject, data.CPlusObject);
end;

function BAlert.Archive(data : BMessage; deep : boolean) : Status_t;
begin
  Result := BAlert_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure BAlert.SetShortcut(button_index : integer; key : Char);
begin
  BAlert_SetShortcut(CPlusObject, button_index, key);
end;

function BAlert.Shortcut(button_index : integer) : Char;
begin
  Result := BAlert_Shortcut(CPlusObject, button_index);
end;

function BAlert.Go : integer;
begin
  Result := BAlert_Go(CPlusObject);
end;

function BAlert.Go(invoker : BInvoker) : Status_t;
begin
  Result := BAlert_Go(CPlusObject, invoker.CPlusObject);
end;

procedure BAlert.MessageReceived(an_event : BMessage);
begin
  BAlert_MessageReceived(CPlusObject, an_event.CPlusObject);
end;

procedure BAlert.FrameResized(new_width : double; new_height : double);
begin
  BAlert_FrameResized(CPlusObject, new_width, new_height);
end;

function BAlert.ButtonAt(index : integer) : BButton;
begin
  Result := BAlert_ButtonAt(CPlusObject, index);
end;

function BAlert.TextView : BTextView;
begin
  Result := BAlert_TextView(CPlusObject);
end;

function BAlert.ResolveSpecifier(msg : BMessage; index : integer; specifier : BMessage; form : integer; properti : PChar) : BHandler;
begin
  Result := BAlert_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function BAlert.GetSupportedSuites(data : BMessage) : Status_t;
begin
  Result := BAlert_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure BAlert.DispatchMessage(msg : BMessage; handler : BHandler);
begin
  BAlert_DispatchMessage(CPlusObject, msg.CPlusObject, handler.CPlusObject);
end;

procedure BAlert.Quit;
begin
  BAlert_Quit(CPlusObject);
end;

function BAlert.QuitRequested : boolean;
begin
  Result := BAlert_QuitRequested(CPlusObject);
end;

function BAlert.AlertPosition(width : double; height : double) : BPoint;
begin
  Result := BAlert_AlertPosition(CPlusObject, width, height);
end;


end.
