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

unit Bitmap;

interface

uses
  BeObj, Archivable, GraphicDefs, Message, OS, Rect, SupportDefs, View;

type
//	PCardinal = ^Cardinal;

  TBitmap = class(TArchivable)
  private
  public
    // I will change "bounds" to "frame" in these constructors...
    // they clash with the Bounds function.
    // Also "bytesPerWow" --> "bytes_per_row"
    constructor Create(frame : TRect; flags : Cardinal; depth : TColor_Space;
                       bytes_per_row : Integer; screenID : TScreenID);
    constructor Create(frame : TRect; depth : TColor_Space;
                       accepts_views : boolean; need_contiguous : boolean);
    constructor Create(source : TBitmap; accepts_views : boolean;
                       need_contiguous : boolean);
    constructor Create(data : TMessage);

    destructor Destroy; override;

    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    function InitCheck : TStatus_t;
    function IsValid : boolean;
    function LockBits(state : PCardinal) : TStatus_t;
    procedure UnlockBits;
    function Area : TArea_ID;
    function Bits : Pointer;
    function BitsLength : Integer;
    function BytesPerRow : Integer;
    function ColorSpace : TColor_Space;
    function Bounds : TRect;
    procedure SetBits(data : Pointer; length : integer; offset : integer;
                      cs : TColor_Space);
    function GetOverlayRestrictions(restrict : TOverlayRestrictions)
             : TStatus_t;
    procedure AddChild(view : TView);
    function RemoveChild(view : TView) : boolean;
    function CountChildren : integer;
    function ChildAt(index : integer) : TView;
    function FindView(view_name : PChar) : TView;
    function FindView(point : TPoint) : TView;
    function Lock : boolean;
    procedure Unlock;
    function IsLocked : boolean;

    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
{
    procedure _ReservedBitmap1;
    procedure _ReservedBitmap2;
    procedure _ReservedBitmap3;
    constructor Create( : TBitmap);
    function operator=( : TBitmap) : TBitmap;
    function get_shared_pointer : PChar;
    procedure set_bits(offset : integer; data : PChar; length : integer);
    procedure set_bits_24(offset : integer; data : PChar; length : integer);
    procedure set_bits_24_local_gray(offset : integer; data : PChar; len : integer);
    procedure set_bits_24_local_256(offset : integer; data : PByte; len : integer);
    procedure set_bits_24_24(offset : integer; data : PChar; length : integer; big_endian_dst : boolean);
    procedure set_bits_8_24(offset : integer; data : PChar; length : integer; big_endian_dst : boolean);
    procedure set_bits_gray_24(offset : integer; data : PChar; length : integer; big_endian_dst : boolean);
    function get_server_token : integer;
    procedure InitObject(frame : TRect; depth : TColor_Space; flags : Cardinal; bytesPerRow : integer; screenID : TScreenID);
    procedure AssertPtr;
    procedure void *fBasePtr;
    procedure int32 fSize;
    procedure color_space fType;
    procedure BRect fBound;
    procedure int32 fRowBytes;
    procedure BWindow *fWindow;
    procedure int32 fServerToken;
    procedure int32 fToken;
    procedure uint8 unused;
    procedure area_id fArea;
    procedure area_id fOrigArea;
    procedure uint32 fFlags;
    procedure status_t fInitError;
}
  end;

function BBitmap_Create(AObject : TBeObject; bounds : TCPlusObject;
  flags : Cardinal; depth : TColor_Space; bytesPerRow : Integer;
  screenID : TScreenID) : TCPlusObject; cdecl;
  external BePascalLibName name 'BBitmap_Create';

function BBitmap_Create_1(AObject : TBeObject; bounds : TCPlusObject;
  depth : TColor_Space; accepts_views : boolean; need_contiguous : boolean)
  : TCPlusObject; cdecl; external BePascalLibName name 'BBitmap_Create_1';

function BBitmap_Create_2(AObject : TBeObject; source : TBitmap;
  accepts_views : boolean; need_contiguous : boolean) : TCPlusObject; cdecl;
  external BePascalLibName name 'BBitmap_Create_2';

function BBitmap_Create_3(AObject : TBeObject; data : TCPlusObject)
  : TCPlusObject; cdecl; external BePascalLibName name 'BBitmap_Create_3';


