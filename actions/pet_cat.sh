echo "The cat purrs and nestles into your lap"

if get "inventory" | grep "^cat$" > /dev/null
then
  return
else
  echo "cat" | add "inventory"
  echo "The cat gets up and follows you"
fi
