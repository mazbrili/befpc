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

unit Window;

interface

uses
  beobj, looper, rect, os, application, appdefs;

const
  // window_type
  B_UNTYPED_WINDOW 		=  0;
  B_TITLED_WINDOW 		=  1;
  B_MODAL_WINDOW		=  3;
  B_DOCUMENT_WINDOW		= 11;
  B_BORDERED_WINDOW		= 20;
  B_FLOATING_WINDOW		= 21;
  
  // window_look
  B_BORDERED_WINDOW_LOOK	= 20;
  B_NO_BORDER_WINDOW_LOOK 	= 19;
  B_TITLED_WINDOW_LOOK		=  1;
  B_DOCUMENT_WINDOW_LOOK	= 11;
  B_MODAL_WINDOW_LOOK		=  3;
  B_FLOATING_WINDOW_LOOK	=  7;
  
  // window_feel
  B_NORMAL_WINDOW_FEEL			= 0;
  B_MODAL_SUBSET_WINDOW_FEEL	= 2;
  B_MODAL_APP_WINDOW_FEEL		= 1;
  B_MODAL_ALL_WINDOW_FEEL		= 3;
  B_FLOATING_SUBSET_WINDOW_FEEL	= 5;
  B_FLOATING_APP_WINDOW_FEEL	= 4;
  B_FLOATING_ALL_WINDOW_FEEL	= 6;
  
  // flags
  B_NOT_MOVABLE					= $00000001;
  B_NOT_CLOSABLE				= $00000020;
  B_NOT_ZOOMABLE				= $00000040;
  B_NOT_MINIMIZABLE				= $00004000;
  B_NOT_RESIZABLE				= $00000002;
  B_NOT_H_RESIZABLE				= $00000004;
  B_NOT_V_RESIZABLE				= $00000008;
  B_AVOID_FRONT					= $00000080;
  B_AVOID_FOCUS					= $00002000;
  B_WILL_ACCEPT_FIRST_CLICK		= $00000010;
  B_OUTLINE_RESIZE				= $00001000;
  B_NO_WORKSPACE_ACTIVATION		= $00000100;
  B_NOT_ANCHORED_ON_ACTIVATE	= $00020000;
  B_ASYNCHRONOUS_CONTROLS		= $00080000;
  B_QUIT_ON_WINDOW_CLOSE		= $00100000;
  
  B_CURRENT_WORKSPACE		= 0;    
  B_ALL_WORKSPACES			= $ffffffff;
  
type
  TWindow = class(TLooper)
  public
    constructor Create(frame : TRect; title : PChar; atype, flags, workspaces : Cardinal);
    destructor Destroy; override;
    procedure Show;
    procedure Hide;
    function QuitRequested : boolean; override;
  end;

function BWindow_Create(AObject : TObject; frame : TCPlusObject; title : PChar;
  atype, flags, workspaces : cardinal) : TCplusObject; cdecl; external BePascalLibName name 'BWindow_Create_1';
procedure BWindow_Free(CPlusObject : TCPlusObject); cdecl; external BePascalLibName name 'BWindow_Free';
procedure BWindow_Show(CPlusObject : TCPlusObject); cdecl; external BePascalLibName name 'BWindow_Show';
procedure BWindow_Hide(CPlusObject : TCPlusObject); cdecl; external BePascalLibName name 'BWindow_Hide';
  
implementation

function TWindow.QuitRequested : boolean;
begin
  Result := inherited;
  be_app.PostMessage(B_QUIT_REQUESTED);
end;

constructor TWindow.Create(frame : TRect; title : PChar; atype, flags, workspaces : Cardinal);
begin
  inherited Create;
  CPlusObject := BWindow_Create(Self, frame.CPlusObject, title, atype, flags, workspaces);
end;

destructor TWindow.Destroy;
begin
  BWindow_Free(CPlusObject);  
  inherited;
end;

procedure TWindow.Show;
begin
  BWindow_Show(Self.CPlusObject);
end;

procedure TWindow.Hide;
begin
  BWindow_Hide(Self.CPlusObject);
end;

initialization

end.