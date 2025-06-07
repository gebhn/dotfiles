export PATH
export ENV=~/.ashrc

if [ ! "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/tmp/$(id -u)/runtime"
fi

if command -v go >/dev/null 2>&1; then
    if [ ! "$GOPATH" ]; then
        export GOPATH="$HOME/.local/go"
    fi

    if [ ! "$GOPATH" ]; then
        export GOBIN="$GOPATH/bin"
    fi

    PATH=$PATH:$GOBIN
    printf "GOPATH=$GOPATH" > "$HOME/.config/go/env"
fi

if command -v docker >/dev/null 2>&1; then
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/docker.sock"
fi

if command -v turso >/dev/null 2>&1; then
    PATH="$PATH:$HOME/.turso"
fi

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

