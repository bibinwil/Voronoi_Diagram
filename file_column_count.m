function column_num = file_column_count ( input_file_name )
  input_unit = fopen ( input_file_name );
  while ( 1 )
    line = fgetl ( input_unit );
    if ( line == -1 )
      break;
    end
    if ( s_len_trim ( line ) == 0 )
    elseif ( line(1) == '#' )
    else
      break;
    end
  end
  fclose ( input_unit );
  column_num = s_word_count ( line );
  return
end