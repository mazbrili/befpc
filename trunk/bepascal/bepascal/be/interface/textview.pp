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
unit textview;

interface

uses
  beobj, interfacedefs,view,Message, Archivable, SupportDefs, Rect, Handler;

{type
  Ttext_run = Record
    offset : Integer;
    font TFont; 
    color : Trgb_color;
end;

type
  Ttext_run_array = Record
    count : Integer;
     runs : Ttext_run runs;
  end;
}  
type
Tundo_state =(undo_state_nil,
	B_UNDO_UNAVAILABLE,
	B_UNDO_TYPING,
	B_UNDO_CUT,
	B_UNDO_PASTE,
	B_UNDO_CLEAR,
	B_UNDO_DROP);
  
type
   TTextView = class(TView)
  private
  public
    constructor Create(frame : TRect; name : pchar;atextRect: TRect ; resizeMask, flags : cardinal); virtual;
//    constructor Create(bounds : TRect; name : pchar; texte : pchar; resizeflags, flags : cardinal); virtual;
    constructor Create(data : TMessage);virtual;
    destructor Destroy;override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure AttachedToWindow;override;
    procedure DetachedFromWindow;override;
    procedure Draw(inRect : TRect);override;
    procedure MouseDown(where : TPoint);override;
    procedure MouseUp(where : TPoint);override;
    procedure MouseMoved(where : TPoint; code : Cardinal; message : TMessage);override;
    procedure WindowActivated(state : boolean);override;
    procedure KeyDown(bytes : PChar; numBytes : integer);override;
    procedure Pulse;override;
    procedure FrameResized(width : double; height : double);override;
    procedure MakeFocus(focusState : boolean);
    procedure MessageReceived(message : TMessage);override;
    function ResolveSpecifier(message : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
{    procedure SetText(inText : PChar; inRuns :  Ttext_tun_array);
    procedure SetText(inText : PChar; inLength : integer; inRuns :  Ttext_tun_array);
    procedure SetText(inFile : TFile; startOffset : integer; inLength : integer; inRuns :  Ttext_tun_array);
    procedure Insert(inText : PChar; inRuns :  Ttext_tun_array);
    procedure Insert(inText : PChar; inLength : integer; inRuns :  Ttext_tun_array);
    procedure Insert(startOffset : integer; inText : PChar; inLength : integer; inRuns :  Ttext_tun_array);
}    procedure Delete;
    procedure Delete(startOffset : integer; endOffset : integer);
    function Text : PChar;
    function TextLength : integer;
    procedure GetText(offset : integer; length : integer; buffer : PChar);
    function ByteAt(offset : integer) :  PChar;
    function CountLines : integer;
    function CurrentLine : integer;
    procedure GoToLine(lineNum : integer);
{    procedure Cut(clipboard : TClipboard);
    procedure Copy(clipboard : TClipboard);
    procedure Paste(clipboard : TClipboard);
    procedure Clear;
    function AcceptsPaste(clipboard : TClipboard) : boolean;
}   function AcceptsDrop(inMessage : TMessage) : boolean;
    procedure Select(startOffset : integer; endOffset : integer);
    procedure SelectAll;
//    procedure GetSelection(outStart : integer; outEnd : integer);
{    procedure SetFontAndColor(inFont :  TFont; inMode : Cardinal; inColor :  Trgb_color);
    procedure SetFontAndColor(startOffset : integer; endOffset : integer; inFont :  TFont; inMode : Cardinal; inColor :  Trgb_color);
    procedure GetFontAndColor(inOffset : integer; outFont :  TFont; outColor : Trgb_color);
    procedure GetFontAndColor(outFont :  TFont; outMode :  integer; outColor : Trgb_color; outEqColor : boolean);
   procedure SetRunArray(startOffset : integer; endOffset : integer; inRuns :  Ttext_tun_array);
    function RunArray(startOffset : integer; endOffset : integer; outSize : ^integer) : Ttext_run_array;
}    function LineAt(offset : integer) : integer;
    function LineAt(point : TPoint) : integer;
    function PointAt(inOffset : integer; outHeight : double) : TPoint;
    function OffsetAt(point : TPoint) : integer;
    function OffsetAt(line : integer) : integer;
    procedure FindWord(inOffset : integer; outFromOffset : integer; outToOffset : integer);
    function CanEndLine(offset : integer) : boolean;
    function LineWidth(lineNum : integer) : double;
    function LineHeight(lineNum : integer) : double;
    function TextHeight(startLine : integer; endLine : integer) : double;
//    procedure GetTextRegion(startOffset : integer; endOffset : integer; outRegion :  TRegion);
    procedure ScrollToOffset(inOffset : integer);
    procedure ScrollToSelection;
    procedure Highlight(startOffset : integer; endOffset : integer);
    procedure SetTextRect(rect : TRect);
    function TextRect : TRect;
    procedure SetStylable(stylable : boolean);
    function IsStylable : boolean;
    procedure SetTabWidth(width : double);
    function TabWidth : double;
    procedure MakeSelectable(selectable : boolean);
    function IsSelectable : boolean;
    procedure MakeEditable(editable : boolean);
    function IsEditable : boolean;
    procedure SetWordWrap(awrap : boolean);
    function DoesWordWrap : boolean;
    procedure SetMaxBytes(max : integer);
    function MaxBytes : integer;
    procedure DisallowChar(aChar : Cardinal);
    procedure AllowChar(aChar : Cardinal);
    procedure SetAlignment(flag : Talignment);
    function Alignment : Talignment;
    procedure SetAutoindent(state : boolean);
    function DoesAutoindent : boolean;
{    procedure SetColorSpace(colors : TColor_Space);
    function ColorSpace : TColor_Space;
}   procedure MakeResizable(resize : boolean; resizeView : TView);
    function IsResizable : boolean;
    procedure SetDoesUndo(undo : boolean);
    function DoesUndo : boolean;
    procedure HideTyping(enabled : boolean);
    function IsTypingHidden : boolean;
    procedure ResizeToPreferred;override;
    procedure GetPreferredSize(width : double; height : double);virtual;
    procedure AllAttached;override;
    procedure AllDetached;override;
{    function FlattenRunArray(inArray :  Ttext_tun_array; outSize : ^integer) : Pointer;
    function UnflattenRunArray(data : Pointer; outSize : ^integer) : Ttext_run_array;
    procedure InsertText(inText : PChar; inLength : integer; inOffset : integer; inRuns :  Ttext_tun_array);
}    
  //  procedure Undo(clipboard : TClipboard);
//    procedure GetDragParameters(drag : TMessage; bitmap : TBitmap; point : TPoint; handler : THandler);
//    procedure InitObject(atextRect : TRect; initialFont :  TFont; initialColor :  Trgb_color);
  end;

function BTextView_Create(AObject : TBeObject;frame : TCPlusObject; name : pchar; atextRect: TCPlusObject ; resizeMask, flags : cardinal): TCPlusObject; cdecl; external BePascalLibName name 'BTextView_Create';

function BTextView_Create(AObject : TBeObject; data : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BTextView_Create_1';
procedure BTextView_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_FREE';
function BTextView_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BTextView_Instantiate';
function BTextView_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BTextView_Archive';
procedure BTextView_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_AttachedToWindow';
procedure BTextView_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_DetachedFromWindow';
procedure BTextView_Draw(AObject : TCPlusObject; inRect : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_Draw';
procedure BTextView_MouseDown(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_MouseDown';
procedure BTextView_MouseUp(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_MouseUp';
procedure BTextView_MouseMoved(AObject : TCPlusObject; where : TCPlusObject; code : Cardinal; message : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_MouseMoved';
procedure BTextView_WindowActivated(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BTextView_WindowActivated';
procedure BTextView_KeyDown(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BTextView_KeyDown';
procedure BTextView_Pulse(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_Pulse';
procedure BTextView_FrameResized(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BTextView_FrameResized';
procedure BTextView_MakeFocus(AObject : TCPlusObject; focusState : boolean); cdecl; external BePascalLibName name 'BTextView_MakeFocus';
procedure BTextView_MessageReceived(AObject : TCPlusObject; message : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_MessageReceived';
function BTextView_ResolveSpecifier(AObject : TCPlusObject; message : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BTextView_ResolveSpecifier';
function BTextView_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BTextView_GetSupportedSuites';
function BTextView_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BTextView_Perform';
//procedure BTextView_SetText(AObject : TCPlusObject; inText : PChar; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_SetText';
//procedure BTextView_SetText(AObject : TCPlusObject; inText : PChar; inLength : integer; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_SetText';
//procedure BTextView_SetText(AObject : TCPlusObject; inFile : TFile; startOffset : integer; inLength : integer; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_SetText';
//procedure BTextView_Insert(AObject : TCPlusObject; inText : PChar; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_Insert';
//procedure BTextView_Insert(AObject : TCPlusObject; inText : PChar; inLength : integer; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_Insert';
//procedure BTextView_Insert(AObject : TCPlusObject; startOffset : integer; inText : PChar; inLength : integer; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_Insert';
procedure BTextView_Delete(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_Delete';
procedure BTextView_Delete(AObject : TCPlusObject; startOffset : integer; endOffset : integer); cdecl; external BePascalLibName name 'BTextView_Delete';
function BTextView_Text(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BTextView_Text';
function BTextView_TextLength(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTextView_TextLength';
procedure BTextView_GetText(AObject : TCPlusObject; offset : integer; length : integer; buffer : PChar); cdecl; external BePascalLibName name 'BTextView_GetText';
function BTextView_ByteAt(AObject : TCPlusObject; offset : integer) :  PChar; cdecl; external BePascalLibName name 'BTextView_ByteAt';
function BTextView_CountLines(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTextView_CountLines';
function BTextView_CurrentLine(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTextView_CurrentLine';
procedure BTextView_GoToLine(AObject : TCPlusObject; lineNum : integer); cdecl; external BePascalLibName name 'BTextView_GoToLine';
//procedure BTextView_Cut(AObject : TCPlusObject; clipboard : TClipboard); cdecl; external BePascalLibName name 'BTextView_Cut';
//procedure BTextView_Copy(AObject : TCPlusObject; clipboard : TClipboard); cdecl; external BePascalLibName name 'BTextView_Copy';
//procedure BTextView_Paste(AObject : TCPlusObject; clipboard : TClipboard); cdecl; external BePascalLibName name 'BTextView_Paste';
procedure BTextView_Clear(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_Clear';
//function BTextView_AcceptsPaste(AObject : TCPlusObject; clipboard : TClipboard) : boolean; cdecl; external BePascalLibName name 'BTextView_AcceptsPaste';
function BTextView_AcceptsDrop(AObject : TCPlusObject; inMessage : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_AcceptsDrop';
procedure BTextView_Select(AObject : TCPlusObject; startOffset : integer; endOffset : integer); cdecl; external BePascalLibName name 'BTextView_Select';
procedure BTextView_SelectAll(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_SelectAll';
//procedure BTextView_GetSelection(AObject : TCPlusObject; outStart : ^integer; outEnd : ^integer); cdecl; external BePascalLibName name 'BTextView_GetSelection';
//procedure BTextView_SetFontAndColor(AObject : TCPlusObject; inFont :  TFont; inMode : Cardinal; inColor :  Trgb_color); cdecl; external BePascalLibName name 'BTextView_SetFontAndColor';
//procedure BTextView_SetFontAndColor(AObject : TCPlusObject; startOffset : integer; endOffset : integer; inFont :  TFont; inMode : Cardinal; inColor :  Trgb_color); cdecl; external BePascalLibName name 'BTextView_SetFontAndColor';
//procedure BTextView_GetFontAndColor(AObject : TCPlusObject; inOffset : integer; outFont :  TFont; outColor : Trgb_color); cdecl; external BePascalLibName name 'BTextView_GetFontAndColor';
//procedure BTextView_GetFontAndColor(AObject : TCPlusObject; outFont :  TFont; outMode :  integer; outColor : Trgb_color; outEqColor : boolean); cdecl; external BePascalLibName name 'BTextView_GetFontAndColor';
//procedure BTextView_SetRunArray(AObject : TCPlusObject; startOffset : integer; endOffset : integer; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_SetRunArray';
//function BTextView_RunArray(AObject : TCPlusObject; startOffset : integer; endOffset : integer; outSize : ^integer) : Ttext_run_array; cdecl; external BePascalLibName name 'BTextView_RunArray';
function BTextView_LineAt(AObject : TCPlusObject; offset : integer) : integer; cdecl; external BePascalLibName name 'BTextView_LineAt';
function BTextView_LineAt(AObject : TCPlusObject; point : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTextView_LineAt';
function BTextView_PointAt(AObject : TCPlusObject; inOffset : integer; outHeight : double) : TPoint; cdecl; external BePascalLibName name 'BTextView_PointAt';
function BTextView_OffsetAt(AObject : TCPlusObject; point : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTextView_OffsetAt';
function BTextView_OffsetAt(AObject : TCPlusObject; line : integer) : integer; cdecl; external BePascalLibName name 'BTextView_OffsetAt';
procedure BTextView_FindWord(AObject : TCPlusObject; inOffset : integer; outFromOffset : integer; outToOffset : integer); cdecl; external BePascalLibName name 'BTextView_FindWord';
function BTextView_CanEndLine(AObject : TCPlusObject; offset : integer) : boolean; cdecl; external BePascalLibName name 'BTextView_CanEndLine';
function BTextView_LineWidth(AObject : TCPlusObject; lineNum : integer) : double; cdecl; external BePascalLibName name 'BTextView_LineWidth';
function BTextView_LineHeight(AObject : TCPlusObject; lineNum : integer) : double; cdecl; external BePascalLibName name 'BTextView_LineHeight';
function BTextView_TextHeight(AObject : TCPlusObject; startLine : integer; endLine : integer) : double; cdecl; external BePascalLibName name 'BTextView_TextHeight';
//procedure BTextView_GetTextRegion(AObject : TCPlusObject; startOffset : integer; endOffset : integer; outRegion :  TRegion); cdecl; external BePascalLibName name 'BTextView_GetTextRegion';
procedure BTextView_ScrollToOffset(AObject : TCPlusObject; inOffset : integer); cdecl; external BePascalLibName name 'BTextView_ScrollToOffset';
procedure BTextView_ScrollToSelection(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_ScrollToSelection';
procedure BTextView_Highlight(AObject : TCPlusObject; startOffset : integer; endOffset : integer); cdecl; external BePascalLibName name 'BTextView_Highlight';
procedure BTextView_SetTextRect(AObject : TCPlusObject; rect : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_SetTextRect';
function BTextView_TextRect(AObject : TCPlusObject) : TRect; cdecl; external BePascalLibName name 'BTextView_TextRect';
procedure BTextView_SetStylable(AObject : TCPlusObject; stylable : boolean); cdecl; external BePascalLibName name 'BTextView_SetStylable';
function BTextView_IsStylable(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_IsStylable';
procedure BTextView_SetTabWidth(AObject : TCPlusObject; width : double); cdecl; external BePascalLibName name 'BTextView_SetTabWidth';
function BTextView_TabWidth(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BTextView_TabWidth';
procedure BTextView_MakeSelectable(AObject : TCPlusObject; selectable : boolean); cdecl; external BePascalLibName name 'BTextView_MakeSelectable';
function BTextView_IsSelectable(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_IsSelectable';
procedure BTextView_MakeEditable(AObject : TCPlusObject; editable : boolean); cdecl; external BePascalLibName name 'BTextView_MakeEditable';
function BTextView_IsEditable(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_IsEditable';
procedure BTextView_SetWordWrap(AObject : TCPlusObject; wrap : boolean); cdecl; external BePascalLibName name 'BTextView_SetWordWrap';
function BTextView_DoesWordWrap(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_DoesWordWrap';
procedure BTextView_SetMaxBytes(AObject : TCPlusObject; max : integer); cdecl; external BePascalLibName name 'BTextView_SetMaxBytes';
function BTextView_MaxBytes(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BTextView_MaxBytes';
procedure BTextView_DisallowChar(AObject : TCPlusObject; aChar : Cardinal); cdecl; external BePascalLibName name 'BTextView_DisallowChar';
procedure BTextView_AllowChar(AObject : TCPlusObject; aChar : Cardinal); cdecl; external BePascalLibName name 'BTextView_AllowChar';
procedure BTextView_SetAlignment(AObject : TCPlusObject; flag : Talignment); cdecl; external BePascalLibName name 'BTextView_SetAlignment';
function BTextView_Alignment(AObject : TCPlusObject) : Talignment; cdecl; external BePascalLibName name 'BTextView_Alignment';
procedure BTextView_SetAutoindent(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BTextView_SetAutoindent';
function BTextView_DoesAutoindent(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_DoesAutoindent';
//procedure BTextView_SetColorSpace(AObject : TCPlusObject; colors : TColor_Space); cdecl; external BePascalLibName name 'BTextView_SetColorSpace';
//function BTextView_ColorSpace(AObject : TCPlusObject) : TColor_Space; cdecl; external BePascalLibName name 'BTextView_ColorSpace';
procedure BTextView_MakeResizable(AObject : TCPlusObject; resize : boolean; resizeView : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_MakeResizable';
function BTextView_IsResizable(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_IsResizable';
procedure BTextView_SetDoesUndo(AObject : TCPlusObject; undo : boolean); cdecl; external BePascalLibName name 'BTextView_SetDoesUndo';
function BTextView_DoesUndo(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_DoesUndo';
procedure BTextView_HideTyping(AObject : TCPlusObject; enabled : boolean); cdecl; external BePascalLibName name 'BTextView_HideTyping';
function BTextView_IsTypingHidden(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BTextView_IsTypingHidden';
procedure BTextView_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_ResizeToPreferred';
procedure BTextView_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BTextView_GetPreferredSize';
procedure BTextView_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_AllAttached';
procedure BTextView_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_AllDetached';
//function BTextView_FlattenRunArray(AObject : TCPlusObject; inArray :  Ttext_tun_array; outSize : ^integer) : Pointer; cdecl; external BePascalLibName name 'BTextView_FlattenRunArray';
//function BTextView_UnflattenRunArray(AObject : TCPlusObject; data : Pointer; outSize : ^integer) : Ttext_run_array; cdecl; external BePascalLibName name 'BTextView_UnflattenRunArray';
//procedure BTextView_InsertText(AObject : TCPlusObject; inText : PChar; inLength : integer; inOffset : integer; inRuns :  Ttext_tun_array); cdecl; external BePascalLibName name 'BTextView_InsertText';
//procedure BTextView_Undo(AObject : TCPlusObject; clipboard : TClipboard); cdecl; external BePascalLibName name 'BTextView_Undo';
//function BTextView_UndoState(AObject : TCPlusObject; isRedo : boolean) :  Tunde_state; cdecl; external BePascalLibName name 'BTextView_UndoState';
//procedure BTextView_GetDragParameters(AObject : TCPlusObject; drag : TMessage; bitmap : TBitmap; point : TPoint; handler : THandler); cdecl; external BePascalLibName name 'BTextView_GetDragParameters';
procedure BTextView__ReservedTextView3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView3';
procedure BTextView__ReservedTextView4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView4';
procedure BTextView__ReservedTextView5(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView5';
procedure BTextView__ReservedTextView6(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView6';
procedure BTextView__ReservedTextView7(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView7';
procedure BTextView__ReservedTextView8(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView8';
procedure BTextView__ReservedTextView9(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView9';
procedure BTextView__ReservedTextView10(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView10';
procedure BTextView__ReservedTextView11(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView11';
procedure BTextView__ReservedTextView12(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView__ReservedTextView12';
//procedure BTextView_InitObject(AObject : TCPlusObject; textRect : TRect; initialFont :  TFont; initialColor :  Trgb_color); cdecl; external BePascalLibName name 'BTextView_InitObject';
procedure BTextView_HandleBackspace(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_HandleBackspace';
procedure BTextView_HandleArrowKey(AObject : TCPlusObject; inArrowKey : Cardinal); cdecl; external BePascalLibName name 'BTextView_HandleArrowKey';
procedure BTextView_HandleDelete(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_HandleDelete';
procedure BTextView_HandlePageKey(AObject : TCPlusObject; inPageKey : Cardinal); cdecl; external BePascalLibName name 'BTextView_HandlePageKey';
procedure BTextView_HandleAlphaKey(AObject : TCPlusObject; bytes : PChar; numBytes : integer); cdecl; external BePascalLibName name 'BTextView_HandleAlphaKey';
procedure BTextView_Refresh(AObject : TCPlusObject; fromOffset : integer; toOffset : integer; erase : boolean; scroll : boolean); cdecl; external BePascalLibName name 'BTextView_Refresh';
//procedure BTextView_RecalLineBreaks(AObject : TCPlusObject; startLine : ^integer; endLine : ^integer); cdecl; external BePascalLibName name 'BTextView_RecalLineBreaks';
function BTextView_FindLineBreak(AObject : TCPlusObject; fromOffset : integer; outAscent : double; outDescent : double; ioWidth : double) : integer; cdecl; external BePascalLibName name 'BTextView_FindLineBreak';
function BTextView_StyledWidth(AObject : TCPlusObject; fromOffset : integer; length : integer; outAscent : double; outDescent : double) : double; cdecl; external BePascalLibName name 'BTextView_StyledWidth';
function BTextView_ActualTabWidth(AObject : TCPlusObject; location : double) : double; cdecl; external BePascalLibName name 'BTextView_ActualTabWidth';
//procedure BTextView_DoInsertText(AObject : TCPlusObject; inText : PChar; inLength : integer; inOffset : integer; inRuns :  Ttext_tun_array; outResult : ); cdecl; external BePascalLibName name 'BTextView_DoInsertText';
//procedure BTextView_DoDeleteText(AObject : TCPlusObject; fromOffset : integer; toOffset : integer; outResult : ); cdecl; external BePascalLibName name 'BTextView_DoDeleteText';
procedure BTextView_DrawLines(AObject : TCPlusObject; startLine : integer; endLine : integer; startOffset : integer; erase : boolean); cdecl; external BePascalLibName name 'BTextView_DrawLines';
procedure BTextView_DrawCaret(AObject : TCPlusObject; offset : integer); cdecl; external BePascalLibName name 'BTextView_DrawCaret';
procedure BTextView_InvertCaret(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_InvertCaret';
procedure BTextView_DragCaret(AObject : TCPlusObject; offset : integer); cdecl; external BePascalLibName name 'BTextView_DragCaret';
procedure BTextView_StopMouseTracking(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_StopMouseTracking';
function BTextView_PerformMouseUp(AObject : TCPlusObject; where : TPoint) : boolean; cdecl; external BePascalLibName name 'BTextView_PerformMouseUp';
function BTextView_PerformMouseMoved(AObject : TCPlusObject; where : TPoint; code : Cardinal) : boolean; cdecl; external BePascalLibName name 'BTextView_PerformMouseMoved';
procedure BTextView_TrackMouse(AObject : TCPlusObject; where : TPoint; message : TMessage; force : boolean); cdecl; external BePascalLibName name 'BTextView_TrackMouse';
procedure BTextView_TrackDrag(AObject : TCPlusObject; where : TPoint); cdecl; external BePascalLibName name 'BTextView_TrackDrag';
procedure BTextView_InitiateDrag(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_InitiateDrag';
function BTextView_MessageDropped(AObject : TCPlusObject; inMessage : TMessage; where : TPoint; offset : TPoint) : boolean; cdecl; external BePascalLibName name 'BTextView_MessageDropped';
procedure BTextView_UpdateScrollbars(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_UpdateScrollbars';
procedure BTextView_AutoResize(AObject : TCPlusObject; doredraw : boolean); cdecl; external BePascalLibName name 'BTextView_AutoResize';
procedure BTextView_NewOffscreen(AObject : TCPlusObject; padding : double); cdecl; external BePascalLibName name 'BTextView_NewOffscreen';
procedure BTextView_DeleteOffscreen(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_DeleteOffscreen';
procedure BTextView_Activate(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_Activate';
procedure BTextView_Deactivate(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_Deactivate';
//procedure BTextView_NormalizeFont(AObject : TCPlusObject; font :  TFont); cdecl; external BePascalLibName name 'BTextView_NormalizeFont';
function BTextView_CharClassification(AObject : TCPlusObject; offset : integer) : Cardinal; cdecl; external BePascalLibName name 'BTextView_CharClassification';
function BTextView_NextInitialByte(AObject : TCPlusObject; offset : integer) : integer; cdecl; external BePascalLibName name 'BTextView_NextInitialByte';
function BTextView_PreviousInitialByte(AObject : TCPlusObject; offset : integer) : integer; cdecl; external BePascalLibName name 'BTextView_PreviousInitialByte';
//function BTextView_GetProperty(AObject : TCPlusObject; specifier : TMessage; form : integer; property : PChar; reply : TMessage) : boolean; cdecl; external BePascalLibName name 'BTextView_GetProperty';
function BTextView_SetProperty(AObject : TCPlusObject; specifier : TMessage; form : integer; properti : PChar; reply : TMessage) : boolean; cdecl; external BePascalLibName name 'BTextView_SetProperty';
function BTextView_CountProperties(AObject : TCPlusObject; specifier : TMessage; form : integer; properti : PChar; reply : TMessage) : boolean; cdecl; external BePascalLibName name 'BTextView_CountProperties';
procedure BTextView_HandleInputMethodChanged(AObject : TCPlusObject; message : TMessage); cdecl; external BePascalLibName name 'BTextView_HandleInputMethodChanged';
procedure BTextView_HandleInputMethodLocationRequest(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_HandleInputMethodLocationRequest';
procedure BTextView_CancelInputMethod(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_CancelInputMethod';
procedure BTextView_LockWidthBuffer(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_LockWidthBuffer';
procedure BTextView_UnlockWidthBuffer(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextView_UnlockWidthBuffer';

implementation


constructor  TTextView.Create(frame : TRect; name : pchar;atextRect: TRect ; resizeMask, flags : cardinal); 
begin
  CreatePas;
  CPlusObject := BTextView_Create(Self, 	frame.CplusObject,name,atextRect.CPlusObject,resizeMask,flags);
end;

constructor  TTextView.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BTextView_Create(Self, data.CPlusObject);
end;

destructor  TTextView.Destroy;
begin
  BTextView_Free(CPlusObject);
  inherited;
end;

function  TTextView.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BTextView_Instantiate(CPlusObject, data.CPlusObject);
end;

function  TTextView.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BTextView_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure  TTextView.AttachedToWindow;
begin
//  BTextView_AttachedToWindow(CPlusObject);
end;

procedure  TTextView.DetachedFromWindow;
begin
//  BTextView_DetachedFromWindow(CPlusObject);
end;

procedure  TTextView.Draw(inRect : TRect);
begin
 // BTextView_Draw(CPlusObject, inRect.CPlusObject);
end;

procedure  TTextView.MouseDown(where : TPoint);
begin
//  BTextView_MouseDown(CPlusObject, where.CPlusObject);
end;

procedure  TTextView.MouseUp(where : TPoint);
begin
  //BTextView_MouseUp(CPlusObject, where.CPlusObject);
end;

procedure  TTextView.MouseMoved(where : TPoint; code : Cardinal; message : TMessage);
begin
  //BTextView_MouseMoved(CPlusObject, where.CPlusObject, code, message);
end;

procedure  TTextView.WindowActivated(state : boolean);
begin
  //BTextView_WindowActivated(CPlusObject, state);
end;

procedure  TTextView.KeyDown(bytes : PChar; numBytes : integer);
begin
  writeln(self.countlines);
  //BTextView_KeyDown(CPlusObject, bytes, numBytes);
end;

procedure  TTextView.Pulse;
begin
  //BTextView_Pulse(CPlusObject);
end;

procedure  TTextView.FrameResized(width : double; height : double);
begin
 // BTextView_FrameResized(CPlusObject, width, height);
end;

procedure  TTextView.MakeFocus(focusState : boolean);
begin
  BTextView_MakeFocus(CPlusObject, focusState);
end;

procedure  TTextView.MessageReceived(message : TMessage);
begin
//  BTextView_MessageReceived(CPlusObject, message.CPlusObject);
end;

function  TTextView.ResolveSpecifier(message : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  //Result := BTextView_ResolveSpecifier(CPlusObject, message.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

function  TTextView.GetSupportedSuites(data : TMessage) : TStatus_t;
begin
  Result := BTextView_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

function  TTextView.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BTextView_Perform(CPlusObject, d, arg);
end;

{procedure  TTextView.SetText(inText : PChar; inRuns :  Ttext_tun_array);
begin
  BTextView_SetText(CPlusObject, inText, inRuns);
end;

procedure  TTextView.SetText(inText : PChar; inLength : integer; inRuns :  Ttext_tun_array);
begin
  BTextView_SetText(CPlusObject, inText, inLength, inRuns);
end;

procedure  TTextView.SetText(inFile : TFile; startOffset : integer; inLength : integer; inRuns :  Ttext_tun_array);
begin
  BTextView_SetText(CPlusObject, inFile.CPlusObject, startOffset, inLength, inRuns);
end;

procedure  TTextView.Insert(inText : PChar; inRuns :  Ttext_tun_array);
begin
  BTextView_Insert(CPlusObject, inText, inRuns);
end;

procedure  TTextView.Insert(inText : PChar; inLength : integer; inRuns :  Ttext_tun_array);
begin
  BTextView_Insert(CPlusObject, inText, inLength, inRuns);
end;

procedure  TTextView.Insert(startOffset : integer; inText : PChar; inLength : integer; inRuns :  Ttext_tun_array);
begin
  BTextView_Insert(CPlusObject, startOffset, inText, inLength, inRuns);
end;
}
procedure  TTextView.Delete;
begin
  BTextView_Delete(CPlusObject);
end;

procedure  TTextView.Delete(startOffset : integer; endOffset : integer);
begin
  BTextView_Delete(CPlusObject, startOffset, endOffset);
end;

function  TTextView.Text : PChar;
begin
  Result := BTextView_Text(CPlusObject);
end;

function  TTextView.TextLength : integer;
begin
  Result := BTextView_TextLength(CPlusObject);
end;

procedure  TTextView.GetText(offset : integer; length : integer; buffer : PChar);
begin
  BTextView_GetText(CPlusObject, offset, length, buffer);
end;

function  TTextView.ByteAt(offset : integer) :  PChar;
begin
  Result := BTextView_ByteAt(CPlusObject, offset);
end;

function  TTextView.CountLines : integer;
begin
  Result := BTextView_CountLines(CPlusObject);
end;

function  TTextView.CurrentLine : integer;
begin
  Result := BTextView_CurrentLine(CPlusObject);
end;

procedure  TTextView.GoToLine(lineNum : integer);
begin
  BTextView_GoToLine(CPlusObject, lineNum);
end;

{procedure  TTextView.Cut(clipboard : TClipboard);
begin
  BTextView_Cut(CPlusObject, clipboard.CPlusObject);
end;

procedure  TTextView.Copy(clipboard : TClipboard);
begin
  BTextView_Copy(CPlusObject, clipboard.CPlusObject);
end;

procedure  TTextView.Paste(clipboard : TClipboard);
begin
  BTextView_Paste(CPlusObject, clipboard.CPlusObject);
end;

procedure  TTextView.Clear;
begin
  BTextView_Clear(CPlusObject);
end;

function  TTextView.AcceptsPaste(clipboard : TClipboard) : boolean;
begin
  Result := BTextView_AcceptsPaste(CPlusObject, clipboard.CPlusObject);
end;
}
function  TTextView.AcceptsDrop(inMessage : TMessage) : boolean;
begin
  Result := BTextView_AcceptsDrop(CPlusObject, inMessage);
end;

procedure  TTextView.Select(startOffset : integer; endOffset : integer);
begin
  BTextView_Select(CPlusObject, startOffset, endOffset);
end;

procedure  TTextView.SelectAll;
begin
  BTextView_SelectAll(CPlusObject);
end;

{procedure  TTextView.GetSelection(outStart : integer; outEnd : integer);
begin
  BTextView_GetSelection(CPlusObject, outStart, outEnd);
end;

procedure  TTextView.SetFontAndColor(inFont :  TFont; inMode : Cardinal; inColor :  Trgb_color);
begin
  BTextView_SetFontAndColor(CPlusObject, inFont, inMode, inColor);
end;

procedure  TTextView.SetFontAndColor(startOffset : integer; endOffset : integer; inFont :  TFont; inMode : Cardinal; inColor :  Trgb_color);
begin
  BTextView_SetFontAndColor(CPlusObject, startOffset, endOffset, inFont, inMode, inColor);
end;

procedure  TTextView.GetFontAndColor(inOffset : integer; outFont :  TFont; outColor : Trgb_color);
begin
  BTextView_GetFontAndColor(CPlusObject, inOffset, outFont.CPlusObject, outColor);
end;

procedure  TTextView.GetFontAndColor(outFont :  TFont; outMode :  integer; outColor : Trgb_color; outEqColor : boolean);
begin
  BTextView_GetFontAndColor(CPlusObject, outFont.CPlusObject, outMode, outColor, outEqColor);
end;

procedure  TTextView.SetRunArray(startOffset : integer; endOffset : integer; inRuns :  Ttext_tun_array);
begin
  BTextView_SetRunArray(CPlusObject, startOffset, endOffset, inRuns);
end;

function  TTextView.RunArray(startOffset : integer; endOffset : integer; outSize : ^integer) : Ttext_run_array;
begin
  Result := BTextView_RunArray(CPlusObject, startOffset, endOffset, outSize);
end;
}
function  TTextView.LineAt(offset : integer) : integer;
begin
  Result := BTextView_LineAt(CPlusObject, offset);
end;

function  TTextView.LineAt(point : TPoint) : integer;
begin
  Result := BTextView_LineAt(CPlusObject, point.CPlusObject);
end;

function  TTextView.PointAt(inOffset : integer; outHeight : double) : TPoint;
begin
  Result := BTextView_PointAt(CPlusObject, inOffset, outHeight);
end;

function  TTextView.OffsetAt(point : TPoint) : integer;
begin
  Result := BTextView_OffsetAt(CPlusObject, point.CPlusObject);
end;

function  TTextView.OffsetAt(line : integer) : integer;
begin
  Result := BTextView_OffsetAt(CPlusObject, line);
end;

procedure  TTextView.FindWord(inOffset : integer; outFromOffset : integer; outToOffset : integer);
begin
  BTextView_FindWord(CPlusObject, inOffset, outFromOffset, outToOffset);
end;

function  TTextView.CanEndLine(offset : integer) : boolean;
begin
  Result := BTextView_CanEndLine(CPlusObject, offset);
end;

function  TTextView.LineWidth(lineNum : integer) : double;
begin
  Result := BTextView_LineWidth(CPlusObject, lineNum);
end;

function  TTextView.LineHeight(lineNum : integer) : double;
begin
  Result := BTextView_LineHeight(CPlusObject, lineNum);
end;

function  TTextView.TextHeight(startLine : integer; endLine : integer) : double;
begin
  Result := BTextView_TextHeight(CPlusObject, startLine, endLine);
end;

{procedure  TTextView.GetTextRegion(startOffset : integer; endOffset : integer; outRegion :  TRegion);
begin
  BTextView_GetTextRegion(CPlusObject, startOffset, endOffset, outRegion.CPlusObject);
end;
}
procedure  TTextView.ScrollToOffset(inOffset : integer);
begin
  BTextView_ScrollToOffset(CPlusObject, inOffset);
end;

procedure  TTextView.ScrollToSelection;
begin
  BTextView_ScrollToSelection(CPlusObject);
end;

procedure  TTextView.Highlight(startOffset : integer; endOffset : integer);
begin
  BTextView_Highlight(CPlusObject, startOffset, endOffset);
end;

procedure  TTextView.SetTextRect(rect : TRect);
begin
  BTextView_SetTextRect(CPlusObject, rect.CPlusObject);
end;

function  TTextView.TextRect : TRect;
begin
  Result := BTextView_TextRect(CPlusObject);
end;

procedure  TTextView.SetStylable(stylable : boolean);
begin
  BTextView_SetStylable(CPlusObject, stylable);
end;

function  TTextView.IsStylable : boolean;
begin
  Result := BTextView_IsStylable(CPlusObject);
end;

procedure  TTextView.SetTabWidth(width : double);
begin
  BTextView_SetTabWidth(CPlusObject, width);
end;

function  TTextView.TabWidth : double;
begin
  Result := BTextView_TabWidth(CPlusObject);
end;

procedure  TTextView.MakeSelectable(selectable : boolean);
begin
  BTextView_MakeSelectable(CPlusObject, selectable);
end;

function  TTextView.IsSelectable : boolean;
begin
  Result := BTextView_IsSelectable(CPlusObject);
end;

procedure  TTextView.MakeEditable(editable : boolean);
begin
  BTextView_MakeEditable(CPlusObject, editable);
end;

function  TTextView.IsEditable : boolean;
begin
  Result := BTextView_IsEditable(CPlusObject);
end;

procedure  TTextView.SetWordWrap(awrap : boolean);
begin
  BTextView_SetWordWrap(CPlusObject, awrap);
end;

function  TTextView.DoesWordWrap : boolean;
begin
  Result := BTextView_DoesWordWrap(CPlusObject);
end;

procedure  TTextView.SetMaxBytes(max : integer);
begin
  BTextView_SetMaxBytes(CPlusObject, max);
end;

function  TTextView.MaxBytes : integer;
begin
  Result := BTextView_MaxBytes(CPlusObject);
end;

procedure  TTextView.DisallowChar(aChar : Cardinal);
begin
  BTextView_DisallowChar(CPlusObject, aChar);
end;

procedure  TTextView.AllowChar(aChar : Cardinal);
begin
  BTextView_AllowChar(CPlusObject, aChar);
end;

procedure  TTextView.SetAlignment(flag : Talignment);
begin
  BTextView_SetAlignment(CPlusObject, flag);
end;

function  TTextView.Alignment : Talignment;
begin
  Result := BTextView_Alignment(CPlusObject);
end;

procedure  TTextView.SetAutoindent(state : boolean);
begin
  BTextView_SetAutoindent(CPlusObject, state);
end;

function  TTextView.DoesAutoindent : boolean;
begin
  Result := BTextView_DoesAutoindent(CPlusObject);
end;

{procedure  TTextView.SetColorSpace(colors : TColor_Space);
begin
  BTextView_SetColorSpace(CPlusObject, colors);
end;

function  TTextView.ColorSpace : TColor_Space;
begin
  Result := BTextView_ColorSpace(CPlusObject);
end;
}
procedure  TTextView.MakeResizable(resize : boolean; resizeView : TView);
begin
  BTextView_MakeResizable(CPlusObject, resize, resizeView.CPlusObject);
end;

function  TTextView.IsResizable : boolean;
begin
  Result := BTextView_IsResizable(CPlusObject);
end;

procedure  TTextView.SetDoesUndo(undo : boolean);
begin
  BTextView_SetDoesUndo(CPlusObject, undo);
end;

function  TTextView.DoesUndo : boolean;
begin
  Result := BTextView_DoesUndo(CPlusObject);
end;

procedure  TTextView.HideTyping(enabled : boolean);
begin
  BTextView_HideTyping(CPlusObject, enabled);
end;

function  TTextView.IsTypingHidden : boolean;
begin
  Result := BTextView_IsTypingHidden(CPlusObject);
end;

procedure  TTextView.ResizeToPreferred;
begin
  BTextView_ResizeToPreferred(CPlusObject);
end;

procedure  TTextView.GetPreferredSize(width : double; height : double);
begin
  BTextView_GetPreferredSize(CPlusObject, width, height);
end;

procedure  TTextView.AllAttached;
begin
  BTextView_AllAttached(CPlusObject);
end;

procedure  TTextView.AllDetached;
begin
  BTextView_AllDetached(CPlusObject);
end;

{function  TTextView.FlattenRunArray(inArray :  Ttext_tun_array; outSize : integer) : Pointer;
begin
  Result := BTextView_FlattenRunArray(CPlusObject, inArray, outSize);
end;


function  TTextView.UnflattenRunArray(data : Pointer; outSize : integer) : Ttext_run_array;
begin
  Result := BTextView_UnflattenRunArray(CPlusObject, data, outSize);
end;

procedure  TTextView.InsertText(inText : PChar; inLength : integer; inOffset : integer; inRuns :  Ttext_tun_array);
begin
  BTextView_InsertText(CPlusObject, inText, inLength, inOffset, inRuns);
end;
}

{procedure  TTextView.Undo(clipboard : TClipboard);
begin
  BTextView_Undo(CPlusObject, clipboard.CPlusObject);
end;

function  TTextView.UndoState(isRedo : boolean) :  Tundo_state;
begin
  Result := BTextView_UndoState(CPlusObject, isRedo);
end;

procedure  TTextView.GetDragParameters(drag : TMessage; bitmap : TBitmap; point : TPoint; handler : THandler);
begin
  BTextView_GetDragParameters(CPlusObject, drag.CPlusObject, bitmap.CPlusObject, point.CPlusObject, handler.CPlusObject);
end;
}


end.
