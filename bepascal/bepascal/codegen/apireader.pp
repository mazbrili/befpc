unit apireader;

interface

uses
  xmlread, dom;
  
type
  TNode = class(TObject)
  private
    FNode : TDOMNode;
  public
    constructor Create(Node : TDOMNode); virtual;
  end;
  TClassess = class(TNode)
  private
  protected
  public
  end;
  TNamedItem = class(TNode)
  private
  protected
    function GetName : string;
  public
    property Name : string read GetName;  
  end;

  TClasse = class(TNamedItem)
  private
  protected
  public
  end;
  TFunction = class(TNamedItem)
  private
  protected
  public
    function IsDestructor : boolean;
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
  end;
  TResultType = class(TNode)
  private
  protected
    function GetType : string;
  public
    property Typ : string read GetType;    
  end;

implementation

constructor TNode.Create(Node : TDOMNode);
begin
  inherited Create;
  FNode := Node;
end;

function TNamedItem.GetName : string;
begin
  Result := FNode.Attributes.GetNamedItem('NAME').NodeValue;
end;

function TFunction.IsDestructor : boolean;
begin
  Result := (Name[1] = '~');
end;

function TTypedItem.GetType : string;
begin
  Result := FNode.Attributes.GetNamedItem('TYPE').NodeValue;
end;

function TResultType.GetType : string;
begin
  Result := FNode.Attributes.GetNamedItem('TYPE').NodeValue;
end;

end.
