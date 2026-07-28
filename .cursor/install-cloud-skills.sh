#!/usr/bin/env bash
# Install repo skills into ~/.cursor/skills/ on Cloud Agent VMs.
# Cloud Agents do not sync your laptop's ~/.cursor/skills/ — each VM is fresh.
# This script runs from environment.json on every agent boot.
set -euo pipefail

SRC="${1:-.cursor/skills}"
DEST="${HOME}/.cursor/skills"

if [[ ! -d "${SRC}" ]]; then
  echo "No ${SRC} directory — skipping cloud skill install."
  exit 0
fi

mkdir -p "${DEST}"

for skill in "${SRC}"/*/; do
  name="$(basename "${skill}")"
  rm -rf "${DEST}/${name}"
  cp -a "${skill}" "${DEST}/${name}"
  echo "  + ${name}"
done

echo "Cloud skills installed to ${DEST}/"
