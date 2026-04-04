# --- ELITE PROTOCOL ALIASES (CYBER-PREMIUM) ---

# Navigation
alias ra='cat .protocols/ASSIST.md'
alias ri='cat .protocols/_INDEX.md'
alias rs='cat .protocols/SECURITY.md && pnpm audit'

# Git Refined
alias gc='git commit'
alias gca='echo "RODIN ERROR: git add . is forbidden. Use atomic staging." && false'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Calibration Hook (Zsh)
# Logic: When entering a directory, check for protocols/INIT.md
function chpwd() {
    if [ -f ".protocols/INIT.md" ]; then
        echo "--- RODIN: INITIALIZATION PROTOCOL DETECTED ---"
        cat .protocols/INIT.md | head -n 5
    fi
}
