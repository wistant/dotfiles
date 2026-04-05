#!/usr/bin/env node

/**
 * ═══════════════════════════════════════════════════════════════════════
 *   DOTFILES INSTALLER  ·  Elite Orchestration  ·  @wistantkode/dotfiles
 * ════════════════════════════════════════───────────────────────════════
 */

import { copyFile, mkdir, readdir, lstat } from 'node:fs/promises';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createInterface } from 'node:readline/promises';

// ── UI Configuration (256-color) ──────────────────────────────────────
const RESET    = '\x1b[0m';
const BOLD     = '\x1b[1m';
const DIM      = '\x1b[2m';
const CYAN     = '\x1b[38;5;117m';
const GREEN    = '\x1b[38;5;114m';
const YELLOW   = '\x1b[38;5;221m';
const RED      = '\x1b[38;5;203m';
const GRAY     = '\x1b[38;5;244m';
const WHITE    = '\x1b[38;5;255m';
const DGRAY    = '\x1b[38;5;238m';
const BLUE     = '\x1b[38;5;75m';

const __dirname = dirname(fileURLToPath(import.meta.url));
const pkgRoot = join(__dirname, '..');

// ── Layout Components ─────────────────────────────────────────────────

const _rep = (n, char = ' ') => char.repeat(Math.max(0, n));
const sep = () => console.log(`${DGRAY}${_rep(64, '─')}${RESET}`);

const renderLogo = () => {
  // Ultra-High-Fidelity "Full Block" Style
  console.log(`\n  ${CYAN}██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗`);
  console.log(`  ${CYAN}██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝`);
  console.log(`  ${CYAN}██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗`);
  console.log(`  ${CYAN}██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║`);
  console.log(`  ${CYAN}██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║`);
  console.log(`  ${CYAN}╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝${RESET}`);
  console.log(`\n  ${GRAY}${BOLD}[ PRECISION AI ORCHESTRATION ]${RESET}\n`);
};

const progress = async (label) => {
  process.stdout.write(`  ${GRAY}[${RESET}`);
  for (let i = 0; i < 28; i++) {
    process.stdout.write(`${CYAN}█${RESET}`);
    await new Promise(r => setTimeout(r, 10));
  }
  process.stdout.write(`${GRAY}]${RESET}  ${GREEN}${label}${RESET}\n`);
};

