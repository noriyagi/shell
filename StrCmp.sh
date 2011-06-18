#!/bin/sh
#
#File: StrCmp.sh
#
StrCmp(){
#
#文字列を比較する
#
#StrCmp string1 string2
#
#等しければ０
#左が小さければ−１
#左が大きければ１
#
if [ $# -ne 2 ] ; then
	echo "Usage: StrCmp string1 string2" 1>&2
	exit 1
fi

if [ "$1" = "$2" ] ; then
	echo "0"
else
	_TMP=`{ echo "$1"; echo "$2"; } | sort | sed -n '1p'`

	if [ "$_TEMP" = "$1" ]; then
		echo "-1"
	else
		echo "1"
	fi
fi
}

