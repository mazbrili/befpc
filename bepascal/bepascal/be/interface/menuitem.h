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

#ifndef _MENUITEM_H_
#define _MENUITEM_H_

#include <Menu.h>
#include <MenuItem.h>
#include <beobj.h>

class BPMenuItem : public BMenuItem, virtual public BPasObject
{
	public:
		BPMenuItem(TPasObject PasObject, const char *label, BMessage *message, char shortcut = 0, uint32 modifiers = 0); 
		BPMenuItem(TPasObject PasObject, BMenu *submenu, BMessage *message = NULL);
		BPMenuItem(TPasObject PasObejct, BMessage *data);
/*		virtual void MessageReceived(BMessage *message);
		virtual void Draw(BRect updateRect);
		virtual void AttachedToWindow(void);
		virtual void MakeDefault(bool flag);
		virtual void WindowActivated(bool active);	

		virtual void AllAttached(void);
		virtual void AllDetached(void);
		virtual void DetachedFromWindow(void);
		virtual void DrawAfterChildren(BRect updateRect);
		virtual void FrameMoved(BPoint parentPoint);
		virtual void FrameResized(float width, float height);
		virtual void GetPreferredSize(float *width, float *height);
		virtual void ResizeToPreferred(void);
		virtual void KeyDown(const char *bytes, int32 numBytes);
		virtual void KeyUp(const char *bytes, int32 numBytes);
		virtual void MouseDown(BPoint point);
		virtual void MouseMoved(BPoint point, uint32 transit, const BMessage *message);
		virtual void MouseUp(BPoint point);
		virtual void Pulse(void);
//		virtual void TargetedByScrollView(BScrollView *scroller);
		virtual void SetEnabled(bool enabled);
		virtual void SetValue(int32 value);*/
	private:
};

class BPSeparatorItem : public BSeparatorItem, virtual public BPMenuItem
{
	public:
		BPSeparatorItem(TPasObject PasObject);
		BPSeparatorItem(TPasObject PasObject, BMessage *data);
};

#endif /* _MENUITEM_H_ */