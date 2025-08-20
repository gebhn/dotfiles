export ENV=~/.ashrc

[ -z "$XDG_RUNTIME_DIR" ] && {
    export XDG_RUNTIME_DIR="/tmp/$(id -u)/runtime"
}

[ -z "$GOPATH" ] && {
    export GOPATH="$HOME/.local/go"
    echo "GOPATH=$GOPATH" >> $HOME/.local/go/env
}

[ -z "$GOBIN" ] && {
    export GOBIN="$GOPATH/bin"
    echo "GOBIN=$GOBIN" >> $HOME/.local/go/env
}

export PATH=$PATH:$HOME/.turso
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/go/bin

for dir in "$XDG_RUNTIME_DIR" "$GOPATH"; do
    mkdir -pm 0700 "$dir"
done

if [ ! "$WAYLAND_DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1

    exec dbus-run-session sway
fi
