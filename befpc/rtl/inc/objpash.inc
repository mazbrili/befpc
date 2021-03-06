{
    $Id: objpash.inc,v 1.1.1.1 2001-07-23 17:17:37 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    This unit makes Free Pascal as much as possible Delphi compatible

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{*****************************************************************************
                            Basic Types/constants
*****************************************************************************}

    const
{$ifdef NEWVMTOFFSET}
       vmtInstanceSize         = 0;
       vmtParent               = 8;
       { These were negative value's, but are now positive, else classes
         couldn't be used with shared linking which copies only all data from
         the .global directive and not the data before the directive (PFV) }
       vmtClassName            = 12;
       vmtDynamicTable         = 16;
       vmtMethodTable          = 20;
       vmtFieldTable           = 24;
       vmtTypeInfo             = 28;
       vmtInitTable            = 32;
       vmtAutoTable            = 36;
       vmtIntfTable            = 40;
       vmtMsgStrPtr            = 44;
       { methods }
       vmtMethodStart          = 48;
       vmtDestroy              = vmtMethodStart;
       vmtNewInstance          = vmtMethodStart+4;
       vmtFreeInstance         = vmtMethodStart+8;
       vmtSafeCallException    = vmtMethodStart+12;
       vmtDefaultHandler       = vmtMethodStart+16;
       vmtAfterConstruction    = vmtMethodStart+20;
       vmtBeforeDestruction    = vmtMethodStart+24;
       vmtDefaultHandlerStr    = vmtMethodStart+28;
{$else}
       vmtMsgStrPtr            = -36;
       vmtIntfTable            = -32;
       vmtAutoTable            = -28;
       vmtInitTable            = -24;
       vmtTypeInfo             = -20;
       vmtFieldTable           = -16;
       vmtMethodTable          = -12;
       vmtDynamicTable         = -8;
       vmtClassName            = -4;
       vmtInstanceSize         = 0;
       vmtParent               = 8;
       vmtDestroy              = 12;
       vmtNewInstance          = 16;
       vmtFreeInstance         = 20;
       vmtSafeCallException    = 24;
       vmtDefaultHandler       = 28;
       vmtAfterConstruction    = 32;
       vmtBeforeDestruction    = 36;
       vmtDefaultHandlerStr    = 40;
{$endif}

    type
       { some pointer definitions }
       pshortstring = ^shortstring;
       plongstring  = ^longstring;
       pansistring  = ^ansistring;
       pwidestring  = ^widestring;
       // pstring   = pansistring;
       pextended    = ^extended;
       ppointer     = ^pointer;

       { now the let's declare the base classes for the class object }
       { model                                                       }
       tobject = class;
       tclass  = class of tobject;
       pclass  = ^tclass;


       { to access the message table from outside }
       tmsgstrtable = record
          name : pshortstring;
          method : pointer;
       end;

       pmsgstrtable = ^tmsgstrtable;

       tstringmessagetable = record
          count : dword;
          msgstrtable : array[0..0] of tmsgstrtable;
       end;

       pstringmessagetable = ^tstringmessagetable;

       tobject = class
       public
          { please don't change the order of virtual methods, because      }
          { their vmt offsets are used by some assembler code which uses   }
          { hard coded addresses      (FK)                                 }
          constructor create;
          { the virtual procedures must be in THAT order }
          destructor destroy;virtual;
          class function newinstance : tobject;virtual;
          procedure freeinstance;virtual;
          function safecallexception(exceptobject : tobject;
            exceptaddr : pointer) : longint;virtual;
          procedure defaulthandler(var message);virtual;

          procedure free;
          class function initinstance(instance : pointer) : tobject;
          procedure cleanupinstance;
          function classtype : tclass;
          class function classinfo : pointer;
          class function classname : shortstring;
          class function classnameis(const name : string) : boolean;
          class function classparent : tclass;
          class function instancesize : longint;
          class function inheritsfrom(aclass : tclass) : boolean;
          class function stringmessagetable : pstringmessagetable;
          { message handling routines }
          procedure dispatch(var message);
          procedure dispatchstr(var message);

          class function methodaddress(const name : shortstring) : pointer;
          class function methodname(address : pointer) : shortstring;
          function fieldaddress(const name : shortstring) : pointer;

          { new since Delphi 4 }
          procedure AfterConstruction;virtual;
          procedure BeforeDestruction;virtual;

          { new for gtk, default handler for text based messages }
          procedure DefaultHandlerStr(var message);virtual;

          { interface functions, I don't know if we need this }
          {
          function getinterface(const iid : tguid;out obj) : boolean;
          class function getinterfaceentry(const iid : tguid) : pinterfaceentry;
          class function getinterfacetable : pinterfacetable;
          }
       end;

       TExceptProc = Procedure (Obj : TObject; Addr,Frame: Pointer);

       { Exception object stack }
       PExceptObject = ^TExceptObject;
       TExceptObject = record
         FObject : TObject;
         Addr,
         Frame   : pointer;
         Next    : PExceptObject;
       end;

       Const
          ExceptProc : TExceptProc = Nil;

       Function RaiseList : PExceptObject;


{*****************************************************************************
                              Variant Type
*****************************************************************************}

    Const
       varEmpty     = $0000;
       varNull      = $0001;
       varSmallint  = $0002;
       varInteger   = $0003;
       varSingle    = $0004;
       varDouble    = $0005;
       varCurrency  = $0006;
       varDate      = $0007;
       varOleStr    = $0008;
       varDispatch  = $0009;
       varError     = $000A;
       varBoolean   = $000B;
       varVariant   = $000C;
       varUnknown   = $000D;
       varByte      = $0011;
       varString    = $0100;
       varAny       = $0101;
       varTypeMask  = $0FFF;
       varArray     = $2000;
       varByRef     = $4000;

       vtInteger    = 0;
       vtBoolean    = 1;
       vtChar       = 2;
       vtExtended   = 3;
       vtString     = 4;
       vtPointer    = 5;
       vtPChar      = 6;
       vtObject     = 7;
       vtClass      = 8;
       vtWideChar   = 9;
       vtPWideChar  = 10;
       vtAnsiString = 11;
       vtCurrency   = 12;
       vtVariant    = 13;
       vtInterface  = 14;
       vtWideString = 15;
       vtInt64      = 16;
       vtQWord      = 17;

    Type
       PVarRec = ^TVarRec;
       TVarRec = record
         case VType : Longint of
           vtInteger    : (VInteger: Longint);
           vtBoolean    : (VBoolean: Boolean);
           vtChar       : (VChar: Char);
           vtExtended   : (VExtended: PExtended);
           vtString     : (VString: PShortString);
           vtPointer    : (VPointer: Pointer);
           vtPChar      : (VPChar: PChar);
           vtObject     : (VObject: TObject);
           vtClass      : (VClass: TClass);
//           vtWideChar   : (VWideChar: WideChar);
//           vtPWideChar  : (VPWideChar: PWideChar);
           vtAnsiString : (VAnsiString: Pointer);
//           vtCurrency   : (VCurrency: PCurrency);
//           vtVariant    : (VVariant: PVariant);
//           vtInterface  : (VInterface: Pointer);
           vtWideString : (VWideString: Pointer);
           vtInt64      : (VInt64: PInt64);
           vtQWord      : (VQWord: PQWord);
       end;
{
  $Log: not supported by cvs2svn $
  Revision 1.11  2000/06/22 18:05:56  michael
  + Modifications for exception support in sysutils. Mainly added
     RaiseList function.

  Revision 1.10  2000/05/14 18:47:53  florian
    * TVarRec with Int64/QWord stuff extended

  Revision 1.9  2000/04/24 11:11:50  peter
    * backtraces for exceptions are now only generated from the place of the
      exception
    * frame is also pushed for exceptions
    * raise statement enhanced with [,<frame>]

  Revision 1.8  2000/02/09 16:59:31  peter
    * truncated log

  Revision 1.7  2000/01/07 16:41:36  daniel
    * copyright 2000

  Revision 1.6  2000/01/07 16:32:25  daniel
    * copyright 2000 added

  Revision 1.5  1999/12/02 19:28:53  peter
    * public added to TObject

  Revision 1.4  1999/08/09 22:20:03  peter
    * classes vmt changed to only positive addresses
    * sharedlib creation is working

}