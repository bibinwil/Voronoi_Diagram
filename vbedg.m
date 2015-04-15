function [ ltri, ledg, rtri, redg ] = vbedg ( x, y, ~, p, ~, ...
  tri_vert, tri_nabe, ltri, ledg, rtri, redg )
  if ( ltri == 0 )
    ldone = 0;
    ltri = rtri;
    ledg = redg;
  else
    ldone = 1;
  end
  while ( 1 )
    l = -tri_nabe(redg,rtri);
    t = floor ( l / 3 );
    e = mod ( l, 3 ) + 1;
    a = tri_vert(e,t);
    if ( e <= 2 )
      b = tri_vert(e+1,t);
    else
      b = tri_vert(1,t);
    end
    lr = lrline ( x, y, p(1,a), p(2,a), p(1,b), p(2,b), 0.0 );
    if ( lr <= 0 )
      break;
    end
    rtri = t;
    redg = e;
  end
  if ( ldone )
    return
  end
  t = ltri;
  e = ledg;
  while ( 1 )
    b = tri_vert(e,t);
    e = i4_wrap ( e-1, 1, 3 );
    while ( 0 < tri_nabe(e,t) )
      t = tri_nabe(e,t);
      if ( tri_vert(1,t) == b )
        e = 3;
      elseif ( tri_vert(2,t) == b )
        e = 1;
      else
        e = 2;
      end
    end
    a = tri_vert(e,t);
    lr = lrline ( x, y, p(1,a), p(2,a), p(1,b), p(2,b), 0.0 );
    if ( lr <= 0 )
      break
    end
  end
  ltri = t;
  ledg = e;
  return
end