function value = i4_modp ( i, j )
  value = mod ( i, j );
  if ( value < 0 )
    value = value + abs ( j );
  end
  return
end