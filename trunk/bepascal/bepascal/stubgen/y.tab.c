
/*  A Bison parser, made from parser.y
    by GNU Bison version 1.28  */

#define YYBISON 1  /* Identify Bison output.  */

#define	IDENTIFIER	257
#define	CONSTANT	258
#define	STRING_LITERAL	259
#define	CHAR	260
#define	SHORT	261
#define	INT	262
#define	LONG	263
#define	SIGNED	264
#define	UNSIGNED	265
#define	FLOAT	266
#define	DOUBLE	267
#define	VOID	268
#define	NEW	269
#define	DELETE	270
#define	TEMPLATE	271
#define	THROW	272
#define	PTR_OP	273
#define	INC_OP	274
#define	DEC_OP	275
#define	LEFT_OP	276
#define	RIGHT_OP	277
#define	LE_OP	278
#define	GE_OP	279
#define	EQ_OP	280
#define	NE_OP	281
#define	AND_OP	282
#define	OR_OP	283
#define	MUL_ASSIGN	284
#define	DIV_ASSIGN	285
#define	MOD_ASSIGN	286
#define	ADD_ASSIGN	287
#define	SUB_ASSIGN	288
#define	LEFT_ASSIGN	289
#define	RIGHT_ASSIGN	290
#define	AND_ASSIGN	291
#define	XOR_ASSIGN	292
#define	OR_ASSIGN	293
#define	CLCL	294
#define	MEM_PTR_OP	295
#define	FRIEND	296
#define	OPERATOR	297
#define	CONST	298
#define	CLASS	299
#define	STRUCT	300
#define	UNION	301
#define	ENUM	302
#define	PROTECTED	303
#define	PRIVATE	304
#define	PUBLIC	305
#define	EXTERN	306
#define	ELIPSIS	307

#line 1 "parser.y"

/*
 *  FILE: parser.y
 *  AUTH: Michael John Radwin <mjr@acm.org>
 *
 *  DESC: stubgen grammar description.  Portions borrowed from
 *  Newcastle University's Arjuna project (http://arjuna.ncl.ac.uk/),
 *  and Jeff Lee's ANSI Grammar
 *  (ftp://ftp.uu.net/usenet/net.sources/ansi.c.grammar.Z)
 *  This grammar is only a subset of the real C++ language.
 *
 *  DATE: Thu Aug 15 13:10:06 EDT 1996
 *   $Id: y.tab.c,v 1.1 2002-06-06 22:09:16 ocoursiere Exp $
 *
 *  Copyright (c) 1996-1998  Michael John Radwin
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  --------------------------------------------------------------------
 * 
 *  $Log: not supported by cvs2svn $
 *  Revision 1.1  2001/11/07 10:06:07  ithamar
 *  Added stubgen to CVS
 *
 *  Revision 1.72  1998/07/07 00:14:06  mradwin
 *  removed extra space from throw_decl, cleaned up memory leak
 *  in ctor skeleton
 *
 *  Revision 1.71  1998/06/11 14:52:09  mradwin
 *  allow for empty class declarations, such as
 *  class Element {};
 *  also, differentiate structs from classes with
 *  new STRUCT_KIND tag.
 *  New version: 2.04
 *
 *  Revision 1.70  1998/05/11 19:49:11  mradwin
 *  Version 2.03 (updated copyright information).
 *
 *  Revision 1.69  1998/04/07 23:43:34  mradwin
 *  changed error-handling code significantly.
 *  several functions now return a value, and instead of
 *  calling fatal(), we do a YYABORT or YYERROR to get out
 *  of the parsing state.
 *  New version: 2.02.
 *
 *  Revision 1.68  1998/03/28 02:59:41  mradwin
 *  working on slightly better error recovery; not done yet.
 *
 *  Revision 1.67  1998/03/28 02:34:56  mradwin
 *  added multi-line function parameters
 *  also changed pointer and reference (* and &) types so there
 *  is no trailing space before the parameter name.
 *
 *  Revision 1.66  1998/01/12 19:39:11  mradwin
 *  modified rcsid
 *
 *  Revision 1.65  1997/11/13 22:50:55  mradwin
 *  moved copyright from parser.y to main.c
 *
 *  Revision 1.64  1997/11/13 22:40:15  mradwin
 *  fixed a silly comment bug
 *
 *  Revision 1.63  1997/11/13 22:37:31  mradwin
 *  changed char[] to char * to make non-gcc compilers
 *  a little happier.  We need to #define const to nothing
 *  for other compilers as well.
 *
 *  Revision 1.62  97/11/13  21:29:30  21:29:30  mradwin (Michael Radwin)
 *  moved code from parser.y to main.c
 * 
 *  Revision 1.61  1997/11/13 21:10:17  mradwin
 *  renamed stubgen.[ly] to parser.y lexer.l
 *
 *  Revision 1.60  1997/11/11 04:11:29  mradwin
 *  fixed command-line flags: invalid options now force usgage.
 *
 *  Revision 1.59  1997/11/11 04:03:56  mradwin
 *  changed version info
 *
 *  Revision 1.58  1997/11/11 03:54:05  mradwin
 *  fixed a long-standing bug with -b option.  a typo was causing
 *  the -b flag to be ignored.
 *
 *  Revision 1.57  1997/11/11 03:52:06  mradwin
 *  changed fatal()
 *
 *  Revision 1.56  1997/11/05 03:02:02  mradwin
 *  Modified logging routines.
 *
 *  Revision 1.55  1997/11/05 02:14:38  mradwin
 *  Made some compiler warnings disappear.
 *
 *  Revision 1.54  1997/11/01 23:26:13  mradwin
 *  new Revision string and usage info
 *
 *  Revision 1.53  1997/11/01 23:12:43  mradwin
 *  greatly improved error-recovery.  errors no longer spill over
 *  into other files because the yyerror state is properly reset.
 *
 *  Revision 1.52  1997/10/27 01:14:23  mradwin
 *  fixed constant_value so it supports simple arithmetic.  it's
 *  not as robust as full expressions, but this will handle the
 *  char buffer[BUFSIZE + 1] problem.
 *
 *  Also removed expansion rules that simply did { $$ = $1; } because
 *  that action is implicit anyway.
 *
 *  Revision 1.51  1997/10/26 23:16:32  mradwin
 *  changed inform_user and fatal functions to use varargs
 *
 *  Revision 1.50  1997/10/26 22:27:07  mradwin
 *  Fixed this bug:
 *  stubgen dies on the following because the protected section is empty:
 *
 *  class WidgetCsg : public WidgetLens {
 *   protected:
 *
 *   public:
 *       virtual ~WidgetCsg() {}
 *                WidgetCsg();
 *  };
 *
 *  Error:
 *  stubgen version 2.0-beta $Revision: 1.1 $.
 *  parse error at line 4, file test.H:
 *   public:
 *        ^
 *
 *  Revision 1.49  1997/10/16 19:42:48  mradwin
 *  added support for elipses, static member/array initializers,
 *  and bitfields.
 *
 *  Revision 1.48  1997/10/16 17:35:39  mradwin
 *  cleaned up usage info
 *
 *  Revision 1.47  1997/10/16 17:12:59  mradwin
 *  handle extern "C" blocks better now, and support multi-line
 *  macros.  still need error-checking.
 *
 *  Revision 1.46  1997/10/15 22:09:06  mradwin
 *  changed tons of names.  stubelem -> sytaxelem,
 *  stubin -> infile, stubout -> outfile, stublog -> logfile.
 *
 *  Revision 1.45  1997/10/15 21:33:36  mradwin
 *  fixed up function_hdr
 *
 *  Revision 1.44  1997/10/15 21:33:02  mradwin
 *  *** empty log message ***
 *
 *  Revision 1.43  1997/10/15 17:42:37  mradwin
 *  added support for 'extern "C" { ... }' blocks.
 *
 *  Revision 1.42  1997/09/26 20:59:18  mradwin
 *  now allow "struct foobar *f" to appear in a parameter
 *  list or as a variable decl.  Had to remove the
 *  class_or_struct rule and blow up the class_specifier
 *  description.
 *
 *  Revision 1.41  1997/09/26 19:02:18  mradwin
 *  fixed memory leak involving template decls in skeleton code.
 *  Leads me to believe that skel_elemcmp() is flawed, because
 *  it may rely in parent->templ info.
 *
 *  Revision 1.40  1997/09/26 18:44:22  mradwin
 *  changed parameter handing from char *'s to an argument type
 *  to facilitate comparisons between skeleton code
 *  and header code.  Now we can correctly recognize different
 *  parameter names while still maintaining the same signature.
 *
 *  Revision 1.39  1997/09/26 00:47:29  mradwin
 *  added better base type support -- recognize things like
 *  "long long" and "short int" now.
 *
 *  Revision 1.38  1997/09/19 18:16:37  mradwin
 *  allowed an instance name to come after a class, struct,
 *  union, or enum.  This improves parseability of typedefs
 *  commonly found in c header files, although true typedefs are
 *  not understood.
 *
 *  Revision 1.37  1997/09/15 22:38:28  mradwin
 *  did more revision on the SGDEBUG stuff
 *
 *  Revision 1.36  1997/09/15 19:05:26  mradwin
 *  allow logging to be compiled out by turning off SGDEBUG
 *
 *  Revision 1.35  1997/09/12 00:58:43  mradwin
 *  duh, silly me.  messed up compilation.
 *
 *  Revision 1.34  1997/09/12 00:57:49  mradwin
 *  Revision string inserted in usage
 *
 *  Revision 1.33  1997/09/12 00:51:19  mradwin
 *  string copyright added to code for binary copyright.
 *
 *  Revision 1.32  1997/09/12 00:47:21  mradwin
 *  some more compactness of grammar with parameter_list_opt
 *  and also ampersand_opt
 *
 *  Revision 1.31  1997/09/12 00:26:19  mradwin
 *  better template support, but still poor
 *
 *  Revision 1.30  1997/09/08 23:24:51  mradwin
 *  changes to error-handling code.
 *  also got rid of the %type <flag> for the top-level rules
 *
 *  Revision 1.30  1997/09/08 23:20:02  mradwin
 *  some error reporting changes and default values for top-level
 *  grammar stuff.
 *
 *  Revision 1.29  1997/09/08 17:54:24  mradwin
 *  cleaned up options and usage info.
 *
 *  Revision 1.28  1997/09/05 19:38:04  mradwin
 *  changed options for .ext instead of -l or -x
 *
 *  Revision 1.27  1997/09/05 19:17:06  mradwin
 *  works for scanning old versions, except for parameter
 *  names that differ between .H and .C files.
 *
 *  Revision 1.26  1997/09/05 16:34:36  mradwin
 *  GPL-ized code.
 *
 *  Revision 1.25  1997/09/05 16:11:44  mradwin
 *  some simple cleanup before GPL-izing the code
 *
 *  Revision 1.24  1997/09/04 19:50:34  mradwin
 *  whoo-hoo!  by blowing up the description
 *  exponentially, it works!
 *
 *  Revision 1.23  1997/03/20 16:05:41  mjr
 *  renamed syntaxelem to syntaxelem_t, cleaned up throw_decl
 *
 *  Revision 1.22  1996/10/02 15:16:57  mjr
 *  using pathname.h instead of libgen.h
 *
 *  Revision 1.21  1996/09/12 14:44:49  mjr
 *  Added throw decl recognition (great, another 4 bytes in syntaxelem)
 *  and cleaned up the grammar so that const_opt appears in far fewer
 *  places.  const_opt is by default 0 as well, so we don't need to
 *  pass it as an arg to new_elem().
 *
 *  I also added a fix to a potential bug with the MINIT and INLIN
 *  exclusive start states.  I think they could have been confused
 *  by braces within comments, so now I'm grabbing comments in those
 *  states as well.
 *
 *  Revision 1.20  1996/09/12 04:55:22  mjr
 *  changed expand strategy.  Don't expand while parsing now;
 *  enqueue as we go along and expand at the end.  Eventually
 *  we'll need to provide similar behavior for when we parse
 *  .C files
 *
 *  Revision 1.19  1996/09/12 03:46:10  mjr
 *  No concrete changes in code.  Just added some sanity by
 *  factoring out code into util.[ch] and putting some prototypes
 *  that were in table.h into stubgen.y where they belong.
 *
 *  Revision 1.18  1996/09/06 14:32:48  mjr
 *  defined the some_KIND constants for clarity, and made
 *  expandClass return immediately if it was give something other
 *  than a CLASS_KIND element.
 *
 *  Revision 1.17  1996/09/06 14:05:44  mjr
 *  Almost there with expanded operator goodies.  Still need
 *  to get OPERATOR type_name to work.
 *
 *  Revision 1.16  1996/09/04 22:28:09  mjr
 *  nested classes work and default arguments are now removed
 *  from the parameter lists.
 *
 *  Revision 1.15  1996/09/04 20:01:57  mjr
 *  non-functional expanded code.  needs work.
 *
 *  Revision 1.14  1996/09/01 21:29:34  mjr
 *  put the expanded_operator code back in as a useless rule.
 *  oughta think about fixing it up if possible
 *
 *  Revision 1.13  1996/09/01 20:59:48  mjr
 *  Added collectMemberInitList() function, which is similar
 *  to collectInlineDef() and also the exclusive state MINIT
 *
 *  Revision 1.12  1996/08/23 05:09:19  mjr
 *  fixed up some more portability things
 *
 *  Revision 1.11  1996/08/22 02:43:47  mjr
 *  added parse error message (using O'Reilly p. 274)
 *
 *  Revision 1.10  1996/08/21 18:33:50  mjr
 *  added support for template instantiation in the type_name
 *  rule.  surprisingly it didn't cause any shift/reduce conflicts.
 *
 *  Revision 1.9  1996/08/21 17:40:56  mjr
 *  added some cpp directives for porting to WIN32
 *
 *  Revision 1.8  1996/08/21 00:00:19  mjr
 *  approaching stability and usability.  command line arguments
 *  are handled now and the fopens and fcloses appear to work.
 *
 *  Revision 1.7  1996/08/20 20:44:23  mjr
 *  added initial support for optind but it is incomplete.
 *
 *  Revision 1.6  1996/08/19 17:14:59  mjr
 *  misordered args, fixed bug
 *
 *  Revision 1.5  1996/08/19 17:11:41  mjr
 *  RCS got confused with the RCS-style header goodies.
 *  got it cleaned up now.
 *
 *  Revision 1.4  1996/08/19 17:01:33  mjr
 *  Removed the expanded code checking and added
 *  lots of code that duplicates what stubgen.pl did.
 *  still need options pretty badly
 *
 *  Revision 1.3  1996/08/17 23:21:10  mjr
 *  added the expanded operator code, cleaned up tabs.
 *  consider putting all of the expanded code in another
 *  grammar - this one is getting cluttered.
 *
 */
