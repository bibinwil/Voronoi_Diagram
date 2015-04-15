function [ tri_num, tri_vert, tri_nabe ] = dtris2 ( point_num, p )
  tri_vert = [];
  tri_nabe = [];
%  Sort the vertices by increasing (x,y).
  indx = r82vec_sort_heap_index_a ( point_num, p );
  p = r82vec_permute ( point_num, p, indx );
  m1 = 1;
  m2 = 2;
  j = 3;
  while ( 1 )
    m = j;
    lr = lrline ( p(1,m), p(2,m), p(1,m1), p(2,m1), p(1,m2), p(2,m2), 0.0 );
    if ( lr ~= 0 )
      break
    end
    j = j + 1;
  end
  tri_num = j - 2;
  if ( lr == -1 )
    tri_vert(1,1) = m1;
    tri_vert(2,1) = m2;
    tri_vert(3,1) = m;
    tri_nabe(3,1) = -3;
    for i = 2 : tri_num
      m1 = m2;
      m2 = i+1;
      tri_vert(1,i) = m1;
      tri_vert(2,i) = m2;
      tri_vert(3,i) = m;
      tri_nabe(1,i-1) = -3 * i;
      tri_nabe(2,i-1) = i;
      tri_nabe(3,i) = i - 1;
    end
    tri_nabe(1,tri_num) = -3 * tri_num - 1;
    tri_nabe(2,tri_num) = -5;
    ledg = 2;
    ltri = tri_num;
  else
    tri_vert(1,1) = m2;
    tri_vert(2,1) = m1;
    tri_vert(3,1) = m;
    tri_nabe(1,1) = -4;
    for i = 2 : tri_num
      m1 = m2;
      m2 = i+1;
      tri_vert(1,i) = m2;
      tri_vert(2,i) = m1;
      tri_vert(3,i) = m;
      tri_nabe(3,i-1) = i;
      tri_nabe(1,i) = -3 * i - 3;
      tri_nabe(2,i) = i - 1;
    end
    tri_nabe(3,tri_num) = -3 * tri_num;
    tri_nabe(2,1) = -3 * tri_num - 2;
    ledg = 2;
    ltri = 1;
  end
  top = 0;
  for i = j+1 : point_num
    m = i;
    m1 = tri_vert(ledg,ltri);
    if ( ledg <= 2 )
      m2 = tri_vert(ledg+1,ltri);
    else
      m2 = tri_vert(1,ltri);
    end
    lr = lrline ( p(1,m), p(2,m), p(1,m1), p(2,m1), p(1,m2), p(2,m2), 0.0 );
    if ( 0 < lr ) 
      rtri = ltri;
      redg = ledg;
      ltri = 0;
    else
      l = -tri_nabe(ledg,ltri);
      rtri = floor ( l / 3 );
      redg = mod(l,3) + 1;
    end
    [ ltri, ledg, rtri, redg ] = vbedg ( p(1,m), p(2,m), point_num, p, ...
      tri_num, tri_vert, tri_nabe, ltri, ledg, rtri, redg );
    n = tri_num + 1;
    l = -tri_nabe(ledg,ltri);
    while ( 1 )
      t = floor ( l / 3 );
      e = mod ( l, 3 ) + 1;
      l = -tri_nabe(e,t);
      m2 = tri_vert(e,t);
      if ( e <= 2 )
        m1 = tri_vert(e+1,t);
      else
        m1 = tri_vert(1,t);
      end
      tri_num = tri_num + 1;
      tri_nabe(e,t) = tri_num;
      tri_vert(1,tri_num) = m1;
      tri_vert(2,tri_num) = m2;
      tri_vert(3,tri_num) = m;
      tri_nabe(1,tri_num) = t;
      tri_nabe(2,tri_num) = tri_num - 1;
      tri_nabe(3,tri_num) = tri_num + 1;
      top = top + 1;
      work(top) = tri_num;
      if ( t == rtri && e == redg )
        break
      end
    end
    tri_nabe(ledg,ltri) = -3 * n - 1;
    tri_nabe(2,n) = -3 * tri_num - 2;
    tri_nabe(3,tri_num) = -l;
    ltri = n;
    ledg = 2;
    [ top, ltri, ledg, tri_vert, tri_nabe ] = swapec ( ...
      m, top, ltri, ledg, point_num, p, tri_num, tri_vert, tri_nabe, work );
  end
  for i = 1 : 3
    for j = 1 : tri_num
      tri_vert(i,j) = indx ( tri_vert(i,j) );
    end
  end
  return
end
