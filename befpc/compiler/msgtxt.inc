{$ifdef Delphi}
const msgtxt : array[0..000125] of string[240]=(
{$else Delphi}
const msgtxt : array[0..000125,1..240] of char=(
{$endif Delphi}
  '01000_T_Compiler: $1'#000+
  '01001_D_Compiler OS: $1'#000+
  '01002_I_Target OS: $1'#000+
  '01003_T_Using executable path: $1'#000+
  '01004_T_Using unit path: $1'#000+
  '01005_T_Using include path: $1'#000+
  '01006_T_Using library path: $1'#000+
  '01007_T_Using object path: $1'#000+
  '01008_I_$1 Lines co','mpiled, $2 sec'#000+
  '01009_F_No memory left'#000+
  '01010_I_Writing Resource String Table file: $1'#000+
  '01011_E_Writing Resource String Table file: $1'#000+
  '02000_F_Unexpected end of file'#000+
  '02001_F_String exceeds line'#000+
  '02002_F_illegal character $1 ($2)'#000+
  '02003_F_Syntax ','error, $1 expected but $2 found'#000+
  '02004_T_Start reading includefile $1'#000+
  '02005_W_Comment level $1 found'#000+
  '02006_N_$F directive (FAR) ignored'#000+
  '02007_N_Stack check is global under Linux'#000+
  '02008_N_Ignored compiler switch $1'#000+
  '02009_W_Illegal compiler swi','tch $1'#000+
  '02010_W_This compiler switch has a global effect'#000+
  '02011_E_Illegal char constant'#000+
  '02012_F_Can'#039't open file $1'#000+
  '02013_F_Can'#039't open include file $1'#000+
  '02014_E_Too many $ENDIFs or $ELSEs'#000+
  '02015_W_Records fields can be aligned to 1,2,4,8,16 or 32',' bytes only'+
  #000+
  '02016_W_Enumerated can be saved in 1,2 or 4 bytes only'#000+
  '02017_E_$ENDIF expected for $1 $2 defined in line $3'#000+
  '02018_E_Syntax error while parsing a conditional compiling expression'#000+
  '02019_E_Evaluating a conditional compiling express','ion'#000+
  '02020_W_Macro contents is cut after char 255 to evalute expression'#000+
  '02021_E_ENDIF without IF(N)DEF'#000+
  '02022_F_User defined: $1'#000+
  '02023_E_User defined: $1'#000+
  '02024_W_User defined: $1'#000+
  '02025_N_User defined: $1'#000+
  '02026_H_User defined: $1'#000+
  '02027_I_User ','defined: $1'#000+
  '02028_E_Keyword redefined as macro has no effect'#000+
  '02029_F_Macro buffer overflow while reading or expanding a macro'#000+
  '02030_W_Extension of macros exceeds a deep of 16.'#000+
  '02031_E_compiler switches aren'#039't allowed in (* ... *) styled com','m'+
  'ents'#000+
  '02032_D_Handling switch "$1"'#000+
  '02033_C_ENDIF $1 found'#000+
  '02034_C_IFDEF $1 found, $2'#000+
  '02035_C_IFOPT $1 found, $2'#000+
  '02036_C_IF $1 found, $2'#000+
  '02037_C_IFNDEF $1 found, $2'#000+
  '02038_C_ELSE $1 found, $2'#000+
  '02039_C_Skipping until...'#000+
  '02040_I_Press <return> t','o continue'#000+
  '02041_W_Unsupported switch $1'#000+
  '02042_W_Illegal compiler directive $1'#000+
  '02043_T_Back in $1'#000+
  '02044_W_Unsupported application type: $1'#000+
  '02045_W_APPTYPE isn'#039't support by the target OS'#000+
  '02046_W_DESCRIPTION is only supported for OS2 and Win3','2'#000+
  '02047_N_VERSION is not supported by target OS.'#000+
  '02048_N_VERSION only for exes or DLLs'#000+
  '02049_W_Wrong format for VERSION directive $1'#000+
  '02050_W_Unsupported assembler style specified $1'#000+
  '02051_W_ASM reader switch is not possible inside asm state','ment, $1 w'+
  'ill be effective only for next'#000+
  '02052_E_Wrong switch toggle, use ON/OFF or +/-'#000+
  '02053_E_Resource files are not supported for this target'#000+
  '02054_W_Include environment $1 not found in environment'#000+
  '02055_E_Illegal value for FPU register ','limit'#000+
  '02056_W_Only one resource file is supported for this target'#000+
  '03000_E_Parser - Syntax Error'#000+
  '03001_W_Procedure type FAR ignored'#000+
  '03002_W_Procedure type NEAR ignored'#000+
  '03003_W_Procedure type INTERRUPT ignored for not i386'#000+
  '03004_E_INTERRUPT p','rocedure can'#039't be nested'#000+
  '03005_W_Procedure type $1 ignored'#000+
  '03006_E_Not all declarations of $1 are declared with OVERLOAD'#000+
  '03007_E_No DLL File specified'#000+
  '03008_E_Duplicate exported function name $1'#000+
  '03009_E_Duplicate exported function index $1'#000,
  '03010_E_Invalid index for exported function'#000+
  '03011_W_Relocatable DLL or executable $1 debug info does not work, dis'+
  'abled.'#000+
  '03012_W_To allow debugging for win32 code you need to disable relocati'+
  'on with -WN option'#000+
  '03013_E_Constructor name must ','be INIT'#000+
  '03014_E_Destructor name must be DONE'#000+
  '03015_E_Illegal open parameter'#000+
  '03016_E_Procedure type INLINE not supported'#000+
  '03017_W_Private methods shouldn'#039't be VIRTUAL'#000+
  '03018_W_Constructor should be public'#000+
  '03019_W_Destructor should be public'#000+
  '03','020_N_Class should have one destructor only'#000+
  '03021_E_Local class definitions are not allowed'#000+
  '03022_F_Anonym class definitions are not allowed'#000+
  '03023_E_The object $1 has no VMT'#000+
  '03024_E_Illegal parameter list'#000+
  '03025_E_Wrong parameter type specif','ied for arg no. $1'#000+
  '03026_E_Wrong amount of parameters specified'#000+
  '03027_E_overloaded identifier $1 isn'#039't a function'#000+
  '03028_E_overloaded functions have the same parameter list'#000+
  '03029_E_function header doesn'#039't match the forward declaration $1'#000+
  '030','30_E_function header $1 doesn'#039't match forward : var name chan'+
  'ges $2 => $3'#000+
  '03031_N_Values in enumeration types have to be ascending'#000+
  '03032_N_Interface and implementation names are different $1 => $2'#000+
  '03033_E_With can not be used for variables ','in a different segment'#000+
  '03034_E_function nesting > 31'#000+
  '03035_E_range check error while evaluating constants'#000+
  '03036_W_range check error while evaluating constants'#000+
  '03037_E_duplicate case label'#000+
  '03038_E_Upper bound of case range is less than lower',' bound'#000+
  '03039_E_typed constants of classes are not allowed'#000+
  '03040_E_functions variables of overloaded functions are not allowed'#000+
  '03041_E_string length must be a value from 1 to 255'#000+
  '03042_W_use extended syntax of NEW and DISPOSE for instances o','f obje'+
  'cts'#000+
  '03043_W_use of NEW or DISPOSE for untyped pointers is meaningless'#000+
  '03044_E_use of NEW or DISPOSE is not possible for untyped pointers'#000+
  '03045_E_class identifier expected'#000+
  '03046_E_type identifier not allowed here'#000+
  '03047_E_method identif','ier expected'#000+
  '03048_E_function header doesn'#039't match any method of this class'#000+
  '03049_P_procedure/function $1'#000+
  '03050_E_Illegal floating point constant'#000+
  '03051_E_FAIL can be used in constructors only'#000+
  '03052_E_Destructors can'#039't have parameters'#000+
  '03053_','E_Only class methods can be referred with class references'#000+
  '03054_E_Only class methods can be accessed in class methods'#000+
  '03055_E_Constant and CASE types do not match'#000+
  '03056_E_The symbol can'#039't be exported from a library'#000+
  '03057_W_An inherited met','hod is hidden by $1'#000+
  '03058_E_There is no method in an ancestor class to be overridden: $1'#000+
  '03059_E_No member is provided to access property'#000+
  '03060_W_Stored prorperty directive is not yet implemented'#000+
  '03061_E_Illegal symbol for property access'#000+
  '0','3062_E_Cannot access a protected field of an object here'#000+
  '03063_E_Cannot access a private field of an object here'#000+
  '03064_W_overloaded method of virtual method should be virtual: $1'#000+
  '03065_W_overloaded method of non-virtual method should be non','-virtua'+
  'l: $1'#000+
  '03066_E_overloaded methods which are virtual must have the same return'+
  ' type: $1'#000+
  '03067_E_EXPORT declared functions can'#039't be nested'#000+
  '03068_E_methods can'#039't be EXPORTed'#000+
  '03069_E_call by var parameters have to match exactly: Got $1 ex','pecte'+
  'd $2'#000+
  '03070_E_Class isn'#039't a parent class of the current class'#000+
  '03071_E_SELF is only allowed in methods'#000+
  '03072_E_methods can be only in other methods called direct with type i'+
  'dentifier of the class'#000+
  '03073_E_Illegal use of '#039':'#039#000+
  '03074_E_range ','check error in set constructor or duplicate set elemen'+
  't'#000+
  '03075_E_Pointer to object expected'#000+
  '03076_E_Expression must be constructor call'#000+
  '03077_E_Expression must be destructor call'#000+
  '03078_E_Illegal order of record elements'#000+
  '03079_E_Expression ty','pe must be class or record type'#000+
  '03080_E_Procedures can'#039't return a value'#000+
  '03081_E_constructors and destructors must be methods'#000+
  '03082_E_Operator is not overloaded'#000+
  '03083_E_Impossible to overload assignment for equal types'#000+
  '03084_E_Impossible ope','rator overload'#000+
  '03085_E_Re-raise isn'#039't possible there'#000+
  '03086_E_The extended syntax of new or dispose isn'#039't allowed for a '+
  'class'#000+
  '03087_E_Assembler incompatible with function return type'#000+
  '03088_E_Procedure overloading is switched off'#000+
  '03089_E_It i','s not possible to overload this operator (overload = ins'+
  'tead)'#000+
  '03090_E_Comparative operator must return a boolean value'#000+
  '03091_E_Only virtual methods can be abstract'#000+
  '03092_F_Use of unsupported feature!'#000+
  '03093_E_The mix of CLASSES and OBJECTS i','sn'#039't allowed'#000+
  '03094_W_Unknown procedure directive had to be ignored: $1'#000+
  '03095_E_absolute can only be associated to ONE variable'#000+
  '03096_E_absolute can only be associated a var or const'#000+
  '03097_E_Only ONE variable can be initialized'#000+
  '03098_E_Abstr','act methods shouldn'#039't have any definition (with fun'+
  'ction body)'#000+
  '03099_E_This overloaded function can'#039't be local (must be exported)'+
  #000+
  '03100_W_Virtual methods are used without a constructor in $1'#000+
  '03101_M_Macro defined: $1'#000+
  '03102_M_Macro undefined',': $1'#000+
  '03103_M_Macro $1 set to $2'#000+
  '03104_I_Compiling $1'#000+
  '03105_U_Parsing interface of unit $1'#000+
  '03106_U_Parsing implementation of $1'#000+
  '03107_D_Compiling $1 for the second time'#000+
  '03108_E_Array properties aren'#039't allowed here'#000+
  '03109_E_No property found t','o override'#000+
  '03110_E_Only one default property is allowed, found inherited default '+
  'property in class $1'#000+
  '03111_E_The default property must be an array property'#000+
  '03112_E_Virtual constructors are only supported in class object model'#000+
  '03113_E_No de','fault property available'#000+
  '03114_E_The class can'#039't have a published section, use the {$M+} sw'+
  'itch'#000+
  '03115_E_Forward declaration of class $1 must be resolved here to use t'+
  'he class as ancestor'#000+
  '03116_E_Local operators not supported'#000+
  '03117_E_Procedu','re directive $1 not allowed in interface section'#000+
  '03118_E_Procedure directive $1 not allowed in implementation section'#000+
  '03119_E_Procedure directive $1 not allowed in procvar declaration'#000+
  '03120_E_Function is already declared Public/Forward $1'#000+
  '0','3121_E_Can'#039't use both EXPORT and EXTERNAL'#000+
  '03122_E_NAME keyword expected'#000+
  '03123_W_$1 not yet supported inside inline procedure/function'#000+
  '03124_W_Inlining disabled'#000+
  '03125_I_Writing Browser log $1'#000+
  '03126_H_may be pointer dereference is missing'#000+
  '031','27_F_Selected assembler reader not supported'#000+
  '03128_E_Procedure directive $1 has conflicts with other directives'#000+
  '03129_E_Calling convention doesn'#039't match forward'#000+
  '03130_E_Register calling (fastcall) not supported'#000+
  '03131_E_Property can'#039't have a',' default value'#000+
  '03132_E_The default value of a property must be constant'#000+
  '03133_E_Symbol can'#039't be published, can be only a class'#000+
  '03134_E_That kind of property can'#039't be published'#000+
  '03135_W_Empty import name specified'#000+
  '03136_W_An import name is re','quired'#000+
  '03137_E_Function internal name changed after use of function'#000+
  '03138_E_Division by zero'#000+
  '03139_E_Invalid floating point operation'#000+
  '03140_E_Upper bound of range is less than lower bound'#000+
  '03141_W_string "$1" is longer than $2'#000+
  '03142_E_string',' length is larger than array of char length'#000+
  '03143_E_Illegal expression after message directive'#000+
  '03144_E_Message handlers can take only one call by ref. parameter'#000+
  '03145_E_Duplicate message label: $1'#000+
  '03146_E_Self can be only an explicit parame','ter in message handlers'#000+
  '03147_E_Threadvars can be only static or global'#000+
  '03148_F_Direct assembler not supported for binary output format'#000+
  '03149_W_Don'#039't load OBJPAS unit manual, use {$mode objfpc} or {$mod'+
  'e delphi} instead'#000+
  '03150_E_OVERRIDE can',#039't be used in objects'#000+
  '03151_E_Data types which requires initialization/finalization can'#039't'+
  ' be used in variant records'#000+
  '03152_E_Resourcestrings can be only static or global'#000+
  '03153_E_Exit with argument can'#039't be used here'#000+
  '03154_E_The type of the ','storage symbol must be boolean'#000+
  '03155_E_This symbol isn'#039't allowed as storage symbol'#000+
  '03156_E_Only class which are compiled in $M+ mode can be published'#000+
  '03157_E_Procedure directive expected'#000+
  '03158_E_The value for a property index must be of an ','ordinal type'#000+
  '03159_E_Procedure name to short to be exported'#000+
  '03160_E_No DEFFILE entry can be generated for unit global vars'#000+
  '03161_E_Compile without -WD option'#000+
  '04000_E_Type mismatch'#000+
  '04001_E_Incompatible types: got "$1" expected "$2"'#000+
  '04002_E_T','ype mismatch between $1 and $2'#000+
  '04003_E_Type identifier expected'#000+
  '04004_E_Variable identifier expected'#000+
  '04005_E_Integer expression expected, but got "$1"'#000+
  '04006_E_Boolean expression expected, but got "$1"'#000+
  '04007_E_Ordinal expression expected'#000+
  '040','08_E_pointer type expected, but got "$1"'#000+
  '04009_E_class type expected, but got "$1"'#000+
  '04010_E_Variable or type indentifier expected'#000+
  '04011_E_Can'#039't evaluate constant expression'#000+
  '04012_E_Set elements are not compatible'#000+
  '04013_E_Operation not implem','ented for sets'#000+
  '04014_W_Automatic type conversion from floating type to COMP which is '+
  'an integer type'#000+
  '04015_H_use DIV instead to get an integer result'#000+
  '04016_E_string types doesn'#039't match, because of $V+ mode'#000+
  '04017_E_succ or pred on enums with',' assignments not possible'#000+
  '04018_E_Can'#039't read or write variables of this type'#000+
  '04019_E_Can'#039't use readln or writeln on typed file'#000+
  '04020_E_Can'#039't use read or write on untyped file.'#000+
  '04021_E_Type conflict between set elements'#000+
  '04022_W_lo/hi(dword/q','word) returns the upper/lower word/dword'#000+
  '04023_E_Integer or real expression expected'#000+
  '04024_E_Wrong type $1 in array constructor'#000+
  '04025_E_Incompatible type for arg no. $1: Got $2, expected $3'#000+
  '04026_E_Method (variable) and Procedure (variable)',' are not compatibl'+
  'e'#000+
  '04027_E_Illegal constant passed to internal math function'#000+
  '04028_E_Can'#039't get the address of constants'#000+
  '04029_E_Argument can'#039't be assigned to'#000+
  '04030_E_Can'#039't assign local procedure/function to procedure variabl'+
  'e'#000+
  '04031_E_Can'#039't',' assign values to an address'#000+
  '04032_E_Can'#039't assign values to const variable'#000+
  '05000_E_Identifier not found $1'#000+
  '05001_F_Internal Error in SymTableStack()'#000+
  '05002_E_Duplicate identifier $1'#000+
  '05003_H_Identifier already defined in $1 at line $2'#000+
  '05004_E','_Unknown identifier $1'#000+
  '05005_E_Forward declaration not solved $1'#000+
  '05006_F_Identifier type already defined as type'#000+
  '05007_E_Error in type definition'#000+
  '05008_E_Type identifier not defined'#000+
  '05009_E_Forward type not resolved $1'#000+
  '05010_E_Only static v','ariables can be used in static methods or outsi'+
  'de methods'#000+
  '05011_E_Invalid call to tvarsym.mangledname()'#000+
  '05012_F_record or class type expected'#000+
  '05013_E_Instances of classes or objects with an abstract method are no'+
  't allowed'#000+
  '05014_W_Label not ','defined $1'#000+
  '05015_E_Label used but not defined $1'#000+
  '05016_E_Illegal label declaration'#000+
  '05017_E_GOTO and LABEL are not supported (use switch -Sg)'#000+
  '05018_E_Label not found'#000+
  '05019_E_identifier isn'#039't a label'#000+
  '05020_E_label already defined'#000+
  '05021_E_ille','gal type declaration of set elements'#000+
  '05022_E_Forward class definition not resolved $1'#000+
  '05023_H_Unit $1 not used in $2'#000+
  '05024_H_Parameter $1 not used'#000+
  '05025_N_Local variable $1 not used'#000+
  '05026_H_Value parameter $1 is assigned but never used'#000+
  '0502','7_N_Local variable $1 is assigned but never used'#000+
  '05028_H_Local $1 $2 is not used'#000+
  '05029_N_Private field $1.$2 is never used'#000+
  '05030_N_Private field $1.$2 is assigned but never used'#000+
  '05031_N_Private method $1.$2 never used'#000+
  '05032_E_Set type expec','ted'#000+
  '05033_W_Function result does not seem to be set'#000+
  '05034_W_Type $1 is not aligned correctly in current record for C'#000+
  '05035_E_Unknown record field identifier $1'#000+
  '05036_W_Local variable $1 does not seem to be initialized'#000+
  '05037_W_Variable $1 do','es not seem to be initialized'#000+
  '05038_E_identifier idents no member $1'#000+
  '05039_B_Found declaration: $1'#000+
  '05040_E_Data segment too large (max. 2GB)'#000+
  '06000_E_BREAK not allowed'#000+
  '06001_E_CONTINUE not allowed'#000+
  '06002_E_Expression too complicated - FPU sta','ck overflow'#000+
  '06003_E_Illegal expression'#000+
  '06004_E_Invalid integer expression'#000+
  '06005_E_Illegal qualifier'#000+
  '06006_E_High range limit < low range limit'#000+
  '06007_E_Illegal counter variable'#000+
  '06008_E_Can'#039't determine which overloaded function to call'#000+
  '06009_','E_Parameter list size exceeds 65535 bytes'#000+
  '06010_E_Illegal type conversion'#000+
  '06011_D_Conversion between ordinals and pointers is not portable acros'+
  's platforms'#000+
  '06012_E_File types must be var parameters'#000+
  '06013_E_The use of a far pointer isn'#039't all','owed there'#000+
  '06014_E_illegal call by reference parameters'#000+
  '06015_E_EXPORT declared functions can'#039't be called'#000+
  '06016_W_Possible illegal call of constructor or destructor (doesn'#039't'+
  ' match to this context)'#000+
  '06017_N_Inefficient code'#000+
  '06018_W_unreachabl','e code'#000+
  '06019_E_procedure call with stackframe ESP/SP'#000+
  '06020_E_Abstract methods can'#039't be called directly'#000+
  '06021_F_Internal Error in getfloatreg(), allocation failure'#000+
  '06022_F_Unknown float type'#000+
  '06023_F_SecondVecn() base defined twice'#000+
  '06024_F_Ex','tended cg68k not supported'#000+
  '06025_F_32-bit unsigned not supported in MC68000 mode'#000+
  '06026_F_Internal Error in secondinline()'#000+
  '06027_D_Register $1 weight $2 $3'#000+
  '06028_E_Stack limit excedeed in local routine'#000+
  '06029_D_Stack frame is omitted'#000+
  '06030_W_','Range check for 64 bit integers is not supported on this tar'+
  'get'#000+
  '06031_E_Object or class methods can'#039't be inline.'#000+
  '06032_E_Procvar calls can'#039't be inline.'#000+
  '06033_E_No code for inline procedure stored'#000+
  '06034_E_Direct call of interrupt procedure $','1 is not possible'#000+
  '06035_E_Element zero of an ansi/wide- or longstring can'#039't be acces'+
  'sed, use (set)length instead'#000+
  '06036_E_Include and exclude not implemented in this case'#000+
  '06037_E_Constructors or destructors can not be called inside a '#039'wi'+
  'th'#039' ','clause'#000+
  '06038_E_Cannot call message handler method directly'#000+
  '06039_E_Jump in or outside of an exception block'#000+
  '06040_E_Control flow statements aren'#039't allowed in a finally block'#000+
  '07000_D_Starting $1 styled assembler parsing'#000+
  '07001_D_Finished $1 s','tyled assembler parsing'#000+
  '07002_E_Non-label pattern contains @'#000+
  '07003_W_Override operator not supported'#000+
  '07004_E_Error building record offset'#000+
  '07005_E_OFFSET used without identifier'#000+
  '07006_E_TYPE used without identifier'#000+
  '07007_E_Cannot use local v','ariable or parameters here'#000+
  '07008_E_need to use OFFSET here'#000+
  '07009_E_need to use $ here'#000+
  '07010_E_Cannot use multiple relocatable symbols'#000+
  '07011_E_Relocatable symbol can only be added'#000+
  '07012_E_Invalid constant expression'#000+
  '07013_E_Relocatable symbo','l is not allowed'#000+
  '07014_E_Invalid reference syntax'#000+
  '07015_E_You can not reach $1 from that code'#000+
  '07016_E_Local symbols/labels aren'#039't allowed as references'#000+
  '07017_E_Invalid base and index register usage'#000+
  '07018_W_Possible error in object field han','dling'#000+
  '07019_E_Wrong scale factor specified'#000+
  '07020_E_Multiple index register usage'#000+
  '07021_E_Invalid operand type'#000+
  '07022_E_Invalid string as opcode operand: $1'#000+
  '07023_W_@CODE and @DATA not supported'#000+
  '07024_E_Null label references are not allowed'#000+
  '0','7025_E_Divide by zero in asm evaluator'#000+
  '07026_E_Illegal expression'#000+
  '07027_E_escape sequence ignored: $1'#000+
  '07028_E_Invalid symbol reference'#000+
  '07029_W_Fwait can cause emulation problems with emu387'#000+
  '07030_W_FADD without operand translated into FADDP',#000+
  '07031_W_ENTER instruction is not supported by Linux kernel'#000+
  '07032_W_Calling an overload function in assembler'#000+
  '07033_E_Unsupported symbol type for operand'#000+
  '07034_E_Constant value out of bounds'#000+
  '07035_E_Error converting decimal $1'#000+
  '07036_E_Error',' converting octal $1'#000+
  '07037_E_Error converting binary $1'#000+
  '07038_E_Error converting hexadecimal $1'#000+
  '07039_H_$1 translated to $2'#000+
  '07040_W_$1 is associated to an overloaded function'#000+
  '07041_E_Cannot use SELF outside a method'#000+
  '07042_E_Cannot use OLDEB','P outside a nested procedure'#000+
  '07043_W_Procedures can'#039't return any value in asm code'#000+
  '07044_E_SEG not supported'#000+
  '07045_E_Size suffix and destination or source size do not match'#000+
  '07046_W_Size suffix and destination or source size do not match'#000+
  '070','47_E_Assembler syntax error'#000+
  '07048_E_Invalid combination of opcode and operands'#000+
  '07049_E_Assemler syntax error in operand'#000+
  '07050_E_Assemler syntax error in constant'#000+
  '07051_E_Invalid String expression'#000+
  '07052_bit constant created for address'#000+
  '07053','_E_Unrecognized opcode $1'#000+
  '07054_E_Invalid or missing opcode'#000+
  '07055_E_Invalid combination of prefix and opcode: $1'#000+
  '07056_E_Invalid combination of override and opcode: $1'#000+
  '07057_E_Too many operands on line'#000+
  '07058_W_NEAR ignored'#000+
  '07059_W_FAR ignor','ed'#000+
  '07060_E_Duplicate local symbol $1'#000+
  '07061_E_Undefined local symbol $1'#000+
  '07062_E_Unknown label identifier $1'#000+
  '07063_E_Invalid register name'#000+
  '07064_E_Invalid floating point register name'#000+
  '07065_E_NOR not supported'#000+
  '07066_W_Modulo not supported'#000+
  '070','67_E_Invalid floating point constant $1'#000+
  '07068_E_Invalid floating point expression'#000+
  '07069_E_Wrong symbol type'#000+
  '07070_E_Cannot index a local var or parameter with a register'#000+
  '07071_E_Invalid segment override expression'#000+
  '07072_W_Identifier $1 supp','osed external'#000+
  '07073_E_Strings not allowed as constants'#000+
  '07074_No type of variable specified'#000+
  '07075_E_assembler code not returned to text section'#000+
  '07076_E_Not a directive or local symbol $1'#000+
  '07077_E_Using a defined name as a local label'#000+
  '07078_E_','Dollar token is used without an identifier'#000+
  '07079_W_32bit constant created for address'#000+
  '07080_N_.align is target specific, use .balign or .p2align'#000+
  '07081_E_Can'#039't access fields directly for parameters'#000+
  '07082_E_Can'#039't access fields of objects/clas','ses directly'#000+
  '08000_F_Too many assembler files'#000+
  '08001_F_Selected assembler output not supported'#000+
  '08002_F_Comp not supported'#000+
  '08003_F_Direct not support for binary writers'#000+
  '08004_E_Allocating of data is only allowed in bss section'#000+
  '08005_F_No bina','ry writer selected'#000+
  '08006_E_Asm: Opcode $1 not in table'#000+
  '08007_E_Asm: $1 invalid combination of opcode and operands'#000+
  '08008_E_Asm: 16 Bit references not supported'#000+
  '08009_E_Asm: Invalid effective address'#000+
  '08010_E_Asm: Immediate or reference expect','ed'#000+
  '08011_E_Asm: $1 value exceeds bounds $2'#000+
  '08012_E_Asm: Short jump is out of range $1'#000+
  '08013_E_Asm: Undefined label $1'#000+
  '09000_W_Source operating system redefined'#000+
  '09001_I_Assembling (pipe) $1'#000+
  '09002_E_Can'#039't create assember file: $1'#000+
  '09003_E_Can'#039,'t create object file: $1'#000+
  '09004_E_Can'#039't create archive file: $1'#000+
  '09005_W_Assembler $1 not found, switching to external assembling'#000+
  '09006_T_Using assembler: $1'#000+
  '09007_W_Error while assembling exitcode $1'#000+
  '09008_W_Can'#039't call the assembler, error $','1 switching to external'+
  ' assembling'#000+
  '09009_I_Assembling $1'#000+
  '09010_I_Assembling smartlink $1'#000+
  '09011_W_Object $1 not found, Linking may fail !'#000+
  '09012_W_Library $1 not found, Linking may fail !'#000+
  '09013_W_Error while linking'#000+
  '09014_W_Can'#039't call the lin','ker, switching to external linking'#000+
  '09015_I_Linking $1'#000+
  '09016_W_Util $1 not found, switching to external linking'#000+
  '09017_T_Using util $1'#000+
  '09018_E_Creation of Executables not supported'#000+
  '09019_E_Creation of Dynamic/Shared Libraries not supported'#000+
  '09','020_I_Closing script $1'#000+
  '09021_W_resource compiler not found, switching to external mode'#000+
  '09022_I_Compiling resource $1'#000+
  '09023_F_Can'#039't post process executable $1'#000+
  '09024_F_Can'#039't open executable $1'#000+
  '09025_X_Size of Code: $1 bytes'#000+
  '09026_X_Size of i','nitialized data: $1 bytes'#000+
  '09027_X_Size of uninitialized data: $1 bytes'#000+
  '09028_X_Stack space reserved: $1 bytes'#000+
  '09029_X_Stack space commited: $1 bytes'#000+
  '10000_T_Unitsearch: $1'#000+
  '10001_T_PPU Loading $1'#000+
  '10002_U_PPU Name: $1'#000+
  '10003_U_PPU Flags: $1'#000+
  '10','004_U_PPU Crc: $1'#000+
  '10005_U_PPU Time: $1'#000+
  '10006_U_PPU File too short'#000+
  '10007_U_PPU Invalid Header (no PPU at the begin)'#000+
  '10008_U_PPU Invalid Version $1'#000+
  '10009_U_PPU is compiled for an other processor'#000+
  '10010_U_PPU is compiled for an other target'#000+
  '100','11_U_PPU Source: $1'#000+
  '10012_U_Writing $1'#000+
  '10013_F_Can'#039't Write PPU-File'#000+
  '10014_F_Error reading PPU-File'#000+
  '10015_F_unexpected end of PPU-File'#000+
  '10016_F_Invalid PPU-File entry: $1'#000+
  '10017_F_PPU Dbx count problem'#000+
  '10018_E_Illegal unit name: $1'#000+
  '10019_F_Too',' much units'#000+
  '10020_F_Circular unit reference between $1 and $2'#000+
  '10021_F_Can'#039't compile unit $1, no sources available'#000+
  '10022_F_Can'#039't find unit $1'#000+
  '10023_W_Unit $1 was not found but $2 exists'#000+
  '10024_F_Unit $1 searched but $2 found'#000+
  '10025_W_Compiling',' the system unit requires the -Us switch'#000+
  '10026_F_There were $1 errors compiling module, stopping'#000+
  '10027_U_Load from $1 ($2) unit $3'#000+
  '10028_U_Recompiling $1, checksum changed for $2'#000+
  '10029_U_Recompiling $1, source found only'#000+
  '10030_U_Recompiling',' unit, static lib is older than ppufile'#000+
  '10031_U_Recompiling unit, shared lib is older than ppufile'#000+
  '10032_U_Recompiling unit, obj and asm are older than ppufile'#000+
  '10033_U_Recompiling unit, obj is older than asm'#000+
  '10034_U_Parsing interface of $1'#000,
  '10035_U_Parsing implementation of $1'#000+
  '10036_U_Second load for unit $1'#000+
  '10037_U_PPU Check file $1 time $2'#000+
  '11000_$1 [options] <inputfile> [options]'#000+
  '11001_W_Only one source file supported'#000+
  '11002_W_DEF file can be created only for OS/2'#000+
  '11003_E_nes','ted response files are not supported'#000+
  '11004_F_No source file name in command line'#000+
  '11005_N_No option inside $1 config file'#000+
  '11006_E_Illegal parameter: $1'#000+
  '11007_H_-? writes help pages'#000+
  '11008_F_Too many config files nested'#000+
  '11009_F_Unable to open ','file $1'#000+
  '11010_N_Reading further options from $1'#000+
  '11011_W_Target is already set to: $1'#000+
  '11012_W_Shared libs not supported on DOS platform, reverting to static'+
  #000+
  '11013_F_too many IF(N)DEFs'#000+
  '11014_F_too many ENDIFs'#000+
  '11015_F_open conditional at the e','nd of the file'#000+
  '11016_W_Debug information generation is not supported by this executab'+
  'le'#000+
  '11017_H_Try recompiling with -dGDB'#000+
  '11018_E_You are using the obsolete switch $1'#000+
  '11019_E_You are using the obsolete switch $1, please use $2'#000+
  '11020_N_Swit','ching assembler to default source writing assembler'#000+
  '11021_W_Assembler output selected "$1" is not compatible with "$2"'#000+
  '11022_W_"$1" assembler use forced'#000+
  '11023_Free Pascal Compiler version $FPCVER [$FPCDATE] for $FPCTARGET'#010+
  'Copyright (c) 1993','-2000 by Florian Klaempfl'#000+
  '11024_Free Pascal Compiler version $FPCVER'#010+
  #010+
  'Compiler Date  : $FPCDATE'#010+
  'Compiler Target: $FPCTARGET'#010+
  #010+
  'This program comes under the GNU General Public Licence'#010+
  'For more information read COPYING.FPC'#010+
  #010+
  'Report bugs,suggesti','ons etc to:'#010+
  '                 bugrep@freepascal.org'#000+
  '11025_**0*_put + after a boolean switch option to enable it, - to disa'+
  'ble it'#010+
  '**1a_the compiler doesn'#039't delete the generated assembler file'#010+
  '**2al_list sourcecode lines in assembler file'#010+
  '**2a','r_list register allocation/release info in assembler file'#010+
  '**2at_list temp allocation/release info in assembler file'#010+
  '**1b_generate browser info'#010+
  '**2bl_generate local symbol info'#010+
  '**1B_build all modules'#010+
  '**1C<x>_code generation options:'#010+
  '**2CD_cr','eate also dynamic library (not supported)'#010+
  '**2Ch<n>_<n> bytes heap (between 1023 and 67107840)'#010+
  '**2Ci_IO-checking'#010+
  '**2Cn_omit linking stage'#010+
  '**2Co_check overflow of integer operations'#010+
  '**2Cr_range checking'#010+
  '**2Cs<n>_set stack size to <n>'#010+
  '**2Ct_st','ack checking'#010+
  '**2CX_create also smartlinked library'#010+
  '**1d<x>_defines the symbol <x>'#010+
  '*O1D_generate a DEF file'#010+
  '*O2Dd<x>_set description to <x>'#010+
  '*O2Dw_PM application'#010+
  '**1e<x>_set path to executable'#010+
  '**1E_same as -Cn'#010+
  '**1F<x>_set file names and paths',':'#010+
  '**2FD<x>_sets the directory where to search for compiler utilities'#010+
  '**2Fe<x>_redirect error output to <x>'#010+
  '**2FE<x>_set exe/unit output path to <x>'#010+
  '**2Fi<x>_adds <x> to include path'#010+
  '**2Fl<x>_adds <x> to library path'#010+
  '*L2FL<x>_uses <x> as dyn','amic linker'#010+
  '**2Fo<x>_adds <x> to object path'#010+
  '**2Fr<x>_load error message file <x>'#010+
  '**2Fu<x>_adds <x> to unit path'#010+
  '**2FU<x>_set unit output path to <x>, overrides -FE'#010+
  '*g1g_generate debugger information:'#010+
  '*g2gg_use gsym'#010+
  '*g2gd_use dbx'#010+
  '*g2gh_use ','heap trace unit (for memory leak debugging)'#010+
  '*g2gl_use line info unit to show more info for backtraces'#010+
  '*g2gc_generate checks for pointers'#010+
  '**1i_information'#010+
  '**2iD_return compiler date'#010+
  '**2iV_return compiler version'#010+
  '**2iSO_return compiler OS'#010+
  '**2','iSP_return compiler processor'#010+
  '**2iTO_return target OS'#010+
  '**2iTP_return target processor'#010+
  '**1I<x>_adds <x> to include path'#010+
  '**1k<x>_Pass <x> to the linker'#010+
  '**1l_write logo'#010+
  '**1n_don'#039't read the default config file'#010+
  '**1o<x>_change the name of the exec','utable produced to <x>'#010+
  '**1pg_generate profile code for gprof (defines FPC_PROFILE)'#010+
  '*L1P_use pipes instead of creating temporary assembler files'#010+
  '**1S<x>_syntax options:'#010+
  '**2S2_switch some Delphi 2 extensions on'#010+
  '**2Sc_supports operators like C',' (*=,+=,/= and -=)'#010+
  '**2sa_include assertion code.'#010+
  '**2Sd_tries to be Delphi compatible'#010+
  '**2Se<x>_compiler stops after the <x> errors (default is 1)'#010+
  '**2Sg_allow LABEL and GOTO'#010+
  '**2Sh_Use ansistrings'#010+
  '**2Si_support C++ styled INLINE'#010+
  '**2Sm_support ','macros like C (global)'#010+
  '**2So_tries to be TP/BP 7.0 compatible'#010+
  '**2Sp_tries to be gpc compatible'#010+
  '**2Ss_constructor name must be init (destructor must be done)'#010+
  '**2St_allow static keyword in objects'#010+
  '**1s_don'#039't call assembler and linker (only wi','th -a)'#010+
  '**1u<x>_undefines the symbol <x>'#010+
  '**1U_unit options:'#010+
  '**2Un_don'#039't check the unit name'#010+
  '**2Us_compile a system unit'#010+
  '**1v<x>_Be verbose. <x> is a combination of the following letters:'#010+
  '**2*_e : Show errors (default)       d : Show debug in','fo'#010+
  '**2*_w : Show warnings               u : Show unit info'#010+
  '**2*_n : Show notes                  t : Show tried/used files'#010+
  '**2*_h : Show hints                  m : Show defined macros'#010+
  '**2*_i : Show general info           p : Show compiled pr','ocedures'#010+
  '**2*_l : Show linenumbers            c : Show conditionals'#010+
  '**2*_a : Show everything             0 : Show nothing (except errors)'#010+
  '**2*_b : Show all procedure          r : Rhide/GCC compatibility mode'#010+
  '**2*_    declarations if an erro','r    x : Executable info (Win32 only'+
  ')'#010+
  '**2*_    occurs'#010+
  '**1X_executable options:'#010+
  '*L2Xc_link with the c library'#010+
  '**2Xs_strip all symbols from executable'#010+
  '**2XD_try to link dynamic          (defines FPC_LINK_DYNAMIC)'#010+
  '**2XS_try to link static (def','ault) (defines FPC_LINK_STATIC)'#010+
  '**2XX_try to link smart            (defines FPC_LINK_SMART)'#010+
  '**0*_Processor specific options:'#010+
  '3*1A<x>_output format:'#010+
  '3*2Aas_assemble using GNU AS'#010+
  '3*2Aasaout_assemble using GNU AS for aout (Go32v1)'#010+
  '3*2Anasmcoff','_coff (Go32v2) file using Nasm'#010+
  '3*2Anasmelf_elf32 (Linux) file using Nasm'#010+
  '3*2Anasmobj_obj file using Nasm'#010+
  '3*2Amasm_obj file using Masm (Microsoft)'#010+
  '3*2Atasm_obj file using Tasm (Borland)'#010+
  '3*2Acoff_coff (Go32v2) using internal writer'#010+
  '3*2Apecoff','_pecoff (Win32) using internal writer'#010+
  '3*1R<x>_assembler reading style:'#010+
  '3*2Ratt_read AT&T style assembler'#010+
  '3*2Rintel_read Intel style assembler'#010+
  '3*2Rdirect_copy assembler text directly to assembler file'#010+
  '3*1O<x>_optimizations:'#010+
  '3*2Og_generate sm','aller code'#010+
  '3*2OG_generate faster code (default)'#010+
  '3*2Or_keep certain variables in registers'#010+
  '3*2Ou_enable uncertain optimizations (see docs)'#010+
  '3*2O1_level 1 optimizations (quick optimizations)'#010+
  '3*2O2_level 2 optimizations (-O1 + slower optimizati','ons)'#010+
  '3*2O3_level 3 optimizations (same as -O2u)'#010+
  '3*2Op<x>_target processor:'#010+
  '3*3Op1_set target processor to 386/486'#010+
  '3*3Op2_set target processor to Pentium/PentiumMMX (tm)'#010+
  '3*3Op3_set target processor to PPro/PII/c6x86/K6 (tm)'#010+
  '3*1T<x>_Target op','erating system:'#010+
  '3*2TGO32V1_version 1 of DJ Delorie DOS extender'#010+
  '3*2TGO32V2_version 2 of DJ Delorie DOS extender'#010+
  '3*2TLINUX_Linux'#010+
  '3*2TOS2_OS/2 2.x'#010+
  '3*2TWin32_Windows 32 Bit'#010+
  '3*1W<x>_Win32 target options'#010+
  '3*2WB<x>_Set Image base to Hexadecimal <x','> value'#010+
  '3*2WC_Specify console type application'#010+
  '3*2WD_Use DEFFILE to export functions of DLL or EXE'#010+
  '3*2WG_Specify graphic type application'#010+
  '3*2WN_Do not generate relocation code (necessary for debugging)'#010+
  '3*2WR_Generate relocation code'#010+
  '6*1A<x>','_output format'#010+
  '6*2Aas_Unix o-file using GNU AS'#010+
  '6*2Agas_GNU Motorola assembler'#010+
  '6*2Amit_MIT Syntax (old GAS)'#010+
  '6*2Amot_Standard Motorola assembler'#010+
  '6*1O_optimizations:'#010+
  '6*2Oa_turn on the optimizer'#010+
  '6*2Og_generate smaller code'#010+
  '6*2OG_generate faster',' code (default)'#010+
  '6*2Ox_optimize maximum (still BUGGY!!!)'#010+
  '6*2O2_set target processor to a MC68020+'#010+
  '6*1R<x>_assembler reading style:'#010+
  '6*2RMOT_read motorola style assembler'#010+
  '6*1T<x>_Target operating system:'#010+
  '6*2TAMIGA_Commodore Amiga'#010+
  '6*2TATARI_Ata','ri ST/STe/TT'#010+
  '6*2TMACOS_Macintosh m68k'#010+
  '6*2TLINUX_Linux-68k'#010+
  '**1*_'#010+
  '**1?_shows this help'#010+
  '**1h_shows this help without waiting'#000
);
