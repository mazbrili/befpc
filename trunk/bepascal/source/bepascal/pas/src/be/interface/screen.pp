{   BePascal - A pascal wrapper around the BeOS API                             
    Copyright (C) 2002 Olivier Coursiere                                        
                       Eric Jourde                                              
                                                                                
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
unit screen;

interface

uses
  beobj,interfacedefs,window,bitmap,rect,graphicdefs,SupportDefs,accelerant;

type
  BScreen = class(TBeObject)
  private
  public
    constructor Create; override;
    //constructor Create(win : BWindow);
    destructor Destroy;override;
    function IsValid : boolean;
    function SetToNext : Status_t;
    function ColorSpace : Color_Space;
    function Frame : BRect;
    function ID : screen_id;
    function WaitForRetrace : Status_t;
    function WaitForRetrace(timeout : Bigtime_t) : Status_t;
    function IndexForColor(rgb : rgb_color) : integer;
    function IndexForColor(r : integer; g : integer; b : integer; a : integer) : integer;
    function ColorForIndex(index : integer) : rgb_color;
    function InvertIndex(index : integer) : integer;
    function ColorMap : color_map;
    function GetBitmap(screen_shot : BBitmap; draw_cursor : boolean; bound : BRect) : Status_t;
    function ReadBitmap(buffer : BBitmap; draw_cursor : boolean; bound : BRect) : Status_t;
    function DesktopColor : rgb_color;
    function DesktopColor(index : Cardinal) : rgb_color;
    procedure SetDesktopColor(rgb : rgb_color; stick : boolean);
    procedure SetDesktopColor(rgb : rgb_color; index : Cardinal; stick : boolean);
    function ProposeMode(target : display_mode; low : display_mode; high : display_mode) : Status_t;
    function GetModeList(mode_list : display_mode; count :  integer) : Status_t;
    function GetMode(mode : display_mode) : Status_t;
    function GetMode(workspace : Cardinal; mode : display_mode) : Status_t;
    function SetMode(mode : display_mode; makeDefault : boolean) : Status_t;
    function SetMode(workspace : Cardinal; mode : display_mode; makeDefault : boolean) : Status_t;
    function GetDeviceInfo(adi :  accelerant_device_info) : Status_t;
    function GetPixelClockLimits(mode : display_mode; low :  integer; high :  integer) : Status_t;
    function GetTimingConstraints(dtc : display_timing_constraints) : Status_t;
    function SetDPMS(dpms_state : Cardinal) : Status_t;
    function DPMSState : Cardinal;
    function DPMSCapabilites : Cardinal;
   // function private_screen : BPrivateScreen;
  end;

function BScreen_Create(AObject : TBeObject): TCPlusObject; cdecl; external BePascalLibName name 'BScreen_Create';
//function BScreen_Create(AObject : TBeObject; win : TCPlusObject); cdecl; external BePascalLibName name 'BScreen_Create';
procedure BScreen_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BScreen_Free';
function BScreen_IsValid(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BScreen_IsValid';
function BScreen_SetToNext(AObject : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BScreen_SetToNext';
function BScreen_ColorSpace(AObject : TCPlusObject) : Color_Space; cdecl; external BePascalLibName name 'BScreen_ColorSpace';
function BScreen_Frame(AObject : TCPlusObject) : BRect; cdecl; external BePascalLibName name 'BScreen_Frame';
function BScreen_ID(AObject : TCPlusObject) : screen_id; cdecl; external BePascalLibName name 'BScreen_ID';
function BScreen_WaitForRetrace(AObject : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BScreen_WaitForRetrace';
function BScreen_WaitForRetrace(AObject : TCPlusObject; timeout : Bigtime_t) : Status_t; cdecl; external BePascalLibName name 'BScreen_WaitForRetrace';
function BScreen_IndexForColor(AObject : TCPlusObject; rgb : rgb_color) : integer; cdecl; external BePascalLibName name 'BScreen_IndexForColor';
function BScreen_IndexForColor(AObject : TCPlusObject; r : integer; g : integer; b : integer; a : integer) : integer; cdecl; external BePascalLibName name 'BScreen_IndexForColor';
function BScreen_ColorForIndex(AObject : TCPlusObject; index : integer) : rgb_color; cdecl; external BePascalLibName name 'BScreen_ColorForIndex';
function BScreen_InvertIndex(AObject : TCPlusObject; index : integer) : integer; cdecl; external BePascalLibName name 'BScreen_InvertIndex';
function BScreen_ColorMap(AObject : TCPlusObject) : color_map; cdecl; external BePascalLibName name 'BScreen_ColorMap';
function BScreen_GetBitmap(AObject : TCPlusObject; screen_shot : TCPlusObject; draw_cursor : boolean; bound : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetBitmap';
function BScreen_ReadBitmap(AObject : TCPlusObject; buffer : TCPlusObject; draw_cursor : boolean; bound : TCPlusObject) : Status_t; cdecl; external BePascalLibName name 'BScreen_ReadBitmap';
function BScreen_DesktopColor(AObject : TCPlusObject) : rgb_color; cdecl; external BePascalLibName name 'BScreen_DesktopColor';
function BScreen_DesktopColor(AObject : TCPlusObject; index : Cardinal) : rgb_color; cdecl; external BePascalLibName name 'BScreen_DesktopColor';
procedure BScreen_SetDesktopColor(AObject : TCPlusObject; rgb : rgb_color; stick : boolean); cdecl; external BePascalLibName name 'BScreen_SetDesktopColor';
procedure BScreen_SetDesktopColor(AObject : TCPlusObject; rgb : rgb_color; index : Cardinal; stick : boolean); cdecl; external BePascalLibName name 'BScreen_SetDesktopColor';
function BScreen_ProposeMode(AObject : TCPlusObject; target : display_mode; low : display_mode; high : display_mode) : Status_t; cdecl; external BePascalLibName name 'BScreen_ProposeMode';
function BScreen_GetModeList(AObject : TCPlusObject; mode_list : display_mode; count :  integer) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetModeList';
function BScreen_GetMode(AObject : TCPlusObject; mode : display_mode) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetMode';
function BScreen_GetMode(AObject : TCPlusObject; workspace : Cardinal; mode : display_mode) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetMode';
function BScreen_SetMode(AObject : TCPlusObject; mode : display_mode; makeDefault : boolean) : Status_t; cdecl; external BePascalLibName name 'BScreen_SetMode';
function BScreen_SetMode(AObject : TCPlusObject; workspace : Cardinal; mode : display_mode; makeDefault : boolean) : Status_t; cdecl; external BePascalLibName name 'BScreen_SetMode';
function BScreen_GetDeviceInfo(AObject : TCPlusObject; adi :  accelerant_device_info) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetDeviceInfo';
function BScreen_GetPixelClockLimits(AObject : TCPlusObject; mode : display_mode; low :  integer; high :  integer) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetPixelClockLimits';
function BScreen_GetTimingConstraints(AObject : TCPlusObject; dtc : display_timing_constraints) : Status_t; cdecl; external BePascalLibName name 'BScreen_GetTimingConstraints';
function BScreen_SetDPMS(AObject : TCPlusObject; dpms_state : Cardinal) : Status_t; cdecl; external BePascalLibName name 'BScreen_SetDPMS';
function BScreen_DPMSState(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BScreen_DPMSState';
function BScreen_DPMSCapabilites(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BScreen_DPMSCapabilites';
//function BScreen_private_screen(AObject : TCPlusObject) : BPrivateScreen; cdecl; external BePascalLibName name 'BScreen_private_screen';

implementation

constructor BScreen.Create;
begin
  CreatePas;
  CPlusObject := BScreen_Create(Self);
end;

{constructor BScreen.Create(win : BWindow);
begin
  CPlusObject := BScreen_Create(Self, win.CPlusObject);
end;
}
destructor BScreen.Destroy;
begin
  BScreen_Free(CPlusObject);
  inherited;
end;

function BScreen.IsValid : boolean;
begin
  Result := BScreen_IsValid(CPlusObject);
end;

function BScreen.SetToNext : Status_t;
begin
  Result := BScreen_SetToNext(CPlusObject);
end;

function BScreen.ColorSpace : Color_Space;
begin
  Result := BScreen_ColorSpace(CPlusObject);
end;

function BScreen.Frame : BRect;
begin
  Result := BScreen_Frame(CPlusObject);
end;

function BScreen.ID : screen_id;
begin
  Result := BScreen_ID(CPlusObject);
end;

function BScreen.WaitForRetrace : Status_t;
begin
  Result := BScreen_WaitForRetrace(CPlusObject);
end;

function BScreen.WaitForRetrace(timeout : Bigtime_t) : Status_t;
begin
  Result := BScreen_WaitForRetrace(CPlusObject, timeout);
end;

function BScreen.IndexForColor(rgb : rgb_color) : integer;
begin
  Result := BScreen_IndexForColor(CPlusObject, rgb);
end;

function BScreen.IndexForColor(r : integer; g : integer; b : integer; a : integer) : integer;
begin
  Result := BScreen_IndexForColor(CPlusObject, r, g, b, a);
end;

function BScreen.ColorForIndex(index : integer) : rgb_color;
begin
  Result := BScreen_ColorForIndex(CPlusObject, index);
end;

function BScreen.InvertIndex(index : integer) : integer;
begin
  Result := BScreen_InvertIndex(CPlusObject, index);
end;

function BScreen.ColorMap : color_map;
begin
  Result := BScreen_ColorMap(CPlusObject);
end;

function BScreen.GetBitmap(screen_shot : BBitmap; draw_cursor : boolean; bound : BRect) : Status_t;
begin
  Result := BScreen_GetBitmap(CPlusObject, screen_shot.CPlusObject, draw_cursor, bound.CPlusObject);
end;

function BScreen.ReadBitmap(buffer : BBitmap; draw_cursor : boolean; bound : BRect) : Status_t;
begin
  Result := BScreen_ReadBitmap(CPlusObject, buffer.CPlusObject, draw_cursor, bound.CPlusObject);
end;

function BScreen.DesktopColor : rgb_color;
begin
  Result := BScreen_DesktopColor(CPlusObject);
end;

function BScreen.DesktopColor(index : Cardinal) : rgb_color;
begin
  Result := BScreen_DesktopColor(CPlusObject, index);
end;

procedure BScreen.SetDesktopColor(rgb : rgb_color; stick : boolean);
begin
  BScreen_SetDesktopColor(CPlusObject, rgb, stick);
end;

procedure BScreen.SetDesktopColor(rgb : rgb_color; index : Cardinal; stick : boolean);
begin
  BScreen_SetDesktopColor(CPlusObject, rgb, index, stick);
end;

function BScreen.ProposeMode(target : display_mode; low : display_mode; high : display_mode) : Status_t;
begin
  Result := BScreen_ProposeMode(CPlusObject, target, low, high);
end;

function BScreen.GetModeList(mode_list : display_mode; count :  integer) : Status_t;
begin
  Result := BScreen_GetModeList(CPlusObject, mode_list, count);
end;

function BScreen.GetMode(mode : display_mode) : Status_t;
begin
  Result := BScreen_GetMode(CPlusObject, mode);
end;

function BScreen.GetMode(workspace : Cardinal; mode : display_mode) : Status_t;
begin
  Result := BScreen_GetMode(CPlusObject, workspace, mode);
end;

function BScreen.SetMode(mode : display_mode; makeDefault : boolean) : Status_t;
begin
  Result := BScreen_SetMode(CPlusObject, mode, makeDefault);
end;

function BScreen.SetMode(workspace : Cardinal; mode : display_mode; makeDefault : boolean) : Status_t;
begin
  Result := BScreen_SetMode(CPlusObject, workspace, mode, makeDefault);
end;

function BScreen.GetDeviceInfo(adi :  accelerant_device_info) : Status_t;
begin
  Result := BScreen_GetDeviceInfo(CPlusObject, adi);
end;

function BScreen.GetPixelClockLimits(mode : display_mode; low :  integer; high :  integer) : Status_t;
begin
  Result := BScreen_GetPixelClockLimits(CPlusObject, mode, low, high);
end;

function BScreen.GetTimingConstraints(dtc : display_timing_constraints) : Status_t;
begin
  Result := BScreen_GetTimingConstraints(CPlusObject, dtc);
end;

function BScreen.SetDPMS(dpms_state : Cardinal) : Status_t;
begin
  Result := BScreen_SetDPMS(CPlusObject, dpms_state);
end;

function BScreen.DPMSState : Cardinal;
begin
  Result := BScreen_DPMSState(CPlusObject);
end;

function BScreen.DPMSCapabilites : Cardinal;
begin
  Result := BScreen_DPMSCapabilites(CPlusObject);
end;

{function BScreen.private_screen : BPrivateScreen;
begin
  Result := BScreen_private_screen(CPlusObject);
end;
}


end.
