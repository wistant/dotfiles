#!/usr/bin/env node

import { copyFile, mkdir, readdir, lstat } from 'node:fs/promises';
import { join, dirname, basename } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const pkgRoot = join(__dirname, '..');

const FILES_TO_INSTALL = [
  '.gitignore',
  'aliases.sh',
  'aliases.zsh',
  'gitmessage',
  'myKDEshorcuts.kksrc'
];

const DIRECTORIES_TO_INSTALL = [
  'protocols'
];

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
  console.log('\x1b[36m%s\x1b[0m', '--- Wistant Dotfiles Installer ---');
  
  const targetDir = process.cwd();
  console.log(`Installing dotfiles to: ${targetDir}`);

  for (const file of FILES_TO_INSTALL) {
    try {
      await copyFile(join(pkgRoot, file), join(targetDir, file));
      console.log(`  [OK] ${file}`);
    } catch (err) {
      console.error(`  [ERROR] Failed to copy ${file}: ${err.message}`);
    }
  }

  for (const dir of DIRECTORIES_TO_INSTALL) {
    try {
      await copyRecursive(join(pkgRoot, dir), join(targetDir, dir));
      console.log(`  [OK] ${dir}/`);
    } catch (err) {
      console.error(`  [ERROR] Failed to copy ${dir}: ${err.message}`);
    }
  }

  console.log('\x1b[32m%s\x1b[0m', '\nDone! Elite dotfiles and protocols added.');
  console.log('To load aliases, source the aliases.sh/zsh file in your shell config.');
}

run().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
