#!/bin/bash

# --- RODIN INTELLIGENT SYNC (SYSTEM PROTOCOL) ---

# Couleurs & Style
GRAY='\033[90m'
BOLD='\033[1m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
RESET='\033[0m'

# Utilitaires
print_banner() {
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    echo -e "${BOLD}  RODIN AUDIT : GITHUB SYNC${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
}

refuse() {
    echo -e "\n${RED}${BOLD}REFUS : $1${RESET}"
    echo -e "${GRAY}L'intégrité de l'infrastructure prime sur la vitesse.${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    exit 1
}

ask_confirm() {
    echo -ne "${YELLOW}${BOLD}Confirmation requise :${RESET} $1 [y/N] "
    read -r response
    if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        refuse "Interruption par l'utilisateur."
    fi
}

# --- DEBUT DE L'AUDIT ---
print_banner

# 1. État Interne (Staging)
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}Avertissement :${RESET} Tu as des modifications non commitées."
    git status -s
    refuse "Ton historique doit être pur (atomique) avant toute projection distante."
fi

# 2. Détection de Branche
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
REMOTE_BRANCH=$(git rev-parse --abbrev-ref @{u} 2>/dev/null)

echo -e "${BOLD}Localisation :${RESET} Branche ${CYAN}${BOLD}${CURRENT_BRANCH}${RESET}"

# 3. Logique Contextuelle
case "$CURRENT_BRANCH" in
    "main" | "master")
        echo -e "${RED}${BOLD}ATTENTION :${RESET} Tu es sur la branche de production (Oracle)."
        ask_confirm "Voulez-vous sceller ces changements sur le miroir public ?"
        ;;
    "dev" | "develop" | "v2")
        echo -e "${YELLOW}INFO :${RESET} Branche d'intégration détectée."
        ask_confirm "Pousser vers l'amont de développement ?"
        ;;
    feat/* | fix/* | refactor/*)
        echo -e "${GREEN}INFO :${RESET} Branche de travail ciblée détectée."
        echo -e "${GRAY}Astuce : N'oublie pas de merger vers 'main' une fois ton intention validée.${RESET}"
        ask_confirm "Pousser cette branche de travail ?"
        ;;
    *)
        echo -e "${GRAY}Branche personnalisée détectée.${RESET}"
        ask_confirm "Confirmer la projection vers l'amont ?"
        ;;
esac

# 4. Détection de Tags (Le Scellement)
NEW_TAGS=$(git tag --points-at HEAD)
if [ -n "$NEW_TAGS" ]; then
    echo -e "${CYAN}${BOLD}Scellement détecté :${RESET} Les tags suivants sont prêts [${NEW_TAGS}]"
    ask_confirm "Faut-il propager les tags avec cette projection ?"
    PUSH_TAGS="--tags"
fi

# 5. Projection
echo -e "${BOLD}Action :${RESET} Projection vers le miroir distant..."
if git push $PUSH_TAGS; then
    echo -e "\n${GREEN}${BOLD}SUCCÈS :${RESET} L'infrastructure est synchronisée."
    echo -e "${GRAY}Ton historique est désormais scellé à distance.${RESET}"
else
    refuse "Échec de la projection. Vérifie ta connexion ou tes accès."
fi

echo -e "${GRAY}--------------------------------------------------${RESET}"
