function word_num = s_word_count ( s )
  FALSE = 0;
  TRUE = 1;
  word_num = 0;
  s_length = length ( s );
  if ( s_length <= 0 )
    return;
  end
  blank = TRUE;
  for i = 1 : s_length
    if ( s(i) == ' ' )
      blank = TRUE;
    elseif ( blank == TRUE )
      word_num = word_num + 1;
      blank = FALSE;
    end
  end
  return
end