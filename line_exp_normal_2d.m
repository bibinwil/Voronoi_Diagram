function normal = line_exp_normal_2d ( p1, p2 )
  dim_num = 2;
  norm = sqrt ( ( p2(1) - p1(1) ).^2 + ( p2(2) - p1(2) ).^2 );
  if ( norm == 0.0 )
    normal(1:dim_num) = sqrt ( 2.0 );
    return
  end
  normal(1) =   ( p2(2) - p1(2) ) / norm;
  normal(2) = - ( p2(1) - p1(1) ) / norm;
  return
end
