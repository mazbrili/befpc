program hookgen;

{$H+} // use AnsiStrings

uses
  Classes, SysUtils, xmlread, DOM;

const
  Eol = #10;
  StartExternalC = '#if defined(__cplusplus)' + Eol +
                   'extern "C" {' + Eol+
                   '#endif' + Eol;
                   
  EndExternalC = '#if defined(__cplusplus)' + Eol +
                  '}' + Eol +
                  '#endif';
  
type
  TSourceWriter = class(TObject)
  private
    FH : TStringList;
    FCpp : TStringList;
    FPas : TStringList;
    FTypMap : TStringList;
    FFileName : string;
  public
    constructor Create(FileName : string); virtual;
    destructor Destroy; override;
    property H : TStringList read FH;
    property Cpp : TStringList read FCpp;
    property Pas : TStringList read FPas;
    property TypMap : TStringList read FTypMap;
  end;
  
constructor TSourceWriter.Create(FileName : string);
begin
  inherited Create;
  FFileName := FileName;
  FH := TStringList.Create;
  FCpp := TStringList.Create;
  FPas := TStringList.Create;  
  FTypMap := TStringList.Create;
  FTypMap.LoadFromFile('typemap.txt');
end;

destructor TSourceWriter.Destroy;
begin
  FH.SaveToFile(FFileName + '.h');
  FH.Free;
  FCpp.SaveToFile(FFileName + '.cpp');
  FCpp.Free;
  FPas.SaveToFile(FFileName + '.pas');
  FPas.Free;
  FTypMap.Free;
  inherited;
end;

type  
  TClasse = class; 
  TFunction = class(TObject)
  private
    FName : string;
    FParent : TClasse;
    FParams : TStringList;
    FResultType : string;
  public
    constructor Create(Parent : TClasse; FunctionName : string); virtual;
    destructor Destroy; override;
    function GetPascalParams(TypMap : TStringList) : string;
    function GetCppParams(StartWithComma : boolean) : string;
    function GetCppParamNames(StartWithComma : boolean) : string;
    function PascalHookVar(TypMap : TStringList) : string;
    function PascalInit(TypMap : TStringList) : string;
    function PascalHookImpl(TypMap : TStringList) : string;
    function PascalHookDecl(TypMap : TStringList) : string;
    function CppTypedef : string;
    function CppVarDecl : string;
    function CppClassDecl : string;
    function CppHookImpl : string;
    property Name : string read FName write FName;
    property Params : TStringList read FParams write FParams;
    property ResultType : string read FResultType write FResultType;
  end;
  
  TClasse = class(TObject)
  private
    FTypeName : string;
    FAncestor : string;    
    FHookFunctions : TStringList;   
    function GetName : string;
    function GetAncestorName : string;
  public	
    constructor Create(ClasseName : string); virtual;
    destructor Destroy; override;
    property TypeName : string read FTypeName write FTypeName;
    property Name : string read GetName;
    property Ancestor : string read FAncestor write FAncestor;
    property AncestorName : string read GetAncestorName;
    property HookFunctions : TStringList read FHookFunctions write FHookFunctions;
    function PascalClasse(TypMap : TStringList) : string;
    function PascalHookVar(TypMap : TStringList) : string;
    function PascalHookDecl(TypMap : TStringList) : string;
    function PascalHookImpl(TypMap : TStringList) : string;
    function PascalInit(TypMap : TStringList) : string;
    function CppTypedef : string;
    function CppVarDecl : string;
    function CppClassDecl : string;
    function CppHookImpl : string;
  end;

// TFunction ---------------------------------------------------------
  
constructor TFunction.Create(Parent : TClasse; FunctionName : string);
begin
  inherited Create;
  FName := FunctionName;
  FParams := TStringList.Create;  
  FParent := Parent;
end;

destructor TFunction.Destroy;
begin
  FParams.Free;
  inherited;
end;

function TFunction.GetPascalParams(TypMap : TStringList) : string;
  function FormatParams : string;
  var
    i : integer;
  begin
    Result := '';
    for i := 0 to FParams.Count - 1 do
    begin
      if i > 0 then
        Result := Result + '; ';
      if FParams.Names[i] <> '' then
        Result := Result + Format('%s : %s', [FParams.Names[i], TypMap.Values[FParams.Values[FParams.Names[i]]] ]);
    end;
  end;
begin
  if FParams.Count = 0 then
    Result := ''
  else
  begin
    Result := Format('%s', [FormatParams]);
  end;
