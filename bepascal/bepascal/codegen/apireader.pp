{   BePascal - A pascal wrapper around the BeOS API                             
    Copyright (C) 2002 Olivier Coursiere                                        
                                                                                
    This library is free software; you can redistribute it and/or               
    modify it under the terms of the GNU Library General Public                 
    License as published by the Free Software Foundation; either                
    version 2 of the License, or (at your option) any later version.            
                                                                                
    This library is distributed in the hope that it will be useful,             
    but WITHOUT ANY WARRANTY; without even the implied warranty of              
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU           
    Library General Public License for more details.                            
                                                                                
    You should have received a copy of the GNU Library General Public           
    License along with this library; if not, write to the Free                  
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   
}                                                                               

unit apireader;

{$H+} // use AnsiStrings

interface

uses
  Classes, SysUtils, xmlread, dom;
  
type
  TNode = class(TObject)
  private
    function GetCount : integer;
    function GetNode(Index : integer) : TNode;
  protected
    FNode : TDOMNode;
    FChildren : TStringList;      
  public
    constructor Create(Node : TDOMNode); virtual;
    destructor Destroy; override;
    procedure Start; virtual;
    procedure Middle; virtual;
    procedure Ends; virtual;
    property Count : integer read GetCount;
    property Nodes[Index : integer] : TNode read GetNode;
  end;
  TClassess = class;
  TDocument = class(TNode)
  private
    function GetClasses(Index : integer) : TClassess;
  protected
  public
    constructor Create(Node : TDOMNode); override;  
    procedure Start; override;
    procedure Middle; override;
    procedure Ends; override;    
    property Classes[Index : integer] : TClassess read GetClasses;
  end;
  TClasse = class;
  TClassess = class(TNode)
  private
    function GetClasse(Index : integer) : TClasse;
  protected
  public
    constructor Create(Node : TDOMNode); override;
    procedure Start; override;
    procedure Middle; override;
    procedure Ends; override;    
    property Classes[Index : integer] : TClasse read GetClasse;
  end;
  TNamedItem = class(TNode)
  private 
  protected
    function GetName : string;
  public
    property Name : string read GetName;  
  end;
  TFunction = class;
  TClasse = class(TNamedItem)
  private    
    function GetFunction(Index : integer) : TFunction;
  protected
    function GetAncestor : string;
  public
    constructor Create(Node : TDOMNode); override;  
    procedure Start; override;
    procedure Ends; override;
    property Ancestor : string read GetAncestor;
    property Functions[Index : integer] : TFunction read GetFunction;
  end;
  TResultType = class;
  TParam = class;  
  TFunction = class(TNamedItem)
  private
    FResultType : TResultType;
    FClasse : TClasse;
    function GetParam(Index : integer) : TParam;
  protected
  public
    constructor Create(Node : TDOMNode); override;  
    destructor Destroy; override;
    function IsConstructor : boolean;
    function IsDestructor : boolean;
    function HasParams : boolean;
    procedure Start; override;
    procedure Ends; override;    
    property ResultType : TResultType read FResultType;
    property Params[Index : integer] : TParam read GetParam;
    property Classe : TClasse read FClasse;
  end;
  TTypedItem = class(TNamedItem)
  private
  protected
    function GetType : string;
  public
    property Typ : string read GetType;
  end;
  TParam = class(TTypedItem)
  private
  protected
  public
    procedure Middle; override;
  end;
  TResultType = class(TNode)
  private
  protected
    function GetType : string;
  public
    property Typ : string read GetType;    
  end;

implementation

uses
  sourcewrite, typmap;
  
// Debug proc
procedure NodeInfo(Node : TDOMNode);
begin
  WriteLn(Node.NodeName + ',' + Node.NodeValue + ',' + IntToStr(Node.NodeType));
end;

constructor TNode.Create(Node : TDOMNode);
begin
  inherited Create;
  FNode := Node;
end;

destructor TNode.Destroy;
var
  i : integer;
begin
  if FChildren <> nil then
  begin
    for i := 0 to FChildren.Count - 1 do
    begin
      if FChildren.Objects[i] <> nil then
        FChildren.Objects[i].Free;
    end;
    FChildren.Free;
  end;
  inherited;
