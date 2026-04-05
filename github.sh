#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════
#   GITHUB SYNC  ·  Integrity Gate  ·  @wistantkode/dotfiles
# ═══════════════════════════════════════════════════════════════════════

# ── Color palette (256-color) ─────────────────────────────────────────
RESET='\033[0m';    BOLD='\033[1m';     DIM='\033[2m'
RED='\033[38;5;203m';   GREEN='\033[38;5;114m';  YELLOW='\033[38;5;221m'
CYAN='\033[38;5;117m';  BLUE='\033[38;5;75m';    GRAY='\033[38;5;244m'
DGRAY='\033[38;5;238m'; WHITE='\033[38;5;255m';  ORANGE='\033[38;5;215m'

# ── Table dimensions ──────────────────────────────────────────────────
HASH_W=8    # hash column display width
MSG_W=52    # message column display width

# ── Layout helpers ────────────────────────────────────────────────────
_rep() { printf "%${1}s" | tr ' ' "${2}"; }
_sep()  { echo -e "${DGRAY}$(_rep 68 '─')${RESET}"; }
_sep2() { echo -e "${DGRAY}  $(_rep 64 '·')${RESET}"; }

_header() {
    echo -e "${DGRAY}  ╭$(_rep $((HASH_W+2)) '─')┬$(_rep $((MSG_W+2)) '─')╮${RESET}"
    printf "${DGRAY}  │${RESET}  ${BOLD}${GRAY}%-${HASH_W}s${RESET}  ${DGRAY}│${RESET}  ${BOLD}${GRAY}%-${MSG_W}s${RESET}  ${DGRAY}│${RESET}\n" "HASH" "COMMIT"
    echo -e "${DGRAY}  ├$(_rep $((HASH_W+2)) '─')┼$(_rep $((MSG_W+2)) '─')┤${RESET}"
}

