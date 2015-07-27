#!/bin/bash
awk '
    BEGIN{i=0} {
        sum[i]=$2+$3+$4+$5;
        idle[i++]=$5
    }
    END {
        printf "%3d\n", 100*( (sum[1]-sum[0]) - (idle[1]-idle[0]) ) / (sum[1]-sum[0])
    }
' <( head -n 1 /proc/stat; sleep 0.5; head -n 1 /proc/stat)
