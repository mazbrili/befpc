// Here we put defines to the supported features of FPC 1.x and 2.x

{$ifdef FPC}
  {$ifndef VER1_0}
    {$define SUPPORTS_DEF_PARAMS}
    {$define SUPPORTS_INLINE}

  {$endif VER1_0}
{$endif}
