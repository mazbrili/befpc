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
unit listitem;

interface

uses
  beobj, interfacedefs,view,Message, Archivable, SupportDefs, Rect, Handler,font;

type
  TListItem = class(TBeObject)
  private
  public
    constructor Create(aoutlineLevel : longint; expanded : boolean );virtual;
    constructor Create(data : TMessage);
    destructor Destroy;override;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    function Height : double;
    function Width : double;
    function IsSelected : boolean;
    procedure Select;
    procedure Deselect;
    procedure SetEnabled(aon : boolean);
    function IsEnabled : boolean;
    procedure SetHeight(aheight : double);
    procedure SetWidth(awidth : double);
    procedure DrawItem(owner : TView; bounds : TRect; complete : boolean);
    procedure Update(owner : TView; font :  TFont);
 //   function Perform(d : TPerform_code; var arg : Pointer) : TStatus_t;
    function IsExpanded : boolean;
    procedure SetExpanded(expanded : boolean);
    function OutlineLevel : Cardinal;
    function HasSubitems : boolean;
  end;
  
type
  TStringItem = class(TListItem)
  private
  public
    constructor Create( atext: pchar;aoutlineLevel : longint; expanded : boolean);virtual;
    destructor Destroy;override;
    constructor Create(data : TMessage);
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure DrawItem(owner : TView; frame : TRect; complete : boolean);
    procedure SetText( atext : PChar);
    function Text : PChar;
    procedure Update(owner : TView; font :  TFont);
//    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
  end;

