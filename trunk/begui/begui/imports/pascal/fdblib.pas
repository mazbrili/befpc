unit fdblib;

interface

{$linklib 'fdb'}

uses
  begui;

procedure SendText(text: pchar);cdecl; external;

procedure force;

implementation

procedure force;
begin
  writeln('force');
end;

initialization
  SendText('----------------------');
  SendText('App start');

finalization
  SendText('App end');

end.