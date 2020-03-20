## Proxy

```bash
export http_proxy="http://username:password@proxy.domain.com:8080"
export https_proxy="http://username:password@proxy.domain.com:8080"
export no_proxy="$(printf %s, {0..9}).local,localhost",.domain.com
```

## Usage

`~/.profile`

```bash
if [ -t 1 ] && [ -f "$HOME/.config/profile.bash" ]; then
   . "$HOME/.config/profile.bash"
fi
```

`~/.bashrc`

```bash
if [ -f "$HOME/.config/bashrc.bash" ]; then
   . "$HOME/.config/bashrc.bash"
fi
```
