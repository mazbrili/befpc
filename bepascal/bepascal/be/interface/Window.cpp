/*  BePascal - A pascal wrapper around the BeOS API
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
*/

#ifndef _WINDOW_CPP_
#define _WINDOW_CPP_

#include <Window.h>

#include <OS.h>

#include <window.h>
#include <beobj.h>

// definition of callback function in BWindow


#if defined(__cplusplus)
extern "C" {
#endif


#if defined(__cplusplus)
}
#endif

BPWindow::BPWindow(TPasObject PasObject, 
				 BRect frame,
				 const char *title,
				 window_type type,
				 uint32 flags,
				 uint32 workspaces = B_CURRENT_WORKSPACE)
				 : BWindow(frame, title, type, flags, workspaces),
                 BPLooper(PasObject),
                 BPHandler(PasObject, title),
                 BPasObject(PasObject)
{
}

#if defined(__cplusplus)
extern "C" {
#endif

TCPlusObject BWindow_Create_1(TPasObject PasObject, 
							BRect frame,
							const char *title,
							window_type type,
							uint32 flags,
							uint32 workspaces)
{
	return new BPWindow(PasObject, frame, title, type, flags, workspaces);
}

void BWindow_Free(TCPlusObject Window)
{
	delete Window;
}

void BWindow_Show(TCPlusObject Window)
{
	reinterpret_cast<BWindow*>(Window)->Show();
	reinterpret_cast<BWindow*>(Window)->UpdateIfNeeded();	
}

void BWindow_Hide(TCPlusObject Window)
{
	reinterpret_cast<BWindow*>(Window)->Hide();
}

void BWindow_AddChild(BWindow* Window, BView* aView, BView* sibling)
{
	Window->AddChild(aView, sibling);
}

bool BWindow_RemoveChild(BWindow* Window, BView* aView)
{
	return Window->RemoveChild(aView);
}

BView* BWindow_ChildAt(BWindow* Window, int32 index)
{
	return Window->ChildAt(index);
}

int32 BWindow_CountChildren(BWindow* Window, void)
{
	return Window->CountChildren();
}

#if defined(__cplusplus)
}
#endif

#endif /* _WINDOW_CPP_ */