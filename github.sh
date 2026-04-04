#!/bin/bash

# --- GITHUB SYNC (SYSTEM PROTOCOL) ---

# Colors & Style
GRAY='\033[90m'
BOLD='\033[1m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
RESET='\033[0m'

# Utilities
print_banner() {
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    echo -e "${BOLD}  INTEGRITY AUDIT : GITHUB SYNC${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
}

abort() {
    echo -e "\n${RED}${BOLD}[ABORT]${RESET} $1"
    echo -e "${GRAY}Infrastructure integrity takes precedence over speed.${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    exit 1
}

ask_confirm() {
    echo -ne "${YELLOW}${BOLD}[CONFIRM]${RESET} $1 [y/N] "
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        return 1
    fi
    return 0
}

# --- AUDIT START ---
print_banner

# 1. Working Tree Audit
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}[WARNING]${RESET} Uncommitted changes detected in the working tree."
    git status -s
    abort "History is not clean. Remote projection requires a pure commit history."
fi

# 2. Branch Detection
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo -e "${BOLD}[CONTEXT]${RESET} Current branch: ${CYAN}${BOLD}${CURRENT_BRANCH}${RESET}"

# 3. Tag Delta Audit (Local vs Remote)
echo -e "${GRAY}[AUDIT]   Scanning tag versions...${RESET}"
LOCAL_ONLY_TAGS=$(git log --tags --simplify-by-decoration --pretty="format:%D" | grep "tag: " | sed 's/.*tag: \([^,)]*\).*/\1/' | while read tag; do
    if ! git ls-remote --tags origin 2>/dev/null | grep -q "refs/tags/$tag"; then
        echo $tag
    fi
done | sort -u)

if [ -n "$LOCAL_ONLY_TAGS" ]; then
    echo -e "${YELLOW}${BOLD}[DELTA]${RESET} Local tags not yet sealed on remote:"
    for tag in $LOCAL_ONLY_TAGS; do
        echo -e "  - ${BOLD}$tag${RESET}"
    done

    if ask_confirm "Propagate these tags with this push?"; then
        PUSH_TAGS="--tags"
    fi
else
    echo -e "${GRAY}[OK]      No unpublished local tags detected.${RESET}"
fi

# 4. Branch Gate Logic
case "$CURRENT_BRANCH" in
    "main" | "master")
        echo -e "${RED}${BOLD}[GATE]${RESET} Production branch. Full integrity required."
        if ! ask_confirm "Seal these changes to the public repository?"; then
            abort "Push cancelled by operator."
        fi
        ;;
    "dev" | "develop")
        echo -e "${YELLOW}[GATE]${RESET} Integration branch."
        if ! ask_confirm "Push to integration upstream?"; then
            abort "Push cancelled by operator."
        fi
        ;;
    feat/* | fix/* | refactor/*)
        echo -e "${GREEN}[GATE]${RESET} Feature branch."
        if ! ask_confirm "Push to remote?"; then
            abort "Push cancelled by operator."
        fi
        ;;
    *)
        if ! ask_confirm "Push current branch to upstream?"; then
            abort "Push cancelled by operator."
        fi
        ;;
esac

# 5. Remote Projection
echo -e "\n${BOLD}[PUSH]${RESET} Initiating remote sync..."
if git push $PUSH_TAGS; then
    echo -e "\n${GREEN}${BOLD}[OK]${RESET} Infrastructure successfully synchronized."
else
    abort "Remote push failed. Check your credentials or network connectivity."
fi

echo -e "${GRAY}--------------------------------------------------${RESET}"
