function row_num = file_row_count ( input_file_name )
  input_unit = fopen ( input_file_name );
  blank_num = 0;
  comment_num = 0;
  row_num = 0;
  record_num = 0;
  while ( 1 )
    line = fgetl ( input_unit );
    if ( line == -1 )
      break;
    end
    record_num = record_num + 1;
    record_length = s_len_trim ( line );
    if ( record_length <= 0 )
      blank_num = blank_num + 1;
    elseif ( line(1) == '#' )
      comment_num = comment_num + 1;
    else
      row_num = row_num + 1;
    end
  end
  fclose ( input_unit );
  return
end