#!/usr/bin/env bash
# Install ui-ux-pro-max (and sibling skills) to ~/.cursor/skills/
# so every new Cursor chat and project can use them — not just this repo.
#
# Run once on your machine:
#   bash scripts/install-cursor-global.sh
set -euo pipefail

cyan() { printf '\033[36m%s\033[0m\n' "$1"; }
green() { printf '\033[32m%s\033[0m\n' "$1"; }

TARGET="${HOME}/.cursor/skills"

cyan "==> Installing UI/UX Pro Max skills globally for Cursor"
cyan "    Target: ${TARGET}/"
echo

if command -v uipro >/dev/null 2>&1; then
  uipro init --ai cursor --global --force
elif npx --yes ui-ux-pro-max-cli init --ai cursor --global --force; then
  :
else
  repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  if [[ -d "${repo_root}/.cursor/skills" ]]; then
    cyan "==> CLI unavailable — copying skills from this repository"
    mkdir -p "${TARGET}"
    for skill in "${repo_root}/.cursor/skills/"*/; do
      name="$(basename "${skill}")"
      rm -rf "${TARGET}/${name}"
      cp -a "${skill}" "${TARGET}/${name}"
      green "  + ${name}"
    done
  else
    echo "Install failed. Try manually:"
    echo "  npx ui-ux-pro-max-cli init --ai cursor --global"
    exit 1
  fi
fi

green "==> Done."
echo
echo "Next steps:"
echo "  1. Restart Cursor (or open a new window)"
echo "  2. Customize → Skills — ui-ux-pro-max should appear"
echo "  3. Every new chat can now use the skill automatically"
