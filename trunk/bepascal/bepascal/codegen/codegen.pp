program codegen;

uses
  dom, xmlread, apireader;

var
  aDoc : TXMLDocument;
  Classes : TClassess;
begin
  if ParamCount > 0 then
  begin
    ReadXMLFile(aDoc, Paramstr(1));
    Classes := TClassess.Create(aDoc);
    try
    finally
      Classes.Free;
    end;
  end;

end.
