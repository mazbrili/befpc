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

unit appdefs;

interface

const
	  // System Messages Codes
	_B_ABOUT_REQUESTED				: array[0..3] of Char = ('_', 'A', 'B', 'R');
	_B_WINDOW_ACTIVATED				: array[0..3] of Char = ('_', 'A', 'C', 'T');
	_B_APP_ACTIVATED				: array[0..3] of Char = ('_', 'A', 'C', 'T');	//* Same as B_WINDOW_ACTIVATED */
	_B_ARGV_RECEIVED 				: array[0..3] of Char = ('_', 'A', 'R', 'G');
	_B_QUIT_REQUESTED 				: array[0..3] of Char = ('_', 'Q', 'R', 'Q');
	_B_CLOSE_REQUESTED 				: array[0..3] of Char = ('_', 'Q', 'R', 'Q');	//* Obsolete; use B_QUIT_REQUESTED */
	_B_CANCEL						: array[0..3] of Char = ('_', 'C', 'N', 'C');
	_B_KEY_DOWN 					: array[0..3] of Char = ('_', 'K', 'Y', 'D');
	_B_KEY_UP 						: array[0..3] of Char = ('_', 'K', 'Y', 'U');
	_B_UNMAPPED_KEY_DOWN 			: array[0..3] of Char = ('_', 'U', 'K', 'D');
	_B_UNMAPPED_KEY_UP 				: array[0..3] of Char = ('_', 'U', 'K', 'U');
	_B_MODIFIERS_CHANGED			: array[0..3] of Char = ('_', 'M', 'C', 'H');
	_B_MINIMIZE						: array[0..3] of Char = ('_', 'W', 'M', 'N');
	_B_MOUSE_DOWN 					: array[0..3] of Char = ('_', 'M', 'D', 'N');
	_B_MOUSE_MOVED 					: array[0..3] of Char = ('_', 'M', 'M', 'V');
	_B_MOUSE_ENTER_EXIT				: array[0..3] of Char = ('_', 'M', 'E', 'X');
	_B_MOUSE_UP 					: array[0..3] of Char = ('_', 'M', 'U', 'P');
	_B_MOUSE_WHEEL_CHANGED			: array[0..3] of Char = ('_', 'M', 'W', 'C');
	_B_OPEN_IN_WORKSPACE			: array[0..3] of Char = ('_', 'O', 'W', 'S');
	_B_PRINTER_CHANGED				: array[0..3] of Char = ('_', 'P', 'C', 'H');
	_B_PULSE 						: array[0..3] of Char = ('_', 'P', 'U', 'L');
	_B_READY_TO_RUN 				: array[0..3] of Char = ('_', 'R', 'T', 'R');
	_B_REFS_RECEIVED 				: array[0..3] of Char = ('_', 'R', 'R', 'C');
	_B_RELEASE_OVERLAY_LOCK			: array[0..3] of Char = ('_', 'R', 'O', 'V');
	_B_ACQUIRE_OVERLAY_LOCK			: array[0..3] of Char = ('_', 'A', 'O', 'V');
	_B_SCREEN_CHANGED 				: array[0..3] of Char = ('_', 'S', 'C', 'H');
	_B_VALUE_CHANGED 				: array[0..3] of Char = ('_', 'V', 'C', 'H');
	_B_VIEW_MOVED 					: array[0..3] of Char = ('_', 'V', 'M', 'V');
	_B_VIEW_RESIZED 				: array[0..3] of Char = ('_', 'V', 'R', 'S');
	_B_WINDOW_MOVED 				: array[0..3] of Char = ('_', 'W', 'M', 'V');
	_B_WINDOW_RESIZED 				: array[0..3] of Char = ('_', 'W', 'R', 'S');
	_B_WORKSPACES_CHANGED			: array[0..3] of Char = ('_', 'W', 'C', 'G');
	_B_WORKSPACE_ACTIVATED			: array[0..3] of Char = ('_', 'W', 'A', 'C');
	_B_ZOOM							: array[0..3] of Char = ('_', 'W', 'Z', 'M');
	__APP_MENU_						: array[0..3] of Char = ('_', 'A', 'M', 'N');
	__BROWSER_MENUS_				: array[0..3] of Char = ('_', 'B', 'R', 'M');
	__MENU_EVENT_ 					: array[0..3] of Char = ('_', 'M', 'E', 'V');
	__PING_							: array[0..3] of Char = ('_', 'P', 'B', 'L');
	__QUIT_ 						: array[0..3] of Char = ('_', 'Q', 'I', 'T');
	__VOLUME_MOUNTED_ 				: array[0..3] of Char = ('_', 'N', 'V', 'L');
	__VOLUME_UNMOUNTED_				: array[0..3] of Char = ('_', 'V', 'R', 'M');
	__MESSAGE_DROPPED_ 				: array[0..3] of Char = ('_', 'M', 'D', 'P');
	__DISPOSE_DRAG_ 				: array[0..3] of Char = ('_', 'D', 'P', 'D');
	__MENUS_DONE_					: array[0..3] of Char = ('_', 'M', 'N', 'D');
	__SHOW_DRAG_HANDLES_			: array[0..3] of Char = ('_', 'S', 'D', 'H');
	__EVENTS_PENDING_ 				: array[0..3] of Char = ('_', 'E', 'V', 'P');
	__UPDATE_ 						: array[0..3] of Char = ('_', 'U', 'P', 'D');
	__UPDATE_IF_NEEDED_				: array[0..3] of Char = ('_', 'U', 'P', 'N');
	__PRINTER_INFO_					: array[0..3] of Char = ('_', 'P', 'I', 'N');
	__SETUP_PRINTER_				: array[0..3] of Char = ('_', 'S', 'U', 'P');
	__SELECT_PRINTER_				: array[0..3] of Char = ('_', 'P', 'S', 'L');

	  // Other Commands	
	_B_SET_PROPERTY					: array[0..3] of Char = ('P', 'S', 'E', 'T');
	_B_GET_PROPERTY					: array[0..3] of Char = ('P', 'G', 'E', 'T');
	_B_CREATE_PROPERTY				: array[0..3] of Char = ('P', 'C', 'R', 'T');
	_B_DELETE_PROPERTY				: array[0..3] of Char = ('P', 'D', 'E', 'L');
	_B_COUNT_PROPERTIES				: array[0..3] of Char = ('P', 'C', 'N', 'T');
	_B_EXECUTE_PROPERTY				: array[0..3] of Char = ('P', 'E', 'X', 'E');
	_B_GET_SUPPORTED_SUITES			: array[0..3] of Char = ('S', 'U', 'I', 'T');
	_B_UNDO							: array[0..3] of Char = ('U', 'N', 'D', 'O');
	_B_CUT 							: array[0..3] of Char = ('C', 'C', 'U', 'T');
	_B_COPY 						: array[0..3] of Char = ('C', 'O', 'P', 'Y');
	_B_PASTE 						: array[0..3] of Char = ('P', 'S', 'T', 'E');
	_B_SELECT_ALL					: array[0..3] of Char = ('S', 'A', 'L', 'L');
	_B_SAVE_REQUESTED 				: array[0..3] of Char = ('S', 'A', 'V', 'E');
	_B_MESSAGE_NOT_UNDERSTOOD		: array[0..3] of Char = ('M', 'N', 'O', 'T');
	_B_NO_REPLY 					: array[0..3] of Char = ('N', 'O', 'N', 'E');
	_B_REPLY 						: array[0..3] of Char = ('R', 'P', 'L', 'Y');
	_B_SIMPLE_DATA					: array[0..3] of Char = ('D', 'A', 'T', 'A');
	_B_MIME_DATA					: array[0..3] of Char = ('M', 'I', 'M', 'E');
	_B_ARCHIVED_OBJECT				: array[0..3] of Char = ('A', 'R', 'C', 'V');
	_B_UPDATE_STATUS_BAR			: array[0..3] of Char = ('S', 'B', 'U', 'P');
	_B_RESET_STATUS_BAR				: array[0..3] of Char = ('S', 'B', 'R', 'S');
	_B_NODE_MONITOR					: array[0..3] of Char = ('N', 'D', 'M', 'N');
	_B_QUERY_UPDATE					: array[0..3] of Char = ('Q', 'U', 'P', 'D');
	_B_ENDORSABLE					: array[0..3] of Char = ('E', 'N', 'D', 'O');
	_B_COPY_TARGET					: array[0..3] of Char = ('D', 'D', 'C', 'P');
	_B_MOVE_TARGET					: array[0..3] of Char = ('D', 'D', 'M', 'V');
	_B_TRASH_TARGET					: array[0..3] of Char = ('D', 'D', 'R', 'M');
	_B_LINK_TARGET					: array[0..3] of Char = ('D', 'D', 'L', 'N');
	_B_INPUT_DEVICES_CHANGED		: array[0..3] of Char = ('I', 'D', 'C', 'H');
	_B_INPUT_METHOD_EVENT			: array[0..3] of Char = ('I', 'M', 'E', 'V');
	_B_WINDOW_MOVE_TO				: array[0..3] of Char = ('W', 'D', 'M', 'T');
	_B_WINDOW_MOVE_BY				: array[0..3] of Char = ('W', 'D', 'M', 'B');
	_B_SILENT_RELAUNCH				: array[0..3] of Char = ('A', 'R', 'E', 'L');
	_B_OBSERVER_NOTICE_CHANGE 		: array[0..3] of Char = ('N', 'T', 'C', 'H');
	_B_CONTROL_INVOKED				: array[0..3] of Char = ('C', 'I', 'V', 'K');
	_B_CONTROL_MODIFIED				: array[0..3] of Char = ('C', 'M', 'O', 'D');

	//* Media Kit reserves all reserved codes starting in 'TRI' */

