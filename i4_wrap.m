function value = i4_wrap ( ival, ilo, ihi )
  jlo = min ( ilo, ihi );
  jhi = max ( ilo, ihi );
  wide = jhi - jlo + 1;
  if ( wide == 1 )
    value = jlo;
  else
    value = jlo + i4_modp ( ival - jlo, wide );
  end
  return
end