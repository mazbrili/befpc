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

#ifndef _APPLICATION_H_
#define _APPLICATION_H_

#include <Application.h>
#include <Archivable.h>
#include <Message.h>

// #include <Control.cpp>

#include <window.h>
#include <view.h>
#include <point.h>
#include <rect.h>

#include <roster.h>
#include <looper.h>
#include <handler.h>
#include <archivable.h>
#include <message.h>
#include <beobj.h>

class BPApplication : public BApplication, public virtual BPLooper
{
	public:
		BPApplication(TPasObject PasObject, const char *signature);
		BPApplication(TPasObject PasObject, const char *signature, 
			status_t *error);
		virtual void AppActivated(bool active);
		virtual void ReadyToRun(void);
		virtual bool QuitRequested(void);
		virtual void MessageReceived(BMessage *message);		
	private:
};

#endif /* _APPLICATION_H_ */