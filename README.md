<div align="center">
  <img src="./assets/wistant-logo.png" alt="Wistant Logo" width="160" />
  <h1>@wistantkode/dotfiles</h1>
  <p><b>Architecture Above Configuration — Professional Engineering Environment</b></p>
  
  <p>
    <img src="https://img.shields.io/npm/v/@wistantkode/dotfiles?style=flat-square&color=CB0000" alt="npm version" />
    <img src="https://img.shields.io/badge/pnpm-6AD7E5?style=flat-square&logo=pnpm&logoColor=white" alt="pnpm" />
    <img src="https://img.shields.io/badge/License-Apache_2.0-blue?style=flat-square" alt="License" />
    <img src="https://img.shields.io/badge/OS-Linux-E95420?style=flat-square&logo=ubuntu&logoColor=white" alt="Linux" />
  </p>
</div>

---

## 🏛️ The Engineering Philosophy

This is not a traditional "dotfiles" repository. It is a **Self-Documenting Infrastructure** designed for high-end software development. It enforces **Architectural Integrity** through local protocols and automated guardrails.

### Why this is different:
- **Protocol-Driven**: Every action (Commit, Release, Refactor) is guided by a local `.protocols/` library.
- **Atomic History**: Zero-entropy git history enforced by the **Integrity Audit** (`github.sh`).
- **NPM Integration**: Distribute your entire environment globally via `pnpm` or `npm`.
- **Smart Synchronization**: Branch-aware and Tag-aware sync scripts that prevent data loss and versioning errors.

---

## 🚀 Quick Deployment

Instantiate your professional environment in seconds on any Linux machine:

```bash
pnpm dlx @wistantkode/dotfiles
```

> [!TIP]
> This command will safely inject the `.protocols/` directory and necessary configuration templates into your current working directory without overwriting existing critical files.

---

## 🛠️ The Tooling Suite

### 1. Smart Oracle Sync (`./github.sh`)
An interactive Git wrapper that acts as a technical advisor.
- **Branch Detection**: Contextual warnings for `main`, `dev`, and `feat/` branches.
- **Tag Delta Detection**: Compares local and remote tags to ensure release alignment.
- **Atomic Guardrail**: Blocks pushes if the history is not "pure" (uncommitted changes).

### 2. GitHub Actions CI/CD
The distribution is handled by **GitHub Actions** (`.github/workflows/publish.yml`).
- **Automated Releasing**: Every GitHub Release triggers an npm publication.
- **Security Audits**: Mandatory `pnpm audit` and secret scanning are performed on every build.

---

## 📜 Standards & Protocols

Documentation is code. The system is governed by:

| Protocol | Purpose |
| :--- | :--- |
| **[RODIN.md](./protocols/RODIN.md)** | Socratic auditing and engineering philosophy. |
| **[COMMIT.md](./protocols/COMMIT.md)** | Rules for atomic, intention-based committing. |
| **[RELEASE.md](./protocols/RELEASE.md)** | Systematic versioning logic (Phase 1-4). |
| **[SECURITY.md](./protocols/SECURITY.md)** | Security audits and vulnerability management. |

---

## ⚖️ License

Copyright © 2026 **Wistant**.  
Distributed under the **Apache License 2.0**. See the [LICENSE](./LICENSE) file for the full legal text.

---

<div align="center">
  <p>Built with <img src="./assets/pnpm.svg" alt="pnpm" width="16" /> and <img src="./assets/npm.svg" alt="npm" width="16" /> for <b>@wistantkode</b></p>
</div>