procedure BBitmap_Free(AObject : TCPlusObject); cdecl;
  external BePascalLibName name 'BBitmap_Free';


function BBitmap_Instantiate(AObject : TCPlusObject; data : {TMessage}TCPlusObject)
  : TArchivable; cdecl; external BePascalLibName name 'BBitmap_Instantiate';

function BBitmap_Archive(AObject : TCPlusObject; data : {TMessage}TCPlusObject;
  deep : boolean) : TStatus_t; cdecl;
  external BePascalLibName name 'BBitmap_Archive';

function BBitmap_InitCheck(AObject : TCPlusObject) : TStatus_t; cdecl;
  external BePascalLibName name 'BBitmap_InitCheck';

function BBitmap_IsValid(AObject : TCPlusObject) : boolean; cdecl;
  external BePascalLibName name 'BBitmap_IsValid';

function BBitmap_LockBits(AObject : TCPlusObject; state : PCardinal)
  : TStatus_t; cdecl; external BePascalLibName name 'BBitmap_LockBits';

procedure BBitmap_UnlockBits(AObject : TCPlusObject); cdecl;
  external BePascalLibName name 'BBitmap_UnlockBits';

function BBitmap_Area(AObject : TCPlusObject) : TArea_ID; cdecl;
  external BePascalLibName name 'BBitmap_Area';

function BBitmap_Bits(AObject : TCPlusObject) : Pointer; cdecl;
  external BePascalLibName name 'BBitmap_Bits';

function BBitmap_BitsLength(AObject : TCPlusObject) : integer; cdecl;
  external BePascalLibName name 'BBitmap_BitsLength';

function BBitmap_BytesPerRow(AObject : TCPlusObject) : integer; cdecl;
  external BePascalLibName name 'BBitmap_BytesPerRow';

function BBitmap_ColorSpace(AObject : TCPlusObject) : TColor_Space; cdecl;
  external BePascalLibName name 'BBitmap_ColorSpace';

function BBitmap_Bounds(AObject : TCPlusObject) : TRect; cdecl;
  external BePascalLibName name 'BBitmap_Bounds';

procedure BBitmap_SetBits(AObject : TCPlusObject; data : Pointer;
  length : integer; offset : integer; cs : TColor_Space); cdecl;
  external BePascalLibName name 'BBitmap_SetBits';

function BBitmap_GetOverlayRestrictions(AObject : TCPlusObject;
  restrict : TOverlayRestrictions) : TStatus_t; cdecl;
  external BePascalLibName name 'BBitmap_GetOverlayRestrictions';

procedure BBitmap_AddChild(AObject : TCPlusObject; view : {TView}TCPlusObject); cdecl;
  external BePascalLibName name 'BBitmap_AddChild';

function BBitmap_RemoveChild(AObject : TCPlusObject; view : {TView}TCPlusObject)
  : boolean; cdecl; external BePascalLibName name 'BBitmap_RemoveChild';

function BBitmap_CountChildren(AObject : TCPlusObject) : integer; cdecl;
  external BePascalLibName name 'BBitmap_CountChildren';

function BBitmap_ChildAt(AObject : TCPlusObject; index : integer) : TView;
  cdecl; external BePascalLibName name 'BBitmap_ChildAt';

function BBitmap_FindView(AObject : TCPlusObject; view_name : PChar) : TView;
  cdecl; external BePascalLibName name 'BBitmap_FindView';

function BBitmap_FindView(AObject : TCPlusObject; point : TPoint{TCPlusObject})
  : TView; cdecl; external BePascalLibName name 'BBitmap_FindView';

function BBitmap_Lock(AObject : TCPlusObject) : boolean; cdecl;
  external BePascalLibName name 'BBitmap_Lock';

procedure BBitmap_Unlock(AObject : TCPlusObject); cdecl;
  external BePascalLibName name 'BBitmap_Unlock';

function BBitmap_IsLocked(AObject : TCPlusObject) : boolean; cdecl;
  external BePascalLibName name 'BBitmap_IsLocked';

function BBitmap_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BBitmap_Perform';

