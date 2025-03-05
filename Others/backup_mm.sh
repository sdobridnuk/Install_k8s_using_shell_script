#!/bin/sh
day=$(date +"%Y%m%d-%H%M")
curr_dir=${PWD##*/}
bak_dir="../_backup/"
tar="$bak_dir$curr_dir-$day.tar"
curr_dir="../$curr_dir"
echo "tar : $tar"
echo "from : $curr_dir"
echo "to : $bak_dir"
mkdir -p $bak_dir
#mkdir -p $bak_dir/public_html
#cmd= "$curr_dir $bak_dir /e /w:0 /r:0 "
#echo $cmd 
tar cvf $tar --exclude=.mp3 --exclude=.mp4 --exclude=.jpg --exclude=.png --exclude=.git --exclude=media --exclude=vendor --exclude=bc --exclude=node_modules --exclude=debugbar --exclude=storage $curr_dir/* 
#cd $bak_dir
#tar xvf backup.tar
#a