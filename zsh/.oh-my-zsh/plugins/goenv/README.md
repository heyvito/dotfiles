# goenv

## Description

This plugin automatically reads `.goenv` files in the `pwd`, and sets `GOPRIVATE` environment variables.

To use it:

1. `cd` to your zsh plugin directory. For instance, if you use oh-my-zsh, you will find it over `~/.oh-my-zsh/plugins`
2. Clone this repository: `git clone https://github.com/heyvito/goenv.zsh.git goenv`
3. Add the `goenv` plugin to your `plugins` array in `~/.zshrc`:

```zsh
plugins=(... goenv)
```

Once the plugin is loaded, it will automatically lookup `.goenv` files whenever the current directory changes, and will automatically set `GOPRIVATE` as defined in such file.
