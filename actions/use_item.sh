#!/bin/bash

action=""

function use() {
  do_action "$(cat "items/$item/action")"
}

choice "Which item" "${loc}/items" "inventory"
item="${choice}"

if get "${loc}/items" | grep "^$item$"
then
  use "$item"
  return
fi

if get "inventory" | grep "$item"
then
  use "$item"
  return
fi

echo "You can't figure out how to use the ${item}"
