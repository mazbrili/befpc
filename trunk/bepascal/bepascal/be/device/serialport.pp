{  BePascal - A pascal wrapper around the BeOS API
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
unit serialport;

interface

uses
  beobj, SupportDefs, os;
  
type
    // Pascal enum start at 0 (like in C++). We are lucky because we can't
    // initialize enum values yet (?) in FreePascal ;-)
  TDataRate = (B_0_BPS, B_50_BPS, B_75_BPS, B_110_BPS, B_134_BPS,
               B_150_BPS, B_200_BPS, B_300_BPS, B_600_BPS, B_1200_BPS,
               B_1800_BPS, B_2400_BPS, B_4800_BPS, B_9600_BPS, B_19200_BPS,
               B_38400_BPS, B_57600_BPS, B_115200_BPS, 
               B_230400_BPS, B_31250_BPS);
               
  TDataBits = (B_DATA_BITS_7, B_DATA_BITS_8);
  
  TStopBits = (B_STOP_BITS_1, B_STOP_BITS_2);
  
  TParityMode = (B_NO_PARITY, B_ODD_PARITY, B_EVEN_PARITY);

const
  B_NOFLOW_CONTROL = 0;
  B_HARDWARE_CONTROL = 1; 
  B_SOFTWARE_CONTROL = 2;
               
type
  TSerialPort = class(TBeObject)
  private
  public
    constructor Create; override;
    destructor Destroy; override;
    function Open(portName : PChar) : TStatus_t;
    procedure Close;
    
    function Read(buf : PChar; count : TSize_t) : TSSize_t;
    function Write(const buf : PChar; count : TSize_t) : TSSize_t;
    
    procedure SetBlocking(Blocking : boolean);
    function SetTimeout(microSeconds : TBigtime_t) : TStatus_t;
    function SetDataRate(bitsPerSecond : TDataRate) : TStatus_t;
    function GetDataRate : TDataRate;
    procedure SetDataBits(numBits : TDataBits);
    function GetDataBits : TDataBits;
    procedure SetStopBits(numBits : TStopBits);
    function GetStopBits : TStopBits;
    procedure SetParityMode(numBits : TParityMode);
    function GetParityMode : TParityMode;
    procedure ClearInput;
    procedure ClearOutput;
    
    procedure SetFlowControl(method : Cardinal);
    function GetFlowControl : Cardinal;
    function SetDTR(asserted : boolean) : TStatus_t;
    function SetRTS(asserted : boolean) : TStatus_t;    
    function NumCharsAvailable(var wait_until_this_many : integer) : TStatus_t;
    
    function IsCTS : boolean;
    function IsDSR : boolean;
    function IsRI : boolean;
    function IsDCD : boolean;
    function WaitForInput : TSSize_t;    
    
    function CountDevices : integer;
    function GetDeviceName(n : integer; name : PChar; bufSize : TSize_t) : TStatus_t;
    
    property DataRate : TDataRate read GetDataRate write SetDataRate;
    property DataBits : TDataBits read GetDataBits write SetDataBits;
    property StopBits : TStopBits read GetStopBits write SetStopBits;    
    property ParityMode : TParityMode read GetParityMode write SetParityMode;
  end;

function BSerialPort_Create(AObject : TBeObject) : TCPlusObject; cdecl; external BePascalLibName name 'BSerialPort_Create';
procedure BSerialPort_Free(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSerialPort_Free';
function BSerialPort_Open(AObject : TCPlusObject; portName : PChar) : TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_Open';
procedure BSerialPort_Close(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSerialPort_Close';
function BSerialPort_Read(AObject : TCPlusObject; buf : PChar; count : TSize_t) : TSSize_t; cdecl; external BePascalLibName name 'BSerialPort_Read';
function BSerialPort_Write(AObject : TCPlusObject; const buf : PChar; count : TSize_t) : TSSize_t; cdecl; external BePascalLibName name 'BSerialPort_Write';
procedure BSerialPort_SetBlocking(AObject : TCPlusObject; Blocking : boolean); cdecl; external BePascalLibName name 'BSerialPort_SetBlocking';
function BSerialPort_SetTimeout(AObject : TCPlusObject; microSeconds : TBigtime_t) : TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_SetTimeout';
function BSerialPort_SetDataRate(AObject : TCPlusObject; bitsPerSecond : TDataRate) : TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_SetDataRate';
function BSerialPort_DataRate(AObject : TCPlusObject) : TDataRate; cdecl; external BePascalLibName name 'BSerialPort_DataRate';
procedure BSerialPort_SetDataBits(AObject : TCPlusObject; numBits : TDataBits); cdecl; external BePascalLibName name 'BSerialPort_SetDataBits';
function BSerialPort_DataBits(AObject : TCPlusObject) : TDataBits; cdecl; external BePascalLibName name 'BSerialPort_DataBits';
procedure BSerialPort_SetStopBits(AObject : TCPlusObject; numBits : TStopBits); cdecl; external BePascalLibName name 'BSerialPort_SetStopBits';
function BSerialPort_StopBits(AObject : TCPlusObject) : TStopBits; cdecl; external BePascalLibName name 'BSerialPort_StopBits';
procedure BSerialPort_SetParityMode(AObject : TCPlusObject; numBits : TParityMode); cdecl; external BePascalLibName name 'BSerialPort_SetParityMode';
function BSerialPort_ParityMode(AObject : TCPlusObject) : TParityMode; cdecl; external BePascalLibName name 'BSerialPort_ParityMode';
procedure BSerialPort_ClearInput(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSerialPort_ClearInput';
procedure BSerialPort_ClearOutput(AObject : TCPlusObject); cdecl; external BePascalLibName name 'BSerialPort_ClearOutput';
procedure BSerialPort_SetFlowControl(AObject : TCPlusObject; method : Cardinal); cdecl; external BePascalLibName name 'BSerialPort_SetFlowControl';
function BSerialPort_FlowControl(AObject : TCPlusObject) : Cardinal; cdecl; external BePascalLibName name 'BSerialPort_FlowControl';
function BSerialPort_SetDTR(AObject : TCPlusObject; asserted : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_SetDTR';
function BSerialPort_SetRTS(AObject : TCPlusObject; asserted : boolean) : TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_SetRTS';
function BSerialPort_NumCharsAvailable(AObject : TCPlusObject; var wait_until_this_many : integer) : TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_NumCharsAvailable';
function BSerialPort_IsCTS(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BSerialPort_IsCTS';
function BSerialPort_IsDSR(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BSerialPort_IsDSR';
function BSerialPort_IsRI(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BSerialPort_IsRI';
function BSerialPort_IsDCD(AObject : TCPlusObject) : boolean; cdecl; external BePascalLibName name 'BSerialPort_IsDCD';
function BSerialPort_WaitForInput(AObject : TCPlusObject) : TSSize_t; cdecl; external BePascalLibName name 'BSerialPort_WaitForInput';
function BSerialPort_CountDevices(AObject : TCPlusObject) : integer; cdecl; external BePascalLibName name 'BSerialPort_CountDevices';
function BSerialPort_GetDeviceName(AObject : TCPlusObject; n : integer; name : PChar; bufSize : TSize_t): TStatus_t; cdecl; external BePascalLibName name 'BSerialPort_GetDeviceName';

implementation

constructor TSerialPort.Create;
begin
  inherited;
  CPlusObject := BSerialPort_Create(Self);
end;

destructor TSerialPort.Destroy;
begin
  if CPlusObject <> nil then
    BSerialPort_Free(CPlusObject);
  inherited;
end;

function TSerialPort.Open(portName : PChar) : TStatus_t;
begin
  result := BSerialPort_Open(CPlusObject, portName); 
end;

procedure TSerialPort.Close;
begin
  BSerialPort_Close(CPlusObject);
end;

function TSerialPort.Read(buf : PChar; count : TSize_t) : TSSize_t;
begin
  Result := BSerialPort_Read(CPlusObject, buf, count);
end;

function TSerialPort.Write(const buf : PChar; count : TSize_t) : TSSize_t;
begin
  Result := BSerialPort_Write(CPlusObject, buf, count);
end;

procedure TSerialPort.SetBlocking(Blocking : boolean);
begin
  BSerialPort_SetBlocking(CPlusObject, Blocking);
end;

function TSerialPort.SetTimeout(microSeconds : TBigtime_t) : TStatus_t;
begin
  Result := BSerialPort_SetTimeout(CPlusObject, microSeconds);
end;

function TSerialPort.SetDataRate(bitsPerSecond : TDataRate) : TStatus_t;
begin
  Result := BSerialPort_SetDataRate(CPlusObject, bitsPerSecond);
end;

function TSerialPort.GetDataRate : TDataRate;
begin
  Result := BSerialPort_DataRate(CPlusObject);
end;

procedure TSerialPort.SetDataBits(numBits : TDataBits);
begin
  BSerialPort_SetDataBits(CPlusObject, numBits);
end;

function TSerialPort.GetDataBits : TDataBits;
begin
  Result := BSerialPort_DataBits(CPlusObject);
end;

procedure TSerialPort.SetStopBits(numBits : TStopBits);
begin
  BSerialPort_SetStopBits(CPlusObject, numBits);
end;

function TSerialPort.GetStopBits : TStopBits;
begin
  Result := BSerialPort_StopBits(CPlusObject);
end;

procedure TSerialPort.SetParityMode(numBits : TParityMode);
begin
  BSerialPort_SetParityMode(CPlusObject, numBits);
end;

function TSerialPort.GetParityMode : TParityMode;
begin
  Result := BSerialPort_ParityMode(CPlusObject);
end;

procedure TSerialPort.ClearInput;
begin
  BSerialPort_ClearInput(CPlusObject);
end;

procedure TSerialPort.ClearOutput;
begin
  BSerialPort_ClearOutput(CPlusObject);
end;

procedure TSerialPort.SetFlowControl(method : Cardinal);
begin
  BSerialPort_SetFlowControl(CPlusobject, method);
end;

function TSerialPort.GetFlowControl : Cardinal;
begin
  Result := BSerialPort_FlowControl(CPlusObject);
end;

function TSerialPort.SetDTR(asserted : boolean) : TStatus_t;
begin
  Result := BSerialPort_SetDTR(CPlusObject, asserted);
end;

function TSerialPort.SetRTS(asserted : boolean) : TStatus_t;
begin
  Result := BSerialPort_SetRTS(CPlusObject, asserted);
end;

function TSerialPort.NumCharsAvailable(var wait_until_this_many : integer) : TStatus_t;
begin
  Result := BSerialPort_NumCharsAvailable(CPlusObject, wait_until_this_many);
end;

function TSerialPort.IsCTS : boolean;
begin
  Result := BSerialPort_IsCTS(CPlusObject);
end;

function TSerialPort.IsDSR : boolean;
begin
  Result := BSerialPort_IsDSR(CPlusObject);
end;

function TSerialPort.IsRI : boolean;
begin
  Result := BSerialPort_IsRI(CPlusObject);
end;

function TSerialPort.IsDCD : boolean;
begin
  Result := BSerialPort_IsDCD(CPlusObject);
end;

function TSerialPort.WaitForInput : TSSize_t;    
begin
  Result := BSerialPort_WaitForInput(CPlusObject);
end;

function TSerialPort.CountDevices : integer;
begin
  Result := BSerialPort_CountDevices(CPlusObject);
end;

function TSerialPort.GetDeviceName(n : integer; name : PChar; bufSize : TSize_t) : TStatus_t;
begin
  Result := BSerialPort_GetDeviceName(CPlusObject, n, name, bufSize);
end;

end.
