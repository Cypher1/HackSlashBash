#!/bin/bash

choose "Where to" "${loc}/walk"
if [ -z "${choice}" ]
then
  return
fi

loc="${choice}"
echo "${loc}" | put "loc"
