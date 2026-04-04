# DOTFILES ARCHITECTURE (DOTFILES.md)

This repository contains a modular environment setup designed for high-end engineering.

## COMMANDS & ALIASES

- **`ia`** (Integrity Assist) : `cat protocols/ASSIST.md`
- **`is`** (Integrity Status) : `cat protocols/_INDEX.md`

### 2. Git Automation

- **Commit Template** : Uses a global `.gitmessage` file to enforce atomic formatting.
- **Smart Sync** : Interactive script (`github.sh`) to manage branches and tags.

---

## DESIGN PRINCIPLES

The interface is designed for focus and structural clarity.

- **Prompt** : Starship. Minimalist indicator for the repository state.
- **Multiplexeur** : Zellij. Layouts that prioritize documentation alongside code.
- **Typography** : JetBrains Mono (optimized for code readability).

---

## SHELL HOOKS

Every directory change triggers a check for local protocols.
See `aliases.zsh` for the `chpwd` function logic.
