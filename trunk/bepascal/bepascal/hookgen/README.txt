HookGen
=======

HookGen is a developper tool written in pascal. It is designed to 
generate pascal and C++ source files needed to implement 
BeOS hooks functions in BePascal. This tool work with a description 
of the BeOS hooks functions stored in a XML file.

Files
=====

README.txt : this file !

hookgen.pp : the main program !

typenum.pp : this tool read hook.xml and write a file with all C++ types.
             hookgen use the result file to translate a C++ type in a
             pascal type.

hooks.xml : XML description of BeOS hook functions

typemap.txt : the type map needed to convert C++ types to pascal types.

Installation
============

Compile kookgen.pp et typenum.pp with the -S2 option :

  fpc -S2 hookgen.pp
  fpc -S2 typenum.pp
  
(only tested with fpc 1.06)