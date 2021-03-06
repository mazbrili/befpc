{
    $Id: strings.inc,v 1.1.1.1 2001-07-23 17:17:29 memson Exp $
    This file is part of the Free Pascal run time library.
    Copyright (c) 1999-2000 by the Free Pascal development team

    Processor dependent part of strings.pp, that can be shared with
    sysutils unit.

    See the file COPYING.FPC, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 **********************************************************************}

{$ASMMODE ATT}

function strcopy(dest,source : pchar) : pchar;assembler;
asm
        movl    source,%edi
        testl   %edi,%edi
        jz      .LStrCopyDone
        movl    %edi,%ecx
        andl    $0x0fffffff8,%edi
        movl    source,%esi
        subl    %edi,%ecx
        movl    dest,%edi
        jz      .LStrCopyAligned
.LStrCopyAlignLoop:
        movb    (%esi),%al
        incl    %edi
        incl    %esi
        testb   %al,%al
        movb    %al,-1(%edi)
        jz      .LStrCopyDone
        decl    %ecx
        jnz     .LStrCopyAlignLoop
        .balign  16
.LStrCopyAligned:
        movl    (%esi),%eax
        addl    $4,%esi
        testl   $0x0ff,%eax
        jz      .LStrCopyByte
        testl   $0x0ff00,%eax
        jz      .LStrCopyWord
        testl   $0x0ff0000,%eax
        jz      .LStrCopy3Bytes
        movl    %eax,(%edi)
        testl   $0x0ff000000,%eax
        jz      .LStrCopyDone
        addl    $4,%edi
        jmp     .LStrCopyAligned
.LStrCopy3Bytes:
        movw     %ax,(%edi)
        xorl     %eax,%eax
        addl     $2,%edi
        jmp     .LStrCopyByte
.LStrCopyWord:
        movw    %ax,(%edi)
        jmp     .LStrCopyDone
.LStrCopyByte:
        movb    %al,(%edi)
.LStrCopyDone:
        movl    dest,%eax
end ['EAX','ECX','ESI','EDI'];


function strecopy(dest,source : pchar) : pchar;assembler;
asm
        cld
        movl    source,%edi
        movl    $0xffffffff,%ecx
        xorl    %eax,%eax
        repne
        scasb
        not     %ecx
        movl    dest,%edi
        movl    source,%esi
        movl    %ecx,%eax
        shrl    $2,%ecx
        rep
        movsl
        movl    %eax,%ecx
        andl    $3,%ecx
        rep
        movsb
        movl    dest,%eax
        decl    %edi
        movl    %edi,%eax
end ['EAX','ECX','ESI','EDI'];


function strlcopy(dest,source : pchar;maxlen : longint) : pchar;assembler;
asm
        movl    source,%esi
        movl    maxlen,%ecx
        movl    dest,%edi
        orl     %ecx,%ecx
        jz      .LSTRLCOPY2
        cld
.LSTRLCOPY1:
        lodsb
        stosb
        decl    %ecx            // Lower maximum
        jz      .LSTRLCOPY2     // 0 reached ends
        orb     %al,%al
        jnz     .LSTRLCOPY1
        jmp     .LSTRLCOPY3
.LSTRLCOPY2:
        xorb    %al,%al         // If cutted
        stosb                   // add a #0
.LSTRLCOPY3:
        movl    dest,%eax
end ['EAX','ECX','ESI','EDI'];


function strlen(p : pchar) : longint;assembler;
asm
        cld
        xorl    %eax,%eax
        movl    p,%edi
        orl     %edi,%edi
        jz      .LNil
        movl    $0xffffffff,%ecx
        repne
        scasb
        movl    $0xfffffffe,%eax
        subl    %ecx,%eax
.LNil:
end ['EDI','ECX','EAX'];


function strend(p : pchar) : pchar;assembler;
asm
        cld
        xorl    %eax,%eax
        movl    p,%edi
        orl     %edi,%edi
        jz      .LStrEndNil
        movl    $0xffffffff,%ecx
        xorl    %eax,%eax
        repne
        scasb
        movl    %edi,%eax
        decl    %eax
.LStrEndNil:
end ['EDI','ECX','EAX'];


