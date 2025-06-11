export PATH
export ENV=~/.ashrc

exists() {
    command -v "$1" > /dev/null
}

if [ ! "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/tmp/$(id -u)/runtime"
fi

exists go && {
    if [ ! "$GOPATH" ]; then
        export GOPATH="$HOME/.local/go"
    fi

    if [ ! "$GOPATH" ]; then
        export GOBIN="$GOPATH/bin"
    fi

    PATH=$PATH:$GOBIN
    printf "GOPATH=$GOPATH" > "$HOME/.config/go/env"
}

exists docker && {
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
}

exists turso && {
    PATH="$PATH:$HOME/.turso"
}

for dir in "$XDG_RUNTIME_DIR" "$GOPATH" "$HOME/.config/go"; do
    mkdir -pm 0700 "$dir"
done


if [ ! "$WAYLAND_DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1

    exec dbus-run-session sway
fi

