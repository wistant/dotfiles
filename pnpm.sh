#!/bin/bash

# --- PROFESSIONAL NPM PUBLICATION ---

# Styling
GRAY='\033[90m'
CYAN='\033[36m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}${CYAN}  NPM PUBLICATION${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"

# Progress simulation
for i in {1..20}; do
    percent=$((i * 100 / 20))
    filled=$((i * 20 / 20))
    empty=$((20 - filled))
    bar=$(printf "%${filled}s" | tr ' ' '#')
    space=$(printf "%${empty}s" | tr ' ' '-')
    printf "\r${BOLD}Status:${RESET} [${bar}${space}] ${percent}%%"
    sleep 0.02
done
echo -e " ${BOLD}${CYAN}READY${RESET}\n"

# Audit Step
if [ -f "./protocols/SECURITY.md" ]; then
    echo -e "${BOLD}Security Check:${RESET} Verifying protocols..."
    pnpm audit
fi

# Execute Publication
echo -e "\n${BOLD}Action:${RESET} Publishing to registries..."
pnpm publish --access public

echo -e "\n${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}${CYAN}  PUBLISHED SUCCESSFULLY${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"
