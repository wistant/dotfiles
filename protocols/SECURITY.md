# Elite Security & Audit Protocol

Protocole critique pour maintenir l'intégrité "Zero-Token" et la confidentialité du projet.

## 1. Secret Scanning (Pre-Commit)
L'IA doit vérifier chaque buffer de code pour :
- Clés API AWS/Google/GitHub.
- Tokens OAuth, Mots de passe, Clés privées.
- Chemins absolus ou noms de machines internes.

## 2. Dependency Integrity
- Audit périodique via `pnpm audit` ou alors la commande appropriee en fonction du package manager ou du projet.
- Mise à jour sélective des packages critiques (NestJS, Prisma, Next.js, nodejs, bun et tout l'ensemble de packets necessaires).
- Vérification des CVE (Common Vulnerabilities and Exposures).

## 3. Handshake Validation
- Vérification du code de signature HMAC.
- Audit de la logique d'isolation multi-tenant dans Prisma.

---
*Note : Toute faille potentielle détectée doit faire l'objet d'un rapport immédiat au USER avant tout commit.*
