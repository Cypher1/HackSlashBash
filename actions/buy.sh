#!/bin/bash

function buy() {
  # TODO wallet?
  echo "$1" | add "inventory"
  echo "$1" | remove "${loc}/items"
  echo "You took the $1."
}

choose "What can I sell you" "${loc}/items"

if [ -z "$choice" ]
then
  echo "Sorry, I don't have any ${fail} at the moment."
  return
fi

buy "$choice"