var
	B_ABOUT_REQUESTED			: Cardinal;
	B_WINDOW_ACTIVATED			: Cardinal;
	B_APP_ACTIVATED				: Cardinal;
	B_ARGV_RECEIVED 			: Cardinal;
	B_QUIT_REQUESTED 			: Cardinal;
	B_CLOSE_REQUESTED 			: Cardinal;
	B_CANCEL					: Cardinal;
	B_KEY_DOWN 					: Cardinal;
	B_KEY_UP 					: Cardinal;
	B_UNMAPPED_KEY_DOWN 		: Cardinal;
	B_UNMAPPED_KEY_UP 			: Cardinal;
	B_MODIFIERS_CHANGED			: Cardinal;
	B_MINIMIZE					: Cardinal;
	B_MOUSE_DOWN 				: Cardinal;	
	B_MOUSE_MOVED 				: Cardinal;	
	B_MOUSE_ENTER_EXIT			: Cardinal;	
	B_MOUSE_UP 					: Cardinal;	
	B_MOUSE_WHEEL_CHANGED		: Cardinal;	
	B_OPEN_IN_WORKSPACE			: Cardinal;	
	B_PRINTER_CHANGED			: Cardinal;	
	B_PULSE 					: Cardinal;	
	B_READY_TO_RUN 				: Cardinal;	
	B_REFS_RECEIVED 			: Cardinal;	
	B_RELEASE_OVERLAY_LOCK		: Cardinal;	
	B_ACQUIRE_OVERLAY_LOCK		: Cardinal;	
	B_SCREEN_CHANGED 			: Cardinal;	
	B_VALUE_CHANGED 			: Cardinal;	
	B_VIEW_MOVED 				: Cardinal;	
	B_VIEW_RESIZED 				: Cardinal;	
	B_WINDOW_MOVED 				: Cardinal;	
	B_WINDOW_RESIZED 			: Cardinal;	
	B_WORKSPACES_CHANGED		: Cardinal;	
	B_WORKSPACE_ACTIVATED		: Cardinal;	
	B_ZOOM						: Cardinal;	
	_APP_MENU_					: Cardinal;	
	_BROWSER_MENUS_				: Cardinal;	
	_MENU_EVENT_ 				: Cardinal;	
	_PING_						: Cardinal;	
	_QUIT_ 						: Cardinal;	
	_VOLUME_MOUNTED_ 			: Cardinal;	
	_VOLUME_UNMOUNTED_			: Cardinal;	
	_MESSAGE_DROPPED_ 			: Cardinal;	
	_DISPOSE_DRAG_ 				: Cardinal;	
	_MENUS_DONE_				: Cardinal;	
	_SHOW_DRAG_HANDLES_			: Cardinal;	
	_EVENTS_PENDING_ 			: Cardinal;	
	_UPDATE_ 					: Cardinal;	
	_UPDATE_IF_NEEDED_			: Cardinal;	
	_PRINTER_INFO_				: Cardinal;	
	_SETUP_PRINTER_				: Cardinal;	
	_SELECT_PRINTER_			: Cardinal;	

	  // Other Commands		
	B_SET_PROPERTY				: Cardinal;	
	B_GET_PROPERTY				: Cardinal;	
	B_CREATE_PROPERTY			: Cardinal;	
	B_DELETE_PROPERTY			: Cardinal;	
	B_COUNT_PROPERTIES			: Cardinal;	
	B_EXECUTE_PROPERTY			: Cardinal;	
	B_GET_SUPPORTED_SUITES		: Cardinal;	
	B_UNDO						: Cardinal;	
	B_CUT 						: Cardinal;	
	B_COPY 						: Cardinal;	
	B_PASTE 					: Cardinal;	
	B_SELECT_ALL				: Cardinal;
	B_SAVE_REQUESTED 			: Cardinal;	
	B_MESSAGE_NOT_UNDERSTOOD	: Cardinal;
	B_NO_REPLY 					: Cardinal;
	B_REPLY 					: Cardinal;
	B_SIMPLE_DATA				: Cardinal;
	B_MIME_DATA					: Cardinal;
	B_ARCHIVED_OBJECT			: Cardinal;
	B_UPDATE_STATUS_BAR			: Cardinal;
	B_RESET_STATUS_BAR			: Cardinal;
	B_NODE_MONITOR				: Cardinal;
	B_QUERY_UPDATE				: Cardinal;
	B_ENDORSABLE				: Cardinal;
	B_COPY_TARGET				: Cardinal;
	B_MOVE_TARGET				: Cardinal;
	B_TRASH_TARGET				: Cardinal;
	B_LINK_TARGET				: Cardinal;
	B_INPUT_DEVICES_CHANGED		: Cardinal;
	B_INPUT_METHOD_EVENT		: Cardinal;
	B_WINDOW_MOVE_TO			: Cardinal;
	B_WINDOW_MOVE_BY			: Cardinal;
	B_SILENT_RELAUNCH			: Cardinal;
	B_OBSERVER_NOTICE_CHANGE 	: Cardinal;
	B_CONTROL_INVOKED			: Cardinal;
	B_CONTROL_MODIFIED			: Cardinal;

