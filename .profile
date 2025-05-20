export PATH
export ENV=~/.ashrc

if [ ! "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/tmp/$(id -u)/runtime"
    mkdir -pm 0700 "$XDG_RUNTIME_DIR"
fi

if [ ! "$GOPATH" ]; then
    export GOPATH="/home/$(whoami)/.local/go"
    mkdir -pm 0700 "$GOPATH"
    mkdir -pm 0700 "$HOME/.config/go"
    printf "GOPATH=$GOPATH" > "$HOME/.config/go/env"
    PATH=$PATH:$GOPATH
fi

if [ ! "$WAYLAND_DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1
    exec dbus-run-session sway
fi
