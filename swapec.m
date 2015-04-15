function [ top, btri, bedg, tri_vert, tri_nabe ] = swapec (i, top, btri, bedg, ~, p, ~, tri_vert, tri_nabe, work )
  x = p(1,i);
  y = p(2,i);
  while ( 1 )
    if ( top <= 0 )
      break
    end
    t = work(top);
    top = top - 1;
    if ( tri_vert(1,t) == i )
      e = 2;
      b = tri_vert(3,t);
    elseif ( tri_vert(2,t) == i )
      e = 3;
      b = tri_vert(1,t);
    else
      e = 1;
      b = tri_vert(2,t);
    end
    a = tri_vert(e,t);
    u = tri_nabe(e,t);
    if ( tri_nabe(1,u) == t )
      f = 1;
      c = tri_vert(3,u);
    elseif ( tri_nabe(2,u) == t )
      f = 2;
      c = tri_vert(1,u);
    else
      f = 3;
      c = tri_vert(2,u);
    end
    swap = diaedg ( x, y, p(1,a), p(2,a), p(1,c), p(2,c), p(1,b), p(2,b) );
    if ( swap == 1 )
      em1 = i4_wrap ( e - 1, 1, 3 );
      ep1 = i4_wrap ( e + 1, 1, 3 );
      fm1 = i4_wrap ( f - 1, 1, 3 );
      fp1 = i4_wrap ( f + 1, 1, 3 );
      tri_vert(ep1,t) = c;
      tri_vert(fp1,u) = i;
      r = tri_nabe(ep1,t);
      s = tri_nabe(fp1,u);
      tri_nabe(ep1,t) = u;
      tri_nabe(fp1,u) = t;
      tri_nabe(e,t) = s;
      tri_nabe(f,u) = r;
      if ( 0 < tri_nabe(fm1,u) )
        top = top + 1;
        work(top) = u;
      end
      if ( 0 < s )
        if ( tri_nabe(1,s) == u )
          tri_nabe(1,s) = t;
        elseif ( tri_nabe(2,s) == u )
          tri_nabe(2,s) = t;
        else
          tri_nabe(3,s) = t;
        end
        top = top + 1;
        work(top) = t;
      else
        if ( u == btri && fp1 == bedg )
          btri = t;
          bedg = e;
        end
        l = - ( 3 * t + e - 1 );
        tt = t;
        ee = em1;
        while ( 0 < tri_nabe(ee,tt) )
          tt = tri_nabe(ee,tt);
          if ( tri_vert(1,tt) == a )
            ee = 3;
          elseif ( tri_vert(2,tt) == a )
            ee = 1;
          else
            ee = 2;
          end
        end
        tri_nabe(ee,tt) = l;
      end
      if ( 0 < r )
        if ( tri_nabe(1,r) == t )
          tri_nabe(1,r) = u;
        elseif ( tri_nabe(2,r) == t )
          tri_nabe(2,r) = u;
        else
          tri_nabe(3,r) = u;
        end
      else
        if ( t == btri && ep1 == bedg )
          btri = u;
          bedg = f;
        end
        l = - ( 3 * u + f - 1 );
        tt = u;
        ee = fm1;
        while ( 0 < tri_nabe(ee,tt) )
          tt = tri_nabe(ee,tt);
          if ( tri_vert(1,tt) == b )
            ee = 3;
          elseif ( tri_vert(2,tt) == b )
            ee = 1;
          else
            ee = 2;
          end
        end
        tri_nabe(ee,tt) = l;
      end
    end
  end
  return
end