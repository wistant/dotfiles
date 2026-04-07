export const getAssets = (protocolDest) => [
  { src: 'data/gitignore', dest: '.gitignore', label: 'Ignore patterns' },
  { src: 'data/LICENSE', dest: 'LICENSE', label: 'License' },
  { src: 'data/github.sh', dest: '.push.sh', label: 'Push helper' },
  { src: 'protocols', dest: protocolDest, label: 'Governance protocols', isDir: true }
];