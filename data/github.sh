#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════
#   GITHUB SYNC  ·  Integrity Gate  ·  @wistantkode/dotfiles
# ════════════════════════════════════════───────────────────────════════

# ── Color palette (Minimalist 256-color) ──────────────────────────────
RESET='\033[0m';    BOLD='\033[1m';     DIM='\033[2m'
WHITE='\033[38;5;255m';  GRAY='\033[38;5;244m';   DGRAY='\033[38;5;238m'
RED='\033[38;5;203m';    GREEN='\033[38;5;114m';  YELLOW='\033[38;5;221m'
BLUE='\033[38;5;75m';    CYAN='\033[38;5;117m'

# ── Table dimensions ──────────────────────────────────────────────────
HASH_W=8    # hash column display width
MSG_W=52    # message column display width

# ── Layout helpers ────────────────────────────────────────────────────
_rep() { printf "%${1}s" | tr ' ' "${2}"; }
_sep()  { echo -e "${DGRAY}$(_rep 66 '─')${RESET}"; }

_logo() {
    echo -e "\n  ${WHITE}██████╗ ██╗████████╗██╗  ██╗██╗   ██╗██████╗ "
    echo -e "  ${WHITE}██╔════╝ ██║╚══██╔══╝██║  ██║██║   ██║██╔══██╗"
    echo -e "  ${WHITE}██║  ███╗██║   ██║   ███████║██║   ██║██████╔╝"
    echo -e "  ${WHITE}██║   ██║██║   ██║   ██╔══██║██║   ██║██╔══██╗"
    echo -e "  ${WHITE}╚██████╔╝██║   ██║   ██║  ██║╚██████╔╝██████╔╝"
    echo -e "  ${WHITE} ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ${RESET}"
    echo -e "\n  ${GRAY}${BOLD}[ GITHUB AUTOMATION SYNC ]${RESET}\n"
}

_header() {
    printf "  ${BOLD}${GRAY}%-${HASH_W}s   %-${MSG_W}s${RESET}\n" "HASH" "COMMIT MESSAGE"
    _sep
}

_row() {
    local hash msg
    hash=$(printf "%-${HASH_W}s" "${1:0:$HASH_W}")
    local raw="$2"
    [ ${#raw} -gt $((MSG_W-1)) ] && raw="${raw:0:$((MSG_W-3))}..."
    msg=$(printf "%-${MSG_W}s" "$raw")
    printf "  ${BLUE}%s${RESET}   ${WHITE}%s${RESET}\n" "$hash" "$msg"
}

_progress() {
    local label="$1"
    printf "  ${GRAY}%-28s ${RESET}" "$label"
    for ((i=1; i<=20; i++)); do
        printf "${WHITE}·${RESET}"
        sleep 0.015
    done
    printf " ${GREEN}✔${RESET}\n"
}

# ── Core utilities ────────────────────────────────────────────────────
abort() {
    echo ""
    _sep
    echo -e "  ${RED}${BOLD}✗  ABORTED${RESET}  ${GRAY}$1${RESET}"
    _sep
    echo ""
    exit 1
}

ask() {
    echo -ne "\n  ${WHITE}${BOLD}?${RESET}  $1 ${GRAY}(y/N)${RESET}  "
    read -r _r
    [[ "$_r" =~ ^([yY][eE][sS]|[yY])$ ]]
}

# ── Phase 0 · Silent data collection ─────────────────────────────────
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) \
    || { echo -e "\n  ${RED}✗${RESET}  Not a git repository."; exit 1; }

REMOTE="origin/${CURRENT_BRANCH}"
COMMITS_RAW=$(git log "${REMOTE}..HEAD" --oneline 2>/dev/null)
COMMIT_COUNT=0
[ -n "$COMMITS_RAW" ] && COMMIT_COUNT=$(echo "$COMMITS_RAW" | wc -l | tr -d ' ')

LOCAL_ONLY_TAGS=$(
    git log --tags --simplify-by-decoration --pretty="format:%D" 2>/dev/null \
    | grep "tag: " \
    | sed 's/.*tag: \([^,)]*\).*/\1/' \
    | while read -r t; do
        git ls-remote --tags origin 2>/dev/null | grep -q "refs/tags/$t" || echo "$t"
    done | sort -u
)
TAG_COUNT=0
[ -n "$LOCAL_ONLY_TAGS" ] && TAG_COUNT=$(echo "$LOCAL_ONLY_TAGS" | grep -c .)
PUSH_TAGS=""
[ "$TAG_COUNT" -gt 0 ] && PUSH_TAGS="--follow-tags"

case "$CURRENT_BRANCH" in
    main|master) BLABEL="${RED}${BOLD}⬡  PRODUCTION${RESET}" ;;
    *)           BLABEL="${GRAY}◈  BRANCH${RESET}" ;;
