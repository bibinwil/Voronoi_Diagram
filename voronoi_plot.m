function voronoi_plot ( filename, g_num, g_xy, g_degree, g_start, g_face,v_num, v_xy, ~, i_xy )
  talky = 0;
  if ( talky )
  else
    clf
    hold on
    for g = 1 : g_num
      g1 = g_start(g);
      for k = 1 : g_degree(g)
       if ( k < g_degree(g) )
          g2 = g1 + 1;
        else
          g2 = g_start(g);
       end
        if ( g_face(g1) < 0 && g_face(g2) < 0 )
        elseif ( g_face(g1) < 0 )
          i1 = - g_face(g1) - v_num;
          i2 = g_face(g2);
          temp_x = [ v_xy(1,i2) + 0.5 * i_xy(1,i1), v_xy(1,i2) ];
          temp_y = [ v_xy(2,i2) + 0.5 * i_xy(2,i1), v_xy(2,i2) ];
          line ( 'Xdata', temp_x, 'Ydata', temp_y, 'Color', 'b' );
        elseif ( g_face(g2) < 0 )
          i1 = g_face(g1);
          i2 = - g_face(g2) - v_num;
          temp_x = [ v_xy(1,i1), v_xy(1,i1) + 0.5 * i_xy(1,i2) ];
          temp_y = [ v_xy(2,i1), v_xy(2,i1) + 0.5 * i_xy(2,i2) ];
          line ( 'Xdata', temp_x, 'Ydata', temp_y, 'Color', 'b' );
        else
          i1 = g_face(g1);
          i2 = g_face(g2);
          p = [ i1, i2 ];
          line ( 'Xdata', v_xy(1,p), 'Ydata', v_xy(2,p), 'Color', 'r' );
        end
        g1 = g1 + 1;
      end
    end

    scatter ( v_xy(1,:), v_xy(2,:), 'r', 'filled' )
    scatter ( g_xy(1,:), g_xy(2,:), 'k', 'filled' );

    grid on
    axis equal
    title ( filename )
    hold off
  end
  return
end