#!/usr/bin/env node

// DOTFILES INSTALLER  ·  Elite Orchestration  ·  @wistantkode/dotfiles

import { copyFile, mkdir, readdir, lstat } from 'node:fs/promises';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createInterface } from 'node:readline/promises';
import { renderLogo } from './renderlogo.mjs';
import { renderSignature } from './renderSignature.mjs';
import { sep, progress } from './ui.mjs';
import { ask, checkDirectory, copyRecursive } from './engine.mjs';
import { getAssets } from './assets.mjs';
import { 
  RED, GREEN, YELLOW, CYAN, GRAY, WHITE, DIM, BOLD, RESET, ICONS, DGRAY
} from './constants.mjs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const pkgRoot = join(__dirname, '..');

const rl = createInterface({
  input: process.stdin,
  output: process.stdout
});

async function run() {
  process.stdout.write('\x1Bc'); // Clear screen
  renderLogo();
  sep();

  const targetDir = process.cwd();
  console.log(`\n  ${GRAY}System Target:${RESET}  ${WHITE}${BOLD}${targetDir}${RESET}`);
  
  const proceedTarget = await ask(rl, 'Initiate deployment in this directory?', true);
  if (!proceedTarget) {
    console.log(`\n  ${RED}Deployment cancelled by user.${RESET}\n`);
    rl.close();
    return;
  }

  // Phase 1: Directory Audit
  const isEmpty = !(await checkDirectory(targetDir));
  if (isEmpty) {
    console.log(`  ${GREEN}${BOLD}${ICONS.CLEAN}  TARGET DIRECTORY IS CLEAN${RESET}`);
  } else {
    console.log(`  ${YELLOW}${BOLD}${ICONS.WARN}  TARGET DIRECTORY IS NOT EMPTY${RESET}`);
    const proceed = await ask(rl, 'Deployment may overwrite existing files. Force installation ?', false);
    if (!proceed) {
      console.log(`\n  ${RED}${ICONS.CANCEL} Deployment cancelled by user.${RESET}\n`);
      rl.close();
      return;
    }
  }

  // Phase 2: Protocol Selection
  let protocolDest = '.protocols';
  console.log(`\n  ${CYAN}${BOLD}${ICONS.INFO}  GOVERNANCE PLACEMENT${RESET}`);
  const useDotDir = await ask(rl, 'Deploy protocols to .protocols/ folder? (Recommended)', true);
  if (!useDotDir) {
    protocolDest = 'protocols';
    console.log(`  ${DIM}Protocols will be deployed to 'protocols/' (No recommanded mode).${RESET}`);
  } else {
    console.log(`  ${DIM}Protocols will be deployed to '.protocols/' (Standard & recommended).${RESET}`);
  }

  const ASSETS = getAssets(protocolDest);

  sep();
  console.log(`\n  ${BOLD}${ICONS.PLAY}  Ready to initiate deployment sequence...${RESET}`);
  const confirm = await ask(rl, 'Apply changes to your system?', true);
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
      console.error(`      ${RED}${ICONS.ERROR}${RESET}  Failed to deploy ${asset.src}: ${err.message}`);
    }
  }

  await progress('Finalizing system orchestration...');

  // Detailed Audit Logs
  const _rep = (n, char = ' ') => char.repeat(Math.max(0, n));
  console.log(`\n  ${BOLD}DEPLOYMENT AUDIT${RESET}`);
  console.log(`  ${DGRAY}${_rep(45, '─')}${RESET}`);
  for (const file of deployedFiles.sort()) {
    console.log(`    ${GREEN}${ICONS.CHECK}${RESET}  ${GRAY}${file}${RESET}`);
  }
  console.log(`  ${DGRAY}${_rep(45, '─')}${RESET}`);

  console.log(`\n  ${GREEN}${BOLD}${ICONS.SUCCESS}  INFRASTRUCTURE DEPLOYED SUCCESSFULLY.${RESET}`);
  console.log(`  ${GRAY}Your environment is now optimized for professional AI pairing developpement.${RESET}`);

  renderSignature();
  
  console.log(`  ${DIM}${ICONS.THANKS} Thank you for choosing high-end architectural standards.${RESET}\n`);
  sep();
  console.log('');
  
  rl.close();
}

run().catch(err => {
  console.error(`\n  ${RED}${BOLD}✗  FATAL ERROR${RESET}  ${err.message}\n`);
  if (rl) rl.close();
  process.exit(1);
});
