{
    $Id: pass_2.pas,v 1.1.1.1 2001-07-23 17:16:44 memson Exp $
    Copyright (c) 1998-2000 by Florian Klaempfl

    This unit handles the codegeneration pass

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 ****************************************************************************
}
{$ifdef FPC}
  {$goto on}
{$endif FPC}
{$ifdef TP}
  {$E+,F+,N+}
{$endif}
unit pass_2;
interface

uses
  tree;

{ produces assembler for the expression in variable p }
{ and produces an assembler node at the end        }
procedure generatecode(var p : ptree);

{ produces the actual code }
function do_secondpass(var p : ptree) : boolean;
procedure secondpass(var p : ptree);


implementation

   uses
     globtype,systems,
     cobjects,comphook,verbose,globals,files,
     symconst,symtable,types,aasm,scanner,
     pass_1,hcodegen,temp_gen,cpubase,cpuasm
{$ifndef newcg}
     ,tcflw
{$endif newcg}
{$ifdef GDB}
     ,gdb
{$endif}
{$ifdef i386}
     ,tgeni386,cgai386
     ,cg386con,cg386mat,cg386cnv,cg386set,cg386add
     ,cg386mem,cg386cal,cg386ld,cg386flw,cg386inl
{$endif}
{$ifdef m68k}
     ,tgen68k,cga68k
     ,cg68kcon,cg68kmat,cg68kcnv,cg68kset,cg68kadd
     ,cg68kmem,cg68kcal,cg68kld,cg68kflw,cg68kinl
{$endif}
     ;