implementation

FUNCTION Power(X,Y:Word):LongInt;
VAR Temp,Teller : LongInt;
BEGIN
  TEMP:=1;
  FOR Teller:=1 TO Y DO TEMP:=TEMP*X;
  Power:=Temp;
END; { Power }


FUNCTION Hex2Dec(Hex:STRING):LongInt;
VAR   T1,T2,Dec   :       LongInt;
      Error       :       Boolean;

BEGIN
  Error:=False;
  T1:=0;T2:=0;DEC:=0;
  FOR T1:=1 TO LENGTH(Hex) DO
  BEGIN
   T2:=Length(Hex)-T1;
   CASE Hex[T1] OF
   '0'  : DEC:=DEC+0;
   '1'  : DEC:=DEC+Power(16,T2);
   '2'  : DEC:=DEC+2*Power(16,T2);
   '3'  : DEC:=DEC+3*Power(16,T2);
   '4'  : DEC:=DEC+4*Power(16,T2);
   '5'  : DEC:=DEC+5*Power(16,T2);
   '6'  : DEC:=DEC+6*Power(16,T2);
   '7'  : DEC:=DEC+7*Power(16,T2);
   '8'  : DEC:=DEC+8*Power(16,T2);
   '9'  : DEC:=DEC+9*Power(16,T2);
   'A','a' : DEC:=DEC+10*Power(16,T2);
   'B','b' : DEC:=DEC+11*Power(16,T2);
   'C','c' : DEC:=DEC+12*Power(16,T2);
   'D','d' : DEC:=DEC+13*Power(16,T2);
   'E','e' : DEC:=DEC+14*Power(16,T2);
   'F','f' : DEC:=DEC+15*Power(16,T2);
   ELSE Error:=True;
   END;
  END;
  Hex2Dec:=Dec;
  IF Error THEN Hex2Dec:=0;
