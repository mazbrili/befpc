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
unit interfacedefs;

interface

uses graphicdefs,beobj;

type
  TAlignment = (B_ALIGN_LEFT,
    B_ALIGN_RIGHT,
    B_ALIGN_CENTER);


  Tcolor_which =(Tcolor_nil,
    B_PANEL_BACKGROUND_COLOR ,
    B_MENU_BACKGROUND_COLOR ,
    B_MENU_SELECTION_BACKGROUND_COLOR ,
    B_MENU_ITEM_TEXT_COLOR ,
    B_MENU_SELECTED_ITEM_TEXT_COLOR ,
    B_WINDOW_TAB_COLOR ,
    B_KEYBOARD_NAVIGATION_COLOR ,
    B_DESKTOP_COLOR );

  Torientation =(
  	B_HORIZONTAL,
  	B_VERTICAL);

  Tborder_style =(
  	B_PLAIN_BORDER,
  	B_FANCY_BORDER,
  	B_NO_BORDER);

function ui_color(which : Tcolor_which) : Trgb_color; cdecl; external 'be' name 'ui_color__F11color_which';
function Ttint_color(color : Trgb_color; which :Tcolor_which) : Trgb_color;cdecl; external 'be' name 'tint_color__FG9rgb_colorf';

implementation

end.
