{  BePascal - A pascal wrapper around the BeOS API
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
}

unit os;

interface

const
  B_LOW_LATENCY = 5;
  B_LOW_PRIORITY = 5;
  B_NORMAL_PRIORITY = 10;
  B_DISPLAY_PRIORITY = 15;
  B_URGENT_DISPLAY_PRIORITY = 20;
  B_REAL_TIME_DISPLAY_PRIORITY = 100;
  B_URGENT_PRIORITY = 110;
  B_REAL_TIME_PRIORITY = 120;

const
  B_OS_NAME_LENGTH = 32;
  B_PAGE_SIZE = 4096;
  B_INFINITE_TIMEOUT = 9223372036854775807;
  
type
  TThread_id = Longint;

implementation

end.