END; 

FUNCTION Dec2Hex(DEC:LONGINT):STRING;

VAR H1:INTEGER;
    Hex,HexDigit:STRING;

BEGIN
  HexDigit:='0123456789ABCDEF';
  HEX:='';
  REPEAT
  H1:=DEC MOD 16;
  DEC:=DEC DIV 16;
  Hex:=CONCAT(Hexdigit[H1+1],Hex);
  UNTIL DEC<1;
  Dec2Hex:=Hex;
END; { Dec2Hex }

function trans( S : Array of char): cardinal;
var nd : array[0..3] of integer;
      Nh :array[0..3] of string;
      Hexa : string;
      i : Integer;
begin
	for i:=0 to 3 do nd[i]:=ord(S[i]);
	for i:=0 to 3 do Nh[i]:=dec2hex(nd[i]);
	hexa:=nh[0]+nh[1]+nh[2]+nh[3];
	result:=hex2dec(hexa);
end;


initialization
	  // System Messages Codes
	B_ABOUT_REQUESTED			:= trans(_B_ABOUT_REQUESTED);
	B_WINDOW_ACTIVATED			:= trans(_B_WINDOW_ACTIVATED);
	B_APP_ACTIVATED				:= trans(_B_APP_ACTIVATED);
	B_ARGV_RECEIVED 			:= trans(_B_ARGV_RECEIVED);
	B_QUIT_REQUESTED 			:= trans(_B_QUIT_REQUESTED);
	B_CLOSE_REQUESTED 			:= trans(_B_CLOSE_REQUESTED);
	B_CANCEL					:= trans(_B_CANCEL);
	B_KEY_DOWN 					:= trans(_B_KEY_DOWN);
	B_KEY_UP 					:= trans(_B_KEY_UP);
	B_UNMAPPED_KEY_DOWN 		:= trans(_B_UNMAPPED_KEY_DOWN);
	B_UNMAPPED_KEY_UP 			:= trans(_B_UNMAPPED_KEY_UP);
	B_MODIFIERS_CHANGED			:= trans(_B_MODIFIERS_CHANGED);
	B_MINIMIZE					:= trans(_B_MINIMIZE);	
	B_MOUSE_DOWN 				:= trans(_B_MOUSE_DOWN);	
	B_MOUSE_MOVED 				:= trans(_B_MOUSE_MOVED);	
	B_MOUSE_ENTER_EXIT			:= trans(_B_MOUSE_ENTER_EXIT);	
	B_MOUSE_UP 					:= trans(_B_MOUSE_UP);	
	B_MOUSE_WHEEL_CHANGED		:= trans(_B_MOUSE_WHEEL_CHANGED);
	B_OPEN_IN_WORKSPACE			:= trans(_B_OPEN_IN_WORKSPACE);
	B_PRINTER_CHANGED			:= trans(_B_PRINTER_CHANGED);
	B_PULSE 					:= trans(_B_PULSE);
	B_READY_TO_RUN 				:= trans(_B_READY_TO_RUN);
	B_REFS_RECEIVED 			:= trans(_B_REFS_RECEIVED);
	B_RELEASE_OVERLAY_LOCK		:= trans(_B_RELEASE_OVERLAY_LOCK);
	B_ACQUIRE_OVERLAY_LOCK		:= trans(_B_ACQUIRE_OVERLAY_LOCK);
	B_SCREEN_CHANGED 			:= trans(_B_SCREEN_CHANGED);
	B_VALUE_CHANGED 			:= trans(_B_VALUE_CHANGED);
	B_VIEW_MOVED 				:= trans(_B_VIEW_MOVED);
	B_VIEW_RESIZED 				:= trans(_B_VIEW_RESIZED);
	B_WINDOW_MOVED 				:= trans(_B_WINDOW_MOVED);
	B_WINDOW_RESIZED 			:= trans(_B_WINDOW_RESIZED);
	B_WORKSPACES_CHANGED		:= trans(_B_WORKSPACES_CHANGED);
	B_WORKSPACE_ACTIVATED		:= trans(_B_WORKSPACE_ACTIVATED);
	B_ZOOM						:= trans(_B_ZOOM);
	_APP_MENU_					:= trans(__APP_MENU_);
	_BROWSER_MENUS_				:= trans(__BROWSER_MENUS_);
	_MENU_EVENT_ 				:= trans(__MENU_EVENT_);
	_PING_						:= trans(__PING_);
	_QUIT_ 						:= trans(__QUIT_);
	_VOLUME_MOUNTED_ 			:= trans(__VOLUME_MOUNTED_);
	_VOLUME_UNMOUNTED_			:= trans(__VOLUME_UNMOUNTED_);
	_MESSAGE_DROPPED_ 			:= trans(__MESSAGE_DROPPED_);
	_DISPOSE_DRAG_ 				:= trans(__DISPOSE_DRAG_);
	_MENUS_DONE_				:= trans(__MENUS_DONE_);
	_SHOW_DRAG_HANDLES_			:= trans(__SHOW_DRAG_HANDLES_);
	_EVENTS_PENDING_ 			:= trans(__EVENTS_PENDING_);
	_UPDATE_ 					:= trans(__UPDATE_);
	_UPDATE_IF_NEEDED_			:= trans(__UPDATE_IF_NEEDED_);
	_PRINTER_INFO_				:= trans(__PRINTER_INFO_);
	_SETUP_PRINTER_				:= trans(__SETUP_PRINTER_);
	_SELECT_PRINTER_			:= trans(__SELECT_PRINTER_);

	  // Other Commands	
	B_SET_PROPERTY				:= trans(_B_SET_PROPERTY);
	B_GET_PROPERTY				:= trans(_B_GET_PROPERTY);
	B_CREATE_PROPERTY			:= trans(_B_CREATE_PROPERTY);
	B_DELETE_PROPERTY			:= trans(_B_DELETE_PROPERTY);
	B_COUNT_PROPERTIES			:= trans(_B_COUNT_PROPERTIES);
	B_EXECUTE_PROPERTY			:= trans(_B_EXECUTE_PROPERTY);
	B_GET_SUPPORTED_SUITES		:= trans(_B_GET_SUPPORTED_SUITES);
	B_UNDO						:= trans(_B_UNDO);
	B_CUT 						:= trans(_B_CUT);
	B_COPY 						:= trans(_B_COPY);
	B_PASTE 					:= trans(_B_PASTE);
	B_SELECT_ALL				:= trans(_B_SELECT_ALL);
	B_SAVE_REQUESTED 			:= trans(_B_SAVE_REQUESTED);
	B_MESSAGE_NOT_UNDERSTOOD	:= trans(_B_MESSAGE_NOT_UNDERSTOOD);
	B_NO_REPLY 					:= trans(_B_NO_REPLY);
	B_REPLY 					:= trans(_B_REPLY);
	B_SIMPLE_DATA				:= trans(_B_SIMPLE_DATA);
	B_MIME_DATA					:= trans(_B_MIME_DATA);
	B_ARCHIVED_OBJECT			:= trans(_B_ARCHIVED_OBJECT);
	B_UPDATE_STATUS_BAR			:= trans(_B_UPDATE_STATUS_BAR);
	B_RESET_STATUS_BAR			:= trans(_B_RESET_STATUS_BAR);
	B_NODE_MONITOR				:= trans(_B_NODE_MONITOR);
	B_QUERY_UPDATE				:= trans(_B_QUERY_UPDATE);
	B_ENDORSABLE				:= trans(_B_ENDORSABLE);
	B_COPY_TARGET				:= trans(_B_COPY_TARGET);
	B_MOVE_TARGET				:= trans(_B_MOVE_TARGET);
	B_TRASH_TARGET				:= trans(_B_TRASH_TARGET);
	B_LINK_TARGET				:= trans(_B_LINK_TARGET);
	B_INPUT_DEVICES_CHANGED		:= trans(_B_INPUT_DEVICES_CHANGED);
	B_INPUT_METHOD_EVENT		:= trans(_B_INPUT_METHOD_EVENT);
	B_WINDOW_MOVE_TO			:= trans(_B_WINDOW_MOVE_TO);
	B_WINDOW_MOVE_BY			:= trans(_B_WINDOW_MOVE_BY);
	B_SILENT_RELAUNCH			:= trans(_B_SILENT_RELAUNCH);
	B_OBSERVER_NOTICE_CHANGE 	:= trans(_B_OBSERVER_NOTICE_CHANGE);
	B_CONTROL_INVOKED			:= trans(_B_CONTROL_INVOKED);
	B_CONTROL_MODIFIED			:= trans(_B_CONTROL_MODIFIED);

end.
