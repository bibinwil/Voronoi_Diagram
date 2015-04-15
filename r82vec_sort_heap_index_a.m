function indx = r82vec_sort_heap_index_a ( n, a )
  if ( n < 1 )
    return
  end
  if ( n == 1 )
    indx(1) = 1;
    return
  end
  indx = i4vec_indicator ( n );
  l = floor ( n / 2 ) + 1;
  ir = n;
  while ( 1 )
    if ( 1 < l )
      l = l - 1;
      indxt = indx(l);
      aval(1:2) = a(1:2,indxt);
    else
      indxt = indx(ir);
      aval(1:2) = a(1:2,indxt);
      indx(ir) = indx(1);
      ir = ir - 1;
      if ( ir == 1 )
        indx(1) = indxt;
        break
      end
    end
    i = l;
    j = l + l;
    while ( j <= ir )
      if ( j < ir )
        if (   a(1,indx(j)) <  a(1,indx(j+1)) || ...
             ( a(1,indx(j)) == a(1,indx(j+1)) && ...
               a(2,indx(j)) <  a(2,indx(j+1)) ) )
          j = j + 1;
        end
      end
      if (   aval(1) <  a(1,indx(j)) || ...
           ( aval(1) == a(1,indx(j)) && ...
             aval(2) <  a(2,indx(j)) ) )
        indx(i) = indx(j);
        i = j;
        j = j + j;
      else
        j = ir + 1;
      end
    end
    indx(i) = indxt;
  end
  return
end
