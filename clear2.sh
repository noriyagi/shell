#!/bin/sh
{ clear; } 2> /dev/null ||
{ tput clear; } 2> /dev/null ||
for i in 1 2 3 4 5 6 7 8 9 10 \
         1 2 3 4 5 6 7 8 9 20 \
         1 2 3 4 5 6 7 8 9 30 \
         1 2 3 4 5 6 7 8 9 40 \
do
    echo
done

