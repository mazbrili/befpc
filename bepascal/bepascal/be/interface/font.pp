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
unit font;

interface

uses
  beobj,flattenable,interfacedefs,supportdefs,rect,bstring;

type
 Tfont_which=  (
    font_which_nil,
	B_PLAIN_FONT,
	B_BOLD_FONT,
	B_FIXED_FONT,
	B_SYMBOL_FONT,
	B_SERIF_FONT	
);

const
  	B__NUM_FONT		= 5;
  	// Attention this is hexadecimal; need conversion !!!!
	B_ITALIC_FACE		=  $0001;
	B_UNDERSCORE_FACE	= $0002;
	B_NEGATIVE_FACE		= $0004;
	B_OUTLINED_FACE		= $0008;
	B_STRIKEOUT_FACE	= $0010;
	B_BOLD_FACE		    = $0020;
	B_REGULAR_FACE		= $0040;

type

Tfont_metric_mode = (
	B_SCREEN_METRIC,
	B_PRINTING_METRIC);

 Tfont_file_format =(
	B_TRUETYPE_WINDOWS			,
	B_POSTSCRIPT_TYPE1_WINDOWS	
);


const  B_FONT_FAMILY_LENGTH= 63;

type TFONT_FAMILY = array[0..B_FONT_FAMILY_LENGTH] of char;

const B_FONT_STYLE_LENGTH= 63;

type Tfont_style = array[0..B_FONT_STYLE_LENGTH ] of char;

type
Tescapement_delta = record
	nonspace : real;
	space: real;
end;
Tedge_info = record
		left: real;
		right: real;
end;
Ttuned_font_info = record
	 size : real;
	 shear: real ; 
	rotation : real;
	 flags: cardinal;
	   face : integer;
end;



Tfont_height = record
		ascent: real;
		descent: real;
		leading: real;
end;

Tfont_direction =(
	B_FONT_LEFT_TO_RIGHT ,
	B_FONT_RIGHT_TO_LEFT 
);



type
   TFont = class(TBeObject)
  private
  public
    constructor Create;
    constructor Create(font : TFont);virtual;
    destructor  Destroy;override;
    function SetFamilyAndStyle(family : TFONT_FAMILY; style : Tfont_style) : TStatus_t;
    procedure SetFamilyAndStyle(code : Cardinal);
    function SetFamilyAndFace(family : TFONT_FAMILY; aface : integer) : TStatus_t;
    procedure SetSize(asize : single);
    procedure SetShear(ashear : single);
    procedure SetRotation(arotation : single);
    procedure SetSpacing(aspacing : integer);
    procedure SetEncoding(aencoding : integer);
    procedure SetFace(aface :integer );
    procedure SetFlags(aflags : Cardinal);
    procedure GetFamilyAndStyle(family : TFONT_FAMILY; style : Tfont_style);
    function FamilyAndStyle : Cardinal;
    function Size : single;
    function Shear : single;
    function Rotation : single;
    function Spacing : integer;
    function Encoding : integer;
    function Face : integer;
    function Flags : Cardinal;
    function Direction : Tfont_direction;
    function IsFixed : boolean;
    function IsFullAndHalfFixed : boolean;
    function BoundingBox : TRect;
//    function Blocks : ;
    function FileFormat : Tfont_file_format;
    function CountTuned : integer;
    procedure GetTunedInfo(index : integer; info : Ttuned_font_info);
    procedure TruncateString(in_out : TString; mode : Cardinal; width : single);
//    procedure GetTruncatedStrings(stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : Pchar);
//    procedure GetTruncatedStrings(stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : PChar);
    function StringWidth(astring : PChar) : single;
    function StringWidth(astring : PChar; length : integer) : single;
