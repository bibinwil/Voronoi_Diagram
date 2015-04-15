function a = r82vec_permute ( n, a, p )
  for istart = 1 : n
    if ( p(istart) < 0 )
      continue
    elseif ( p(istart) == istart )
      p(istart) = - p(istart);
      continue
    else
      a_temp(1:2) = a(1:2,istart);
      iget = istart;
      while ( 1 )
        iput = iget;
        iget = p(iget);
        p(iput) = - p(iput);
        if ( iget == istart )
          a(1:2,iput) = a_temp(1:2)';
          break
        end
        a(1:2,iput) = a(1:2,iget);
      end
    end
  end
  return
end