end;

function TNode.GetCount : integer;
begin
  if FChildren <> nil then
    Result := FChildren.Count
  else
    Result := 0;
end;

function TNode.GetNode(Index : integer) : TNode;
begin
  Result := FChildren.Objects[Index] as TNode;
end;

procedure TNode.Start;
begin
  Write('Start : '); 
  if FNode <> nil then
    NodeInfo(FNode); 
end;

procedure TNode.Middle;
var
  i : integer;
begin
  Write('Middle : '); 
  if FNode <> nil then  
  begin
    NodeInfo(FNode); 
    for i := 0 to Count - 1 do
    begin
      Nodes[i].Start;
      Nodes[i].Middle;
      Nodes[i].Ends;
    end;
  end;
end;

procedure TNode.Ends;
begin
  Write('Ends : '); 
  if FNode <> nil then
    NodeInfo(FNode); 
end;

constructor TDocument.Create(Node : TDOMNode);
var
  i : integer;
  aClasses : TClassess;
  List : TStringList;
begin
  if Node.HasChildNodes then
  begin
    List := TStringList.Create;
    for i := 0 to Node.ChildNodes.count - 1 do
    begin
      aClasses := TClassess.Create(Node.ChildNodes.Item[i]);
      List.AddObject(IntToStr(i), aClasses);
    end;
    FChildren := List; 
  end;
end;

function TDocument.GetClasses(Index : integer) : TClassess;
begin
  Result := FChildren.Objects[Index] as TClassess;
end;

procedure TDocument.Start;
begin
end;

procedure TDocument.Middle;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
  begin
    Classes[i].Start;
    Classes[i].Middle;
    Classes[i].Ends;
  end;
end;

procedure TDocument.Ends;
begin
end;
 
constructor TClassess.Create(Node : TDOMNode);
var
  i : integer;
  aClasse : TClasse;
  List : TStringList;
begin
  inherited;
  if Node.HasChildNodes then
  begin
    List := TStringList.Create;
    for i := 0 to Node.ChildNodes.count - 1 do
    begin
      aClasse := TClasse.Create(Node.ChildNodes.Item[i]);
      List.AddObject(aClasse.Name, aClasse);
    end;
    FChildren := List; 
  end;
end;

function TClassess.GetClasse(Index : integer) : TClasse;
begin
  Result := FChildren.Objects[Index] as TClasse;
end;

function TNamedItem.GetName : string;
var
  DomNode : TDOMNode;
begin
  DomNode := FNode.Attributes.GetNamedItem('NAME');
  if DomNode <> nil then
  begin
    Result := DomNode.NodeValue;
  end;
end;

procedure TClassess.Start;
begin
  SourceWriter.Pas.Add('');
end;

procedure TClassess.Middle;
var
  i : integer;
begin
  for i := 0 to Count - 1 do
  begin
    Nodes[i].Start;
    Nodes[i].Middle;
    Nodes[i].Ends;
  end;
end;

procedure TClassess.Ends;
begin
end;

constructor TClasse.Create(Node : TDOMNode);
var
  i : integer;
  aFunc : TFunction;
  List : TStringList;
begin
  inherited;
  if Node.HasChildNodes then
  begin
    List := TStringList.Create;
    for i := 0 to Node.ChildNodes.count - 1 do
    begin
      aFunc := TFunction.Create(Node.ChildNodes.Item[i]);
      aFunc.FClasse := Self;
      WriteLn(aFunc.Name);
      WriteLn('');
      List.AddObject(aFunc.Name, aFunc);
    end;
    FChildren := List; 
  end;  
end;

function TClasse.GetAncestor : string;
begin
  if FNode.Attributes.GetNamedItem('ANCESTOR') <> nil then
    Result := FNode.Attributes.GetNamedItem('ANCESTOR').NodeValue
  else
    Result := '';
end;

function TClasse.GetFunction(Index : integer) : TFunction;
begin
  Result := FChildren.Objects[Index] as TFunction;
end;

