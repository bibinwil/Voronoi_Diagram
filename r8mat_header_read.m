function [ m, n ] = r8mat_header_read ( input_filename )
  m = file_column_count ( input_filename );
  n = file_row_count ( input_filename );
  return
end