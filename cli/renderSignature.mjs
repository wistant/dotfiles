import { WHITE, BOLD, RESET, DGRAY, BLUE, GRAY, UI } from './constants.mjs';
import { _rep } from './ui.mjs';

export const renderSignature = () => {
  const width = UI.SIG_WIDTH;
  const stripAnsi = (str) => str.replace(/\x1b\[[0-9;]*m/g, '');
  const pad = (text, len) => text + _rep(len - stripAnsi(text).length);

  console.log(`\n  ${WHITE}${BOLD}SOURCE & AUTHORSHIP${RESET}`);
  console.log(`  ${DGRAY}┌${_rep(width, '──')}┐${RESET}`);
  
  const label = (txt, col) => `${col}${BOLD}${txt}${RESET}`;

  console.log(`  ${DGRAY}│${RESET}  ${pad(`${label('REPOSITORY', BLUE)}  ${BOLD}https://github.com/wistant/dotfiles${RESET}`, width + 17)} ${DGRAY}│${RESET}`);
  console.log(`  ${DGRAY}├${_rep(width, '──')}┤${RESET}`);
  console.log(`  ${DGRAY}│${RESET}  ${pad(`${label('AUTOR ', WHITE)}  ${BOLD}Wistant${RESET} ${GRAY}(Opensource Advocate)${RESET}`, width + 28)} ${DGRAY}│${RESET}`);
  console.log(`  ${DGRAY}│${RESET}  ${pad(`${label('GITHUB    ', BLUE)}  ${GRAY}https://github.com/wistant${RESET}`, width + 26)} ${DGRAY}│${RESET}`);
  console.log(`  ${DGRAY}└${_rep(width, '──')}┘${RESET}\n`);
};