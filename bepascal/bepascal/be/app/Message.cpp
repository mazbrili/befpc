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

#ifndef _MESSAGE_CPP_
#define _MESSAGE_CPP_

#include <Application.h>
#include <Message.h>

#include <SupportDefs.h>

#include <message.h>
#include <beobj.h>

#if defined(__cplusplus)
extern "C" {
#endif
// No hook in BMessage
#if defined(__cplusplus)
}
#endif

BPMessage::BPMessage(TPasObject PasObject)
	: BMessage(), BPasObject(PasObject)
{

}

BPMessage::BPMessage(TPasObject PasObject, uint32 what)
	: BMessage(what), BPasObject(PasObject)
{

}

 BPMessage::BPMessage(TPasObject PasObject, TCPlusObject message)
	: BMessage(reinterpret_cast<BMessage&>(message)), BPasObject(PasObject)
{
// Attention, problème potentiel avec le reinterpret_cast de la référence
// A tester !
// Je ne suis pas sur de la correspondance entre le C++ et le pascal
}


#if defined(__cplusplus)
extern "C" {
#endif

TCPlusObject BMessage_Create_1(TPasObject PasObject)
{
	return new BPMessage(PasObject);
}

TCPlusObject BMessage_Create_2(TPasObject PasObject, uint32 what)
{
	return new BPMessage(PasObject, what);
}

 TCPlusObject BMessage_Create_3(TPasObject PasObject, TCPlusObject message)
{
	return new BPMessage(PasObject, message);
}

void BMessage_Free(TCPlusObject message)
{
	delete message;
}

uint32 BMessage_Getwhat(BMessage *message)
{
	return message->what;
}

void BMessage_Setwhat(BMessage *message, uint32 what)
{
	message->what = what;
}
/*
status_t BMessage_AddData(TCPlusObject message, const char *name,
	type_code type,
	const void *data,
	ssize_t fixedSize = true,
	int32 numItems = 1)
{
	return reinterpret_cast<BMessage*>(message)->AddData(name, type, data, 
		fixedSize, numItems);
}

status_t BMessage_AddBool(TCPlusObject message, const char *name, bool aBool)
{
	return reinterpret_cast<BMessage*>(message)->AddBool(name, aBool);
}

status_t BMessage_AddInt8(TCPlusObject message, const char *name, int8 anInt8)
{
	return reinterpret_cast<BMessage*>(message)->AddInt8(name, anInt8);
}

status_t BMessage_FindInt8(TCPlusObject message,const char *name, int8 *value) 
{
	return reinterpret_cast<BMessage*>(message)->FindInt8(name, value);
}


status_t BMessage_AddInt16(TCPlusObject message, const char *name, int16 anInt16)
{
	return reinterpret_cast<BMessage*>(message)->AddInt16(name, anInt16);
}

status_t BMessage_AddInt32(TCPlusObject message, const char *name, int32 anInt32)
{
	return reinterpret_cast<BMessage*>(message)->AddInt32(name, anInt32);
}

status_t BMessage_AddInt64(TCPlusObject message, const char *name, int64 anInt64)
{
	return reinterpret_cast<BMessage*>(message)->AddInt64(name, anInt64);
}

status_t BMessage_AddFloat(TCPlusObject message, const char *name, float aFloat)
{
	return reinterpret_cast<BMessage*>(message)->AddFloat(name, aFloat);
}

status_t BMessage_AddDouble(TCPlusObject message, const char *name, double aDouble)
{
	return reinterpret_cast<BMessage*>(message)->AddDouble(name, aDouble);
}

status_t BMessage_AddString(TCPlusObject message, const char *name, const char *string)
{
	return reinterpret_cast<BMessage*>(message)->AddString(name, string);
}

status_t BMessage_FindString(TCPlusObject message,const char *name, const char **str) 
{
	return reinterpret_cast<BMessage*>(message)->FindString(name, str);
}


status_t BMessage_AddMessage(TCPlusObject message, const char *name, const TCPlusObject amessage)
{
	return reinterpret_cast<BMessage*>(message)->AddMessage(name, reinterpret_cast<BMessage*>(amessage));
}

int32 BMessage_CountNames(TCPlusObject message, type_code type)
{
	return reinterpret_cast<BMessage*>(message)->CountNames(type);
}

bool BMessage_HasSpecifiers(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->HasSpecifiers();
}

bool BMessage_IsSystem(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->IsSystem();
}

status_t BMessage_MakeEmpty(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->MakeEmpty();
}

bool BMessage_IsEmpty(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->IsEmpty();
}

status_t BMessage_RemoveName(TCPlusObject message, const char *name)
{
	return reinterpret_cast<BMessage*>(message)->RemoveName(name);
}

void BMessage_PrintToStream(TCPlusObject message)
{
	reinterpret_cast<BMessage*>(message)->PrintToStream();
}

status_t BMessage_RemoveData(TCPlusObject message, const char *name, int32 index = 0)
{
	return reinterpret_cast<BMessage*>(message)->RemoveData(name, index);
}

bool BMessage_WasDelivered(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->WasDelivered();
}

bool BMessage_IsSourceRemote(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->IsSourceRemote();
}

bool BMessage_IsSourceWaiting(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->IsSourceWaiting();
}

bool BMessage_IsReply(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->IsReply();
}

const BMessage *BMessage_Previous(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->Previous();
}

bool BMessage_WasDropped(TCPlusObject message)
{
	return reinterpret_cast<BMessage*>(message)->WasDropped();
}
*/
/***********************************************************************
 *  Method: BMessage::operator=
 *  Params: const BMessage &msg
 * Returns: BMessage &
 * Effects: 
 ***********************************************************************/
BMessage &
BMessage_operator_equal(BMessage *Message, const BMessage &msg)
{
   return Message->operator=(msg);
}

/***********************************************************************
 *  Method: BMessage::GetInfo
 *  Params: type_code typeRequested, int32 which, char **name, type_code *typeReturned, int32 *count
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_GetInfo(BMessage *Message, type_code typeRequested, int32 which, char **name, type_code *typeReturned, int32 *count)
{
   return Message->GetInfo(typeRequested, which, name, typeReturned, count);
}


/***********************************************************************
 *  Method: BMessage::GetInfo
 *  Params: const char *name, type_code *type, int32 *c
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_GetInfo_1
(BMessage *Message, const char *name, type_code *type, int32 *c) 
{
   return Message->GetInfo(name, type, c);
}


/***********************************************************************
 *  Method: BMessage::GetInfo
 *  Params: const char *name, type_code *type, bool *fixed_size
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_GetInfo_2
(BMessage *Message, const char *name, type_code *type, bool *fixed_size) 
{
   return Message->GetInfo(name, type, fixed_size);
}


/***********************************************************************
 *  Method: BMessage::CountNames
 *  Params: type_code type
 * Returns: int32
 * Effects: 
 ***********************************************************************/
int32
BMessage_CountNames(BMessage *Message, type_code type) 
{
   return Message->CountNames(type);
}


/***********************************************************************
 *  Method: BMessage::IsEmpty
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_IsEmpty(BMessage *Message) 
{
   return Message->IsEmpty();
}


/***********************************************************************
 *  Method: BMessage::IsSystem
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_IsSystem(BMessage *Message) 
{
   return Message->IsSystem();
}


/***********************************************************************
 *  Method: BMessage::IsReply
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_IsReply(BMessage *Message) 
{
   return Message->IsReply();
}


/***********************************************************************
 *  Method: BMessage::PrintToStream
 *  Params: 
 * Returns: void
 * Effects: 
 ***********************************************************************/
void
BMessage_PrintToStream(BMessage *Message) 
{
   Message->PrintToStream();
}


/***********************************************************************
 *  Method: BMessage::Rename
 *  Params: const char *old_entry, const char *new_entry
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_Rename(BMessage *Message, const char *old_entry, const char *new_entry)
{
   return Message->Rename(old_entry, new_entry);
}


/***********************************************************************
 *  Method: BMessage::WasDelivered
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_WasDelivered(BMessage *Message) 
{
   return Message->WasDelivered();
}


/***********************************************************************
 *  Method: BMessage::IsSourceWaiting
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_IsSourceWaiting(BMessage *Message) 
{
   return Message->IsSourceWaiting();
}


/***********************************************************************
 *  Method: BMessage::IsSourceRemote
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_IsSourceRemote(BMessage *Message) 
{
   return Message->IsSourceRemote();
}


/***********************************************************************
 *  Method: BMessage::ReturnAddress
 *  Params: 
 * Returns: BMessenger
 * Effects: 
 ***********************************************************************/
BMessenger
BMessage_ReturnAddress(BMessage *Message) 
{
   return Message->ReturnAddress();
}


/***********************************************************************
 *  Method: BMessage::Previous
 *  Params: 
 * Returns: const BMessage *
 * Effects: 
 ***********************************************************************/
const BMessage *
BMessage_Previous(BMessage *Message) 
{
   return Message->Previous();
}


/***********************************************************************
 *  Method: BMessage::WasDropped
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_WasDropped(BMessage *Message) 
{
   return Message->WasDropped();
}


/***********************************************************************
 *  Method: BMessage::DropPoint
 *  Params: BPoint *offset
 * Returns: BPoint
 * Effects: 
 ***********************************************************************/
BPoint
BMessage_DropPoint(BMessage *Message, BPoint *offset) 
{
   return Message->DropPoint(offset);
}


/***********************************************************************
 *  Method: BMessage::SendReply
 *  Params: uint32 command, BHandler *reply_to
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_SendReply(BMessage *Message, uint32 command, BHandler *reply_to)
{
   return Message->SendReply(command, reply_to);
}


/***********************************************************************
 *  Method: BMessage::SendReply
 *  Params: BMessage *the_reply, BHandler *reply_to, bigtime_t timeout
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_SendReply_1
(BMessage *Message, BMessage *the_reply, BHandler *reply_to, bigtime_t timeout)
{
   return Message->SendReply(the_reply, reply_to, timeout);
}


/***********************************************************************
 *  Method: BMessage::SendReply
 *  Params: BMessage *the_reply, BMessenger reply_to, bigtime_t timeout
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_SendReply_2
(BMessage *Message, BMessage *the_reply, BMessenger reply_to, bigtime_t timeout)
{
   return Message->SendReply(the_reply, reply_to, timeout);
}


/***********************************************************************
 *  Method: BMessage::SendReply
 *  Params: uint32 command, BMessage *reply_to_reply
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_SendReply_3
(BMessage *Message, uint32 command, BMessage *reply_to_reply)
{
   return Message->SendReply(command, reply_to_reply);
}


/***********************************************************************
 *  Method: BMessage::SendReply
 *  Params: BMessage *the_reply, BMessage *reply_to_reply, bigtime_t send_timeout, bigtime_t reply_timeout
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_SendReply_4
(BMessage *Message, BMessage *the_reply, BMessage *reply_to_reply, bigtime_t send_timeout, bigtime_t reply_timeout)
{
   return Message->SendReply(the_reply, reply_to_reply, send_timeout, reply_timeout);
}


/***********************************************************************
 *  Method: BMessage::FlattenedSize
 *  Params: 
 * Returns: ssize_t
 * Effects: 
 ***********************************************************************/
ssize_t
BMessage_FlattenedSize(BMessage *Message) 
{
   return Message->FlattenedSize();
}


/***********************************************************************
 *  Method: BMessage::Flatten
 *  Params: char *buffer, ssize_t size
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_Flatten(BMessage *Message, char *buffer, ssize_t size) 
{
   return Message->Flatten(buffer, size);
}


/***********************************************************************
 *  Method: BMessage::Flatten
 *  Params: BDataIO *stream, ssize_t *size
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_Flatten_1
(BMessage *Message, BDataIO *stream, ssize_t *size) 
{
   return Message->Flatten(stream, size);
}


/***********************************************************************
 *  Method: BMessage::Unflatten
 *  Params: const char *flat_buffer
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_Unflatten(BMessage *Message, const char *flat_buffer)
{
   return Message->Unflatten(flat_buffer);
}


/***********************************************************************
 *  Method: BMessage::Unflatten
 *  Params: BDataIO *stream
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_Unflatten_1
(BMessage *Message, BDataIO *stream)
{
   return Message->Unflatten(stream);
}


/***********************************************************************
 *  Method: BMessage::AddSpecifier
 *  Params: const char *property
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddSpecifier(BMessage *Message, const char *property)
{
   return Message->AddSpecifier(property);
}


/***********************************************************************
 *  Method: BMessage::AddSpecifier
 *  Params: const char *property, int32 index
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddSpecifier_1
(BMessage *Message, const char *property, int32 index)
{
   return Message->AddSpecifier(property, index);
}


/***********************************************************************
 *  Method: BMessage::AddSpecifier
 *  Params: const char *property, int32 index, int32 range
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddSpecifier_2
(BMessage *Message, const char *property, int32 index, int32 range)
{
   return Message->AddSpecifier(property, index, range);
}


/***********************************************************************
 *  Method: BMessage::AddSpecifier
 *  Params: const char *property, const char *name
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddSpecifier_3
(BMessage *Message, const char *property, const char *name)
{
   return Message->AddSpecifier(property, name);
}


/***********************************************************************
 *  Method: BMessage::AddSpecifier
 *  Params: const BMessage *specifier
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddSpecifier_4
(BMessage *Message, const BMessage *specifier)
{
   return Message->AddSpecifier(specifier);
}


/***********************************************************************
 *  Method: BMessage::SetCurrentSpecifier
 *  Params: int32 index
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_SetCurrentSpecifier(BMessage *Message, int32 index)
{
   return Message->SetCurrentSpecifier(index);
}


/***********************************************************************
 *  Method: BMessage::GetCurrentSpecifier
 *  Params: int32 *index, BMessage *specifier, int32 *form, const char **property
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_GetCurrentSpecifier(BMessage *Message, int32 *index, BMessage *specifier, int32 *form, const char **property) 
{
   return Message->GetCurrentSpecifier(index, specifier, form, property);
}


/***********************************************************************
 *  Method: BMessage::HasSpecifiers
 *  Params: 
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasSpecifiers(BMessage *Message) 
{
   return Message->HasSpecifiers();
}


/***********************************************************************
 *  Method: BMessage::PopSpecifier
 *  Params: 
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_PopSpecifier(BMessage *Message)
{
   return Message->PopSpecifier();
}


/***********************************************************************
 *  Method: BMessage::AddRect
 *  Params: const char *name, BRect a_rect
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddRect(BMessage *Message, const char *name, BRect a_rect)
{
   return Message->AddRect(name, a_rect);
}


/***********************************************************************
 *  Method: BMessage::AddPoint
 *  Params: const char *name, BPoint a_point
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddPoint(BMessage *Message, const char *name, BPoint a_point)
{
   return Message->AddPoint(name, a_point);
}


/***********************************************************************
 *  Method: BMessage::AddString
 *  Params: const char *name, const char *a_string
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddString(BMessage *Message, const char *name, const char *a_string)
{
   return Message->AddString(name, a_string);
}


/***********************************************************************
 *  Method: BMessage::AddString
 *  Params: const char *name, const BString &a_string
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddString_1
(BMessage *Message, const char *name, const BString &a_string)
{
   return Message->AddString(name, a_string);
}


/***********************************************************************
 *  Method: BMessage::AddInt8
 *  Params: const char *name, int8 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddInt8(BMessage *Message, const char *name, int8 val)
{
   return Message->AddInt8(name, val);
}


/***********************************************************************
 *  Method: BMessage::AddInt16
 *  Params: const char *name, int16 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddInt16(BMessage *Message, const char *name, int16 val)
{
   return Message->AddInt16(name, val);
}


/***********************************************************************
 *  Method: BMessage::AddInt32
 *  Params: const char *name, int32 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddInt32(BMessage *Message, const char *name, int32 val)
{
   return Message->AddInt32(name, val);
}


/***********************************************************************
 *  Method: BMessage::AddInt64
 *  Params: const char *name, int64 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddInt64(BMessage *Message, const char *name, int64 val)
{
   return Message->AddInt64(name, val);
}


/***********************************************************************
 *  Method: BMessage::AddBool
 *  Params: const char *name, bool a_boolean
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddBool(BMessage *Message, const char *name, bool a_boolean)
{
   return Message->AddBool(name, a_boolean);
}


/***********************************************************************
 *  Method: BMessage::AddFloat
 *  Params: const char *name, float a_float
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddFloat(BMessage *Message, const char *name, float a_float)
{
   return Message->AddFloat(name, a_float);
}


/***********************************************************************
 *  Method: BMessage::AddDouble
 *  Params: const char *name, double a_double
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddDouble(BMessage *Message, const char *name, double a_double)
{
   return Message->AddDouble(name, a_double);
}


/***********************************************************************
 *  Method: BMessage::AddPointer
 *  Params: const char *name, const void *ptr
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddPointer(BMessage *Message, const char *name, const void *ptr)
{
   return Message->AddPointer(name, ptr);
}


/***********************************************************************
 *  Method: BMessage::AddMessenger
 *  Params: const char *name, BMessenger messenger
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddMessenger(BMessage *Message, const char *name, BMessenger messenger)
{
   return Message->AddMessenger(name, messenger);
}


/***********************************************************************
 *  Method: BMessage::AddRef
 *  Params: const char *name, const entry_ref *ref
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddRef(BMessage *Message, const char *name, const entry_ref *ref)
{
   return Message->AddRef(name, ref);
}


/***********************************************************************
 *  Method: BMessage::AddMessage
 *  Params: const char *name, const BMessage *msg
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddMessage(BMessage *Message, const char *name, const BMessage *msg)
{
   return Message->AddMessage(name, msg);
}


/***********************************************************************
 *  Method: BMessage::AddFlat
 *  Params: const char *name, BFlattenable *obj, int32 count
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddFlat(BMessage *Message, const char *name, BFlattenable *obj, int32 count)
{
   return Message->AddFlat(name, obj, count);
}


/***********************************************************************
 *  Method: BMessage::AddData
 *  Params: const char *name, type_code type, const void *data, ssize_t numBytes, bool is_fixed_size, int32 count
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_AddData(BMessage *Message, const char *name, type_code type, const void *data, ssize_t numBytes, bool is_fixed_size, int32 count)
{
   return Message->AddData(name, type, data, numBytes, is_fixed_size, count);
}


/***********************************************************************
 *  Method: BMessage::RemoveData
 *  Params: const char *name, int32 index
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_RemoveData(BMessage *Message, const char *name, int32 index)
{
   return Message->RemoveData(name, index);
}


/***********************************************************************
 *  Method: BMessage::RemoveName
 *  Params: const char *name
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_RemoveName(BMessage *Message, const char *name)
{
   return Message->RemoveName(name);
}


/***********************************************************************
 *  Method: BMessage::MakeEmpty
 *  Params: 
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_MakeEmpty(BMessage *Message)
{
   return Message->MakeEmpty();
}


/***********************************************************************
 *  Method: BMessage::FindRect
 *  Params: const char *name, BRect *rect
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindRect(BMessage *Message, const char *name, BRect *rect) 
{
   return Message->FindRect(name, rect);
}


/***********************************************************************
 *  Method: BMessage::FindRect
 *  Params: const char *name, int32 index, BRect *rect
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindRect_1
(BMessage *Message, const char *name, int32 index, BRect *rect) 
{
   return Message->FindRect(name, index, rect);
}


/***********************************************************************
 *  Method: BMessage::FindPoint
 *  Params: const char *name, BPoint *pt
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindPoint(BMessage *Message, const char *name, BPoint *pt) 
{
   return Message->FindPoint(name, pt);
}


/***********************************************************************
 *  Method: BMessage::FindPoint
 *  Params: const char *name, int32 index, BPoint *pt
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindPoint_1
(BMessage *Message, const char *name, int32 index, BPoint *pt) 
{
   return Message->FindPoint(name, index, pt);
}


/***********************************************************************
 *  Method: BMessage::FindString
 *  Params: const char *name, const char **str
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindString(BMessage *Message, const char *name, const char **str) 
{
   return Message->FindString(name, str);
}


/***********************************************************************
 *  Method: BMessage::FindString
 *  Params: const char *name, int32 index, const char **str
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindString_1
(BMessage *Message, const char *name, int32 index, const char **str) 
{
   return Message->FindString(name, index, str);
}


/***********************************************************************
 *  Method: BMessage::FindString
 *  Params: const char *name, BString *str
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindString_2
(BMessage *Message, const char *name, BString *str) 
{
   return Message->FindString(name, str);
}


/***********************************************************************
 *  Method: BMessage::FindString
 *  Params: const char *name, int32 index, BString *str
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindString_3
(BMessage *Message, const char *name, int32 index, BString *str) 
{
   return Message->FindString(name, index, str);
}


/***********************************************************************
 *  Method: BMessage::FindInt8
 *  Params: const char *name, int8 *value
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt8(BMessage *Message, const char *name, int8 *value) 
{
   return Message->FindInt8(name, value);
}


/***********************************************************************
 *  Method: BMessage::FindInt8
 *  Params: const char *name, int32 index, int8 *val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt8_1
(BMessage *Message, const char *name, int32 index, int8 *val) 
{
   return Message->FindInt8(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::FindInt16
 *  Params: const char *name, int16 *value
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt16(BMessage *Message, const char *name, int16 *value) 
{
   return Message->FindInt16(name, value);
}


/***********************************************************************
 *  Method: BMessage::FindInt16
 *  Params: const char *name, int32 index, int16 *val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt16_1
(BMessage *Message, const char *name, int32 index, int16 *val) 
{
   return Message->FindInt16(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::FindInt32
 *  Params: const char *name, int32 *value
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt32(BMessage *Message, const char *name, int32 *value) 
{
   return Message->FindInt32(name, value);
}


/***********************************************************************
 *  Method: BMessage::FindInt32
 *  Params: const char *name, int32 index, int32 *val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt32_1
(BMessage *Message, const char *name, int32 index, int32 *val) 
{
   return Message->FindInt32(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::FindInt64
 *  Params: const char *name, int64 *value
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt64(BMessage *Message, const char *name, int64 *value) 
{
   return Message->FindInt64(name, value);
}


/***********************************************************************
 *  Method: BMessage::FindInt64
 *  Params: const char *name, int32 index, int64 *val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindInt64_1
(BMessage *Message, const char *name, int32 index, int64 *val) 
{
   return Message->FindInt64(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::FindBool
 *  Params: const char *name, bool *value
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindBool(BMessage *Message, const char *name, bool *value) 
{
   return Message->FindBool(name, value);
}


/***********************************************************************
 *  Method: BMessage::FindBool
 *  Params: const char *name, int32 index, bool *value
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindBool_1
(BMessage *Message, const char *name, int32 index, bool *value) 
{
   return Message->FindBool(name, index, value);
}


/***********************************************************************
 *  Method: BMessage::FindFloat
 *  Params: const char *name, float *f
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindFloat(BMessage *Message, const char *name, float *f) 
{
   return Message->FindFloat(name, f);
}


/***********************************************************************
 *  Method: BMessage::FindFloat
 *  Params: const char *name, int32 index, float *f
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindFloat_1
(BMessage *Message, const char *name, int32 index, float *f) 
{
   return Message->FindFloat(name, index, f);
}


/***********************************************************************
 *  Method: BMessage::FindDouble
 *  Params: const char *name, double *d
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindDouble(BMessage *Message, const char *name, double *d) 
{
   return Message->FindDouble(name, d);
}


/***********************************************************************
 *  Method: BMessage::FindDouble
 *  Params: const char *name, int32 index, double *d
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindDouble_1
(BMessage *Message, const char *name, int32 index, double *d) 
{
   return Message->FindDouble(name, index, d);
}


/***********************************************************************
 *  Method: BMessage::FindPointer
 *  Params: const char *name, void **ptr
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindPointer(BMessage *Message, const char *name, void **ptr) 
{
   return Message->FindPointer(name, ptr);
}


/***********************************************************************
 *  Method: BMessage::FindPointer
 *  Params: const char *name, int32 index, void **ptr
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindPointer_1
(BMessage *Message, const char *name, int32 index, void **ptr) 
{
   return Message->FindPointer(name, index, ptr);
}


/***********************************************************************
 *  Method: BMessage::FindMessenger
 *  Params: const char *name, BMessenger *m
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindMessenger(BMessage *Message, const char *name, BMessenger *m) 
{
   return Message->FindMessenger(name, m);
}


/***********************************************************************
 *  Method: BMessage::FindMessenger
 *  Params: const char *name, int32 index, BMessenger *m
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindMessenger_1
(BMessage *Message, const char *name, int32 index, BMessenger *m) 
{
   return Message->FindMessenger(name, index, m);
}


/***********************************************************************
 *  Method: BMessage::FindRef
 *  Params: const char *name, entry_ref *ref
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindRef(BMessage *Message, const char *name, entry_ref *ref) 
{
   return Message->FindRef(name, ref);
}


/***********************************************************************
 *  Method: BMessage::FindRef
 *  Params: const char *name, int32 index, entry_ref *ref
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindRef_1
(BMessage *Message, const char *name, int32 index, entry_ref *ref) 
{
   return Message->FindRef(name, index, ref);
}


/***********************************************************************
 *  Method: BMessage::FindMessage
 *  Params: const char *name, BMessage *msg
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindMessage(BMessage *Message, const char *name, BMessage *msg) 
{
   return Message->FindMessage(name, msg);
}


/***********************************************************************
 *  Method: BMessage::FindMessage
 *  Params: const char *name, int32 index, BMessage *msg
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindMessage_1
(BMessage *Message, const char *name, int32 index, BMessage *msg) 
{
   return Message->FindMessage(name, index, msg);
}


/***********************************************************************
 *  Method: BMessage::FindFlat
 *  Params: const char *name, BFlattenable *obj
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindFlat(BMessage *Message, const char *name, BFlattenable *obj) 
{
   return Message->FindFlat(name, obj);
}


/***********************************************************************
 *  Method: BMessage::FindFlat
 *  Params: const char *name, int32 index, BFlattenable *obj
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindFlat_1
(BMessage *Message, const char *name, int32 index, BFlattenable *obj) 
{
   return Message->FindFlat(name, index, obj);
}


/***********************************************************************
 *  Method: BMessage::FindData
 *  Params: const char *name, type_code type, const void **data, ssize_t *numBytes
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindData(BMessage *Message, const char *name, type_code type, const void **data, ssize_t *numBytes) 
{
   return Message->FindData(name, type, data, numBytes);
}


/***********************************************************************
 *  Method: BMessage::FindData
 *  Params: const char *name, type_code type, int32 index, const void **data, ssize_t *numBytes
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_FindData_1
(BMessage *Message, const char *name, type_code type, int32 index, const void **data, ssize_t *numBytes) 
{
   return Message->FindData(name, type, index, data, numBytes);
}


/***********************************************************************
 *  Method: BMessage::ReplaceRect
 *  Params: const char *name, BRect a_rect
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceRect(BMessage *Message, const char *name, BRect a_rect)
{
   return Message->ReplaceRect(name, a_rect);
}


/***********************************************************************
 *  Method: BMessage::ReplaceRect
 *  Params: const char *name, int32 index, BRect a_rect
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceRect_1
(BMessage *Message, const char *name, int32 index, BRect a_rect)
{
   return Message->ReplaceRect(name, index, a_rect);
}


/***********************************************************************
 *  Method: BMessage::ReplacePoint
 *  Params: const char *name, BPoint a_point
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplacePoint(BMessage *Message, const char *name, BPoint a_point)
{
   return Message->ReplacePoint(name, a_point);
}


/***********************************************************************
 *  Method: BMessage::ReplacePoint
 *  Params: const char *name, int32 index, BPoint a_point
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplacePoint_1
(BMessage *Message, const char *name, int32 index, BPoint a_point)
{
   return Message->ReplacePoint(name, index, a_point);
}


/***********************************************************************
 *  Method: BMessage::ReplaceString
 *  Params: const char *name, const char *string
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceString(BMessage *Message, const char *name, const char *string)
{
   return Message->ReplaceString(name, string);
}


/***********************************************************************
 *  Method: BMessage::ReplaceString
 *  Params: const char *name, int32 index, const char *string
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceString_1
(BMessage *Message, const char *name, int32 index, const char *string)
{
   return Message->ReplaceString(name, index, string);
}


/***********************************************************************
 *  Method: BMessage::ReplaceString
 *  Params: const char *name, const BString &string
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceString_2
(BMessage *Message, const char *name, const BString &string)
{
   return Message->ReplaceString(name, string);
}


/***********************************************************************
 *  Method: BMessage::ReplaceString
 *  Params: const char *name, int32 index, const BString &string
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceString_3
(BMessage *Message, const char *name, int32 index, const BString &string)
{
   return Message->ReplaceString(name, index, string);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt8
 *  Params: const char *name, int8 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt8(BMessage *Message, const char *name, int8 val)
{
   return Message->ReplaceInt8(name, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt8
 *  Params: const char *name, int32 index, int8 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt8_1
(BMessage *Message, const char *name, int32 index, int8 val)
{
   return Message->ReplaceInt8(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt16
 *  Params: const char *name, int16 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt16(BMessage *Message, const char *name, int16 val)
{
   return Message->ReplaceInt16(name, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt16
 *  Params: const char *name, int32 index, int16 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt16_1
(BMessage *Message, const char *name, int32 index, int16 val)
{
   return Message->ReplaceInt16(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt32
 *  Params: const char *name, int32 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt32(BMessage *Message, const char *name, int32 val)
{
   return Message->ReplaceInt32(name, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt32
 *  Params: const char *name, int32 index, int32 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt32_1
(BMessage *Message, const char *name, int32 index, int32 val)
{
   return Message->ReplaceInt32(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt64
 *  Params: const char *name, int64 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt64(BMessage *Message, const char *name, int64 val)
{
   return Message->ReplaceInt64(name, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceInt64
 *  Params: const char *name, int32 index, int64 val
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceInt64_1
(BMessage *Message, const char *name, int32 index, int64 val)
{
   return Message->ReplaceInt64(name, index, val);
}


/***********************************************************************
 *  Method: BMessage::ReplaceBool
 *  Params: const char *name, bool a_bool
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceBool(BMessage *Message, const char *name, bool a_bool)
{
   return Message->ReplaceBool(name, a_bool);
}


/***********************************************************************
 *  Method: BMessage::ReplaceBool
 *  Params: const char *name, int32 index, bool a_bool
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceBool_1
(BMessage *Message, const char *name, int32 index, bool a_bool)
{
   return Message->ReplaceBool(name, index, a_bool);
}


/***********************************************************************
 *  Method: BMessage::ReplaceFloat
 *  Params: const char *name, float a_float
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceFloat(BMessage *Message, const char *name, float a_float)
{
   return Message->ReplaceFloat(name, a_float);
}


/***********************************************************************
 *  Method: BMessage::ReplaceFloat
 *  Params: const char *name, int32 index, float a_float
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceFloat_1
(BMessage *Message, const char *name, int32 index, float a_float)
{
   return Message->ReplaceFloat(name, index, a_float);
}


/***********************************************************************
 *  Method: BMessage::ReplaceDouble
 *  Params: const char *name, double a_double
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceDouble(BMessage *Message, const char *name, double a_double)
{
   return Message->ReplaceDouble(name, a_double);
}


/***********************************************************************
 *  Method: BMessage::ReplaceDouble
 *  Params: const char *name, int32 index, double a_double
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceDouble_1
(BMessage *Message, const char *name, int32 index, double a_double)
{
   return Message->ReplaceDouble(name, index, a_double);
}


/***********************************************************************
 *  Method: BMessage::ReplacePointer
 *  Params: const char *name, const void *ptr
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplacePointer(BMessage *Message, const char *name, const void *ptr)
{
   return Message->ReplacePointer(name, ptr);
}


/***********************************************************************
 *  Method: BMessage::ReplacePointer
 *  Params: const char *name, int32 index, const void *ptr
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplacePointer_1
(BMessage *Message, const char *name, int32 index, const void *ptr)
{
   return Message->ReplacePointer(name, index, ptr);
}


/***********************************************************************
 *  Method: BMessage::ReplaceMessenger
 *  Params: const char *name, BMessenger messenger
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceMessenger(BMessage *Message, const char *name, BMessenger messenger)
{
   return Message->ReplaceMessenger(name, messenger);
}


/***********************************************************************
 *  Method: BMessage::ReplaceMessenger
 *  Params: const char *name, int32 index, BMessenger msngr
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceMessenger_1
(BMessage *Message, const char *name, int32 index, BMessenger msngr)
{
   return Message->ReplaceMessenger(name, index, msngr);
}


/***********************************************************************
 *  Method: BMessage::ReplaceRef
 *  Params: const char *name, const entry_ref *ref
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceRef(BMessage *Message, const char *name, const entry_ref *ref)
{
   return Message->ReplaceRef(name, ref);
}


/***********************************************************************
 *  Method: BMessage::ReplaceRef
 *  Params: const char *name, int32 index, const entry_ref *ref
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceRef_1
(BMessage *Message, const char *name, int32 index, const entry_ref *ref)
{
   return Message->ReplaceRef(name, index, ref);
}


/***********************************************************************
 *  Method: BMessage::ReplaceMessage
 *  Params: const char *name, const BMessage *msg
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceMessage(BMessage *Message, const char *name, const BMessage *msg)
{
   return Message->ReplaceMessage(name, msg);
}


/***********************************************************************
 *  Method: BMessage::ReplaceMessage
 *  Params: const char *name, int32 index, const BMessage *msg
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceMessage_1
(BMessage *Message, const char *name, int32 index, const BMessage *msg)
{
   return Message->ReplaceMessage(name, index, msg);
}


/***********************************************************************
 *  Method: BMessage::ReplaceFlat
 *  Params: const char *name, BFlattenable *obj
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceFlat(BMessage *Message, const char *name, BFlattenable *obj)
{
   return Message->ReplaceFlat(name, obj);
}


/***********************************************************************
 *  Method: BMessage::ReplaceFlat
 *  Params: const char *name, int32 index, BFlattenable *obj
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceFlat_1
(BMessage *Message, const char *name, int32 index, BFlattenable *obj)
{
   return Message->ReplaceFlat(name, index, obj);
}


/***********************************************************************
 *  Method: BMessage::ReplaceData
 *  Params: const char *name, type_code type, const void *data, ssize_t data_size
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceData(BMessage *Message, const char *name, type_code type, const void *data, ssize_t data_size)
{
   return Message->ReplaceData(name, type, data, data_size);
}


/***********************************************************************
 *  Method: BMessage::ReplaceData
 *  Params: const char *name, type_code type, int32 index, const void *data, ssize_t data_size
 * Returns: status_t
 * Effects: 
 ***********************************************************************/
status_t
BMessage_ReplaceData_1
(BMessage *Message, const char *name, type_code type, int32 index, const void *data, ssize_t data_size)
{
   return Message->ReplaceData(name, type, index, data, data_size);
}


/***********************************************************************
 *  Method: BMessage::operator new
 *  Params: size_t size
 * Returns: void *
 * Effects: 
 ***********************************************************************/
/*void *
BMessage_operator new(BMessage *Message, size_t size)
{
   Message->operator new(size);
}
*/


/***********************************************************************
 *  Method: BMessage::operator delete
 *  Params: void *ptr, size_t size
 * Returns: void
 * Effects: 
 ***********************************************************************/
/*void
BMessage_operator delete(BMessage *Message, void *ptr, size_t size)
{
   Message->operator delete(ptr, size);
}
*/

/***********************************************************************
 *  Method: BMessage::HasRect
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasRect(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasRect(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasPoint
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasPoint(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasPoint(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasString
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasString(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasString(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasInt8
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasInt8(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasInt8(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasInt16
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasInt16(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasInt16(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasInt32
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasInt32(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasInt32(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasInt64
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasInt64(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasInt64(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasBool
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasBool(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasBool(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasFloat
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasFloat(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasFloat(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasDouble
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasDouble(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasDouble(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasPointer
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasPointer(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasPointer(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasMessenger
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasMessenger(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasMessenger(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasRef
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasRef(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasRef(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasMessage
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasMessage(BMessage *Message, const char *name, int32 n) 
{
   return Message->HasMessage(name, n);
}


/***********************************************************************
 *  Method: BMessage::HasFlat
 *  Params: const char *, const BFlattenable *
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasFlat(BMessage *Message, const char *name, const BFlattenable *flatten) 
{
   return Message->HasFlat(name, flatten);
}


/***********************************************************************
 *  Method: BMessage::HasFlat
 *  Params: const char *, int32, const BFlattenable *
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasFlat_1
(BMessage *Message, const char *name, int32 index, const BFlattenable *flatten) 
{
   return Message->HasFlat(name, index, flatten);
}


/***********************************************************************
 *  Method: BMessage::HasData
 *  Params: const char *, type_code, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_HasData(BMessage *Message, const char *name, type_code code, int32 n) 
{
   return Message->HasData(name, code, n);
}


/***********************************************************************
 *  Method: BMessage::FindRect
 *  Params: const char *, int32 n
 * Returns: BRect
 * Effects: 
 ***********************************************************************/
BRect
BMessage_FindRect_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindRect(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindPoint
 *  Params: const char *, int32 n
 * Returns: BPoint
 * Effects: 
 ***********************************************************************/
BPoint
BMessage_FindPoint_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindPoint(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindString
 *  Params: const char *, int32 n
 * Returns: const char *
 * Effects: 
 ***********************************************************************/
const char *
BMessage_FindString_4(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindString(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindInt8
 *  Params: const char *, int32 n
 * Returns: int8
 * Effects: 
 ***********************************************************************/
int8
BMessage_FindInt8_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindInt8(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindInt16
 *  Params: const char *, int32 n
 * Returns: int16
 * Effects: 
 ***********************************************************************/
int16
BMessage_FindInt16_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindInt16(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindInt32
 *  Params: const char *, int32 n
 * Returns: int32
 * Effects: 
 ***********************************************************************/
int32
BMessage_FindInt32_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindInt32(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindInt64
 *  Params: const char *, int32 n
 * Returns: int64
 * Effects: 
 ***********************************************************************/
int64
BMessage_FindInt64_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindInt64(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindBool
 *  Params: const char *, int32 n
 * Returns: bool
 * Effects: 
 ***********************************************************************/
bool
BMessage_FindBool_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindBool(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindFloat
 *  Params: const char *, int32 n
 * Returns: float
 * Effects: 
 ***********************************************************************/
float
BMessage_FindFloat_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindFloat(name, n);
}


/***********************************************************************
 *  Method: BMessage::FindDouble
 *  Params: const char *, int32 n
 * Returns: double
 * Effects: 
 ***********************************************************************/
double
BMessage_FindDouble_2(BMessage *Message, const char *name, int32 n) 
{
   return Message->FindDouble(name, n);
}

#if defined(__cplusplus)
}
#endif


#endif /* _MESSAGE_CPP_ */