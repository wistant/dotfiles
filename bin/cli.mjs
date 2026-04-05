#!/usr/bin/env node

import { copyFile, mkdir, readdir, lstat } from 'node:fs/promises';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

// ── UI Configuration (256-color) ──────────────────────────────────────
const RESET  = '\x1b[0m';
const BOLD   = '\x1b[1m';
const DIM    = '\x1b[2m';
const CYAN   = '\x1b[38;5;117m';
const GREEN  = '\x1b[38;5;114m';
const YELLOW = '\x1b[38;5;221m';
const RED    = '\x1b[38;5;203m';
const GRAY   = '\x1b[38;5;244m';
const WHITE  = '\x1b[38;5;255m';
const DGRAY  = '\x1b[38;5;238m';

const __dirname = dirname(fileURLToPath(import.meta.url));
const pkgRoot = join(__dirname, '..');

const FILES_TO_INSTALL = [
  'gitignore',
  'LICENSE'
];

const DIRECTORIES_TO_INSTALL = [
  'protocols'
];

// ── Utilities ─────────────────────────────────────────────────────────

const sep = () => console.log(`${DGRAY}${'─'.repeat(60)}${RESET}`);

const progress = async (label) => {
  process.stdout.write(`  ${GRAY}[${RESET}`);
  for (let i = 0; i < 24; i++) {
    process.stdout.write(`${CYAN}█${RESET}`);
    await new Promise(r => setTimeout(r, 15));
  }
  process.stdout.write(`${GRAY}]${RESET}  ${GREEN}${label}${RESET}\n`);
};

async function copyRecursive(src, dest) {
  const stat = await lstat(src);
  if (stat.isDirectory()) {
    await mkdir(dest, { recursive: true });
    const children = await readdir(src);
    for (const child of children) {
      await copyRecursive(join(src, child), join(dest, child));
    }
  } else {
    await copyFile(src, dest);
  }
}

async function run() {
  console.clear();
  console.log(`\n  ${WHITE}${BOLD}◆  DOTFILES INSTALLER${RESET}  ${DGRAY}·  @wistantkode/dotfiles${RESET}\n`);
  sep();

  const targetDir = process.cwd();
  console.log(`\n  ${GRAY}Target Directory:${RESET}  ${CYAN}${BOLD}${targetDir}${RESET}\n`);
  
  sep();
  console.log(`\n  ${BOLD}▶  Initiating deployment...${RESET}\n`);

  await progress('Verifying package integrity...');
  
  // Files deployment
  for (const file of FILES_TO_INSTALL) {
    try {
      const destName = file === 'gitignore' ? '.gitignore' : file;
      await copyFile(join(pkgRoot, file), join(targetDir, destName));
      console.log(`      ${GREEN}✔${RESET}  Deployed ${BOLD}${destName}${RESET}`);
    } catch (err) {
      console.error(`      ${RED}✘${RESET}  Failed to deploy ${file}: ${err.message}`);
    }
  }

  // Directories deployment
  for (const dir of DIRECTORIES_TO_INSTALL) {
    try {
      const destName = dir === 'protocols' ? '.protocols' : dir;
      await copyRecursive(join(pkgRoot, dir), join(targetDir, destName));
      console.log(`      ${GREEN}✔${RESET}  Deployed ${BOLD}${destName}/${RESET}`);
    } catch (err) {
      console.error(`      ${RED}✘${RESET}  Failed to deploy ${dir}: ${err.message}`);
    }
  }

  await progress('Finalizing configuration...');

  console.log(`\n  ${GREEN}${BOLD}✔  SUCCESS${RESET}  Infrastructure deployed successfully.`);
  console.log(`  ${GRAY}Your environment is now orchestrated by @wistantkode protocols.${RESET}\n`);
  sep();
  console.log('');
}

run().catch(err => {
  console.error(`\n  ${RED}${BOLD}✗  FATAL ERROR${RESET}  ${err.message}\n`);
  process.exit(1);
});
