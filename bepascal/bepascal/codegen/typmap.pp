unit typmap;

interface

uses
  SysUtils, Classes;

function CppToPas(CppType : string) : string;
function PasToCpp(PasType : string) : string;
  
implementation

const
  TypMapFileName = 'typemap.txt';
var
  aTypMap : TStringList;

function CppToPas(CppType : string) : string;
begin
  Result := aTypMap.Values[CppType];
//  if Result = '' then
//    aTypMap.Values[CppType] := '';
end;

function PasToCpp(PasType : string) : string;
begin
    // To implement if necessary
  Result := '';
end;

initialization
  aTypMap := TStringList.Create;
  aTypMap.LoadFromFile(TypMapFileName);
  aTypMap.Sorted := True;
  
finalization
//  WriteLn(aTypMap.Text);
  aTypMap.SaveToFile(TypMapFileName);
  aTypMap.Free;

end.
