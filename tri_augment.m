function [ v_inf, nodtri ] = tri_augment ( v_num, nodtri )
  v_inf = 0;
  for v = 1 : v_num
    for i = 1 : 3
      s = nodtri(i,v);
      ip1 = i4_wrap ( i + 1, 1, 3 );
      t = nodtri(ip1,v);
      found = 0;
      for v2 = 1 : v_num
        for i2 = 1 : 3
          s2 = nodtri(i2,v2);
          ip1 = i4_wrap ( i2 + 1, 1, 3 );
          t2 = nodtri(ip1,v2);
          if ( s == t2 && t == s2 )
            found = 1;
            break
          end
        end
        if ( found )
          break
        end
      end
      if ( ~found )
        v_inf = v_inf + 1;
        nodtri(1:3,v_num+v_inf) = [ -v_inf; t; s ];
      end
    end
  end
  return
end