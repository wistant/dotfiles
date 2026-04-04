# --- ELITE PROTOCOL ALIASES (POSIX COMPLIANT) ---

# Navigation
alias ra='cat .protocols/ASSIST.md'
alias ri='cat .protocols/_INDEX.md'
alias rs='cat .protocols/SECURITY.md && pnpm audit'

# Git Refined
alias gc='git commit'
alias gca='echo "RODIN ERROR: git add . is forbidden. Use atomic staging." && false'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Calibration Hook (Zsh specific - for POSIX compat, use manual trigger or wrapper)
# chpwd is Zsh-specific. For other shells, you can use a manual 'ra' check.
