# Tom's Dotfiles

Personal development environment: Zsh, Neovim, Starship, Ghostty and Herdr. The primary platform is macOS; `.zshrc` also supports WSL.

This document is written so that a person or an AI agent can follow it to install everything. AI agents: read "Rules for AI agents" first, then run "Installation" in order.

## Rules for AI agents

1. Detect the platform first. `uname -s` printing `Darwin` means macOS; `/proc/sys/kernel/osrelease` containing `microsoft` means WSL. Where the steps differ, this document lists them separately.
2. Before creating a link, inspect the target. If the target exists and is not a symlink into this repo, rename it to `<name>.bak.<date>` first, then create the link. Never overwrite or delete it.
3. Keep every step idempotent: skip tools that are already installed and leave correct links alone.
4. Steps that need the user (signing in, entering a password, installing GUI apps or fonts) must be listed for the user to do. Do not try to work around them.
5. `~/.zshrc.local` holds machine-specific settings and is not in this repo. If it exists, do not overwrite or edit it.
6. When finished, run the commands in "Verification" and report each result.

## Layout and link targets

The repo is expected at `~/dotfiles`. Paths in the Herdr config point at `~/dotfiles/scripts/`, so other locations will break them.

| Path in repo | Linked to | Method | Contents |
|---|---|---|---|
| `.zshrc` | `~/.zshrc` | `ln -s` | Zsh config; plugins managed by zinit |
| `.config/starship.toml` | `~/.config/starship.toml` | `ln -s` | Starship prompt |
| `nvim/.config/nvim/` | `~/.config/nvim` | `stow nvim` | Neovim; plugins managed by lazy.nvim |
| `ghostty/.config/ghostty/` | `~/.config/ghostty` | `stow ghostty` | Ghostty terminal |
| `herdr/.config/herdr/config.toml` | `~/.config/herdr/config.toml` | `stow herdr` | Herdr terminal multiplexer |
| `claude/.claude/skills/<name>/` | `~/.claude/skills/<name>` | `stow claude` | Personal Claude Code skills |
| `claude/.claude/statusline.sh` | `~/.claude/statusline.sh` | `stow claude` | Claude Code status line |
| `claude/.config/caveman/config.json` | `~/.config/caveman/config.json` | `stow claude` | Default mode for the caveman plugin |
| `codex/.codex/AGENTS.md` | `~/.codex/AGENTS.md` | `stow codex` | Global Codex instructions |
| `codex/.codex/skills/<name>` | `~/.codex/skills/<name>` | `stow codex` | Symlinks to the same skills as `claude/` |
| `scripts/` | Not linked; called as `~/dotfiles/scripts/...` | — | Scripts used by Herdr |
| `Brewfile` | Not linked | `brew bundle` | Homebrew package list |

`nvim`, `ghostty`, `herdr`, `claude` and `codex` are GNU Stow packages: the tree inside each one mirrors its location under `$HOME`. The repo root is not a stow package. Do not run `stow .`, or `README.md` and `Brewfile` will be linked into `$HOME` as well.

`~/.config/herdr/` also holds runtime files (sockets, logs, `session.json`), so only `config.toml` is linked. When that directory already exists, stow links just the file.

Likewise, `~/.claude/skills/` also contains skills synced from claude.ai (`synced/`), which are managed by Claude and not tracked here. Each personal skill directory is linked on its own. If `~/.claude/skills/` does not exist yet, create it before running stow so stow does not link the whole directory.

Codex uses the same skills. Each entry in `codex/.codex/skills/` is a relative symlink to `claude/.claude/skills/<name>`, so a skill is edited in one place and both tools see the change. `~/.codex/` itself is full of runtime state (`auth.json`, sessions, SQLite databases), so only `AGENTS.md` and the skill links are tracked. Create `~/.codex/skills/` before running stow for the same reason as above.

## Installation

### 1. Clone the repo

```bash
git clone git@github.com:tommm2/dotfiles.git ~/dotfiles
```

### 2. Install packages

**macOS**

```bash
# If Homebrew is missing, install it with the command from https://brew.sh
brew bundle --file ~/dotfiles/Brewfile
```

The `Brewfile` includes CLI tools, font casks, iTerm2, gcloud, VS Code extensions and Go tools. For the terminal setup alone, the minimum is:

