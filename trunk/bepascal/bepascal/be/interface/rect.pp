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

unit rect;

interface

uses
  beobj;

type
    // TPoint and TRect are defined in the same unit to avoid circular reference
  TPoint = class;
  TRect = class(TBeObject)
  public
    constructor Create; override;
    constructor Create(rect : TRect); virtual; // Problème de référence circulaire avec TPoint
    constructor Create(l, t, r, b : single); virtual;        
    constructor Create(leftTop, rightBottom : TPoint); virtual;
    destructor Destroy; override;
    procedure PrintToStream;
  end;

function BRect_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BRect_Create_1';
function BRect_Create(AObject : TBeObject; rect : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BRect_Create_2';
function BRect_Create(AObject : TBeObject; l, t, r, b : single) : TCPlusObject; cdecl; external BePascalLibName name 'BRect_Create_3';
function BRect_Create(AObject : TBeObject; leftTop, rightBottom : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BRect_Create_4';
procedure BRect_Free(rect : TCPlusObject); cdecl; external BePascalLibName name 'BRect_Free';
procedure BRect_PrintToStream(Rect : TCPlusObject); cdecl; external bePascalLibName name 'BRect_PrintToStream';

type
  TPoint = class(TBeObject)
  public
  	constructor Create; override;
  	constructor Create(x, y : single); virtual;
  	constructor Create(point : TPoint); virtual; 
  	destructor Destroy; override;
  	procedure ConstrainTo(Rect : TRect);
  	procedure PrintToStream;
  	procedure Sept(x, y : single);
  end;
  
function BPoint_Create(AObject : TBeObject; x, y : single) : TCPlusObject; cdecl; external BePascalLibName name 'BPoint_Create_1';
function BPoint_Create(AObject : TBeObject; point : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BPoint_Create_2';
function BPoint_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BPoint_Create_3';
procedure BPoint_Free(Point : TCPlusObject); cdecl; external BePascalLibName name 'BPoint_Free';
procedure BPoint_ConstrainTo(Point : TCPlusObject; Rect : TCPlusObject); cdecl; external BePascalLibName name 'BPoint_ConstrainTo';
procedure BPoint_PrintToStream(Point : TCPlusObject); cdecl; external bePascalLibName name 'BPoint_PrintToStream';
procedure BPoint_Set(Point : TCPlusObject; x, y : single); cdecl; external BePascalLibName name 'BPoint_Set'; 

implementation

constructor TRect.Create;
begin
  inherited Create;
  CPlusObject := BRect_Create(Self);
end;

constructor TRect.Create(rect : TRect);
begin
  inherited Create;
  CPlusObject := BRect_Create(Self, rect.CPlusObject);
end;

constructor TRect.Create(l, t, r, b : single);
begin
  inherited Create;
  CPlusObject := BRect_Create(Self, l, t, r, b);
end;

constructor TRect.Create(leftTop, rightBottom : TPoint);
begin
  inherited Create;
  CPlusObject := BRect_Create(Self, leftTop.CPlusObject, rightBottom.CPlusObject);
end;

destructor TRect.Destroy;
begin
  BRect_Free(CPlusObject);
  inherited Destroy;
end;

procedure TRect.PrintToStream;
begin
  BRect_PrintToStream(CPlusObject);
end;

constructor TPoint.Create(x, y : single);
begin
  inherited Create;
  CPlusObject := BPoint_Create(Self, x, y);
end;

constructor TPoint.Create(point : TPoint);
begin
  inherited Create;
  CPlusObject := BPoint_Create(Self, point.CPlusObject)	
end;

constructor TPoint.Create;
begin
  inherited Create;
  CPlusObject := BPoint_Create(Self);
end;

destructor TPoint.Destroy;
begin
  BPoint_Free(CPlusObject);
  inherited;
end;

procedure TPoint.ConstrainTo(Rect : TRect);
begin
  BPoint_ConstrainTo(CPlusObject, Rect.CPlusObject);
end;

procedure TPoint.PrintToStream;
begin
  BPoint_PrintToStream(CPlusObject);
end;

procedure TPoint.Sept(x, y : single);
begin
  BPoint_Set(CPlusObject, x, y);
end;

initialization

end.