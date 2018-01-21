#!/usr/bin/env bash

printf "%s\n" "Create symbolic link to /usr/local/bin"

if [[ -d "/usr/local/bin" ]] ; then

  ln -s bin/multitor /usr/local/bin

fi

printf "%s\n" "Create man page to /usr/local/man/man8"

if [[ -d "/usr/local/man/man8" ]] ; then

  cp doc/man8/multitor.8 /usr/local/man/man8
  gzip /usr/local/man/man8/multitor.8

fi