#line 334 "parser.y"

#include "table.h"
#include "util.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#ifdef WIN32
#include <malloc.h> /* defintion of alloca */
#include "getopt.h" /* use GNU getopt      */
#endif /* WIN32 */

#ifndef WIN32
#include <pwd.h>
#endif /* WIN32 */

/* defined in lexer.l */
extern int collectInlineDef();
extern int collectMemberInitList();

/* defined here in parser.y */
static int error_recovery();
static int yyerror(char *);
static const char rcsid[] = "$Id: y.tab.c,v 1.1 2002-06-06 22:09:16 ocoursiere Exp $";

/* defined in main.c */
extern FILE *outfile;
extern char *currentFile;
extern int lineno;


#line 366 "parser.y"
typedef union {
  char *string;
  syntaxelem_t *elt;
  arg_t *arg;
  int flag;
} YYSTYPE;
#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#ifndef const
#define const
#endif
#endif
#endif



#define	YYFINAL		463
#define	YYFLAG		-32768
#define	YYNTBASE	76

#define YYTRANSLATE(x) ((unsigned)(x) <= 307 ? yytranslate[x] : 150)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,    71,     2,     2,     2,    73,    55,     2,    64,
    65,    58,    69,    63,    70,     2,    72,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,    61,    54,    56,
    62,    57,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
    59,     2,    60,    74,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,    67,    75,    68,    66,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     3,     4,     5,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
    17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
    27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
    37,    38,    39,    40,    41,    42,    43,    44,    45,    46,
    47,    48,    49,    50,    51,    52,    53
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     2,     5,     8,    12,    14,    16,    18,    20,    22,
    24,    26,    28,    30,    31,    33,    36,    40,    43,    46,
    49,    52,    54,    56,    59,    64,    69,    75,    81,    84,
    87,    91,    93,    96,    98,   101,   104,   106,   108,   111,
   113,   115,   118,   121,   125,   127,   129,   131,   133,   137,
   141,   143,   146,   148,   151,   154,   157,   162,   166,   168,
   172,   174,   177,   182,   186,   188,   191,   195,   197,   201,
   204,   208,   209,   211,   215,   217,   219,   221,   225,   229,
   231,   235,   240,   244,   247,   248,   253,   257,   258,   264,
   267,   268,   273,   277,   279,   281,   285,   287,   289,   295,
   306,   308,   314,   316,   325,   332,   341,   348,   355,   360,
   361,   363,   364,   369,   371,   375,   380,   387,   394,   404,
   414,   420,   426,   437,   448,   449,   453,   458,   464,   467,
   469,   473,   475,   479,   480,   482,   485,   489,   491,   493,
   495,   497,   499,   501,   503,   505,   507,   509,   511,   513,
   515,   517,   519,   521,   523,   525,   527,   529,   531,   533,
   535,   537,   539,   541,   543,   545,   547,   549,   551,   553,
   555,   557,   559,   561,   563,   565,   567,   569,   571,   573,
   575,   577,   580,   583,   585,   587,   589,   591,   594,   596,
   598,   600,   604,   606,   610,   614,   618,   620,   624,   628,
   634,   639,   642,   648,   656,   663,   672,   677,   683,   691,
   698,   707,   709,   713,   716,   719,   722,   723,   725,   727,
   730,   732,   734,   736,   739,   742,   745,   747,   749,   751,
   753,   756,   760,   762,   764,   767,   771,   776,   779,   782,
   784,   788,   790,   792,   794,   798
};

