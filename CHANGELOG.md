# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-04-04 - [Foundation Ignition]

### Breaking Changes

- Reorganized entire repository structure for npm compatibility.
- Moved dotfiles to root and renamed `gitignore` to `gitignore` (template).
- Protocols moved to `protocols/` (to be installed as `.protocols/`).

### Fonctionnalités

- Added `bin/cli.mjs` for automated installation via `npx`.
- Added `pnpm.sh` and `github.sh` for streamlined dev workflow.
- Standardized `package.json` under `@wistantkode/dotfiles` scope.

### Corrections & Refactoring

- Updated aliases to support the hidden `.protocols/` path.
- Refined `.gitignore` for the repository.
