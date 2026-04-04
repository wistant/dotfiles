#!/bin/bash

# --- PROFESSIONAL GITHUB SYNC ---

GRAY='\033[90m'
CYAN='\033[36m'
BOLD='\033[1m'
RED='\033[31m'
RESET='\033[0m'

fail() {
    echo -e "\n${RED}FAILED: $1${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    exit 1
}

echo -e "${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}${CYAN}  GITHUB SYNCHRONIZATION${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"

# 1. Status Check
if ! git diff-index --quiet HEAD --; then
    echo -e "${RED}${BOLD}Warning: You have uncommitted changes.${RESET}"
    read -p "Continue sync anyway? (y/N): " allow_sync
    if [[ ! "$allow_sync" =~ ^[yY]$ ]]; then
        fail "Sync aborted by user"
    fi
fi

# 2. Sync
echo -e "${BOLD}Action:${RESET} Synchronizing with remote..."
git push || fail "Git push failed (Check SSH passphrase or connection)"

echo -e "\n${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}${CYAN}  SYNC COMPLETE${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"
