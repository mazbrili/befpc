/*
 *  FILE: main.c
 *  AUTH: Michael John Radwin <mjr@acm.org>
 *
 *  DESC: stubgen code generation routines
 *
 *  DATE: Thu Nov 13 13:28:23 PST 1997
 *   $Id: main.c,v 1.1 2002-06-06 22:09:16 ocoursiere Exp $
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
 */

// modified version for the BeFPC project by Olivier Coursière
// Mai-June 2002

#include "table.h"
#include "util.h"
#include "pathname.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <assert.h>

#ifdef WIN32
#include <windows.h> /* defintion of GetUserName(), BOOL, etc. */
#include <lmaccess.h>
#include <malloc.h>  /* defintion of alloca() */
#include "getopt.h"  /* use GNU getopt      */
#else /* !WIN32 */
#include <pwd.h>
#endif /* WIN32 */

/* protos */
static void debug_printf(syntaxelem_t *);
static void generate_skel(syntaxelem_t *);
static void print_function(syntaxelem_t *, syntaxelem_t *);
static void function_hdr(syntaxelem_t *, syntaxelem_t *);
static void file_hdr();
static void scan_and_generate(FILE *);
static void scan_existing_skeleton();

/* duplicating variable names from stubgen.pl */
static const char *OPTS = "hqrivgae:cdbfsn";
int opt_h = 0, opt_q = 0, opt_r = 0, opt_i = 0;
int opt_v = 0, opt_g = 0, opt_a = 0;
int opt_c = 0, opt_d = 0;
int opt_b = 0, opt_f = 0, opt_s = 0, opt_n = 0;
char *opt_e = "cpp";

int using_stdio = 0;
static int new_functions = 0, fileOpened = 0, fileExisted = 0;
static int inform_indent = 0;

#ifdef SGDEBUG
static const char *logfilename = "stubgen.log";
#endif /* SGDEBUG */

FILE *outfile = NULL;
static char *inPath = NULL, *outPath = NULL;
char *currentFile = "";
static const char *lots_of_stars = 
  "***********************************************************************";
static const char *progname = "stubgen";
static const char rcsid[] = "$Id: main.c,v 1.1 2002-06-06 22:09:16 ocoursiere Exp $";
static const char *progver = "2.05";

static const char *copyright =
  "Copyright (c) 1996-1998  Michael John Radwin";

static const char *version_info = 
"Distributed under the GNU General Public License.\n\
See http://www.radwin.org/michael/projects/stubgen/ for more information.\n";

static const char *usage = 
"usage: %s [-hqrivgacd] [-e ext] [-{bfsn}] [infiles]\n\
  OPTIONS\n\
    -h        Display usage information.\n\
    -q        Quiet mode, no status information while generating code.\n\
    -r        Make RCS-style file headers.\n\
    -i        Don't put the #include \"my_file.H\" directive in my_file.cpp\n\
    -v        Display version information.\n\
    -g        Generate dummy return statements for functions.\n\
    -a        Split function arguments over multiple lines.\n\
    -c        Print debugging output with cerrs (#include <iostream.h>).\n\
    -d        Print debugging output with dprintfs (#include <Debug.H>).\n\
    -e ext    Generate source files with extension '.ext' (default '.cpp').\n\
\n\
  METHOD HEADER STYLES\n\
    -b        Block method headers (default).\n\
    -f        Full method headers: like block, but less asterisks.\n\
    -s        Simple method headers: only \"Method\" and \"Descr\" fields.\n\
    -n        No method headers.\n";

// 
static int nbConstructor = 0;

static char *prec_function_name = "";

/* string manipulation functions. Found on the web 
   added for the BeFPC project
*/ 

#define UP_CASE(ch)  ((ch) & 223)   /* turn 6'th least sig. bit ON  */
#define LOW_CASE(ch) ((ch) | 32)    /* turn 6'th least sig. bit OFF */


/* Return the index (pos) of a char in a string or -1 if not found */