function strcomp(str1,str2 : pchar) : longint;assembler;
asm
        movl    str2,%edi
        movl    $0xffffffff,%ecx
        cld
        xorl    %eax,%eax
        repne
        scasb
        not     %ecx
        movl    str2,%edi
        movl    str1,%esi
        repe
        cmpsb
        movb    -1(%esi),%al
        movzbl  -1(%edi),%ecx
        subl    %ecx,%eax
end ['EAX','ECX','ESI','EDI'];


function strlcomp(str1,str2 : pchar;l : longint) : longint;assembler;
asm
        movl    str2,%edi
        movl    $0xffffffff,%ecx
        cld
        xorl    %eax,%eax
        repne
        scasb
        not     %ecx
        cmpl    l,%ecx
        jl      .LSTRLCOMP1
        movl    l,%ecx
.LSTRLCOMP1:
        movl    str2,%edi
        movl    str1,%esi
        repe
        cmpsb
        movb    -1(%esi),%al
        movzbl  -1(%edi),%ecx
        subl    %ecx,%eax
end ['EAX','ECX','ESI','EDI'];


function stricomp(str1,str2 : pchar) : longint;assembler;
asm
        movl    str2,%edi
        movl    $0xffffffff,%ecx
        cld
        xorl    %eax,%eax
        repne
        scasb
        not     %ecx
        movl    str2,%edi
        movl    str1,%esi
.LSTRICOMP2:
        repe
        cmpsb
        jz      .LSTRICOMP3     // If last reached then exit
        movzbl  -1(%esi),%eax
        movzbl  -1(%edi),%ebx
        cmpb    $97,%al
        jb      .LSTRICOMP1
        cmpb    $122,%al
        ja      .LSTRICOMP1
        subb    $0x20,%al
.LSTRICOMP1:
        cmpb    $97,%bl
        jb      .LSTRICOMP4
        cmpb    $122,%bl
        ja      .LSTRICOMP4
        subb    $0x20,%bl
.LSTRICOMP4:
        subl    %ebx,%eax
        jz      .LSTRICOMP2     // If still equal, compare again
.LSTRICOMP3:
end ['EAX','ECX','ESI','EDI'];


function strlicomp(str1,str2 : pchar;l : longint) : longint;assembler;
asm
        movl    str2,%edi
        movl    $0xffffffff,%ecx
        cld
        xorl    %eax,%eax
        repne
        scasb
        not     %ecx
        cmpl    l,%ecx
        jl      .LSTRLICOMP5
        movl    l,%ecx
.LSTRLICOMP5:
        movl    str2,%edi
        movl    str1,%esi
.LSTRLICOMP2:
        repe
        cmpsb
        jz      .LSTRLICOMP3    // If last reached, exit
        movzbl  -1(%esi),%eax
        movzbl  -1(%edi),%ebx
        cmpb    $97,%al
        jb      .LSTRLICOMP1
        cmpb    $122,%al
        ja      .LSTRLICOMP1
        subb    $0x20,%al
.LSTRLICOMP1:
        cmpb    $97,%bl
        jb      .LSTRLICOMP4
        cmpb    $122,%bl
        ja      .LSTRLICOMP4
        subb    $0x20,%bl
.LSTRLICOMP4:
        subl    %ebx,%eax
        jz      .LSTRLICOMP2
.LSTRLICOMP3:
end ['EAX','ECX','ESI','EDI'];


function strscan(p : pchar;c : char) : pchar;assembler;
asm
        movl    p,%eax
        xorl    %ecx,%ecx
        testl   %eax,%eax
        jz      .LSTRSCAN
// align
        movb    c,%cl
        movl    %eax,%esi
        andl    $0xfffffff8,%eax
        movl    $0xff,%edx
        movl    p,%edi
        subl    %eax,%esi
        jz      .LSTRSCANLOOP
        xorl    %eax,%eax
.LSTRSCANALIGNLOOP:
        movb    (%edi),%al
// at .LSTRSCANFOUND, one is substracted from edi to calculate the position,
// so add 1 here already (not after .LSTRSCAN, because then the test/jz and
// cmp/je can't be paired)
        incl    %edi
        testb   %al,%al
        jz      .LSTRSCAN
        cmpb    %cl,%al
        je      .LSTRSCANFOUND
        decl    %esi
        jnz     .LSTRSCANALIGNLOOP
        jmp     .LSTRSCANLOOP
        .balign  16
