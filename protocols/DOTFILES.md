# DOTFILES & ENVIRONMENT PROTOCOL (DOTFILES.md)

> [!IMPORTANT]
> **Activation de l'Agent :**
> Lors de la maintenance ou de l'expansion de ta configuration système, tu actives le **System Integrity Audit**. Ta mission est de garantir que tes outils ne sont pas seulement des gadgets, mais des extensions directes de tes protocoles d'ingénierie.

---

## SYNC : LE SYSTÈME D'EXPLOITATION SOCRATIQUE

Tes dotfiles doivent refléter la hiérarchie définie dans `ASSIST.md`. Un environnement "parfait" est un environnement qui **force** la réflexion avant l'action.

### 1. Aliases de Navigation & Audit (Zsh/Bash)

- **`ra`** (Rodin Assist) : `cat protocols/ASSIST.md`
- **`ri`** (Rodin Index) : `cat protocols/_INDEX.md`
- **`rc`** (Rodin Commit) : Avant tout commit, affiche `COMMIT.md`.
- **`rs`** (Rodin Security) : Script automatique `pnpm audit` + scan de secrets.

### 2. Git Automation (Elite Config)

- **Commit Template** : Utilise un fichier `.gitmessage` global qui force le format atomique.
- **Git Alias `git elite`** : Un log formaté et compact pour visualiser l'histoire architecturale.

### 3. Shell Hooks & Installer

- **Installer `npx @wistantkode/dotfiles`** : Le point d'entrée unique pour déployer l'environnement sur une nouvelle machine.
- **Hook `chpwd`** : Exécute silencieusement la Phase 1 de `INIT.md` dès que tu entres dans un projet.
- **Alerte `git status`** : Affiche un avertissement si le staging contient plus de 10 fichiers (suspicion de commit non-atomique).

---

## ESTHÉTIQUE "CYBER-PREMIUM"

L'interface doit être une source d'inspiration, pas une distraction.

- **Prompt** : Starship. Intègre un symbole minimaliste pour l'état du "Rodin Audit".
- **Multiplexeur** : Zellij. Utilise des layouts qui ouvrent toujours `ASSIST.md` dans un panneau latéral.
- **Typographie** : JetBrains Mono ou Victor Mono (avec ligatures pour la lisibilité du code).

---

## CHECKLIST DE PERFECTION

- [ ] Mes protocoles sont accessibles en une touche.
- [ ] Mon prompt me prévient si je dévie de l'atomicité.
- [ ] Mon setup est reproductible (`install.sh` ou `stow`).
- [ ] Ma configuration Git m'interdit les messages de commit médiocres.

---

> [!CAUTION]
> Un outil que tu ne comprends pas est une faille. La "perfection" n'est pas d'ajouter des fonctions, mais de retirer ce qui est inutile.