static const short yyrhs[] = {    77,
     0,    76,    77,     0,    78,    54,     0,    52,     5,   116,
     0,   101,     0,    98,     0,    54,     0,     1,     0,   143,
     0,    82,     0,   133,     0,   118,     0,   134,     0,     0,
    55,     0,    83,    80,     0,    44,    83,    80,     0,    45,
     3,     0,    45,    86,     0,    46,     3,     0,    46,    86,
     0,    86,     0,     3,     0,    46,     3,     0,    86,    56,
   148,    57,     0,     3,    56,   148,    57,     0,    86,    56,
   148,    57,    87,     0,     3,    56,   148,    57,    87,     0,
    86,    87,     0,     3,    87,     0,    46,     3,    87,     0,
    84,     0,    84,    87,     0,    85,     0,    10,    85,     0,
    11,    85,     0,     6,     0,     7,     0,     7,     8,     0,
     8,     0,     9,     0,     9,     8,     0,     9,     9,     0,
     9,     9,     8,     0,    11,     0,    12,     0,    13,     0,
    14,     0,     3,    40,     3,     0,    86,    40,     3,     0,
    88,     0,    87,    88,     0,    58,     0,    58,    44,     0,
    81,    90,     0,    81,    86,     0,    89,    59,   128,    60,
     0,    89,    59,    60,     0,     3,     0,     3,    61,     4,
     0,    90,     0,    87,     3,     0,    91,    59,   128,    60,
     0,    91,    59,    60,     0,    89,     0,    52,    89,     0,
    89,    62,   128,     0,    92,     0,    93,    63,    91,     0,
    93,    54,     0,    94,    93,    54,     0,     0,    96,     0,
    96,    63,    53,     0,    53,     0,    92,     0,    97,     0,
    96,    63,    92,     0,    96,    63,    97,     0,    81,     0,
    81,    62,   128,     0,    97,    59,   128,    60,     0,    97,
    59,    60,     0,   103,   116,     0,     0,   115,    61,    99,
   116,     0,   149,   103,   116,     0,     0,   149,   115,    61,
   100,   116,     0,   104,   116,     0,     0,   114,    61,   102,
   116,     0,   105,   109,   110,     0,   115,     0,   113,     0,
   106,   109,   110,     0,   114,     0,   112,     0,    81,    86,
    64,    95,    65,     0,    81,     3,    56,   148,    57,    40,
     3,    64,    95,    65,     0,   107,     0,    81,     3,    64,
    95,    65,     0,   108,     0,    81,    86,    40,    43,   127,
    64,    95,    65,     0,    86,    40,    43,    81,    64,    65,
     0,    81,     3,    40,    43,   127,    64,    95,    65,     0,
     3,    40,    43,    81,    64,    65,     0,    81,    43,   127,
    64,    95,    65,     0,    43,    81,    64,    65,     0,     0,
    44,     0,     0,    18,    64,   111,    65,     0,    81,     0,
   111,    63,    81,     0,    66,     3,    64,    65,     0,    86,
    40,    66,     3,    64,    65,     0,     3,    40,    66,     3,
    64,    65,     0,     3,    56,   148,    57,    40,    66,     3,
    64,    65,     0,    86,    56,   148,    57,    40,    66,     3,
    64,    65,     0,     3,    64,    95,    65,   110,     0,    86,
    64,    95,    65,   110,     0,     3,    56,   148,    57,    40,
     3,    64,    95,    65,   110,     0,    86,    56,   148,    57,
    40,     3,    64,    95,    65,   110,     0,     0,    67,   117,
    68,     0,    48,    67,   119,    68,     0,    48,     3,    67,
   119,    68,     0,    48,     3,     0,   120,     0,   119,    63,
   120,     0,     3,     0,     3,    62,   128,     0,     0,   123,
     0,   123,    61,     0,   122,   123,    61,     0,    51,     0,
    50,     0,    49,     0,    55,     0,    58,     0,    69,     0,
    70,     0,    66,     0,    71,     0,    72,     0,    73,     0,
    74,     0,    75,     0,    56,     0,    57,     0,    63,     0,
    62,     0,    30,     0,    31,     0,    32,     0,    33,     0,
    34,     0,    35,     0,    36,     0,    37,     0,    38,     0,
    39,     0,   126,     0,   124,     0,   125,     0,    15,     0,
    16,     0,    19,     0,    41,     0,    20,     0,    21,     0,
    22,     0,    23,     0,    24,     0,    25,     0,    26,     0,
    27,     0,    28,     0,    29,     0,    59,    60,     0,    64,
    65,     0,   129,     0,   116,     0,   132,     0,     4,     0,
    70,     4,     0,     5,     0,     3,     0,    86,     0,    64,
   129,    65,     0,   130,     0,   131,    58,   130,     0,   131,
    72,   130,     0,   131,    73,   130,     0,   131,     0,   132,
    69,   131,     0,   132,    70,   131,     0,    47,     3,    67,
    94,    68,     0,    47,    67,    94,    68,     0,    47,     3,
     0,    45,     3,    67,   138,    68,     0,    45,     3,    61,
   135,    67,   138,    68,     0,   149,    45,     3,    67,   138,
    68,     0,   149,    45,     3,    61,   135,    67,   138,    68,
     0,    46,    67,   138,    68,     0,    46,     3,    67,   138,
    68,     0,    46,     3,    61,   135,    67,   138,    68,     0,
   149,    46,     3,    67,   138,    68,     0,   149,    46,     3,
    61,   135,    67,   138,    68,     0,   136,     0,   135,    63,
   136,     0,   121,    81,     0,    42,   104,     0,    42,    82,
     0,     0,   139,     0,   141,     0,   139,   141,     0,   142,
     0,     1,     0,   140,     0,   122,   140,     0,   143,    54,
     0,   137,    54,     0,   101,     0,    54,     0,    93,     0,
   104,     0,    52,   104,     0,   104,    62,     4,     0,   144,
     0,    79,     0,    79,     3,     0,   144,    59,    60,     0,
   144,    59,   128,    60,     0,    45,     3,     0,    81,     3,
     0,   145,     0,   146,    63,   145,     0,     4,     0,    81,
     0,   147,     0,   148,    63,   147,     0,    17,    56,   146,
    57,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   415,   416,   420,   421,   426,   433,   441,   442,   456,   471,
   475,   482,   489,   493,   494,   498,   507,   517,   518,   519,
   520,   524,   525,   526,   534,   542,   550,   559,   568,   576,
   584,   592,   593,   604,   605,   614,   626,   627,   628,   634,
   635,   636,   642,   648,   655,   656,   657,   658,   662,   670,
   682,   683,   695,   696,   700,   709,   718,   729,   742,   743,
   747,   748,   756,   764,   775,   776,   777,   785,   790,   801,
   808,   819,   823,   827,   836,   848,   849,   850,   855,   863,
   872,   882,   893,   906,   907,   909,   909,   916,   918,   927,
   928,   930,   933,   939,   940,   944,   950,   951,   956,   963,
   975,   981,   988,   992,  1003,  1015,  1026,  1041,  1051,  1064,
  1065,  1069,  1070,  1080,  1081,  1092,  1105,  1117,  1129,  1141,
  1156,  1167,  1175,  1188,  1204,  1205,  1208,  1215,  1223,  1233,
  1234,  1245,  1246,  1257,  1258,  1262,  1263,  1267,  1268,  1269,
  1273,  1274,  1275,  1276,  1277,  1278,  1282,  1283,  1284,  1285,
  1286,  1287,  1288,  1292,  1293,  1294,  1295,  1296,  1297,  1298,
  1299,  1300,  1301,  1302,  1306,  1307,  1308,  1309,  1310,  1311,
  1312,  1313,  1314,  1315,  1316,  1317,  1318,  1319,  1320,  1321,
  1322,  1323,  1324,  1328,  1329,  1333,  1337,  1338,  1345,  1346,
  1347,  1348,  1358,  1359,  1367,  1375,  1386,  1387,  1395,  1407,
  1415,  1422,  1432,  1445,  1458,  1472,  1486,  1500,  1513,  1526,
  1540,  1557,  1558,  1562,  1566,  1567,  1571,  1572,  1576,  1583,
  1595,  1596,  1611,  1612,  1616,  1617,  1618,  1619,  1623,  1630,
  1631,  1632,  1633,  1637,  1638,  1639,  1640,  1648,  1655,  1666,
  1667,  1678,  1679,  1683,  1684,  1695
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","IDENTIFIER",
"CONSTANT","STRING_LITERAL","CHAR","SHORT","INT","LONG","SIGNED","UNSIGNED",
"FLOAT","DOUBLE","VOID","NEW","DELETE","TEMPLATE","THROW","PTR_OP","INC_OP",
"DEC_OP","LEFT_OP","RIGHT_OP","LE_OP","GE_OP","EQ_OP","NE_OP","AND_OP","OR_OP",
"MUL_ASSIGN","DIV_ASSIGN","MOD_ASSIGN","ADD_ASSIGN","SUB_ASSIGN","LEFT_ASSIGN",
"RIGHT_ASSIGN","AND_ASSIGN","XOR_ASSIGN","OR_ASSIGN","CLCL","MEM_PTR_OP","FRIEND",
"OPERATOR","CONST","CLASS","STRUCT","UNION","ENUM","PROTECTED","PRIVATE","PUBLIC",
"EXTERN","ELIPSIS","';'","'&'","'<'","'>'","'*'","'['","']'","':'","'='","','",
"'('","')'","'~'","'{'","'}'","'+'","'-'","'!'","'/'","'%'","'^'","'|'","translation_unit",
"declaration","declaration_specifiers","type_specifier","ampersand_opt","type_name",
"forward_decl","non_reference_type","simple_signed_type","simple_type_name",
"scoped_identifier","pointer","asterisk","variable_or_parameter","bitfield_savvy_identifier",
"variable_name","variable_specifier","multiple_variable_specifier","variable_specifier_list",
"parameter_list_opt","parameter_list","unnamed_parameter","function_skeleton",
"@1","@2","member_func_inlined","@3","member_func_skel","member_func_specifier",
"member_func_skel_spec","function_specifier","overloaded_op_skeleton","overloaded_op_specifier",
"const_opt","throw_decl","throw_list","destructor","destructor_skeleton","constructor",
"constructor_skeleton","compound_statement","@4","enum_specifier","enumerator_list",
"enumerator","access_specifier_opt","access_specifier_list","access_specifier",
"unary_operator","binary_operator","assignment_operator","any_operator","constant_value",
"expression","primary_expression","multiplicative_expression","additive_expression",
"union_specifier","class_specifier","superclass_list","superclass","friend_specifier",
"member_list_opt","member_list","member_or_error","member_with_access","member",
"member_specifier","mem_type_specifier","template_arg","template_arg_list","template_instance_arg",
"template_instance_arg_list","template_specifier", NULL
};
#endif

static const short yyr1[] = {     0,
    76,    76,    77,    77,    77,    77,    77,    77,    78,    78,
    79,    79,    79,    80,    80,    81,    81,    82,    82,    82,
    82,    83,    83,    83,    83,    83,    83,    83,    83,    83,
    83,    83,    83,    84,    84,    84,    85,    85,    85,    85,
    85,    85,    85,    85,    85,    85,    85,    85,    86,    86,
    87,    87,    88,    88,    89,    89,    89,    89,    90,    90,
    91,    91,    91,    91,    92,    92,    92,    93,    93,    94,
    94,    95,    95,    95,    95,    96,    96,    96,    96,    97,
    97,    97,    97,    98,    99,    98,    98,   100,    98,   101,
   102,   101,   103,   103,   103,   104,   104,   104,   105,   105,
   105,   106,   106,   107,   107,   107,   107,   108,   108,   109,
   109,   110,   110,   111,   111,   112,   113,   113,   113,   113,
   114,   115,   115,   115,   117,   116,   118,   118,   118,   119,
   119,   120,   120,   121,   121,   122,   122,   123,   123,   123,
   124,   124,   124,   124,   124,   124,   125,   125,   125,   125,
   125,   125,   125,   126,   126,   126,   126,   126,   126,   126,
   126,   126,   126,   126,   127,   127,   127,   127,   127,   127,
   127,   127,   127,   127,   127,   127,   127,   127,   127,   127,
   127,   127,   127,   128,   128,   129,   130,   130,   130,   130,
   130,   130,   131,   131,   131,   131,   132,   132,   132,   133,
   133,   133,   134,   134,   134,   134,   134,   134,   134,   134,
   134,   135,   135,   136,   137,   137,   138,   138,   139,   139,
   140,   140,   141,   141,   142,   142,   142,   142,   143,   143,
   143,   143,   143,   144,   144,   144,   144,   145,   145,   146,
   146,   147,   147,   148,   148,   149
};

static const short yyr2[] = {     0,
     1,     2,     2,     3,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     0,     1,     2,     3,     2,     2,     2,
     2,     1,     1,     2,     4,     4,     5,     5,     2,     2,
     3,     1,     2,     1,     2,     2,     1,     1,     2,     1,
     1,     2,     2,     3,     1,     1,     1,     1,     3,     3,
     1,     2,     1,     2,     2,     2,     4,     3,     1,     3,
     1,     2,     4,     3,     1,     2,     3,     1,     3,     2,
     3,     0,     1,     3,     1,     1,     1,     3,     3,     1,
     3,     4,     3,     2,     0,     4,     3,     0,     5,     2,
     0,     4,     3,     1,     1,     3,     1,     1,     5,    10,
     1,     5,     1,     8,     6,     8,     6,     6,     4,     0,
     1,     0,     4,     1,     3,     4,     6,     6,     9,     9,
     5,     5,    10,    10,     0,     3,     4,     5,     2,     1,
     3,     1,     3,     0,     1,     2,     3,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     2,     2,     1,     1,     1,     1,     2,     1,     1,
     1,     3,     1,     3,     3,     3,     1,     3,     3,     5,
     4,     2,     5,     7,     6,     8,     4,     5,     7,     6,
     8,     1,     3,     2,     2,     2,     0,     1,     1,     2,
     1,     1,     1,     2,     2,     2,     1,     1,     1,     1,
     2,     3,     1,     1,     2,     3,     4,     2,     2,     1,
     3,     1,     1,     1,     3,     4
};

static const short yydefact[] = {     0,
     8,    23,    37,    38,    40,    41,     0,    45,    46,    47,
    48,     0,     0,     0,     0,     0,     0,     0,     0,     7,
     0,     0,     1,     0,   234,     0,    10,    14,    32,    34,
    22,    65,    68,   229,     6,     5,     0,   230,   110,   110,
   101,   103,    98,    95,    97,    94,    12,    11,    13,     9,
   233,     0,     0,     0,    53,    72,    30,    51,    39,    42,
    43,    45,    35,    36,     0,    23,     0,     0,    22,    14,
    18,    19,    24,     0,    21,   202,     0,   129,     0,    23,
     0,     0,    66,   231,    97,     0,     2,     3,   235,    59,
     0,    56,    55,    15,    16,    33,     0,     0,    72,    29,
     0,     0,     0,   125,    84,     0,    90,   111,   112,   112,
    91,    85,     0,    23,     0,     0,     0,     0,    94,    49,
     0,     0,   242,   243,   244,     0,    54,     0,    75,    80,
    76,     0,    73,    77,    52,    44,     0,     0,   240,     0,
     0,     0,    24,     0,     0,     0,    17,   134,     0,   134,
     0,    31,   222,     0,     0,     0,   140,   139,   138,     0,
   228,   227,     0,     0,     0,     0,     0,   223,   219,   221,
     0,     0,     0,     0,     0,     0,     0,   132,     0,   130,
     4,    59,    56,     0,     0,     0,     0,    72,   168,   169,
   170,   172,   173,   174,   175,   176,   177,   178,   179,   180,
   181,   155,   156,   157,   158,   159,   160,   161,   162,   163,
   164,   171,   141,   151,   152,   142,     0,   154,   153,     0,
   145,   143,   144,   146,   147,   148,   149,   150,   166,   167,
   165,     0,     0,    72,    50,     0,     0,     0,     0,   190,
   187,   189,    58,     0,     0,   191,   185,     0,   184,   193,
   197,   186,    67,    59,     0,    61,    69,     0,   232,     0,
    93,    96,     0,     0,   236,     0,     0,    24,     0,     0,
    87,    88,     0,     0,    26,     0,    59,     0,   112,     0,
     0,   238,   239,   246,     0,     0,   109,     0,     0,   135,
     0,   212,     0,     0,     0,     0,     0,     0,   216,   215,
     0,    24,     0,   224,   136,   226,   207,   220,   225,     0,
     0,    70,   201,     0,     0,     0,     0,   127,   116,     0,
     0,    60,     0,   182,   183,    72,     0,     0,     0,     0,
    25,   112,     0,   188,    57,     0,     0,     0,     0,     0,
    62,     0,   126,     0,    92,    86,   237,   134,     0,   134,
     0,     0,     0,     0,     0,    28,   245,    81,   121,    74,
    78,    79,    83,     0,   241,    26,    25,   214,   134,     0,
   203,     0,   208,    18,    24,     0,   137,     0,   200,    71,
   128,   133,   131,     0,     0,   102,     0,     0,    99,     0,
     0,     0,    27,   122,   192,   194,   195,   196,   198,   199,
    64,     0,   114,     0,     0,     0,     0,     0,    89,   107,
   118,     0,     0,    82,   213,     0,     0,    72,     0,   108,
    72,   105,   117,     0,     0,    63,     0,   113,     0,   205,
     0,   210,    72,     0,   204,   209,     0,     0,     0,    72,
     0,   115,     0,     0,     0,     0,   106,    72,   104,     0,
     0,   206,   211,   112,   119,     0,   112,   120,   123,   100,
   124,     0,     0
};

