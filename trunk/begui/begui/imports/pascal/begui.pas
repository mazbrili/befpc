unit BeGUI;

{

$Header $

$Revision $
  
$Log $

}

interface

type
  MApplicationH = pointer;
  MFormH = pointer;
  MButtonH = pointer;
  MEditH = pointer;
  MPanelH = pointer;
  MMemoH = pointer;

  uint32 = longword;
  int32  = longint;

var
  Application: MApplicationH;

type

   base_Message = procedure (sender:pointer; msg:uint32);cdecl;
   mouseMoved_Message = procedure (sender:pointer; x:double; y:double; code:uint32; msg:uint32);cdecl;
   mouseAction_Message = procedure (sender:pointer; x:double; y:double);cdecl;
   keyAction_Message = procedure (sender:pointer; bytes:Pchar; numBytes:int32);cdecl;
   drawAction_Message = procedure (sender:pointer; left:double; top:double; right:double; bottom:double);cdecl;
  
const
  //Memson 30/03/2002 : changed this for FPC1.06 compatibility
  BEGUILIB = 'begui'; //must be in /boot/home/config/lib and /boot/develop/lib/x86 

{$PACKRECORDS C}


  function MApplication_Create: MApplicationH; cdecl; external BEGUILIB; 

  procedure MApplication_Free(app:MApplicationH); cdecl; external BEGUILIB;

  procedure MApplication_Run(app:MApplicationH); cdecl; external BEGUILIB;

  function MApplication_GetMainForm(app:MApplicationH):MFormH; cdecl; external BEGUILIB;

  function MApplication_AddForm(app:MApplicationH; left:double; top:double; right:double; bottom:double; 
             name:Pchar; caption:Pchar):MFormH; cdecl; external BEGUILIB;

  function MApplication_AddForm_int32(app:MApplicationH; left:int32; top:int32; right:int32; bottom:int32; 
             name:Pchar; caption:Pchar):MFormH; cdecl; external BEGUILIB;

  {added to get round fpc's inability to pass 'float' params...}

  function MButton_Create_int32(left:int32; top:int32; right:int32; bottom:int32; caption:Pchar):MButtonH; external BEGUILIB;

  function MForm_AddMEdit_int32(form:MFormH; left:int32; top:int32; right:int32; bottom:int32;  caption:Pchar):MEditH; external BEGUILIB;

  function MForm_AddMMemo_int32(form:MFormH; left:int32; top:int32; right:int32; bottom:int32;  caption:Pchar):MMemoH; cdecl; external BEGUILIB;

  function MForm_AddMPanel_int32(frm:MFormH; left:int32; top:int32; right:int32; bottom:int32;  name:Pchar):MPanelH;cdecl; external BEGUILIB;

  {form }
  procedure MForm_AddChild(form:MFormH; ctrl:pointer); cdecl; external BEGUILIB;

  procedure MForm_AttachMouseMovedDispatcher(form:MFormH; msg:mouseMoved_Message);cdecl; external BEGUILIB;

  procedure MForm_AttachMouseDownDispatcher(form:MFormH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MForm_AttachMouseUpDispatcher(form:MFormH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MForm_AttachKeyDownDispatcher(form:MFormH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MForm_AttachKeyUpDispatcher(form:MFormH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MForm_AttachDrawDispatcher(form:MFormH; msg:drawAction_Message);cdecl; external BEGUILIB;

  procedure MForm_Show(frm:MFormH);cdecl; external BEGUILIB;

  procedure MForm_Hide(frm:MFormH);cdecl; external BEGUILIB;

  {button }
  function MButton_Create(left:double; top:double; right:double; bottom:double; caption:Pchar):MButtonH;cdecl; external BEGUILIB;

  procedure MButton_AttachClickDispatcher(btn:MButtonH; msg:base_Message);cdecl; external BEGUILIB;

  function MButton_getCaption(btn:MButtonH):pchar;cdecl; external BEGUILIB;

  procedure MButton_setCaption(btn:MButtonH; caption:Pchar);cdecl; external BEGUILIB;

  procedure MButton_AttachMouseMovedDispatcher(btn:MButtonH; msg:mouseMoved_Message);cdecl; external BEGUILIB;

  procedure MButton_AttachMouseDownDispatcher(btn:MButtonH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MButton_AttachMouseUpDispatcher(btn:MButtonH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MButton_AttachKeyDownDispatcher(btn:MButtonH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MButton_AttachKeyUpDispatcher(btn:MButtonH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MButton_AttachDrawDispatcher(btn:MButtonH; msg:drawAction_Message);cdecl; external BEGUILIB;

  {edit }
  function MForm_AddMEdit(form:MFormH; left:double; top:double; right:double; bottom:double; 
             caption:Pchar):MEditH;cdecl; external BEGUILIB;

  function MEdit_getText(edt:MEditH):Pchar;cdecl; external BEGUILIB;

  procedure MEdit_setText(edt:MEditH; text:Pchar);cdecl; external BEGUILIB;

  procedure MEdit_AttachClickDispatcher(edt:MEditH; msg:base_Message);cdecl; external BEGUILIB;

  procedure MEdit_AttachMouseMovedDispatcher(edt:MEditH; msg:mouseMoved_Message);cdecl; external BEGUILIB;

  procedure MEdit_AttachMouseDownDispatcher(edt:MEditH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MEdit_AttachMouseUpDispatcher(edt:MEditH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MEdit_AttachKeyDownDispatcher(edt:MEditH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MEdit_AttachKeyUpDispatcher(edt:MEditH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MEdit_AttachDrawDispatcher(edt:MEditH; msg:drawAction_Message);cdecl; external BEGUILIB;

  {memo }
  function MForm_AddMMemo(form:MFormH; left:double; top:double; right:double; bottom:double; 
             caption:Pchar):MMemoH;cdecl; external BEGUILIB;

  procedure MMemo_AttachMouseMovedDispatcher(memo:MMemoH; msg:mouseMoved_Message);cdecl; external BEGUILIB;

  procedure MMemo_AttachMouseDownDispatcher(memo:MMemoH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MMemo_AttachMouseUpDispatcher(memo:MMemoH; msg:mouseAction_Message);cdecl; external BEGUILIB;

  procedure MMemo_AttachKeyDownDispatcher(memo:MMemoH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MMemo_AttachKeyUpDispatcher(memo:MMemoH; msg:keyAction_Message);cdecl; external BEGUILIB;

  procedure MMemo_AttachDrawDispatcher(memo:MMemoH; msg:drawAction_Message);cdecl; external BEGUILIB;

  {panel }
  function MForm_AddMPanel(frm:MFormH; left:double; top:double; right:double; bottom:double; 
             name:Pchar):MPanelH;cdecl; external BEGUILIB;

  {needed?? }
  function GetBaseMessage:uint32;cdecl; external BEGUILIB;

  function GetNextMessage:uint32;cdecl; external BEGUILIB;

(* Const before type ignored *)
  procedure GenericAlert(message:Pchar);cdecl; external BEGUILIB;

  procedure testfloat(f: integer);cdecl; external BEGUILIB;

implementation

initialization
  Application := MApplication_create;
finalization
  MApplication_free(Application);
end.