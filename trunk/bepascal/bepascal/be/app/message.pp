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

unit message;

interface

uses
  beobj, supportdefs, typeconstants;
  
const
	B_NO_SPECIFIER 				= 0;
	B_DIRECT_SPECIFIER 			= 1;
	B_INDEX_SPECIFIER 			= 2;
	B_REVERSE_INDEX_SPECIFIER 	= 3;
	B_RANGE_SPECIFIER 			= 4;
	B_REVERSE_RANGE_SPECIFIER 	= 5;
	B_NAME_SPECIFIER 			= 6; 
	B_ID_SPECIFIER 				= 7;

	B_SPECIFIERS_END 			= 128;

	B_FIELD_NAME_LENGTH 		= 255;
	B_PROPERTY_NAME_LENGTH		= 255;
	
type
	TMessage = class(TBeObject)
	private
	  function GetWhat : Cardinal;
	  procedure SetWhat(aWhat : Cardinal);
	public
	  constructor Create; override;
	  constructor Create(Command : Cardinal); virtual;
	  constructor Create(var Message : TMessage); virtual;
	  destructor Destroy; override;
      function AddData(const Name : PChar; aType : TType_Code; const Data : Pointer; FixedSize : Cardinal; NumItems : Integer) : TStatus_t;
      function AddBool(const Name : PChar; aBool : boolean) : TStatus_t;
      function AddInt8(const Name : PChar; anInt8 : Shortint) : TStatus_t;
      function FindInt8(const Name : PChar; var anInt8 : Shortint) : TStatus_t;
      function AddInt16(const Name : PChar; anInt16 : Smallint) : TStatus_t;
      function AddInt32(const Name : PChar; anInt32 : Integer) : TStatus_t;
      function AddInt64(const Name : PChar; anInt64 : int64) : TStatus_t;
      function AddFloat(const Name : PChar; aFloat : Single) : TStatus_t;
      function AddDouble(const Name : PChar; aDouble : Double) : TStatus_t;
      function AddString(const Name : PChar; aString : PChar) : TStatus_t; 
      function FindString(const Name : PChar; var aString : PChar) : TStatus_t; 
      function AddMessage(const Name : PChar; aMessage : TCPlusObject) : TStatus_t;	  
      function CountNames(aType : TType_Code) : Integer; 
      function HasSpecifiers : boolean;
      function IsSystem : boolean;
      function MakeEmpty : TStatus_t;
      function IsEmpty : boolean;
      function RemoveName(const Name : PChar) : TStatus_t;
      procedure PrintToStream;
      function RemoveData(const name : PChar; index : Integer) : TStatus_t;
      function WasDelivered : boolean;
      function IsSourceRemote : boolean;
      function IsSourceWaiting : boolean;
      function IsReply : boolean;
      function Previous : TMessage;
      function WasDropped : boolean;
	  property What : Cardinal read GetWhat write SetWhat;
	end;

