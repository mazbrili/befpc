{   BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002 Olivier Coursiere
                        Eric Jourde

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

unit main_window;

interface
{$M+}
uses
	beobj, application, message, _beep, roster, SysUtils,appdefs,
	archivable, handler,  rect, window, view, graphicdefs, dataio, interfacedefs,textView,alert,
	invoker, messenger, Control, Button,stringview,textcontrol,checkbox,TabView,listitem,
    menu, menubar,
	button_view,edit_view,common,other_view;


Type
TMyWindow = class(BWindow)
  private
    aView : BView;
    TabView : BTabView;
    Tab1			: BTab;
    Tab2			: BTab;


  public
    constructor Create(aFrame : BRect; title : PChar; atype, aFlags, aWorkspaces : Cardinal); override;
    destructor Destroy; override;
    procedure MessageReceived(amessage : BMessage); override;
    VButton : TButton_View;
    VEdit      : TEdit_View;
    Explain : BStringView;
    VOther : TOther_View;
  end;

Const Message1='Message : ';

implementation

constructor TMyWindow.Create(aFrame :BRect; title : PChar; atype, aFlags, aWorkspaces : Cardinal);
var
  aRect : BRect;  
  aRect2 : BRect;  
  mess : BMessage;
  i : Integer;
  S : pchar;

  menu : BMenu;
  menubar : BMenuBar;
  sepItem, sepItem2 : BSeparatorItem;
  item : BMenuItem;
  item1 : BMenuItem;

begin
	inherited;
 	try
  		try
  			// menu
  			
      		aRect2 := BRect.Create(0,0,300,300);
      		menubar := BMenuBar.Create(aRect2, 'Bonjour', B_FOLLOW_LEFT_RIGHT or B_FOLLOW_TOP, B_ITEMS_IN_COLUMN, True);
      		AddChild(menubar, nil);
      		aRect2.Free;
      		Menu := BMenu.Create('File', B_ITEMS_IN_COLUMN);
      		item := BMenuItem.Create('Open', BMessage.Create(MSG_MENU_BASE+1), 'o'{#0}, 0);
      		item1 := BMenuItem.Create('Close', BMessage.Create(MSG_MENU_BASE+2), 'z'{#0}, 0);

			Menu.AddItem(item);
			Menu.AddSeparatorItem;
			Menu.AddItem(item1);

      		MenuBar.AddItem(Menu);
  			
      		// Create the main View
 			aRect := BRect.Create(0, 0, 1000, 600);
      		aView := BView.Create(aRect, 'Test', B_FOLLOW_ALL, B_WILL_DRAW);
      		aView.SetViewColor(ui_color(B_PANEL_BACKGROUND_COLOR));  
      		self.AddChild(aView, nil);
    		aRect.Free;
      
      		// Show text Message
       		aRect:= BRect.Create(20, 400, 200, 420);
   		    Explain := BStringView.Create(aRect,'explain','Message : ',B_FOLLOW_LEFT or B_FOLLOW_TOP, B_WILL_DRAW or B_NAVIGABLE);
        	aView.AddChild(Explain, nil);
        	aRect.Free;

      
      		// TabView
       		aRect:= BRect.Create(20, 25, 700, 400);
        	TabView:=BTabview.Create(aRect,'test',
	    	    						B_WIDTH_AS_USUAL,
    		    						B_FOLLOW_TOP,
        								B_FULL_UPDATE_ON_RESIZE or	B_WILL_DRAW or B_NAVIGABLE_JUMP or		B_FRAME_EVENTS or B_NAVIGABLE);
        	aView.AddChild(TabView, nil);
        	aRect.Free;
   
			// Button
       		aRect:= BRect.Create(0, 0, 700, 500);
   		    VButton := TButton_View.Create(aRect, 'Test 1', B_FOLLOW_ALL, B_NAVIGABLE);
      		aRect.Free;

			Tab1:=BTab.create(VButton);
			Tab1.SetLabel('BButton & BListView');
		
			TabView.AddTab(VButton,Tab1);

			// Edit
       		aRect:= BRect.Create(0, 0, 700, 500);
   		    VEdit := TEdit_View.Create(aRect, 'Test 1', B_FOLLOW_ALL, B_NAVIGABLE);
      		aRect.Free;

			Tab1:=BTab.create(VEdit);
			Tab1.SetLabel('BeditText');
		
			TabView.AddTab(VEdit,Tab1);
  
			// Other
       		aRect:= BRect.Create(0, 0, 700, 500);
   		    VOther := TOther_View.Create(aRect, 'Test 1', B_FOLLOW_ALL, B_NAVIGABLE);
      		aRect.Free;

			Tab1:=BTab.create(VOther);
			Tab1.SetLabel('Other');
		
			TabView.AddTab(VOther,Tab1);
        											    
  	
	TabView.Select(0);
      
    finally
    end;
  finally
  end;
  
end;

destructor TMyWindow.Destroy;
begin
  inherited;
end;



procedure TMyWindow.MessageReceived(aMessage : BMessage);
Var S : String;
       p : pchar;
    	Alert : BAlert;
begin
  inherited;
  Case aMessage.what of
  MSG_BUTTON_BASE+1 : Begin
  					Explain.SetText(Message1+'button 1 clic');
  		         End;
  MSG_BUTTON_BASE+2 : Begin
  					Explain.SetText(Message1+'button Add Item click');
    				VButton.ItemString := BStringItem.create('new Item',0,true);
    				VButton.ListView1.AddItem(VButton.ItemString);
  		         End;
  MSG_BUTTON_BASE+3 : Begin
  					Explain.SetText(Message1+'button Add OutlineListItem  clic');
    				VButton.ItemString := BStringItem.create('New Item',0,true);
    				VButton.outlineListView.AddItem(VButton.ItemString);
  		         End;
  MSG_BUTTON_BASE+4 : Begin
  					VOther.StatusBar1.Update(10, nil, nil); 
  					S:='Position: '+FloatToStr(VOther.StatusBar1.CurrentValue)+' \ '+FloatToStr(VOther.StatusBar1.MaxValue);
  					p:=stralloc(length(s)+1);
  					strpcopy(p,s);
  					VOther.Value.SetText(p);
  					strdispose(p);
  		         End;
  MSG_BUTTON_BASE+5 : Begin
  					VOther.StatusBar1.Update(-10, nil, nil); 
  					S:='Position: '+FloatToStr(VOther.StatusBar1.CurrentValue)+' \ '+FloatToStr(VOther.StatusBar1.MaxValue);
  					p:=stralloc(length(s)+1);
  					strpcopy(p,s);
  					VOther.Value.SetText(p);
  					strdispose(p);
  		         End;
  MSG_BUTTON_BASE+6 : Begin
					Alert:=BAlert.Create('Attention','You have request a alert ?','Help','Cancel','OK',B_WIDTH_AS_USUAL,B_WARNING_ALERT);
  					Alert.go;
  		         End;
  	MSG_RADIOBUTTON_BASE + 1 : Begin
 					VEdit.Edit.setalignment(B_ALIGN_LEFT,B_ALIGN_LEFT);
  				End;	         
  	MSG_RADIOBUTTON_BASE + 2 : Begin
      				VEdit.Edit.setalignment(B_ALIGN_RIGHT,B_ALIGN_RIGHT);
  				End;	         
  	MSG_RADIOBUTTON_BASE + 3 : Begin
					VEdit.Edit.SetEnabled(true);  				
				End;
  	MSG_RADIOBUTTON_BASE + 4 : Begin
					VEdit.Edit.SetEnabled(false);  				
				End;
	MSG_MENU_BASE	+2 : Begin
					quit;
				End;			
  end;
end;

end.


