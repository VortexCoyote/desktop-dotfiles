#!/bin/sh

grep -L -E '\bNoDisplay=true' /usr/share/applications/* > $HOME/.cache/copland-desktop-entry-list

get_applications () {
    xargs -d '\n' grep -E -m 1 '\bName=(.*)' < $HOME/.cache/copland-desktop-entry-list | sed s/'.*Name='//
}

selected=$(get_applications | fzf --reverse --no-scrollbar --no-bold --color=bw --pointer='>')

if [ ! -z "${selected}" ];
then
    grep -l "Name=$selected" /usr/share/applications/*
fi

