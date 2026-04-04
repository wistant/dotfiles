# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2026-04-04 - [Automation & Security Ascent]

### Added

- **GitHub Actions Integration**: Created `publish.yml` for automated pnpm-based distribution on GitHub Release.
- **Zero-Trust Security Phase**: Integrated mandatory `pnpm audit` and **Secret Scanning** into the release protocol.
- **Rodin Personalization**: Automation scripts (`pnpm.sh`, `github.sh`) now follow the Socratic and professional Rodin philosophy.
- **Lockfile Enforcement**: Added `pnpm-lock.yaml` to guarantee dependency integrity in all environments.

### Changed

- **NPM Distribution Logic**: Replaced manual `npm publish` with a self-destructing `npm_config_` environment variable injection for tokens.
- **System Protocol Header**: Modernized CLI aesthetics for better clarity and professionalism.

## [1.0.0] - 2026-04-04 - [Foundation Ignition]

### Breaking Changes

- Reorganized entire repository structure for npm compatibility.
- Moved dotfiles to root and renamed `gitignore` to `gitignore` (template).
- Protocols moved to `protocols/` (installed as `.protocols/`).

### Initial Features

- Added `bin/cli.mjs` for automated installation via `npx`.
- Added `pnpm.sh` and `github.sh` for streamlined dev workflow.
- Standardized `package.json` under `@wistantkode/dotfiles` scope.

### Fixed

- Updated aliases to support the hidden `.protocols/` path.
- Refined `.gitignore` for the repository.
