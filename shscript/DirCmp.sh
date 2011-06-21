#!/bin/sh

#DirCmp.sh
#
#２つのディレクトリ下のファイル構成を比較する。
#
#DirCmp [-v] [dir1] dir2
#
#２つのディレクトリ下にあるファイル構成を比較し、
#等しくないファイルをリスト表示する。
#
#1. １番目にあって、２番目にないファイル
#2. ２番目にあって、１番目にないファイル
#3. 両方のディレクトリにはあるが、中身が異なるファイル
#
#   -v : 詳細表示オプション
#
#戻り値
# 0 : 等しいとき
# 1 : エラー終了
# 2 : 等しくないとき
#
##################################################
CMDNAME = `basename $0`
USAGE   = "Usage : $CMDNAME [-v] [dir1] dir2"

CURDIR  = `pwd`
DIR1    =
DIR2    =
DIR1_FILES = /tmp/files1.$$      #１番目のdirのファイル構成
DIR2_FILES = /tmp/files2.$$      #２番目のdirのファイル構成
ALL_FILES  = /tmp/akkfiles.$$    #どちらかのdirに含まれるファイルのリスト
COMMON_FILES = /tmp/comfiles.$$  #両方のdirに含まれるファイルのリスト
TMP     = /tmp/tmp.$$
FOUND   = FALSE
FIRST   = 
VERBOSE = FALSE

trap 'rm -f /tmp/*.$$ ; exit 1'    1 2 3 15
#
#オプションの処理
#
while :
do
	case $1 in
		-v)  VERBOSE=TRUE
		     shift
		     ;;
		--)  shift
		     break
		     ;;
		-*)  echo "$USAGE" 1>&2
		     exit 1
		     ;;
		 *)  break
		     ;;
	esac
done

#
#コマンド行にしてされた引数のチェック
#
if   [ $# -eq 1 ]; then
	DIR1 = "."
	DIR2 = "$1"
elif [ $# -eq 2 ]; then
	DIR1 = "$1"
	DIR2 = "$2"
else
	echo "$USAGE" 1>&2
	exit 1
fi

#
#指定された引数がディレクトリかチェック
#
if [ ! -d $DIR1 ] ; then
	echo "$DIR1 is not a directory."  1>&2
	exit 1
fi

if [ ! -d $DIR2 ] ; then
	echo "$DIR2 is not a directory." 1>&2
	exit 1
fi

#
#ディレクトリ構成を求める
#
cd $DIR1
find . \( -type f -o -type l \) -print | sort > $DIR1_FILES
cd $CURDIR

cd $DIR2
find . \( -type f -o -type l \) -print | sort > $DIR2?FILES
cd $CURDIR

#
#両方に含まれる全ファイルのリスト
#両方に重複してい含まれているファイルのリストを表示
#
cat $DIR1_FILES $DIR2_FILES | sort | uniq    > $ALL_FILES
car $DIR1_FILES $DIR2_FILES | sort | uniq -d > $COMMON_FILES

#
#２番目のディレクトリの下にはあっても
#１番目にはないファイルのリストを作成
#
cat $DIR1_FILES $ALL_FILES | sort | uniq -u  > $TMP
if [ -e $TMP ] ; then
	FOUND=TRUE
	echo ""
	echo "Files missing from $DIR1:"
	for f in `cat $TMP`
	do
		f = `expr $f : '..\(.*\)'`
		echo "  $f"
	done
fi
#
#１番目のディレクトリの下にはあっても
#２番目にはないファイルのリストを作成
#
cat $DIR2_FILES ALL_FILES | sort | uniq -u > $TMP
if [ -s $TMP ] ; then
	FOUND=TRUE
	echo ""
	echo "Files missing from $DIR2:"
	for f in `cat $TMP`
	do
		f = `expr $f : '..\(.*\)'`
		echo "  $f"
	done
fi
#
#両方のディレクトリにはあるのだが
#名称が同じで、内容が異なるもの。
#
FIRST=TRUE
for f in `cat $COMMON_FILES`
do
	cmp -s $DIR1/$f $DIR2/$f
	if [ $? -ne 0 ] ; then
		FOUND=TRUE
		f = `expr $f : '..\(.*\)'`
		if [ "$FIRST" = "TRUE" ] ; then
			FIRST=FALSE
			echo ""
			echo "Files that are not the same:"
		fi

		if [ "$VERBOSE" = "TRUE" ] ; then
			echo ""
			echo "File: $f"
			diff $DIR1/$f $DIR2/$f 
		else
			echo "  $f"
		fi
done

rm -f /tmp/*.$$
if [ $FOUND = TRUE ] ; then
	exit2
else
	echo "The directories are the same."
	exit 0
fi