{
procedure BBitmap__ReservedBitmap1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap__ReservedBitmap1';
procedure BBitmap__ReservedBitmap2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap__ReservedBitmap2';
procedure BBitmap__ReservedBitmap3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap__ReservedBitmap3';
function BBitmap_Create(AObject : TBeObject;  : TBitmap); cdecl; external BePascalLibName name 'BBitmap_Create';
function BBitmap_operator=(AObject : TCPlusObject;  : TBitmap) : TBitmap; cdecl; external BePascalLibName name 'BBitmap_operator=';
function BBitmap_get_shared_pointer(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BBitmap_get_shared_pointer';
procedure BBitmap_set_bits(AObject : TCPlusObject; offset : integer; data : PChar; length : integer); cdecl; external BePascalLibName name 'BBitmap_set_bits';
procedure BBitmap_set_bits_24(AObject : TCPlusObject; offset : integer; data : PChar; length : integer); cdecl; external BePascalLibName name 'BBitmap_set_bits_24';
procedure BBitmap_set_bits_24_local_gray(AObject : TCPlusObject; offset : integer; data : PChar; len : integer); cdecl; external BePascalLibName name 'BBitmap_set_bits_24_local_gray';
procedure BBitmap_set_bits_24_local_256(AObject : TCPlusObject; offset : integer; data : PByte; len : integer); cdecl; external BePascalLibName name 'BBitmap_set_bits_24_local_256';
procedure BBitmap_set_bits_24_24(AObject : TCPlusObject; offset : integer; data : PChar; length : integer; big_endian_dst : boolean); cdecl; external BePascalLibName name 'BBitmap_set_bits_24_24';
procedure BBitmap_set_bits_8_24(AObject : TCPlusObject; offset : integer; data : PChar; length : integer; big_endian_dst : boolean); cdecl; external BePascalLibName name 'BBitmap_set_bits_8_24';
procedure BBitmap_set_bits_gray_24(AObject : TCPlusObject; offset : integer; data : PChar; length : integer; big_endian_dst : boolean); cdecl; external BePascalLibName name 'BBitmap_set_bits_gray_24';
function BBitmap_get_server_token(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BBitmap_get_server_token';
procedure BBitmap_InitObject(AObject : TCPlusObject; frame : TCPlusObject; depth : TColor_Space; flags : Cardinal; bytesPerRow : integer; screenID : TScreenID); cdecl; external BePascalLibName name 'BBitmap_InitObject';
procedure BBitmap_AssertPtr(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_AssertPtr';
procedure BBitmap_void *fBasePtr(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_void *fBasePtr';
procedure BBitmap_int32 fSize(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_int32 fSize';
procedure BBitmap_color_space fType(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_color_space fType';
procedure BBitmap_BRect fBound(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_BRect fBound';
procedure BBitmap_int32 fRowBytes(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_int32 fRowBytes';
procedure BBitmap_BWindow *fWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_BWindow *fWindow';
procedure BBitmap_int32 fServerToken(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_int32 fServerToken';
procedure BBitmap_int32 fToken(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_int32 fToken';
procedure BBitmap_uint8 unused(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_uint8 unused';
procedure BBitmap_area_id fArea(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_area_id fArea';
procedure BBitmap_area_id fOrigArea(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_area_id fOrigArea';
procedure BBitmap_uint32 fFlags(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_uint32 fFlags';
procedure BBitmap_status_t fInitError(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BBitmap_status_t fInitError';
}

implementation

{ -- NOTE!
  I will change "bounds" to "frame" in these constructors...
  they clash with the Bounds function.

  Also "bytesPerWow" --> "bytes_per_row"
}

//  BBitmap(BRect bounds, uint32 flags, color_space depth,
//    int32 bytesPerRow=B_ANY_BYTES_PER_ROW, screen_id screenID=B_MAIN_SCREEN_ID);
constructor TBitmap.Create(frame{bounds} : TRect; flags : Cardinal;
	depth : TColor_Space; bytes_per_row : Integer; screenID : TScreenID);
begin
  CPlusObject := BBitmap_Create(Self, frame, flags, depth, bytes_per_row,
                                screenID);
end;

//  BBitmap(BRect bounds, color_space depth, bool accepts_views = false,
//    bool need_contiguous = false);
constructor TBitmap.Create(frame{bounds} : TRect; depth : TColor_Space;
  accepts_views : boolean; need_contiguous : Boolean);
begin
  CPlusObject := BBitmap_Create_1(Self, frame.CPlusObject, depth,
                                  accepts_views, need_contiguous);
end;

//  BBitmap(const BBitmap* source, bool accepts_views = false,
//    bool need_contiguous = false);
constructor TBitmap.Create(source : TBitmap; accepts_views : Boolean;
  need_contiguous : Boolean);
begin
  CPlusObject := BBitmap_Create_2(Self, source, accepts_views, need_contiguous);
end;

// BBitmap(BMessage *data);
constructor TBitmap.Create(data : TMessage);
begin
  CPlusObject := BBitmap_Create_3(Self, data.CPlusObject);
end;

destructor TBitmap.Destroy;
begin
  BBitmap_Free(CPlusObject);
  inherited;
end;

function TBitmap.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BBitmap_Instantiate(CPlusObject, data.CPlusObject);
end;

function TBitmap.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BBitmap_Archive(CPlusObject, data.CPlusObject, deep);
end;

function TBitmap.InitCheck : TStatus_t;
begin
  Result := BBitmap_InitCheck(CPlusObject);
end;

function TBitmap.IsValid : boolean;
begin
  Result := BBitmap_IsValid(CPlusObject);
end;

function TBitmap.LockBits(state : PCardinal) : TStatus_t;
begin
  Result := BBitmap_LockBits(CPlusObject, state);
end;

procedure TBitmap.UnlockBits;
begin
  BBitmap_UnlockBits(CPlusObject);
end;

function TBitmap.Area : TArea_ID;
begin
  Result := BBitmap_Area(CPlusObject);
end;

function TBitmap.Bits : Pointer;
begin
  Result := BBitmap_Bits(CPlusObject);
end;

function TBitmap.BitsLength : integer;
begin
  Result := BBitmap_BitsLength(CPlusObject);
end;

function TBitmap.BytesPerRow : integer;
begin
  Result := BBitmap_BytesPerRow(CPlusObject);
end;

function TBitmap.ColorSpace : TColor_Space;
begin
  Result := BBitmap_ColorSpace(CPlusObject);
end;

function TBitmap.Bounds : TRect;
begin
  Result := BBitmap_Bounds(CPlusObject);
end;

procedure TBitmap.SetBits(data : Pointer; length : integer; offset : integer; cs : TColor_Space);
begin
  BBitmap_SetBits(CPlusObject, data, length, offset, cs);
end;

function TBitmap.GetOverlayRestrictions(restrict : TOverlayRestrictions) : TStatus_t;
begin
  Result := BBitmap_GetOverlayRestrictions(CPlusObject, restrict);
end;

procedure TBitmap.AddChild(view : TView);
begin
  BBitmap_AddChild(CPlusObject, view.CPlusObject);
end;

function TBitmap.RemoveChild(view : TView) : boolean;
begin
  Result := BBitmap_RemoveChild(CPlusObject, view.CPlusObject);
end;

function TBitmap.CountChildren : integer;
begin
  Result := BBitmap_CountChildren(CPlusObject);
end;

function TBitmap.ChildAt(index : integer) : TView;
begin
  Result := BBitmap_ChildAt(CPlusObject, index);
end;

function TBitmap.FindView(view_name : PChar) : TView;
begin
  Result := BBitmap_FindView(CPlusObject, view_name);
end;

function TBitmap.FindView(point : TPoint) : TView;
begin
  Result := BBitmap_FindView(CPlusObject, point.CPlusObject);
end;

function TBitmap.Lock : boolean;
begin
  Result := BBitmap_Lock(CPlusObject);
end;

procedure TBitmap.Unlock;
begin
  BBitmap_Unlock(CPlusObject);
end;

function TBitmap.IsLocked : boolean;
begin
  Result := BBitmap_IsLocked(CPlusObject);
end;


function TBitmap.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BBitmap_Perform(CPlusObject, d, arg);
end;


{
procedure TBitmap._ReservedBitmap1;
begin
  BBitmap__ReservedBitmap1(CPlusObject);
end;

procedure TBitmap._ReservedBitmap2;
begin
  BBitmap__ReservedBitmap2(CPlusObject);
end;

procedure TBitmap._ReservedBitmap3;
begin
  BBitmap__ReservedBitmap3(CPlusObject);
end;

constructor TBitmap.Create( : TBitmap);
begin
  CPlusObject := BBitmap_Create(Self, );
end;

function TBitmap.operator=( : TBitmap) : TBitmap;
begin
  Result := BBitmap_operator=(CPlusObject, );
end;

function TBitmap.get_shared_pointer : PChar;
begin
  Result := BBitmap_get_shared_pointer(CPlusObject);
end;

procedure TBitmap.set_bits(offset : integer; data : PChar; length : integer);
begin
  BBitmap_set_bits(CPlusObject, offset, data, length);
end;

procedure TBitmap.set_bits_24(offset : integer; data : PChar; length : integer);
begin
  BBitmap_set_bits_24(CPlusObject, offset, data, length);
end;

procedure TBitmap.set_bits_24_local_gray(offset : integer; data : PChar; len : integer);
begin
  BBitmap_set_bits_24_local_gray(CPlusObject, offset, data, len);
end;

procedure TBitmap.set_bits_24_local_256(offset : integer; data : PByte; len : integer);
begin
  BBitmap_set_bits_24_local_256(CPlusObject, offset, data, len);
end;

procedure TBitmap.set_bits_24_24(offset : integer; data : PChar; length : integer; big_endian_dst : boolean);
begin
  BBitmap_set_bits_24_24(CPlusObject, offset, data, length, big_endian_dst);
end;

procedure TBitmap.set_bits_8_24(offset : integer; data : PChar; length : integer; big_endian_dst : boolean);
begin
  BBitmap_set_bits_8_24(CPlusObject, offset, data, length, big_endian_dst);
end;

procedure TBitmap.set_bits_gray_24(offset : integer; data : PChar; length : integer; big_endian_dst : boolean);
begin
  BBitmap_set_bits_gray_24(CPlusObject, offset, data, length, big_endian_dst);
end;

function TBitmap.get_server_token : integer;
begin
  Result := BBitmap_get_server_token(CPlusObject);
end;

procedure TBitmap.InitObject(frame : TRect; depth : TColor_Space; flags : Cardinal; bytesPerRow : integer; screenID : TScreenID);
begin
  BBitmap_InitObject(CPlusObject, frame.CPlusObject, depth, flags, bytesPerRow, screenID);
end;

procedure TBitmap.AssertPtr;
begin
  BBitmap_AssertPtr(CPlusObject);
end;

procedure TBitmap.void *fBasePtr;
begin
  BBitmap_void *fBasePtr(CPlusObject);
end;

procedure TBitmap.int32 fSize;
begin
  BBitmap_int32 fSize(CPlusObject);
end;

procedure TBitmap.color_space fType;
begin
  BBitmap_color_space fType(CPlusObject);
end;

procedure TBitmap.BRect fBound;
begin
  BBitmap_BRect fBound(CPlusObject);
end;

procedure TBitmap.int32 fRowBytes;
begin
  BBitmap_int32 fRowBytes(CPlusObject);
end;

procedure TBitmap.BWindow *fWindow;
begin
  BBitmap_BWindow *fWindow(CPlusObject);
end;

procedure TBitmap.int32 fServerToken;
begin
  BBitmap_int32 fServerToken(CPlusObject);
end;

procedure TBitmap.int32 fToken;
begin
  BBitmap_int32 fToken(CPlusObject);
end;

procedure TBitmap.uint8 unused;
begin
  BBitmap_uint8 unused(CPlusObject);
end;

procedure TBitmap.area_id fArea;
begin
  BBitmap_area_id fArea(CPlusObject);
end;

procedure TBitmap.area_id fOrigArea;
begin
  BBitmap_area_id fOrigArea(CPlusObject);
end;

procedure TBitmap.uint32 fFlags;
begin
  BBitmap_uint32 fFlags(CPlusObject);
end;

procedure TBitmap.status_t fInitError;
begin
  BBitmap_status_t fInitError(CPlusObject);
end;
}

end.