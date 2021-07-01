#!/usr/bin/with-contenv bash

set -eu
set -o pipefail

groupmod -o -g "$PGID" idies
usermod -o -u "$PUID" idies
echo "idies:$ROOT_PASSWORD" | chpasswd
echo "root:$ROOT_PASSWORD" | chpasswd

# Link /root -> $HOME
# for compatibility reasons
if [[ "$PGID" -eq 0 ]] && [[ "$PUID" -eq 0 ]]
then
  if [[ ! -e "$HOME" ]]
  then
    ln -s /root "$HOME"
  fi
else
  mkdir -p "$HOME"
fi

chown idies:idies "$HOME"
