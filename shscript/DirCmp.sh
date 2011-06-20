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
