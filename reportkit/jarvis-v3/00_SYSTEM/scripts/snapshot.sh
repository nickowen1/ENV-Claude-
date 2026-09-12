#!/usr/bin/env bash
# Crée un snapshot horodaté d'un dossier projet, en excluant TOUJOURS livrables/
# et snapshots/ eux-mêmes (pas de copie récursive des anciens snapshots).
#
# N'utilise que cp/rm/mv (pas de dépendance à rsync ou tar, pas toujours
# disponibles selon l'environnement).
#
# Usage : snapshot.sh <chemin-du-projet> [nom-du-point]
#   ex.  snapshot.sh 03_PROJECTS/active/MonProjet "avant refonte roadmap"

set -euo pipefail

PROJECT_DIR="${1:?Usage: snapshot.sh <chemin-du-projet> [nom-du-point]}"
NAME="${2:-snapshot}"
NAME_SLUG="$(echo "$NAME" | tr ' /' '__')"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Erreur : dossier introuvable : $PROJECT_DIR" >&2
  exit 1
fi

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

# Copie dans un dossier temporaire HORS de l'arborescence source, pour éviter
# qu'une copie récursive s'inclue elle-même (le dossier snapshots/ final vit
# à l'intérieur du dossier projet).
TMP_DEST="$(mktemp -d)"
cp -a "$PROJECT_DIR"/. "$TMP_DEST"/
rm -rf "$TMP_DEST/livrables" "$TMP_DEST/snapshots"

mkdir -p "$PROJECT_DIR/snapshots"
FINAL_DEST="$PROJECT_DIR/snapshots/${TIMESTAMP}_${NAME_SLUG}"
mv "$TMP_DEST" "$FINAL_DEST"

echo "Snapshot créé : $FINAL_DEST"