end;

function TFunction.PascalHookVar(TypMap : TStringList) : string;
begin
  Result := Format('  %s_%s_hook : Pointer; cvar; external;', [FParent.Name, Name]);
end;

function TFunction.PascalInit(TypMap : TStringList) : string;
begin
  Result := Format('  %s_%s_hook := @%s_%s_hook_func;', [FParent.Name, Name, FParent.Name, Name]);
end;

function TFunction.PascalHookDecl(TypMap : TStringList) : string;
  function CommaIfNotEmpty(s : string) : string;
  begin
    if s <> '' then
      Result := ', '
    else
      Result := '';
  end;
begin
  Result := '';
  Result := Format('  function %s_%s_hook(%s : %s%s%s);', 
                   [FParent.TypeName, Name, FParent.Name, 'T' + FParent.Name, 
                    CommaIfNotEmpty(GetPascalParams(TypMap)), GetPascalParams(TypMap)]) + 
                    Format(' cdecl; external BePascalLibName name ''%s_%s'';',
                           [FParent.TypeName, Name]);
end;

function TFunction.PascalHookImpl(TypMap : TStringList) : string;
begin
  Result := '';
end;

function TFunction.GetCppParams(StartWithComma : boolean) : string;
  function FormatParams : string;
  var
    i : integer;
  begin
    Result := '';
    for i := 0 to FParams.Count - 1 do
    begin
      if (i > 0) then
        Result := Result + ', ';
      if FParams.Names[i] <> '' then
        Result := Result + Format('%s%s', [FParams.Values[FParams.Names[i]], FParams.Names[i] ]);
    end;
  end;
begin
  if FParams.Count = 0 then
    Result := ''
  else
  begin
    if (FormatParams <> '') and StartWithComma then
      Result := Format(', %s', [FormatParams])
    else if FormatParams <> '' then
      Result := Format('%s', [FormatParams])    
    else if StartWithComma then
      Result := ''
    else
      Result := 'void';
  end;
end;

function TFunction.GetCppParamNames(StartWithComma : boolean) : string;
  function FormatParamNames : string;
  var
    i : integer;
  begin
    Result := '';
    for i := 0 to FParams.Count - 1 do
    begin
      if (i > 0) then
        Result := Result + ', ';
      if FParams.Names[i] <> '' then
        Result := Result + Format('%s', [FParams.Names[i] ]);
    end;
  end;
begin
  if FParams.Count = 0 then
    Result := ''
  else
  begin
    if (FormatParamNames <> '') and StartWithComma then
      Result := Format(', %s', [FormatParamNames])
    else if FormatParamNames <> '' then
      Result := Format('%s', [FormatParamNames])    
    else if StartWithComma then
      Result := ''
    else
      Result := 'void';
  end;
end;

function TFunction.CppTypedef : string;
begin
  Result := Format('typedef %s (*%s_%s_hook) (TPasObject PasObject%s);', 
                   [ResultType, FParent.TypeName, Name, GetCppParams(True)]);
end;

function TFunction.CppVarDecl : string;
begin
  Result := Format('%s_%s_hook %s_%s_hook;', [FParent.TypeName, Name, FParent.Name, Name]);
end;

function TFunction.CppClassDecl : string;
begin
  Result := Format('		virtual %s %s(%s);', [ResultType, Name, GetCppParams(False)]);
end;

function TFunction.CppHookImpl : string;
begin
  Result := Format('%s BP%s::%s(%s)', 
                   [ResultType, FParent.Name, Name, GetCppParams(False)]) + Eol;
  Result := Result + '{' + Eol;
  if ResultType <> 'void' then
    Result := Result + Format('	return %s_%s_hook(GetPasObject()%s);', 
                              [FParent.Name, Name, GetCppParamNames(True)])
  else
    Result := Result + Format('	%s_%s_hook(GetPasObject()%s);', 
                              [FParent.Name, Name, GetCppParamNames(True)]);    
  Result := Result + Eol + '}' + Eol;
end;

// TClasse -------------------------------------

constructor TClasse.Create(ClasseName : string);
begin
  inherited Create;
  FTypeName := ClasseName;
  FHookFunctions := TStringList.Create;    
end;

destructor TClasse.Destroy;
var
  i : integer;
begin
  for i := 0 to FHookFunctions.Count - 1 do
    FHookFunctions.Objects[i].Free;
  FHookFunctions.Free;
  inherited;
