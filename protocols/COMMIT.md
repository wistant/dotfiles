# 🪶 Convention de Commits & Versioning

## 🚫 Règle d'Or : Zéro "git add ."

Il est srictement **INTERDIT** d'utiliser `git add .` ou `git commit -a`.
Chaque changement doit être atomique et ciblé. On ne mélange pas des torchons et des serviettes.
Tu dois voir les changements concrets apportes.. tu vois ?? je peux avoir change editer un fichier pour deux raions. Et les deux raisons doivent etre notee dans le commits.

## 🎯 Stratégie de Commit Atomique
Un commit doit correspondre à **UNE** intention logique.
Si j'ai modifié 3 fichiers pour 3 raisons différentes -> **3 COMMITS DIFFÉRENTS**.

### Procédure Obligatoire
1. **Identifier** les fichiers modifiés (`git status`).
2. **Grouper** les fichiers par logique (ex: tous les fichiers liés au composant `Button`).
3. **Cibler** uniquement ces fichiers (`git add src/components/ui/button.tsx`).
4. **Commiter** avec un message précis.
5. **Répéter** jusqu'à ce que la staging area soit vide.
6. **Verification** faire un dernier (`git status`) pour voir si le versioning est vide et bien complet

---

## 📝 Format du Message
Chaque commit doit suivre strictement ce format :

```text
<type>(scope): <sujet>

[Corps bien explicite mais pas trop longs juste long pour pour les moyens et gros changements]

[Footer]
```

#### 1️⃣ Types Autorisés
- `feat`: Nouvelle fonctionnalité (ajoute de la valeur utilisateur).
- `fix`: Correction de bug (répare quelque chose de cassé).
- `ui`: Changement purement visuel (CSS, style, assets) sans impact logique.
- `refactor`: Réécriture de code (ni fix ni feat, ex: nettoyage, simplification).
- `perf`: Amélioration des performances.
- `docs`: Documentation uniquement.
- `test`: Ajout ou modification de tests.
- `chore`: Maintenance, build, dépendances (pas de code de prod).
- `style`: Formatage, espaces manquants (pas de changement de logique).

#### 2️⃣ Scope (Portée)
Le fichier ou module impacté. Exemples : `(auth)`, `(ui)`, `(deps)`, `(api)`, `(hooks)`.

### 3️⃣ Sujet
- Impératif présent ("add" et non "added").
- Pas de majuscule au début.
- Pas de point à la fin.
- Clair et concis.

### Exemples de Bons Commits
✅ `feat(hooks): add use-media-query for responsive logic`
✅ `fix(ui): resolve typescript error in 3d-card component`
✅ `chore(deps): upgrade prisma to v7`

### Exemples à BANNIR ⛔
❌ `fix bugs` (Trop vague)
❌ `wip` (Interdit sur main/dev)
❌ `update files` (Ne veut rien dire)