function BListItem_Create(AObject : TBeObject;outlineLevel : longint; expanded : boolean): TCPlusObject; cdecl; external BePascalLibName name 'BListItem_Create';
function BListItem_Create(AObject : TBeObject; data : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BListItem_Create_1';
procedure BListItem_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BListItem_Free';
function BListItem_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BListItem_Archive';
function BListItem_Height(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BListItem_Height';
function BListItem_Width(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BListItem_Width';
function BListItem_IsSelected(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BListItem_IsSelected';
procedure BListItem_Select(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BListItem_Select';
procedure BListItem_Deselect(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BListItem_Deselect';
procedure BListItem_SetEnabled(AObject : TCPlusObject; aon : boolean); cdecl; external BePascalLibName name 'BListItem_SetEnabled';
function BListItem_IsEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BListItem_IsEnabled';
procedure BListItem_SetHeight(AObject : TCPlusObject; aheight : double); cdecl; external BePascalLibName name 'BListItem_SetHeight';
procedure BListItem_SetWidth(AObject : TCPlusObject; awidth : double); cdecl; external BePascalLibName name 'BListItem_SetWidth';
procedure BListItem_Update(AObject : TCPlusObject; owner : TCPlusObject; font :  TCPlusObject); cdecl; external BePascalLibName name 'BListItem_Update';
function BListItem_Perform(AObject : TCPlusObject; d : TCPlusObject; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BListItem_Perform';
function BListItem_IsExpanded(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BListItem_IsExpanded';
procedure BListItem_SetExpanded(AObject : TCPlusObject; expanded : boolean); cdecl; external BePascalLibName name 'BListItem_SetExpanded';
function BListItem_OutlineLevel(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BListItem_OutlineLevel';

//function BListItem_HasSubitems(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BListItem_HasSubitems';
procedure BListItem_DrawItem(AObject : TCPlusObject; owner : TCPlusObject; bounds : TCPlusObject; complete : boolean); cdecl; external BePascalLibName name 'BListItem_DrawItem';

function BStringItem_Create(AObject : TBeObject ;text: pchar;lineLevel : longint; expanded : boolean): TCPlusObject;  cdecl; external BePascalLibName name 'BStringItem_Create';
procedure BStringItem_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BStringItem_Free';
function BStringItem_Create(AObject : TBeObject; data : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BStringItem_Create';
function BStringItem_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BStringItem_Instantiate';
function BStringItem_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BStringItem_Archive';
procedure BStringItem_DrawItem(AObject : TCPlusObject; owner : TCPlusObject; frame : TCPlusObject; complete : boolean); cdecl; external BePascalLibName name 'BStringItem_DrawItem';
procedure BStringItem_SetText(AObject : TCPlusObject; text : PChar); cdecl; external BePascalLibName name 'BStringItem_SetText';
function BStringItem_Text(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BStringItem_Text';
procedure BStringItem_Update(AObject : TCPlusObject; owner : TCPlusObject; font :  TCPlusObject); cdecl; external BePascalLibName name 'BStringItem_Update';
function BStringItem_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BStringItem_Perform';

implementation

var
  
  ListItem_DrawItem_hook : Pointer; cvar; external;
  ListString_DrawItem_hook : Pointer; cvar; external;
  ListItem_Update_hook : Pointer; cvar; external;
  ListString_Update_hook : Pointer; cvar; external;

constructor TListItem.Create(aoutlineLevel : longint; expanded : boolean );
begin
  CreatePas;
  CPlusObject := BListItem_Create(Self,aoutlineLevel , expanded );
end;

constructor TListItem.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BListItem_Create(Self, data.CPlusObject);
end;

destructor TListItem.Destroy;
begin
  BListItem_Free(CPlusObject);
  inherited;
end;

function TListItem.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BListItem_Archive(CPlusObject, data.CPlusObject, deep);
end;

function TListItem.Height : double;
begin
  Result := BListItem_Height(CPlusObject);
end;

function TListItem.Width : double;
begin
  Result := BListItem_Width(CPlusObject);
end;

function TListItem.IsSelected : boolean;
begin
  Result := BListItem_IsSelected(CPlusObject);
end;

procedure TListItem.Select;
begin
  BListItem_Select(CPlusObject);
end;

procedure TListItem.Deselect;
begin
  BListItem_Deselect(CPlusObject);
end;

procedure TListItem.SetEnabled(aon : boolean);
begin
  BListItem_SetEnabled(CPlusObject, aon);
end;

function TListItem.IsEnabled : boolean;
begin
  Result := BListItem_IsEnabled(CPlusObject);
end;

procedure TListItem.SetHeight(aheight : double);
begin
  BListItem_SetHeight(CPlusObject, aheight);
end;

procedure TListItem.SetWidth(awidth : double);
begin
  BListItem_SetWidth(CPlusObject, awidth);
end;

procedure TListItem.DrawItem(owner : TView; bounds : TRect; complete : boolean);
begin
  //BListItem_DrawItem(CPlusObject, owner.CPlusObject, bounds.CPlusObject, complete);
end;

procedure TListItem.Update(owner : TView; font :  TFont);
begin
 // BListItem_Update(CPlusObject, owner.CPlusObject, font);
end;

{function TListItem.Perform(d : TPerform_code; var arg : Pointer) : TStatus_t;
begin
  Result := BListItem_Perform(CPlusObject, d, arg);
end;
}
function TListItem.IsExpanded : boolean;
begin
  Result := BListItem_IsExpanded(CPlusObject);
end;

procedure TListItem.SetExpanded(expanded : boolean);
begin
  BListItem_SetExpanded(CPlusObject, expanded);
end;

function TListItem.OutlineLevel : Cardinal;
begin
  Result := BListItem_OutlineLevel(CPlusObject);
end;

function TListItem.HasSubitems : boolean;
begin
 // Result := BListItem_HasSubitems(CPlusObject);
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// TStringItem
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

constructor TStringItem.Create( atext: pchar;aoutlineLevel : longint; expanded : boolean);
begin
  CreatePas;
  CPlusObject := BStringItem_Create(Self,atext,aoutlineLevel,expanded);
end;

destructor TStringItem.Destroy;
begin
  BStringItem_Free(CPlusObject);
  inherited;
end;

constructor TStringItem.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BStringItem_Create(Self, data.CPlusObject);
end;

function TStringItem.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BStringItem_Instantiate(CPlusObject, data.CPlusObject);
end;

function TStringItem.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  //Result := BStringItem_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TStringItem.DrawItem(owner : TView; frame : TRect; complete : boolean);
begin
  //BStringItem_DrawItem(CPlusObject, owner.CPlusObject, frame.CPlusObject, complete);
end;

procedure TStringItem.SetText( atext : PChar);
begin
  BStringItem_SetText(CPlusObject, atext);
end;

function TStringItem.Text : PChar;
begin
  Result := BStringItem_Text(CPlusObject);
end;

procedure TStringItem.Update(owner : TView; font :  TFont);
begin
  //BStringItem_Update(CPlusObject, owner.CPlusObject, font);
end;

{function TStringItem.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BStringItem_Perform(CPlusObject, d, arg);
end;
}

procedure ListItem_DrawItem_hook_func(Liste : TListItem;owner : TCPlusObject; bounds : TCPlusObject; complete : boolean); cdecl;
var Rect : TRect;
	  ow    : TView;
	  
begin
	Rect:=TRect.Wrap(bounds);
	ow:=TView.Wrap(owner);
  try
 	 if Liste <> nil then
 	 begin
	    Liste.DrawItem(ow ,Rect, complete );
	  end;  
   finally
   		Rect.UnWrap;
   		ow.UnWrap;
   end; 
end;

procedure ListString_DrawItem_hook_func(Liste : TStringItem;owner : TCPlusObject; bounds : TCPlusObject; complete : boolean); cdecl;
var Rect : TRect;
	  ow    : TView;
begin
	Rect:=TRect.Wrap(bounds);
	ow:=TView.Wrap(owner);
  try
 	 if Liste <> nil then
 	 begin
	    Liste.DrawItem(ow ,Rect, complete );
	  end;  
   finally
   		Rect.UnWrap;
   		ow.UnWrap;
   end; 
end;

procedure ListItem_Update_hook_func(Liste : TListItem;owner : TCPlusObject; font : TCPlusObject); cdecl;
var afont: TFont;
	  ow    : TView;
begin
	afont:=TFont.Wrap(font);
	ow:=TView.Wrap(owner);
  try
 	 if Liste <> nil then
 	 begin
 	  
	    Liste.Update(ow ,afont );
	  end;  
   finally
   		afont.UnWrap;
   		ow.UnWrap;
   end; 
end;

procedure ListString_Update_hook_func(Liste : TStringItem;owner : TCPlusObject; font : TCPlusObject); cdecl;
var afont: TFont;
	  ow    : TView;	  
begin
	afont:=TFont.Wrap(font);
	ow:=TView.Wrap(owner);
  try
 	 if Liste <> nil then
 	 begin
	    Liste.Update(ow ,afont );
	  end;  
   finally
   		afont.UnWrap;
   		ow.UnWrap;
   end; 
end;


initialization

  ListItem_DrawItem_hook := @ListItem_DrawItem_hook_func;
  ListString_DrawItem_hook := @ListString_DrawItem_hook_func;
  ListItem_Update_hook := @ListItem_Update_hook_func;
  ListString_Update_hook := @ListString_Update_hook_func;


end.