```bash
brew install git stow neovim starship eza fzf zoxide pyenv ripgrep fd luarocks
```

**WSL (Ubuntu)**

The `cask` and `vscode` entries in the `Brewfile` work only on macOS. On WSL, install the equivalent tools with apt:

```bash
sudo apt update
sudo apt install -y zsh git stow ripgrep fd-find jq luarocks build-essential unzip
```

The apt versions of `neovim`, `starship`, `eza`, `fzf`, `zoxide` and `pyenv` are usually too old. Install current releases following each project's own instructions. `.zshrc` needs `fzf --zsh` (fzf 0.48 or later). The Neovim config is currently used with Neovim 0.11.

### 3. Tools not installed through Homebrew

| Tool | How to install | Notes |
|---|---|---|
| zinit | Nothing to do | `.zshrc` clones it into `~/.local/share/zinit/zinit.git` on first load |
| nvm | Official install script from https://github.com/nvm-sh/nvm | `.zshrc` loads `~/.nvm/nvm.sh`. A Homebrew-installed nvm lives elsewhere and is not loaded |
| Herdr | Follow https://herdr.dev | Binary goes in `~/.local/bin/herdr`; update later with `herdr update` |
| Ghostty | macOS: download from https://ghostty.org | Not in the `Brewfile` |
| Claude Code | Follow the official instructions | Used by the usage segment in the Herdr tab bar |
| jq | Built in at `/usr/bin/jq` on macOS 15+; apt on WSL | Required by the scripts in `scripts/` |

### 4. Create links

```bash
cd ~/dotfiles
mkdir -p ~/.config ~/.claude/skills ~/.codex/skills

# If a target already exists, back it up first (see rule 2)
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml

stow -t ~ nvim ghostty herdr claude codex
```

On WSL without Ghostty, run `stow -t ~ nvim herdr claude codex` instead.

### 5. Machine-specific settings (optional)

`.zshrc` sources `~/.zshrc.local` last, when it exists. Use it for paths, environment variables or secrets that differ per machine. The file is not tracked, and nothing in this repo depends on it, so skip this step unless a machine needs it.

```bash
# Example only; create the file when needed
cat > ~/.zshrc.local <<'EOF'
# Machine-specific settings, not tracked in dotfiles.
export EXAMPLE_DIR="$HOME/path/to/dir"
EOF
```

### 6. Change the default shell

```bash
chsh -s "$(command -v zsh)"
```

This step asks the user for a password.

### 7. Claude Code plugins

Run these inside Claude Code. They need the user's Claude Code session, so an AI agent should list them for the user instead of running them.

```text
/plugin marketplace add JuliusBrussee/caveman
/plugin install caveman@caveman
/plugin marketplace add DietrichGebert/ponytail
/plugin install ponytail@ponytail
```

### 8. Initialise

```bash
# Start zsh once so zinit downloads its plugins
zsh -ic exit

# Neovim: lazy.nvim downloads plugins; Mason installs LSP servers and formatters
nvim --headless "+Lazy! sync" +qa

# If Herdr is running, reload its config
herdr server reload-config
```

## Verification

```bash
ls -l ~/.zshrc ~/.config/starship.toml ~/.config/nvim ~/.config/ghostty ~/.config/herdr/config.toml
ls -l ~/.claude/skills ~/.codex/skills ~/.codex/AGENTS.md
zsh -n ~/.zshrc && echo "zshrc syntax ok"
zsh -ic 'whence -w z prompt_starship_precmd fzf-history-widget'
nvim --headless "+lua print(vim.fn.maparg('<C-l>','n',false,true).desc)" +qa
herdr config check
```

Expected results:

- All five paths are symlinks into `~/dotfiles/...`, and each skill under `claude/.claude/skills/` appears in `~/.claude/skills` as a symlink into `~/dotfiles/claude/...`.
- `whence` reports `function` for all three names.
- Neovim prints `Window/pane right`.
- `herdr config check` prints `config: ok`.

## Components

### Zsh (`.zshrc`)

- Plugins: zsh-syntax-highlighting, zsh-completions, zsh-autosuggestions and fzf-tab, loaded by zinit.
- Integrations: starship, zoxide, fzf and pyenv are initialised only when installed, so a missing tool does not cause errors.
- WSL: when WSL is detected, `pbcopy`, `pbpaste` and `open` map to `clip.exe`, PowerShell `Get-Clipboard` and `explorer.exe`.
- OpenSpec completions load from `~/.zsh/completions`.
- Aliases: `vi` (nvim), `ll` / `ls` (eza), and `g*` aliases for git stash and worktree.

