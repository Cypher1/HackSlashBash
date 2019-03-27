#!/bin/bash

function indent() {
  cat | sed "s/^/  /"
}

function put() {
  mkdir -p "$(dirname "saves/${name}/$1")"
  cat > "saves/${name}/$1"
}

function remove() {
  remove=cat
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
    echo "What's your name, kid?"
    read name
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
    echo "That doesn't seem possible."
    echo "${act}"
  fi
}

function choose() {
  echo "$1?"
  get "$2" > ".tmp"
  get "$3" >> ".tmp"
  cat ".tmp" | sort | uniq | indent
  echo -n "? "
  read choice
  if grep "^${choice}$" ".tmp" > /dev/null
  then
    return
  else
    choice=""
  fi
}

function start_room() {
  echo "----- ${loc} -----"
  get "$loc/description" | indent
  echo "Items:"
  get "$loc/items" | indent
  choose "What's next" "${loc}/actions" "actions" 
  action="$choice"
  if [ -z "$action" ]
  then
    echo "Oh no, that won't work."
  else
    do_action "$action"
    return
  fi
}

function game() {
  start_room
  game
}

init
game
