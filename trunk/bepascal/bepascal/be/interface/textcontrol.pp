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
unit textcontrol;

interface

uses
  beobj, Control, Message, Archivable, SupportDefs, Rect, Handler,interfacedefs;

type
  TTextControl = class(TControl)
  private
  public
    destructor Destroy;override;
	constructor Create(frame : TRect; name, aLabel,initial : PChar; message : TMessage; resizingMode, flags : Cardinal); virtual;
    constructor Create(data : TMessage);override;
    function Instantiate(data : TMessage) : TArchivable;
    function Archive(data : TMessage; deep : boolean) : TStatus_t;
    procedure SetText(texte : PChar);
    function Text : PChar;
    procedure SetValue(valu : integer);
    function Invoke(msg : TMessage) : TStatus_t;
    function TextView : TTextControl;
    procedure SetModificationMessage(message : TMessage);
    function ModificationMessage : TMessage;
    procedure SetAlignment(alabel :  TAlignment; texte :  TAlignment);
    procedure GetAlignment(alabel : TAlignment; texte : TAlignment);
    procedure SetDivider(dividing_line : double);
    function Divider : double;
    procedure Draw(updateRect : TRect);override;
    procedure MouseDown(where : TPoint);override;
    procedure AttachedToWindow;override;
    procedure MakeFocus(focusState : boolean);override;
    procedure SetEnabled(state : boolean);
    procedure FrameMoved(new_position : TPoint);override;
    procedure FrameResized(new_width : double; new_height : double);override;
    procedure WindowActivated(active : boolean);override;
    procedure GetPreferredSize(width : double; height : double);
    procedure ResizeToPreferred;override;
    procedure MessageReceived(msg : TMessage);override;
    function ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
    procedure MouseUp(pt : TPoint);override;
    procedure MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);override;
    procedure DetachedFromWindow;override;
    procedure AllAttached;override;
    procedure AllDetached;override;
    function GetSupportedSuites(data : TMessage) : TStatus_t;
    procedure SetFlags(flags : Cardinal);
    function Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
  {  procedure _ReservedTextControl1;
    procedure _ReservedTextControl2;
    procedure _ReservedTextControl3;
    procedure _ReservedTextControl4;
    function operator=( : TTextControl) : TTextControl;
    procedure CommitValue;
    procedure InitData(label : PChar; initial_text : PChar; data : TMessage);
    procedure _BTextInput_ *fText;
    procedure char *fLabel;
    procedure BMessage *fModificationMessage;
    procedure alignment fLabelAlign;
    procedure float fDivider;
    procedure uint16 fPrevWidth;
    procedure uint16 fPrevHeight;
    procedure uint32 _reserved[3];
    procedure uint32 _more_reserved[4];
    procedure bool fClean;
    procedure bool fSkipSetFlags;
    procedure bool fUnusedBool1;
    procedure bool fUnusedBool2;
  }
  end;

