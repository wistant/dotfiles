# 🏁 Project Initialization Protocol

Ce protocole automatise la configuration de l'environnement de développement pour garantir un cadre d'ingénierie d'élite dès la première seconde.

## 1. Git Identity Configuration
L'IA doit s'assurer que l'identité Git est correctement configurée pour le projet :
- `git config user.name "Your Name"`
- `git config user.email "your.email@example.com"`
- `git config core.ignorecase false` (Pour éviter les problèmes de casse sous Windows/macOS)

## 2. Environment Setup Check
Avant toute action, l'IA doit vérifier la présence et la validité de :
- `.env.example` vs `.env`
- Version de Node.js et bun (via `.nvmrc` ou `package.json`)
- Version de PNPM et de bun (gestionnaires privilégié)

## 3. Toolset Calibration
- Activation de **Prettier** et **ESLint** avec les règles strictes du projet.
- Vérification des extensions VS Code recommandées (`.vscode/extensions.json`).

---
*Note : L'échec d'une étape d'initialisation suspend immédiatement toute autre action de développement.*
