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

#ifndef _VIEW_CPP_
#define _VIEW_CPP_

#include <View.h>

#include <OS.h>

#include <beobj.cpp>

// definition of callback function in BView
typedef void (*BView_AllAttached_hook) (TPasObject PasObject);
typedef void (*BView_AllDetached_hook) (TPasObject PasObject);
typedef void (*BView_AttachedToWindow_hook) (TPasObject PasObject);
typedef void (*BView_DetachedFromWindow_hook) (TPasObject PasObject);
typedef void (*BView_Draw_hook) (TPasObject PasObject, TCPlusObject updateRect);
typedef void (*BView_DrawAfterChildren_hook) (TPasObject PasObject, TCPlusObject updateRect);
typedef void (*BView_FrameMoved_hook) (TPasObject PasObject, TCPlusObject parentPoint);
typedef void (*BView_FrameResized_hook) (TPasObject PasObject, float width, float height);
typedef void (*BView_GetPreferredSize_hook) (TPasObject PasObject, float *width, float *height);
typedef void (*BView_ResizeToPreferred_hook) (TPasObject PasObject);
typedef void (*BView_KeyDown_hook) (TPasObject PasObject, const char *bytes, int32 numBytes);
typedef void (*BView_KeyUp_hook) (TPasObject PasObject, const char *bytes, int32 numBytes);
typedef void (*BView_MouseDown_hook) (TPasObject PasObject, TCPlusObject point);
typedef void (*BView_MouseMoved_hook) (TPasObject PasObject, TCPlusObject point, uint32 transit, TCPlusObject message);
typedef void (*BView_MouseUp_hook) (TPasObject PasObject, TCPlusObject point);
typedef void (*BView_Pulse_hook) (TPasObject PasObject);
typedef void (*BView_TargetedByScrollView_hook) (TPasObject PasObject, TCPlusObject scroller);
typedef void (*BView_WindowActivated_hook) (TPasObject PasObject, bool active);

#if defined(__cplusplus)
extern "C" {
#endif

uint32 _B_FOLLOW_NONE = B_FOLLOW_NONE;
uint32 _B_FOLLOW_ALL_SIDES = B_FOLLOW_ALL_SIDES;
uint32 _B_FOLLOW_ALL = B_FOLLOW_ALL;

uint32 _B_FOLLOW_LEFT = B_FOLLOW_LEFT;
uint32 _B_FOLLOW_RIGHT = B_FOLLOW_RIGHT;
uint32 _B_FOLLOW_LEFT_RIGHT = B_FOLLOW_LEFT_RIGHT;
uint32 _B_FOLLOW_H_CENTER = B_FOLLOW_H_CENTER;

uint32 _B_FOLLOW_TOP = B_FOLLOW_TOP;
uint32 _B_FOLLOW_BOTTOM = B_FOLLOW_BOTTOM;
uint32 _B_FOLLOW_TOP_BOTTOM = B_FOLLOW_TOP_BOTTOM;
uint32 _B_FOLLOW_V_CENTER = B_FOLLOW_V_CENTER;

BView_AllAttached_hook View_AllAttached_hook;
BView_AllDetached_hook View_AllDetached_hook;
BView_AttachedToWindow_hook View_AttachedToWindow_hook;
BView_DetachedFromWindow_hook View_DetachedFromWindow_hook;
BView_Draw_hook View_Draw_hook;
BView_DrawAfterChildren_hook View_DrawAfterChildren_hook;
BView_FrameMoved_hook View_FrameMoved_hook;
BView_FrameResized_hook View_FrameResized_hook;
BView_GetPreferredSize_hook View_GetPreferredSize_hook;
BView_ResizeToPreferred_hook View_ResizeToPreferred_hook;
BView_KeyDown_hook View_KeyDown_hook;
BView_KeyUp_hook View_KeyUp_hook;
BView_MouseDown_hook View_MouseDown_hook;
BView_MouseMoved_hook View_MouseMoved_hook;
BView_MouseUp_hook View_MouseUp_hook;
BView_Pulse_hook View_Pulse_hook;
BView_TargetedByScrollView_hook View_TargetedByScrollView_hook;
BView_WindowActivated_hook View_WindowActivated_hook;
  
#if defined(__cplusplus)
}
#endif

