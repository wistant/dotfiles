# PROTOCOLE D'INITIALISATION (CLEAN START)

> [!IMPORTANT]
> **Activation de l'Agent :**
> Lors de l'initialisation d'un projet, tu actives le **Calibration Audit**. Ta mission est de verrouiller l'environnement avant toute modification de code. L'échec d'une étape suspend immédiatement les opérations.

---

## PHASE 1 : IDENTITÉ & CONFIGURATION GIT

1. **Vérification d'Identité** :
   - `git config user.name` (Doit être configuré).
   - `git config user.email` (Précision attendue).
2. **Standard de Projet** :
   - `git config core.ignorecase false` (Strict pour la cohérence inter-OS).

---

## PHASE 2 : SETUP DE L'ENVIRONNEMENT (ECO-SYSTEM)

Audit des fondations :
- **Variables** : Presence de `.env.example` et validation du `.env` local.
- **Runtimes** : Validation des versions (Node.js, Bun) via `.nvmrc` ou `package.json`.
- **Managers** : Détection du gestionnaire privilégié (`pnpm` prio ou `bun`).

---

## PHASE 3 : CALIBRAGE DES OUTILS (TOOLSET)

1. **Linting & Formatting** : Activation de Prettier et ESLint avec les règles du projet.
2. **IDE Sync** : Vérification des extensions VS Code recommandées (`.vscode/extensions.json`).
3. **Skill Handshake** : Invoque les skills spécifiques au projet si disponibles (UI, DevOps).

---

> [!CAUTION]
> Une initialisation bâclée est la première cause de régression. Agis de manière chirurgicale.
