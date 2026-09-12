# /rollback

## Rôle

Restaure un projet (ou un agent, ou le système) vers un état antérieur capturé par `/snapshot`.

## Usage

`/rollback [projet]`

## Déroulé

1. Lister les snapshots disponibles pour le projet ciblé, avec leur date et leur nom, à partir de `[nom-du-projet]/snapshots/` dans le dossier du projet.
2. Présenter cette liste à Collins et attendre son choix explicite — **jamais de restauration automatique du plus récent sans confirmation**.
3. Une fois le snapshot choisi confirmé, exécuter `00_SYSTEM/scripts/rollback.sh [chemin-du-projet] [nom-du-snapshot]` (ou `rollback.ps1` sous Windows).

## Périmètre de la restauration

- Le rollback restaure le **dossier projet dans son ensemble** — pas de granularité fichier par fichier.
- Le sous-dossier `livrables/` est **toujours exclu** de l'opération, exclusion codée en dur dans le script (jamais une copie manuelle décrite en prose) : quel que soit le snapshot choisi, les livrables produits après le point de restauration restent intacts.
- Avant d'écraser l'état courant, le script conserve automatiquement une copie de l'état actuel (pré-rollback) dans `_versions/`, au cas où Collins voudrait revenir en avant après coup.

## Confirmation finale

Avant d'exécuter la restauration, résumer clairement ce qui va être perdu (les changements effectués entre le snapshot choisi et maintenant) et demander une dernière confirmation explicite.
