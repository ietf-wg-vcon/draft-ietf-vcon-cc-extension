#!/bin/sh

awk 'BEGIN {max = 65}
    { 
      len = length($0); 
      if(len <= max) print $0;
      else 
      {
        match($0, /^ */);
        #print(RLENGTH " spaces")
        pref = RLENGTH + 2
        start = 1; 
        prefix = 0; 
        while(start <= len) 
        {
          # print(start, trunk);
          line_len = max - prefix
          printf("%*s%s\n", prefix, "", substr($0, start, line_len))
          #print(prefix substr($0, start, line_len));
          start = start + line_len;
          prefix = pref
        }
      }
    }'

