import { DGRAY, RESET, GRAY, WHITE, GREEN, UI } from './constants.mjs';

export const _rep = (n, char = ' ') => char.repeat(Math.max(0, n));

export const sep = () => console.log(`${DGRAY}${_rep(UI.SEP_WIDTH, '─')}${RESET}`);

export const progress = async (label) => {
  process.stdout.write(`  ${GRAY}[${RESET}`);
  for (let i = 0; i < UI.PROGRESS_WIDTH; i++) {
    process.stdout.write(`${WHITE}#${RESET}`);
    await new Promise(r => setTimeout(r, 10));
  }
  process.stdout.write(`${GRAY}]${RESET}  ${GREEN}${label}${RESET}\n`);
};