const renderSignature = () => {
  const width = 44;
  const stripAnsi = (str) => str.replace(/\x1b\[[0-9;]*m/g, '');
  const pad = (text, len) => text + _rep(len - stripAnsi(text).length);

  console.log(`\n  ${WHITE}${BOLD}SOURCE & AUTHORSHIP${RESET}`);
  console.log(`  ${DGRAY}┌${_rep(width, '──')}┐${RESET}`);
  
  const label = (txt, col) => `${col}${BOLD}${txt}${RESET}`;

  console.log(`  ${DGRAY}│${RESET}  ${pad(`${label('REPOSITORY', BLUE)}  ${BOLD}https://github.com/wistant/dotfiles${RESET}`, width + 17)} ${DGRAY}│${RESET}`);
  console.log(`  ${DGRAY}├${_rep(width, '──')}┤${RESET}`);
  console.log(`  ${DGRAY}│${RESET}  ${pad(`${label('ARCHITECT ', WHITE)}  ${BOLD}Wistant${RESET} ${GRAY}(DevOps Architect)${RESET}`, width + 28)} ${DGRAY}│${RESET}`);
  console.log(`  ${DGRAY}│${RESET}  ${pad(`${label('GITHUB    ', BLUE)}  ${GRAY}https://github.com/wistant${RESET}`, width + 26)} ${DGRAY}│${RESET}`);
  console.log(`  ${DGRAY}└${_rep(width, '──')}┘${RESET}\n`);
};

// ── Interactive Logic ─────────────────────────────────────────────────

const rl = createInterface({
  input: process.stdin,
  output: process.stdout
});

const ask = async (question, defaultYes = true) => {
  const options = defaultYes ? ' (Y/n)' : ' (y/N)';
  const answer = await rl.question(`  ${YELLOW}${BOLD}?${RESET}  ${question}${GRAY}${options}${RESET}  `);
  if (!answer) return defaultYes;
  return answer.toLowerCase().startsWith('y');
};

async function checkDirectory(dir) {
  try {
    const files = await readdir(dir);
    // Ignore common development/system noise
    const filtered = files.filter(f => !['.git', 'node_modules', '.DS_Store', 'package-lock.json', 'pnpm-lock.yaml'].includes(f));
    return filtered.length > 0;
  } catch {
    return false;
  }
}

// ── Core Engine ───────────────────────────────────────────────────────

async function copyRecursive(src, dest, onFile) {
  const stat = await lstat(src);
  if (stat.isDirectory()) {
    await mkdir(dest, { recursive: true });
    const children = await readdir(src);
    for (const child of children) {
      await copyRecursive(join(src, child), join(dest, child), onFile);
    }
  } else {
    await copyFile(src, dest);
    if (onFile) onFile(dest);
  }
}

async function run() {
  process.stdout.write('\x1Bc'); // Clear screen
  renderLogo();
  sep();

  const targetDir = process.cwd();
  console.log(`\n  ${GRAY}System Target:${RESET}  ${WHITE}${BOLD}${targetDir}${RESET}`);
  
  // Phase 1: Directory Audit
  if (await checkDirectory(targetDir)) {
    console.log(`  ${YELLOW}${BOLD}⚠  TARGET DIRECTORY IS NOT EMPTY${RESET}`);
    const proceed = await ask('Deployment may overwrite existing files. Proceed?', false);
    if (!proceed) {
      console.log(`\n  ${RED}Deployment cancelled by user.${RESET}\n`);
      rl.close();
      return;
    }
  }

  // Phase 2: Protocol Selection
  let protocolDest = '.protocols';
  console.log(`\n  ${CYAN}${BOLD}i  GOVERNANCE PLACEMENT${RESET}`);
  const useDotDir = await ask('Deploy protocols to .protocols/ folder? (Recommended)', true);
  if (!useDotDir) {
    protocolDest = 'protocols';
    console.log(`  ${DIM}Protocols will be deployed to the root 'protocols/' directory.${RESET}`);
  }

  const ASSETS = [
    { src: 'gitignore', dest: '.gitignore', label: 'Ignore patterns' },
    { src: 'LICENSE', dest: 'LICENSE', label: 'License' },
    { src: 'protocols', dest: protocolDest, label: 'Governance protocols', isDir: true }
  ];

  sep();
  console.log(`\n  ${BOLD}▶  Ready to initiate deployment sequence...${RESET}`);
  const confirm = await ask('Apply changes to your system?', true);
  if (!confirm) {
    console.log(`\n  ${RED}Deployment aborted.${RESET}\n`);
    rl.close();
    return;
  }

  console.log('');
  await progress('Validating package integrity');

  const deployedFiles = [];

  for (const asset of ASSETS) {
    try {
      const srcPath = join(pkgRoot, asset.src);
      const destPath = join(targetDir, asset.dest);
      
      if (asset.isDir) {
        await copyRecursive(srcPath, destPath, (f) => {
           deployedFiles.push(f.replace(targetDir, ''));
        });
      } else {
        await copyFile(srcPath, destPath);
        deployedFiles.push('/' + asset.dest);
      }
    } catch (err) {
      console.error(`      ${RED}✘${RESET}  Failed to deploy ${asset.src}: ${err.message}`);
    }
  }

  await progress('Finalizing system orchestration');

  // Detailed Audit Logs
  console.log(`\n  ${BOLD}DEPLOYMENT AUDIT${RESET}`);
  console.log(`  ${DGRAY}${_rep(45, '─')}${RESET}`);
  for (const file of deployedFiles.sort()) {
    console.log(`    ${GREEN}✔${RESET}  ${GRAY}${file}${RESET}`);
  }
  console.log(`  ${DGRAY}${_rep(45, '─')}${RESET}`);

  console.log(`\n  ${GREEN}${BOLD}✔  INFRASTRUCTURE DEPLOYED SUCCESSFULLY.${RESET}`);
  console.log(`  ${GRAY}Your environment is now optimized for professional AI pairing.${RESET}`);

  renderSignature();
  
  console.log(`  ${DIM}Thank you for choosing high-end architectural standards.${RESET}\n`);
  sep();
  console.log('');
  
  rl.close();
}

run().catch(err => {
  console.error(`\n  ${RED}${BOLD}✗  FATAL ERROR${RESET}  ${err.message}\n`);
  if (rl) rl.close();
  process.exit(1);
});
