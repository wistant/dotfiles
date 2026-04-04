#!/bin/bash

# --- PROFESSIONAL NPM PUBLICATION ARCHITECT ---

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
echo -e "${BOLD}${CYAN}  NPM PUBLICATION ARCHITECT${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"

# 1. Versioning
echo -e "${BOLD}Step 1: Versioning${RESET}"
read -p "Select increment (patch/minor/major/none): " vtype
if [[ "$vtype" =~ ^(patch|minor|major)$ ]]; then
    echo "Upgrading version to $vtype..."
    pnpm version "$vtype" || fail "Version upgrade failed"
else
    echo "Skipping version upgrade."
fi

# 2. Audit
if [ -f "pnpm-lock.yaml" ]; then
    echo -e "\n${BOLD}Step 2: Security Audit${RESET}"
    pnpm audit || fail "Security audit failed"
else
    echo -e "\n${GRAY}Status: Skipping audit (no pnpm-lock.yaml found)${RESET}"
fi

# 3. Git Check
git_flags=""
if ! git diff-index --quiet HEAD --; then
    echo -e "\n${RED}${BOLD}Warning: Unclean working tree detected.${RESET}"
    read -p "Publish anyway? (y/N): " allow_unclean
    if [[ ! "$allow_unclean" =~ ^[yY]$ ]]; then
        fail "Aborted due to unclean git state"
    fi
    git_flags="--no-git-checks"
fi

# 4. Publication
echo -e "\n${BOLD}Step 3: Distribution${RESET}"
read -s -p "Enter NPM Token (leave empty to use current login): " npm_token
echo ""

if [ -n "$npm_token" ]; then
    echo "Using manual token for publication..."
    # Create a temporary .npmrc for this session
    echo "//registry.npmjs.org/:_authToken=$npm_token" > .npmrc_tmp
    pnpm publish --access public --no-git-checks --userconfig .npmrc_tmp || { rm .npmrc_tmp; fail "Publication failed"; }
    rm .npmrc_tmp
else
    pnpm publish --access public $git_flags || fail "Publication failed"
fi

echo -e "\n${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}${CYAN}  PUBLISHED SUCCESSFULLY${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"
