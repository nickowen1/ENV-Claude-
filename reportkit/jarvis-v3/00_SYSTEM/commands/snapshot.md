# /snapshot

## Rôle

Crée un point de restauration explicite et nommé pour un projet — à utiliser avant un changement risqué, une refonte, ou à tout moment où Collins veut sécuriser un état avant d'avancer.

## Usage

`/snapshot [projet]` — crée un snapshot du projet précisé.
`/snapshot [projet] "[nom du point]"` — crée un snapshot avec un nom explicite (ex : "avant refonte roadmap").

## Déroulé

1. Exécuter `00_SYSTEM/scripts/snapshot.sh [chemin-du-projet] "[nom du point]"` (ou `snapshot.ps1` sous Windows) — le script copie l'intégralité du dossier projet **à l'exception du sous-dossier `livrables/`**, exclusion codée en dur dans le script, jamais laissée à l'appréciation du moment.
2. Cette copie est rangée par le script dans `[nom-du-projet]/snapshots/[date-heure]_[nom]/` à l'intérieur du dossier du projet.
3. Confirmer à Collins la création du point, avec sa date et son nom.

> Pourquoi un script plutôt qu'une copie décrite en prose : l'exclusion de `livrables/` est une règle qui ne doit jamais dépendre d'une étape manuelle oubliée — le script la garantit à chaque exécution.

## Différence avec /save

`/snapshot` est un point de restauration ponctuel et volontaire, distinct de `/save` qui gère la continuité courante de session. `/save` n'écrit jamais dans `snapshots/` — seul `/snapshot` le fait.

## Niveaux de snapshot

Cette même logique s'applique à trois niveaux, selon ce que Collins précise :
- **Projet** (le cas courant, décrit ci-dessus).
- **Agent** : `/snapshot` peut aussi cibler un agent, copie dans `00_SYSTEM/agents/[agent]/snapshots/`.
- **Système** : sur demande explicite, snapshot de l'ensemble de `01_IDENTITY/` et de la structure générale — rangé dans `08_SNAPSHOTS/` à la racine (voir README de ce dossier), généralement avant un changement structurel majeur.
