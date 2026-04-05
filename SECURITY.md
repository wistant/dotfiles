# Security Policy

This repository follows a **Zero-Trust** security model. We prioritize the integrity of the infrastructure and the protection of sensitive architectural data.

## Supported Versions

We only provide security updates for the current major version.

| Version | Supported          |
| ------- | ------------------ |
| v1.x    | :white_check_mark: |
| < v1.0  | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability, please do NOT open a public issue. We take security seriously and prefer a coordinated disclosure.

Please report vulnerabilities directly to the maintainer:
- **Contact**: [@wistant](https://github.com/wistant)
- **Encryption**: If possible, encrypt your report using a secure channel.

## Our Security Principles

### 1. Silent Guardian Audit
Every interaction with the codebase (commits, refactors, releases) triggers a scan for:
- Exposed secrets (tokens, API keys, private keys).
- Context leaks (internal paths, IPs, machine names).
- Insecure API logic or missing sanitization.

### 2. Dependency Integrity
We use strictly audited dependencies. 
- All packages are scanned via `pnpm audit`.
- Critical CVEs in core libraries results in an immediate suspension of the release flow until resolved.

### 3. Isolation by Design
Sensitive configuration files and release manifests are strictly isolated from the standard development cycle to prevent accidental leakage.

---
**Architectural Integrity • Security First • @wistant dotfiles baseline**
