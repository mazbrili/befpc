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
unit menu;

interface

uses
  beobj, view, message, archivable, SupportDefs, rect, list,
  handler, messenger;

type
  TMenu_Info = record
    font_size : Double;
{    float font_size;
    font_family f_family;
    font_style f_style;
    rgb_color background_color;
    int32 separator;
    bool click_to_open;
    bool triggers_always_shown;}
  end;
  PMenu_Info = ^TMenu_Info;
type
  TMenu_Layout = (B_ITEMS_IN_ROW, B_ITEMS_IN_COLUMN, B_ITEMS_IN_MATRIX);
  TAdd_State = (B_INITIAL_ADD, B_PROCESSING, B_ABORT);
type
  TMenu_Tracking_Hook = function() : TStatus_t; cdecl;
type
  TMenuItem = class;
  TMenu = class(TView)
  private
  public
//    constructor Create; override;
    constructor Create(title : PChar; width : double; height : double);
    constructor Create(title : PChar; layout : TMenu_Layout);    
    destructor Destroy; override;
//    constructor Create(data : TMessage);
    function Instantiate(data : TMessage) : TArchivable; 
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure AttachedToWindow; override;
    procedure DetachedFromWindow; override;

    function AddItem(item : TMenuItem) : boolean; virtual;    
    function AddItem(item : TMenuItem; index : integer) : boolean; virtual;
    function AddItem(item : TMenuItem; frame : TRect) : boolean; virtual;
    function AddItem(menu : TMenu; index : integer) : boolean; virtual;    
    function AddItem(menu : TMenu; frame : TRect) : boolean; virtual;
    function AddItem(menu : TMenu) : boolean; virtual;

    function AddList(list : TList; index : integer) : boolean; 
    function AddSeparatorItem : boolean;
    function RemoveItem(item : TMenuItem) : boolean;
    function RemoveItem(index : integer) : TMenuItem;
    function RemoveItems(index : integer; count : integer; del : boolean) : boolean;
    function RemoveItem(menu : TMenu) : boolean;
    function ItemAt(index : integer) : TMenuItem;
    function SubmenuAt(index : integer) : TMenu;
    function CountItems : integer;
    function IndexOf(item : TMenuItem) : integer;
    function IndexOf(menu : TMenu) : integer;
    function FindItem(command : Cardinal) : TMenuItem;
    function FindItem(name : PChar) : TMenuItem;
    function SetTargetForItems(target : THandler) : TStatus_t;
    function SetTargetForItems(messenger : TMessenger) : TStatus_t;
    procedure SetEnabled(state : boolean);
    procedure SetRadioMode(state : boolean);
    procedure SetTriggersEnabled(state : boolean);
    procedure SetMaxContentWidth(max : double);
    procedure SetLabelFromMarked(aOn : boolean);
    function IsLabelFromMarked : boolean;
    function IsEnabled : boolean;
    function IsRadioMode : boolean;
    function AreTriggersEnabled : boolean;
    function IsRedrawAfterSticky : boolean;
    function MaxContentWidth : double;
    function FindMarked : TMenuItem;
    function Supermenu : TMenu;
    function Superitem : TMenuItem;
    procedure MessageReceived(msg : TMessage); override;
    procedure KeyDown(bytes : PChar; numBytes : integer); override;
    procedure Draw(updateRect : TRect); override;
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred; override;
    procedure FrameMoved(new_position : TPoint); override;
    procedure FrameResized(new_width : double; new_height : double); override;
    procedure InvalidateLayout;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; aProperty : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
    procedure MakeFocus(state : boolean);
    procedure AllAttached; override;
    procedure AllDetached; override;
{    constructor Create(frame : TRect; viewName : PChar; resizeMask : Cardinal; flags : Cardinal; layout : TMenu_Layout; resizeToFit : boolean);
    function ScreenLocation : TPoint;
    procedure SetItemMargins(left : double; top : double; right : double; bottom : double);
    procedure GetItemMargins(left : double; top : double; right : double; bottom : double);
    function Layout : TMenu_Layout;
    procedure Show;
    procedure Show(selectFirstItem : boolean);
    procedure Hide;
    function Track(start_opened : boolean; special_rect : TRect) : TMenuItem;
}
//    procedure enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT };
{    function AddDynamicItem(s : TAdd_State) : boolean;
    procedure DrawBackground(update : TRect);
    procedure SetTrackingHook(func : TMenu_Tracking_Hook; state : Pointer);
}
{    procedure _ReservedMenu3;
    procedure _ReservedMenu4;
    procedure _ReservedMenu5;
    procedure _ReservedMenu6;
    function operator=( : TMenu) : TMenu;
    procedure InitData(data : TMessage);
    function _show(selectFirstItem : boolean) : boolean;
    procedure _hide;
    function _track(action : integer; start : integer) : TMenuItem;
    function _AddItem(item : TMenuItem; index : integer) : boolean;
    function RemoveItems(index : integer; count : integer; item : TMenuItem; del : boolean) : boolean;
    procedure LayoutItems(index : integer);
    procedure ComputeLayout(index : integer; bestFit : boolean; moveItems : boolean; width : double; height : double);
    function Bump(current : TRect; extent : TPoint; index : integer) : TRect;
    function ItemLocInRect(frame : TRect) : TPoint;
    function CalcFrame(where : TPoint; scrollOn : boolean) : TRect;
    function ScrollMenu(bounds : TRect; loc : TPoint; fast : boolean) : boolean;
    procedure ScrollIntoView(item : TMenuItem);
    procedure DrawItems(updateRect : TRect);
    function State(item : TMenuItem) : integer;
    procedure InvokeItem(item : TMenuItem; now : boolean);
    function OverSuper(loc : TPoint) : boolean;
    function OverSubmenu(item : TMenuItem; loc : TPoint) : boolean;
    function MenuWindow : TMenuWindow;
    procedure DeleteMenuWindow;
    function HitTestItems(where : TPoint; slop : TPoint) : TMenuItem;
    function Superbounds : TRect;
    procedure CacheFontInfo;
    procedure ItemMarked(item : TMenuItem);
    procedure Install(target : TWindow);
    procedure Uninstall;
    procedure SelectItem(m : TMenuItem; showSubmenu : Cardinal; selectFirstItem : boolean);
    function CurrentSelection : TMenuItem;
    function SelectNextItem(item : TMenuItem; forward : boolean) : boolean;
    function NextItem(item : TMenuItem; forward : boolean) : TMenuItem;
    function IsItemVisible(item : TMenuItem) : boolean;
    procedure SetIgnoreHidden(on : boolean);
    procedure SetStickyMode(on : boolean);
    function IsStickyMode : boolean;
    procedure CalcTriggers;
    function ChooseTrigger(title : PChar; chars : TList) : PChar;
    procedure UpdateWindowViewSize(upWind : boolean);
    function IsStickyPrefOn : boolean;
    procedure RedrawAfterSticky(bounds : TRect);
    function OkToProceed( : TMenuItem) : boolean;
    function ParseMsg(msg : TMessage; sindex : ^integer; spec : TMessage; form : ^integer; prop : PChar; tmenu : TMenu; titem : TMenuItem; user_data : ^integer; reply : TMessage) : TStatus_t;
    function DoMenuMsg(next : TMenuItem; tar : TMenu; m : TMessage; r : TMessage; spec : TMessage; f : integer) : TStatus_t;
    function DoMenuItemMsg(next : TMenuItem; tar : TMenu; m : TMessage; r : TMessage; spec : TMessage; f : integer) : TStatus_t;
    function DoEnabledMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
    function DoLabelMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
    function DoMarkMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
    function DoDeleteMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
    function DoCreateMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage; menu : boolean) : TStatus_t;
    procedure menu_info sMenuInfo;
    procedure bool sSwapped;
    procedure BMenuItem *fChosenItem;
    procedure BList fItems;
    procedure BRect fPad;
    procedure BMenuItem *fSelected;
    procedure BMenuWindow *fCachedMenuWindow;
    procedure BMenu *fSuper;
    procedure BMenuItem *fSuperitem;
    procedure BRect fSuperbounds;
    procedure float fAscent;
    procedure float fDescent;
    procedure float fFontHeight;
    procedure uint32 fState;
    procedure menu_layout fLayout;
    procedure BRect *fExtraRect;
    procedure float fMaxContentWidth;
    procedure BPoint *fInitMatrixSize;
    procedure _ExtraMenuData_ *fExtraMenuData;
    procedure uint32 _reserved[2];
    procedure char fTrigger;
    procedure bool fResizeToFit;
    procedure bool fUseCachedMenuLayout;
    procedure bool fEnabled;
    procedure bool fDynamicName;
    procedure bool fRadioMode;
    procedure bool fTrackNewBounds;
    procedure bool fStickyMode;
    procedure bool fIgnoreHidden;
    procedure bool fTriggerEnabled;
    procedure bool fRedrawAfterSticky;
    procedure bool fAttachAborted;}
  end;

  TMenuItem = class(TBeObject)
  private
  public
    constructor Create; override;
    constructor Create(aMenu : TMenu; message : TMessage); virtual;
    constructor Create(data : TMessage); virtual;
    constructor Create(aLabel : PChar; message : TMessage; aShortcut : Char; modifiers : Cardinal); virtual;    
    destructor Destroy; override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure SetLabel(name : PChar);
    procedure SetEnabled(state : boolean);
    procedure SetMarked(state : boolean);
    procedure SetTrigger(ch : Char);
    procedure SetShortcut(ch : Char; modifiers : Cardinal);
//    function aLabel : PChar;
    function IsEnabled : boolean;
    function IsMarked : boolean;
    function Trigger : Char;
//    function Shortcut(modifiers : Cardinal) : Char;
    function Submenu : TMenu;
    function Menu : TMenu;
    function Frame : TRect;
{    procedure GetContentSize(width : double; height : double);
    procedure TruncateLabel(max : double; new_label : PChar);
    procedure DrawContent;
    procedure Draw;
    procedure Highlight(aOn : boolean);
    function IsSelected : boolean;
    function ContentLocation : TPoint;
    procedure _ReservedMenuItem2;
    procedure _ReservedMenuItem3;
    procedure _ReservedMenuItem4;
    constructor Create(MenuItem : TMenuItem);
    function operator=(MenuItem : TMenuItem) : TMenuItem;
    procedure InitData;
    procedure InitMenuData(menu : TMenu);
    procedure Install(window : TWindow);
    function Invoke(msg : TMessage) : TStatus_t;
    procedure Uninstall;
    procedure SetSuper(super : TMenu);
    procedure Select(on : boolean);
    procedure DrawMarkSymbol;
    procedure DrawShortcutSymbol;
    procedure DrawSubmenuSymbol;
    procedure DrawControlChar(control : PChar);
    procedure SetSysTrigger(ch : Char);
    procedure char *fLabel;
    procedure BMenu *fSubmenu;
    procedure BWindow *fWindow;
    procedure BMenu *fSuper;
    procedure BRect fBounds;
    procedure uint32 fModifiers;
    procedure float fCachedWidth;
    procedure int16 fTriggerIndex;
    procedure char fUserTrigger;
    procedure char fSysTrigger;
    procedure char fShortcutChar;
    procedure bool fMark;
    procedure bool fEnabled;
    procedure bool fSelected;
    procedure uint32 _reserved[4];
}
  end;
