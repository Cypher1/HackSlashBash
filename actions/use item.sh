#!/bin/bash

choose "Which item" "${loc}/items" "inventory"

if [ -z "${choice}" ]
then
  echo "You can't figure out how to use the ${fail}"
  return
fi

item="$choice"
do_action "$(get "items/$item/action")"
item=""
