{   BePascal - A pascal wrapper around the BeOS API
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

program Hello;

{$M+}
uses
	beobj, application, message, _beep, roster, SysUtils,
	archivable, handler, toto, rect, window;
	
type
  TMonApplication = class(TApplication)
  public
  	procedure ReadyToRun; override;
  	procedure MessageReceived(aMessage : TMessage); override;
  	function QuitRequested : boolean; override;
  end;
  
  TMonObjet = class(TObject)
  private
    FMessage : string;
  public
    constructor Create; 
    destructor Destroy; override;
    procedure Bonjour(test : string);
  published
    property Message : string read FMessage write FMessage;
  end;
 
var
  MonObj : TMonObjet;

function TMonApplication.QuitRequested : boolean;
begin
  Result := inherited;
  be_app.Free;
end;

procedure TMonApplication.ReadyToRun;
var
  Mess : TMessage;
begin
  inherited;
  if MonObj <> nil then
    MonObj.Bonjour('BONJOUR');
  Mess := TMessage.Create;
  try
    Mess.What := 7777;
    be_roster.Broadcast(Mess);
  finally
    Mess.Free;
  end;
end;

procedure TMonApplication.MessageReceived(aMessage : TMessage);
begin
  inherited;
  WriteLn(IntToStr(aMessage.What));
end;

constructor TMonObjet.Create;
var
  a, b : string;
  c : longint;
begin
  inherited;
 // GetLineInfo($A0000DB4, a, b, c);
  Writeln(a + ' ' + b + ' ' + IntToStr(c));
  WriteLn('Constructor');
end;

procedure TMonObjet.Bonjour(test : string);
var
  a, b : string;
  c : longint;
begin
//  GetLineInfo($8002AEA5, a, b, c);
  Writeln(a + ' ' + b + ' ' + IntToStr(c));
  WriteLn(test);
  beep;	
  WriteLn('Fin de ' + test);
end;

destructor TMonObjet.Destroy;
var
  point : TPoint;
  rect : TRect;
begin
  point := TPoint.Create(10, 20);
  rect := TRect.Create(10.0, 10.0, 10.0, 20.0);
  try
    point.PrintToStream;  
    point.Sept(15, 30);
    rect.PrintToStream;
  finally
    point.PrintToStream;
    point.Free;
    rect.Free;
  end;
  WriteLn('The End');
  inherited;
end;

var
  aRect : TRect;
  win : TWindow;
    
begin
	beep;
	Write('Hello world !' + #13#10);
	MonObj := TMonObjet.Create;
	TMonApplication.Create;
	try
      aRect := TRect.Create(20, 20, 200, 200);
      win := TWindow.Create(aRect, 'Bonjour', B_TITLED_WINDOW, B_QUIT_ON_WINDOW_CLOSE, B_CURRENT_WORKSPACE);
      win.Show;
      be_app.Run;
      be_app.HideCursor;  	  
      be_app.ShowCursor;
	finally
	  MonObj.Free;	
	  aRect.Free;
	  win.Free;
	end;	
end.