end;

function TClasse.GetName : string;
begin
  Result := TypeName;
    // Delete the first letter in the C++ type name
  Delete(Result, 1, 1);  
end;

function TClasse.GetAncestorName : string;
begin
  Result := Ancestor;
    // Delete the first letter in the C++ type name
  Delete(Result, 1, 1);  
end;

function TClasse.PascalClasse(TypMap : TStringList) : string;
var
  i : integer;
begin
    // We add ' *' to the ancestor to find the corresponding type in the type map
  Result := Format('  T%s = class(%s)', [Name, TypMap.Values[Self.Ancestor + ' *']]);
  Result := Result + Eol + '    // Hook functions';
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + Eol + Format('    procedure %s(%s); virtual;', [HookFunctions[i], TFunction(Self.HookFunctions.Objects[i]).GetPascalParams(TypMap)]);
  end;
  Result := Result + Eol + '  end;';
  WriteLn(Result);
end;

function TClasse.PascalHookVar(TypMap : TStringList) : string;
var
  i : integer;
begin
  Result := 'var';
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + Eol + TFunction(Self.HookFunctions.Objects[i]).PascalHookVar(TypMap);
  end;
  WriteLn(Result);
end;

function TClasse.PascalInit(TypMap : TStringList) : string;
var
  i : integer;
begin
  Result := 'initialization' + Eol;
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + TFunction(Self.HookFunctions.Objects[i]).PascalInit(TypMap) + Eol;
  end;
  WriteLn(Result);
end;

function TClasse.PascalHookDecl(TypMap : TStringList) : string;
var
  i : integer;
begin
  Result := 'var' + Eol;
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + TFunction(Self.HookFunctions.Objects[i]).PascalHookDecl(TypMap) + Eol;
  end;
end;

function TClasse.PascalHookImpl(TypMap : TStringList) : string;
begin
  Result := '';
end;

function TClasse.CppTypedef : string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + TFunction(Self.HookFunctions.Objects[i]).CppTypedef + Eol;
  end;
end;

function TClasse.CppVarDecl : string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + TFunction(Self.HookFunctions.Objects[i]).CppVarDecl + Eol;
  end;
end;

function TClasse.CppClassDecl : string;
var
  i : integer;
begin
  Result := Format('class BP%s : public %s, public BP%s', 
                   [Name, TypeName, AncestorName]) + Eol;
  Result := Result + '{' + Eol;
  Result := Result + '	public:' + Eol;
  Result := Result + '		// <BView_Constructor>' + Eol;
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + TFunction(Self.HookFunctions.Objects[i]).CppClassDecl + Eol;  
  end;  
  Result := Result + '	private:' + Eol;
  Result := Result + '}' + Eol;
end;

function TClasse.CppHookImpl : string;
var
  i : integer;
begin
  Result := '';
  for i := 0 to HookFunctions.Count - 1 do
  begin
    Result := Result + TFunction(Self.HookFunctions.Objects[i]).CppHookImpl + Eol;  
  end;    
end;

//****************************************************************************************

procedure NodeInfo(Node : TDOMNode);
begin
  WriteLn(Node.NodeName + ',' + Node.NodeValue + ',' + IntToStr(Node.NodeType));
end;

function HandleParams(Node : TDOMNode; Parent : TClasse) : TFunction;
var
  paramtmp : TDOMNode;
begin
  Result := TFunction.Create(Parent, Node.Attributes.GetNamedItem('NAME').NodeValue);
  paramtmp := Node.FirstChild.FirstChild;
  Result.Params.Values[paramtmp.Attributes.GetNamedItem('NAME').NodeValue] := paramtmp.Attributes.GetNamedItem('TYPE').NodeValue;
  while paramtmp.NextSibling <> nil do
  begin
    paramtmp := paramtmp.NextSibling;
    Result.Params.Values[paramtmp.Attributes.GetNamedItem('NAME').NodeValue] := paramtmp.Attributes.GetNamedItem('TYPE').NodeValue;    
  end;
  Result.ResultType := Node.FindNode('RESULT').Attributes.GetNamedItem('TYPE').NodeValue;
  WriteLn('FunctionName : ' + Result.Name);  
  WriteLn(Result.Params.Text);
  WriteLn('Result = ' + Result.ResultType);  
  WriteLn('');
end;

function HandleClasse(Node : TDOMNode) : TClasse;
var
  hooktmp : TDOMNode;
