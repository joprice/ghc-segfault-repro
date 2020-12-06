#!/usr/bin/env bash

set -u

{ stack run -- +RTS -N -xn -M2G -RTS; } 2> output &
PID=$!

url=localhost:3000

set +e
started=false
while ! $started ; do
  echo "test"
  curl -f $url
  status=$?
  if [[ $status != 0 ]]; then
    echo "Retrying"
  else
    started=true
  fi
  sleep .5
done

while true; do
  curl $url -f
  status=$?
  if [[ $status != 0 ]]; then
    break;
  else
    echo "Retrying"
  fi
  sleep .5
done
# clean up in case it survived
kill $PID
cat output