int index( s, c)
char *s,c;
{
  unsigned int i = (unsigned int) s + 1;

  while (*s)
    if (*s++ == c)
      return((unsigned int) s - i);

  return(-1);
}

// #include <jaz.h> // OCoursiere : it appears that this header is just need
// to include a min function

int min(int Val1, int Val2)
{
	if (Val1 < Val2)
		return Val1;
	else
		return Val2;
}

/*
Insert a string into another string at a given index position. Note that the
starting position is the index, not the character number like in pascal!.
*/

void jzinsstr(fdestin,fsource,fstart)
char *fdestin;
char *fsource;
int fstart;
{

  int wdlen,wslen;
  int w,wlen,wpad;

  wdlen = strlen(fdestin);	/* get destination string length */
  wslen = strlen(fsource);	/* get source string length */

  wlen = min(fstart,wdlen);	/* don't initially point past destin */

  wpad = fstart - wlen; 	/* get extra length to pad */

  for (w = wlen ; w < fstart ; w ++)	/* pad with blanks if neccessary */
    fdestin[w] = ' ';

  /* start at end of string and move characters to the right */
  /* draw it out if necessary; It's hard to follow if you don't */

  for (w = wdlen + wslen - 1 ; w >= fstart + wslen ; w --)
    fdestin[w] = fdestin[w - wslen];

  for (w = 0 ; w < wslen ; w ++)	/* now insert into the dest string */
    fdestin[w+fstart] = *fsource++;

  fdestin[wslen+wdlen+wpad] = 0;	/* string is bigger, needs NULL */
}


/*
Return the substring of a string.
Specify the String, the starting position, and the number of chars to copy
*/
// OCoursiere : the function i need to cut 'B' in class names
char *jzmidstr(fstr,ffrom,flen)
char *fstr;
int ffrom,flen;
{
  static char wstr[256];		/* static work buffer */
  unsigned int wlen,newlen;

  if ((wlen = strlen(fstr)) < (ffrom+1))	/* don't go beyond string */
    return(0);

  strncpy(wstr, fstr + ffrom, flen);	/* copy into work storage */

  newlen = flen - ffrom + 1;

  if (newlen >= flen)
    wstr[newlen] = 0;

  return(wstr);

}

/* End string manipulation functions */ 

static void generate_skel(syntaxelem_t *elt)
{
    syntaxelem_t *e;
    log_printf("generate_skel called: %s\n", elt->name);
    if (elt->kind != CLASS_KIND && elt->kind != STRUCT_KIND)
	return;
	
    inform_user("%*s==> %s %s", inform_indent, "", 
		(elt->kind == CLASS_KIND ? "class " : "struct"),
		elt->name);
    if (inform_indent == 0)
      inform_user(" (file %s)", inPath);
    else
      inform_user(" (nested class)");
    inform_user("\n");
    inform_indent += 4;

	nbConstructor = 0;	

    for (e = elt->children; e != NULL; e = e->next) {
	if (e->kind == FUNC_KIND) {
	  char *arg_str = args_to_string(e->args, 0);
	    log_printf(">>>>>>> generating %s: %s %s::%s(%s) %s\n",
		      string_kind(e->kind),
		      e->ret_type, elt->name, e->name, arg_str,
		      (e->const_flag) ? "const" : "");
		free(arg_str);
	    print_se(e);
	    print_function(e, elt);
	    e->kind = DONE_FUNC_KIND;
	} else if (e->kind == CLASS_KIND || e->kind == STRUCT_KIND) {
	    /* nested class */
	    char *tmp_str = (char *) malloc(strlen(elt->name) + strlen(e->name) + 3);
	    sprintf(tmp_str, "%s::%s", elt->name, e->name);
	    free(e->name);
	    e->name = tmp_str;

	    log_printf(">>>>>>> generating NESTED %s: %s\n",
		      string_kind(e->kind), e->name);
	    print_se(e);
	    generate_skel(e);
	    free(tmp_str);
	} else {
	    log_printf("------> ignoring   %s: %s\n",
		      string_kind(e->kind), e->name);
	}
    }

    inform_indent -= 4;
    inform_user("%*s==> %s %s", inform_indent, "",
		(elt->kind == CLASS_KIND ? "class " : "struct"),
		elt->name);
    if (inform_indent == 0)
	inform_user(" (%d functions appended to %s)", new_functions, outPath);
    else
	inform_user(" (end nested class)");
    inform_user("\n");

    elt->kind = DONE_CLASS_KIND;
}