begin
  Result := TClasse.Create(Node.Attributes.GetNamedItem('NAME').NodeValue);
  if Node.Attributes.GetNamedItem('ANCESTOR') <> nil then
    Result.Ancestor := Node.Attributes.GetNamedItem('ANCESTOR').NodeValue;
  hooktmp := Node.FirstChild.FirstChild;
  Result.HookFunctions.AddObject(hooktmp.Attributes.GetNamedItem('NAME').NodeValue, HandleParams(hooktmp, Result));
  while hooktmp.NextSibling <> nil do
  begin
    hooktmp := hooktmp.NextSibling;
    Result.HookFunctions.AddObject(hooktmp.Attributes.GetNamedItem('NAME').NodeValue, HandleParams(hooktmp, Result));
  end;
  WriteLn('ClasseName : ' + Result.TypeName);
  WriteLn(Result.HookFunctions.Text);
end;

//****************************************************************************************

var
  ADoc : TXMLDocument;
  tmp : TDOMNode;
  classe : TClasse;
  ClassesList : TStringList;
  i : integer;
  srcWriter : TSourceWriter;
begin
  ReadXMLFile(ADoc, 'hooks.xml');
  ClassesList := TStringList.Create;
  try
  NodeInfo(ADoc);
    // root -> BEOSAPI
  NodeInfo(ADoc.DocumentElement);
    // -> CLASSES
  NodeInfo(ADoc.DocumentElement.FirstChild);
    // -> CLASSE
  NodeInfo(ADoc.DocumentElement.FirstChild.FirstChild);
    // -> CLASSE NAME=
  NodeInfo(ADoc.DocumentElement.FirstChild.FirstChild.Attributes.GetNamedItem('NAME'));
  tmp := ADoc.DocumentElement.FirstChild.FirstChild;
  Classe := HandleClasse(tmp);
  ClassesList.AddObject(Classe.TypeName, Classe);
  while tmp.NextSibling <> nil do
  begin
    tmp := tmp.NextSibling;
    Classe := HandleClasse(tmp);
    ClassesList.AddObject(Classe.TypeName, Classe);
  end;
    // -> HOOKS
  NodeInfo(ADoc.DocumentElement.FirstChild.FirstChild.FirstChild);  
    // -> HOOKFUNCTION
  NodeInfo(ADoc.DocumentElement.FirstChild.FirstChild.FirstChild.FirstChild);  
  NodeInfo(ADoc.DocumentElement.FirstChild.FirstChild.FirstChild.FirstChild.FirstChild);      
  
  // -------------------------------
  // Generating source files
  // -------------------------------
  
  WriteLn('<Begining Pascal code>');
  srcWriter := TSourceWriter.Create('looper');
  try
    with srcWriter.Pas do
    begin
      Add('type');    
      Add(TClasse(ClassesList.objects[0]).PascalClasse(srcWriter.TypMap));
      Add('');
      Add(TClasse(ClassesList.Objects[0]).PascalHookDecl(srcWriter.TypMap));
      Add('implementation' + Eol);
      Add(TClasse(ClassesList.objects[0]).PascalHookVar(srcWriter.TypMap));
      Add('');      
      Add(TClasse(ClassesList.objects[0]).PascalInit(srcWriter.TypMap));

      Add('type');
      Add(TClasse(ClassesList.objects[1]).PascalClasse(srcWriter.TypMap));
      Add('');
      Add(TClasse(ClassesList.Objects[1]).PascalHookDecl(srcWriter.TypMap));
      Add('implementation' + Eol);
      Add(TClasse(ClassesList.objects[1]).PascalHookVar(srcWriter.TypMap));    
      Add('');      
      Add(TClasse(ClassesList.objects[1]).PascalInit(srcWriter.TypMap));
    end;
    with srcWriter.Cpp do
    begin
      Add(TClasse(ClassesList.Objects[0]).CppTypedef);
      Add(StartExternalC);
      Add(TClasse(ClassesList.Objects[0]).CppVarDecl);
      Add(EndExternalC);
      Add('');
      Add(TClasse(ClassesList.Objects[0]).CppClassDecl);
      Add(TClasse(ClassesList.Objects[0]).CppHookImpl);
    end;
  finally
    srcWriter.Free;
  end;
  finally
    ADoc.Free;
    for i := 0 to ClassesList.Count - 1 do
      ClassesList.Objects[i].Free;
    ClassesList.Free;
  end;
end.
