#!/bin/sh

#cat.sh

#ファイルの連結、表示を行う。

#sh cat.sh [file . . . . . ]

#########################################
ERROR = 0
LINE =
IFS_SV = "$IFS"
IFS =


while [ $# -gt 0 ]
do
	if [ ! -r "$1" ]; then
		echo "Cannot find file $1" 1>&2
		ERROR = 1
	else
		while read LINE
		do
			echo "$LINE"
		done < "$1"
	fi
	shift
done

	IFS = "$IFS_SV"

exit $ERROR

