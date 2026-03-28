# Meticulous Release & Tagging Protocol

Ce protocole transforme chaque livraison en un événement d'ingénierie certifié.

## 1. Phase de Vérification (Pre-Flight)
Une release ne peut être déclenchée **que si** :
- **Readiness** : Le est à 100%.
- **Zero-Critique** : Aucun lint error ou test échoué.
- **Security Scan** : Audit des secrets et dépendances effectué (`pnpm audit`, `bun run audit` en fonction du package manager ou `.protocols/SECURITY.md`).

## 2. Tagging & Titrages Élite
Chaque release doit porter un "Motto" (Slogan technique) inspiré par la "Cyber-Premium" esthétique.
- **Format du Tag** : `vX.Y.Z` (SemVer strict).
- **Format du Titre** : `vX.Y.Z - [MOTTO]` (ex: `v1.0.0 - Project Shadow Ignition`).
- **Commande** : `git tag -a vX.Y.Z -m "release: [MOTTO] - Detailed changelog reference"`

## 3. Demande de Tagging (AI Logic)
L'IA doit proposer le tag et le titre au USER après avoir :
1. Analysé l'historique complet depuis le dernier tag.
2. Synthétisé les changements majeurs (Features, Security, Design).
3. Choisi un Motto qui reflète l'âme de la release.

## 4. Post-Release
- Génération automatique du `CHANGELOG.md`.
- Mise à jour des versions dans les `package.json`.

---
*Note : Une release sans tag méticuleux est considérée comme une dette technique.*