static const short yydefgoto[] = {    22,
    23,    24,    25,    95,    82,    27,    28,    29,    30,    69,
   152,    58,    32,    93,   257,    33,    34,   176,   132,   133,
   134,    35,   264,   352,   162,   263,    37,    38,    39,    40,
    41,    42,   109,   261,   404,    43,    44,    45,    46,   247,
   258,    47,   179,   180,   289,   163,   164,   229,   230,   231,
   232,   248,   249,   250,   251,   252,    48,    49,   291,   292,
   165,   166,   167,   168,   169,   170,   171,    51,   139,   140,
   125,   126,   172
};

static const short yypact[] = {   598,
-32768,   138,-32768,    26,-32768,   162,   301,   301,-32768,-32768,
-32768,    -3,   874,   886,    75,    17,    18,    20,   154,-32768,
   114,   522,-32768,    85,   180,    37,-32768,   140,   161,-32768,
   159,   123,-32768,   172,-32768,-32768,   208,   166,   250,   250,
-32768,-32768,-32768,-32768,   222,   243,-32768,-32768,-32768,-32768,
   268,   534,     4,   818,   286,   758,   161,-32768,-32768,-32768,
   340,-32768,-32768,-32768,   830,   212,   347,   294,   223,   140,
   108,   319,    82,   443,   319,   295,   686,   297,   362,   209,
   208,    40,   308,-32768,-32768,   306,-32768,-32768,-32768,   116,
   721,    15,-32768,-32768,-32768,   161,    38,   818,   758,   161,
    33,    56,     8,-32768,-32768,   367,-32768,-32768,   354,   354,
-32768,-32768,    71,   234,   371,   372,   373,   208,   316,-32768,
   874,   376,-32768,-32768,-32768,    62,-32768,   874,-32768,    27,
-32768,   315,   318,   323,-32768,-32768,   380,   381,-32768,   198,
   383,   818,   161,   322,   385,   818,-32768,   296,   443,   296,
   443,   161,-32768,   660,   386,    29,-32768,-32768,-32768,   673,
-32768,-32768,   583,   329,   337,   324,   507,-32768,-32768,-32768,
   341,   163,   686,   393,    61,   391,   362,   344,   175,-32768,
-32768,   149,   319,   343,    43,   818,   405,   758,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,   351,-32768,-32768,   348,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,   350,    59,   758,-32768,   874,   409,   259,   352,   375,
-32768,-32768,-32768,    24,   412,   319,-32768,   359,-32768,-32768,
   228,   284,-32768,   361,    32,-32768,   364,   356,-32768,   365,
-32768,-32768,   208,   208,-32768,   360,    -4,   226,    52,    15,
-32768,-32768,   366,   368,    72,   818,   153,    56,   354,   806,
   187,-32768,-32768,-32768,   830,   260,-32768,   262,   874,-32768,
   193,-32768,   363,   232,   370,   425,   431,    64,-32768,-32768,
   267,   230,   378,-32768,-32768,-32768,-32768,-32768,-32768,   433,
   610,-32768,-32768,   158,   190,    56,   362,-32768,-32768,   721,
   274,-32768,   377,-32768,-32768,   758,   721,   382,   394,   397,
   192,   354,   398,-32768,-32768,    24,    24,    24,    24,    24,
-32768,   202,-32768,   874,-32768,-32768,-32768,   296,   443,   296,
   443,   208,   399,   407,    45,   161,-32768,-32768,-32768,-32768,
-32768,   323,-32768,   402,-32768,   161,   161,-32768,   296,   443,
-32768,   443,-32768,   375,   224,   406,-32768,   271,-32768,-32768,
-32768,-32768,-32768,   410,   401,-32768,   408,   411,-32768,   413,
   414,    48,   161,-32768,-32768,-32768,-32768,-32768,   228,   228,
-32768,   416,-32768,   255,   239,   415,   272,   428,-32768,-32768,
-32768,   417,   474,-32768,-32768,   430,   432,   758,   477,-32768,
   758,-32768,-32768,   418,   481,-32768,   874,-32768,   443,-32768,
   443,-32768,   758,   435,-32768,-32768,   436,   438,   439,   758,
   441,-32768,   444,   458,   442,   462,-32768,   758,-32768,   473,
   495,-32768,-32768,   354,-32768,   497,   354,-32768,-32768,-32768,
-32768,   503,-32768
};

static const short yypgoto[] = {-32768,
   484,-32768,-32768,   493,     0,   423,   550,-32768,   333,   129,
     2,   -51,   -10,   468,-32768,   -55,   -67,   429,   -97,-32768,
   292,-32768,-32768,-32768,    42,-32768,   529,    -7,-32768,-32768,
-32768,-32768,   542,  -105,-32768,-32768,-32768,    -2,   531,   -23,
-32768,-32768,   421,   270,-32768,-32768,  -124,-32768,-32768,-32768,
  -193,   -94,   392,    19,    21,-32768,-32768,-32768,  -147,   216,
-32768,  -133,-32768,   440,   447,-32768,    50,-32768,   353,-32768,
   379,   -73,   110
};


#define	YYLAST		932


static const short yytable[] = {    26,
   131,   239,   294,    57,   262,   135,   120,   253,    83,   175,
   254,    84,    68,   105,   107,   293,    85,   295,   266,    73,
    76,    26,    78,   290,   238,   290,   240,   241,   242,   277,
    96,   302,   100,    59,   341,   240,   241,   242,   303,    90,
   235,    36,   182,   131,   135,   120,   121,   412,   135,    50,
   424,   117,    65,   124,   233,   130,   348,   181,   240,   241,
   242,   235,   349,    36,   138,    55,   376,    57,   286,   122,
   100,    50,   288,   240,   241,   242,   174,    71,   234,    91,
   236,    57,    91,    74,    77,   320,    79,   244,   278,    55,
   323,   185,   243,   245,   271,    74,   244,   124,   130,   104,
   135,   327,   245,   237,   255,   175,    91,   186,   314,    52,
   413,   355,   321,   425,   312,    57,    86,    83,   275,   244,
   273,   141,   104,   103,   276,   245,   384,   174,    31,    55,
   265,    52,   131,   388,   244,   -20,   328,   104,    88,    55,
   245,   124,   150,    72,    75,   124,   300,   141,   151,    83,
    31,    85,    84,   298,    92,   185,    80,    85,    81,     3,
     4,     5,     6,     7,     8,     9,    10,    11,   148,    60,
    61,   186,   174,   359,   149,   174,   187,    53,   131,   188,
    31,   101,    89,   358,   102,   124,   364,   130,   141,   240,
   241,   242,   141,    54,    94,    55,    13,    14,    97,    67,
   405,    56,   407,   135,   240,   241,   242,   115,   310,   187,
   183,   380,   188,   187,    98,   406,    55,   408,    55,    21,
   103,   382,    99,   290,   361,   290,   394,   106,   387,   246,
   246,   392,   104,   130,   103,   329,   416,   317,   417,   345,
   346,   246,   318,   314,   290,   270,   363,   402,   141,    55,
   244,   141,   317,   104,   284,   369,   245,   381,   183,   370,
   285,   401,   145,   141,   142,   244,    55,   142,   104,    55,
   131,   245,    56,    53,   104,   124,   356,   -20,   146,   130,
    55,    55,   111,    55,   138,   336,   350,    55,   368,    54,
   150,    55,   351,   108,   369,   443,   151,   444,   372,   337,
   338,   369,   183,   112,   135,   429,     3,     4,     5,     6,
   174,    62,     9,    10,    11,   331,   366,   427,   367,   428,
   437,   276,   276,   439,   276,   130,   113,   148,   409,   127,
   385,   350,   393,   149,   369,   445,   276,   351,   431,    63,
    64,   135,   450,   403,   157,   158,   159,   136,   459,   143,
   456,   461,   339,   340,   396,   397,   398,   144,   145,   399,
   400,   173,   131,   177,   178,   131,   101,   356,   393,   184,
   259,   260,   246,   267,   268,   269,   272,   131,   274,   279,
   280,   281,   282,   283,   131,   120,   287,   235,   301,   305,
   306,   307,   131,    66,   309,   277,     3,     4,     5,     6,
     7,     8,     9,    10,    11,   316,   246,   319,   322,   246,
   324,   330,   325,   326,   141,   334,   332,   130,   335,   347,
   130,   187,   342,   343,    72,    75,   442,   374,   344,   353,
   371,   354,   130,   375,    14,   378,    67,   373,   377,   130,
   419,   386,   128,   153,   246,    80,   389,   130,     3,     4,
     5,     6,     7,     8,     9,    10,    11,   390,   313,    12,
   391,   414,   395,   410,   246,   246,   246,   246,   246,   188,
   246,   411,   420,   418,   421,   426,   434,   422,   423,   438,
   433,   440,   430,   441,   154,    13,    14,   155,   156,    17,
    18,   157,   158,   159,   160,   432,   161,   435,   446,   436,
   447,   448,   463,   449,   451,    87,   454,   153,    21,    80,
  -217,   452,     3,     4,     5,     6,     7,     8,     9,    10,
    11,   462,     1,    12,     2,   453,   455,     3,     4,     5,
     6,     7,     8,     9,    10,    11,   114,   457,    12,     3,
     4,     5,     6,     7,     8,     9,    10,    11,   154,    13,
    14,   155,   156,    17,    18,   157,   158,   159,   160,   458,
   161,   460,   147,    70,    13,    14,    15,    16,    17,    18,
   256,   362,    21,    19,  -218,    20,   299,    14,   115,   116,
   118,   110,   119,   153,   415,    80,   383,    21,     3,     4,
     5,     6,     7,     8,     9,    10,    11,   315,     1,    12,
     2,   311,   304,     3,     4,     5,     6,     7,     8,     9,
    10,    11,    66,   308,    12,     3,     4,     5,     6,     7,
     8,     9,    10,    11,   154,    13,    14,   155,   156,    17,
    18,   157,   158,   159,   160,   333,   161,   365,     0,     0,
    13,    14,    15,    16,    17,    18,     0,     0,    21,    19,
     0,    20,     0,    14,   357,    67,     0,     0,     0,     0,
     0,   128,    80,    21,     0,     3,     4,     5,     6,     7,
     8,     9,    10,    11,     0,    80,     0,   379,     3,     4,
     5,     6,     7,     8,     9,    10,    11,     0,    66,     0,
     0,     3,     4,     5,     6,     7,     8,     9,    10,    11,
     0,     0,    13,    14,   296,   297,     0,     0,     0,     0,
     0,     0,     0,     0,     0,    13,    14,     0,    67,     0,
     0,     0,     0,     0,     0,    21,     0,     0,     0,    14,
     0,    67,     0,     0,     0,   189,   190,   128,    21,   191,
   192,   193,   194,   195,   196,   197,   198,   199,   200,   201,
   202,   203,   204,   205,   206,   207,   208,   209,   210,   211,
    66,   212,     0,     3,     4,     5,     6,     7,     8,     9,
    10,    11,     0,     0,     0,   213,   214,   215,   216,   217,
     0,     0,   218,   219,   220,     0,   221,     0,     0,   222,
   223,   224,   225,   226,   227,   228,     0,     0,     0,     0,
     0,    14,     0,    67,     0,     0,     0,     0,    66,   128,
   129,     3,     4,     5,     6,     7,     8,     9,    10,    11,
    66,   123,     0,     3,     4,     5,     6,     7,     8,     9,
    10,    11,    66,     0,     0,     3,     4,     5,     6,     7,
     8,     9,    10,    11,     0,     0,     0,     0,     0,    14,
     0,    67,     0,     0,     0,     0,     0,   128,   360,     0,
     0,    14,     0,    67,     0,     0,     0,     0,     0,     0,
     0,     0,     0,    14,   137,    67,    66,     0,     0,     3,
     4,     5,     6,     7,     8,     9,    10,    11,    66,     0,
     0,     3,     4,     5,     6,     7,     8,     9,    10,    11,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,    14,     0,    67,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,    67
};

