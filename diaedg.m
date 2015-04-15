function value = diaedg ( x0, y0, x1, y1, x2, y2, x3, y3 )
  tol = 100.0 * eps;
  dx10 = x1 - x0;
  dy10 = y1 - y0;
  dx12 = x1 - x2;
  dy12 = y1 - y2;
  dx30 = x3 - x0;
  dy30 = y3 - y0;
  dx32 = x3 - x2;
  dy32 = y3 - y2;
  tola = tol * max ( abs ( dx10 ), ...
               max ( abs ( dy10 ), ...
               max ( abs ( dx30 ), abs ( dy30 ) )));
  tolb = tol * max ( abs ( dx12 ), ...
               max ( abs ( dy12 ), ...
               max ( abs ( dx32 ), abs ( dy32 ) )));
  ca = dx10 * dx30 + dy10 * dy30;
  cb = dx12 * dx32 + dy12 * dy32;
  if ( tola < ca && tolb < cb )
    value = -1;
  elseif ( ca < -tola && cb < -tolb )
    value = 1;
  else
    tola = max ( tola, tolb );
    s = ( dx10 * dy30 - dx30 * dy10 ) * cb ...
      + ( dx32 * dy12 - dx12 * dy32 ) * ca;
    if ( tola < s )
      value = -1;
    elseif ( s < -tola )
      value = 1;
    else
      value = 0;
    end
  end
  return
end