// Adapted to generate C++ glue code for the befpc project
static void print_function(syntaxelem_t *elt, syntaxelem_t *classe)
{
    syntaxelem_t *e;
    
    char * test = "P"; 
    
    if (find_skeleton(elt)) 
    {
	    log_printf("find_skeleton() returned true for this elt:\n");
	    print_se(elt);
	    return;
    }

    new_functions++;
    if (!fileOpened) 
    {
		fileOpened = 1;

		if (using_stdio) 
		{
			fileExisted = 0;
		} 
		else 
		{
			/* test for existence */
			outfile = fopen(outPath, "r");
			if (outfile != NULL) 
			{
		    	fileExisted = 1;
			    fclose(outfile);
			}

			/* do the fopen */
			log_printf("writing to %s\n", outPath);
			outfile = fopen(outPath, "a");
			if (outfile == NULL) 
			{
				/* open failed */
				fatal(1, "%s: cannot open %s\n", progname, outPath);
			}
		}
  
		if (!fileExisted) file_hdr();
    }

    inform_user("%*s%s\n", inform_indent, "", elt->name);
    function_hdr(elt, classe);
    for (e = elt->parent; e != NULL; e = e->parent) 
    {
    	if (e->templ) 
    	{
			fprintf(outfile, "%s\n", e->templ);
			break;
		}
    }

    {  /* scope for local vars */
		char *arg_str;
		char *arg_str_name;
		
		char *ClassName;
		
		char *Suffixe;
	
		// Extract the class name without the 'B' prefix
		// (without the first char)
		ClassName = jzmidstr(classe->name, 1, strlen(classe->name));		

		if (strncmp(elt->name, prec_function_name, strlen(prec_function_name)) == 0)
		{
			if (strlen(prec_function_name) > 0)
				free(prec_function_name);
			prec_function_name = (char *) malloc(strlen(elt->name) + 1);
			strcpy(prec_function_name, elt->name);
			if (nbConstructor == 0)
			{
				Suffixe = "";
			}
			else			
			{
				Suffixe = (char *) malloc(5);
				sprintf(Suffixe, "_%d\n", nbConstructor);
			}

			nbConstructor++;
		}
		else
		{
			nbConstructor = 0;
			if (strlen(prec_function_name) > 0)
				free(prec_function_name);
			prec_function_name = (char *) malloc(strlen(elt->name) + 1);
			strcpy(prec_function_name, elt->name);		
			if (nbConstructor == 0)
			{
				Suffixe = "";
			}
			else			
			{
				Suffixe = (char *) malloc(5);			
				sprintf(Suffixe, "_%d", nbConstructor);
			}
			nbConstructor++;
		}	


		if (strncmp(elt->name, classe->name, strlen(elt->name)) == 0)
		{
			// constructor
			fprintf(outfile, "TCPlusObject %s%s%s_Create%s(TPasObject PasObject", 
					elt->ret_type, (strcmp(elt->ret_type, "") ? "\n" : ""), 
					classe->name, Suffixe);
	//		nbConstructor++;
		}
		else
			fprintf(outfile, "%s%s%s_%s%s(%s *%s",
				elt->ret_type, (strcmp(elt->ret_type, "") ? "\n" : ""),
				elt->parent->name, elt->name, Suffixe,
				classe->name, ClassName);

		arg_str = args_to_string(
		    elt->args, 
		    opt_a ? strlen(elt->parent->name) + strlen(elt->name) + 3 : 0);

		arg_str_name = args_to_string_name(
		    elt->args, 
		    opt_a ? strlen(elt->parent->name) + strlen(elt->name) + 3 : 0);
	
		if (elt->args == 0)
			fprintf(outfile, "%s)", arg_str); 
		else
			fprintf(outfile, ", %s)", arg_str);
		
		if (elt->throw_decl)
		    fprintf(outfile, " %s", elt->throw_decl);

		if (elt->const_flag)
		    fprintf(outfile, " const");

		fprintf(outfile, "\n{\n");

		if (strncmp(elt->name, classe->name, strlen(elt->name)) == 0)
		{
			char *toto = (char *) malloc(strlen(classe->name) + 100);
			strcpy(toto, classe->name);
			jzinsstr(toto, test, 1);
			fprintf(outfile, "	return new %s(PasObject", 
					toto);
			free(toto);
			if (elt->args == 0) 
				fprintf(outfile, ");\n");
			else
				fprintf(outfile, ", %s);\n", arg_str_name);
		}
	
		// Generate stub code
		else if (strncmp(elt->ret_type, "void", 4) == 0)	
			// procedure
			fprintf(outfile, "   %s->%s(%s);\n", ClassName, elt->name, arg_str_name);	
		else
			// function
			fprintf(outfile, "   return %s->%s(%s);\n", ClassName, elt->name, arg_str_name);		

		free(ClassName);
		free(arg_str_name);
		free(arg_str);
		free(Suffixe);

		
	}

//    debug_printf(elt);
	fprintf(outfile, "}\n\n\n");
}

