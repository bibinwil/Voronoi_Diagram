function [ g_degree, g_start, g_face, v_num, v_xy, i_num, i_xy ] = voronoi_data ( g_num, g_xy )

%  Compute the Delaunay triangulation.
  [ v_num, nodtri, tnbr  ] = dtris2 ( g_num, g_xy );
  [ v_inf, nodtri ] = tri_augment ( v_num, nodtri );
  i_num = 0;
  for v = 1 : v_num
    for i = 1 : 3
      if ( tnbr(i,v) < 0 )
        i_num = i_num + 1;
        tnbr(i,v) = - i_num;
      end
    end
  end
  g_degree(1:g_num) = 0;
  for j = 1 : v_num + v_inf
    for i = 1 : 3
      k = nodtri(i,j);
      if ( 0 < k )
        g_degree(k) = g_degree(k) + 1;
      end
    end
  end
  for v = 1 : v_num
    i1 = nodtri(1,v);
    i2 = nodtri(2,v);
    i3 = nodtri(3,v);
    t(1:2,1) = g_xy(1:2,i1);
    t(1:2,2) = g_xy(1:2,i2);
    t(1:2,3) = g_xy(1:2,i3);
    v_xy(1:2,v) = triangle_circumcenter_2d ( t );
  end
  count = 0;
  g_start(1:g_num) = 0;
  for g = 1 : g_num
    v_next = 0;
    for v = 1 : v_num + v_inf
      for s = 1 : 3
        if ( nodtri(s,v) == g )
          v_next = v;
          s_next = s;
          break
        end
      end
      if ( v_next ~= 0 )
        break
      end
    end
    v_save = v_next;
    while ( 1 )
      s_next = i4_wrap ( s_next + 1, 1, 3 );
      g_next = nodtri(s_next,v_next);
      if ( g_next == g )
        s_next = i4_wrap ( s_next + 1, 1, 3 );
        g_next = nodtri(s_next,v_next);
      end
      v_old = v_next;
      v_next = 0;
      for v = 1 : v_num + v_inf
        if ( v == v_old )
          continue
        end
        for s = 1 : 3
          if ( nodtri(s,v) == g )
            sp1 = i4_wrap ( s + 1, 1, 3 );
            if ( nodtri(sp1,v) == g_next )
              v_next = v;
              s_next = sp1;
              break
            end
            sp1 = i4_wrap ( s + 2, 1, 3 );
            if ( nodtri(sp1,v) == g_next )
              v_next = v;
              s_next = sp1;
              break
            end
          end
        end
        if ( v_next ~= 0 )
          break
        end
      end
      if ( v_next == v_save )
        break
      end
      if ( v_next == 0 )
        v_next = v_old;
        break
      end
    end
    v_save = v_next;
    count = count + 1;
    g_start(g) = count;
    g_face(count) = v_next;
    while ( 1 )
      s_next = i4_wrap ( s_next + 1, 1, 3 );
      g_next = nodtri(s_next,v_next);
      if ( g_next == g )
        s_next = i4_wrap ( s_next + 1, 1, 3 );
        g_next = nodtri(s_next,v_next);
      end
      v_old = v_next;
      v_next = 0;
      for v = 1 : v_num + v_inf
        if ( v == v_old )
          continue
        end
        for s = 1 : 3
          if ( nodtri(s,v) == g )
            sp1 = i4_wrap ( s + 1, 1, 3 );
            if ( nodtri(sp1,v) == g_next )
              v_next = v;
              s_next = sp1;
              break
            end
            sp1 = i4_wrap ( s + 2, 1, 3 );
            if ( nodtri(sp1,v) == g_next )
              v_next = v;
              s_next = sp1;
              break
            end
          end
        end
        if ( v_next ~= 0 )
          break
        end
      end
      if ( v_next == v_save )
        break
      end
      if ( v_next == 0 )
        break
      end
      count = count + 1;
      g_face(count) = v_next;
    end
  end
  for i = 1 : count
    if ( v_num < g_face(i) )
      g_face(i) = - g_face(i);
    end
  end
  for i = 1 : v_num
    for j = 1 : 3
      k = tnbr(j,i);
      if ( k < 0 )
        ix1 = nodtri(j,i);
        jp1 = i4_wrap ( j+1, 1, 3 );
        ix2 = nodtri(jp1,i);
        i_xy(1:2,-k) = line_exp_normal_2d ( g_xy(1:2,ix1), g_xy(1:2,ix2) );
      end
    end
  end
  return
end