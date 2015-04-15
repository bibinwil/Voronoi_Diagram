function value = lrline ( xu, yu, xv1, yv1, xv2, yv2, dv )
  tol = 100.0 * eps;
  dx = xv2 - xv1;
  dy = yv2 - yv1;
  dxu = xu - xv1;
  dyu = yu - yv1;
  tolabs = tol * max ( abs ( dx ), ...
                 max ( abs ( dy ), ...
                 max ( abs ( dxu ), ...
                 max ( abs ( dyu ), abs ( dv ) ) ) ) );
  t = dy * dxu - dx * dyu + dv * sqrt ( dx * dx + dy * dy );
  if ( tolabs < t )
    value = 1;
  elseif ( -tolabs <= t )
    value = 0;
  else
    value = -1;
  end
  return
end