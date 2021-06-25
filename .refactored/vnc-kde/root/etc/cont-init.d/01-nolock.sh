#!/usr/bin/with-contenv bash

set -eu
set -o pipefail

s6-setuidgid idies mkdir -p "$HOME/.config"
s6-setuidgid idies mv /misc/kscreenlockerrc "$HOME/.config/kscreenlockerrc"