esac

# ── Phase 1 · Working tree check ─────────────────────────────────────
clear
_logo
_sep
echo ""
echo -e "  ${WHITE}${BOLD}◆  INTEGRITY GATE${RESET}  ${DGRAY}·  Software Engineer${RESET}"
echo ""

if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    echo ""
    echo -e "  ${YELLOW}${BOLD}⚠  DIRTY WORKING TREE${RESET}"
    echo ""
    git status -s | sed 's/^/     /'
    abort "Stage and commit all changes before syncing."
fi

# ── Phase 2 · Summary panel ───────────────────────────────────────────
printf "  ${GRAY}%-12s${RESET}  ${WHITE}${BOLD}%s${RESET}  %b\n"    "Branch"   "$CURRENT_BRANCH" "$BLABEL"
printf "  ${GRAY}%-12s${RESET}  ${WHITE}%s${RESET} commit(s) ahead\n" "Ahead"  "$COMMIT_COUNT"
printf "  ${GRAY}%-12s${RESET}  ${WHITE}%s${RESET} to publish\n"      "Tags"   "$TAG_COUNT"
echo ""
_sep

# Commits table
if [ "$COMMIT_COUNT" -gt 0 ]; then
    echo ""
    _header
    while IFS= read -r line; do
        h=$(echo "$line" | awk '{print $1}')
        m=$(echo "$line" | cut -d' ' -f2-)
        _row "$h" "$m"
    done <<< "$COMMITS_RAW"
    _sep
fi

# Tags list
if [ "$TAG_COUNT" -gt 0 ]; then
    echo ""
    echo -e "  ${GRAY}Unpublished tags:${RESET}"
    while IFS= read -r tag; do
        echo -e "    ${GREEN}✔${RESET}  ${WHITE}${BOLD}$tag${RESET}"
    done <<< "$LOCAL_ONLY_TAGS"
    _sep
fi

# ── Phase 3 · Final confirmation ──────────────────────────────────────
echo ""
SUMMARY="${WHITE}${BOLD}${COMMIT_COUNT}${RESET} commit(s)"
[ "$TAG_COUNT" -gt 0 ] && SUMMARY+=" ${DGRAY}+${RESET} ${WHITE}${BOLD}${TAG_COUNT}${RESET} tag(s)"
printf "  ${GRAY}%-12s${RESET}  %b\n" "Will push"  "$SUMMARY"
printf "  ${GRAY}%-12s${RESET}  ${BLUE}%s${RESET}\n" "Target" "$REMOTE"
echo ""

ask "Confirm push to remote?" || abort "Gate: push cancelled."

# ── Phase 4 · Projection ──────────────────────────────────────────────
echo ""
_sep
echo ""
_progress "Initializing sync"
_progress "Verifying state"
_progress "Final handoff"
echo ""

if git push --quiet $PUSH_TAGS; then
    echo ""
    _sep
    echo ""
    echo -e "  ${GREEN}${BOLD}✔  SUCCESS${RESET}  Infrastructure synchronized."
    echo ""
    _sep
else
    echo ""
    abort "Git push failed. Check connectivity."
fi

echo ""