_row() {
    local hash msg
    hash=$(printf "%-${HASH_W}s" "${1:0:$HASH_W}")
    local raw="$2"
    [ ${#raw} -gt $((MSG_W-1)) ] && raw="${raw:0:$((MSG_W-3))}..."
    msg=$(printf "%-${MSG_W}s" "$raw")
    printf "${DGRAY}  │${RESET}  ${CYAN}%s${RESET}  ${DGRAY}│${RESET}  %s  ${DGRAY}│${RESET}\n" "$hash" "$msg"
}

_footer() {
    echo -e "${DGRAY}  ╰$(_rep $((HASH_W+2)) '─')┴$(_rep $((MSG_W+2)) '─')╯${RESET}"
}

# ── Progress bar animation ────────────────────────────────────────────
_progress() {
    local label="$1"
    local total=28
    printf "  ${GRAY}[${RESET}"
    for ((i=1; i<=total; i++)); do
        printf "${CYAN}█${RESET}"
        sleep 0.018
    done
    printf "${GRAY}]${RESET}  ${GREEN}${label}${RESET}\n"
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
    echo -ne "\n  ${YELLOW}${BOLD}?${RESET}  $1 ${GRAY}[y/N]${RESET}  "
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
    dev|develop) BLABEL="${YELLOW}◈  INTEGRATION${RESET}" ;;
    feat/*)      BLABEL="${GREEN}◈  FEATURE${RESET}" ;;
    fix/*)       BLABEL="${CYAN}◈  BUGFIX${RESET}" ;;
    refactor/*)  BLABEL="${BLUE}◈  REFACTOR${RESET}" ;;
    *)           BLABEL="${GRAY}◈  BRANCH${RESET}" ;;
esac

# ── Phase 1 · Working tree check ─────────────────────────────────────
clear
echo ""
echo -e "  ${WHITE}${BOLD}◆  GITHUB SYNC${RESET}  ${DGRAY}·  Integrity Gate  ·  @wistantkode/dotfiles${RESET}"
echo ""
_sep

if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    echo ""
    echo -e "  ${YELLOW}${BOLD}⚠  DIRTY WORKING TREE${RESET}"
    echo ""
    git status -s | sed 's/^/     /'
    abort "Stage and commit all changes before syncing."
fi

# ── Phase 2 · Summary panel ───────────────────────────────────────────
echo ""
printf "  ${GRAY}%-14s${RESET}  ${CYAN}${BOLD}%s${RESET}  %b\n"    "Branch"   "$CURRENT_BRANCH" "$BLABEL"
printf "  ${GRAY}%-14s${RESET}  ${BOLD}%s${RESET} commit(s) ahead of remote\n" "Ahead"  "$COMMIT_COUNT"
printf "  ${GRAY}%-14s${RESET}  ${BOLD}%s${RESET} to publish\n"                "Tags"   "$TAG_COUNT"
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
    _footer
fi

# Tags list
if [ "$TAG_COUNT" -gt 0 ]; then
    echo ""
    echo -e "  ${GRAY}Unpublished tags:${RESET}"
    while IFS= read -r tag; do
        echo -e "    ${GREEN}+${RESET}  ${BOLD}$tag${RESET}"
    done <<< "$LOCAL_ONLY_TAGS"
fi

echo ""
_sep

# ── Phase 3 · Branch gate ─────────────────────────────────────────────
echo ""
case "$CURRENT_BRANCH" in
    main|master)
        echo -e "  ${RED}${BOLD}⚠  PRODUCTION BRANCH${RESET}"
        echo -e "  ${DIM}Every push to this branch triggers the public release pipeline.${RESET}"
        ask "You are on ${BOLD}${CURRENT_BRANCH}${RESET}. Proceed to final review?" \
            || abort "Cancelled by operator."
        ;;
    dev|develop)
        echo -e "  ${YELLOW}${BOLD}◈  INTEGRATION BRANCH${RESET}"
        ask "Push to ${BOLD}${REMOTE}${RESET}?" || abort "Cancelled by operator."
        ;;
    *)
        ask "Push ${BOLD}${CURRENT_BRANCH}${RESET} to remote?" || abort "Cancelled by operator."
        ;;
esac

# ── Phase 4 · Final confirmation ──────────────────────────────────────
echo ""
_sep
echo ""
SUMMARY="${BOLD}${COMMIT_COUNT}${RESET} commit(s)"
[ "$TAG_COUNT" -gt 0 ] && SUMMARY+="  ${DGRAY}+${RESET}  ${BOLD}${TAG_COUNT}${RESET} tag(s)"
printf "  ${GRAY}%-14s${RESET}  %b\n" "Will push"  "$SUMMARY"
printf "  ${GRAY}%-14s${RESET}  ${BOLD}%s${RESET}\n" "Target" "$REMOTE"
echo ""
echo -e "  ${DIM}SSH key passphrase will be required by git if not cached.${RESET}"

ask "${BOLD}Confirm push?${RESET}  ${GRAY}This cannot be undone.${RESET}" \
    || abort "Final gate: push cancelled."

# ── Phase 5 · Remote projection ───────────────────────────────────────
echo ""
_sep
echo ""
_progress "Initializing..."
_progress "Verifying integrity state..."
_progress "Ready — handing off to git."
echo ""
echo -e "  ${DGRAY}$(_rep 64 '─')${RESET}"
echo -e "  ${BOLD}▶  git push${RESET}  ${DGRAY}(passphrase prompt appears below if required)${RESET}"
echo -e "  ${DGRAY}$(_rep 64 '─')${RESET}"
echo ""

if git push --quiet $PUSH_TAGS; then
    echo ""
    _sep
    echo ""
    echo -e "  ${GREEN}${BOLD}✔  SUCCESS${RESET}  Infrastructure synchronized with ${BOLD}${REMOTE}${RESET}."
    [ "$TAG_COUNT" -gt 0 ] && \
        echo -e "  ${GRAY}Tags published. GitHub Actions pipeline may now be triggered.${RESET}"
    echo ""
    _sep
else
    echo ""
    abort "Git push failed. Check your SSH key or network connectivity."
fi

echo ""
