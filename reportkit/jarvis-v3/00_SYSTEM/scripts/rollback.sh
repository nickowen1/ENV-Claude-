#!/usr/bin/env bash
# Restaure un dossier projet à partir d'un snapshot existant.
# - Sauvegarde d'abord l'état courant (hors livrables/, snapshots/, _versions/)
#   dans _versions/pre-rollback_<timestamp>/, au cas où il faudrait revenir
#   en avant après coup.
# - livrables/ n'est JAMAIS touché par cette opération, quel que soit le
#   snapshot restauré (le snapshot ne le contient de toute façon jamais).
#
# N'utilise que cp/rm/mv (pas de dépendance à rsync ou tar).
#
# Usage : rollback.sh <chemin-du-projet> <nom-du-snapshot-dans-snapshots/>
#   ex.  rollback.sh 03_PROJECTS/active/MonProjet 20260702_113000_avant_refonte

set -euo pipefail

PROJECT_DIR="${1:?Usage: rollback.sh <chemin-du-projet> <nom-du-snapshot>}"
SNAPSHOT_NAME="${2:?Usage: rollback.sh <chemin-du-projet> <nom-du-snapshot>}"
SNAPSHOT_DIR="$PROJECT_DIR/snapshots/$SNAPSHOT_NAME"

if [ ! -d "$SNAPSHOT_DIR" ]; then
  echo "Erreur : snapshot introuvable : $SNAPSHOT_DIR" >&2
  echo "Snapshots disponibles :" >&2
  ls "$PROJECT_DIR/snapshots" >&2 || true
  exit 1
fi

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

# 1. Sauvegarde de l'état courant (hors livrables/snapshots/_versions),
#    via un dossier temporaire hors arborescence pour éviter l'auto-inclusion.
TMP_PRE="$(mktemp -d)"
cp -a "$PROJECT_DIR"/. "$TMP_PRE"/
rm -rf "$TMP_PRE/livrables" "$TMP_PRE/snapshots" "$TMP_PRE/_versions"

mkdir -p "$PROJECT_DIR/_versions"
PRE_ROLLBACK_DIR="$PROJECT_DIR/_versions/pre-rollback_${TIMESTAMP}"
mv "$TMP_PRE" "$PRE_ROLLBACK_DIR"
echo "État courant sauvegardé dans : $PRE_ROLLBACK_DIR"

# 2. Restauration : le snapshot ne contient jamais livrables/ ni snapshots/,
#    donc cette copie ne peut pas les écraser dans le projet courant.
cp -a "$SNAPSHOT_DIR"/. "$PROJECT_DIR"/
echo "Projet restauré depuis : $SNAPSHOT_DIR"
