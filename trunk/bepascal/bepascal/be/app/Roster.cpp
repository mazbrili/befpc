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

#ifndef _ROSTER_CPP_
#define _ROSTER_CPP_

#include <Roster.h>
#include <Message.h>

#include <beobj.h>
#include <roster.h>

#if defined(__cplusplus)
extern "C" {
#endif

const TCPlusObject Get_be_roster(void)
{
		// Pas très propre ! Si quelqu'un a mieux...
	return TCPlusObject(be_roster);
}

TCPlusObject BRoster_Create(TPasObject PasObject)
{
	return new BRoster();
}

void BRoster_Destroy(TPasObject PasObject)
{
	delete PasObject;
}

status_t BRoster_Broadcast(TCPlusObject Roster, TCPlusObject *message)
{
	return reinterpret_cast<BRoster*>(Roster)->Broadcast(reinterpret_cast<BMessage*>(message));
}

#if defined(__cplusplus)
}
#endif

#endif /* _ROSTER_CPP_ */