procedure TClasse.Start;
begin
  with SourceWriter.InterfacePas do
  begin
    Add('type');
    Add(Format('  %s = class(%s)', [CppToPas(Name + ' *'), CppToPas(Ancestor + ' *')]));
    Add('  private');
    Add('  public');
  end;
end;

procedure TClasse.Ends;
begin
  with SourceWriter.InterfacePas do
  begin
    Add('  end;');
  end;
end;

constructor TFunction.Create(Node : TDOMNode);
var
  i : integer;
  aParam : TParam;
  List : TStringList;
begin
  inherited;
  if Node.HasChildNodes then
  begin
    List := TStringList.Create;
    for i := 0 to Node.ChildNodes.count - 1 do
    begin
      if Node.ChildNodes.Item[i].Attributes.GetNamedItem('NAME') <> nil then
      begin
        aParam := TParam.Create(Node.ChildNodes.Item[i]);
        WriteLn('Param : ' + aParam.Name + '; ' + 'Type : ' + aParam.Typ);
        List.AddObject(aParam.Name, aParam);
      end
      else
      begin
        FResultType := TResultType.Create(Node.ChildNodes.Item[i]);
        WriteLn('ResultType : ' + FResultType.Typ);
      end;
    end;
    FChildren := List; 
  end;  
end;

destructor TFunction.Destroy;
begin
  if Assigned(FResultType) then
    FResultType.Free;
  inherited;
end;

function TFunction.IsConstructor : boolean;
begin
  Result := (Name = Classe.Name);
end;

function TFunction.IsDestructor : boolean;
begin
  Result := (Name[1] = '~');
end;

function TFunction.GetParam(Index : integer) : TParam;
begin
  Result := FChildren.Objects[Index] as TParam;
end;

function TFunction.HasParams : boolean;
begin
  Result := (Count > 0);
end;

procedure TFunction.Start;
var
  EndChar : string;
begin
  WriteLn('Function Start');
  if HasParams then
    EndChar := '('
  else
    EndChar := '';
  with SourceWriter.InterfacePas do
  begin
    if IsConstructor then
      Add(Format('    constructor %s%s', [Name, EndChar]))
    else if IsDestructor then
      Add(Format('    destructor %s%s', [Name, EndChar]))
    else if (ResultType.Typ = '') or (ResultType.Typ = 'void') then
      Add(Format('    procedure %s%s', [Name, EndChar]))
    else
      Add(Format('    function %s%s', [Name, EndChar]));
  end;
end;

procedure TFunction.Ends;
var
  s : string;
  EndChar : string;
begin
  WriteLn('Function ends');
  if hasParams then
  begin
    EndChar := ')';
    with SourceWriter.InterfacePas do
    begin
      // Delete the last '; '
      s := Strings[Count - 1];
      System.Delete(s, Length(s) - 1, 2);
      Strings[Count - 1] := s;
    end;
  end
  else
  begin
    EndChar := '';
  end;
  with SourceWriter.InterfacePas do
  begin
    if not((ResultType.Typ = '') or (ResultType.Typ = 'void')) then
    begin
      WriteLn(ResultType.Typ);
      WriteLn(Name);
      s := Format('%s%s : %s;', [Strings[Count - 1], EndChar, CppToPas(ResultType.Typ)]);
      Strings[Count - 1] := s;
    end
    else
      Strings[Count - 1] := Format('%s%s;', [Strings[Count - 1], EndChar]);
  end;
end;

function TTypedItem.GetType : string;
begin
  Result := FNode.Attributes.GetNamedItem('TYPE').NodeValue;
end;

procedure TParam.Middle;
var
  s : string;
begin
  WriteLn('Param Middle');
  with SourceWriter.InterfacePas do
  begin
    WriteLn(Strings[Count - 1]);
    s := Format('%s%s : %s; ', [Strings[Count - 1], Name, CppToPas(Typ)]);
    Strings[Count - 1] := s;
    WriteLn(Strings[Count - 1]);    
  end;
end;

function TResultType.GetType : string;
begin
  Result := FNode.Attributes.GetNamedItem('TYPE').NodeValue;
end;

end.
