#!/bin/bash

item=""

function take() {
  echo "${item}" | add "inventory"
  echo "${item}" | remove "${loc}/items"
  echo "You took the ${item}."
}

choose "Which item" "${loc}/items"
item="${choice}"

if get "${loc}/items" | grep "^$item$" > /dev/null
then
  take "$item"
  return
fi

echo "You can't figure out how to take the ${item}"