.LSTRSCANLOOP:
        movl    (%edi),%eax
        movl    %eax,%esi
// first char
        andl    %edx,%eax
// end of string -> stop
        jz      .LSTRSCAN
        shrl    $8,%esi
        cmpl    %ecx,%eax
        movl    %esi,%eax
        je      .LSTRSCANFOUND1
// second char
        andl    %edx,%eax
        jz      .LSTRSCAN
        shrl    $8,%esi
        cmpl    %ecx,%eax
        movl    %esi,%eax
        je      .LSTRSCANFOUND2
// third char
        andl    %edx,%eax
        jz      .LSTRSCAN
        shrl    $8,%esi
        cmpl    %ecx,%eax
        movl    %esi,%eax
        je      .LSTRSCANFOUND3
// fourth char
// all upper bits have already been cleared
        testl   %eax,%eax
        jz      .LSTRSCAN
        addl    $4,%edi
        cmpl    %ecx,%eax
        je      .LSTRSCANFOUND
        jmp     .LSTRSCANLOOP
.LSTRSCANFOUND3:
        leal    2(%edi),%eax
        jmp     .LSTRSCAN
.LSTRSCANFOUND2:
        leal    1(%edi),%eax
        jmp     .LSTRSCAN
.LSTRSCANFOUND1:
        movl    %edi,%eax
        jmp     .LSTRSCAN
.LSTRSCANFOUND:
        leal    -1(%edi),%eax
.LSTRSCAN:
end ['EAX','ECX','ESI','EDI','EDX'];


function strrscan(p : pchar;c : char) : pchar;assembler;
asm
        xorl    %eax,%eax
        movl    p,%edi
        orl     %edi,%edi
        jz      .LSTRRSCAN
        movl    $0xffffffff,%ecx
        cld
        xorb    %al,%al
        repne
        scasb
        not     %ecx
        movb    c,%al
        movl    p,%edi
        addl    %ecx,%edi
        decl    %edi
        std
        repne
        scasb
        cld
        movl    $0,%eax
        jnz     .LSTRRSCAN
        movl    %edi,%eax
        incl    %eax
.LSTRRSCAN:
end ['EAX','ECX','EDI'];


function strupper(p : pchar) : pchar;assembler;
asm
        movl    p,%esi
        orl     %esi,%esi
        jz      .LStrUpperNil
        movl    %esi,%edi
.LSTRUPPER1:
        lodsb
        cmpb    $97,%al
        jb      .LSTRUPPER3
        cmpb    $122,%al
        ja      .LSTRUPPER3
        subb    $0x20,%al
.LSTRUPPER3:
        stosb
        orb     %al,%al
        jnz     .LSTRUPPER1
.LStrUpperNil:
        movl    p,%eax
end ['EAX','ESI','EDI'];


function strlower(p : pchar) : pchar;assembler;
asm
        movl    p,%esi
        orl     %esi,%esi
        jz      .LStrLowerNil
        movl    %esi,%edi
.LSTRLOWER1:
        lodsb
        cmpb    $65,%al
        jb      .LSTRLOWER3
        cmpb    $90,%al
        ja      .LSTRLOWER3
        addb    $0x20,%al
.LSTRLOWER3:
        stosb
        orb     %al,%al
        jnz     .LSTRLOWER1
.LStrLowerNil:
        movl    p,%eax
end ['EAX','ESI','EDI'];

{
  $Log: not supported by cvs2svn $
  Revision 1.11  2000/06/23 11:13:56  jonas
    * fixed bug in strscan :(

  Revision 1.10  2000/06/12 19:53:32  peter
    * change .align to .balign

  Revision 1.9  2000/06/11 14:25:23  jonas
    * much faster strcopy and strscan procedures

  Revision 1.8  2000/03/28 11:14:33  jonas
    * added missing register that is destroyed by strecopy
    + some destroyed register lists for procedures that didn't have one yet

  Revision 1.7  2000/02/09 16:59:29  peter
    * truncated log

  Revision 1.6  2000/01/07 16:41:33  daniel
    * copyright 2000

  Revision 1.5  1999/12/18 23:08:33  florian
    * bug 766 fixed

}
