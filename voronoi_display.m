 function voronoi_display ( filename )
  [ g_num, g_xy, g_degree, g_start, g_face, v_num, v_xy, i_num, i_xy ] = handle_file ( filename );
  voronoi_plot ( filename, g_num, g_xy, g_degree, g_start, g_face, v_num, v_xy, i_num, i_xy );
  return
 end