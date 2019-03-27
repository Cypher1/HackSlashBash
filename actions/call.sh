#!/bin/bash

echo "Phonebook"
choice "Who'd you like to call" "phonebook" 
if [ -z "$choice" ]
then
  echo "You put away the phone"
else
  echo "Calling $choice..."
  echo "$choice is busy now. Try calling later"
fi
