function __wg() {
    if which ip &>/dev/null && ip link show wg0 &>/dev/null; then
        echo '*'
    fi
}
