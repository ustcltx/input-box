#!/bin/sh
mypath=$(cd "$(dirname "$0")"; pwd)
pidpath=$mypath/pid

txtpath=$mypath/test.txt

[ ! -f $txtpath ] && touch $txtpath

if [ -f $pidpath ] && mypid=`cat $pidpath` && ps -p $mypid > /dev/null
then
        
	GEDWINID=`xdotool search --pid $mypid 2>&1 | tail -1` && xdotool windowactivate --sync $GEDWINID key --clearmodifiers --delay 100 ctrl+s
	kill $mypid
        rm $pidpath
	cat $txtpath | perl -pe 'chomp if eof' | xclip -selection c
	exit
fi

echo > $txtpath
gedit --geometry 200x200-0-0 -s $txtpath &
echo "$!"  > $pidpath
exit

