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
	archivable, handler, toto, rect, window, view, graphicdefs, dataio, 
	invoker, messenger, Control, Button;
	
type
  TMonApplication = class(TApplication)
  public
  	procedure ReadyToRun; override;
  	procedure MessageReceived(aMessage : TMessage); override;
  	function QuitRequested : boolean; override;
  end;
  TMyWindow = class(TWindow)
  private
    aView : TView;
    aButton : TButton;    
  public
    constructor Create(aFrame : TRect; title : PChar; atype, aFlags, aWorkspaces : Cardinal); override;
    destructor Destroy; override;
    procedure MessageReceived(amessage : TMessage); override;    
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

constructor TMyWindow.Create(aFrame : TRect; title : PChar; atype, aFlags, aWorkspaces : Cardinal);
var
  aRect, aRect2 : TRect;  
  rgb_color : TRGB_color;
  mess : TMessage;
begin
  inherited;
  aRect := TRect.Create(20, 20, 100, 100);
  try
    aRect2 := TRect.Create(110, 110, 150, 150);
    try
      aView := TView.Create(aRect, 'Test', B_FOLLOW_ALL, B_WILL_DRAW);
      rgb_color.red := 255;
      rgb_color.green := 0;
      rgb_color.blue := 0;
      rgb_color.alpha := 0;
      aView.SetViewColor(rgb_color);  
      Self.AddChild(aView, nil);
      mess := TMessage.Create(77777);
      aButton := TButton.Create(aRect2, 'Test2', 'Test2', mess, B_FOLLOW_LEFT or B_FOLLOW_TOP, B_WILL_DRAW or B_NAVIGABLE);
      aButton.SetViewColor(rgb_color);
      WriteLn('before addchild');
      Self.AddChild(aButton, nil);
      WriteLn('after addchild');          
//      aButton.Invoker.SetTarget(aView, nil);
      if aButton.IsEnabled then
        WriteLn('Actif');
    finally
      aRect2.Free;
    end;
  finally
    aRect.Free;
  end;
end;

destructor TMyWindow.Destroy;
begin
//  aButton.Free;
//  aView.Free;  
  inherited;
end;

procedure TMyWindow.MessageReceived(aMessage : TMessage);
begin
  inherited;
  WriteLn('TMyWindow réception');
  WriteLn(Self.ClassName + '.MessageReceived');
end;

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
//var
//  a, b : string;
//  c : longint;
begin
  inherited;
//  GetLineInfo($A0000DB4, a, b, c);
//  Writeln(a + ' ' + b + ' ' + IntToStr(c));
  WriteLn('Constructor');
end;

procedure TMonObjet.Bonjour(test : string);
//var
//  a, b : string;
//  c : longint;
begin
//  GetLineInfo($8002AEA5, a, b, c);
//  Writeln(a + ' ' + b + ' ' + IntToStr(c));
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
  win : TMyWindow;
    
begin
	beep;
	Write('Hello world !' + #13#10);
	MonObj := TMonObjet.Create;
	TMonApplication.Create;
	try
      aRect := TRect.Create(20, 20, 200, 200);
      win := TMyWindow.Create(aRect, 'Bonjour', B_TITLED_WINDOW, B_NOT_RESIZABLE or B_NOT_ZOOMABLE or B_QUIT_ON_WINDOW_CLOSE, B_CURRENT_WORKSPACE);
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