function BMessage_Create(AObject : TObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMessage_Create_1';
function BMessage_Create(AObject : TObject; command : Cardinal) : TCPlusObject; cdecl; external BePascalLibName name 'BMessage_Create_2';
function BMessage_Create(AObject : TObject; var Message : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMessage_Create_3';
procedure BMessage_Free(Message : TCPlusObject); cdecl; external BePascalLibName;
function BMessage_GetWhat(Message : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BMessage_Getwhat';
procedure BMessage_SetWhat(Message : TCPlusObject; What : Cardinal); cdecl; external BePascalLibName name 'BMessage_Setwhat';
function BMessage_AddData(Message : TCPlusObject; const Name : PChar; aType : TType_Code; const Data : Pointer; FixedSize : Cardinal; NumItems : Integer) : TStatus_t; cdecl; external BePascalLibName; 
function BMessage_AddBool(Message : TCPlusObject; const Name : PChar; aBool : boolean) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddInt8(Message : TCPlusObject; const Name : PChar; anInt8 : Shortint) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_FindInt8(Message : TCPlusObject; const Name : PChar; var anInt8 : Shortint) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddInt16(Message : TCPlusObject; const Name : PChar; anInt16 : Smallint) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddInt32(Message : TCPlusObject; const Name : PChar; anInt32 : Integer) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddInt64(Message : TCPlusObject; const Name : PChar; anInt64 : int64) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddFloat(Message : TCPlusObject; const Name : PChar; aFloat : Single) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddDouble(Message : TCPlusObject; const Name : PChar; aDouble : Double) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddString(Message : TCPlusObject; const Name : PChar; aString : PChar) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_FindString(Message : TCPlusObject; const Name : PChar;var aString : PChar) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_AddMessage(Message : TCPlusObject; const Name : PChar; aMessage : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_CountNames(Message : TCPlusObject; aType : TType_Code) : Integer; cdecl; external BePascalLibName;
function BMessage_HasSpecifiers(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_IsSystem(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_MakeEmpty(Message : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_IsEmpty(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_RemoveName(Message : TCPlusObject; const Name : PChar) : TStatus_t; cdecl; external BePascalLibName;
procedure BMessage_PrintToStream(Message : TCPlusObject); cdecl; external BePascalLibName;
function BMessage_RemoveData(Message : TCPlusObject; const name : PChar; index : Integer) : TStatus_t; cdecl; external BePascalLibName;
function BMessage_WasDelivered(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_IsSourceRemote(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_IsSourceWaiting(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_IsReply(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;
function BMessage_Previous(Message : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName;
function BMessage_WasDropped(Message : TCPlusObject) : boolean; cdecl; external BePascalLibName;

implementation

  // start TMessage
constructor TMessage.Create;
begin
  inherited Create; 
  CPlusObject := BMessage_Create(Self);  
end;

constructor TMessage.Create(Command : Cardinal);
begin
  inherited Create;
  CPlusObject := BMessage_Create(Self, Command);	
end;

constructor TMessage.Create(var Message : TMessage);
begin
  inherited Create;
  CPlusObject := BMessage_Create(Self, Message.FCPlusObject);
end;

destructor TMessage.Destroy;
begin
  if CPlusObject <> nil then
    BMessage_Free(CPlusObject);
  inherited;	
end;

function TMessage.GetWhat : Cardinal;
begin
  Result := BMessage_GetWhat(CPlusObject);
end;

procedure TMessage.SetWhat(aWhat : Cardinal);
begin
  BMessage_SetWhat(CPlusObject, aWhat);
end;

function TMessage.AddData(const Name : PChar; aType : TType_Code; const Data : Pointer; FixedSize : Cardinal; NumItems : Integer) : TStatus_t;
begin
  result := BMessage_AddData(CPlusObject, Name, aType, Data, FixedSize, NumItems);
end;

function TMessage.AddBool(const Name : PChar; aBool : boolean) : TStatus_t;
begin
  result := BMessage_AddBool(CPlusObject, Name, aBool);
end;

function TMessage.AddInt8(const Name : PChar; anInt8 : Shortint) : TStatus_t;
begin
  result := BMessage_AddInt8(CPlusObject, Name, anInt8);
end;

function TMessage.FindInt8(const Name : PChar; var anInt8 : Shortint) : TStatus_t;
begin
  result := BMessage_FindInt8(CPlusObject, Name, anInt8);
end;

function TMessage.AddInt16(const Name : PChar; anInt16 : Smallint) : TStatus_t;
begin
  result := BMessage_AddInt16(CPlusObject, Name, anInt16);
end;

function TMessage.AddInt32(const Name : PChar; anInt32 : Integer) : TStatus_t;
begin
  result := BMessage_AddInt32(CPlusObject, Name, anInt32);
end;

function TMessage.AddInt64(const Name : PChar; anInt64 : int64) : TStatus_t;
begin
  result := BMessage_AddInt64(CPlusObject, Name, anInt64);
end;

function TMessage.AddFloat(const Name : PChar; aFloat : Single) : TStatus_t;
begin
  result := BMessage_AddFloat(CPlusObject, Name, aFloat);
end;

function TMessage.AddDouble(const Name : PChar; aDouble : Double) : TStatus_t;
begin
  result := BMessage_AddDouble(CPlusObject, Name, aDouble);
end;

function TMessage.AddString(const Name : PChar; aString : PChar) : TStatus_t; 
begin
  result := BMessage_AddString(CPlusObject, Name, aString);
end;

function TMessage.FindString(const Name : PChar;var aString : PChar) : TStatus_t; 
begin
  result := BMessage_FindString(CPlusObject, Name, aString);
end;

function TMessage.AddMessage(const Name : PChar; aMessage : TCPlusObject) : TStatus_t;	  
begin
  result := BMessage_AddMessage(CPlusObject, Name, aMessage);
end;

function TMessage.CountNames(aType : TType_Code) : Integer; 
begin
  result := BMessage_CountNames(CPlusObject, aType);
end;

function TMessage.HasSpecifiers : boolean;
begin
  result := BMessage_HasSpecifiers(CPlusObject);
end;

function TMessage.IsSystem : boolean;
begin
  result := BMessage_IsSystem(CPlusObject);
end;

function TMessage.MakeEmpty : TStatus_t;
begin
  result := BMessage_MakeEmpty(CPlusObject);
end;

function TMessage.IsEmpty : boolean;
begin
  result := BMessage_IsEmpty(CPlusObject);
end;

function TMessage.RemoveName(const Name : PChar) : TStatus_t;
begin
  result := BMessage_RemoveName(CPlusObject, Name);
end;

procedure TMessage.PrintToStream;
begin
  BMessage_PrintToStream(CPlusObject);
end;

function TMessage.RemoveData(const name : PChar; index : Integer) : TStatus_t;
begin
  result := BMessage_RemoveData(CPlusObject, name, index);
end;

function TMessage.WasDelivered : boolean;
begin
  result := BMessage_WasDelivered(CPlusObject);
end;

function TMessage.IsSourceRemote : boolean;
begin
  result := BMessage_IsSourceRemote(CPlusObject);
end;

function TMessage.IsSourceWaiting : boolean;
begin
  result := BMessage_IsSourceWaiting(CPlusObject);
end;

function TMessage.IsReply : boolean;
begin
  result := BMessage_IsReply(CPlusObject);
end;

function TMessage.Previous : TMessage;
begin
  result := TMessage.Wrap(BMessage_Previous(CPlusObject));
end;

function TMessage.WasDropped : boolean;
begin
  result := BMessage_WasDropped(CPlusObject);
end;

end.