type
  TSeparatorItem = class(TMenuItem)
  private
  public
    constructor Create; override;
    constructor Create(data : TMessage); override;
    destructor Destroy; override;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    function Instantiate(data : TMessage) : TArchivable;
    procedure SetEnabled(state : boolean);
{    procedure GetContentSize(width : double; height : double);
    procedure Draw;
    procedure _ReservedSeparatorItem1;
    procedure _ReservedSeparatorItem2;
    function operator=( : TSeparatorItem) : TSeparatorItem;
    procedure uint32 _reserved[1];
}
  end;

//function BMenuItem_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuItem_Create';
function BMenuItem_Create(AObject : TBeObject; aLabel : PChar; message : TCPlusObject; shortcut : Char; modifiers : Cardinal) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuItem_Create';
function BMenuItem_Create(AObject : TBeObject; menu : TCPlusObject; message : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuItem_Create_1';
function BMenuItem_Create(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuItem_Create_2';
procedure BMenuItem_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_Free';
function BMenuItem_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BMenuItem_Instantiate';
function BMenuItem_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BMenuItem_Archive';
procedure BMenuItem_SetLabel(AObject : TCPlusObject; name : PChar); cdecl; external BePascalLibName name 'BMenuItem_SetLabel';
procedure BMenuItem_SetEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenuItem_SetEnabled';
procedure BMenuItem_SetMarked(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenuItem_SetMarked';
procedure BMenuItem_SetTrigger(AObject : TCPlusObject; ch : Char); cdecl; external BePascalLibName name 'BMenuItem_SetTrigger';
procedure BMenuItem_SetShortcut(AObject : TCPlusObject; ch : Char; modifiers : Cardinal); cdecl; external BePascalLibName name 'BMenuItem_SetShortcut';
function BMenuItem_Label(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BMenuItem_Label';
function BMenuItem_IsEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenuItem_IsEnabled';
function BMenuItem_IsMarked(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenuItem_IsMarked';
function BMenuItem_Trigger(AObject : TCPlusObject) : Char; cdecl; external BePascalLibName name 'BMenuItem_Trigger';
function BMenuItem_Shortcut(AObject : TCPlusObject; modifiers : Cardinal) : Char; cdecl; external BePascalLibName name 'BMenuItem_Shortcut';
function BMenuItem_Submenu(AObject : TCPlusObject) : TMenu; cdecl; external BePascalLibName name 'BMenuItem_Submenu';
function BMenuItem_Menu(AObject : TCPlusObject) : TMenu; cdecl; external BePascalLibName name 'BMenuItem_Menu';
function BMenuItem_Frame(AObject : TCPlusObject) : TRect; cdecl; external BePascalLibName name 'BMenuItem_Frame';
{procedure BMenuItem_GetContentSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BMenuItem_GetContentSize';
procedure BMenuItem_TruncateLabel(AObject : TCPlusObject; max : double; new_label : PChar); cdecl; external BePascalLibName name 'BMenuItem_TruncateLabel';
procedure BMenuItem_DrawContent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_DrawContent';
procedure BMenuItem_Draw(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_Draw';
procedure BMenuItem_Highlight(AObject : TCPlusObject; aOn : boolean); cdecl; external BePascalLibName name 'BMenuItem_Highlight';
function BMenuItem_IsSelected(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenuItem_IsSelected';
function BMenuItem_ContentLocation(AObject : TCPlusObject) : TPoint; cdecl; external BePascalLibName name 'BMenuItem_ContentLocation';
procedure BMenuItem__ReservedMenuItem2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem__ReservedMenuItem2';
procedure BMenuItem__ReservedMenuItem3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem__ReservedMenuItem3';
procedure BMenuItem__ReservedMenuItem4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem__ReservedMenuItem4';
function BMenuItem_Create(AObject : TBeObject;  : TMenuItem) : TCPlusObject; cdecl; external BePascalLibName name 'BMenuItem_Create';
function BMenuItem_operator=(AObject : TCPlusObject;  : TMenuItem) : TMenuItem; cdecl; external BePascalLibName name 'BMenuItem_operator=';
procedure BMenuItem_InitData(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_InitData';
procedure BMenuItem_InitMenuData(AObject : TCPlusObject; menu : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_InitMenuData';
procedure BMenuItem_Install(AObject : TCPlusObject; window : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_Install';
function BMenuItem_Invoke(AObject : TCPlusObject; msg : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenuItem_Invoke';
procedure BMenuItem_Uninstall(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_Uninstall';
procedure BMenuItem_SetSuper(AObject : TCPlusObject; super : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_SetSuper';
procedure BMenuItem_Select(AObject : TCPlusObject; on : boolean); cdecl; external BePascalLibName name 'BMenuItem_Select';
procedure BMenuItem_DrawMarkSymbol(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_DrawMarkSymbol';
procedure BMenuItem_DrawShortcutSymbol(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_DrawShortcutSymbol';
procedure BMenuItem_DrawSubmenuSymbol(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_DrawSubmenuSymbol';
procedure BMenuItem_DrawControlChar(AObject : TCPlusObject; control : PChar); cdecl; external BePascalLibName name 'BMenuItem_DrawControlChar';
procedure BMenuItem_SetSysTrigger(AObject : TCPlusObject; ch : Char); cdecl; external BePascalLibName name 'BMenuItem_SetSysTrigger';
procedure BMenuItem_char *fLabel(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_char *fLabel';
procedure BMenuItem_BMenu *fSubmenu(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_BMenu *fSubmenu';
procedure BMenuItem_BWindow *fWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_BWindow *fWindow';
procedure BMenuItem_BMenu *fSuper(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_BMenu *fSuper';
procedure BMenuItem_BRect fBounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_BRect fBounds';
procedure BMenuItem_uint32 fModifiers(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_uint32 fModifiers';
procedure BMenuItem_float fCachedWidth(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_float fCachedWidth';
procedure BMenuItem_int16 fTriggerIndex(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_int16 fTriggerIndex';
procedure BMenuItem_char fUserTrigger(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_char fUserTrigger';
procedure BMenuItem_char fSysTrigger(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_char fSysTrigger';
procedure BMenuItem_char fShortcutChar(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_char fShortcutChar';
procedure BMenuItem_bool fMark(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_bool fMark';
procedure BMenuItem_bool fEnabled(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_bool fEnabled';
procedure BMenuItem_bool fSelected(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_bool fSelected';
procedure BMenuItem_uint32 _reserved[4](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenuItem_uint32 _reserved[4]';
}
function BSeparatorItem_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BSeparatorItem_Create';
function BSeparatorItem_Create(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BSeparatorItem_Create_1';
procedure BSeparatorItem_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSeparatorItem_Free';
function BSeparatorItem_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BSeparatorItem_Archive';
function BSeparatorItem_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BSeparatorItem_Instantiate';
procedure BSeparatorItem_SetEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BSeparatorItem_SetEnabled';
procedure BSeparatorItem_GetContentSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BSeparatorItem_GetContentSize';
//procedure BSeparatorItem_Draw(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSeparatorItem_Draw';
{procedure BSeparatorItem__ReservedSeparatorItem1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSeparatorItem__ReservedSeparatorItem1';
procedure BSeparatorItem__ReservedSeparatorItem2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSeparatorItem__ReservedSeparatorItem2';
function BSeparatorItem_operator=(AObject : TCPlusObject;  : TSeparatorItem) : TSeparatorItem; cdecl; external BePascalLibName name 'BSeparatorItem_operator=';
procedure BSeparatorItem_uint32 _reserved[1](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSeparatorItem_uint32 _reserved[1]';
}

//procedure menu_info_float font_size(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_float font_size';
//procedure menu_info_font_family f_family(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_font_family f_family';
//procedure menu_info_font_style f_style(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_font_style f_style';
//procedure menu_info_rgb_color background_color(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_rgb_color background_color';
//procedure menu_info_int32 separator(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_int32 separator';
//procedure menu_info_bool click_to_open(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_bool click_to_open';
//procedure menu_info_bool triggers_always_shown(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_bool triggers_always_shown';
//function BMenu_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
function BMenu_Create(AObject : TBeObject; title : PChar; layout : Integer) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
function BMenu_Create(AObject : TBeObject; title : PChar; width : double; height : double) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create_1';
procedure BMenu_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Free';
function BMenu_Create(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create_3';
function BMenu_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BMenu_Instantiate';
function BMenu_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_Archive';
procedure BMenu_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_AttachedToWindow';
procedure BMenu_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_DetachedFromWindow';
function BMenu_AddItem_1(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
function BMenu_AddItem_2(AObject : TCPlusObject; item : TCPlusObject; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem_1';
function BMenu_AddItem_3(AObject : TCPlusObject; item : TCPlusObject; frame : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem_2';
function BMenu_AddItem_4(AObject : TCPlusObject; menu : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem_3';
function BMenu_AddItem_5(AObject : TCPlusObject; menu : TCPlusObject; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem_4';
function BMenu_AddItem_6(AObject : TCPlusObject; menu : TCPlusObject; frame : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem_5';
function BMenu_AddList(AObject : TCPlusObject; list : TCPlusObject; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu_AddList';
function BMenu_AddSeparatorItem(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddSeparatorItem';
function BMenu_RemoveItem(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItem';
function BMenu_RemoveItem(AObject : TCPlusObject; index : integer) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_RemoveItem_1';
function BMenu_RemoveItems(AObject : TCPlusObject; index : integer; count : integer; del : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItems_2';
//function BMenu_RemoveItem(AObject : TCPlusObject; menu : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItem';
function BMenu_ItemAt(AObject : TCPlusObject; index : integer) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_ItemAt';
function BMenu_SubmenuAt(AObject : TCPlusObject; index : integer) : TMenu; cdecl; external BePascalLibName name 'BMenu_SubmenuAt';
function BMenu_CountItems(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BMenu_CountItems';
function BMenu_IndexOf(AObject : TCPlusObject; item : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BMenu_IndexOf';
//function BMenu_IndexOf(AObject : TCPlusObject; menu : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BMenu_IndexOf';
function BMenu_FindItem(AObject : TCPlusObject; command : Cardinal) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_FindItem';
function BMenu_FindItem(AObject : TCPlusObject; name : PChar) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_FindItem';
function BMenu_SetTargetForItems(AObject : TCPlusObject; target : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_SetTargetForItems';
//function BMenu_SetTargetForItems(AObject : TCPlusObject; messenger : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_SetTargetForItems';
procedure BMenu_SetEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_SetEnabled';
procedure BMenu_SetRadioMode(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_SetRadioMode';
procedure BMenu_SetTriggersEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_SetTriggersEnabled';
procedure BMenu_SetMaxContentWidth(AObject : TCPlusObject; max : double); cdecl; external BePascalLibName name 'BMenu_SetMaxContentWidth';
procedure BMenu_SetLabelFromMarked(AObject : TCPlusObject; aOn : boolean); cdecl; external BePascalLibName name 'BMenu_SetLabelFromMarked';
function BMenu_IsLabelFromMarked(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsLabelFromMarked';
function BMenu_IsEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsEnabled';
function BMenu_IsRadioMode(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsRadioMode';
function BMenu_AreTriggersEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AreTriggersEnabled';
function BMenu_IsRedrawAfterSticky(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsRedrawAfterSticky';
function BMenu_MaxContentWidth(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BMenu_MaxContentWidth';
function BMenu_FindMarked(AObject : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_FindMarked';
function BMenu_Supermenu(AObject : TCPlusObject) : TMenu; cdecl; external BePascalLibName name 'BMenu_Supermenu';
function BMenu_Superitem(AObject : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_Superitem';
procedure BMenu_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_MessageReceived';
procedure BMenu_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BMenu_KeyDown';
procedure BMenu_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Draw';
procedure BMenu_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BMenu_GetPreferredSize';
procedure BMenu_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_ResizeToPreferred';
procedure BMenu_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_FrameMoved';
procedure BMenu_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BMenu_FrameResized';
procedure BMenu_InvalidateLayout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_InvalidateLayout';
function BMenu_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; aProperty : PChar) : THandler; cdecl; external BePascalLibName name 'BMenu_ResolveSpecifier';
function BMenu_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_GetSupportedSuites';
function BMenu_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_Perform';
procedure BMenu_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_MakeFocus';
procedure BMenu_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_AllAttached';
procedure BMenu_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_AllDetached';
function BMenu_Create(AObject : TBeObject; frame : TCPlusObject; viewName : PChar; resizeMask : Cardinal; flags : Cardinal; layout : TMenu_Layout; resizeToFit : boolean) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
function BMenu_ScreenLocation(AObject : TCPlusObject) : TPoint; cdecl; external BePascalLibName name 'BMenu_ScreenLocation';
procedure BMenu_SetItemMargins(AObject : TCPlusObject; left : double; top : double; right : double; bottom : double); cdecl; external BePascalLibName name 'BMenu_SetItemMargins';
procedure BMenu_GetItemMargins(AObject : TCPlusObject; left : double; top : double; right : double; bottom : double); cdecl; external BePascalLibName name 'BMenu_GetItemMargins';
function BMenu_Layout(AObject : TCPlusObject) : TMenu_Layout; cdecl; external BePascalLibName name 'BMenu_Layout';
procedure BMenu_Show(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Show';
procedure BMenu_Show(AObject : TCPlusObject; selectFirstItem : boolean); cdecl; external BePascalLibName name 'BMenu_Show';
procedure BMenu_Hide(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Hide';
function BMenu_Track(AObject : TCPlusObject; start_opened : boolean; special_rect : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_Track';
//procedure BMenu_enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT }(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT }';
function BMenu_AddDynamicItem(AObject : TCPlusObject; s : TAdd_State) : boolean; cdecl; external BePascalLibName name 'BMenu_AddDynamicItem';
procedure BMenu_DrawBackground(AObject : TCPlusObject; update : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_DrawBackground';
procedure BMenu_SetTrackingHook(AObject : TCPlusObject; func : TMenu_Tracking_Hook; state : Pointer); cdecl; external BePascalLibName name 'BMenu_SetTrackingHook';
{procedure BMenu__ReservedMenu3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu3';
procedure BMenu__ReservedMenu4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu4';
procedure BMenu__ReservedMenu5(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu5';
procedure BMenu__ReservedMenu6(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu6';
function BMenu_operator=(AObject : TCPlusObject;  : TMenu) : TMenu; cdecl; external BePascalLibName name 'BMenu_operator=';
procedure BMenu_InitData(AObject : TCPlusObject; data : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_InitData';
function BMenu__show(AObject : TCPlusObject; selectFirstItem : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu__show';
procedure BMenu__hide(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__hide';
function BMenu__track(AObject : TCPlusObject; action : integer; start : integer) : TMenuItem; cdecl; external BePascalLibName name 'BMenu__track';
function BMenu__AddItem(AObject : TCPlusObject; item : TCPlusObject; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu__AddItem';
function BMenu_RemoveItems(AObject : TCPlusObject; index : integer; count : integer; item : TCPlusObject; del : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItems';
procedure BMenu_LayoutItems(AObject : TCPlusObject; index : integer); cdecl; external BePascalLibName name 'BMenu_LayoutItems';
procedure BMenu_ComputeLayout(AObject : TCPlusObject; index : integer; bestFit : boolean; moveItems : boolean; width : double; height : double); cdecl; external BePascalLibName name 'BMenu_ComputeLayout';
function BMenu_Bump(AObject : TCPlusObject; current : TCPlusObject; extent : TCPlusObject; index : integer) : TRect; cdecl; external BePascalLibName name 'BMenu_Bump';
function BMenu_ItemLocInRect(AObject : TCPlusObject; frame : TCPlusObject) : TPoint; cdecl; external BePascalLibName name 'BMenu_ItemLocInRect';
function BMenu_CalcFrame(AObject : TCPlusObject; where : TCPlusObject; scrollOn : boolean) : TRect; cdecl; external BePascalLibName name 'BMenu_CalcFrame';
function BMenu_ScrollMenu(AObject : TCPlusObject; bounds : TCPlusObject; loc : TCPlusObject; fast : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_ScrollMenu';
procedure BMenu_ScrollIntoView(AObject : TCPlusObject; item : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_ScrollIntoView';
procedure BMenu_DrawItems(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_DrawItems';
function BMenu_State(AObject : TCPlusObject; item : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BMenu_State';
procedure BMenu_InvokeItem(AObject : TCPlusObject; item : TCPlusObject; now : boolean); cdecl; external BePascalLibName name 'BMenu_InvokeItem';
function BMenu_OverSuper(AObject : TCPlusObject; loc : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_OverSuper';
function BMenu_OverSubmenu(AObject : TCPlusObject; item : TCPlusObject; loc : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_OverSubmenu';
function BMenu_MenuWindow(AObject : TCPlusObject) : TMenuWindow; cdecl; external BePascalLibName name 'BMenu_MenuWindow';
procedure BMenu_DeleteMenuWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_DeleteMenuWindow';
function BMenu_HitTestItems(AObject : TCPlusObject; where : TCPlusObject; slop : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_HitTestItems';
function BMenu_Superbounds(AObject : TCPlusObject) : TRect; cdecl; external BePascalLibName name 'BMenu_Superbounds';
procedure BMenu_CacheFontInfo(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_CacheFontInfo';
procedure BMenu_ItemMarked(AObject : TCPlusObject; item : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_ItemMarked';
procedure BMenu_Install(AObject : TCPlusObject; target : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Install';
procedure BMenu_Uninstall(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Uninstall';
procedure BMenu_SelectItem(AObject : TCPlusObject; m : TCPlusObject; showSubmenu : Cardinal; selectFirstItem : boolean); cdecl; external BePascalLibName name 'BMenu_SelectItem';
function BMenu_CurrentSelection(AObject : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_CurrentSelection';
function BMenu_SelectNextItem(AObject : TCPlusObject; item : TCPlusObject; forward : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_SelectNextItem';
function BMenu_NextItem(AObject : TCPlusObject; item : TCPlusObject; forward : boolean) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_NextItem';
function BMenu_IsItemVisible(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsItemVisible';
procedure BMenu_SetIgnoreHidden(AObject : TCPlusObject; on : boolean); cdecl; external BePascalLibName name 'BMenu_SetIgnoreHidden';
procedure BMenu_SetStickyMode(AObject : TCPlusObject; on : boolean); cdecl; external BePascalLibName name 'BMenu_SetStickyMode';
function BMenu_IsStickyMode(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsStickyMode';
procedure BMenu_CalcTriggers(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_CalcTriggers';
function BMenu_ChooseTrigger(AObject : TCPlusObject; title : PChar; chars : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BMenu_ChooseTrigger';
procedure BMenu_UpdateWindowViewSize(AObject : TCPlusObject; upWind : boolean); cdecl; external BePascalLibName name 'BMenu_UpdateWindowViewSize';
function BMenu_IsStickyPrefOn(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsStickyPrefOn';
procedure BMenu_RedrawAfterSticky(AObject : TCPlusObject; bounds : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_RedrawAfterSticky';
function BMenu_OkToProceed(AObject : TCPlusObject;  : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_OkToProceed';
function BMenu_ParseMsg(AObject : TCPlusObject; msg : TCPlusObject; sindex : ^integer; spec : TCPlusObject; form : ^integer; prop : PChar; tmenu : TCPlusObject; titem : TCPlusObject; user_data : ^integer; reply : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_ParseMsg';
function BMenu_DoMenuMsg(AObject : TCPlusObject; next : TCPlusObject; tar : TCPlusObject; m : TCPlusObject; r : TCPlusObject; spec : TCPlusObject; f : integer) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoMenuMsg';
function BMenu_DoMenuItemMsg(AObject : TCPlusObject; next : TCPlusObject; tar : TCPlusObject; m : TCPlusObject; r : TCPlusObject; spec : TCPlusObject; f : integer) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoMenuItemMsg';
function BMenu_DoEnabledMsg(AObject : TCPlusObject; ti : TCPlusObject; tm : TCPlusObject; m : TCPlusObject; r : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoEnabledMsg';
function BMenu_DoLabelMsg(AObject : TCPlusObject; ti : TCPlusObject; tm : TCPlusObject; m : TCPlusObject; r : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoLabelMsg';
function BMenu_DoMarkMsg(AObject : TCPlusObject; ti : TCPlusObject; tm : TCPlusObject; m : TCPlusObject; r : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoMarkMsg';
function BMenu_DoDeleteMsg(AObject : TCPlusObject; ti : TCPlusObject; tm : TCPlusObject; m : TCPlusObject; r : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoDeleteMsg';
function BMenu_DoCreateMsg(AObject : TCPlusObject; ti : TCPlusObject; tm : TCPlusObject; m : TCPlusObject; r : TCPlusObject; menu : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoCreateMsg';
procedure BMenu_menu_info sMenuInfo(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_menu_info sMenuInfo';
procedure BMenu_bool sSwapped(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool sSwapped';
procedure BMenu_BMenuItem *fChosenItem(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuItem *fChosenItem';
procedure BMenu_BList fItems(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BList fItems';
procedure BMenu_BRect fPad(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BRect fPad';
procedure BMenu_BMenuItem *fSelected(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuItem *fSelected';
procedure BMenu_BMenuWindow *fCachedMenuWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuWindow *fCachedMenuWindow';
procedure BMenu_BMenu *fSuper(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenu *fSuper';
procedure BMenu_BMenuItem *fSuperitem(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuItem *fSuperitem';
procedure BMenu_BRect fSuperbounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BRect fSuperbounds';
procedure BMenu_float fAscent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fAscent';
procedure BMenu_float fDescent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fDescent';
procedure BMenu_float fFontHeight(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fFontHeight';
procedure BMenu_uint32 fState(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_uint32 fState';
procedure BMenu_menu_layout fLayout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_menu_layout fLayout';
procedure BMenu_BRect *fExtraRect(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BRect *fExtraRect';
procedure BMenu_float fMaxContentWidth(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fMaxContentWidth';
procedure BMenu_BPoint *fInitMatrixSize(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BPoint *fInitMatrixSize';
procedure BMenu__ExtraMenuData_ *fExtraMenuData(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ExtraMenuData_ *fExtraMenuData';
procedure BMenu_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_uint32 _reserved[2]';
procedure BMenu_char fTrigger(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_char fTrigger';
procedure BMenu_bool fResizeToFit(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fResizeToFit';
procedure BMenu_bool fUseCachedMenuLayout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fUseCachedMenuLayout';
procedure BMenu_bool fEnabled(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fEnabled';
procedure BMenu_bool fDynamicName(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fDynamicName';
procedure BMenu_bool fRadioMode(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fRadioMode';
procedure BMenu_bool fTrackNewBounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fTrackNewBounds';
procedure BMenu_bool fStickyMode(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fStickyMode';
procedure BMenu_bool fIgnoreHidden(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fIgnoreHidden';
procedure BMenu_bool fTriggerEnabled(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fTriggerEnabled';
procedure BMenu_bool fRedrawAfterSticky(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fRedrawAfterSticky';
procedure BMenu_bool fAttachAborted(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fAttachAborted';
}
//-----------------------------------

//procedure menu_info_float font_size(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_float font_size';
//procedure menu_info_font_family f_family(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_font_family f_family';
//procedure menu_info_font_style f_style(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_font_style f_style';
//procedure menu_info_rgb_color background_color(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_rgb_color background_color';
//procedure menu_info_int32 separator(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_int32 separator';
//procedure menu_info_bool click_to_open(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_bool click_to_open';
//procedure menu_info_bool triggers_always_shown(AObject : TCPlusObject); cdecl; external BePascalLibName name 'menu_info_bool triggers_always_shown';
{function BMenu_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
function BMenu_Create(AObject : TBeObject; title : PChar; width : double; height : double) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
procedure BMenu_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Free';
function BMenu_Create(AObject : TBeObject; data : TCPlusObject) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
function BMenu_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BMenu_Instantiate';
function BMenu_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_Archive';
procedure BMenu_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_AttachedToWindow';
procedure BMenu_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_DetachedFromWindow';
function BMenu_AddItem(AObject : TCPlusObject; item : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
function BMenu_AddItem(AObject : TCPlusObject; item : TCPlusObject; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
function BMenu_AddItem(AObject : TCPlusObject; item : TCPlusObject; frame : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
}
//function BMenu_AddItem(AObject : TCPlusObject; menu : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
//function BMenu_AddItem(AObject : TCPlusObject; menu : TCPlusObject; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
//function BMenu_AddItem(AObject : TCPlusObject; menu : TCPlusObject; frame : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddItem';
{function BMenu_AddList(AObject : TCPlusObject; list : TList; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu_AddList';
function BMenu_AddSeparatorItem(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AddSeparatorItem';
function BMenu_RemoveItem(AObject : TCPlusObject; item : TMenuItem) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItem';
function BMenu_RemoveItem(AObject : TCPlusObject; index : integer) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_RemoveItem';
function BMenu_RemoveItems(AObject : TCPlusObject; index : integer; count : integer; del : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItems';
function BMenu_RemoveItem(AObject : TCPlusObject; menu : TMenu) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItem';
function BMenu_ItemAt(AObject : TCPlusObject; index : integer) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_ItemAt';
function BMenu_SubmenuAt(AObject : TCPlusObject; index : integer) : TMenu; cdecl; external BePascalLibName name 'BMenu_SubmenuAt';
function BMenu_CountItems(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BMenu_CountItems';
function BMenu_IndexOf(AObject : TCPlusObject; item : TMenuItem) : integer; cdecl; external BePascalLibName name 'BMenu_IndexOf';
function BMenu_IndexOf(AObject : TCPlusObject; menu : TMenu) : integer; cdecl; external BePascalLibName name 'BMenu_IndexOf';
function BMenu_FindItem(AObject : TCPlusObject; command : Cardinal) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_FindItem';
function BMenu_FindItem(AObject : TCPlusObject; name : PChar) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_FindItem';
function BMenu_SetTargetForItems(AObject : TCPlusObject; target : THandler) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_SetTargetForItems';
function BMenu_SetTargetForItems(AObject : TCPlusObject; messenger : TMessenger) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_SetTargetForItems';
procedure BMenu_SetEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_SetEnabled';
procedure BMenu_SetRadioMode(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_SetRadioMode';
procedure BMenu_SetTriggersEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_SetTriggersEnabled';
procedure BMenu_SetMaxContentWidth(AObject : TCPlusObject; max : double); cdecl; external BePascalLibName name 'BMenu_SetMaxContentWidth';
procedure BMenu_SetLabelFromMarked(AObject : TCPlusObject; aOn : boolean); cdecl; external BePascalLibName name 'BMenu_SetLabelFromMarked';
function BMenu_IsLabelFromMarked(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsLabelFromMarked';
function BMenu_IsEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsEnabled';
function BMenu_IsRadioMode(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsRadioMode';
function BMenu_AreTriggersEnabled(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_AreTriggersEnabled';
function BMenu_IsRedrawAfterSticky(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsRedrawAfterSticky';
function BMenu_MaxContentWidth(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BMenu_MaxContentWidth';
function BMenu_FindMarked(AObject : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_FindMarked';
function BMenu_Supermenu(AObject : TCPlusObject) : TMenu; cdecl; external BePascalLibName name 'BMenu_Supermenu';
function BMenu_Superitem(AObject : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_Superitem';
procedure BMenu_MessageReceived(AObject : TCPlusObject; msg : TMessage); cdecl; external BePascalLibName name 'BMenu_MessageReceived';
procedure BMenu_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BMenu_KeyDown';
procedure BMenu_Draw(AObject : TCPlusObject; updateRect : TRect); cdecl; external BePascalLibName name 'BMenu_Draw';
procedure BMenu_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BMenu_GetPreferredSize';
procedure BMenu_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_ResizeToPreferred';
procedure BMenu_FrameMoved(AObject : TCPlusObject; new_position : TPoint); cdecl; external BePascalLibName name 'BMenu_FrameMoved';
procedure BMenu_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BMenu_FrameResized';
procedure BMenu_InvalidateLayout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_InvalidateLayout';
function BMenu_ResolveSpecifier(AObject : TCPlusObject; msg : TMessage; index : integer; specifier : TMessage; form : integer; aProperty : PChar) : THandler; cdecl; external BePascalLibName name 'BMenu_ResolveSpecifier';
function BMenu_GetSupportedSuites(AObject : TCPlusObject; data : TMessage) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_GetSupportedSuites';
function BMenu_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_Perform';
procedure BMenu_MakeFocus(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BMenu_MakeFocus';
procedure BMenu_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_AllAttached';
procedure BMenu_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_AllDetached';
function BMenu_Create(AObject : TBeObject; frame : TRect; viewName : PChar; resizeMask : Cardinal; flags : Cardinal; layout : TMenu_Layout; resizeToFit : boolean) : TCPlusObject; cdecl; external BePascalLibName name 'BMenu_Create';
function BMenu_ScreenLocation(AObject : TCPlusObject) : TPoint; cdecl; external BePascalLibName name 'BMenu_ScreenLocation';
procedure BMenu_SetItemMargins(AObject : TCPlusObject; left : double; top : double; right : double; bottom : double); cdecl; external BePascalLibName name 'BMenu_SetItemMargins';
procedure BMenu_GetItemMargins(AObject : TCPlusObject; left : double; top : double; right : double; bottom : double); cdecl; external BePascalLibName name 'BMenu_GetItemMargins';
function BMenu_Layout(AObject : TCPlusObject) : TMenu_Layout; cdecl; external BePascalLibName name 'BMenu_Layout';
procedure BMenu_Show(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Show';
procedure BMenu_Show(AObject : TCPlusObject; selectFirstItem : boolean); cdecl; external BePascalLibName name 'BMenu_Show';
procedure BMenu_Hide(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Hide';
function BMenu_Track(AObject : TCPlusObject; start_opened : boolean; special_rect : TRect) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_Track';
}
//procedure BMenu_enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT }(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT }';
{function BMenu_AddDynamicItem(AObject : TCPlusObject; s : TAdd_State) : boolean; cdecl; external BePascalLibName name 'BMenu_AddDynamicItem';
procedure BMenu_DrawBackground(AObject : TCPlusObject; update : TRect); cdecl; external BePascalLibName name 'BMenu_DrawBackground';
procedure BMenu_SetTrackingHook(AObject : TCPlusObject; func : TMenu_Tracking_Hook; state : Pointer); cdecl; external BePascalLibName name 'BMenu_SetTrackingHook';
procedure BMenu__ReservedMenu3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu3';
procedure BMenu__ReservedMenu4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu4';
procedure BMenu__ReservedMenu5(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu5';
procedure BMenu__ReservedMenu6(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ReservedMenu6';
function BMenu_operator=(AObject : TCPlusObject;  : TMenu) : TMenu; cdecl; external BePascalLibName name 'BMenu_operator=';
procedure BMenu_InitData(AObject : TCPlusObject; data : TMessage); cdecl; external BePascalLibName name 'BMenu_InitData';
function BMenu__show(AObject : TCPlusObject; selectFirstItem : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu__show';
procedure BMenu__hide(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__hide';
function BMenu__track(AObject : TCPlusObject; action : integer; start : integer) : TMenuItem; cdecl; external BePascalLibName name 'BMenu__track';
function BMenu__AddItem(AObject : TCPlusObject; item : TMenuItem; index : integer) : boolean; cdecl; external BePascalLibName name 'BMenu__AddItem';
function BMenu_RemoveItems(AObject : TCPlusObject; index : integer; count : integer; item : TMenuItem; del : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_RemoveItems';
procedure BMenu_LayoutItems(AObject : TCPlusObject; index : integer); cdecl; external BePascalLibName name 'BMenu_LayoutItems';
procedure BMenu_ComputeLayout(AObject : TCPlusObject; index : integer; bestFit : boolean; moveItems : boolean; width : double; height : double); cdecl; external BePascalLibName name 'BMenu_ComputeLayout';
function BMenu_Bump(AObject : TCPlusObject; current : TRect; extent : TPoint; index : integer) : TRect; cdecl; external BePascalLibName name 'BMenu_Bump';
function BMenu_ItemLocInRect(AObject : TCPlusObject; frame : TRect) : TPoint; cdecl; external BePascalLibName name 'BMenu_ItemLocInRect';
function BMenu_CalcFrame(AObject : TCPlusObject; where : TPoint; scrollOn : boolean) : TRect; cdecl; external BePascalLibName name 'BMenu_CalcFrame';
function BMenu_ScrollMenu(AObject : TCPlusObject; bounds : TRect; loc : TPoint; fast : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_ScrollMenu';
procedure BMenu_ScrollIntoView(AObject : TCPlusObject; item : TMenuItem); cdecl; external BePascalLibName name 'BMenu_ScrollIntoView';
procedure BMenu_DrawItems(AObject : TCPlusObject; updateRect : TRect); cdecl; external BePascalLibName name 'BMenu_DrawItems';
function BMenu_State(AObject : TCPlusObject; item : TMenuItem) : integer; cdecl; external BePascalLibName name 'BMenu_State';
procedure BMenu_InvokeItem(AObject : TCPlusObject; item : TMenuItem; now : boolean); cdecl; external BePascalLibName name 'BMenu_InvokeItem';
function BMenu_OverSuper(AObject : TCPlusObject; loc : TPoint) : boolean; cdecl; external BePascalLibName name 'BMenu_OverSuper';
function BMenu_OverSubmenu(AObject : TCPlusObject; item : TMenuItem; loc : TPoint) : boolean; cdecl; external BePascalLibName name 'BMenu_OverSubmenu';
function BMenu_MenuWindow(AObject : TCPlusObject) : TMenuWindow; cdecl; external BePascalLibName name 'BMenu_MenuWindow';
procedure BMenu_DeleteMenuWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_DeleteMenuWindow';
function BMenu_HitTestItems(AObject : TCPlusObject; where : TPoint; slop : TPoint) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_HitTestItems';
function BMenu_Superbounds(AObject : TCPlusObject) : TRect; cdecl; external BePascalLibName name 'BMenu_Superbounds';
procedure BMenu_CacheFontInfo(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_CacheFontInfo';
procedure BMenu_ItemMarked(AObject : TCPlusObject; item : TMenuItem); cdecl; external BePascalLibName name 'BMenu_ItemMarked';
procedure BMenu_Install(AObject : TCPlusObject; target : TWindow); cdecl; external BePascalLibName name 'BMenu_Install';
procedure BMenu_Uninstall(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_Uninstall';
procedure BMenu_SelectItem(AObject : TCPlusObject; m : TMenuItem; showSubmenu : Cardinal; selectFirstItem : boolean); cdecl; external BePascalLibName name 'BMenu_SelectItem';
function BMenu_CurrentSelection(AObject : TCPlusObject) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_CurrentSelection';
function BMenu_SelectNextItem(AObject : TCPlusObject; item : TMenuItem; forward : boolean) : boolean; cdecl; external BePascalLibName name 'BMenu_SelectNextItem';
function BMenu_NextItem(AObject : TCPlusObject; item : TMenuItem; forward : boolean) : TMenuItem; cdecl; external BePascalLibName name 'BMenu_NextItem';
function BMenu_IsItemVisible(AObject : TCPlusObject; item : TMenuItem) : boolean; cdecl; external BePascalLibName name 'BMenu_IsItemVisible';
procedure BMenu_SetIgnoreHidden(AObject : TCPlusObject; aOn : boolean); cdecl; external BePascalLibName name 'BMenu_SetIgnoreHidden';
procedure BMenu_SetStickyMode(AObject : TCPlusObject; aOn : boolean); cdecl; external BePascalLibName name 'BMenu_SetStickyMode';
function BMenu_IsStickyMode(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsStickyMode';
procedure BMenu_CalcTriggers(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_CalcTriggers';
function BMenu_ChooseTrigger(AObject : TCPlusObject; title : PChar; chars : TList) : PChar; cdecl; external BePascalLibName name 'BMenu_ChooseTrigger';
procedure BMenu_UpdateWindowViewSize(AObject : TCPlusObject; upWind : boolean); cdecl; external BePascalLibName name 'BMenu_UpdateWindowViewSize';
function BMenu_IsStickyPrefOn(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BMenu_IsStickyPrefOn';
procedure BMenu_RedrawAfterSticky(AObject : TCPlusObject; bounds : TRect); cdecl; external BePascalLibName name 'BMenu_RedrawAfterSticky';
function BMenu_OkToProceed(AObject : TCPlusObject;  : TMenuItem) : boolean; cdecl; external BePascalLibName name 'BMenu_OkToProceed';
function BMenu_ParseMsg(AObject : TCPlusObject; msg : TMessage; sindex : ^integer; spec : TMessage; form : ^integer; prop : PChar; tmenu : TMenu; titem : TMenuItem; user_data : ^integer; reply : TMessage) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_ParseMsg';
function BMenu_DoMenuMsg(AObject : TCPlusObject; next : TMenuItem; tar : TMenu; m : TMessage; r : TMessage; spec : TMessage; f : integer) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoMenuMsg';
function BMenu_DoMenuItemMsg(AObject : TCPlusObject; next : TMenuItem; tar : TMenu; m : TMessage; r : TMessage; spec : TMessage; f : integer) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoMenuItemMsg';
function BMenu_DoEnabledMsg(AObject : TCPlusObject; ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoEnabledMsg';
function BMenu_DoLabelMsg(AObject : TCPlusObject; ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoLabelMsg';
function BMenu_DoMarkMsg(AObject : TCPlusObject; ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoMarkMsg';
function BMenu_DoDeleteMsg(AObject : TCPlusObject; ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoDeleteMsg';
function BMenu_DoCreateMsg(AObject : TCPlusObject; ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage; menu : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BMenu_DoCreateMsg';
procedure BMenu_menu_info sMenuInfo(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_menu_info sMenuInfo';
procedure BMenu_bool sSwapped(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool sSwapped';
procedure BMenu_BMenuItem *fChosenItem(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuItem *fChosenItem';
procedure BMenu_BList fItems(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BList fItems';
procedure BMenu_BRect fPad(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BRect fPad';
procedure BMenu_BMenuItem *fSelected(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuItem *fSelected';
procedure BMenu_BMenuWindow *fCachedMenuWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuWindow *fCachedMenuWindow';
procedure BMenu_BMenu *fSuper(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenu *fSuper';
procedure BMenu_BMenuItem *fSuperitem(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BMenuItem *fSuperitem';
procedure BMenu_BRect fSuperbounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BRect fSuperbounds';
procedure BMenu_float fAscent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fAscent';
procedure BMenu_float fDescent(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fDescent';
procedure BMenu_float fFontHeight(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fFontHeight';
procedure BMenu_uint32 fState(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_uint32 fState';
procedure BMenu_menu_layout fLayout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_menu_layout fLayout';
procedure BMenu_BRect *fExtraRect(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BRect *fExtraRect';
procedure BMenu_float fMaxContentWidth(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_float fMaxContentWidth';
procedure BMenu_BPoint *fInitMatrixSize(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_BPoint *fInitMatrixSize';
procedure BMenu__ExtraMenuData_ *fExtraMenuData(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu__ExtraMenuData_ *fExtraMenuData';
procedure BMenu_uint32 _reserved[2](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_uint32 _reserved[2]';
procedure BMenu_char fTrigger(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_char fTrigger';
procedure BMenu_bool fResizeToFit(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fResizeToFit';
procedure BMenu_bool fUseCachedMenuLayout(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fUseCachedMenuLayout';
procedure BMenu_bool fEnabled(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fEnabled';
procedure BMenu_bool fDynamicName(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fDynamicName';
procedure BMenu_bool fRadioMode(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fRadioMode';
procedure BMenu_bool fTrackNewBounds(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fTrackNewBounds';
procedure BMenu_bool fStickyMode(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fStickyMode';
procedure BMenu_bool fIgnoreHidden(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fIgnoreHidden';
procedure BMenu_bool fTriggerEnabled(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fTriggerEnabled';
procedure BMenu_bool fRedrawAfterSticky(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fRedrawAfterSticky';
procedure BMenu_bool fAttachAborted(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BMenu_bool fAttachAborted';
}

implementation

{procedure PMenu_Info.float font_size;
begin
  menu_info_float font_size(CPlusObject);
end;

procedure PMenu_Info.font_family f_family;
begin
  menu_info_font_family f_family(CPlusObject);
end;

procedure PMenu_Info.font_style f_style;
begin
  menu_info_font_style f_style(CPlusObject);
end;

procedure PMenu_Info.rgb_color background_color;
begin
  menu_info_rgb_color background_color(CPlusObject);
end;

procedure PMenu_Info.int32 separator;
begin
  menu_info_int32 separator(CPlusObject);
end;

procedure PMenu_Info.bool click_to_open;
begin
  menu_info_bool click_to_open(CPlusObject);
end;

procedure PMenu_Info.bool triggers_always_shown;
begin
  menu_info_bool triggers_always_shown(CPlusObject);
end;
}
{constructor TMenu.Create;
begin
  CPlusObject := BMenu_Create_0(Self);
end;
}

constructor TMenu.Create(title : PChar; width : double; height : double);
begin
  CPlusObject := BMenu_Create(Self, title, width, height);
end;

constructor TMenu.Create(title : PChar; layout : TMenu_Layout);
begin
//  CPlusObject := BMenu_Create(Self, title, 0);

  case layout of
    B_ITEMS_IN_ROW : CPlusObject := BMenu_Create(Self, title, 0);
    B_ITEMS_IN_COLUMN : CPlusObject := BMenu_Create(Self, title, 1);
    B_ITEMS_IN_MATRIX : CPlusObject := BMenu_Create(Self, title, 2);
  end;
end;


destructor TMenu.Destroy;
begin
  BMenu_Free(CPlusObject);
end;

{constructor TMenu.Create(data : TMessage);
begin
  CPlusObject := BMenu_Create(Self, data.CPlusObject);
end;
}

function TMenu.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BMenu_Instantiate(CPlusObject, data.CPlusObject);
end;

function TMenu.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BMenu_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TMenu.AttachedToWindow;
begin
//  BMenu_AttachedToWindow(CPlusObject);
end;

procedure TMenu.DetachedFromWindow;
begin
//  BMenu_DetachedFromWindow(CPlusObject);
end;


function TMenu.AddItem(item : TMenuItem) : boolean;
begin
  WriteLn('function TMenu.AddItem(item : TMenuItem) : boolean;');
  Result := BMenu_AddItem_1(CPlusObject, item.CPlusObject);
end;

function TMenu.AddItem(item : TMenuItem; index : integer) : boolean;
begin
  WriteLn('function TMenu.AddItem(item : TMenuItem; index : integer) : boolean;');
  Result := BMenu_AddItem_2(CPlusObject, item.CPlusObject, index);
end;

function TMenu.AddItem(item : TMenuItem; frame : TRect) : boolean;
begin
  WriteLn('ici');
  WriteLn('function TMenu.AddItem(item : TMenuItem; frame : TRect) : boolean;');
  frame.PrintToStream;
  Writeln('toto');
  Result := BMenu_AddItem_3(CPlusObject, item.CPlusObject, frame.CPlusObject);
end;

function TMenu.AddItem(menu : TMenu) : boolean;
begin
  WriteLn('function TMenu.AddItem(menu : TMenu) : boolean;');
  WriteLn('Bonjour');
  Result := BMenu_AddItem_4(CPlusObject, menu.CPlusObject);
end;

function TMenu.AddItem(menu : TMenu; index : integer) : boolean;
begin
  WriteLn('function TMenu.AddItem(menu : TMenu; index : integer) : boolean;');
  Result := BMenu_AddItem_5(CPlusObject, menu.CPlusObject, index);
end;

function TMenu.AddItem(menu : TMenu; frame : TRect) : boolean;
begin
  WriteLn('function TMenu.AddItem(menu : TMenu; frame : TRect) : boolean;');
  Result := BMenu_AddItem_6(CPlusObject, menu.CPlusObject, frame.CPlusObject);
end;


{function TMenu.AddItem(item : TMenuItem) : boolean;
begin
  WriteLn('function TMenu.AddItem(item : TMenuItem) : boolean;');
  Result := BMenu_AddItem_1(CPlusObject, item.CPlusObject);
end;

function TMenu.AddItem(item : TMenuItem; index : integer) : boolean;
begin
  WriteLn('function TMenu.AddItem(item : TMenuItem; index : integer) : boolean;');
  Result := BMenu_AddItem_2(CPlusObject, item.CPlusObject, index);
end;

function TMenu.AddItem(item : TMenuItem; frame : TRect) : boolean;
begin
  WriteLn('ici');
  WriteLn('function TMenu.AddItem(item : TMenuItem; frame : TRect) : boolean;');
  frame.PrintToStream;
  Writeln('toto');
  Result := BMenu_AddItem_3(CPlusObject, item.CPlusObject, frame.CPlusObject);
end;

function TMenu.AddItem(menu : TMenu) : boolean;
begin
  WriteLn('function TMenu.AddItem(menu : TMenu) : boolean;');
  WriteLn('Bonjour');
  Result := BMenu_AddItem_4(CPlusObject, menu.CPlusObject);
end;

function TMenu.AddItem(menu : TMenu; index : integer) : boolean;
begin
  WriteLn('function TMenu.AddItem(menu : TMenu; index : integer) : boolean;');
  Result := BMenu_AddItem_5(CPlusObject, menu.CPlusObject, index);
end;

function TMenu.AddItem(menu : TMenu; frame : TRect) : boolean;
begin
  WriteLn('function TMenu.AddItem(menu : TMenu; frame : TRect) : boolean;');
  Result := BMenu_AddItem_6(CPlusObject, menu.CPlusObject, frame.CPlusObject);
end;
}

function TMenu.AddList(list : TList; index : integer) : boolean;
begin
  Result := BMenu_AddList(CPlusObject, list.CPlusObject, index);
end;

function TMenu.AddSeparatorItem : boolean;
begin
  Result := BMenu_AddSeparatorItem(CPlusObject);
end;

function TMenu.RemoveItem(item : TMenuItem) : boolean;
begin
  Result := BMenu_RemoveItem(CPlusObject, item.CPlusObject);
end;

function TMenu.RemoveItem(index : integer) : TMenuItem;
begin
  Result := BMenu_RemoveItem(CPlusObject, index);
end;

function TMenu.RemoveItems(index : integer; count : integer; del : boolean) : boolean;
begin
  Result := BMenu_RemoveItems(CPlusObject, index, count, del);
end;

function TMenu.RemoveItem(menu : TMenu) : boolean;
begin
  Result := BMenu_RemoveItem(CPlusObject, menu.CPlusObject);
end;

function TMenu.ItemAt(index : integer) : TMenuItem;
begin
  Result := BMenu_ItemAt(CPlusObject, index);
end;

function TMenu.SubmenuAt(index : integer) : TMenu;
begin
  Result := BMenu_SubmenuAt(CPlusObject, index);
end;

function TMenu.CountItems : integer;
begin
  Result := BMenu_CountItems(CPlusObject);
end;

function TMenu.IndexOf(item : TMenuItem) : integer;
begin
  Result := BMenu_IndexOf(CPlusObject, item.CPlusObject);
end;

function TMenu.IndexOf(menu : TMenu) : integer;
begin
  Result := BMenu_IndexOf(CPlusObject, menu.CPlusObject);
end;

function TMenu.FindItem(command : Cardinal) : TMenuItem;
begin
  Result := BMenu_FindItem(CPlusObject, command);
end;

function TMenu.FindItem(name : PChar) : TMenuItem;
begin
  Result := BMenu_FindItem(CPlusObject, name);
end;

function TMenu.SetTargetForItems(target : THandler) : TStatus_t;
begin
  Result := BMenu_SetTargetForItems(CPlusObject, target.CPlusObject);
end;

function TMenu.SetTargetForItems(messenger : TMessenger) : TStatus_t;
begin
  Result := BMenu_SetTargetForItems(CPlusObject, messenger.CPlusObject);
end;

procedure TMenu.SetEnabled(state : boolean);
begin
//  BMenu_SetEnabled(CPlusObject, state);
end;

procedure TMenu.SetRadioMode(state : boolean);
begin
  BMenu_SetRadioMode(CPlusObject, state);
end;

procedure TMenu.SetTriggersEnabled(state : boolean);
begin
  BMenu_SetTriggersEnabled(CPlusObject, state);
end;

procedure TMenu.SetMaxContentWidth(max : double);
begin
  BMenu_SetMaxContentWidth(CPlusObject, max);
end;

procedure TMenu.SetLabelFromMarked(aOn : boolean);
begin
  BMenu_SetLabelFromMarked(CPlusObject, aOn);
end;

function TMenu.IsLabelFromMarked : boolean;
begin
  Result := BMenu_IsLabelFromMarked(CPlusObject);
end;

function TMenu.IsEnabled : boolean;
begin
  Result := BMenu_IsEnabled(CPlusObject);
end;

function TMenu.IsRadioMode : boolean;
begin
  Result := BMenu_IsRadioMode(CPlusObject);
end;

function TMenu.AreTriggersEnabled : boolean;
begin
  Result := BMenu_AreTriggersEnabled(CPlusObject);
end;

function TMenu.IsRedrawAfterSticky : boolean;
begin
  Result := BMenu_IsRedrawAfterSticky(CPlusObject);
end;

function TMenu.MaxContentWidth : double;
begin
  Result := BMenu_MaxContentWidth(CPlusObject);
end;

function TMenu.FindMarked : TMenuItem;
begin
  Result := BMenu_FindMarked(CPlusObject);
end;

function TMenu.Supermenu : TMenu;
begin
  Result := BMenu_Supermenu(CPlusObject);
end;

function TMenu.Superitem : TMenuItem;
begin
  Result := BMenu_Superitem(CPlusObject);
end;

procedure TMenu.MessageReceived(msg : TMessage);
begin
//  BMenu_MessageReceived(CPlusObject, msg.CPlusObject);
end;

procedure TMenu.KeyDown(bytes : PChar; numBytes : integer);
begin
//  BMenu_KeyDown(CPlusObject, bytes, numBytes);
end;

procedure TMenu.Draw(updateRect : TRect);
begin
//  BMenu_Draw(CPlusObject, updateRect.CPlusObject);
end;

procedure TMenu.GetPreferredSize(width : double; height : double);
begin
//  BMenu_GetPreferredSize(CPlusObject, width, height);
end;

procedure TMenu.ResizeToPreferred;
begin
//  BMenu_ResizeToPreferred(CPlusObject);
end;

procedure TMenu.FrameMoved(new_position : TPoint);
begin
//  BMenu_FrameMoved(CPlusObject, new_position.CPlusObject);
end;

procedure TMenu.FrameResized(new_width : double; new_height : double);
begin
//  BMenu_FrameResized(CPlusObject, new_width, new_height);
end;

procedure TMenu.InvalidateLayout;
begin
  BMenu_InvalidateLayout(CPlusObject);
end;

function TMenu.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; aProperty : PChar) : THandler;
begin
  Result := BMenu_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, aProperty);
end;

function TMenu.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BMenu_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function TMenu.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BMenu_Perform(CPlusObject, d, arg);
end;

procedure TMenu.MakeFocus(state : boolean);
begin
//  BMenu_MakeFocus(CPlusObject, state);
end;

procedure TMenu.AllAttached;
begin
//  BMenu_AllAttached(CPlusObject);
end;

procedure TMenu.AllDetached;
begin
//  BMenu_AllDetached(CPlusObject);
end;

{
constructor TMenu.Create(frame : TRect; viewName : PChar; resizeMask : Cardinal; flags : Cardinal; layout : TMenu_Layout; resizeToFit : boolean);
begin
  CPlusObject := BMenu_Create(Self, frame.CPlusObject, viewName, resizeMask, flags, layout, resizeToFit);
end;

function TMenu.ScreenLocation : TPoint;
begin
  Result := BMenu_ScreenLocation(CPlusObject);
end;

procedure TMenu.SetItemMargins(left : double; top : double; right : double; bottom : double);
begin
  BMenu_SetItemMargins(CPlusObject, left, top, right, bottom);
end;

procedure TMenu.GetItemMargins(left : double; top : double; right : double; bottom : double);
begin
  BMenu_GetItemMargins(CPlusObject, left, top, right, bottom);
end;

function TMenu.Layout : TMenu_Layout;
begin
  Result := BMenu_Layout(CPlusObject);
end;

procedure TMenu.Show;
begin
  BMenu_Show(CPlusObject);
end;

procedure TMenu.Show(selectFirstItem : boolean);
begin
  BMenu_Show(CPlusObject, selectFirstItem);
end;

procedure TMenu.Hide;
begin
  BMenu_Hide(CPlusObject);
end;

function TMenu.Track(start_opened : boolean; special_rect : TRect) : TMenuItem;
begin
  Result := BMenu_Track(CPlusObject, start_opened, special_rect.CPlusObject);
end;
}

//procedure TMenu.enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT };
//begin
//  BMenu_enum add_state { B_INITIAL_ADD, B_PROCESSING, B_ABORT }(CPlusObject);
//end;

{
function TMenu.AddDynamicItem(s : TAdd_State) : boolean;
begin
  Result := BMenu_AddDynamicItem(CPlusObject, s);
end;

procedure TMenu.DrawBackground(update : TRect);
begin
  BMenu_DrawBackground(CPlusObject, update.CPlusObject);
end;

procedure TMenu.SetTrackingHook(func : TMenu_Tracking_Hook; state : Pointer);
begin
  BMenu_SetTrackingHook(CPlusObject, func, state);
end;

procedure TMenu._ReservedMenu3;
begin
  BMenu__ReservedMenu3(CPlusObject);
end;

procedure TMenu._ReservedMenu4;
begin
  BMenu__ReservedMenu4(CPlusObject);
end;

procedure TMenu._ReservedMenu5;
begin
  BMenu__ReservedMenu5(CPlusObject);
end;

procedure TMenu._ReservedMenu6;
begin
  BMenu__ReservedMenu6(CPlusObject);
end;

function TMenu.operator=( : TMenu) : TMenu;
begin
  Result := BMenu_operator=(CPlusObject, );
end;

procedure TMenu.InitData(data : TMessage);
begin
  BMenu_InitData(CPlusObject, data.CPlusObject);
end;

function TMenu._show(selectFirstItem : boolean) : boolean;
begin
  Result := BMenu__show(CPlusObject, selectFirstItem);
end;

procedure TMenu._hide;
begin
  BMenu__hide(CPlusObject);
end;

function TMenu._track(action : integer; start : integer) : TMenuItem;
begin
  Result := BMenu__track(CPlusObject, action, start);
end;

function TMenu._AddItem(item : TMenuItem; index : integer) : boolean;
begin
  Result := BMenu__AddItem(CPlusObject, item.CPlusObject, index);
end;

function TMenu.RemoveItems(index : integer; count : integer; item : TMenuItem; del : boolean) : boolean;
begin
  Result := BMenu_RemoveItems(CPlusObject, index, count, item.CPlusObject, del);
end;

procedure TMenu.LayoutItems(index : integer);
begin
  BMenu_LayoutItems(CPlusObject, index);
end;

procedure TMenu.ComputeLayout(index : integer; bestFit : boolean; moveItems : boolean; width : double; height : double);
begin
  BMenu_ComputeLayout(CPlusObject, index, bestFit, moveItems, width, height);
end;

function TMenu.Bump(current : TRect; extent : TPoint; index : integer) : TRect;
begin
  Result := BMenu_Bump(CPlusObject, current.CPlusObject, extent.CPlusObject, index);
end;

function TMenu.ItemLocInRect(frame : TRect) : TPoint;
begin
  Result := BMenu_ItemLocInRect(CPlusObject, frame.CPlusObject);
end;

function TMenu.CalcFrame(where : TPoint; scrollOn : boolean) : TRect;
begin
  Result := BMenu_CalcFrame(CPlusObject, where.CPlusObject, scrollOn);
end;

function TMenu.ScrollMenu(bounds : TRect; loc : TPoint; fast : boolean) : boolean;
begin
  Result := BMenu_ScrollMenu(CPlusObject, bounds.CPlusObject, loc.CPlusObject, fast);
end;

procedure TMenu.ScrollIntoView(item : TMenuItem);
begin
  BMenu_ScrollIntoView(CPlusObject, item.CPlusObject);
end;

procedure TMenu.DrawItems(updateRect : TRect);
begin
  BMenu_DrawItems(CPlusObject, updateRect.CPlusObject);
end;

function TMenu.State(item : TMenuItem) : integer;
begin
  Result := BMenu_State(CPlusObject, item.CPlusObject);
end;

procedure TMenu.InvokeItem(item : TMenuItem; now : boolean);
begin
  BMenu_InvokeItem(CPlusObject, item.CPlusObject, now);
end;

function TMenu.OverSuper(loc : TPoint) : boolean;
begin
  Result := BMenu_OverSuper(CPlusObject, loc.CPlusObject);
end;

function TMenu.OverSubmenu(item : TMenuItem; loc : TPoint) : boolean;
begin
  Result := BMenu_OverSubmenu(CPlusObject, item.CPlusObject, loc.CPlusObject);
end;

function TMenu.MenuWindow : TMenuWindow;
begin
  Result := BMenu_MenuWindow(CPlusObject);
end;

procedure TMenu.DeleteMenuWindow;
begin
  BMenu_DeleteMenuWindow(CPlusObject);
end;

function TMenu.HitTestItems(where : TPoint; slop : TPoint) : TMenuItem;
begin
  Result := BMenu_HitTestItems(CPlusObject, where.CPlusObject, slop.CPlusObject);
end;

function TMenu.Superbounds : TRect;
begin
  Result := BMenu_Superbounds(CPlusObject);
end;

procedure TMenu.CacheFontInfo;
begin
  BMenu_CacheFontInfo(CPlusObject);
end;

procedure TMenu.ItemMarked(item : TMenuItem);
begin
  BMenu_ItemMarked(CPlusObject, item.CPlusObject);
end;

procedure TMenu.Install(target : TWindow);
begin
  BMenu_Install(CPlusObject, target.CPlusObject);
end;

procedure TMenu.Uninstall;
begin
  BMenu_Uninstall(CPlusObject);
end;

procedure TMenu.SelectItem(m : TMenuItem; showSubmenu : Cardinal; selectFirstItem : boolean);
begin
  BMenu_SelectItem(CPlusObject, m.CPlusObject, showSubmenu, selectFirstItem);
end;

function TMenu.CurrentSelection : TMenuItem;
begin
  Result := BMenu_CurrentSelection(CPlusObject);
end;

function TMenu.SelectNextItem(item : TMenuItem; forward : boolean) : boolean;
begin
  Result := BMenu_SelectNextItem(CPlusObject, item.CPlusObject, forward);
end;

function TMenu.NextItem(item : TMenuItem; forward : boolean) : TMenuItem;
begin
  Result := BMenu_NextItem(CPlusObject, item.CPlusObject, forward);
end;

function TMenu.IsItemVisible(item : TMenuItem) : boolean;
begin
  Result := BMenu_IsItemVisible(CPlusObject, item.CPlusObject);
end;

procedure TMenu.SetIgnoreHidden(aOn : boolean);
begin
  BMenu_SetIgnoreHidden(CPlusObject, aOn);
end;

procedure TMenu.SetStickyMode(aOn : boolean);
begin
  BMenu_SetStickyMode(CPlusObject, aOn);
end;

function TMenu.IsStickyMode : boolean;
begin
  Result := BMenu_IsStickyMode(CPlusObject);
end;

procedure TMenu.CalcTriggers;
begin
  BMenu_CalcTriggers(CPlusObject);
end;

function TMenu.ChooseTrigger(title : PChar; chars : TList) : PChar;
begin
  Result := BMenu_ChooseTrigger(CPlusObject, title, chars.CPlusObject);
end;

procedure TMenu.UpdateWindowViewSize(upWind : boolean);
begin
  BMenu_UpdateWindowViewSize(CPlusObject, upWind);
end;

function TMenu.IsStickyPrefOn : boolean;
begin
  Result := BMenu_IsStickyPrefOn(CPlusObject);
end;

procedure TMenu.RedrawAfterSticky(bounds : TRect);
begin
  BMenu_RedrawAfterSticky(CPlusObject, bounds.CPlusObject);
end;

function TMenu.OkToProceed( : TMenuItem) : boolean;
begin
  Result := BMenu_OkToProceed(CPlusObject, .CPlusObject);
end;

function TMenu.ParseMsg(msg : TMessage; sindex : ^integer; spec : TMessage; form : ^integer; prop : PChar; tmenu : TMenu; titem : TMenuItem; user_data : ^integer; reply : TMessage) : TStatus_t;
begin
  Result := BMenu_ParseMsg(CPlusObject, msg.CPlusObject, sindex, spec.CPlusObject, form, prop, tmenu.CPlusObject, titem.CPlusObject, user_data, reply.CPlusObject);
end;

function TMenu.DoMenuMsg(next : TMenuItem; tar : TMenu; m : TMessage; r : TMessage; spec : TMessage; f : integer) : TStatus_t;
begin
  Result := BMenu_DoMenuMsg(CPlusObject, next.CPlusObject, tar.CPlusObject, m.CPlusObject, r.CPlusObject, spec.CPlusObject, f);
end;

function TMenu.DoMenuItemMsg(next : TMenuItem; tar : TMenu; m : TMessage; r : TMessage; spec : TMessage; f : integer) : TStatus_t;
begin
  Result := BMenu_DoMenuItemMsg(CPlusObject, next.CPlusObject, tar.CPlusObject, m.CPlusObject, r.CPlusObject, spec.CPlusObject, f);
end;

function TMenu.DoEnabledMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
begin
  Result := BMenu_DoEnabledMsg(CPlusObject, ti.CPlusObject, tm.CPlusObject, m.CPlusObject, r.CPlusObject);
end;

function TMenu.DoLabelMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
begin
  Result := BMenu_DoLabelMsg(CPlusObject, ti.CPlusObject, tm.CPlusObject, m.CPlusObject, r.CPlusObject);
end;

function TMenu.DoMarkMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
begin
  Result := BMenu_DoMarkMsg(CPlusObject, ti.CPlusObject, tm.CPlusObject, m.CPlusObject, r.CPlusObject);
end;

function TMenu.DoDeleteMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage) : TStatus_t;
begin
  Result := BMenu_DoDeleteMsg(CPlusObject, ti.CPlusObject, tm.CPlusObject, m.CPlusObject, r.CPlusObject);
end;

function TMenu.DoCreateMsg(ti : TMenuItem; tm : TMenu; m : TMessage; r : TMessage; menu : boolean) : TStatus_t;
begin
  Result := BMenu_DoCreateMsg(CPlusObject, ti.CPlusObject, tm.CPlusObject, m.CPlusObject, r.CPlusObject, menu);
end;

procedure TMenu.menu_info sMenuInfo;
begin
  BMenu_menu_info sMenuInfo(CPlusObject);
end;

procedure TMenu.bool sSwapped;
begin
  BMenu_bool sSwapped(CPlusObject);
end;

procedure TMenu.BMenuItem *fChosenItem;
begin
  BMenu_BMenuItem *fChosenItem(CPlusObject);
end;

procedure TMenu.BList fItems;
begin
  BMenu_BList fItems(CPlusObject);
end;

procedure TMenu.BRect fPad;
begin
  BMenu_BRect fPad(CPlusObject);
end;

procedure TMenu.BMenuItem *fSelected;
begin
  BMenu_BMenuItem *fSelected(CPlusObject);
end;

procedure TMenu.BMenuWindow *fCachedMenuWindow;
begin
  BMenu_BMenuWindow *fCachedMenuWindow(CPlusObject);
end;

procedure TMenu.BMenu *fSuper;
begin
  BMenu_BMenu *fSuper(CPlusObject);
end;

procedure TMenu.BMenuItem *fSuperitem;
begin
  BMenu_BMenuItem *fSuperitem(CPlusObject);
end;

procedure TMenu.BRect fSuperbounds;
begin
  BMenu_BRect fSuperbounds(CPlusObject);
end;

procedure TMenu.float fAscent;
begin
  BMenu_float fAscent(CPlusObject);
end;

procedure TMenu.float fDescent;
begin
  BMenu_float fDescent(CPlusObject);
end;

procedure TMenu.float fFontHeight;
begin
  BMenu_float fFontHeight(CPlusObject);
end;

procedure TMenu.uint32 fState;
begin
  BMenu_uint32 fState(CPlusObject);
end;

procedure TMenu.menu_layout fLayout;
begin
  BMenu_menu_layout fLayout(CPlusObject);
end;

procedure TMenu.BRect *fExtraRect;
begin
  BMenu_BRect *fExtraRect(CPlusObject);
end;

procedure TMenu.float fMaxContentWidth;
begin
  BMenu_float fMaxContentWidth(CPlusObject);
end;

procedure TMenu.BPoint *fInitMatrixSize;
begin
  BMenu_BPoint *fInitMatrixSize(CPlusObject);
end;

procedure TMenu._ExtraMenuData_ *fExtraMenuData;
begin
  BMenu__ExtraMenuData_ *fExtraMenuData(CPlusObject);
end;

procedure TMenu.uint32 _reserved[2];
begin
  BMenu_uint32 _reserved[2](CPlusObject);
end;

procedure TMenu.char fTrigger;
begin
  BMenu_char fTrigger(CPlusObject);
end;

procedure TMenu.bool fResizeToFit;
begin
  BMenu_bool fResizeToFit(CPlusObject);
end;

procedure TMenu.bool fUseCachedMenuLayout;
begin
  BMenu_bool fUseCachedMenuLayout(CPlusObject);
end;

procedure TMenu.bool fEnabled;
begin
  BMenu_bool fEnabled(CPlusObject);
end;

procedure TMenu.bool fDynamicName;
begin
  BMenu_bool fDynamicName(CPlusObject);
end;

procedure TMenu.bool fRadioMode;
begin
  BMenu_bool fRadioMode(CPlusObject);
end;

procedure TMenu.bool fTrackNewBounds;
begin
  BMenu_bool fTrackNewBounds(CPlusObject);
end;

procedure TMenu.bool fStickyMode;
begin
  BMenu_bool fStickyMode(CPlusObject);
end;

procedure TMenu.bool fIgnoreHidden;
begin
  BMenu_bool fIgnoreHidden(CPlusObject);
end;

procedure TMenu.bool fTriggerEnabled;
begin
  BMenu_bool fTriggerEnabled(CPlusObject);
end;

procedure TMenu.bool fRedrawAfterSticky;
begin
  BMenu_bool fRedrawAfterSticky(CPlusObject);
end;

procedure TMenu.bool fAttachAborted;
begin
  BMenu_bool fAttachAborted(CPlusObject);
end;
}

constructor TMenuItem.Create;
begin
//  CPlusObject := BMenuItem_Create(Self);
end;

constructor TMenuItem.Create(aMenu : TMenu; message : TMessage);
begin
  CPlusObject := BMenuItem_Create(Self, menu.CPlusObject, message.CPlusObject);
end;

constructor TMenuItem.Create(data : TMessage);
begin
  CPlusObject := BMenuItem_Create(Self, data.CPlusObject);
end;

constructor TMenuItem.Create(aLabel : PChar; message : TMessage; aShortcut : Char; modifiers : Cardinal);
begin
  CPlusObject := BMenuItem_Create(Self, aLabel, message.CPlusObject, aShortcut, modifiers);  
end;

destructor TMenuItem.Destroy;
begin
  BMenuItem_Free(CPlusObject);
  inherited;
end;

function TMenuItem.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BMenuItem_Instantiate(CPlusObject, data.CPlusObject);
end;

function TMenuItem.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BMenuItem_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TMenuItem.SetLabel(name : PChar);
begin
  BMenuItem_SetLabel(CPlusObject, name);
end;

procedure TMenuItem.SetEnabled(state : boolean);
begin
//  BMenuItem_SetEnabled(CPlusObject, state);
end;

procedure TMenuItem.SetMarked(state : boolean);
begin
  BMenuItem_SetMarked(CPlusObject, state);
end;

procedure TMenuItem.SetTrigger(ch : Char);
begin
  BMenuItem_SetTrigger(CPlusObject, ch);
end;

procedure TMenuItem.SetShortcut(ch : Char; modifiers : Cardinal);
begin
  BMenuItem_SetShortcut(CPlusObject, ch, modifiers);
end;

{function TMenuItem.aLabel : PChar;
begin
  Result := BMenuItem_Label(CPlusObject);
end;
}

function TMenuItem.IsEnabled : boolean;
begin
  Result := BMenuItem_IsEnabled(CPlusObject);
end;

function TMenuItem.IsMarked : boolean;
begin
  Result := BMenuItem_IsMarked(CPlusObject);
end;

function TMenuItem.Trigger : Char;
begin
  Result := BMenuItem_Trigger(CPlusObject);
end;

{function TMenuItem.Shortcut(modifiers : Cardinal) : Char;
begin
  Result := BMenuItem_Shortcut(CPlusObject, modifiers);
end;}

function TMenuItem.Submenu : TMenu;
begin
  Result := BMenuItem_Submenu(CPlusObject);
end;

function TMenuItem.Menu : TMenu;
begin
  Result := BMenuItem_Menu(CPlusObject);
end;

function TMenuItem.Frame : TRect;
begin
  Result := BMenuItem_Frame(CPlusObject);
end;

{
procedure TMenuItem.GetContentSize(width : double; height : double);
begin
  BMenuItem_GetContentSize(CPlusObject, width, height);
end;

procedure TMenuItem.TruncateLabel(max : double; new_label : PChar);
begin
  BMenuItem_TruncateLabel(CPlusObject, max, new_label);
end;

procedure TMenuItem.DrawContent;
begin
//  BMenuItem_DrawContent(CPlusObject);
end;

procedure TMenuItem.Draw;
begin
//  BMenuItem_Draw(CPlusObject);
end;

procedure TMenuItem.Highlight(aOn : boolean);
begin
  BMenuItem_Highlight(CPlusObject, aOn);
end;

function TMenuItem.IsSelected : boolean;
begin
  Result := BMenuItem_IsSelected(CPlusObject);
end;

function TMenuItem.ContentLocation : TPoint;
begin
  Result := BMenuItem_ContentLocation(CPlusObject);
end;

procedure TMenuItem._ReservedMenuItem2;
begin
  BMenuItem__ReservedMenuItem2(CPlusObject);
end;

procedure TMenuItem._ReservedMenuItem3;
begin
  BMenuItem__ReservedMenuItem3(CPlusObject);
end;

procedure TMenuItem._ReservedMenuItem4;
begin
  BMenuItem__ReservedMenuItem4(CPlusObject);
end;

constructor TMenuItem.Create( : TMenuItem) : TCPlusObject;
begin
  CPlusObject := BMenuItem_Create(Self, );
end;

function TMenuItem.operator=( : TMenuItem) : TMenuItem;
begin
  Result := BMenuItem_operator=(CPlusObject, );
end;

procedure TMenuItem.InitData;
begin
  BMenuItem_InitData(CPlusObject);
end;

procedure TMenuItem.InitMenuData(menu : TMenu);
begin
  BMenuItem_InitMenuData(CPlusObject, menu.CPlusObject);
end;

procedure TMenuItem.Install(window : TWindow);
begin
  BMenuItem_Install(CPlusObject, window.CPlusObject);
end;

function TMenuItem.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BMenuItem_Invoke(CPlusObject, msg.CPlusObject);
end;

procedure TMenuItem.Uninstall;
begin
  BMenuItem_Uninstall(CPlusObject);
end;

procedure TMenuItem.SetSuper(super : TMenu);
begin
  BMenuItem_SetSuper(CPlusObject, super.CPlusObject);
end;

procedure TMenuItem.Select(on : boolean);
begin
  BMenuItem_Select(CPlusObject, on);
end;

procedure TMenuItem.DrawMarkSymbol;
begin
  BMenuItem_DrawMarkSymbol(CPlusObject);
end;

procedure TMenuItem.DrawShortcutSymbol;
begin
  BMenuItem_DrawShortcutSymbol(CPlusObject);
end;

procedure TMenuItem.DrawSubmenuSymbol;
begin
  BMenuItem_DrawSubmenuSymbol(CPlusObject);
end;

procedure TMenuItem.DrawControlChar(control : PChar);
begin
  BMenuItem_DrawControlChar(CPlusObject, control);
end;

procedure TMenuItem.SetSysTrigger(ch : Char);
begin
  BMenuItem_SetSysTrigger(CPlusObject, ch);
end;

procedure TMenuItem.char *fLabel;
begin
  BMenuItem_char *fLabel(CPlusObject);
end;

procedure TMenuItem.BMenu *fSubmenu;
begin
  BMenuItem_BMenu *fSubmenu(CPlusObject);
end;

procedure TMenuItem.BWindow *fWindow;
begin
  BMenuItem_BWindow *fWindow(CPlusObject);
end;

procedure TMenuItem.BMenu *fSuper;
begin
  BMenuItem_BMenu *fSuper(CPlusObject);
end;

procedure TMenuItem.BRect fBounds;
begin
  BMenuItem_BRect fBounds(CPlusObject);
end;

procedure TMenuItem.uint32 fModifiers;
begin
  BMenuItem_uint32 fModifiers(CPlusObject);
end;

procedure TMenuItem.float fCachedWidth;
begin
  BMenuItem_float fCachedWidth(CPlusObject);
end;

procedure TMenuItem.int16 fTriggerIndex;
begin
  BMenuItem_int16 fTriggerIndex(CPlusObject);
end;

procedure TMenuItem.char fUserTrigger;
begin
  BMenuItem_char fUserTrigger(CPlusObject);
end;

procedure TMenuItem.char fSysTrigger;
begin
  BMenuItem_char fSysTrigger(CPlusObject);
end;

procedure TMenuItem.char fShortcutChar;
begin
  BMenuItem_char fShortcutChar(CPlusObject);
end;

procedure TMenuItem.bool fMark;
begin
  BMenuItem_bool fMark(CPlusObject);
end;

procedure TMenuItem.bool fEnabled;
begin
  BMenuItem_bool fEnabled(CPlusObject);
end;

procedure TMenuItem.bool fSelected;
begin
  BMenuItem_bool fSelected(CPlusObject);
end;

procedure TMenuItem.uint32 _reserved[4];
begin
  BMenuItem_uint32 _reserved[4](CPlusObject);
end;
}

constructor TSeparatorItem.Create;
begin
  CPlusObject := BSeparatorItem_Create(Self);
end;

constructor TSeparatorItem.Create(data : TMessage);
begin
  CPlusObject := BSeparatorItem_Create(Self, data.CPlusObject);
end;

destructor TSeparatorItem.Destroy;
begin
  BSeparatorItem_Free(CPlusObject);
  inherited;
end;

function TSeparatorItem.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BSeparatorItem_Archive(CPlusObject, data.CPlusObject, deep);
end;

function TSeparatorItem.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BSeparatorItem_Instantiate(CPlusObject, data.CPlusObject);
end;

procedure TSeparatorItem.SetEnabled(state : boolean);
begin
//  BSeparatorItem_SetEnabled(CPlusObject, state);
end;

{
procedure TSeparatorItem.GetContentSize(width : double; height : double);
begin
  BSeparatorItem_GetContentSize(CPlusObject, width, height);
end;

procedure TSeparatorItem.Draw;
begin
//  BSeparatorItem_Draw(CPlusObject);
end;

procedure TSeparatorItem._ReservedSeparatorItem1;
begin
  BSeparatorItem__ReservedSeparatorItem1(CPlusObject);
end;

procedure TSeparatorItem._ReservedSeparatorItem2;
begin
  BSeparatorItem__ReservedSeparatorItem2(CPlusObject);
end;

function TSeparatorItem.operator=( : TSeparatorItem) : TSeparatorItem;
begin
  Result := BSeparatorItem_operator=(CPlusObject, );
end;

procedure TSeparatorItem.uint32 _reserved[1];
begin
  BSeparatorItem_uint32 _reserved[1](CPlusObject);
end;
}

end.
