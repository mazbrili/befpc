unit accelerant;
{
 (Manual) Translation of Be's GraphicDefs.h

 Ok, if TBitmap doesn't work, the error its most likely to be in this unit.

 What this unit needs? that someone take a look at the points marked with:

// Check/Confirm This one, please.

 I'm not too sure about how to translate the enums, and also not sure about
 the values of the index on a set. Excuse (and fix!) my ignorace :)

 Maybe I also screwed up a little the integer types too, be warned :^P

-- BiPolar.
}
interface

uses
  SupportDefs;

{$PACKRECORDS C}


// uint32 = integer uint16=word


type accelerant_device_info=record 
	version  : integer;	
	name : string[32];			
	chipset: string[32];		
	serial_no:string[32];		
	memory : integer;		
	dac_speed : integer;			
end;

type display_timing = record
	pixel_clock: integer;	
	h_display,		
	h_sync_start,
    h_sync_end,
	h_total,
	v_display,	
	v_sync_start,
	v_sync_end,
	v_total : word;
	flags :  integer;		
end;

type display_mode= record
	timing : display_timing	;			
	space : integer;		
	virtual_width,
	virtual_height,
	h_display_start,
	v_display_start : word;
	flags: integer;				
end;

type display_timing_constraints =record
		h_res:word;		
		h_sync_min:word;		
		h_sync_max:word;
		h_blank_min:word;	
		h_blank_max:word;
		v_res:word;			
		v_sync_min:word;		
		v_sync_max:word;
		v_blank_min:word;	
		v_blank_max:word;
end;

implementation

end.
