<div align="center">
  <br />
  <img src="./assets/wistant-logo.png" alt="Wistant Logo" width="160" />
  <h1>@wistantkode/dotfiles</h1>
  <p><b>Infrastructure-as-Code — System Protocols & Automated Synchronization</b></p>
  
  <p>
    <a href="https://www.npmjs.com/package/@wistantkode/dotfiles">
      <img src="https://img.shields.io/npm/v/@wistantkode/dotfiles?style=for-the-badge&color=CC0000&logo=npm" alt="npm version" />
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

## Infrastructure Architecture

This repository operates as an automated distribution system for personal Linux environments. It treats configuration as an engineering asset, governed by strict socratic and architectural protocols.

```mermaid
graph TD
    A[Local Machine] -- Atomic Commit --> B[GitHub Mirror]
    B -- Release Tag --> C[GitHub Actions]
    C -- Security Audit & Publish --> D[NPM Registry]
    E[Target Environment] -- npx installer --> D
    E -- Initialization --> F[Local .protocols/]
```

### System Components

- **Synchronization Module (`github.sh`)**: An interactive synchronizer performing Tag Delta audits and branch state verification before any remote projection.
- **Architectural Protocols**: Technical guides located in `.protocols/` that enforce atomic history and engineering integrity.
- **Automated Pipeline**: CI/CD workflows ensuring every public release is audited, secure, and distributed via NPM.

---

## Deployment

Deploy the infrastructure baseline on any Linux environment:

```bash
pnpm dlx @wistantkode/dotfiles
```

*Note: The installer manages the creation of local protocols and the staging of configuration templates.*

---

## Automation Suite

| Feature | Technical Logic | Operational Outcome |
| :--- | :--- | :--- |
| **Integrity Sync** | `github.sh` | Prevents remote projection without validated tag alignment. |
| **Atomic Commit** | `COMMIT.md` | Enforces a sequence of verifiable intentions over bulk commits. |
| **Technical Release** | `RELEASE.md` | Socratic validation of version increments (SemVer). |
| **System Installer** | `bin/cli.mjs` | Handles the secure deployment of configuration assets. |

---

## Engineering Standards

The project is governed by strict technical standards:

- **[RODIN.md](./protocols/RODIN.md)**: Socratic auditing and engineering philosophy.
- **[SECURITY.md](./protocols/SECURITY.md)**: Vulnerability management and secret scanning rules.
- **[INDEX](./protocols/_INDEX.md)**: Global registry for all system protocols.

---

## Licensing

Copyright © 2026 **Wistant**.  
Licensed under the **Apache License 2.0**. See the [LICENSE](./LICENSE) file for the full text.

---

<div align="center">
  <p>Repository maintained by <b>@wistantkode</b></p>
</div>
