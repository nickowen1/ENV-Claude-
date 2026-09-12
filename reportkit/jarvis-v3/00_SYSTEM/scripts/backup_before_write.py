#!/usr/bin/env python3
"""
Hook PreToolUse (Write/Edit) pour Jarvis.

Avant toute écriture dans 01_IDENTITY/** ou 03_PROJECTS/**, copie le fichier
existant vers un dossier _versions/ horodaté. Ne bloque jamais l'écriture :
ce script fait uniquement la sauvegarde, la validation elle-même est gérée
par les règles "ask" de .claude/settings.json.

Ne touche jamais les fichiers sous un dossier livrables/, conformément à la
règle générale du système (livrables toujours exclus des mécanismes de
sauvegarde/restauration).
"""
import json
import re
import shutil
import sys
from datetime import datetime
from pathlib import Path


def project_versions_dir(rel_path: Path) -> Path | None:
    parts = rel_path.parts
    if len(parts) >= 3 and parts[0] == "03_PROJECTS":
        # 03_PROJECTS/<status>/<project-name>/... -> backup dans ce projet
        return Path(*parts[:3]) / "_versions"
    if parts and parts[0] == "01_IDENTITY":
        return Path("01_IDENTITY") / "_versions"
    return None


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        return 0

    tool_input = payload.get("tool_input", {})
    file_path = tool_input.get("file_path")
    if not file_path:
        return 0

    cwd = Path(payload.get("cwd", "."))
    abs_path = Path(file_path)
    if not abs_path.is_absolute():
        abs_path = cwd / abs_path

    try:
        rel_path = abs_path.relative_to(cwd)
    except ValueError:
        return 0

    if "livrables" in rel_path.parts:
        return 0

    if not re.match(r"^(01_IDENTITY|03_PROJECTS)([/\\]|$)", str(rel_path)):
        return 0

    if not abs_path.exists():
        # Rien à sauvegarder, c'est une création de fichier.
        return 0

    versions_dir_rel = project_versions_dir(rel_path)
    if versions_dir_rel is None:
        return 0

    versions_dir = cwd / versions_dir_rel
    versions_dir.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"{abs_path.stem}_{timestamp}{abs_path.suffix}"
    shutil.copy2(abs_path, versions_dir / backup_name)
    return 0


if __name__ == "__main__":
    sys.exit(main())
