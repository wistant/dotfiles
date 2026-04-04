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

# 3. Audit de Sécurité (Zero-Trust)
echo -e "\n${BOLD}Audit de Sécurité :${RESET}"
if [ ! -f "pnpm-lock.yaml" ]; then
    refuse "Absence de pnpm-lock.yaml. L'intégrité des dépendances ne peut être garantie. Génère un lockfile avant toute distribution."
fi

echo -e "${GRAY}Analyse des vulnérabilités...${RESET}"
pnpm audit || refuse "Failles détectées dans l'arbre des dépendances."

# 4. Scan d'Intégrité (Secrets)
echo -e "\n${BOLD}Scan d'Intégrité (Secrets) :${RESET}"
# Recherche de motifs sensibles (excluant les fichiers de config et le script lui-même)
forbidden_patterns="npm_|key_|secret_|password|token"
secrets=$(grep -rEi "$forbidden_patterns" . --exclude-dir=.git --exclude="pnpm.sh" --exclude="CHANGELOG.md" --exclude="package.json" --exclude="*.md" 2>/dev/null)

if [ -n "$secrets" ]; then
    echo -e "${RED}ALERTE : Secrets ou clés potentiels détectés :${RESET}"
    echo "$secrets" | sed 's/^/  /'
    refuse "La Phase 1 du protocole SECURITY.md (Secret Scanning) a échoué. Purge tes fichiers avant de continuer."
fi
echo -e "${GRAY}Aucun secret détecté dans l'espace de travail.${RESET}"

# 4. Scellement (Distribution)
echo -e "\n${BOLD}Scellement final :${RESET}"
read -s -p "Clé d'accès NPM (Token) : " npm_token
echo ""

if [ -n "$npm_token" ]; then
    echo -e "${GRAY}Scellement par jeton éphémère...${RESET}"
    # Environment injection (Self-destructing: no disk trace)
    npm_config_//registry.npmjs.org/:_authToken="$npm_token" pnpm publish --access public --no-git-checks || { unset npm_token; refuse "Échec de distribution."; }
    unset npm_token
else
    pnpm publish --access public || refuse "Authentification requise."
fi

echo -e "\n${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}  DISTRIBUTION COMPLÈTE${RESET}"
echo -e "${GRAY}  L'infrastructure est désormais synchronisée.${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"