static void function_hdr(syntaxelem_t *elt, syntaxelem_t *classe)
{
  if (opt_n)
    return;
  
  fprintf(outfile, "/%s\n", (opt_b ? lots_of_stars : "*"));
  fprintf(outfile, " *  Method: %s::%s%s\n", elt->parent->name, elt->name,
	  (opt_s ? "()" : ""));

  if (opt_s) {
    fprintf(outfile, " *   Descr: \n");

  } else {
    char *arg_str = args_to_string(elt->args, 0);
    fprintf(outfile, " *  Params: %s\n", arg_str);
    if (strcmp(elt->ret_type, ""))
      fprintf(outfile, " * Returns: %s\n", elt->ret_type);
    fprintf(outfile, " * Effects: \n");
    free(arg_str);
  }

  fprintf(outfile, " %s/\n", (opt_b ? lots_of_stars : "*"));
}

#ifdef WIN32
static BOOL win32_fullname(const char *login, char *dest)
{
    WCHAR  wszLogin[256];              /* Unicode user name */
    struct _USER_INFO_10 *ui;          /* User structure */
    
    /* Convert ASCII user name to Unicode. */
    MultiByteToWideChar(CP_ACP, 0, login,
			strlen(login)+1, wszLogin, sizeof(wszLogin));
    
    /* Look up the user on the DC.  This function only works for
     * Windows NT, and not Windows 95. */
    if (NetUserGetInfo(NULL, (LPWSTR) &wszLogin, 10, (LPBYTE *) &ui))
	return FALSE;
    
    /* Convert the Unicode full name to ASCII. */
    WideCharToMultiByte(CP_ACP, 0, ui->usri10_full_name,
			-1, dest, 256, NULL, NULL);
    
    return TRUE;
}
#endif /* WIN32 */

static char *sg_getlogin()
{
    static char *login;
#ifdef WIN32
    static char login_buffer[256];
    DWORD size;
#endif /* WIN32 */
    static int sg_getlogin_called = 0;

    if (sg_getlogin_called)
	return login;
    else
	sg_getlogin_called = 1;

#ifdef WIN32
    if ((login = getenv("USERNAME")) == NULL) {
	if ((login = getenv("USER")) == NULL) {
	    size = 255;
	    login = login_buffer;
	    if (GetUserName(login_buffer, &size) == FALSE)
		login = "nobody";
	}
    }
#else /* !WIN32 */
    if ((login = getenv("USER")) == NULL)
	if ((login = getlogin()) == NULL)
	    login = "nobody";
#endif /* WIN32 */
    
    return login;
}

