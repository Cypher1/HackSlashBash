#!/bin/bash

function take() {
  echo "$1" | add "inventory"
  echo "$1" | remove "${loc}/items"
  echo "You took the $1."
}

choose "Which item" "${loc}/items"

if [ -z "${choice}" ]
then
  if [ -z "${fail}" ]
  then
    return
  fi
  echo "You can't figure out how to take the ${fail}."
  return
fi

take "$choice"
