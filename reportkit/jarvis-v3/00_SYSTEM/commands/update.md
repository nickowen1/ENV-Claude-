# /update

## Skill intégré

Ce déroulé s'appuie sur `00_SYSTEM/skills/consistency-checker/`, qui vérifie automatiquement toute contradiction avant l'application d'une modification (voir étape 4 ci-dessous).

## Rôle

Déclenche une mise à jour explicite d'un fichier de contexte (identité, projet, ou système), en complément de la détection proactive déjà décrite dans `CLAUDE.md`.

## Usage

`/update` — Claude demande quel fichier ou quelle information mettre à jour.
`/update [fichier ou projet]` — cible directement l'élément concerné.

## Déroulé

1. Identifier le ou les fichiers à modifier.
2. Avant toute écriture, copier la version actuelle dans `_versions/` (du projet concerné, ou de `01_IDENTITY/_versions/` pour les fichiers d'identité) avec un horodatage.
3. Appliquer la modification.
4. Si la modification semble contredire une information déjà présente ailleurs dans le système, le signaler avant de valider — jamais d'écriture silencieuse sur une incohérence détectée.
5. Confirmer la mise à jour effectuée.

## Différence avec la mise à jour proactive

`/update` est déclenché volontairement par Collins. La mise à jour proactive (décrite dans `CLAUDE.md`) se déclenche quand Claude détecte un changement important en cours de conversation — mais dans les deux cas, aucune écriture ne se fait sans validation explicite de Collins.
