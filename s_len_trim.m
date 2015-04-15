function len = s_len_trim ( s )
  len = length ( s );
  while ( 0 < len )
    if ( s(len) ~= ' ' )
      return
    end
    len = len - 1;
  end
  return
end