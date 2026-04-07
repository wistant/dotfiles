import { readdir, lstat, mkdir, copyFile } from 'node:fs/promises';
import { join } from 'node:path';
import { YELLOW, BOLD, RESET, GRAY, WHITE } from './constants.mjs';

export async function ask(rl, question, defaultYes = true) {
  const options = defaultYes ? ' (Y/n)' : ' (y/N)';
  const answer = await rl.question(`  ${YELLOW}${BOLD}?${RESET}  ${question}${GRAY}${options}${RESET}  `);
  if (!answer) return defaultYes;
  return answer.toLowerCase().startsWith('y');
}

export async function checkDirectory(dir) {
  try {
    const files = await readdir(dir);
    const filtered = files.filter(f => !['.git', 'node_modules', '.DS_Store', 'package-lock.json', 'pnpm-lock.yaml'].includes(f));
    return filtered.length > 0;
  } catch {
    return false;
  }
}

export async function copyRecursive(src, dest, onFile) {
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
