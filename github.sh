#!/bin/bash

# --- GITHUB SYNC (SYSTEM PROTOCOL) ---

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
    echo -e "${BOLD}  INTEGRITY AUDIT : GITHUB SYNC${RESET}"
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
        return 1
    fi
    return 0
}

# --- DÉBUT DE L'AUDIT ---
print_banner

# 1. État Interne (Staging Audit)
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}Avertissement :${RESET} Tu as des modifications non commitées."
    git status -s
    refuse "Ton historique doit être pur (atomique) avant toute projection distante."
fi

# 2. Détection de Branche & Contexte
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo -e "${BOLD}Localisation :${RESET} Branche ${CYAN}${BOLD}${CURRENT_BRANCH}${RESET}"

# 3. Audit des Tags (Delta Local vs Distant)
echo -e "${GRAY}Analyse du scellement (tags)...${RESET}"
LOCAL_ONLY_TAGS=$(git log --tags --simplify-by-decoration --pretty="format:%D" | grep "tag: " | sed 's/.*tag: \([^,)]*\).*/\1/' | while read tag; do
    if ! git ls-remote --tags origin 2>/dev/null | grep -q "refs/tags/$tag"; then
        echo $tag
    fi
done | sort -u)

if [ -n "$LOCAL_ONLY_TAGS" ]; then
    echo -e "${YELLOW}${BOLD}DELTA DÉTECTÉ :${RESET} Tags locaux non scellés sur GitHub :"
    for tag in $LOCAL_ONLY_TAGS; do
        echo -e "  - ${BOLD}$tag${RESET}"
    done
    
    if ask_confirm "Faut-il propager ces tags avec cette projection ?"; then
        PUSH_TAGS="--tags"
    fi
else
    echo -e "${GRAY}Aucun nouveau tag local détecté.${RESET}"
fi

# 4. Logique de Branche
case "$CURRENT_BRANCH" in
    "main" | "master")
        echo -e "${RED}${BOLD}ATTENTION :${RESET} Branche de production."
        if ! ask_confirm "Voulez-vous sceller ces changements sur le dépôt public ?"; then
            refuse "Projection annulée."
        fi
        ;;
    "dev" | "develop")
        echo -e "${YELLOW}INFO :${RESET} Branche d'intégration."
        if ! ask_confirm "Pousser vers l'amont de développement ?"; then
            refuse "Projection dev annulée."
        fi
        ;;
    feat/* | fix/* | refactor/*)
        echo -e "${GREEN}INFO :${RESET} Branche de travail."
        if ! ask_confirm "Continuer la projection ?"; then
            refuse "Projection feature annulée."
        fi
        ;;
    *)
        if ! ask_confirm "Confirmer la projection vers l'amont ?"; then
            refuse "Projection annulée."
        fi
        ;;
esac

# 5. Projection
echo -e "\n${BOLD}Action :${RESET} Synchronisation distante..."
if git push $PUSH_TAGS; then
    echo -e "\n${GREEN}${BOLD}SUCCÈS :${RESET} L'infrastructure est synchronisée."
else
    refuse "Échec de la projection. Vérifie ta clé ou ta connexion."
fi

echo -e "${GRAY}--------------------------------------------------${RESET}"
