#!/bin/bash

choose "What at" "${loc}/items" "inventory"

if [ -z "${choice}" ]
then
  echo "You can't seem to find the ${fail}."
  return
fi

echo "You see $(get "items/${choice}/description")"
