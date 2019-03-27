#!/bin/bash

function indent() {
  cat | sed "s/^/  /"
}

function put() {
  mkdir -p "$(dirname "saves/${name}/$1")"
  cat > "saves/${name}/$1"
}

function add() {
  mkdir -p "$(dirname "saves/${name}/$1")"
  get "$1" | put "$1"
  cat >> "saves/${name}/$1"
}

function get() {
  saved="saves/${name}/$1"
  if [ -f "$saved" ]
  then
    cat $saved
    return
  fi
  map="world/$1"
  if [ -f "$map" ]
  then
    cat $map
    return
  fi
}

function init() {
  mkdir -p "saves"
  touch "saves/.last"
  name="$(cat "saves/.last")"
  if echo "" | grep "^${name}$"
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

function choice() {
  echo "$1?"
  get "$2" > .tmp
  get "$3" >> .tmp
  cat .tmp | sort | uniq > .tmp_ops
  cat .tmp_ops | indent
  echo -n "? "
  read choice
  if grep "^${choice}$" .tmp_ops
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
 
  choice "What's next" "${loc}/actions" "actions" 
  action="${choice}"
  if [ -z "$action" ]
  then
    echo "You try to ${action}, but it doesnt seem to work."
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
