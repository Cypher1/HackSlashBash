#!/bin/bash

source "util.sh"

function put() {
  mkdir -p "$(dirname "saves/${name}/$1")"
  cat > "saves/${name}/$1"
}

function remove() {
  remove="$(cat)"
  get "$1" | grep -v "^${remove}$" | put "$1"
}

function add() {
  get "$1" | put "$1"
  cat >> "saves/${name}/$1"
}

function get() {
  saved="saves/${name}/$1"
  got=""
  if [ -f "$saved" ]
  then
    got="$saved"
  else
    map="world/$1"
    if [ -f "$map" ]
    then
      got="$map"
    fi
  fi
  if [ -f "$got" ]
  then
    cp "$got" ".tmp"
    cat ".tmp"
  fi
}

function init() {
  mkdir -p "saves"
  touch "saves/.last"
  name="$(cat "saves/.last")"
  if [ -z "${name}" ]
  then
    choose_raw "What's your name, kid" "$(ls saves)"
    if [ -z "${choice}" ]
    then
      name="$fail"
    else
      name="$choice"
    fi
  else
    echo "Hi ${name}"
  fi
  loc="$(get "loc")"
  echo "${name}" > saves/.last
}

function do_action() {
  act="actions/$1.sh"
  if [ -f "${act}" ]
  then
    source "${act}"
  else
    echo "You try to ${fail}, but it doesn't work."
  fi
}

function choose() {
  get "$2" > ".tmp_choice"
  get "$3" >> ".tmp_choice"
  ops="$(cat ".tmp_choice" | sort | uniq)"
  choose_raw "$1" "$ops"
}

function game() {
  echo "----- ${loc} -----"
  get "$loc/description" | indent
  echo "Items:"
  get "$loc/items" | indent
  choose "What's next" "${loc}/actions" "actions"
  if [ -z "$choice" ]
  then
    if echo "$fail" | grep "^quit$"
    then
      exit
    fi
    if echo "$fail" | grep "^load$"
    then
      rm "saves/.last"
      init
      return
    fi
    echo "You try to ${fail} but it doesn't seem possible."
  else
    do_action "$choice"
    return
  fi
  do_action "$action"
}

init
while true
do
  game
done