procedure BTextControl_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_Free';
function BTextControl_Create(AObject : TBeObject; frame : TCPlusObject; name, aLabel ,initial: PChar; message : TCPlusObject; resizingMode, flags : Cardinal): TCPlusObject; cdecl; external BePascalLibName name 'BTextControl_Create';
function BTextControl_Create(AObject : TBeObject; data : TCPlusObject): TCPlusObject; cdecl; external BePascalLibName name 'BTextControl_Create_1';
function BTextControl_Instantiate(AObject : TCPlusObject; data : TCPlusObject) : TArchivable; cdecl; external BePascalLibName name 'BTextControl_Instantiate';
function BTextControl_Archive(AObject : TCPlusObject; data : TCPlusObject; deep : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BTextControl_Archive';
procedure BTextControl_SetText(AObject : TCPlusObject; text : PChar); cdecl; external BePascalLibName name 'BTextControl_SetText';
function BTextControl_Text(AObject : TCPlusObject) : PChar; cdecl; external BePascalLibName name 'BTextControl_Text';
procedure BTextControl_SetValue(AObject : TCPlusObject; value : integer); cdecl; external BePascalLibName name 'BTextControl_SetValue';
function BTextControl_Invoke(AObject : TCPlusObject; msg : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BTextControl_Invoke';
function BTextControl_TextView(AObject : TCPlusObject) : TTextControl; cdecl; external BePascalLibName name 'BTextControl_TextView';
procedure BTextControl_SetModificationMessage(AObject : TCPlusObject; message : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_SetModificationMessage';
function BTextControl_ModificationMessage(AObject : TCPlusObject) : TMessage; cdecl; external BePascalLibName name 'BTextControl_ModificationMessage';
procedure BTextControl_SetAlignment(AObject : TCPlusObject; alabel :  TAlignment; texte :  TAlignment); cdecl; external BePascalLibName name 'BTextControl_SetAlignment';
procedure BTextControl_GetAlignment(AObject : TCPlusObject; alabel : TAlignment; texte : TAlignment); cdecl; external BePascalLibName name 'BTextControl_GetAlignment';
procedure BTextControl_SetDivider(AObject : TCPlusObject; dividing_line : double); cdecl; external BePascalLibName name 'BTextControl_SetDivider';
function BTextControl_Divider(AObject : TCPlusObject) : double; cdecl; external BePascalLibName name 'BTextControl_Divider';
procedure BTextControl_Draw(AObject : TCPlusObject; updateRect : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_Draw';
procedure BTextControl_MouseDown(AObject : TCPlusObject; where : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_MouseDown';
procedure BTextControl_AttachedToWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_AttachedToWindow';
procedure BTextControl_MakeFocus(AObject : TCPlusObject; focusState : boolean); cdecl; external BePascalLibName name 'BTextControl_MakeFocus';
procedure BTextControl_SetEnabled(AObject : TCPlusObject; state : boolean); cdecl; external BePascalLibName name 'BTextControl_SetEnabled';
procedure BTextControl_FrameMoved(AObject : TCPlusObject; new_position : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_FrameMoved';
procedure BTextControl_FrameResized(AObject : TCPlusObject; new_width : double; new_height : double); cdecl; external BePascalLibName name 'BTextControl_FrameResized';
procedure BTextControl_WindowActivated(AObject : TCPlusObject; active : boolean); cdecl; external BePascalLibName name 'BTextControl_WindowActivated';
procedure BTextControl_GetPreferredSize(AObject : TCPlusObject; width : double; height : double); cdecl; external BePascalLibName name 'BTextControl_GetPreferredSize';
procedure BTextControl_ResizeToPreferred(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_ResizeToPreferred';
procedure BTextControl_MessageReceived(AObject : TCPlusObject; msg : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_MessageReceived';
function BTextControl_ResolveSpecifier(AObject : TCPlusObject; msg : TCPlusObject; index : integer; specifier : TCPlusObject; form : integer; properti : PChar) : THandler; cdecl; external BePascalLibName name 'BTextControl_ResolveSpecifier';
procedure BTextControl_MouseUp(AObject : TCPlusObject; pt : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_MouseUp';
procedure BTextControl_MouseMoved(AObject : TCPlusObject; pt : TCPlusObject; code : Cardinal; msg : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_MouseMoved';
procedure BTextControl_DetachedFromWindow(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_DetachedFromWindow';
procedure BTextControl_AllAttached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_AllAttached';
procedure BTextControl_AllDetached(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_AllDetached';
function BTextControl_GetSupportedSuites(AObject : TCPlusObject; data : TCPlusObject) : TStatus_t; cdecl; external BePascalLibName name 'BTextControl_GetSupportedSuites';
procedure BTextControl_SetFlags(AObject : TCPlusObject; flags : Cardinal); cdecl; external BePascalLibName name 'BTextControl_SetFlags';
function BTextControl_Perform(AObject : TCPlusObject; d : TPerform_code; arg : Pointer) : TStatus_t; cdecl; external BePascalLibName name 'BTextControl_Perform';



{procedure BTextControl__ReservedTextControl1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl__ReservedTextControl1';
procedure BTextControl__ReservedTextControl2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl__ReservedTextControl2';
procedure BTextControl__ReservedTextControl3(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl__ReservedTextControl3';
procedure BTextControl__ReservedTextControl4(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl__ReservedTextControl4';
function BTextControl_operator=(AObject : TCPlusObject;  : TTextControl) : TTextControl; cdecl; external BePascalLibName name 'BTextControl_operator=';
procedure BTextControl_CommitValue(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_CommitValue';
procedure BTextControl_InitData(AObject : TCPlusObject; label : PChar; initial_text : PChar; data : TMessage); cdecl; external BePascalLibName name 'BTextControl_InitData';
procedure BTextControl__BTextInput_ *fText(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl__BTextInput_ *fText';
procedure BTextControl_char *fLabel(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_char *fLabel';
procedure BTextControl_BMessage *fModificationMessage(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_BMessage *fModificationMessage';
procedure BTextControl_alignment fLabelAlign(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_alignment fLabelAlign';
procedure BTextControl_float fDivider(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_float fDivider';
procedure BTextControl_uint16 fPrevWidth(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_uint16 fPrevWidth';
procedure BTextControl_uint16 fPrevHeight(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_uint16 fPrevHeight';
procedure BTextControl_uint32 _reserved[3](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_uint32 _reserved[3]';
procedure BTextControl_uint32 _more_reserved[4](AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_uint32 _more_reserved[4]';
procedure BTextControl_bool fClean(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_bool fClean';
procedure BTextControl_bool fSkipSetFlags(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_bool fSkipSetFlags';
procedure BTextControl_bool fUnusedBool1(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_bool fUnusedBool1';
procedure BTextControl_bool fUnusedBool2(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BTextControl_bool fUnusedBool2';
}
implementation

destructor TTextControl.Destroy;
begin
  BTextControl_Free(CPlusObject);
  inherited;
end;

constructor TTextControl.Create(frame : TRect; name, aLabel,initial : PChar; message : TMessage; resizingMode, flags : Cardinal);
begin
  CreatePas;
  CPlusObject := BTextControl_Create(Self, frame.CPlusObject, name, aLabel,initial, message.CPlusObject, resizingMode, flags);
end;


constructor TTextControl.Create(data : TMessage);
begin
  CreatePas;
  CPlusObject := BTextControl_Create(Self, data.CPlusObject);
end;

function TTextControl.Instantiate(data : TMessage) : TArchivable;
begin
  Result := BTextControl_Instantiate(CPlusObject, data.CPlusObject);
end;

function TTextControl.Archive(data : TMessage; deep : boolean) : TStatus_t;
begin
  Result := BTextControl_Archive(CPlusObject, data.CPlusObject, deep);
end;

procedure TTextControl.SetText(texte : PChar);
begin
  BTextControl_SetText(CPlusObject, texte);
end;

function TTextControl.Text : PChar;
begin
  Result := BTextControl_Text(CPlusObject);
end;

procedure TTextControl.SetValue(valu : integer);
begin
  BTextControl_SetValue(CPlusObject, valu);
end;

function TTextControl.Invoke(msg : TMessage) : TStatus_t;
begin
  Result := BTextControl_Invoke(CPlusObject, msg.CPlusObject);
end;

function TTextControl.TextView : TTextControl;
begin
  Result := BTextControl_TextView(CPlusObject);
end;

procedure TTextControl.SetModificationMessage(message : TMessage);
begin
  BTextControl_SetModificationMessage(CPlusObject, message.CPlusObject);
end;

function TTextControl.ModificationMessage : TMessage;
begin
  Result := BTextControl_ModificationMessage(CPlusObject);
end;

procedure TTextControl.SetAlignment(alabel :  TAlignment; texte :  TAlignment);
begin
  BTextControl_SetAlignment(CPlusObject, alabel, texte);
end;

procedure TTextControl.GetAlignment(alabel : TAlignment; texte : TAlignment);
begin
  BTextControl_GetAlignment(CPlusObject, alabel, texte);
end;

procedure TTextControl.SetDivider(dividing_line : double);
begin
  BTextControl_SetDivider(CPlusObject, dividing_line);
end;

function TTextControl.Divider : double;
begin
  Result := BTextControl_Divider(CPlusObject);
end;

procedure TTextControl.Draw(updateRect : TRect);
begin
end;

procedure TTextControl.MouseDown(where : TPoint);
begin
end;

procedure TTextControl.AttachedToWindow;
begin
end;

procedure TTextControl.MakeFocus(focusState : boolean);
begin
  BTextControl_MakeFocus(CPlusObject, focusState);
end;

procedure TTextControl.SetEnabled(state : boolean);
begin
  BTextControl_SetEnabled(CPlusObject, state);
end;

procedure TTextControl.FrameMoved(new_position : TPoint);
begin
end;

procedure TTextControl.FrameResized(new_width : double; new_height : double);
begin
//  BTextControl_FrameResized(CPlusObject, new_width, new_height);
end;

procedure TTextControl.WindowActivated(active : boolean);
begin
  //BTextControl_WindowActivated(CPlusObject, active);
end;

procedure TTextControl.GetPreferredSize(width : double; height : double);
begin
  //BTextControl_GetPreferredSize(CPlusObject, width, height);
end;

procedure TTextControl.ResizeToPreferred;
begin
  //BTextControl_ResizeToPreferred(CPlusObject);
end;

procedure TTextControl.MessageReceived(msg : TMessage);
begin
  //BTextControl_MessageReceived(CPlusObject, msg.CPlusObject);
end;

function TTextControl.ResolveSpecifier(msg : TMessage; index : integer; specifier : TMessage; form : integer; properti : PChar) : THandler;
begin
  Result := BTextControl_ResolveSpecifier(CPlusObject, msg.CPlusObject, index, specifier.CPlusObject, form, properti);
end;

procedure TTextControl.MouseUp(pt : TPoint);
begin
  //BTextControl_MouseUp(CPlusObject, pt.CPlusObject);
end;

procedure TTextControl.MouseMoved(pt : TPoint; code : Cardinal; msg : TMessage);
begin
  //BTextControl_MouseMoved(CPlusObject, pt.CPlusObject, code, msg);
end;

procedure TTextControl.DetachedFromWindow;
begin
  //BTextControl_DetachedFromWindow(CPlusObject);
end;

procedure TTextControl.AllAttached;
begin
  //BTextControl_AllAttached(CPlusObject);
end;

procedure TTextControl.AllDetached;
begin
  //BTextControl_AllDetached(CPlusObject);
end;

function TTextControl.GetSupportedSuites(data : TMessage) : TStatus_t;
begin

  Result := BTextControl_GetSupportedSuites(CPlusObject, data.CPlusObject);
end;

procedure TTextControl.SetFlags(flags : Cardinal);
begin
  BTextControl_SetFlags(CPlusObject, flags);
end;

function TTextControl.Perform(d : TPerform_code; arg : Pointer) : TStatus_t;
begin
  Result := BTextControl_Perform(CPlusObject, d, arg);
end;

{procedure TTextControl._ReservedTextControl1;
begin
  BTextControl__ReservedTextControl1(CPlusObject);
end;

procedure TTextControl._ReservedTextControl2;
begin
  BTextControl__ReservedTextControl2(CPlusObject);
end;

procedure TTextControl._ReservedTextControl3;
begin
  BTextControl__ReservedTextControl3(CPlusObject);
end;

procedure TTextControl._ReservedTextControl4;
begin
  BTextControl__ReservedTextControl4(CPlusObject);
end;

function TTextControl.operator=( : TTextControl) : TTextControl;
begin
  Result := BTextControl_operator=(CPlusObject, );
end;

procedure TTextControl.CommitValue;
begin
  BTextControl_CommitValue(CPlusObject);
end;

procedure TTextControl.InitData(label : PChar; initial_text : PChar; data : TMessage);
begin
  BTextControl_InitData(CPlusObject, label, initial_text, data.CPlusObject);
end;

procedure TTextControl._BTextInput_ *fText;
begin
  BTextControl__BTextInput_ *fText(CPlusObject);
end;

procedure TTextControl.char *fLabel;
begin
  BTextControl_char *fLabel(CPlusObject);
end;

procedure TTextControl.BMessage *fModificationMessage;
begin
  BTextControl_BMessage *fModificationMessage(CPlusObject);
end;

procedure TTextControl.alignment fLabelAlign;
begin
  BTextControl_alignment fLabelAlign(CPlusObject);
end;

procedure TTextControl.float fDivider;
begin
  BTextControl_float fDivider(CPlusObject);
end;

procedure TTextControl.uint16 fPrevWidth;
begin
  BTextControl_uint16 fPrevWidth(CPlusObject);
end;

procedure TTextControl.uint16 fPrevHeight;
begin
  BTextControl_uint16 fPrevHeight(CPlusObject);
end;

procedure TTextControl.uint32 _reserved[3];
begin
  BTextControl_uint32 _reserved[3](CPlusObject);
end;

procedure TTextControl.uint32 _more_reserved[4];
begin
  BTextControl_uint32 _more_reserved[4](CPlusObject);
end;

procedure TTextControl.bool fClean;
begin
  BTextControl_bool fClean(CPlusObject);
end;

procedure TTextControl.bool fSkipSetFlags;
begin
  BTextControl_bool fSkipSetFlags(CPlusObject);
end;

procedure TTextControl.bool fUnusedBool1;
begin
  BTextControl_bool fUnusedBool1(CPlusObject);
end;

procedure TTextControl.bool fUnusedBool2;
begin
  BTextControl_bool fUnusedBool2(CPlusObject);
end;
}

end.
