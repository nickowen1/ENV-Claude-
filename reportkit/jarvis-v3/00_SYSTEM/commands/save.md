# /save

## Rôle

Capture l'état de fin de session sur un projet en cours, pour permettre une reprise rapide via `/continue`.

## Usage

`/save` — sauvegarde le projet actif de la session en cours.
`/save [projet]` — sauvegarde un projet précis si plusieurs étaient en jeu dans la session.

## Déroulé

1. Identifier le projet concerné (déduit du contexte de la session, ou précisé par Collins).
2. Mettre à jour dans le dossier du projet :
   - `roadmap.md` : cocher les tâches terminées, ajouter les nouvelles si mentionnées.
   - `blockers.md` : ajouter tout obstacle rencontré durant la session.
   - `decisions.md` : ajouter toute décision structurante prise.
3. Noter explicitement la **prochaine action recommandée** — c'est l'information la plus importante pour une reprise rapide, elle doit être écrite noir sur blanc, pas implicite.

## Important

- `/save` **ne crée jamais d'entrée dans `snapshots/`**. Le dossier `snapshots/` est réservé exclusivement à `/snapshot`, tapé explicitement.
- Avant toute écriture, une copie horodatée des fichiers modifiés est conservée dans `_versions/` du projet.
- Si des changements semblent contredire un objectif ou une décision précédente, le signaler avant de sauvegarder.
