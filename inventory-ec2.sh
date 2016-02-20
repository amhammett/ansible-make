#!/bin/bash

echo "# if you're looking for a real dynamic inventory ready-made take a look at"
echo "# > https://github.com/ansible/ansible/tree/devel/contrib/inventory"

if [ -z $1 ]; then
  echo '{"local" : [ "localhost" ]}'
else
  echo aws profile: $AWS_PROFILE
  echo $1
fi
