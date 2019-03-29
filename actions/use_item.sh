#!/bin/bash

choose "Which item" "${loc}/items" "inventory"

if [ -z "${choice}" ]
then
  echo "You can't figure out how to use the ${fail}"
  return
fi

do_action "$(get "items/$choice/action")"