{*****************************************************************************
                              SecondPass
*****************************************************************************}

    type
       secondpassproc = procedure(var p : ptree);

    procedure secondnothing(var p : ptree);

      begin
      end;

    procedure seconderror(var p : ptree);

      begin
         p^.error:=true;
         codegenerror:=true;
      end;


    procedure secondstatement(var p : ptree);

      var
         hp : ptree;
      begin
         hp:=p;
         while assigned(hp) do
          begin
            if assigned(hp^.right) then
             begin
               cleartempgen;
               {!!!!!!
               oldrl:=temptoremove;
               temptoremove:=new(plinkedlist,init);
               }
               secondpass(hp^.right);
               { !!!!!!!
                 some temporary data which can't be released elsewhere
               removetemps(exprasmlist,temptoremove);
               dispose(temptoremove,done);
               temptoremove:=oldrl;
               }
             end;
            hp:=hp^.left;
          end;
      end;


    procedure secondblockn(var p : ptree);
      begin
      { do second pass on left node }
        if assigned(p^.left) then
         secondpass(p^.left);
      end;


    procedure secondasm(var p : ptree);

        procedure ReLabel(var p:pasmsymbol);
        begin
          if p^.proclocal then
           begin
             if not assigned(p^.altsymbol) then
              p^.GenerateAltSymbol;
             p:=p^.altsymbol;
           end;
        end;

      var
        hp,hp2 : pai;
        localfixup,parafixup,
        i : longint;
        r : preference;
        skipnode : boolean;
      begin
         if inlining_procedure then
           begin
             localfixup:=aktprocsym^.definition^.localst^.address_fixup;
             parafixup:=aktprocsym^.definition^.parast^.address_fixup;
             ResetAsmSymbolListAltSymbol;
             hp:=pai(p^.p_asm^.first);
             while assigned(hp) do
              begin
                hp2:=pai(hp^.getcopy);
                skipnode:=false;
                case hp2^.typ of
                  ait_label :
                     begin
                       { regenerate the labels by setting altsymbol }
                       ReLabel(pasmsymbol(pai_label(hp2)^.l));
                     end;
                  ait_const_rva,
                  ait_const_symbol :
                     begin
                       ReLabel(pai_const_symbol(hp2)^.sym);
                     end;
                  ait_instruction :
                     begin
{$ifdef i386}
                       { fixup the references }
                       for i:=1 to paicpu(hp2)^.ops do
                        case paicpu(hp2)^.oper[i-1].typ of
                          top_ref :
                            begin
                              r:=paicpu(hp2)^.oper[i-1].ref;
                              case r^.options of
                                ref_parafixup :
                                  r^.offsetfixup:=parafixup;
                                ref_localfixup :
                                  r^.offsetfixup:=localfixup;
                              end;
                              if assigned(r^.symbol) then
                               ReLabel(r^.symbol);
                            end;
                          top_symbol :
                            begin
                              ReLabel(paicpu(hp2)^.oper[i-1].sym);
                            end;
                         end;
{$endif i386}
                     end;
                   ait_marker :
                     begin
                     { it's not an assembler block anymore }
                       if (pai_marker(hp2)^.kind in [AsmBlockStart, AsmBlockEnd]) then
                        skipnode:=true;
                     end;
                   else
                end;
                if not skipnode then
                 exprasmlist^.concat(hp2)
                else
                 dispose(hp2,done);
                hp:=pai(hp^.next);
              end
           end
         else
           begin
             { if the routine is an inline routine, then we must hold a copy
               becuase it can be necessary for inlining later }
             if (pocall_inline in aktprocsym^.definition^.proccalloptions) then
               exprasmlist^.concatlistcopy(p^.p_asm)
             else
               exprasmlist^.concatlist(p^.p_asm);
           end;
         if not p^.object_preserved then
          begin
{$ifdef i386}
            maybe_loadesi;
{$endif}
{$ifdef m68k}
            maybe_loada5;
{$endif}
          end;
       end;

{$ifdef logsecondpass}
     procedure logsecond(const s: string; entry: boolean);
     var p: pchar;
     begin
       if entry then
         p := strpnew(s+' (entry)')
       else p := strpnew(s+' (exit)');
       exprasmlist^.concat(new(pai_asm_comment,init(p)));
     end;
{$endif logsecondpass}

     procedure secondpass(var p : ptree);
       const
         procedures : array[ttreetyp] of secondpassproc =
            (secondadd,  {addn}
             secondadd,  {muln}
             secondadd,  {subn}
             secondmoddiv,      {divn}
             secondadd,  {symdifn}
             secondmoddiv,      {modn}
             secondassignment,  {assignn}
             secondload,        {loadn}
             secondnothing,     {range}
             secondadd,  {ltn}
             secondadd,  {lten}
             secondadd,  {gtn}
             secondadd,  {gten}
             secondadd,  {equaln}
             secondadd,  {unequaln}
             secondin,    {inn}
             secondadd,  {orn}
             secondadd,  {xorn}
             secondshlshr,      {shrn}
             secondshlshr,      {shln}
             secondadd,  {slashn}
             secondadd,  {andn}
             secondsubscriptn,  {subscriptn}
             secondderef,       {derefn}
             secondaddr,        {addrn}
             seconddoubleaddr,  {doubleaddrn}
             secondordconst,    {ordconstn}
             secondtypeconv,    {typeconvn}
             secondcalln,       {calln}
             secondnothing,     {callparan}
             secondrealconst,   {realconstn}
             secondfixconst,    {fixconstn}
             secondunaryminus,  {unaryminusn}
             secondasm,         {asmn}
             secondvecn,        {vecn}
             secondpointerconst, {pointerconstn}
             secondstringconst, {stringconstn}
             secondfuncret,     {funcretn}
             secondselfn,       {selfn}
             secondnot,  {notn}
             secondinline,      {inlinen}
             secondniln,        {niln}
             seconderror,       {errorn}
             secondnothing,     {typen}
             secondhnewn,       {hnewn}
             secondhdisposen,   {hdisposen}
             secondnewn,        {newn}
             secondsimplenewdispose, {simpledisposen}
             secondsetelement,  {setelementn}
             secondsetconst,    {setconstn}
             secondblockn,      {blockn}
             secondstatement,   {statementn}
             secondnothing,     {loopn}
             secondifn,  {ifn}
             secondbreakn,      {breakn}
             secondcontinuen,   {continuen}
             second_while_repeatn, {repeatn}
             second_while_repeatn, {whilen}
             secondfor,  {forn}
             secondexitn,       {exitn}
             secondwith,        {withn}
             secondcase,        {casen}
             secondlabel,       {labeln}
             secondgoto,        {goton}
             secondsimplenewdispose, {simplenewn}
             secondtryexcept,   {tryexceptn}
             secondraise,       {raisen}
             secondnothing,     {switchesn}
             secondtryfinally,  {tryfinallyn}
             secondon,    {onn}
             secondis,    {isn}
             secondas,    {asn}
             seconderror,       {caretn}
             secondfail,        {failn}
             secondadd,  {starstarn}
             secondprocinline,  {procinlinen}
             secondarrayconstruct, {arrayconstructn}
             secondnothing,     {arrayconstructrangen}
             secondnothing,     {nothingn}
             secondloadvmt      {loadvmtn}
             );
{$ifdef logsecondpass}
      secondnames: array[ttreetyp] of string[13] =
            ('add-addn',  {addn}
             'add-muln)',  {muln}
             'add-subn',  {subn}
             'moddiv-divn',      {divn}
             'add-symdifn',      {symdifn}
             'moddiv-modn',      {modn}
             'assignment',  {assignn}
             'load',        {loadn}
             'nothing-range',     {range}
             'add-ltn',  {ltn}
             'add-lten',  {lten}
             'add-gtn',  {gtn}
             'add-gten',  {gten}
             'add-equaln',  {equaln}
             'add-unequaln',  {unequaln}
             'in',    {inn}
             'add-orn',  {orn}
             'add-xorn',  {xorn}
             'shlshr-shrn',      {shrn}
             'shlshr-shln',      {shln}
             'add-slashn',  {slashn}
             'add-andn',  {andn}
             'subscriptn',  {subscriptn}
             'dderef',       {derefn}
             'addr',        {addrn}
             'doubleaddr',  {doubleaddrn}
             'ordconst',    {ordconstn}
             'typeconv',    {typeconvn}
             'calln',       {calln}
             'nothing-callp',     {callparan}
             'realconst',   {realconstn}
             'fixconst',    {fixconstn}
             'unaryminus',  {unaryminusn}
             'asm',         {asmn}
             'vecn',        {vecn}
             'pointerconst', {pointerconstn}
             'stringconst', {stringconstn}
             'funcret',     {funcretn}
             'selfn',       {selfn}
             'not',  {notn}
             'inline',      {inlinen}
             'niln',        {niln}
             'error',       {errorn}
             'nothing-typen',     {typen}
             'hnewn',       {hnewn}
             'hdisposen',   {hdisposen}
             'newn',        {newn}
             'simplenewDISP', {simpledisposen}
             'setelement',  {setelementn}
             'setconst',    {setconstn}
             'blockn',      {blockn}
             'statement',   {statementn}
             'nothing-loopn',     {loopn}
             'ifn',  {ifn}
             'breakn',      {breakn}
             'continuen',   {continuen}
             '_while_REPEAT', {repeatn}
             '_WHILE_repeat', {whilen}
             'for',  {forn}
             'exitn',       {exitn}
             'with',        {withn}
             'case',        {casen}
             'label',       {labeln}
             'goto',        {goton}
             'simpleNEWdisp', {simplenewn}
             'tryexcept',   {tryexceptn}
             'raise',       {raisen}
             'nothing-swtch',     {switchesn}
             'tryfinally',  {tryfinallyn}
             'on',    {onn}
             'is',    {isn}
             'as',    {asn}
             'error-caret',       {caretn}
             'fail',        {failn}
             'add-startstar',  {starstarn}
             'procinline',  {procinlinen}
             'arrayconstruc', {arrayconstructn}
             'noth-arrcnstr',     {arrayconstructrangen}
             'nothing-nothg',     {nothingn}
             'loadvmt'      {loadvmtn}
             );

{$endif logsecondpass}
      var
         oldcodegenerror  : boolean;
         oldlocalswitches : tlocalswitches;
         oldpos    : tfileposinfo;
{$ifdef TEMPREGDEBUG}
         prevp : pptree;
{$endif TEMPREGDEBUG}
      begin
         if not(p^.error) then
          begin
            oldcodegenerror:=codegenerror;
            oldlocalswitches:=aktlocalswitches;
            oldpos:=aktfilepos;
{$ifdef TEMPREGDEBUG}
            testregisters32;
            prevp:=curptree;
            curptree:=@p;
            p^.usableregs:=usablereg32;
{$endif TEMPREGDEBUG}
            aktfilepos:=p^.fileinfo;
            aktlocalswitches:=p^.localswitches;
            codegenerror:=false;
{$ifdef logsecondpass}
            logsecond('second'+secondnames[p^.treetype],true);
{$endif logsecondpass}
            procedures[p^.treetype](p);
{$ifdef logsecondpass}
            logsecond('second'+secondnames[p^.treetype],false);
{$endif logsecondpass}
            p^.error:=codegenerror;

            codegenerror:=codegenerror or oldcodegenerror;
            aktlocalswitches:=oldlocalswitches;
            aktfilepos:=oldpos;
{$ifdef TEMPREGDEBUG}
            curptree:=prevp;
{$endif TEMPREGDEBUG}
{$ifdef EXTTEMPREGDEBUG}
            if p^.usableregs-usablereg32>p^.reallyusedregs then
              p^.reallyusedregs:=p^.usableregs-usablereg32;
            if p^.reallyusedregs<p^.registers32 then
              Comment(V_Debug,'registers32 overestimated '+tostr(p^.registers32)+
                '>'+tostr(p^.reallyusedregs));
{$endif EXTTEMPREGDEBUG}
          end
         else
           codegenerror:=true;
      end;


    function do_secondpass(var p : ptree) : boolean;
      begin
         codegenerror:=false;
         if not(p^.error) then
           secondpass(p);
         do_secondpass:=codegenerror;
      end;

    var
       { the array ranges are overestimated !!!  }
       { max(maxvarregs,maxfpuvarregs) would be }
       { enough                                 }
       regvars : array[1..maxvarregs+maxfpuvarregs] of pvarsym;
       regvars_para : array[1..maxvarregs+maxfpuvarregs] of boolean;
       regvars_refs : array[1..maxvarregs+maxfpuvarregs] of longint;
       parasym : boolean;

    procedure searchregvars(p : pnamedindexobject);
      var
         i,j,k : longint;
      begin
         if (psym(p)^.typ=varsym) and (vo_regable in pvarsym(p)^.varoptions) then
           begin
              j:=pvarsym(p)^.refs;
              { parameter get a less value }
              if parasym then
                begin
                   if cs_littlesize in aktglobalswitches  then
                     dec(j,1)
                   else
                     dec(j,100);
                end;
              { walk through all momentary register variables }
              for i:=1 to maxvarregs do
                begin
                   if ((regvars[i]=nil) or (j>regvars_refs[i])) and (j>0) then
                     begin
                        for k:=maxvarregs-1 downto i do
                          begin
                             regvars[k+1]:=regvars[k];
                             regvars_para[k+1]:=regvars_para[k];
                             regvars_refs[k+1]:=regvars_refs[k];
                          end;
                        { calc the new refs
                        pvarsym(p)^.refs:=j; }
                        regvars[i]:=pvarsym(p);
                        regvars_para[i]:=parasym;
                        regvars_refs[i]:=j;
                        break;
                     end;
                end;
           end;
      end;


    procedure searchfpuregvars(p : pnamedindexobject);
      var
         i,j,k : longint;
      begin
         if (psym(p)^.typ=varsym) and (vo_fpuregable in pvarsym(p)^.varoptions) then
           begin
              j:=pvarsym(p)^.refs;
              { parameter get a less value }
              if parasym then
                begin
                   if cs_littlesize in aktglobalswitches  then
                     dec(j,1)
                   else
                     dec(j,100);
                end;
              { walk through all momentary register variables }
              for i:=1 to maxfpuvarregs do
                begin
                   if ((regvars[i]=nil) or (j>regvars_refs[i])) and (j>0) then
                     begin
                        for k:=maxfpuvarregs-1 downto i do
                          begin
                             regvars[k+1]:=regvars[k];
                             regvars_para[k+1]:=regvars_para[k];
                             regvars_refs[k+1]:=regvars_refs[k];
                          end;
                        { calc the new refs
                        pvarsym(p)^.refs:=j; }
                        regvars[i]:=pvarsym(p);
                        regvars_para[i]:=parasym;
                        regvars_refs[i]:=j;
                        break;
                     end;
                end;
           end;
      end;

    procedure clearrefs(p : pnamedindexobject);

      begin
         if (psym(p)^.typ=varsym) then
           if pvarsym(p)^.refs>1 then
             pvarsym(p)^.refs:=1;
      end;

    procedure generatecode(var p : ptree);
      var
         i       : longint;
         regsize : topsize;
         hr      : preference;
      label
         nextreg;
      begin
         cleartempgen;
         flowcontrol:=[];
         { when size optimization only count occurrence }
         if cs_littlesize in aktglobalswitches then
           t_times:=1
         else
           { reference for repetition is 100 }
           t_times:=100;
         { clear register count }
         clearregistercount;
         use_esp_stackframe:=false;
         aktexceptblock:=nil;
         symtablestack^.foreach(@clearrefs);
         symtablestack^.next^.foreach(@clearrefs);
         if not(do_firstpass(p)) then
           begin
              { max. optimizations     }
              { only if no asm is used }
              { and no try statement   }
              if (cs_regalloc in aktglobalswitches) and
                ((procinfo^.flags and (pi_uses_asm or pi_uses_exceptions))=0) then
                begin
                   { can we omit the stack frame ? }
                   { conditions:
                     1. procedure (not main block)
                     2. no constructor or destructor
                     3. no call to other procedures
                     4. no interrupt handler
                   }
                   {!!!!!! this doesn work yet, because of problems with
                     with linux and windows
                   }
                   (*
                   if assigned(aktprocsym) then
                     begin
                       if not(assigned(procinfo^._class)) and
                          not(aktprocsym^.definition^.proctypeoption in [potype_constructor,potype_destructor]) and
                          not(po_interrupt in aktprocsym^.definition^.procoptions) and
                          ((procinfo^.flags and pi_do_call)=0) and
                          (lexlevel>=normal_function_level) then
                       begin
                         { use ESP as frame pointer }
                         procinfo^.framepointer:=stack_pointer;
                         use_esp_stackframe:=true;

                         { calc parameter distance new }
                         dec(procinfo^.framepointer_offset,4);
                         dec(procinfo^.selfpointer_offset,4);

                         { is this correct ???}
                         { retoffset can be negativ for results in eax !! }
                         { the value should be decreased only if positive }
                         if procinfo^.retoffset>=0 then
                           dec(procinfo^.retoffset,4);

                         dec(procinfo^.para_offset,4);
                         aktprocsym^.definition^.parast^.address_fixup:=procinfo^.para_offset;
                       end;
                     end;
                   *)
                   if (p^.registers32<4) then
                     begin
                        for i:=1 to maxvarregs do
                          regvars[i]:=nil;
                        parasym:=false;
                        symtablestack^.foreach({$ifndef TP}@{$endif}searchregvars);
                        { copy parameter into a register ? }
                        parasym:=true;
                        symtablestack^.next^.foreach({$ifndef TP}@{$endif}searchregvars);
                        { hold needed registers free }
                        for i:=maxvarregs downto maxvarregs-p^.registers32+1 do
                          regvars[i]:=nil;
                        { now assign register }
                        for i:=1 to maxvarregs-p^.registers32 do
                          begin
                             if assigned(regvars[i]) then
                               begin
                                  { it is nonsens, to copy the variable to }
                                  { a register because we need then much   }
                                  { too pushes ?                           }
                                  if reg_pushes[varregs[i]]>=regvars[i]^.refs then
                                    begin
                                       regvars[i]:=nil;
                                       goto nextreg;
                                    end;

                                  { register is no longer available for }
                                  { expressions                  }
                                  { search the register which is the most }
                                  { unused                              }
                                  usableregs:=usableregs-[varregs[i]];
{$ifdef i386}
                                  procinfo^.aktentrycode^.concat(new(pairegalloc,alloc(varregs[i])));
{$endif i386}
                                  is_reg_var[varregs[i]]:=true;
                                  dec(c_usableregs);

                                  { possibly no 32 bit register are needed }
                                  { call by reference/const ? }
                                  if (regvars[i]^.varspez=vs_var) or
                                     ((regvars[i]^.varspez=vs_const) and
                                       push_addr_param(regvars[i]^.vartype.def)) then
                                    begin
                                       regvars[i]^.reg:=varregs[i];
                                       regsize:=S_L;
                                    end
                                  else
                                   if (regvars[i]^.vartype.def^.deftype in [orddef,enumdef]) and
                                      (porddef(regvars[i]^.vartype.def)^.size=1) then
                                    begin
{$ifdef i386}
                                       regvars[i]^.reg:=reg32toreg8(varregs[i]);
{$endif}
                                       regsize:=S_B;
                                    end
                                  else
                                   if (regvars[i]^.vartype.def^.deftype in [orddef,enumdef]) and
                                      (porddef(regvars[i]^.vartype.def)^.size=2) then
                                    begin
{$ifdef i386}
                                       regvars[i]^.reg:=reg32toreg16(varregs[i]);
{$endif}
                                       regsize:=S_W;
                                    end
                                  else
                                    begin
                                       regvars[i]^.reg:=varregs[i];
                                       regsize:=S_L;
                                    end;
                                  { parameter must be load }
                                  if regvars_para[i] then
                                    begin
                                       { procinfo is there actual,      }
                                       { because we can't never be in a }
                                       { nested procedure              }
                                       { when loading parameter to reg  }
                                       new(hr);
                                       reset_reference(hr^);
                                       hr^.offset:=pvarsym(regvars[i])^.address+procinfo^.para_offset;
                                       hr^.base:=procinfo^.framepointer;
{$ifdef i386}
                                       procinfo^.aktentrycode^.concat(new(paicpu,op_ref_reg(A_MOV,regsize,
                                         hr,regvars[i]^.reg)));
{$endif i386}
{$ifdef m68k}
                                       procinfo^.aktentrycode^.concat(new(paicpu,op_ref_reg(A_MOVE,regsize,
                                         hr,regvars[i]^.reg)));
{$endif m68k}
                                       unused:=unused - [regvars[i]^.reg];
                                    end;
                                  { procedure uses this register }
{$ifdef i386}
                                  usedinproc:=usedinproc or ($80 shr byte(varregs[i]));
{$endif i386}
{$ifdef m68k}
                                  usedinproc:=usedinproc or ($800 shr word(varregs[i]));
{$endif m68k}
                               end;
                             nextreg:
                               { dummy }
                               regsize:=S_W;
                          end;
                        for i:=1 to maxvarregs do
                          begin
                             if assigned(regvars[i]) then
                               begin
                                  if cs_asm_source in aktglobalswitches then
                                    procinfo^.aktentrycode^.insert(new(pai_asm_comment,init(strpnew(regvars[i]^.name+
                                      ' with weight '+tostr(regvars[i]^.refs)+' assigned to register '+
                                      reg2str(regvars[i]^.reg)))));
                                  if (status.verbosity and v_debug)=v_debug then
                                    Message3(cg_d_register_weight,reg2str(regvars[i]^.reg),
                                      tostr(regvars[i]^.refs),regvars[i]^.name);
                               end;
                          end;
                     end;
                   if ((p^.registersfpu+1)<maxfpuvarregs) then
                     begin
                        for i:=1 to maxfpuvarregs do
                          regvars[i]:=nil;
                        parasym:=false;
                        symtablestack^.foreach({$ifndef TP}@{$endif}searchfpuregvars);
{$ifdef dummy}
                        { copy parameter into a register ? }
                        parasym:=true;
                        symtablestack^.next^.foreach({$ifndef TP}@{$endif}searchregvars);
{$endif dummy}
                        { hold needed registers free }

                        { in non leaf procedures we must be very careful }
                        { with assigning registers                       }
                        if aktmaxfpuregisters=-1 then
                          begin
                             if (procinfo^.flags and pi_do_call)<>0 then
                               begin
                                  for i:=maxfpuvarregs downto 2 do
                                    regvars[i]:=nil;
                               end
                             else
                               begin
                                  for i:=maxfpuvarregs downto maxfpuvarregs-p^.registersfpu do
                                    regvars[i]:=nil;
                               end;
                          end
                        else
                          begin
                             for i:=aktmaxfpuregisters+1 to maxfpuvarregs do
                                regvars[i]:=nil;
                          end;
                        { now assign register }
                        for i:=1 to maxfpuvarregs do
                          begin
                             if assigned(regvars[i]) then
                               begin
{$ifdef i386}
                                  { reserve place on the FPU stack }
                                  regvars[i]^.reg:=correct_fpuregister(R_ST0,i-1);
                                  procinfo^.aktentrycode^.concat(new(paicpu,op_none(A_FLDZ,S_NO)));
                                  { ... and clean it up }
                                  procinfo^.aktexitcode^.concat(new(paicpu,op_reg(A_FSTP,S_NO,R_ST0)));
{$endif i386}
{$ifdef m68k}
                                  regvars[i]^.reg:=fpuvarregs[i];
{$endif m68k}
{$ifdef dummy}
                                  { parameter must be load }
                                  if regvars_para[i] then
                                    begin
                                       { procinfo is there actual,      }
                                       { because we can't never be in a }
                                       { nested procedure              }
                                       { when loading parameter to reg  }
                                       new(hr);
                                       reset_reference(hr^);
                                       hr^.offset:=pvarsym(regvars[i])^.address+procinfo^.para_offset;
                                       hr^.base:=procinfo^.framepointer;
{$ifdef i386}
                                       procinfo^.aktentrycode^.concat(new(paicpu,op_ref_reg(A_MOV,regsize,
                                         hr,regvars[i]^.reg)));
{$endif i386}
{$ifdef m68k}
                                       procinfo^.aktentrycode^.concat(new(paicpu,op_ref_reg(A_MOVE,regsize,
                                         hr,regvars[i]^.reg)));
{$endif m68k}
                                    end;
{$endif dummy}
                               end;
                          end;
                       if cs_asm_source in aktglobalswitches then
                         procinfo^.aktentrycode^.insert(new(pai_asm_comment,init(strpnew(tostr(p^.registersfpu)+
                         ' registers on FPU stack used by temp. expressions'))));
                        for i:=1 to maxfpuvarregs do
                          begin
                             if assigned(regvars[i]) then
                               begin
                                  if cs_asm_source in aktglobalswitches then
                                    procinfo^.aktentrycode^.insert(new(pai_asm_comment,init(strpnew(regvars[i]^.name+
                                      ' with weight '+tostr(regvars[i]^.refs)+' assigned to register '+
                                      reg2str(regvars[i]^.reg)))));
                                  if (status.verbosity and v_debug)=v_debug then
                                    Message3(cg_d_register_weight,reg2str(regvars[i]^.reg),
                                      tostr(regvars[i]^.refs),regvars[i]^.name);
                               end;
                          end;
                        if cs_asm_source in aktglobalswitches then
                          procinfo^.aktentrycode^.insert(new(pai_asm_comment,init(strpnew('Register variable assignment:'))));
                     end;
                end;
              if assigned(aktprocsym) and
                 (pocall_inline in aktprocsym^.definition^.proccalloptions) then
                make_const_global:=true;
              do_secondpass(p);

              if assigned(procinfo^.def) then
                procinfo^.def^.fpu_used:=p^.registersfpu;

           end;
         procinfo^.aktproccode^.concatlist(exprasmlist);
         make_const_global:=false;
      end;

end.
{
  $Log: not supported by cvs2svn $
  Revision 1.63  2000/04/06 11:28:17  pierre
   * avoid bug 911, worng unused parameter hints

  Revision 1.62  2000/04/02 12:11:38  florian
    * enumerations with size 1 or 2 weren't handled corretly if they were register
      variables: in fact they got 32 bit register assigned; fixed

  Revision 1.61  2000/03/26 10:50:04  florian
    * improved allocation rules for integer register variables

  Revision 1.60  2000/03/19 08:17:36  peter
    * tp7 fix

  Revision 1.59  2000/03/01 00:01:14  pierre
   Use $GOTO ON

  Revision 1.58  2000/02/20 20:49:45  florian
    * newcg is compiling
    * fixed the dup id problem reported by Paul Y.

  Revision 1.57  2000/02/10 23:44:43  florian
    * big update for exception handling code generation: possible mem holes
      fixed, break/continue/exit should work always now as expected

  Revision 1.56  2000/02/09 13:22:55  peter
    * log truncated

  Revision 1.55  2000/02/05 15:57:58  florian
    * for some strange reasons my fix regarding register variable
      allocation was lost

  Revision 1.54  2000/02/04 14:54:17  jonas
    * moved call to resetusableregs to compile_proc_body (put it right before the
      reset of the temp generator) so the optimizer can know which registers are
      regvars

  Revision 1.52  2000/01/22 15:58:12  jonas
    * forgot to commit a procedure for -dlogsecondpass the last time

  Revision 1.51  2000/01/21 12:16:53  jonas
    + add info on entry/exit of secondpass procedure in assembler files, between
      -dlogsecondpass

  Revision 1.50  2000/01/16 22:17:11  peter
    * renamed call_offset to para_offset

  Revision 1.49  2000/01/07 01:14:28  peter
    * updated copyright to 2000

  Revision 1.48  2000/01/04 15:15:52  florian
    + added compiler switch $maxfpuregisters
    + fixed a small problem in secondvecn

  Revision 1.47  1999/12/22 01:01:52  peter
    - removed freelabel()
    * added undefined label detection in internal assembler, this prevents
      a lot of ld crashes and wrong .o files
    * .o files aren't written anymore if errors have occured
    * inlining of assembler labels is now correct

  Revision 1.46  1999/12/19 23:37:18  pierre
   * fix for web bug735

  Revision 1.45  1999/12/14 09:58:42  florian
    + compiler checks now if a goto leaves an exception block

  Revision 1.44  1999/11/30 10:40:44  peter
    + ttype, tsymlist

  Revision 1.43  1999/11/18 15:34:47  pierre
    * Notes/Hints for local syms changed to
      Set_varstate function

  Revision 1.42  1999/11/09 23:06:45  peter
    * esi_offset -> selfpointer_offset to be newcg compatible
    * hcogegen -> cgbase fixes for newcg

  Revision 1.41  1999/11/06 14:34:21  peter
    * truncated log to 20 revs

  Revision 1.40  1999/09/27 23:44:52  peter
    * procinfo is now a pointer
    * support for result setting in sub procedure

  Revision 1.39  1999/09/26 21:30:17  peter
    + constant pointer support which can happend with typecasting like
      const p=pointer(1)
    * better procvar parsing in typed consts

  Revision 1.38  1999/09/16 23:05:54  florian
    * m68k compiler is again compilable (only gas writer, no assembler reader)

  Revision 1.37  1999/09/15 20:35:41  florian
    * small fix to operator overloading when in MMX mode
    + the compiler uses now fldz and fld1 if possible
    + some fixes to floating point registers
    + some math. functions (arctan, ln, sin, cos, sqrt, sqr, pi) are now inlined
    * .... ???

  Revision 1.36  1999/09/07 14:12:35  jonas
    * framepointer cannot be changed to esp for methods

  Revision 1.35  1999/08/27 10:46:26  pierre
   + some EXTTEMPREGDEBUG code added

}