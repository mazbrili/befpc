program typenum;

uses
  SysUtils, Classes, xmlread, DOM;

procedure NodeInfo(Node : TDOMNode);
begin
  WriteLn(Node.NodeName + ',' + Node.NodeValue + ',' + IntToStr(Node.NodeType));
end;

var
  ADoc : TXMLDocument;
  TypeList : TStringList;  
  classeNode, fonction : TDOMNode;
  list : TDOMNodeList;
  i : integer;
begin
  ReadXMLFile(ADoc, 'hooks.xml');
  TypeList := TStringList.Create;
  try
    classeNode := ADoc.FirstChild.FirstChild.FirstChild;
    NodeInfo(classeNode);
    while classeNode <> nil do
    begin
      fonction := classeNode.FirstChild.FirstChild;
      Write('Toto : ');
      NodeInfo(fonction);
      while fonction <> nil do 
      begin
        list := fonction.FirstChild.ChildNodes;
        WriteLn(IntToStr(list.Count));
        for i := 0 to list.Count - 1 do
        begin
          WriteLn(list.item[i].NodeValue + ';' + list.item[i].NodeName);
          TypeList.Values[list.item[i].Attributes.GetNamedItem('TYPE').NodeValue] := '';    
        end;
        NodeInfo(fonction.FindNode('RESULT'));
        TypeList.Values[fonction.FindNode('RESULT').Attributes.GetNamedItem('TYPE').NodeValue] := '';
        fonction := fonction.NextSibling;
      end;
      classeNode := classeNode.NextSibling;
    end;
  finally
    TypeList.SaveToFile('typemap.txt');  
    list.Release;
    TypeList.Free;
  end;
end.