//    procedure GetStringWidths(stringArray : PChar; lengthArray : integer; numStrings : integer; widthArray : single);
//    procedure GetEscapements(charArray : ; numChars : integer; escapementArray : single);
//    procedure GetEscapements(charArray : ; numChars : integer; delta : ; escapementArray : single);
 //   procedure GetEscapements(charArray : ; numChars : integer; delta : ; escapementArray : TPoint);
 //   procedure GetEscapements(charArray : ; numChars : integer; delta : ; escapementArray : TPoint; offsetArray : TPoint);
  //  procedure GetEdges(charArray : ; numBytes : integer; edgeArray : );
   procedure GetHeight(height : Tfont_height);
 //   procedure GetBoundingBoxesAsGlyphs(charArray : ; numChars : integer; mode : ; boundingBoxArray : TRect);
  //  procedure GetBoundingBoxesAsString(charArray : ; numChars : integer; mode : ; delta : ; boundingBoxArray : TRect);
  //  procedure GetBoundingBoxesForStrings(stringArray : PChar; numStrings : integer; mode : ; deltas : ; boundingBoxArray : TRect);
//    procedure GetGlyphShapes(charArray : ; numChars : integer; glyphShapeArray : );
 //   procedure GetHasGlyphs(charArray : ; numChars : integer; hasArray : boolean);
    procedure PrintToStream;
  end;

