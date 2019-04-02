#!/bin/bash

source "util.sh"

function create() {
  touch "$1"
  vim "$1"
}

choose_raw "Make inside" "$(ls -d world/**/ )"

in="$choice"
if [ -z "$choice" ]
then
  in="$choice"
  "$0" "$in"
fi
root="$in$1"
mkdir -p "$root"
create "$root/description"
create "$root/items"
create "$root/actions"
if grep "walk" "$root/actions"
then
  create "$root/walk"
fi
