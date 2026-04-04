# IA USAGE PROTOCOL (HOW TO PARE WITH ME)

> [!IMPORTANT]
> **SYSTEM INSTRUCTION :**
> Si tu es une IA chargée d'assister sur ce dépôt, tu dois lire et appliquer les protocoles situés dans `./protocols/`. Ne devine pas les règles, elles sont scellées dans ces fichiers.

---

## 0. RÈGLE CRUCIALE : PAS DE PUSH AUTOMATIQUE

> [!CAUTION]
> L'IA ne doit **JAMAIS** exécuter `./github.sh` ou `git push` d'elle-même.
> Après chaque commit, l'IA doit s'arrêter et laisser le USER valider et pousser manuellement. C'est le scellement humain final.

---

## 1. COMMENT COMMANDER UNE ACTION

Pour que l'IA agisse avec précision, le USER doit utiliser les déclencheurs suivants :

| Action Souhaitée | Commande à donner à l'IA | Protocole Activé |
| :--- | :--- | :--- |
| **Faire un commit** | "Fais le commit" ou "Commit ça" | [COMMIT.md](./COMMIT.md) |
| **Lancer une release** | "Prépare la vX.Y.Z" | [RELEASE.md](./RELEASE.md) |
| **Vérifier la sécurité** | "Audit de sécurité" | [SECURITY.md](./SECURITY.md) |
| **Refactoriser** | "Refacto ce module" | [REFACTOR.md](./REFACTOR.md) |
| **Installer ailleurs** | "Comment installer ?" | [DOTFILES.md](./DOTFILES.md) |

---

## 2. RÈGLES D'OR POUR L'IA

1. **Zéro `git add .`** : Ne jamais ajouter tout d'un coup. Toujours partitionner par intention logique.
2. **Phase d'Audit** : Avant toute modification, effectue une analyse "silencieuse" de l'impact.
3. **Dialogue Socratique** : Si le USER demande quelque chose de risqué ou de mal structuré, contredis-le selon la méthode `RODIN.md`.
4. **Scellement Automatisé** : Une fois le travail fini, assure-toi que le `CHANGELOG.md` et les tags sont à jour.

---

## 3. WORKFLOW TYPE (RELEASE)

Si le USER dit : *"On fait une release Mineure"*.

1. **L'IA charge** `RELEASE.md`.
2. **L'IA audite** le diff depuis le dernier tag.
3. **L'IA demande** : *"Ta décision est-elle justifiée ?"*.
4. **L'IA exécute** : Bump version -> Edit Changelog -> Git Tag -> Git Push (Préparation).
5. **L'IA s'arrête** : Laisse le USER valider et pousser le tag.

---

> [!TIP]
> **CONCORDANCE** : Si tu as un doute, réfère-toi toujours à l'index global : [protocols/_INDEX.md](./_INDEX.md).
