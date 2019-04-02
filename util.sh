#!/bin/bash

function indent() {
  cat | sed "s/^/  /"
}

function choose_raw() {
  ops="$2"
  echo "$1?"
  echo "$ops" | cat -n
  echo -n "? "
  read choice
  fail=""
  if echo "${choice}"|grep "^[0-9][0-9]*$" > /dev/null
  then
    choice="$(echo "$ops" | cat -n | grep "^ *${choice}[^0-9]" | sed "s/^ *[0-9]*[^0-9]//")"
    return
  fi
  if echo "$ops" | grep "^${choice}$" > /dev/null
  then
    return
  fi
  fail="$choice"
  choice="$3"
}
