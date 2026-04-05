# Contributing to Dotfiles Infrastructure

This repository is governed by strict **Architectural Validation**. To maintain technical excellence, every contribution must align with our core engineering baseline. Precision and structural integrity are non-negotiable.

---

## ⚡ Technical Pillars

### 1. Atomic Integrity

We maintain a linear, pure history. PRs must represent a single, isolated logical intention.

- **Manual Staging**: The use of `git add .` is prohibited. Every staging must be targeted (`git add <file>`).
- **No Hybrid Commits**: Do not mix refactoring (`refactor`) with functional additions (`feat`) in the same commit.
- **Separation of Powers**: Release manifests (`package.json`, `CHANGELOG.md`) and Git Tags are strictly reserved for the **Release Protocol**. They must never be part of a standard code commit.

### 2. Architectural Governance

Your interaction with the codebase is a technical review, not a service.

- **Critical Assessment**: Contributors (Human or AI) must provide technical justification for every change. Blind validation is a protocol failure.
- **Zero-Initiative**: Decision-making is limited to the explicit scope of the requested task. Unauthorized modification of non-cited components is forbidden.
- **Impact-Based SemVer**: Versioning must be mathematically justified by the code impact analyzed during the release phase.

### 3. AI-Pairing Standards

We recognize AI as a technical peer. Contributions co-authored by an agent must:

- Maintain a direct, technical, and objective tone.
- Be verified by the **Architect (Human)** at every execution gate.
- **The Verification Barrier**: The agent must prompt for human confirmation of the versioning logic before final execution.

---

## Development Lifecycle

### Phase 1: Code Implementation

Follow the **Commit Convention**. Use strict prefixes (`feat`, `fix`, `refactor`, `style`, `ui`, `docs`).

### Phase 2: Infrastructure Deployment

Deployment follows the **Architectural Release** flow. Every release must be sealed with a unique identifier: `vX.Y.Z - [MOTTO]`.

---

## 👥 Maintenance

Managed by **Wistant** — Lead Architect.

---
