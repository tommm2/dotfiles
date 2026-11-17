# Tom's Dotfiles

## Contents

- **Neovim** — 編輯器設定
- **Tmux** — Terminal 分割與 session 管理
- **Zsh** — Shell 設定（zinit 管理插件）
- **Starship** — Prompt 主題
- **Ghostty** — Terminal 模擬器設定
- **Herdr** — Terminal 多工器設定（`herdr/.config/herdr/config.toml`，搭配 `scripts/herdr-nav.sh` 與 tab bar 用量腳本）

## 前置安裝

```bash
# 插件管理
zinit

# CLI 工具
brew install eza fzf zoxide starship pyenv nvm

# AI
claude  # Claude Code CLI，note-rename 會用到
```

## 環境變數

在 `~/.zshrc` 設定以下路徑（依個人環境調整）：

```bash
export NOTE_DIR="$HOME/Desktop/note"
export TOOLS_DIR="$HOME/Desktop/projects/tools"
```

