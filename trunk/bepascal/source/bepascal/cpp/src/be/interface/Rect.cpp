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

#ifndef _RECT_CPP_
#define _RECT_CPP_

#include <Point.h>
#include <Rect.h>

#include <rect.h>
#include <beobj.h>

BPRect::BPRect(TPasObject PasObject) : BRect(), BPasObject(PasObject)
{
}

BPRect::BPRect(TPasObject PasObject, const BRect & rect) : BRect(rect), BPasObject(PasObject)
{
}

BPRect::BPRect(TPasObject PasObject, float l, float t, float r, float b) : BRect(l, t, r, b), BPasObject(PasObject)
{
}

BPRect::BPRect(TPasObject PasObject, BPoint leftTop, BPoint rightBottom) : BRect(leftTop, rightBottom), BPasObject(PasObject)
{
}

#if defined(__cplusplus)
extern "C" {
#endif

TCPlusObject BRect_Create_1(TPasObject PasObject)
{
  return new BPRect(PasObject);
}

TCPlusObject BRect_Create_2(TPasObject PasObject, const BRect& rect)
{
  return new BPRect(PasObject, rect);
}

TCPlusObject BRect_Create_3(TPasObject PasObject, float l, float t, float r, float b)
{
  return new BPRect(PasObject, l, t, r, b);
}

TCPlusObject BRect_Create_4(TPasObject PasObject, BPoint leftTop, BPoint rightBottom)
{
  return new BPRect(PasObject, leftTop, rightBottom);
}

void BRect_Free(TCPlusObject rect)
{
  delete rect;
}

void BRect_PrintToStream(TCPlusObject rect)
{
	reinterpret_cast<BRect*>(rect)->PrintToStream();
}


#if defined(__cplusplus)
}
#endif


#endif _RECT_CPP_ /* _RECT_CPP_ */