static char *sg_getfullname(const char *login)
{
    char *fullname;
    static char fullname_buffer[256];
#ifndef WIN32
    char *comma;
    struct passwd *pw;
#endif /* WIN32 */

#ifdef WIN32
    fullname = fullname_buffer;
    
    if (win32_fullname(login, fullname_buffer) == FALSE)
	fullname = "nobody";
#else /* !WIN32 */
    if ((fullname = getenv("NAME")) == NULL) {
	setpwent();
	pw = getpwnam(login);
	if (pw == NULL) {
	    fullname = "nobody";
	} else {
	    strncpy(fullname_buffer, pw->pw_gecos, 256);
	    comma = strchr(fullname_buffer, ',');
	    if (comma) *comma = '\0';
	    fullname = fullname_buffer;
	}
	endpwent();
    }
#endif /* WIN32 */

    return fullname;
}


static void file_hdr() {
  char domain[256], *tmp;
  time_t now = time(0);
  char *today = ctime(&now);
  char *login = sg_getlogin();
  char *fullname = sg_getfullname(login);

  log_printf("login: %s, full name: %s\n", login, fullname);

  domain[0] = '\0';
  if ((tmp = getenv("STUBGEN_DOM")) != NULL)
      sprintf(domain, "@%s", tmp);

  if (opt_r) {
    fprintf(outfile, "/*\n *  FILE: %s\n *  AUTH: %s <%s%s>\n", outPath, fullname, login, domain);
    /* no '\n' needed with ctime() */
    fprintf(outfile, " *\n *  DESC: \n *\n *  DATE: %s *   %sId$ \n *\n", today, "$");
    fprintf(outfile, " *  %sLog$\n", "$");
    fprintf(outfile, " *\n */\n");

  } else {
    fprintf(outfile, "/%s\n", lots_of_stars);
    fprintf(outfile, " * AUTHOR: %s <%s%s>\n", fullname, login, domain);
    fprintf(outfile, " *   FILE: %s\n", outPath);
    fprintf(outfile, " *   DATE: %s", today); /* no '\n' needed with ctime() */
    fprintf(outfile, " *  DESCR: \n");
    fprintf(outfile, " %s/\n", lots_of_stars);
  }

  if (!opt_i && !using_stdio)
    fprintf(outfile, "#include \"%s\"\n", inPath);
  if (opt_c)
    fprintf(outfile, "#include <iostream.h>\n");
  else if (opt_d)
    fprintf(outfile, "#include <Debug.H>\n");

  fprintf(outfile, "\n");
}
    

static void debug_printf(syntaxelem_t *elt)
{
  /*
   * Make a dummy return value if this function is not a 
   * procedure (returning void) or a ctor (returning "").
   * Don't bother for references because they require an lvalue.
   */
  int dummy_ret_val = (opt_g && 
		       strcmp(elt->ret_type, "") != 0 && 
		       strcmp(elt->ret_type, "void") != 0 &&
		       strchr(elt->ret_type, '&') == 0);
  /* 
   * If it's not a pointer type, create a temporary on the stack.
   * They'll get warnings "dummy has not yet been assigned a value"
   * from the compiler, but that's the best we can do.
   * If it's a pointer type, return NULL (we assume it's defined).
   */
  if (dummy_ret_val != 0 && strchr(elt->ret_type, '*') == NULL)
    fprintf(outfile, "    %s dummy;\n\n", elt->ret_type);

  if (opt_c)
    fprintf(outfile, "    cerr << \"%s::%s()\" << endl;\n",
	    elt->parent->name, elt->name);
  else if (opt_d)
    fprintf(outfile, "    dprintf((\"%s::%s()\\n\"));\n",
	    elt->parent->name, elt->name);

  if (dummy_ret_val != 0)
    fprintf(outfile, "    return %s;\n",
	    (strchr(elt->ret_type, '*') == NULL) ? "dummy" : "NULL");
}
    
