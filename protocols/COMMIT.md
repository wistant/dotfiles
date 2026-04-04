# CONVENTION DE COMMITS ATOMIQUES

> [!IMPORTANT]
> **Activation de l'Agent :**
> Des que l'utilisateur entame une phase de commit, tu actives le **Rodin Audit**. Ta mission est de refuser tout commit "fourre-tout". Tu dois forcer la decomposition des changements en intentions logiques isolees.

---

## Regle d'Or : Zero "git add ."

Il est **STRICTEMENT INTERDIT** d'utiliser `git add .` ou `git commit -a`.
Chaque modification doit etre atomique. On ne melange pas la logique métier (`core/`) et le style (`ui/`).

> [!CAUTION]
> **Pas de Push Automatique** : L'IA ne doit jamais exécuter `git push` ou `./github.sh`.
> Après le commit, l'IA s'arrête. Le USER valide et pousse manuellement.

---

## METHODOLOGIE : LE CYCLE ATOMIQUE

### PHASE 1 : L'AUDIT D'INTENTION (Silent)

1. **Status Check** : Examine `git status` et `git diff`.
2. **Identification des Motifs** : Pourquoi as-tu fait ces changements ?
3. **Partitionnement** : Separe les changements techniques (refactor, deps) des changements fonctionnels (feat, fix).

### PHASE 2 : L'INTERROGATION SOCRATIQUE

Si l'utilisateur semble vouloir tout commiter d'un coup, pose la question :
> *"Je vois des changements sur [Fichier A] et [Fichier B]. Sont-ils lies par une seule intention logique, ou devons-nous les separer en deux commits distincts pour preserver l'historique ?"*

### PHASE 3 : GROUPEMENT & STAGING CIBLE

1. **Selection** : Ajoute uniquement les fichiers lies au motif n°1.
2. **Commande** : `git add [fichiers specifiques]`.
3. **Verification** : Effectue un `git status` pour valider que seule l'intention n°1 est dans le buffer.

---

## Format du Message

Chaque commit doit suivre strictement ce format :

```text
<type>(scope): <sujet>

[Corps explicite mais concis — réservé aux changements d'ampleur moyenne ou majeure]

[Footer]
```

### 1. Types Autorises

- `feat`: Nouvelle fonctionnalite (ajoute de la valeur utilisateur).
- `fix`: Correction de bug (repare quelque chose de casse).
- `ui`: Changement purement visuel (CSS, style, assets) sans impact logique.
- `refactor`: Reecriture de code (ni fix ni feat, ex: nettoyage, simplification).
- `perf`: Amelioration des performances.
- `docs`: Documentation uniquement.
- `test`: Ajout ou modification de tests.
- `chore`: Maintenance, build, dependances (pas de code de prod).
- `style`: Formatage, espaces manquants (pas de changement de logique).

### 2. Scope (Portee)

Le fichier ou module impacte. Exemples : `(auth)`, `(ui)`, `(deps)`, `(api)`, `(hooks)`.

### 3. Sujet

- Imperatif present ("add" et non "added").
- Pas de majuscule au debut.
- Pas de point a la fin.
- Clair et concis.

### Exemples de Bons Commits

- feat(hooks): add use-media-query for responsive logic
- fix(ui): resolve typescript error in 3d-card component
- chore(deps): upgrade prisma to v7

### Exemples a BANNIR

- fix bugs (Trop vague)
- wip (Interdit sur main/dev)
- update files (Ne veut rien dire)