static const short yycheck[] = {     0,
    56,    99,   150,     2,   110,    57,     3,   102,    19,    77,
     3,    19,    13,    37,    38,   149,    19,   151,   113,     3,
     3,    22,     3,   148,    98,   150,     3,     4,     5,     3,
    29,     3,    31,     8,     3,     3,     4,     5,   163,     3,
     3,     0,     3,    99,    96,     3,    43,     3,   100,     0,
     3,    52,    56,    54,    40,    56,    61,    81,     3,     4,
     5,     3,    67,    22,    65,    58,     3,    66,   142,    66,
    69,    22,   146,     3,     4,     5,    77,     3,    64,    43,
    43,    80,    43,    67,    67,    43,    67,    64,    62,    58,
   188,    40,    60,    70,   118,    67,    64,    98,    99,    67,
   152,    43,    70,    66,   103,   173,    43,    56,   176,     0,
    66,    40,   186,    66,    54,   114,     3,   128,    57,    64,
   121,    40,    67,    63,    63,    70,   320,   128,     0,    58,
    60,    22,   188,   327,    64,    54,   234,    67,    54,    58,
    70,   142,    61,    15,    16,   146,   154,    40,    67,   160,
    22,   154,   160,   154,    26,    40,     3,   160,     5,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    61,     8,
     9,    56,   173,   279,    67,   176,    61,    40,   234,    64,
    52,    59,     3,   278,    62,   186,   281,   188,    40,     3,
     4,     5,    40,    56,    55,    58,    43,    44,    40,    46,
   348,    64,   350,   255,     3,     4,     5,    45,    46,    61,
    82,    54,    64,    61,    56,   349,    58,   351,    58,    66,
    63,   316,    64,   348,   280,   350,   332,    62,   326,   101,
   102,    40,    67,   234,    63,   236,   370,    63,   372,   263,
   264,   113,    68,   311,   369,   117,    60,   342,    40,    58,
    64,    40,    63,    67,    57,    63,    70,    68,   130,    67,
    63,    60,    40,    40,    56,    64,    58,    56,    67,    58,
   326,    70,    64,    40,    67,   276,   275,    54,    56,   280,
    58,    58,    61,    58,   285,    58,    61,    58,   289,    56,
    61,    58,    67,    44,    63,   429,    67,   431,    67,    72,
    73,    63,   174,    61,   356,    67,     6,     7,     8,     9,
   311,    11,    12,    13,    14,    57,    57,    63,    57,    65,
   418,    63,    63,   421,    63,   326,    59,    61,   352,    44,
    57,    61,   331,    67,    63,   433,    63,    67,    67,     7,
     8,   393,   440,   344,    49,    50,    51,     8,   454,     3,
   448,   457,    69,    70,   336,   337,   338,    64,    40,   339,
   340,    67,   418,    67,     3,   421,    59,   366,   367,    64,
     4,    18,   244,     3,     3,     3,    61,   433,     3,    65,
    63,    59,     3,     3,   440,     3,    65,     3,     3,    61,
    54,    68,   448,     3,    54,     3,     6,     7,     8,     9,
    10,    11,    12,    13,    14,    62,   278,    65,     4,   281,
    60,     3,    65,    64,    40,     4,    65,   418,    60,    60,
   421,    61,    59,    68,   296,   297,   427,     3,    64,    64,
    68,    64,   433,     3,    44,     3,    46,    68,    61,   440,
    40,    65,    52,     1,   316,     3,    65,   448,     6,     7,
     8,     9,    10,    11,    12,    13,    14,    64,    68,    17,
    64,    60,    65,    65,   336,   337,   338,   339,   340,    64,
   342,    65,    65,    64,    64,    60,     3,    65,    65,     3,
    64,    64,    68,     3,    42,    43,    44,    45,    46,    47,
    48,    49,    50,    51,    52,    68,    54,    68,    64,    68,
    65,    64,     0,    65,    64,    22,    65,     1,    66,     3,
    68,    68,     6,     7,     8,     9,    10,    11,    12,    13,
    14,     0,     1,    17,     3,    68,    65,     6,     7,     8,
     9,    10,    11,    12,    13,    14,     3,    65,    17,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    42,    43,
    44,    45,    46,    47,    48,    49,    50,    51,    52,    65,
    54,    65,    70,    14,    43,    44,    45,    46,    47,    48,
   103,   280,    66,    52,    68,    54,   154,    44,    45,    46,
    52,    40,    52,     1,   369,     3,   317,    66,     6,     7,
     8,     9,    10,    11,    12,    13,    14,   177,     1,    17,
     3,   173,   163,     6,     7,     8,     9,    10,    11,    12,
    13,    14,     3,   167,    17,     6,     7,     8,     9,    10,
    11,    12,    13,    14,    42,    43,    44,    45,    46,    47,
    48,    49,    50,    51,    52,   244,    54,   285,    -1,    -1,
    43,    44,    45,    46,    47,    48,    -1,    -1,    66,    52,
    -1,    54,    -1,    44,   276,    46,    -1,    -1,    -1,    -1,
    -1,    52,     3,    66,    -1,     6,     7,     8,     9,    10,
    11,    12,    13,    14,    -1,     3,    -1,    68,     6,     7,
     8,     9,    10,    11,    12,    13,    14,    -1,     3,    -1,
    -1,     6,     7,     8,     9,    10,    11,    12,    13,    14,
    -1,    -1,    43,    44,    45,    46,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    -1,    -1,    43,    44,    -1,    46,    -1,
    -1,    -1,    -1,    -1,    -1,    66,    -1,    -1,    -1,    44,
    -1,    46,    -1,    -1,    -1,    15,    16,    52,    66,    19,
    20,    21,    22,    23,    24,    25,    26,    27,    28,    29,
    30,    31,    32,    33,    34,    35,    36,    37,    38,    39,
     3,    41,    -1,     6,     7,     8,     9,    10,    11,    12,
    13,    14,    -1,    -1,    -1,    55,    56,    57,    58,    59,
    -1,    -1,    62,    63,    64,    -1,    66,    -1,    -1,    69,
    70,    71,    72,    73,    74,    75,    -1,    -1,    -1,    -1,
    -1,    44,    -1,    46,    -1,    -1,    -1,    -1,     3,    52,
    53,     6,     7,     8,     9,    10,    11,    12,    13,    14,
     3,     4,    -1,     6,     7,     8,     9,    10,    11,    12,
    13,    14,     3,    -1,    -1,     6,     7,     8,     9,    10,
    11,    12,    13,    14,    -1,    -1,    -1,    -1,    -1,    44,
    -1,    46,    -1,    -1,    -1,    -1,    -1,    52,    53,    -1,
    -1,    44,    -1,    46,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    44,    45,    46,     3,    -1,    -1,     6,
     7,     8,     9,    10,    11,    12,    13,    14,     3,    -1,
    -1,     6,     7,     8,     9,    10,    11,    12,    13,    14,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    44,    -1,    46,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
    -1,    46
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "/etc/bison.simple"
/* This file comes from bison-1.28.  */

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

#ifndef YYSTACK_USE_ALLOCA
#ifdef alloca
#define YYSTACK_USE_ALLOCA
#else /* alloca not defined */
#ifdef __GNUC__
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi) || (defined (__sun) && defined (__i386)) || (defined (__BEOS__) && defined (__MWERKS__))
#define YYSTACK_USE_ALLOCA
#include <alloca.h>
#else /* not sparc */
/* We think this test detects Watcom and Microsoft C.  */
/* This used to test MSDOS, but that is a bad idea
   since that symbol is in the user namespace.  */
#if (defined (_MSDOS) || defined (_MSDOS_)) && !defined (__TURBOC__)
#if 0 /* No need for malloc.h, which pollutes the namespace;
	 instead, just don't use alloca.  */
#include <malloc.h>
#endif
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
/* I don't know what this was needed for, but it pollutes the namespace.
   So I turned it off.   rms, 2 May 1997.  */
/* #include <malloc.h>  */
 #pragma alloca
#define YYSTACK_USE_ALLOCA
#else /* not MSDOS, or __TURBOC__, or _AIX */
#if 0
#ifdef __hpux /* haible@ilog.fr says this works for HPUX 9.05 and up,
		 and on HPUX 10.  Eventually we can turn this on.  */
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#endif /* __hpux */
#endif
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc */
#endif /* not GNU C */
#endif /* alloca not defined */
#endif /* YYSTACK_USE_ALLOCA not defined */

