#!/bin/bash

# --- RODIN AUDIT : GITHUB SYNC ---

GRAY='\033[90m'
BOLD='\033[1m'
RED='\033[31m'
RESET='\033[0m'

refuse() {
    echo -e "\n${RED}${BOLD}REFUS : $1${RESET}"
    echo -e "${GRAY}L'historique Git doit être pur avant toute synchronisation.${RESET}"
    echo -e "${GRAY}--------------------------------------------------${RESET}"
    exit 1
}

echo -e "${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}  RODIN AUDIT : GITHUB SYNC${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"

# 1. Vérification de l'Atome
if ! git diff-index --quiet HEAD --; then
    refuse "Modifications non commitées détectées. Ta synchronisation est prématurée. Décompose tes intentions avant de pousser."
fi

# 2. Synchronisation
echo -e "${BOLD}Action :${RESET} Projection vers le miroir distant..."
git push || refuse "Échec de la projection (Vérifie ta clé ou ta connexion)."

echo -e "\n${GRAY}--------------------------------------------------${RESET}"
echo -e "${BOLD}  SYNCHRONISATION TERMINÉE${RESET}"
echo -e "${GRAY}  Ton historique est désormais scellé à distance.${RESET}"
echo -e "${GRAY}--------------------------------------------------${RESET}"
