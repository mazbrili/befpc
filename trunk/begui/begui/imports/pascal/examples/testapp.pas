program TespApp;

uses BeGUI;

procedure EventTest(sender: pointer; msg: uint32);
begin
  if sender <> nil then
    GenericAlert(MButton_getCaption(sender));
end;

var
  TestMsg: array[0..10] of char;

  Button1: MButtonH;
  Edit1: MEditH;
  MainForm: MFormH;
  a: integer;
begin
  TestMsg := 'Test'#0;
 
  MainForm := MApplication_GetMainForm(Application);

  Button1 := MButton_Create_int32(10, 10, 50, 20, @TestMsg);
  MButton_AttachClickDispatcher(Button1, base_Message(@EventTest));

  MForm_AddChild(MainForm, Button1);

  Edit1 := MForm_AddMEdit_int32(MainForm, 30, 100, 150, 150, @TestMsg);

  MApplication_Run(Application);
end.