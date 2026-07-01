#!/bin/bash

# CREDITS TO: https://github.com/avagordon01/cursor-converter/blob/master/convert.sh

rm -r outputs
mkdir -p outputs
cd outputs || exit

for name in ../inputs/*.ani; do
  name=$(basename "$name" .ani)
  mkdir -p "$name"
  cd "$name" || exit
  cp ../../inputs/$name.ani .
  ../../ani2ico/ani2ico $name.ani
  rm $name.ani
  for f in $name*.ico; do
    filename=$(basename "$f")
    png="${filename%.*}".png
    convert "$f" "$png"
    identify -format '%w 1 1 %f 200\n' "$png" >> $name.xcg
  done
  xcursorgen $name.xcg $name
  cd .. || exit
done

for name in ../inputs/*.cur; do
  name=$(basename "$name" .cur)
  mkdir -p "$name"
  cd "$name" || exit
  cp ../../inputs/$name.cur .
  convert $name.cur $name.png
  identify -format '%w 1 1 %f\n' $name.png >> $name.xcg
  xcursorgen $name.xcg $name
  cd .. || exit
done

cd .. || exit
