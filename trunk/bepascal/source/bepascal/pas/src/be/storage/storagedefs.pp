unit StorageDefs;

interface

const  
    // from sys/param.h
  NAME_MAX = 256;
    // from limits.h  
  PATH_MAX = 1024;
  MAXPATHLEN = PATH_MAX;
  B_FILE_NAME_LENGTH = NAME_MAX;
  B_PATH_NAME_LENGTH = MAXPATHLEN;
  B_ATTR_NAME_LENGTH = B_FILE_NAME_LENGTH - 1;
  B_MIME_TYPE_LENGTH = B_ATTR_NAME_LENGTH - 15;
//  B_MAX_SYMLINKS = SYMLINK_MAX;

    // from fcntl.h
  O_RDONLY = 0;
  O_WRONLY = 1;
  O_RDWR = 2;
  O_RWMASK = 3;
  
  O_EXCL = $0100;
  O_CREAT = $0200;
  O_TRUNC = $0400;
  O_APPEND = $0800;

    // from StorageDefs.h
  B_READ_ONLY = O_RDONLY;
  B_WRITE_ONLY = O_WRONLY;
  B_READ_WRITE = O_RDWR;
  
  B_FAIL_IF_EXISTS = O_EXCL;
  B_CREATE_FILE = O_CREAT;
  B_ERASE_FILE = O_TRUNC;
  B_OPEN_AT_END = O_APPEND;
  
    // Node flavor
  B_FILE_NODE = $01;
  B_SYMLINK_NODE = $02;
  B_DIRECTORY_NODE = $04;
  B_ANY_NODE = $07;

type
  // from types.h
  dev_t = integer;
  ino_t = int64;


implementation

end.
