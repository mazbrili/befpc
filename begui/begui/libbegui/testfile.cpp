#include "MFile.h"
#include "BeGuiAPI.h"
#include <stdlib.h>
#include <string.h>



void file_io(void* sender, uint32 msg, const char *path){
  char *buffer; //for output
  void *file;   //for MFile reference
  
  buffer = (char*) malloc(27); //create some space in the buffer
  buffer = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; //add domething to put in file
  
  //file output...
  file = MFile_Create(path, B_READ_WRITE | B_CREATE_FILE); //file read/write and create if not already there
  MFile_Write( (MFile*)file, buffer, strlen(buffer) ); //output buffer contents
  MFile_Free((MFile*)file); //clear the file pointer
}

int main(){
  void *savepanel; // MSavePanel reference
  void *app;       // MApplication reference
  
  // Matt 11/04/2002 : Must have a MApplication to use a MFilePanel of descendents
  app = MApplication_Create(); //create an MApplication reference
  
  savepanel = MSavePanel_Create(); //create a MSavePanel reference
  MFilePanel_AttachDialogEvent((MFilePanel*)savepanel, file_io); //attach callback for event
  
  MSavePanel_Show((MSavePanel*) savepanel); //show the panel (this is modal)
  
  MApplication_Run((MApplication*)app); //run the application
  
  MApplication_Free((MApplication*)app); //clean up the app

}
