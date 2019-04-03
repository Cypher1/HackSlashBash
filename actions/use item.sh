#!/bin/bash

choose "Which item" "inventory"

if [ -z "${choice}" ]
then
  if [ -z "${fail}" ]
  then
    return
  fi
  echo "You can't figure out how to use the ${fail}"
  return
fi

item="$choice"
do_action "$(get "items/$item/action")"
item=""
