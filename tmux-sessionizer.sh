#! /usr/bin/bash

function main () {
    path=$(select_dir)

    name=$(basename "$path")

    if [[ $path =~ /branches/${name}$ ]]; then
        name=$(append_root $name $path)
    fi


    name=${name/./_}

    if [[ `has_duplicated_name $name` -eq 0 ]]; then
        echo "new session"
        tmux new-session -ds "$name" -c "$path"
    fi

    tmux switch-client -t "$name"
    exit 0
}

function has_duplicated_name () {
    if [[ -z `tmux ls | grep "^$1:\s"` ]]; then
        echo 0;
    else
        echo 1;
    fi
}

function append_root () {
    local name=$1;
    local path=$2;
    local project_root=$(basename "${path%\/branches\/$name}")
    echo $project_root/$name
}

function select_dir () {
    echo $(find ~/projects ~/work -mindepth 1 -maxdepth 3 -type d | fzf)
}

main;
