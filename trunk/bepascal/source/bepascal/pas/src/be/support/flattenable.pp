{  BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002  Olivier Coursière
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

unit Flattenable;

interface

uses
  beobj, SupportDefs, os;

type
  BFlattenable = class(TBeObject)
  private
  public
    constructor Create; override;
    destructor Destroy; override;

  function IsFixedSize : boolean;
  function TypeCode : Type_code;
  function 	Flatten( buffer :pointer; size :  ssize_t) : Status_t;
  function 	AllowsTypeCode( code : Type_code) : boolean;
  function	Unflatten(c :Type_code ; buf :pointer ;  size: ssize_t) :	Status_t;
 
 end;


procedure BFlattenable_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BFlattenable_Free';

function BFlattenable_IsFixedSize(AObject : TCPlusObject) : boolean;cdecl; external BePascalLibName name 'BFlattenable_IsFixedSize';
function BFlattenable_TypeCode(AObject : TCPlusObject) : Type_code;cdecl; external BePascalLibName name 'BFlattenable_TypeCode';
function 	BFlattenable_Flatten( AObject : TCPlusObject;buffer :pointer; size :  ssize_t) : Status_t;cdecl; external BePascalLibName name 'BFlattenable_Flatten';
function 	BFlattenable_AllowsTypeCode( AObject : TCPlusObject;code : Type_code) : boolean;cdecl; external BePascalLibName name 'BFlattenable_AllowsTypeCode';
function	BFlattenable_Unflatten(AObject : TCPlusObject;c :Type_code ; buf :pointer ;  size: ssize_t) :	Status_t;cdecl; external BePascalLibName name 'BFlattenable_Unflatten';


implementation



constructor BFlattenable.Create;
begin
  CreatePas;
  CPlusObject:=self;
end;


destructor BFlattenable.Destroy; 
begin
   if CPlusObject <> nil then
    BFlattenable_Free(CPlusObject);
  inherited;
end;

function BFlattenable.IsFixedSize : boolean;
begin
   result:=BFlattenable_IsFixedSize(CPlusObject);
end;

function BFlattenable.TypeCode : Type_code;
begin
   result:=BFlattenable_TypeCode(CPlusObject);
end;

function 	BFlattenable.Flatten( buffer :pointer; size :  ssize_t) : Status_t;
begin
   result:=BFlattenable_Flatten(CPlusObject,buffer,size);
end;

function 	BFlattenable.AllowsTypeCode( code : Type_code) : boolean;
begin
   result:=BFlattenable_AllowsTypeCode(CPlusObject,code);
end;

function	BFlattenable.Unflatten(c :Type_code ; buf :pointer ;  size: ssize_t) :	Status_t;
begin
   result:=BFlattenable_Unflatten(CPlusObject,c,buf,size);
end;


end.
