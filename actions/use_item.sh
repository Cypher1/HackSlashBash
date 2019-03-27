#!/bin/bash

action=""

function use() {
  do_action "$(cat "items/$item/action")"
}

if echo "" | grep "^${item}$"
then
  echo "Which item?"
  get "${loc}/items" | indent
  get "inventory" | indent
  echo -n "? "
  read item
fi

if get "${loc}/items" | grep "^${action}$"
then
  use "$item"
  return
fi

if get "inventory" | grep "$item"
then
  use "$item"
  return
fi

echo "You can't figure out how to use ${item}"
