#!/bin/bash

function put() {
  mkdir -p "$(dirname "saves/${name}/$1")"
  cat > "saves/${name}/$1"
}

function get() {
  saved="saves/${name}/$1"
  map="world/$1"
  
  if [ -f "$saved" ]
  then
    cat $saved
    return
  fi
  if [ -f "$map" ]
  then
      cat $map
    return
  fi
}

function save() {
  echo "${name}" > saves/.last
  echo "${loc}" | put "loc" 
}

function enter_room() {
  echo "----- ${loc} -----"
  get "$loc/description"
  echo "Items:"
  get "$loc/items"
  echo "Actions:"
  get "$loc/actions"

  echo -n "? "
  read action
  if get "$loc/actions" | grep action 
  then
    echo "You ${action} really hard!"
  else
    echo "You try to ${action}, but it doesnt seem to work."
    action = ""
  fi
}

function init() {
  mkdir -p saves
  touch saves/.last
  name="$(cat saves/.last)"
  if  echo "" | grep name
  then
    echo "Hi ${name}"
  else
    echo "What's your name, kid?"
    read name
  fi
  
  echo "Loading game..."
  loc="$(get "loc")"
  save name
}

init
enter_room
