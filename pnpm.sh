#!/bin/bash
# --- ELITE NPM PUBLISH AUTOMATION (@wistantkode/dotfiles) ---

echo "🚀 Preparing for npm publication..."

# Ensure pnpm is used
if ! command -v pnpm &> /dev/null; then
    echo "❌ Error: pnpm is not installed."
    exit 1
fi

# Run audit before publishing if SECURITY.md exists and is readable
if [ -f "./protocols/SECURITY.md" ]; then
    echo "🛡️ Running security audit (viewing protocols/SECURITY.md)..."
    cat ./protocols/SECURITY.md
    pnpm audit
fi

# Publish
echo "📦 Publishing to NPM..."
pnpm publish --access public

echo "✅ Published successfully!"