class BPView : public BView, public virtual BPHandler
{
	public:
		BPView(TPasObject PasObject, 
			   BRect frame,
			   const char *name,
			   uint32 resizingMode,
			   uint32 flags);
		BPView(TPasObject PasObject, BMessage *archive);
//		virtual void DispatchMessage(BMessage *message, BHandler *target);
//		virtual bool QuitRequested(void);
		virtual void AllAttached(void);
		virtual void AttachedToWindow(void);
		virtual void AllDetached(void);
		virtual void DetachedFromWindow(void);
		virtual void Draw(BRect updateRect);
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
		virtual void WindowActivated(bool active);
	private:	
};

BPView::BPView(TPasObject PasObject, 
			   BRect frame,
			   const char *name,
			   uint32 resizingMode,
			   uint32 flags)
			   : BView(frame, name, resizingMode, flags),
               BPHandler(PasObject),
               BPasObject(PasObject)
{
}

BPView::BPView(TPasObject PasObject, BMessage *archive)
				: BView(archive),
                  BPHandler(PasObject),				
	              BPasObject(PasObject)
{
}

void BPView::AllAttached(void)
{
	View_AllAttached_hook(GetPasObject());
}

void BPView::AttachedToWindow(void)
{
	View_AttachedToWindow_hook(GetPasObject());	
}

void BPView::AllDetached(void)
{
	View_AllDetached_hook(GetPasObject());
}

void BPView::DetachedFromWindow(void)
{
	View_DetachedFromWindow_hook(GetPasObject());
}

void BPView::Draw(BRect updateRect)
{
	View_Draw_hook(GetPasObject(), &updateRect);
}

void BPView::DrawAfterChildren(BRect updateRect)
{
	View_DrawAfterChildren_hook(GetPasObject(), &updateRect);
}

void BPView::FrameMoved(BPoint parentPoint)
{
	View_FrameMoved_hook(GetPasObject(), &parentPoint);
}

void BPView::FrameResized(float width, float height)
{
	View_FrameResized_hook(GetPasObject(), width, height);
}

void BPView::GetPreferredSize(float *width, float *height)
{
	View_GetPreferredSize_hook(GetPasObject(), width, height);
}

void BPView::ResizeToPreferred(void)
{
	View_ResizeToPreferred_hook(GetPasObject());
}

void BPView::KeyDown(const char *bytes, int32 numBytes)
{
	View_KeyDown_hook(GetPasObject(), bytes, numBytes);
}

void BPView::KeyUp(const char *bytes, int32 numBytes)
{
	View_KeyUp_hook(GetPasObject(), bytes, numBytes);
}

void BPView::MouseDown(BPoint point)
{
	View_MouseDown_hook(GetPasObject(), &point);
}

void BPView::MouseMoved(BPoint point, uint32 transit, const BMessage *message)
{
	View_MouseMoved_hook(GetPasObject(), &point, transit, &message);
}

void BPView::MouseUp(BPoint point)
{
	View_MouseUp_hook(GetPasObject(), &point);
}

void BPView::Pulse(void)
{
	View_Pulse_hook(GetPasObject());
}

//void BPView::TargetedByScrollView(BScrollView *scroller)
//{
//	View_TargetedByScrollView(GetPasObject(), scroller);
//}

void BPView::WindowActivated(bool active)
{
	View_WindowActivated_hook(GetPasObject(), active);
}