#ifdef YYSTACK_USE_ALLOCA
#define YYSTACK_ALLOC alloca
#else
#define YYSTACK_ALLOC malloc
#endif

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	goto yyacceptlab
#define YYABORT 	goto yyabortlab
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Define __yy_memcpy.  Note that the size argument
   should be passed with type unsigned int, because that is what the non-GCC
   definitions require.  With GCC, __builtin_memcpy takes an arg
   of type size_t, but it can handle unsigned int.  */

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(TO,FROM,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (to, from, count)
     char *to;
     char *from;
     unsigned int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *to, char *from, unsigned int count)
{
  register char *t = to;
  register char *f = from;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 217 "/etc/bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#ifdef __cplusplus
#define YYPARSE_PARAM_ARG void *YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#else /* not __cplusplus */
#define YYPARSE_PARAM_ARG YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#endif /* not __cplusplus */
#else /* not YYPARSE_PARAM */
#define YYPARSE_PARAM_ARG
#define YYPARSE_PARAM_DECL
#endif /* not YYPARSE_PARAM */

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
#ifdef YYPARSE_PARAM
int yyparse (void *);
#else
int yyparse (void);
#endif
#endif

int
yyparse(YYPARSE_PARAM_ARG)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;
  int yyfree_stacks = 0;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  if (yyfree_stacks)
	    {
#ifndef YYSTACK_USE_ALLOCA
	      free (yyss);
	      free (yyvs);
#ifdef YYLSP_NEEDED
	      free (yyls);
#endif
#endif
	    }
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
#ifndef YYSTACK_USE_ALLOCA
      yyfree_stacks = 1;
#endif
      yyss = (short *) YYSTACK_ALLOC (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss, (char *)yyss1,
		   size * (unsigned int) sizeof (*yyssp));
      yyvs = (YYSTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs, (char *)yyvs1,
		   size * (unsigned int) sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls, (char *)yyls1,
		   size * (unsigned int) sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 4:
#line 422 "parser.y"
{ 
  log_printf("IGNORING extern \"C\" { ... } block.\n");
  free(yyvsp[-1].string);
;
    break;}
case 5:
#line 427 "parser.y"
{ 
    yyvsp[0].elt->kind = INLINED_KIND; 
    log_printf("\nBEGIN matched dec : m_f_i rule --");
    print_se(yyvsp[0].elt); 
    log_printf("END   matched dec : m_f_i rule\n");
;
    break;}
case 6:
#line 434 "parser.y"
{ 
    yyvsp[0].elt->kind = SKEL_KIND; 
    log_printf("\nBEGIN matched dec : function_skeleton rule --");
    print_se(yyvsp[0].elt); 
    enqueue_skeleton(yyvsp[0].elt);
    log_printf("END   matched dec : function_skeleton rule\n");
;
    break;}
case 8:
#line 443 "parser.y"
{
  log_printf("declaration : error.  Attempting to recover...\n");
  yyerrok;
  yyclearin;
  if (error_recovery() != 0) {
      log_printf("ERROR recovery could not complete -- YYABORT.\n");
      YYABORT;
  }
  log_printf("ERROR recovery complete.\n");
;
    break;}
case 9:
#line 457 "parser.y"
{
    /* the name of the rule "member_specifier" might be misleading, but
     * this is either a class, struct, union, enum, global var, global
     * prototype, etc..  */
    if (yyvsp[0].elt->kind == CLASS_KIND || yyvsp[0].elt->kind == STRUCT_KIND) {
	enqueue_class(yyvsp[0].elt);
    } else {
	log_printf("\nIGNORING      dec_spec : mem_spec (%s) --",
		  string_kind(yyvsp[0].elt->kind));
	print_se(yyvsp[0].elt);
	log_printf("END IGNORING  dec_spec : mem_spec (%s)\n",
		  string_kind(yyvsp[0].elt->kind));
    }
;
    break;}
case 11:
#line 476 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), yyvsp[0].string, NULL, IGNORE_KIND);
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 12:
#line 483 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), yyvsp[0].string, NULL, IGNORE_KIND);
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 14:
#line 493 "parser.y"
{ yyval.flag = 0; ;
    break;}
case 15:
#line 494 "parser.y"
{ yyval.flag = 1; ;
    break;}
case 16:
#line 499 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + (yyvsp[0].flag ? 2 : 0) + 1);
  strcpy(tmp_str, yyvsp[-1].string);
  if (yyvsp[0].flag)
    strcat(tmp_str, " &");
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 17:
#line 508 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + (yyvsp[0].flag ? 2 : 0) + 7);
  sprintf(tmp_str, "const %s%s", yyvsp[-1].string, (yyvsp[0].flag ? " &" : ""));
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 18:
#line 517 "parser.y"
{ free(yyvsp[0].string); ;
    break;}
case 19:
#line 518 "parser.y"
{ free(yyvsp[0].string); ;
    break;}
case 20:
#line 519 "parser.y"
{ free(yyvsp[0].string); ;
    break;}
case 21:
#line 520 "parser.y"
{ free(yyvsp[0].string); ;
    break;}
case 24:
#line 527 "parser.y"
{
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 8);
  strcpy(tmp_str, "struct ");
  strcat(tmp_str, yyvsp[0].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 25:
#line 535 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-3].string) + strlen(yyvsp[-1].string) + 3);
  sprintf(tmp_str, "%s<%s>", yyvsp[-3].string, yyvsp[-1].string);
  free(yyvsp[-3].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 26:
#line 543 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-3].string) + strlen(yyvsp[-1].string) + 3);
  sprintf(tmp_str, "%s<%s>", yyvsp[-3].string, yyvsp[-1].string);
  free(yyvsp[-3].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 27:
#line 551 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-4].string) + strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s<%s> %s", yyvsp[-4].string, yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-4].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 28:
#line 560 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-4].string) + strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s<%s> %s", yyvsp[-4].string, yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-4].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 29:
#line 569 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "%s %s", yyvsp[-1].string, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 30:
#line 577 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "%s %s", yyvsp[-1].string, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 31:
#line 585 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 9);
  sprintf(tmp_str, "struct %s %s", yyvsp[-1].string, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 33:
#line 594 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "%s %s", yyvsp[-1].string, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 35:
#line 606 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 8);
  strcpy(tmp_str,"signed ");
  strcat(tmp_str, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 36:
#line 615 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 10);
  strcpy(tmp_str,"unsigned ");
  strcat(tmp_str, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 39:
#line 629 "parser.y"
{ 
  yyval.string = strdup("short int");
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
;
    break;}
case 42:
#line 637 "parser.y"
{ 
  yyval.string = strdup("long int");
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
;
    break;}
case 43:
#line 643 "parser.y"
{ 
  yyval.string = strdup("long long");
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
;
    break;}
case 44:
#line 649 "parser.y"
{ 
  yyval.string = strdup("long long int");
  free(yyvsp[-2].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
;
    break;}
case 49:
#line 663 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s::%s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 50:
#line 671 "parser.y"
{ 
  /* control-Y programming! */
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s::%s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 52:
#line 684 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 1);
  strcpy(tmp_str,yyvsp[-1].string);
  strcat(tmp_str,yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 53:
#line 695 "parser.y"
{ yyval.string = strdup("*"); ;
    break;}
case 54:
#line 696 "parser.y"
{ yyval.string = strdup("*const "); ;
    break;}
case 55:
#line 701 "parser.y"
{ 
  arg_t *new_arg = (arg_t *) malloc(sizeof(arg_t));
  new_arg->type = yyvsp[-1].string;
  new_arg->name = yyvsp[0].string;
  new_arg->array = NULL;
  new_arg->next = NULL;
  yyval.arg = new_arg;
;
    break;}
case 56:
#line 710 "parser.y"
{ 
  arg_t *new_arg = (arg_t *) malloc(sizeof(arg_t));
  new_arg->type = yyvsp[-1].string;
  new_arg->name = yyvsp[0].string;
  new_arg->array = NULL;
  new_arg->next = NULL;
  yyval.arg = new_arg;
;
    break;}
case 57:
#line 719 "parser.y"
{
  char *old_array = yyvsp[-3].arg->array;
  int old_len = old_array ? strlen(old_array) : 0;
  yyvsp[-3].arg->array = (char *) malloc(strlen(yyvsp[-1].string) + old_len + 3);
  sprintf(yyvsp[-3].arg->array, "%s[%s]", old_array ? old_array : "", yyvsp[-1].string);
  free(yyvsp[-1].string);
  if (old_array)
    free(old_array);
  yyval.arg = yyvsp[-3].arg;
;
    break;}
case 58:
#line 730 "parser.y"
{ 
  char *old_array = yyvsp[-2].arg->array;
  int old_len = old_array ? strlen(old_array) : 0;
  yyvsp[-2].arg->array = (char *) malloc(old_len + 3);
  sprintf(yyvsp[-2].arg->array, "%s[]", old_array ? old_array : "");
  if (old_array)
    free(old_array);
  yyval.arg = yyvsp[-2].arg;
;
    break;}
case 60:
#line 743 "parser.y"
{ free(yyvsp[0].string); yyval.string = yyvsp[-2].string;;
    break;}
case 62:
#line 749 "parser.y"
{
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "%s %s", yyvsp[-1].string, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 63:
#line 757 "parser.y"
{
  char *tmp_str = (char *) malloc(strlen(yyvsp[-3].string) + strlen(yyvsp[-1].string) + 3);
  sprintf(tmp_str, "%s[%s]", yyvsp[-3].string, yyvsp[-1].string);
  free(yyvsp[-3].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 64:
#line 765 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + 3);
  strcpy(tmp_str, yyvsp[-2].string);
  strcat(tmp_str, "[]");
  free(yyvsp[-2].string);
  yyval.string = tmp_str;
;
    break;}
case 66:
#line 776 "parser.y"
{ yyval.arg = yyvsp[0].arg; ;
    break;}
case 67:
#line 778 "parser.y"
{
  free(yyvsp[0].string);
  yyval.arg = yyvsp[-2].arg;
;
    break;}
case 68:
#line 786 "parser.y"
{
  yyval.string = args_to_string(yyvsp[0].arg, 0);
  free_args(yyvsp[0].arg);
;
    break;}
case 69:
#line 791 "parser.y"
{
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s, %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 70:
#line 802 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + 2);
  sprintf(tmp_str, "%s;", yyvsp[-1].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 71:
#line 809 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[-1].string) + 3);
  sprintf(tmp_str, "%s\n%s;", yyvsp[-2].string, yyvsp[-1].string);
  free(yyvsp[-2].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 72:
#line 820 "parser.y"
{ 
  yyval.arg = NULL; 
;
    break;}
case 73:
#line 824 "parser.y"
{
  yyval.arg = reverse_arg_list(yyvsp[0].arg);
;
    break;}
case 74:
#line 828 "parser.y"
{
  arg_t *new_arg = (arg_t *) malloc(sizeof(arg_t));
  new_arg->type = strdup("...");
  new_arg->name = NULL;
  new_arg->array = NULL;
  new_arg->next = yyvsp[-2].arg;
  yyval.arg = reverse_arg_list(new_arg);
;
    break;}
case 75:
#line 837 "parser.y"
{
  arg_t *new_arg = (arg_t *) malloc(sizeof(arg_t));
  new_arg->type = strdup("...");
  new_arg->name = NULL;
  new_arg->array = NULL;
  new_arg->next = NULL;
  yyval.arg = new_arg;
;
    break;}
case 78:
#line 851 "parser.y"
{
  yyvsp[0].arg->next = yyvsp[-2].arg;
  yyval.arg = yyvsp[0].arg;
;
    break;}
case 79:
#line 856 "parser.y"
{ 
  yyvsp[0].arg->next = yyvsp[-2].arg;
  yyval.arg = yyvsp[0].arg;
;
    break;}
case 80:
#line 864 "parser.y"
{
  arg_t *new_arg = (arg_t *) malloc(sizeof(arg_t));
  new_arg->type = yyvsp[0].string;
  new_arg->name = NULL;
  new_arg->array = NULL;
  new_arg->next = NULL;
  yyval.arg = new_arg;
;
    break;}
case 81:
#line 873 "parser.y"
{
  arg_t *new_arg = (arg_t *) malloc(sizeof(arg_t));
  new_arg->type = yyvsp[-2].string;
  new_arg->name = NULL;
  new_arg->array = NULL;
  new_arg->next = NULL;
  free(yyvsp[0].string);
  yyval.arg = new_arg;
;
    break;}
case 82:
#line 883 "parser.y"
{
  char *old_array = yyvsp[-3].arg->array;
  int old_len = old_array ? strlen(old_array) : 0;
  yyvsp[-3].arg->array = (char *) malloc(strlen(yyvsp[-1].string) + old_len + 3);
  sprintf(yyvsp[-3].arg->array, "%s[%s]", old_array ? old_array : "", yyvsp[-1].string);
  free(yyvsp[-1].string);
  if (old_array)
    free(old_array);
  yyval.arg = yyvsp[-3].arg;
;
    break;}
case 83:
#line 894 "parser.y"
{ 
  char *old_array = yyvsp[-2].arg->array;
  int old_len = old_array ? strlen(old_array) : 0;
  yyvsp[-2].arg->array = (char *) malloc(old_len + 3);
  sprintf(yyvsp[-2].arg->array, "%s[]", old_array ? old_array : "");
  if (old_array)
    free(old_array);
  yyval.arg = yyvsp[-2].arg;
;
    break;}
case 85:
#line 908 "parser.y"
{ if (collectMemberInitList() != 0) YYERROR; ;
    break;}
case 87:
#line 910 "parser.y"
{
  /* I think this is the correct behavior, but skel_elemcmp is wrong */
  /* $2->templ = $1; */
  free(yyvsp[-2].string);
  yyval.elt = yyvsp[-1].elt;
;
    break;}
case 88:
#line 917 "parser.y"
{ if (collectMemberInitList() != 0) YYERROR; ;
    break;}
case 89:
#line 918 "parser.y"
{ 
  /* I think this is the correct behavior, but skel_elemcmp is wrong */
  /* $2->templ = $1; */
  free(yyvsp[-4].string);
  yyval.elt = yyvsp[-3].elt;
;
    break;}
case 91:
#line 929 "parser.y"
{ if (collectMemberInitList() != 0) YYERROR; ;
    break;}
case 93:
#line 934 "parser.y"
{ 
    yyvsp[-2].elt->const_flag = yyvsp[-1].flag; 
    yyvsp[-2].elt->throw_decl = yyvsp[0].string;
    yyval.elt = yyvsp[-2].elt; 
;
    break;}
case 96:
#line 945 "parser.y"
{ 
    yyvsp[-2].elt->const_flag = yyvsp[-1].flag; 
    yyvsp[-2].elt->throw_decl = yyvsp[0].string;
    yyval.elt = yyvsp[-2].elt; 
;
    break;}
case 99:
#line 957 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(yyvsp[-4].string, yyvsp[-3].string, yyvsp[-1].arg, FUNC_KIND);
/*  print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 100:
#line 964 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(yyvsp[-9].string,
			      (char *) malloc(strlen(yyvsp[-8].string) + strlen(yyvsp[-6].string) + strlen(yyvsp[-3].string) + 5),
			      yyvsp[-1].arg, FUNC_KIND);
  sprintf(elem->name,"%s<%s>::%s", yyvsp[-8].string, yyvsp[-6].string, yyvsp[-3].string);
  free(yyvsp[-8].string);
  free(yyvsp[-6].string);
  free(yyvsp[-3].string);
  yyval.elt = elem;
;
    break;}
case 102:
#line 982 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(yyvsp[-4].string, yyvsp[-3].string, yyvsp[-1].arg, FUNC_KIND);
  print_se(elem);
  yyval.elt = elem;
;
    break;}
case 104:
#line 993 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(yyvsp[-7].string, (char *)malloc(strlen(yyvsp[-6].string) + strlen(yyvsp[-3].string) + 12),
			      yyvsp[-1].arg, FUNC_KIND);
  sprintf(elem->name, "%s::operator%s", yyvsp[-6].string, yyvsp[-3].string);
  free(yyvsp[-6].string);
  free(yyvsp[-3].string);
/*  print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 105:
#line 1004 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *)malloc(strlen(yyvsp[-5].string) + strlen(yyvsp[-2].string) + 13),
			      NULL, FUNC_KIND);
  sprintf(elem->name, "%s::operator %s", yyvsp[-5].string, yyvsp[-2].string);
  free(yyvsp[-5].string);
  free(yyvsp[-2].string);
/*  print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 106:
#line 1016 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(yyvsp[-7].string, (char *)malloc(strlen(yyvsp[-6].string) + strlen(yyvsp[-3].string) + 12),
			      yyvsp[-1].arg, FUNC_KIND);
  sprintf(elem->name, "%s::operator%s", yyvsp[-6].string, yyvsp[-3].string);
  free(yyvsp[-6].string);
  free(yyvsp[-3].string);
/*  print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 107:
#line 1027 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""),
			      (char *)malloc(strlen(yyvsp[-5].string) + strlen(yyvsp[-2].string) + 13),
			      NULL, FUNC_KIND);
  sprintf(elem->name, "%s::operator %s", yyvsp[-5].string, yyvsp[-2].string);
  free(yyvsp[-5].string);
  free(yyvsp[-2].string);
/*  print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 108:
#line 1042 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(yyvsp[-5].string, (char *)malloc(strlen(yyvsp[-3].string) + 9), 
			      yyvsp[-1].arg, FUNC_KIND);
  sprintf(elem->name, "operator%s", yyvsp[-3].string);
  free(yyvsp[-3].string);
  print_se(elem);
  yyval.elt = elem;
;
    break;}
case 109:
#line 1052 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), (char *)malloc(strlen(yyvsp[-2].string) + 10),
			      NULL, FUNC_KIND);
  sprintf(elem->name, "operator %s", yyvsp[-2].string);
  free(yyvsp[-2].string);
  print_se(elem);
  yyval.elt = elem;
;
    break;}
case 110:
#line 1064 "parser.y"
{ yyval.flag = 0; ;
    break;}
case 111:
#line 1065 "parser.y"
{ yyval.flag = 1; ;
    break;}
case 112:
#line 1069 "parser.y"
{ yyval.string = NULL; ;
    break;}
case 113:
#line 1071 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + 8);
  sprintf(tmp_str, "throw(%s)", yyvsp[-1].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 115:
#line 1082 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s, %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 116:
#line 1093 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), (char *) malloc(strlen(yyvsp[-2].string) + 2),
			      NULL, FUNC_KIND);
  sprintf(elem->name,"~%s", yyvsp[-2].string);
  free(yyvsp[-2].string);
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 117:
#line 1106 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *) malloc(strlen(yyvsp[-5].string) + strlen(yyvsp[-2].string) + 4),
			      NULL, FUNC_KIND);
  sprintf(elem->name,"%s::~%s", yyvsp[-5].string, yyvsp[-2].string);
  free(yyvsp[-5].string);
  free(yyvsp[-2].string);
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 118:
#line 1118 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *) malloc(strlen(yyvsp[-5].string) + strlen(yyvsp[-2].string) + 4),
			      NULL, FUNC_KIND);
  sprintf(elem->name,"%s::~%s", yyvsp[-5].string, yyvsp[-2].string);
  free(yyvsp[-5].string);
  free(yyvsp[-2].string);
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 119:
#line 1130 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *) malloc(strlen(yyvsp[-8].string) + strlen(yyvsp[-6].string) + strlen(yyvsp[-2].string) + 6),
			      NULL, FUNC_KIND);
  sprintf(elem->name,"%s<%s>::~%s", yyvsp[-8].string, yyvsp[-6].string, yyvsp[-2].string);
  free(yyvsp[-8].string);
  free(yyvsp[-6].string);
  free(yyvsp[-2].string);
  yyval.elt = elem;
;
    break;}
case 120:
#line 1142 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *) malloc(strlen(yyvsp[-8].string) + strlen(yyvsp[-6].string) + strlen(yyvsp[-2].string) + 6),
			      NULL, FUNC_KIND);
  sprintf(elem->name,"%s<%s>::~%s", yyvsp[-8].string, yyvsp[-6].string, yyvsp[-2].string);
  free(yyvsp[-8].string);
  free(yyvsp[-6].string);
  free(yyvsp[-2].string);
  yyval.elt = elem;
;
    break;}
case 121:
#line 1157 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), yyvsp[-4].string, yyvsp[-2].arg, FUNC_KIND);
  elem->throw_decl = yyvsp[0].string;
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 122:
#line 1168 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), yyvsp[-4].string, yyvsp[-2].arg, FUNC_KIND);
  elem->throw_decl = yyvsp[0].string;
/*  print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 123:
#line 1176 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *) malloc(strlen(yyvsp[-9].string) + strlen(yyvsp[-7].string) + strlen(yyvsp[-4].string) + 5),
			      yyvsp[-2].arg, FUNC_KIND);
  sprintf(elem->name,"%s<%s>::%s", yyvsp[-9].string, yyvsp[-7].string, yyvsp[-4].string);
  free(yyvsp[-9].string);
  free(yyvsp[-7].string);
  free(yyvsp[-4].string);
  elem->throw_decl = yyvsp[0].string;
  yyval.elt = elem;
;
    break;}
case 124:
#line 1189 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), 
			      (char *) malloc(strlen(yyvsp[-9].string) + strlen(yyvsp[-7].string) + strlen(yyvsp[-4].string) + 5),
			      yyvsp[-2].arg, FUNC_KIND);
  sprintf(elem->name,"%s<%s>::%s", yyvsp[-9].string, yyvsp[-7].string, yyvsp[-4].string);
  free(yyvsp[-9].string);
  free(yyvsp[-7].string);
  free(yyvsp[-4].string);
  elem->throw_decl = yyvsp[0].string;
  yyval.elt = elem;
;
    break;}
case 125:
#line 1204 "parser.y"
{ if (collectInlineDef() != 0) YYERROR; ;
    break;}
case 127:
#line 1209 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + 10);
  sprintf(tmp_str, "enum { %s }", yyvsp[-1].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 128:
#line 1216 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-3].string) + strlen(yyvsp[-1].string) + 11);
  sprintf(tmp_str, "enum %s { %s }", yyvsp[-3].string, yyvsp[-1].string);
  free(yyvsp[-3].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 129:
#line 1224 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 6);
  sprintf(tmp_str, "enum %s", yyvsp[0].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 131:
#line 1235 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s, %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 133:
#line 1247 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "%s=%s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 141:
#line 1273 "parser.y"
{ yyval.string = strdup("&"); ;
    break;}
case 142:
#line 1274 "parser.y"
{ yyval.string = strdup("*"); ;
    break;}
case 143:
#line 1275 "parser.y"
{ yyval.string = strdup("+"); ;
    break;}
case 144:
#line 1276 "parser.y"
{ yyval.string = strdup("-"); ;
    break;}
case 145:
#line 1277 "parser.y"
{ yyval.string = strdup("~"); ;
    break;}
case 146:
#line 1278 "parser.y"
{ yyval.string = strdup("!"); ;
    break;}
case 147:
#line 1282 "parser.y"
{ yyval.string = strdup("/"); ;
    break;}
case 148:
#line 1283 "parser.y"
{ yyval.string = strdup("%"); ;
    break;}
case 149:
#line 1284 "parser.y"
{ yyval.string = strdup("^"); ;
    break;}
case 150:
#line 1285 "parser.y"
{ yyval.string = strdup("|"); ;
    break;}
case 151:
#line 1286 "parser.y"
{ yyval.string = strdup("<"); ;
    break;}
case 152:
#line 1287 "parser.y"
{ yyval.string = strdup(">"); ;
    break;}
case 153:
#line 1288 "parser.y"
{ yyval.string = strdup(","); ;
    break;}
case 154:
#line 1292 "parser.y"
{ yyval.string = strdup("="); ;
    break;}
case 155:
#line 1293 "parser.y"
{ yyval.string = strdup("*="); ;
    break;}
case 156:
#line 1294 "parser.y"
{ yyval.string = strdup("/="); ;
    break;}
case 157:
#line 1295 "parser.y"
{ yyval.string = strdup("%="); ;
    break;}
case 158:
#line 1296 "parser.y"
{ yyval.string = strdup("+="); ;
    break;}
case 159:
#line 1297 "parser.y"
{ yyval.string = strdup("-="); ;
    break;}
case 160:
#line 1298 "parser.y"
{ yyval.string = strdup("<<="); ;
    break;}
case 161:
#line 1299 "parser.y"
{ yyval.string = strdup(">>="); ;
    break;}
case 162:
#line 1300 "parser.y"
{ yyval.string = strdup("&="); ;
    break;}
case 163:
#line 1301 "parser.y"
{ yyval.string = strdup("^="); ;
    break;}
case 164:
#line 1302 "parser.y"
{ yyval.string = strdup("|="); ;
    break;}
case 168:
#line 1309 "parser.y"
{ yyval.string = strdup(" new"); ;
    break;}
case 169:
#line 1310 "parser.y"
{ yyval.string = strdup(" delete"); ;
    break;}
case 170:
#line 1311 "parser.y"
{ yyval.string = strdup("->"); ;
    break;}
case 171:
#line 1312 "parser.y"
{ yyval.string = strdup("->*"); ;
    break;}
case 172:
#line 1313 "parser.y"
{ yyval.string = strdup("++"); ;
    break;}
case 173:
#line 1314 "parser.y"
{ yyval.string = strdup("--"); ;
    break;}
case 174:
#line 1315 "parser.y"
{ yyval.string = strdup("<<"); ;
    break;}
case 175:
#line 1316 "parser.y"
{ yyval.string = strdup(">>"); ;
    break;}
case 176:
#line 1317 "parser.y"
{ yyval.string = strdup("<="); ;
    break;}
case 177:
#line 1318 "parser.y"
{ yyval.string = strdup(">="); ;
    break;}
case 178:
#line 1319 "parser.y"
{ yyval.string = strdup("=="); ;
    break;}
case 179:
#line 1320 "parser.y"
{ yyval.string = strdup("!="); ;
    break;}
case 180:
#line 1321 "parser.y"
{ yyval.string = strdup("&&"); ;
    break;}
case 181:
#line 1322 "parser.y"
{ yyval.string = strdup("||"); ;
    break;}
case 182:
#line 1323 "parser.y"
{ yyval.string = strdup("[]"); ;
    break;}
case 183:
#line 1324 "parser.y"
{ yyval.string = strdup("()"); ;
    break;}
case 185:
#line 1329 "parser.y"
{ yyval.string = strdup("{ ... }"); ;
    break;}
case 188:
#line 1339 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "-%s", yyvsp[0].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 192:
#line 1349 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + 3);
  sprintf(tmp_str, "(%s)", yyvsp[-1].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str; 
;
    break;}
case 194:
#line 1360 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s * %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 195:
#line 1368 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s / %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 196:
#line 1376 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s %% %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 198:
#line 1388 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s + %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 199:
#line 1396 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 4);
  sprintf(tmp_str, "%s - %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str; 
;
    break;}
case 200:
#line 1408 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-3].string) + strlen(yyvsp[-1].string) + 12);
  sprintf(tmp_str, "union %s { %s }", yyvsp[-3].string, yyvsp[-1].string);
  free(yyvsp[-3].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 201:
#line 1416 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + 11);
  sprintf(tmp_str, "union { %s }", yyvsp[-1].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
case 202:
#line 1423 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 7);
  sprintf(tmp_str, "union %s", yyvsp[0].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 203:
#line 1433 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-3].string, NULL, CLASS_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 204:
#line 1446 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-5].string, NULL, CLASS_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 205:
#line 1459 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-3].string, NULL, CLASS_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  tmp_elem->templ = yyvsp[-5].string;
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 206:
#line 1473 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-5].string, NULL, CLASS_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  tmp_elem->templ = yyvsp[-7].string;
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 207:
#line 1487 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), "unnamed_struct",
				    NULL, IGNORE_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 208:
#line 1501 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-3].string, NULL, STRUCT_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 209:
#line 1514 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-5].string, NULL, STRUCT_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 210:
#line 1527 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-3].string, NULL, STRUCT_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  tmp_elem->templ = yyvsp[-5].string;
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 211:
#line 1541 "parser.y"
{
  syntaxelem_t *child;
  /* ret_type, name, args, kind */
  syntaxelem_t *tmp_elem = new_elem(strdup(""), yyvsp[-5].string, NULL, STRUCT_KIND);
  tmp_elem->children = reverse_list(yyvsp[-1].elt);
  tmp_elem->templ = yyvsp[-7].string;
  
  for (child = tmp_elem->children; child != NULL; child = child->next)
      child->parent = tmp_elem;

/*   print_se(tmp_elem); */
  yyval.elt = tmp_elem;
;
    break;}
case 214:
#line 1562 "parser.y"
{ free(yyvsp[0].string); ;
    break;}
case 215:
#line 1566 "parser.y"
{ yyvsp[0].elt->kind = IGNORE_KIND; ;
    break;}
case 217:
#line 1571 "parser.y"
{ yyval.elt = NULL; ;
    break;}
case 219:
#line 1577 "parser.y"
{
  if (yyvsp[0].elt != NULL)
    yyvsp[0].elt->next = NULL;
  
  yyval.elt = yyvsp[0].elt; 
;
    break;}
case 220:
#line 1584 "parser.y"
{ 
  if (yyvsp[0].elt != NULL) {
    yyvsp[0].elt->next = yyvsp[-1].elt;
    yyval.elt = yyvsp[0].elt; 
  } else {
    yyval.elt = yyvsp[-1].elt;
  }
;
    break;}
case 222:
#line 1597 "parser.y"
{
  log_printf("member_with_access : error.  Attempting to recover...\n");
  yyerrok;
  yyclearin;
  if (error_recovery() != 0) {
      log_printf("ERROR recovery could not complete -- YYABORT.\n");
      YYABORT;
  }
  log_printf("ERROR recovery complete.\n");
  yyval.elt = NULL;
;
    break;}
case 224:
#line 1612 "parser.y"
{ yyval.elt = yyvsp[0].elt; ;
    break;}
case 226:
#line 1617 "parser.y"
{ yyval.elt = NULL; ;
    break;}
case 227:
#line 1618 "parser.y"
{ yyvsp[0].elt->kind = INLINED_KIND; yyval.elt = yyvsp[0].elt; ;
    break;}
case 228:
#line 1619 "parser.y"
{ yyval.elt = NULL; ;
    break;}
case 229:
#line 1624 "parser.y"
{ 
  /* ret_type, name, args, kind */
  syntaxelem_t *elem = new_elem(strdup(""), yyvsp[0].string, NULL, IGNORE_KIND);
/*   print_se(elem); */
  yyval.elt = elem;
;
    break;}
case 231:
#line 1631 "parser.y"
{ yyval.elt = yyvsp[0].elt; ;
    break;}
case 232:
#line 1632 "parser.y"
{ yyvsp[-2].elt->kind = IGNORE_KIND; free(yyvsp[0].string); yyval.elt = yyvsp[-2].elt; ;
    break;}
case 235:
#line 1638 "parser.y"
{ free(yyvsp[0].string); yyval.elt = yyvsp[-1].elt; ;
    break;}
case 237:
#line 1641 "parser.y"
{
  free(yyvsp[-1].string);
  yyval.elt = yyvsp[-3].elt; 
;
    break;}
case 238:
#line 1649 "parser.y"
{
  char *tmp_str = (char *) malloc(strlen(yyvsp[0].string) + 7);
  sprintf(tmp_str, "class %s", yyvsp[0].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 239:
#line 1656 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + strlen(yyvsp[0].string) + 2);
  sprintf(tmp_str, "%s %s", yyvsp[-1].string, yyvsp[0].string);
  free(yyvsp[-1].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 241:
#line 1668 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s, %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 245:
#line 1685 "parser.y"
{ 
  char *tmp_str = (char *) malloc(strlen(yyvsp[-2].string) + strlen(yyvsp[0].string) + 3);
  sprintf(tmp_str, "%s, %s", yyvsp[-2].string, yyvsp[0].string);
  free(yyvsp[-2].string);
  free(yyvsp[0].string);
  yyval.string = tmp_str;
;
    break;}
case 246:
#line 1696 "parser.y"
{
  char *tmp_str = (char *) malloc(strlen(yyvsp[-1].string) + 12);
  sprintf(tmp_str, "template <%s>", yyvsp[-1].string);
  free(yyvsp[-1].string);
  yyval.string = tmp_str;
;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 543 "/etc/bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;

 yyacceptlab:
  /* YYACCEPT comes here.  */
  if (yyfree_stacks)
    {
#ifndef YYSTACK_USE_ALLOCA
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
#endif
    }
  return 0;

 yyabortlab:
  /* YYABORT comes here.  */
  if (yyfree_stacks)
    {
#ifndef YYSTACK_USE_ALLOCA
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
#endif
    }
  return 1;
}
#line 1704 "parser.y"


static int yyerror(char *s /*UNUSED*/)
{
  if (outfile != NULL)
    fflush(outfile);

  return 0;
}

static int error_recovery()
{
  extern char linebuf[];
  extern int lineno;
  extern int column;
  extern int tokens_seen;

#ifdef SGDEBUG
  log_printf("parse error at line %d, file %s:\n%s\n%*s\n",
	     lineno, currentFile, linebuf, column, "^");
  log_flush();
#endif /* SGDEBUG */

  if (tokens_seen == 0) {
    /*
     * if we've seen no tokens but we're in an error, we must have
     * hit an EOF, either by stdin, or on a file.  Just give up
     * now instead of complaining.
     */
    return -1;

  } else {
    fprintf(stderr, "parse error at line %d, file %s:\n%s\n%*s\n",
	    lineno, currentFile, linebuf, column, "^");
  }

  linebuf[0] = '\0';

  for (;;) {
    int result = yylex();

    if (result <= 0) {
      /* fatal error: Unexpected EOF during parse error recovery */

#ifdef SGDEBUG
      log_printf("EOF in error recovery, line %d, file %s\n",
		 lineno, currentFile);
      log_flush();
#endif /* SGDEBUG */

      fprintf(stderr, "EOF in error recovery, line %d, file %s\n",
	      lineno, currentFile);

      return -1;
    }

    switch(result) {
    case IDENTIFIER:
    case CONSTANT:
    case STRING_LITERAL:
    case CHAR:
    case SHORT:
    case INT:
    case LONG:
    case SIGNED:
    case UNSIGNED:
    case FLOAT:
    case DOUBLE:
    case VOID:
      free(yylval.string);
      break;
    case (int) '{':
      if (collectInlineDef() != 0)
	return -1;
      result = yylex();
      return 0;
    case (int) ';':
      return 0;
    }
  }
}
