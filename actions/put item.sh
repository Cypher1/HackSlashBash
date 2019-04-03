#!/bin/bash

function put() {
  echo "$1" | add "${loc}/items"
  echo "$1" | remove "inventory"
  echo "You put the $1 down."
}

choose "Which item" "inventory"

if [ -z "$choice" ]
then
  echo "You can't figure out how to put the ${fail} down."
  return
fi

put "$choice"