extern char linebuf[];
extern int lineno;
extern int column;
extern int tokens_seen;
extern int yyparse();

static void scan_existing_skeleton()
{
  extern FILE *yyin;
  FILE *existing;

  log_printf("checking for existence of %s ...\n", outPath);
  if ((existing = fopen(outPath, "r")) == NULL)
    return;

  log_printf("%s exists, scanning skeleton...\n", outPath);
  inform_user("scanning %s ...\n", outPath);

  lineno = 1;
  column = 0;
  tokens_seen = 0;

  yyin = existing;
  currentFile = outPath;
  linebuf[0] = '\0';
  yyparse();
  log_printf("finished yyparse()\n");
  currentFile = "";

  fclose(existing);
  log_printf("done scanning skeleton...\n");
}


static void scan_and_generate(FILE *infile)
{
  extern FILE *yyin;
  
  fileOpened = 0;
  lineno = 1;
  column = 0;
  tokens_seen = 0;

  /* normal interaction on yyin and outfile from now on */
  inform_user("parsing %s ...\n", inPath);
  log_printf("parsing %s ...\n", inPath);
  yyin = infile;
  currentFile = inPath;
  linebuf[0] = '\0';
  yyparse();
  log_printf("finished yyparse()\n");
  currentFile = "";
  log_printf("expanding classes...\n");
  while (!class_queue_empty()) {
    syntaxelem_t *elt = dequeue_class();
    generate_skel(elt);
  }

  log_printf("closing %s\n", outPath);
  free(outPath);
  outPath = NULL;
  if (fileOpened) {
    fflush(outfile);
    fclose(outfile);
    outfile = NULL;
  }
  log_printf("done with %s\n", inPath);
}

/*
 * return a value representing numeric part of the RCS Revision string
 * where value == (major * 1000) + minor.
 */
int revision()
{
  static char rcsrev[] = "$Revision: 1.1 $";
  static int value = -1;
  char *major_str, *dot;

  if (value != -1)
    return value;

  rcsrev[strlen(rcsrev)-2] = '\0';

  major_str = &rcsrev[11];
  dot = strchr(major_str, '.');
  *dot++ = '\0'; /* tie off major_str and move to minor */

  value = (atoi(major_str) * 1000) + atoi(dot);

  return value;
}

#ifndef _MAX_PATH
#define _MAX_PATH 256
#endif /* !def _MAX_PATH */

