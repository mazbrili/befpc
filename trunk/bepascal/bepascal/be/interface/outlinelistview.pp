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
unit outlinelistview;

interface

uses
     beobj, view, message, archivable, SupportDefs, rect, list,
  handler, messenger,interfacedefs,font,graphicdefs,scrollview,listitem,listview;

type
  TOutlineListView = class(TListView)
  private
  public
    constructor Create(frame : TRect; name : pchar; atype : Tlist_view_type; resizeMask: longint; flags : longint); override;
    constructor Create(data : TMessage); 
    destructor Destroy;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure MouseDown(where : TPoint);override;
    procedure KeyDown(bytes : PChar; numBytes : integer);override;
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(new_width : double; new_height : double);override;
    procedure MouseUp(where : TPoint);override;
    function AddUnder(item : TListItem; underItem : TListItem) : boolean;
    function AddItem(item : TListItem) : boolean;
    function AddItem(item : TListItem; fullListIndex : integer) : boolean;
    function AddList(newItems : TList) : boolean;
    function AddList(newItems : TList; fullListIndex : integer) : boolean;
    function RemoveItem(item : TListItem) : boolean;
    function RemoveItem(fullListIndex : integer) : TListItem;
    function RemoveItems(fullListIndex : integer; count : integer) : boolean;
    function FullListItemAt(fullListIndex : integer) : TListItem;
    function FullListIndexOf(point : TPoint) : integer;
    function FullListIndexOf(item : TListItem) : integer;
    function FullListFirstItem : TListItem;
    function FullListLastItem : TListItem;
    function FullListHasItem(item : TListItem) : boolean;
    function FullListCountItems : integer;
    function FullListCurrentSelection(index : integer) : integer;
    procedure MakeEmpty;
    function FullListIsEmpty : boolean;
    function Superitem(item : TListItem) : TListItem;
    procedure Expand(item : TListItem);
    procedure Collapse(item : TListItem);
    function IsExpanded(fullListIndex : integer) : boolean;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
    procedure ResizeToPreferred;override;
    procedure GetPreferredSize(width : double; height : double);
    procedure MakeFocus(state : boolean);
    procedure AllAttached;override;
    procedure AllDetached;override;
    procedure DetachedFromWindow;override;
    function CountItemsUnder(under : TListItem; oneLevelOnly : boolean) : integer;
    function ItemUnderAt(underItem : TListItem; oneLevelOnly : boolean; index : integer) : TListItem;
//    function DoMiscellaneous(code : ; data : ) : boolean;
//    procedure MessageReceived( : TMessage);
  end;

