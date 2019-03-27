#!/bin/bash

choose "Where to" "${loc}/walk"

if [ -z "${choice}" ]
then
  return
else
  loc="${choice}"
  echo "${loc}" | put "loc"
fi
