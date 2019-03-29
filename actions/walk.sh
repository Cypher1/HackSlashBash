#!/bin/bash

choose "Where to" "${loc}/walk"

if [ -z "${choice}" ]
then
  return
fi

echo "${choice}" | put "loc"
