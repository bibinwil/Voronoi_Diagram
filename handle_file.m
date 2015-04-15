function [ g_num, g_xy, g_degree, g_start, g_face, v_num, v_xy, i_num, i_xy ] = handle_file ( filename )
   [ m, g_num ] = r8mat_header_read ( filename );
   g_xy = r8mat_data_read ( filename, m, g_num );
  [ g_degree, g_start, g_face, v_num, v_xy, i_num, i_xy ] = voronoi_data ( g_num, g_xy );
  return
end