# /continue

## Rôle

Charge le contexte complet d'un projet précis pour reprendre le travail exactement là où il s'était arrêté. C'est la commande de travail principale au quotidien.

## Usage

`/continue [nom-du-projet]`

## Déroulé

1. Localiser le dossier du projet dans `03_PROJECTS/active/` (ou `paused/` si Collins réactive un projet en pause).
2. Charger l'ensemble des fichiers du projet : `project.md`, `roadmap.md`, `decisions.md`, `assumptions.md`, `blockers.md`, `lessons.md`.
3. Résumer en quelques lignes l'état actuel : où le travail s'était arrêté, la dernière prochaine action notée via `/save`.

## Signalement d'urgence

Détailler précisément les tâches urgentes de ce projet (voir règle de rappel dans `roadmap.md` : échéance dépassée/proche de 48h, ou priorité haute), puisque `/continue` porte sur un seul projet et peut se permettre ce niveau de détail (contrairement à `/prime` qui reste global).

## Réactivation d'un projet en pause

Si le projet ciblé est dans `paused/`, demander confirmation avant de le déplacer vers `active/` :

> "[Projet] est actuellement en pause. Tu veux le réactiver ?"

## Ce que /continue ne fait pas

- Ne charge pas les fichiers d'autres projets.
- Ne modifie rien automatiquement — pour sauvegarder un changement, `/save` reste nécessaire.
