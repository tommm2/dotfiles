# Tom's Dotfiles

## Contents

- **Neovim** — 編輯器設定
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

各台機器自己的路徑寫在 `~/.zshrc.local`（不進版控，由 `.zshrc` 最後載入）：

```bash
export NOTE_DIR="$HOME/Desktop/note"
export TOOLS_DIR="$HOME/Desktop/projects/tools"
```

