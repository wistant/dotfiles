# UNIVERSAL PULL REQUEST PROTOCOL (AI-SYNC)

Ce document définit le standard d'excellence pour la préparation des Pull Requests avec synchronisation forcée et audit métier.

---

## Étape 1 : Validation Atomique & Synchronisation (CRITICAL)

Dès que l'utilisateur demande une PR, l'IA **DOIT** exécuter cette séquence dans l'ordre :

0. **Audit des Commits** :
   - Vérifier que les modifications (git diff/status) ont bien été découpées selon le protocole `.protocols/COMMIT.md` (aucun `git add .` global).
1. **Vérification Distante** :
   - `git fetch origin`
   - `git log HEAD..origin/dev` : Alerte si des commits distants manquent.
2. **Analyse Différentielle** :
   - `git log origin/dev..HEAD --oneline`
   - `git diff --stat origin/dev..HEAD`
3. **Audit des Protocols** :
   - Vérifier que la sécurité respecte `.protocols/SECURITY.md`.

---

## Étape 2 : Génération Automatique du Rapport

Une fois la synchronisation validée, l'IA doit générer de façon autonome un fichier d'audit listant les travaux :

- **Location** : Le fichier doit être créé sous `zothers/PR[Numéro].md` (incrémenter le numéro par rapport à l'existant).
- **Langue** : 🇬🇧 **STRICTEMENT EN ANGLAIS**. Même si la conversation se déroule en français, le fichier PR doit être rédigé en anglais professionnel.

---

## Étape 3 : Structure du Document PR Élite

### Title: type(scope): Elite Technical Description

### Narrative Synthesis

*Global impact on the Cyber-Premium vision, architectural decisions, and value delivered.*

### Granular Modifications

- **[Composant]** : Détails précis des changements.
- **[Automation]** : Nouveaux protocoles ou scripts introduits.

### Sync Status & Readiness

- Rapport d'état local vs distant et score de préparation.
