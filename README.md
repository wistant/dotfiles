<div align="center">
  <br />
  <img src="./assets/wistant-logo.png" alt="Wistant Logo" width="180" />
  <h1>@wistantkode/dotfiles</h1>
  <p><b>High-End Engineering Infrastructure & Socratic Protocols</b></p>
  
  <p>
    <a href="https://www.npmjs.com/package/@wistantkode/dotfiles">
      <img src="https://img.shields.io/npm/v/@wistantkode/dotfiles?style=for-the-badge&color=D12121&logo=npm" alt="npm version" />
    </a>
    <a href="https://pnpm.io">
      <img src="https://img.shields.io/badge/pnpm-4AB6FA?style=for-the-badge&logo=pnpm&logoColor=white" alt="pnpm" />
    </a>
    <a href="./LICENSE">
      <img src="https://img.shields.io/badge/License-Apache_2.0-F47023?style=for-the-badge" alt="License" />
    </a>
  </p>
</div>

---

## 🏛️ The Infrastructure Architecture

Contrary to standard dotfiles, this repository functions as an **Automated Distribution System**. It treats your configuration as **Infrastructure-as-Code**, governed by strict engineering standards.

```mermaid
graph TD
    A[Local Machine] -- Atomic Commit --> B[GitHub Mirror]
    B -- Release Tag --> C[GitHub Actions]
    C -- Security Audit & Publish --> D[NPM Registry]
    E[Target Environment] -- npx installer --> D
    E -- Initialization --> F[Local .protocols/]
```

### Core Components

- **Smart Oracle (`github.sh`)**: An interactive synchronizer that performs a "Tag Delta" audit before any projection to GitHub.
- **Integrity Protocols**: A set of hidden guides (`.protocols/`) that force the AI and the user to maintain a pure, atomic history.
- **CI/CD Pipeline**: fully automated distribution workflow ensuring every public version is audited and secure.

---

## 🚀 Instant Deployment

Deploy your professional baseline on any Linux environment without cloning:

```bash
pnpm dlx @wistantkode/dotfiles
```

---

## 🛠️ The Intelligence Suite

| Feature | Logic | Outcome |
| :--- | :--- | :--- |
| **Interactive Sync** | `github.sh` | Prevents pushing to production without sealed tags or pure history. |
| **Atomic Commitment** | `COMMIT.md` | Forces a sequence of small, verifiable intentions over "everything" commits. |
| **Socratic Release** | `RELEASE.md` | A structured dialogue to justify Major/Minor/Patch increments. |
| **Integrity Audit** | `bin/cli.mjs` | Transparently handles the transformation of files during installation. |

---

## 📜 Professional Standards

The system is powered by the **Rodin Engineering Philosophy** :

- **[RODIN.md](./protocols/RODIN.md)** : The philosophical anchor (Anti-compliancy, Socratic auditing).
- **[SECURITY.md](./protocols/SECURITY.md)** : Vulnerability management and secret scanning.
- **[INDEX](./protocols/_INDEX.md)** : Navigation across all architectural protocols.

---

## ⚖️ Licensing & Legal

Copyright © 2026 **Wistant**.  
Everything in this repository is licensed under the **Apache License 2.0**.

---

<div align="center">
  <p>Engineered for <img src="./assets/dotfiles.png" width="16" /> with <b>@wistantkode</b></p>
</div>
