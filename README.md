# etc

my conf, expressed as Nix before I forget how I configured it.

personal standalone Home Manager config for `aarch64-darwin`.

## the pile

- `ghostty` with split navigation and custom styling
- `helix` with opinionated editing defaults
- `jujutsu` and `jjui`
- `fish`, `zsh`, `bash`, and `tmux`
- `rust`, `go`, `zig`, `node.js`, `postgresql`, and other dev tools
- nerd fonts

## layout

```text
flake.nix       standalone Home Manager entry point
nix/            packages, shells, tmux, and dev config
ghostty/        terminal config and focused-split shader
helix/          editor config
jjui/           jjui config
```

## steal responsibly

you need Nix with flakes enabled and the `home-manager` command.

```bash
git clone https://github.com/beborngod/etc.git ~/.config/nix
cd ~/.config/nix
home-manager switch --flake .#alx
```

before switching, replace my machine-specific values:

- set `system`, `user`, and the config name in `flake.nix`
- set Git and Jujutsu identity in `nix/dev.nix`
- update the absolute Fish path in `ghostty/config`

## sharp edges

expect to edit it before activation!