function BOutlineListView_Create(AObject : TBeObject; frame : TCPlusObject; name : pchar; atype : Tlist_view_type; resizeMask: longint; flags : longint):TCPlusObject; cdecl; external BePascalLibName name 'BOutlineListView_Create';
function BOutlineListView_Create_1(AObject : TBeObject;data : TCPlusObject):TCPlusObject; cdecl; external BePascalLibName name 'BOutlineListView_Create_1';
procedure BOutlineListView_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_Free';
function BOutlineListView_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BOutlineListView_Instantiate';
function BOutlineListView_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BOutlineListView_Archive';
procedure BOutlineListView_MouseDown(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_MouseDown';
procedure BOutlineListView_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BOutlineListView_KeyDown';
procedure BOutlineListView_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_FrameMoved';
procedure BOutlineListView_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BOutlineListView_FrameResized';
procedure BOutlineListView_MouseUp(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_MouseUp';
function BOutlineListView_AddUnder(AObject : TCPlusObject; item : TCPlusObject; underItem : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_AddUnder';
function BOutlineListView_AddItem(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_AddItem';
function BOutlineListView_AddItem(AObject : TCPlusObject; item : TCPlusObject; fullListIndex : integer) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_AddItem';
function BOutlineListView_AddList(AObject : TCPlusObject; newItems : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_AddList';
function BOutlineListView_AddList(AObject : TCPlusObject; newItems : TCPlusObject; fullListIndex : integer) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_AddList';
function BOutlineListView_RemoveItem(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_RemoveItem';
function BOutlineListView_RemoveItem_1(AObject : TCPlusObject; fullListIndex : integer) : TCPlusObject; cdecl; external BePascalLibName name 'BOutlineListView_RemoveItem_1';
function BOutlineListView_RemoveItems(AObject : TCPlusObject; fullListIndex : integer; count : integer) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_RemoveItems';
function BOutlineListView_FullListItemAt(AObject : TCPlusObject; fullListIndex : integer) : TListItem; cdecl; external BePascalLibName name 'BOutlineListView_FullListItemAt';
function BOutlineListView_FullListIndexOf(AObject : TCPlusObject; point : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BOutlineListView_FullListIndexOf';
function BOutlineListView_FullListIndexOf_1(AObject : TCPlusObject; item : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BOutlineListView_FullListIndexOf_1';
function BOutlineListView_FullListFirstItem(AObject : TCPlusObject) : TListItem; cdecl; external BePascalLibName name 'BOutlineListView_FullListFirstItem';
function BOutlineListView_FullListLastItem(AObject : TCPlusObject) : TListItem; cdecl; external BePascalLibName name 'BOutlineListView_FullListLastItem';
function BOutlineListView_FullListHasItem(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_FullListHasItem';
function BOutlineListView_FullListCountItems(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BOutlineListView_FullListCountItems';
function BOutlineListView_FullListCurrentSelection(AObject : TCPlusObject; index : integer) : integer; cdecl; external BePascalLibName name 'BOutlineListView_FullListCurrentSelection';
procedure BOutlineListView_MakeEmpty(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_MakeEmpty';
function BOutlineListView_FullListIsEmpty(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_FullListIsEmpty';
function BOutlineListView_Superitem(AObject : TCPlusObject; item : TCPlusObject) : TListItem; cdecl; external BePascalLibName name 'BOutlineListView_Superitem';
procedure BOutlineListView_Expand(AObject : TCPlusObject; item : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_Expand';
procedure BOutlineListView_Collapse(AObject : TCPlusObject; item : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_Collapse';
function BOutlineListView_IsExpanded(AObject : TCPlusObject; fullListIndex : integer) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_IsExpanded';
function BOutlineListView_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BOutlineListView_ResolveSpecifier';
function BOutlineListView_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BOutlineListView_GetSupportedSuites';
function BOutlineListView_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BOutlineListView_Perform';
procedure BOutlineListView_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_ResizeToPreferred';
procedure BOutlineListView_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BOutlineListView_GetPreferredSize';
procedure BOutlineListView_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BOutlineListView_MakeFocus';
procedure BOutlineListView_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_AllAttached';
procedure BOutlineListView_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_AllDetached';
procedure BOutlineListView_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_DetachedFromWindow';
function BOutlineListView_CountItemsUnder(AObject : TCPlusObject; under : TCPlusObject; oneLevelOnly : boolean) : integer; cdecl; external BePascalLibName name 'BOutlineListView_CountItemsUnder';
function BOutlineListView_ItemUnderAt(AObject : TCPlusObject; underItem : TCPlusObject; oneLevelOnly : boolean; index : integer) : TListItem; cdecl; external BePascalLibName name 'BOutlineListView_ItemUnderAt';
//function BOutlineListView_DoMiscellaneous(AObject : TCPlusObject; code : ; data : ) : boolean; cdecl; external BePascalLibName name 'BOutlineListView_DoMiscellaneous';
//procedure BOutlineListView_MessageReceived(AObject : TCPlusObject;  : TCPlusObject); cdecl; external BePascalLibName name 'BOutlineListView_MessageReceived';

implementation


constructor TOutlineListView.Create(frame : TRect; name : pchar; atype : Tlist_view_type; resizeMask: longint; flags : longint);
begin
  CreatePas;
  CPlusObject := BOutlineListView_Create(Self,frame.CPlusObject,name,atype,resizeMask,flags);
end;

constructor TOutlineListView.Create(data : TMessage); 
begin
  CreatePas;
  CPlusObject := BOutlineListView_Create_1(Self,data.CPlusObject);
end;

destructor TOutlineListView.Destroy;
begin
  BOutlineListView_Free(CPlusObject);
  inherited;
end;

function TOutlineListView.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BOutlineListView_Instantiate(CPlusObject, data.CPlusObject);
end;

function TOutlineListView.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BOutlineListView_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TOutlineListView.MouseDown(where : TPoint);
begin
//  BOutlineListView_MouseDown(CPlusObject, where.CPlusObject);
end;

procedure TOutlineListView.KeyDown(bytes : PChar; numBytes : integer);
begin
 // BOutlineListView_KeyDown(CPlusObject, bytes, numBytes);
end;

procedure TOutlineListView.FrameMoved(new_position : TPoint);
begin
//  BOutlineListView_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TOutlineListView.FrameResized(new_width : double; new_height : double);
begin
//  BOutlineListView_FrameResized(CPlusObject, new_width, new_height);
end;

procedure TOutlineListView.MouseUp(where : TPoint);
begin
//  BOutlineListView_MouseUp(CPlusObject, where.CPlusObject);
end;

function TOutlineListView.AddUnder(item : TListItem; underItem : TListItem) : boolean;
begin
  Result := BOutlineListView_AddUnder(CPlusObject, item.CPlusObject, underItem.CPlusObject);
end;

function TOutlineListView.AddItem(item : TListItem) : boolean;
begin
  Result := BOutlineListView_AddItem(CPlusObject, item.CPlusObject);
end;

function TOutlineListView.AddItem(item : TListItem; fullListIndex : integer) : boolean;
begin
  Result := BOutlineListView_AddItem(CPlusObject, item.CPlusObject, fullListIndex);
end;

function TOutlineListView.AddList(newItems : TList) : boolean;
begin
  Result := BOutlineListView_AddList(CPlusObject, newItems.CPlusObject);
end;

function TOutlineListView.AddList(newItems : TList; fullListIndex : integer) : boolean;
begin
  Result := BOutlineListView_AddList(CPlusObject, newItems.CPlusObject, fullListIndex);
end;

function TOutlineListView.RemoveItem(item : TListItem) : boolean;
begin
  Result := BOutlineListView_RemoveItem(CPlusObject, item.CPlusObject);
end;

function TOutlineListView.RemoveItem(fullListIndex : integer) : TListItem;
begin
//  Result := BOutlineListView_RemoveItem_1(CPlusObject, fullListIndex);
end;

function TOutlineListView.RemoveItems(fullListIndex : integer; count : integer) : boolean;
begin
  Result := BOutlineListView_RemoveItems(CPlusObject, fullListIndex, count);
end;

function TOutlineListView.FullListItemAt(fullListIndex : integer) : TListItem;
begin
  Result := BOutlineListView_FullListItemAt(CPlusObject, fullListIndex);
end;

function TOutlineListView.FullListIndexOf(point : TPoint) : integer;
begin
  Result := BOutlineListView_FullListIndexOf(CPlusObject, point.CPlusObject);
end;

function TOutlineListView.FullListIndexOf(item : TListItem) : integer;
begin
  Result := BOutlineListView_FullListIndexOf(CPlusObject, item.CPlusObject);
end;

function TOutlineListView.FullListFirstItem : TListItem;
begin
  Result := BOutlineListView_FullListFirstItem(CPlusObject);
end;

function TOutlineListView.FullListLastItem : TListItem;
begin
  Result := BOutlineListView_FullListLastItem(CPlusObject);
end;

function TOutlineListView.FullListHasItem(item : TListItem) : boolean;
begin
  Result := BOutlineListView_FullListHasItem(CPlusObject, item.CPlusObject);
end;

function TOutlineListView.FullListCountItems : integer;
begin
  Result := BOutlineListView_FullListCountItems(CPlusObject);
end;

function TOutlineListView.FullListCurrentSelection(index : integer) : integer;
begin
  Result := BOutlineListView_FullListCurrentSelection(CPlusObject, index);
end;

procedure TOutlineListView.MakeEmpty;
begin
  BOutlineListView_MakeEmpty(CPlusObject);
end;

function TOutlineListView.FullListIsEmpty : boolean;
begin
  Result := BOutlineListView_FullListIsEmpty(CPlusObject);
end;

function TOutlineListView.Superitem(item : TListItem) : TListItem;
begin
  Result := BOutlineListView_Superitem(CPlusObject, item);
end;

procedure TOutlineListView.Expand(item : TListItem);
begin
  BOutlineListView_Expand(CPlusObject, item.CPlusObject);
end;

procedure TOutlineListView.Collapse(item : TListItem);
begin
  BOutlineListView_Collapse(CPlusObject, item.CPlusObject);
end;

function TOutlineListView.IsExpanded(fullListIndex : integer) : boolean;
begin
  Result := BOutlineListView_IsExpanded(CPlusObject, fullListIndex);
end;

function TOutlineListView.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BOutlineListView_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function TOutlineListView.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BOutlineListView_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function TOutlineListView.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BOutlineListView_Perform(CPlusObject, d, arg);
end;

procedure TOutlineListView.ResizeToPreferred;
begin
  BOutlineListView_ResizeToPreferred(CPlusObject);
end;

procedure TOutlineListView.GetPreferredSize(width : double; height : double);
begin
  BOutlineListView_GetPreferredSize(CPlusObject, width, height);
end;

procedure TOutlineListView.MakeFocus(state : boolean);
begin
  BOutlineListView_MakeFocus(CPlusObject, state);
end;

procedure TOutlineListView.AllAttached;
begin
  BOutlineListView_AllAttached(CPlusObject);
end;

procedure TOutlineListView.AllDetached;
begin
  BOutlineListView_AllDetached(CPlusObject);
end;

procedure TOutlineListView.DetachedFromWindow;
begin
  BOutlineListView_DetachedFromWindow(CPlusObject);
end;

function TOutlineListView.CountItemsUnder(under : TListItem; oneLevelOnly : boolean) : integer;
begin
  Result := BOutlineListView_CountItemsUnder(CPlusObject, under.CPlusObject, oneLevelOnly);
end;

function TOutlineListView.ItemUnderAt(underItem : TListItem; oneLevelOnly : boolean; index : integer) : TListItem;
begin
  Result := BOutlineListView_ItemUnderAt(CPlusObject, underItem.CPlusObject, oneLevelOnly, index);
end;

{function TOutlineListView.DoMiscellaneous(code : ; data : ) : boolean;
begin
  Result := BOutlineListView_DoMiscellaneous(CPlusObject, code, data);
end;

procedure TOutlineListView.MessageReceived( : TMessage);
begin
  BOutlineListView_MessageReceived(CPlusObject, .CPlusObject);
end;
}


end.