int main(int argc, char **argv) 
{ 
    extern int optind;
    extern char *optarg;
    int c, err_flag = 0;
    char *ext;

#ifdef SGDEBUG
    char logfilename_buffer[_MAX_PATH];
#ifdef WIN32
    DWORD tmpPathLen;
#endif /* WIN32 */
#endif /* SGDEBUG */

#ifdef SGDEBUG
#ifdef WIN32
    tmpPathLen = GetTempPath(_MAX_PATH, logfilename_buffer);
    if (logfilename_buffer[tmpPathLen - 1] != '\\')
	strcat(logfilename_buffer, "\\");
#else /* !WIN32 */
    strcpy(logfilename_buffer, "/tmp/");
#endif /* WIN32 */

    strcat(logfilename_buffer, sg_getlogin());
    strcat(logfilename_buffer, "-");
    strcat(logfilename_buffer, logfilename);

    if (!log_open(logfilename_buffer)) {
      /* open failed */
      fatal(1, "%s: cannot write to %s\n", progname, logfilename_buffer);
    }
#endif /* SGDEBUG */

    while ((c = getopt(argc, argv, OPTS)) != EOF) {
	switch (c) {
	case 'h':
	    opt_h = 1; break;
	case 'q':
	    opt_q = 1; break;
	case 'v':
	    opt_v = 1; break;
	case 'g':
	    opt_g = 1; break;
	case 'a':
	    opt_a = 1; break;
	case 'e':
 	    opt_e = optarg; 
	    if (opt_e[0] == '.')
	      opt_e++;
	    break;
	case 'r':
	    opt_r = 1; break;
	case 'i':
	    opt_i = 1; break;
	case 'c':
	    if (opt_d) err_flag = 1;
	    opt_c = 1; break;
	case 'd':
	    if (opt_c) err_flag = 1;
	    opt_d = 1; break;
	case 'b':
	    if (opt_f || opt_s || opt_n) err_flag = 1;
	    opt_b = 1; break;
	case 'f':
	    if (opt_b || opt_s || opt_n) err_flag = 1;
	    opt_f = 1; break;
	case 's':
	    if (opt_f || opt_b || opt_n) err_flag = 1;
	    opt_s = 1; break;
	case 'n':
	    if (opt_f || opt_s || opt_b) err_flag = 1;
	    opt_n = 1; break;
	default:
            err_flag = 1;
	}
    }
    
    if (opt_h || opt_v || err_flag) {
      inform_user("%s version %s (build %d).\n",
		  progname, progver, revision());
      if (opt_h || err_flag)
	fatal(err_flag, usage, progname);
      else
	fatal(0, "%s\n%s", copyright, version_info);
    }

    if (!(opt_b || opt_f || opt_s || opt_n))
	opt_b = 1;

    /* done setting options */
    if (argc == optind) {
	/* read from stdin and stdout */
        outfile = stdout;
	fprintf(outfile, "/* %s: reading from stdin */\n", progname);
	using_stdio = 1;
	inPath = "stdin";
	outPath = strdup("stdout");
	
        opt_q = 1;  /* force quiet mode */
	log_printf("initting...\n");
	init_tables();
	scan_and_generate(stdin);
	log_printf("freeing memory...\n");
	free_tables();

    } else {
        inform_user("%s version %s (build %d).\n",
		    progname, progver, revision());

	/* each bloody file from the command line */
	while (optind < argc) {
  	    FILE *infile;
	    log_printf("working on %s\n", argv[optind]);
	    /* open for read */
	    infile = fopen(argv[optind], "r");
	    if (infile == NULL) {
	      /* open failed */
	      fatal(1, "%s: cannot open %s\n", progname, argv[optind]);
	    }

	    inPath = basename(argv[optind]);
	    outPath = (char *)malloc(strlen(inPath) + strlen(opt_e) + 2);
	    strcpy(outPath, inPath);

	    /* tie off .h, .hh, .hpp, or .hxx extension */
	    if (((ext = strrchr(outPath, '.')) != NULL) &&
		(((strlen(ext) == 2) &&
		  ((ext[1] == 'H') || (ext[1] == 'h'))) ||
		 (((strlen(ext) == 3) &&
		   ((ext[1] == 'H') || (ext[1] == 'h')) &&
		   ((ext[2] == 'H') || (ext[2] == 'h')))) ||
		 ((strlen(ext) == 4) &&
		  ((ext[1] == 'H') || (ext[1] == 'h')) &&
		  ((((ext[2] == 'P') || (ext[2] == 'p')) &&
		    ((ext[3] == 'P') || (ext[3] == 'p'))) ||
		   (((ext[2] == 'X') || (ext[2] == 'x')) &&
		    ((ext[3] == 'X') || (ext[3] == 'x')))))))
		*ext = '\0';
	    
	    assert(opt_e[0] != '.');
	    strcat(outPath, ".");
	    strcat(outPath, opt_e);

	    log_printf("initting...\n");
	    init_tables();
	    scan_existing_skeleton();
	    scan_and_generate(infile);
	    log_printf("freeing memory...\n");
	    free_tables();
	    clear_skeleton_queue();
	    fclose(infile);
	    optind++;
	}
    }

#ifdef SGDEBUG
    log_flush();
    log_close();
#endif /* SGDEBUG */

    return 0;
}
