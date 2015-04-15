function table = r8mat_data_read ( input_filename, m, n )
  string = ' ';
  for i = 0 : m
    string = strcat ( string, ' %f' );
  end
  input_unit = fopen ( input_filename );
  table = zeros(m,n);
  i = 0;
  while ( i < n )
    line = fgets ( input_unit );
    if ( line == -1 )
      break;
    end
    if ( line(1) == '#' )
    elseif ( s_len_trim ( line ) == 0 )
    else
      [ x, count ] = sscanf ( line, string );
      if ( count == m )
        i = i + 1;
        table(1:m,i) = x(1:m);
      end
    end
  end
  fclose ( input_unit );
  return
end