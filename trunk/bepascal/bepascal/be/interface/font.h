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

#ifndef _FONT_H_
#define _FONT_H_

#include "Font.h"
#include "Rect.h"
#include <beobj.h>

class BPFont : public BFont, public BPasObject
{
	public:
		BPFont(TPasObject PasObject);
		BPFont(TPasObject PasObject, const BFont &font);
};

#endif _FONT_H_ /* _FONT_H_ */