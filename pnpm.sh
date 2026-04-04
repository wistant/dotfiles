#!/bin/bash

# --- RODIN AUDIT : NPM DISTRIBUTION ---

GRAY='\033[90m'
BOLD='\033[1m'
RED='\033[31m'
RESET='\033[0m'

refuse() {
    echo -e "\n${RED}${BOLD}REFUS : $1${RESET}"
    echo -e "${GRAY}L'intégrité de l'infrastructure est compromise. Correction requise.${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    exit 1
}

echo -e "${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}  RODIN AUDIT : NPM DISTRIBUTION${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"

# 1. Intégrité Git (COMMIT.md Guard)
if ! git diff-index --quiet HEAD --; then
    refuse "Arbre de travail impur. Le protocole COMMIT.md n'est pas respecté. Soumet tes modifications de manière atomique avant de prétendre à une publication."
fi

# 2. Sémantique (Versioning)
echo -e "${BOLD}Analyse sémantique :${RESET}"
read -p "Type d'incrément requis (patch/minor/major/none) ? " vtype
if [[ "$vtype" =~ ^(patch|minor|major)$ ]]; then
    echo -e "${GRAY}Mutation de la version ($vtype)...${RESET}"
    pnpm version "$vtype" || refuse "Échec de la mutation sémantique."
else
    echo -e "${GRAY}Avertissement : Es-tu certain que la sémantique n'a pas évolué ?${RESET}"
fi

# 3. Validation Technique (Audit)
if [ -f "pnpm-lock.yaml" ]; then
    echo -e "\n${BOLD}Audit technique :${RESET}"
    pnpm audit || refuse "Vulnérabilités détectées. Base de code non sécurisée."
else
    echo -e "\n${GRAY}Note : Aucun lockfile trouvé. Audit partiel.${RESET}"
fi

# 4. Scellement (Distribution)
echo -e "\n${BOLD}Scellement final :${RESET}"
read -s -p "Clé d'accès NPM (Token) : " npm_token
echo ""

if [ -n "$npm_token" ]; then
    echo -e "${GRAY}Utilisation d'un jeton de session...${RESET}"
    echo "//registry.npmjs.org/:_authToken=$npm_token" > .npmrc_tmp
    NPM_CONFIG_USERCONFIG=./.npmrc_tmp pnpm publish --access public --no-git-checks || { rm .npmrc_tmp; refuse "Échec de distribution."; }
    rm .npmrc_tmp
else
    pnpm publish --access public || refuse "Authentification requise."
fi

echo -e "\n${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}  DISTRIBUTION COMPLÈTE${RESET}"
echo -e "${GRAY}  L'infrastructure est désormais synchronisée.${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"
