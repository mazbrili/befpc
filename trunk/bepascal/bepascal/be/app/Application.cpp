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

#ifndef _APPLICATION_CPP_
#define _APPLICATION_CPP_

#include <Application.h>
#include <Archivable.h>

#include <Roster.cpp>
#include <Message.cpp>
#include <Archivable.cpp>
#include <Handler.cpp>
#include <Looper.cpp>
#include <Window.cpp>
#include <View.cpp>
#include <Point.cpp>
#include <Rect.cpp>

#include <beobj.cpp>

// definition of callback function in BApplication
typedef void (*BApplication_AppActivated_hook) (TPasObject PasObject, bool active);
typedef void (*BApplication_ReadyToRun_hook) (TPasObject PasObject);
// typedef bool (*BApplication_QuitRequested_hook) (TPasObject PasObject);
// typedef void (*BApplication_MessageReceived_hook) (TPasObject PasObject, TCPlusObject message);

#if defined(__cplusplus)
extern "C" {
#endif

BApplication_AppActivated_hook Application_AppActivated_hook;
BApplication_ReadyToRun_hook Application_ReadyToRun_hook;
//BApplication_QuitRequested_hook Application_QuitRequested_hook;
//BApplication_MessageReceived_hook Application_MessageReceived_hook;

#if defined(__cplusplus)
}
#endif

class BPApplication : public BApplication, public BPLooper
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

BPApplication::BPApplication(TPasObject PasObject, const char *signature) 
	: BApplication(signature), BPLooper(PasObject)
{

}

BPApplication::BPApplication(TPasObject PasObject, const char *signature,
	 status_t *error) : BApplication(signature, error), BPLooper(PasObject)
{
}

void BPApplication::AppActivated(bool active)
{
	Application_AppActivated_hook(GetPasObject(), active);	
}

void BPApplication::ReadyToRun(void)
{
	Application_ReadyToRun_hook(GetPasObject());
}

bool BPApplication::QuitRequested(void)
{
	return BPLooper::QuitRequested();
} 

void BPApplication::MessageReceived(BMessage *message)
{
	BPHandler::MessageReceived(message);
}

#if defined(__cplusplus)
extern "C" {
#endif

TCPlusObject BApplication_Create_1(TPasObject PasObject)
{
	return new BPApplication(PasObject, "application/x-vnd.RuBe");
}

TCPlusObject BApplication_Create_2(TPasObject PasObject, const char *Signature)
{
	return new BPApplication(PasObject, Signature);
}

TCPlusObject BApplication_Create_3(TPasObject PasObject, const char *Signature,
	status_t *error)
{
	return new BPApplication(PasObject, Signature, error);
}

void BApplication_Free(TCPlusObject Application)
{
	delete Application;
}

void BApplication_HideCursor(TCPlusObject Application)
{
	reinterpret_cast<BApplication*>(Application)->HideCursor();
}

void BApplication_ShowCursor(TCPlusObject Application)
{
	reinterpret_cast<BApplication*>(Application)->ShowCursor();
}

thread_id BApplication_Run(TCPlusObject Application)
{
	return reinterpret_cast<BApplication*>(Application)->Run();
}

void BApplication_Quit(TCPlusObject Application)
{
	reinterpret_cast<BApplication*>(Application)->Quit();	
}



#if defined(__cplusplus)
}
#endif

#endif /* _APPLICATION_CPP_ */