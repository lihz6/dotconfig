## Usage

`~/.profile`

```bash
if [ -t 1 ] && [ -f "$HOME/.config/profile.bash" ]; then
   . "$HOME/.config/profile.bash"
fi
```

`~/.bashrc`

```bash
# Note: the following would reset `$PS1`,
# please place before anything decorating the `$PS1`,
# such as Annaconda, Miniconda, etc.

if [ -f "$HOME/.config/bashrc.bash" ]; then
   . "$HOME/.config/bashrc.bash"
fi
```

## Proxy

```bash
export http_proxy="http://username:password@proxy.domain.com:8080"
export https_proxy="http://username:password@proxy.domain.com:8080"
export no_proxy="$(printf %s, {0..9}).local,localhost",.domain.com
```

## Trouble Shooting

### 1. Ubuntu Terminal doesn't seem to load `~/.profile` automatically.

Checkbox: Preferences > Unamed > Command > Run command as a login shell