### Neovim (`nvim/`)

- `init.lua` loads `tom.core` (options, keymaps, autocmds) and then `tom.lazy` (plugins).
- Plugin specs live in `lua/tom/plugins/`; versions are pinned in `lazy-lock.json`.
- `Ctrl+h/j/k/l` moves between Neovim windows. At the edge window, it hands off to Herdr to move pane focus.

### Herdr (`herdr/` and `scripts/`)

- Prefix is `Ctrl+s`. `prefix+s` / `prefix+v` split panes; `prefix+n` creates a workspace.
- `Ctrl+h/j/k/l` is handled by `scripts/herdr-nav.sh`. When the focused pane runs vim or nvim, the key is sent to the editor; otherwise Herdr's pane focus moves.
- The right side of the tab bar shows AI usage:
  - `scripts/claude-usage.sh` reads `~/.cache/ai-usage/claude.json`. That cache is written by the Claude Code status line script `claude/.claude/statusline.sh`. Without a running Claude Code session, the cache goes stale after 10 minutes and the segment is empty.
  - `scripts/codex-usage.sh` reads the Codex session logs. Without Codex, the segment is empty.
- Theme: rose-pine.

### Ghostty (`ghostty/`)

- Font: `Paper Mono`, falling back to `MesloLGS Nerd Font Mono`. Meslo is in the `Brewfile`; Paper Mono is not and must be installed separately. Without it, Ghostty uses Meslo.

### Claude Code (`claude/`)

- Personal skills: `ask-me`, `bro`, `encode-lessons-in-structure`, `grill-me`, `how`, `no-comments`, `note`, `resume-review`, `verify-in-browser` and `write-resume`. Each directory holds a `SKILL.md` and its supporting files.
- `statusline.sh` shows the caveman and ponytail badges and the remaining 5h / 7d rate limit, and writes usage to `~/.cache/ai-usage/claude.json` for the herdr tab bar. `~/.claude/settings.json` is not tracked, so set `"statusLine": {"type": "command", "command": "~/.claude/statusline.sh"}` there by hand on a new machine.
- `note` writes notes to `$NOTE_DIR` (default `~/Desktop/projects/note`) and clones `$NOTE_REPO` there when the folder is missing. Set both under `env` in `~/.claude/settings.json`, for example `"env": {"NOTE_DIR": "/Users/<you>/notes", "NOTE_REPO": "git@github.com:<you>/notes.git"}`. Without `NOTE_REPO`, the skill asks for the URL.
- Other skills in `~/.claude/skills/` (plugin skills, claude.ai sync, and skills kept local on purpose) are not in this repo.

### Claude Code plugins: caveman and ponytail

- caveman shortens Claude's conversational replies. `~/.config/caveman/config.json` sets the default mode (`full`). Switch per session with `/caveman lite|full|ultra|off`.
- ponytail makes Claude prefer the smallest working change. It has no config file; the default level is `full`. Switch per session with `/ponytail lite|full|ultra`, or turn it off with "stop ponytail".
- Both plugins are installed from their GitHub marketplaces (step 7). Their runtime state (`~/.claude/.caveman-active`, `~/.claude/.ponytail-active`, session logs) is not tracked.

### Codex (`codex/`)

- `AGENTS.md` tells Codex to use the `caveman` skill and the `ponytail` skill at `full` intensity by default.
- `skills/` links the personal skills from `claude/`, except `verify-in-browser`, which needs the Claude-only `claude-in-chrome` tools.
- Not tracked: `~/.codex/config.toml` (model choice, per-project trust, MCP servers and app-generated entries with machine-specific paths), `hooks.json` (generated by another app), `auth.json`, and Codex-only skills such as `caveman` and the sprite-generation skills in `~/.codex/skills/`.
- The `ponytail` plugin for Codex comes from the `https://github.com/DietrichGebert/ponytail.git` marketplace configured in Codex.

### Starship (`.config/starship.toml`)

- `.zshrc` sets `STARSHIP_CONFIG` to `~/.config/starship.toml`.
