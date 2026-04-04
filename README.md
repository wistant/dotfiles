# [@wistantkode/dotfiles](https://www.npmjs.com/package/@wistantkode/dotfiles)

<div align="center">
  <img src="./assets/wistant-logo.png" alt="Wistant Logo" width="120" />
  <h3>Modular Dotfiles & Architectural Protocols</h3>
  <p align="center">
    <img src="./assets/pnpm.svg" alt="pnpm" width="24" /> <b>pnpm</b> &nbsp; | &nbsp; 
    <img src="./assets/npm.svg" alt="npm" width="24" /> <b>npm</b> &nbsp; | &nbsp; 
    <img src="./assets/dotfiles.png" alt="dotfiles" width="24" /> <b>Linux</b> 
  </p>
</div>

---

## Overview

This repository provides a streamlined Linux environment setup based on high-end engineering standards. It focuses on **architectural integrity**, **atomic history**, and **automated distribution**.

### Key Features

- **Smart Installer**: Deploy the entire ecosystem via `npx @wistantkode/dotfiles`.
- **System Protocols**: Comprehensive guides for commits, releases, and security audits (`.protocols/`).
- **Interactive Sync**: A specialized `github.sh` script with Tag Delta detection and branch awareness.
- **CI/CD Driven**: Automated NPM publication via GitHub Actions on every official release.

---

## Quick Start

Deploy the environment on any machine:

```bash
pnpm dlx @wistantkode/dotfiles
```

*Note: The installer automatically creates hidden `.protocols/` and configuration files in your root.*

---

## Engineering Standards

Every interaction with this repository follows a strict socratic and architectural protocol:

- **[RODIN.md](./protocols/RODIN.md)**: Engineering philosophy and socratic auditing.
- **[COMMIT.md](./protocols/COMMIT.md)**: Strict atomic commit rules (Zero `git add .`).
- **[RELEASE.md](./protocols/RELEASE.md)**: Systematic versioning and distribution steps.

---

## Automation

### Local Synchronization
Use the smart sync script to audit your state before pushing:
```bash
./github.sh
```

### GitHub Actions
The distribution is handled by **GitHub Actions** (`.github/workflows/publish.yml`). It performs:
1. Integrity audits (`pnpm audit`).
2. Secret scanning.
3. Automated NPM publication upon GitHub Release tagging.

---

## License

Copyright 2026 Wistant.
Licensed under the **Apache License, Version 2.0**. See the [LICENSE](./LICENSE) file for details.