#if defined(__cplusplus)
extern "C" {
#endif

TCPlusObject BView_Create_1(TPasObject PasObject, 
							BRect frame,
							const char *name,
							uint32 resizingMode,
							uint32 flags)
{
	return new BPView(PasObject, frame, name, resizingMode, flags);
}

void BView_Free(TCPlusObject View)
{
	delete View;
}

/***********************************************************************
 *  Method: BView::Instantiate
 *  Params: BMessage *data
 * Returns: BArchivable *
 * Effects: 
 ***********************************************************************/
BArchivable *
BView_Instantiate(BView *View, BMessage *data)
{
   return View->Instantiate(data);
}


/***********************************************************************
 *  Method: BView::Archive
 *  Params: BMessage *data, bool deep
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BView_Archive(BView *View, BMessage *data,
               bool deep) 
{
   return View->Archive(data,
               deep);
}

// TODO : implement hook functions
/***********************************************************************
 *  Method: BView::AttachedToWindow
 *  Params: 
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_AttachedToWindow(BView *View)
{
   View->AttachedToWindow();
}


/***********************************************************************
 *  Method: BView::AllAttached
 *  Params: 
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_AllAttached(BView *View)
{
   View->AllAttached();
}


/***********************************************************************
 *  Method: BView::DetachedFromWindow
 *  Params: 
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_DetachedFromWindow(BView *View)
{
   View->DetachedFromWindow();
}


/***********************************************************************
 *  Method: BView::AllDetached
 *  Params: 
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_AllDetached(BView *View)
{
   View->AllDetached();
}

// END TODO implement hook functions

/***********************************************************************
 *  Method: BView::AddChild
 *  Params: BView *child, BView *before
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_AddChild(BView *View, BView *child,
                BView *before)
{
   View->AddChild(child,
                before);
}


/***********************************************************************
 *  Method: BView::RemoveChild
 *  Params: BView *child
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BView_RemoveChild(BView *View, BView *child)
{
   return View->RemoveChild(child);
}


/***********************************************************************
 *  Method: BView::CountChildren
 *  Params: 
 * Returns: int32
 * Effects: 
 ***********************************************************************/
int32
BView_CountChildren(BView *View)
{
   return View->CountChildren();
}


/***********************************************************************
 *  Method: BView::ChildAt
 *  Params: int32 index
 * Returns: BView *
 * Effects: 
 ***********************************************************************/
BView *
BView_ChildAt(BView *View, int32 index)
{
   return View->ChildAt(index);
}


/***********************************************************************
 *  Method: BView::NextSibling
 *  Params: 
 * Returns: BView *
 * Effects: 
 ***********************************************************************/
BView *
BView_NextSibling(BView *View)
{
   return View->NextSibling();
}


/***********************************************************************
 *  Method: BView::PreviousSibling
 *  Params: 
 * Returns: BView *
 * Effects: 
 ***********************************************************************/
BView *
BView_PreviousSibling(BView *View)
{
   return View->PreviousSibling();
}


/***********************************************************************
 *  Method: BView::RemoveSelf
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BView_RemoveSelf(BView *View)
{
   return View->RemoveSelf();
}


/***********************************************************************
 *  Method: BView::Window
 *  Params: 
 * Returns: BWindow *
 * Effects: 
 ***********************************************************************/
BWindow *
BView_Window(BView *View) 
{
   return View->Window();
}


// TODO : implement hook function 

/***********************************************************************
 *  Method: BView::Draw
 *  Params: BRect updateRect
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_Draw(BView *View, BRect updateRect)
{
   View->Draw(updateRect);
}

// END TODO implement hook function

/***********************************************************************
 *  Method: BView::SetViewColor
 *  Params: rgb_color c
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BView_SetViewColor(BView *View, rgb_color c)
{
   View->SetViewColor(c);
}


/***********************************************************************
 *  Method: BView::ViewColor
 *  Params: 
 * Returns: rgb_color
 * Effects: 
 ***********************************************************************/
rgb_color
BView_ViewColor(BView *View)
{
   return View->ViewColor();
}

#if defined(__cplusplus)
}
#endif

#endif /* _VIEW_CPP_ */