{procedure edge_info_float left(AObject : TCPlusObject); cdecl; external BePascalLibName name 'edge_info_float left';
procedure edge_info_float right(AObject : TCPlusObject); cdecl; external BePascalLibName name 'edge_info_float right';
procedure font_height_float ascent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_height_float ascent';
procedure font_height_float descent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_height_float descent';
procedure font_height_float leading(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_height_float leading';
procedure escapement_delta_float nonspace(AObject : TCPlusObject); cdecl; external BePascalLibName name 'escapement_delta_float nonspace';
procedure escapement_delta_float space(AObject : TCPlusObject); cdecl; external BePascalLibName name 'escapement_delta_float space';
procedure font_cache_info_int32 sheared_font_penalty(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_cache_info_int32 sheared_font_penalty';
procedure font_cache_info_int32 rotated_font_penalty(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_cache_info_int32 rotated_font_penalty';
procedure font_cache_info_float oversize_threshold(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_cache_info_float oversize_threshold';
procedure font_cache_info_int32 oversize_penalty(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_cache_info_int32 oversize_penalty';
procedure font_cache_info_int32 cache_size(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_cache_info_int32 cache_size';
procedure font_cache_info_float spacing_size_threshold(AObject : TCPlusObject); cdecl; external BePascalLibName name 'font_cache_info_float spacing_size_threshold';
procedure tuned_font_info_float size(AObject : TCPlusObject); cdecl; external BePascalLibName name 'tuned_font_info_float size';
procedure tuned_font_info_float shear(AObject : TCPlusObject); cdecl; external BePascalLibName name 'tuned_font_info_float shear';
procedure tuned_font_info_float rotation(AObject : TCPlusObject); cdecl; external BePascalLibName name 'tuned_font_info_float rotation';
procedure tuned_font_info_uint32 flags(AObject : TCPlusObject); cdecl; external BePascalLibName name 'tuned_font_info_uint32 flags';
procedure tuned_font_info_uint16 face(AObject : TCPlusObject); cdecl; external BePascalLibName name 'tuned_font_info_uint16 face';
}

function BFont_Create(AObject : TBeObject): TCPlusObject; cdecl; external BePascalLibName name 'BFont_Create';
function BFont_Create(AObject : TBeObject; font : TFont): TCPlusObject; cdecl; external BePascalLibName name 'BFont_Create_1';
procedure BFont_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_Free';
function BFont_SetFamilyAndStyle(AObject : TCPlusObject; family : Tfont_family; style : Tfont_style) : TStatus_t; cdecl; external BePascalLibName name 'BFont_SetFamilyAndStyle';
procedure BFont_SetFamilyAndStyle(AObject : TCPlusObject; code : Cardinal); cdecl; external BePascalLibName name 'BFont_SetFamilyAndStyle';
function BFont_SetFamilyAndFace(AObject : TCPlusObject; family : Tfont_family; face : integer) : TStatus_t; cdecl; external BePascalLibName name 'BFont_SetFamilyAndFace';
procedure BFont_SetSize(AObject : TCPlusObject; size : single); cdecl; external BePascalLibName name 'BFont_SetSize';
procedure BFont_SetShear(AObject : TCPlusObject; shear : single); cdecl; external BePascalLibName name 'BFont_SetShear';
procedure BFont_SetRotation(AObject : TCPlusObject; rotation : single); cdecl; external BePascalLibName name 'BFont_SetRotation';
procedure BFont_SetSpacing(AObject : TCPlusObject; spacing : integer); cdecl; external BePascalLibName name 'BFont_SetSpacing';
procedure BFont_SetEncoding(AObject : TCPlusObject; encoding : integer); cdecl; external BePascalLibName name 'BFont_SetEncoding';
procedure BFont_SetFace(AObject : TCPlusObject; face :integer ); cdecl; external BePascalLibName name 'BFont_SetFace';
procedure BFont_SetFlags(AObject : TCPlusObject; flags : Cardinal); cdecl; external BePascalLibName name 'BFont_SetFlags';
procedure BFont_GetFamilyAndStyle(AObject : TCPlusObject; family : Tfont_family; style : Tfont_style); cdecl; external BePascalLibName name 'BFont_GetFamilyAndStyle';
function BFont_FamilyAndStyle(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BFont_FamilyAndStyle';
function BFont_Size(AObject : TCPlusObject) : single; cdecl; external BePascalLibName name 'BFont_Size';
function BFont_Shear(AObject : TCPlusObject) : single; cdecl; external BePascalLibName name 'BFont_Shear';
function BFont_Rotation(AObject : TCPlusObject) : single; cdecl; external BePascalLibName name 'BFont_Rotation';
function BFont_Spacing(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BFont_Spacing';
function BFont_Encoding(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BFont_Encoding';
function BFont_Face(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BFont_Face';
function BFont_Flags(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BFont_Flags';
function BFont_Direction(AObject : TCPlusObject) : Tfont_direction; cdecl; external BePascalLibName name 'BFont_Direction';
function BFont_IsFixed(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BFont_IsFixed';
function BFont_IsFullAndHalfFixed(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BFont_IsFullAndHalfFixed';
function BFont_BoundingBox(AObject : TCPlusObject) : TRect; cdecl; external BePascalLibName name 'BFont_BoundingBox';
//function BFont_Blocks(AObject : TCPlusObject) : ; cdecl; external BePascalLibName name 'BFont_Blocks';
function BFont_FileFormat(AObject : TCPlusObject) :Tfont_file_format ; cdecl; external BePascalLibName name 'BFont_FileFormat';
function BFont_CountTuned(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BFont_CountTuned';
procedure BFont_GetTunedInfo(AObject : TCPlusObject; index : integer; info : Ttuned_font_info); cdecl; external BePascalLibName name 'BFont_GetTunedInfo';
procedure BFont_TruncateString(AObject : TCPlusObject; in_out : TCPlusObject; mode : Cardinal; width : single); cdecl; external BePascalLibName name 'BFont_TruncateString';
//procedure BFont_GetTruncatedStrings(AObject : TCPlusObject; stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : ); cdecl; external BePascalLibName name 'BFont_GetTruncatedStrings';
//procedure BFont_GetTruncatedStrings(AObject : TCPlusObject; stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : PChar); cdecl; external BePascalLibName name 'BFont_GetTruncatedStrings';
function BFont_StringWidth(AObject : TCPlusObject; astring : PChar) : single; cdecl; external BePascalLibName name 'BFont_StringWidth';
function BFont_StringWidth(AObject : TCPlusObject; astring : PChar; length : integer) : single; cdecl; external BePascalLibName name 'BFont_StringWidth';
//procedure BFont_GetStringWidths(AObject : TCPlusObject; stringArray : PChar; lengthArray : ; numStrings : integer; widthArray : single); cdecl; external BePascalLibName name 'BFont_GetStringWidths';
//procedure BFont_GetEscapements(AObject : TCPlusObject; charArray : ; numChars : integer; escapementArray : single); cdecl; external BePascalLibName name 'BFont_GetEscapements';
//procedure BFont_GetEscapements(AObject : TCPlusObject; charArray : ; numChars : integer; delta : ; escapementArray : single); cdecl; external BePascalLibName name 'BFont_GetEscapements';
//procedure BFont_GetEscapements(AObject : TCPlusObject; charArray : ; numChars : integer; delta : ; escapementArray : TPoint); cdecl; external BePascalLibName name 'BFont_GetEscapements';
//procedure BFont_GetEscapements(AObject : TCPlusObject; charArray : ; numChars : integer; delta : ; escapementArray : TPoint; offsetArray : TPoint); cdecl; external BePascalLibName name 'BFont_GetEscapements';
//procedure BFont_GetEdges(AObject : TCPlusObject; charArray : ; numBytes : integer; edgeArray : ); cdecl; external BePascalLibName name 'BFont_GetEdges';
procedure BFont_GetHeight(AObject : TCPlusObject; height :Tfont_height ); cdecl; external BePascalLibName name 'BFont_GetHeight';

{procedure BFont_GetBoundingBoxesAsGlyphs(AObject : TCPlusObject; charArray : ; numChars : integer; mode : ; boundingBoxArray : TRect); cdecl; external BePascalLibName name 'BFont_GetBoundingBoxesAsGlyphs';
procedure BFont_GetBoundingBoxesAsString(AObject : TCPlusObject; charArray : ; numChars : integer; mode : ; delta : ; boundingBoxArray : TRect); cdecl; external BePascalLibName name 'BFont_GetBoundingBoxesAsString';
procedure BFont_GetBoundingBoxesForStrings(AObject : TCPlusObject; stringArray : PChar; numStrings : integer; mode : ; deltas : ; boundingBoxArray : TRect); cdecl; external BePascalLibName name 'BFont_GetBoundingBoxesForStrings';
procedure BFont_GetGlyphShapes(AObject : TCPlusObject; charArray : ; numChars : integer; glyphShapeArray : ); cdecl; external BePascalLibName name 'BFont_GetGlyphShapes';
procedure BFont_GetHasGlyphs(AObject : TCPlusObject; charArray : ; numChars : integer; hasArray : boolean); cdecl; external BePascalLibName name 'BFont_GetHasGlyphs';
function BFont_operator=(AObject : TCPlusObject; font : ) : ; cdecl; external BePascalLibName name 'BFont_operator=';
function BFont_operator==(AObject : TCPlusObject; font : ) : boolean; cdecl; external BePascalLibName name 'BFont_operator==';
function BFont_operator!=(AObject : TCPlusObject; font : ) : boolean; cdecl; external BePascalLibName name 'BFont_operator!=';
}
procedure BFont_PrintToStream(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_PrintToStream';
{procedure BFont_uint16 fFamilyID(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint16 fFamilyID';
procedure BFont_uint16 fStyleID(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint16 fStyleID';
procedure BFont_float fSize(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_float fSize';
procedure BFont_float fShear(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_float fShear';
procedure BFont_float fRotation(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_float fRotation';
procedure BFont_uint8 fSpacing(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint8 fSpacing';
procedure BFont_uint8 fEncoding(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint8 fEncoding';
procedure BFont_uint16 fFace(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint16 fFace';
procedure BFont_uint32 fFlags(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint32 fFlags';
procedure BFont_font_height fHeight(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_font_height fHeight';
procedure BFont_int32 fPrivateFlags(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_int32 fPrivateFlags';
procedure BFont_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFont_uint32 _reserved[2]';
procedure BFont_SetPacket(AObject : TCPlusObject; packet : Pointer); cdecl; external BePascalLibName name 'BFont_SetPacket';
procedure BFont_GetTruncatedStrings64(AObject : TCPlusObject; stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : PChar); cdecl; external BePascalLibName name 'BFont_GetTruncatedStrings64';
procedure BFont_GetTruncatedStrings64(AObject : TCPlusObject; stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : ); cdecl; external BePascalLibName name 'BFont_GetTruncatedStrings64';
procedure BFont__GetEscapements_(AObject : TCPlusObject; charArray : ; numChars : integer; delta : ; mode : ; escapements : single; offsets : single); cdecl; external BePascalLibName name 'BFont__GetEscapements_';
procedure BFont__GetBoundingBoxes_(AObject : TCPlusObject; charArray : ; numChars : integer; mode : ; string_escapement : boolean; delta : ; boundingBoxArray : TRect); cdecl; external BePascalLibName name 'BFont__GetBoundingBoxes_';
}
implementation


constructor  TFont.Create;
begin
  inherited Create;
  CPlusObject := BFont_Create(Self);
end;

constructor  TFont.Create(font : TFont);
begin
  inherited Create;
  CPlusObject := BFont_Create(Self, font);
end;

destructor  TFont.Destroy;
begin
  if CPlusObject <> nil then
    BFont_Free(CPlusObject);
  inherited;
end;

function  TFont.SetFamilyAndStyle(family : Tfont_family; style :Tfont_style ) : TStatus_t;
begin
  Result := BFont_SetFamilyAndStyle(CPlusObject, family, style);
end;

procedure  TFont.SetFamilyAndStyle(code : Cardinal);
begin
  BFont_SetFamilyAndStyle(CPlusObject, code);
end;

function  TFont.SetFamilyAndFace(family : Tfont_family; aface : integer) : TStatus_t;
begin
  Result := BFont_SetFamilyAndFace(CPlusObject, family, aface);
end;

procedure  TFont.SetSize(asize : single);
begin
  BFont_SetSize(CPlusObject, asize);
end;

procedure  TFont.SetShear(ashear : single);
begin
  BFont_SetShear(CPlusObject, ashear);
end;

procedure  TFont.SetRotation(arotation : single);
begin
  BFont_SetRotation(CPlusObject, arotation);
end;

procedure  TFont.SetSpacing(aspacing : integer);
begin
  BFont_SetSpacing(CPlusObject, aspacing);
end;

procedure  TFont.SetEncoding(aencoding : integer);
begin
  BFont_SetEncoding(CPlusObject, aencoding);
end;

procedure  TFont.SetFace(aface : integer);
begin
  BFont_SetFace(CPlusObject, aface);
end;

procedure  TFont.SetFlags(aflags : Cardinal);
begin
  BFont_SetFlags(CPlusObject, aflags);
end;

procedure  TFont.GetFamilyAndStyle(family : Tfont_family; style :Tfont_style );
begin
  BFont_GetFamilyAndStyle(CPlusObject, family, style);
end;

function  TFont.FamilyAndStyle : Cardinal;
begin
  Result := BFont_FamilyAndStyle(CPlusObject);
end;

function  TFont.Size : single;
begin
  Result := BFont_Size(CPlusObject);
end;

function  TFont.Shear : single;
begin
  Result := BFont_Shear(CPlusObject);
end;

function  TFont.Rotation : single;
begin
  Result := BFont_Rotation(CPlusObject);
end;

function  TFont.Spacing : integer;
begin
  Result := BFont_Spacing(CPlusObject);
end;

function  TFont.Encoding : integer;
begin
  Result := BFont_Encoding(CPlusObject);
end;

function  TFont.Face : integer;
begin
  Result := BFont_Face(CPlusObject);
end;

function  TFont.Flags : Cardinal;
begin
  Result := BFont_Flags(CPlusObject);
end;

function  TFont.Direction : Tfont_direction;
begin
  Result := BFont_Direction(CPlusObject);
end;

function  TFont.IsFixed : boolean;
begin
  Result := BFont_IsFixed(CPlusObject);
end;

function  TFont.IsFullAndHalfFixed : boolean;
begin
  Result := BFont_IsFullAndHalfFixed(CPlusObject);
end;

function  TFont.BoundingBox : TRect;
begin
  Result := BFont_BoundingBox(CPlusObject);
end;

{function  TFont.Blocks : ;
begin
  Result := BFont_Blocks(CPlusObject);
end;
}
function  TFont.FileFormat : Tfont_file_format;
begin
  Result := BFont_FileFormat(CPlusObject);
end;

function  TFont.CountTuned : integer;
begin
  Result := BFont_CountTuned(CPlusObject);
end;

procedure  TFont.GetTunedInfo(index : integer; info : Ttuned_font_info);
begin
  BFont_GetTunedInfo(CPlusObject, index, info);
end;

procedure  TFont.TruncateString(in_out : TString; mode : Cardinal; width : single);
begin
  BFont_TruncateString(CPlusObject, in_out.CPlusObject, mode, width);
end;

{procedure  TFont.GetTruncatedStrings(stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : );
begin
  BFont_GetTruncatedStrings(CPlusObject, stringArray, numStrings, mode, width, resultArray.CPlusObject);
end;

procedure  TFont.GetTruncatedStrings(stringArray : PChar; numStrings : integer; mode : Cardinal; width : single; resultArray : PChar);
begin
  BFont_GetTruncatedStrings(CPlusObject, stringArray, numStrings, mode, width, resultArray);
end;
}

function  TFont.StringWidth(astring : PChar) : single;
begin
  Result := BFont_StringWidth(CPlusObject, astring);
end;

function  TFont.StringWidth(astring : PChar; length : integer) : single;
begin
  Result := BFont_StringWidth(CPlusObject, astring, length);
end;

{procedure  TFont.GetStringWidths(stringArray : PChar; lengthArray : integer ; numStrings : integer; widthArray : single);
begin
  BFont_GetStringWidths(CPlusObject, stringArray, lengthArray, numStrings, widthArray);
end;

procedure  TFont.GetEscapements(charArray : PChar; numChars : integer; escapementArray : single);
begin
  BFont_GetEscapements(CPlusObject, charArray, numChars, escapementArray);
end;

procedure  TFont.GetEscapements(charArray : ; numChars : integer; delta : ; escapementArray : single);
begin
  BFont_GetEscapements(CPlusObject, charArray, numChars, delta, escapementArray);
end;

procedure  TFont.GetEscapements(charArray : ; numChars : integer; delta : ; escapementArray : TPoint);
begin
  BFont_GetEscapements(CPlusObject, charArray, numChars, delta, escapementArray.CPlusObject);
end;

procedure  TFont.GetEscapements(charArray : ; numChars : integer; delta : ; escapementArray : TPoint; offsetArray : TPoint);
begin
  BFont_GetEscapements(CPlusObject, charArray, numChars, delta, escapementArray.CPlusObject, offsetArray.CPlusObject);
end;

procedure  TFont.GetEdges(charArray : ; numBytes : integer; edgeArray : );
begin
  BFont_GetEdges(CPlusObject, charArray, numBytes, edgeArray);
end;
}
procedure  TFont.GetHeight(height :Tfont_height );
begin
  BFont_GetHeight(CPlusObject, height);
end;

{
procedure  TFont.GetBoundingBoxesAsGlyphs(charArray : ; numChars : integer; mode : ; boundingBoxArray : TRect);
begin
  BFont_GetBoundingBoxesAsGlyphs(CPlusObject, charArray, numChars, mode, boundingBoxArray.CPlusObject);
end;

procedure  TFont.GetBoundingBoxesAsString(charArray : ; numChars : integer; mode : ; delta : ; boundingBoxArray : TRect);
begin
  BFont_GetBoundingBoxesAsString(CPlusObject, charArray, numChars, mode, delta, boundingBoxArray.CPlusObject);
end;

procedure  TFont.GetBoundingBoxesForStrings(stringArray : PChar; numStrings : integer; mode : ; deltas : ; boundingBoxArray : TRect);
begin
  BFont_GetBoundingBoxesForStrings(CPlusObject, stringArray, numStrings, mode, deltas, boundingBoxArray.CPlusObject);
end;

procedure  TFont.GetGlyphShapes(charArray : ; numChars : integer; glyphShapeArray : );
begin
  BFont_GetGlyphShapes(CPlusObject, charArray, numChars, glyphShapeArray.CPlusObject);
end;

procedure  TFont.GetHasGlyphs(charArray : ; numChars : integer; hasArray : boolean);
begin
  BFont_GetHasGlyphs(CPlusObject, charArray, numChars, hasArray);
end;
}
procedure  TFont.PrintToStream;
begin
  BFont_PrintToStream(CPlusObject);
end;


end.
