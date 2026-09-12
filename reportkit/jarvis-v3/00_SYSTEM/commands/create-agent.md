# /create-agent

## Rôle

Crée un sous-agent à partir de `00_SYSTEM/templates/agent/`. Toujours à la demande explicite de Collins.

## Usage

`/create-agent [nom]`

## Déroulé

1. Demander la portée de l'agent : transversal (utilisable sur plusieurs projets) ou dédié à un projet précis — voir `identity.md` du template. Ce choix est indicatif, pas restrictif : l'agent pourra être réutilisé ailleurs plus tard si pertinent.
2. Copier la structure de `templates/agent/` vers `00_SYSTEM/agents/[nom-de-l-agent]/`.
3. Remplir `identity.md` et `mission.md` avec les informations données par Collins.
4. Demander explicitement à ce stade : cet agent doit-il s'activer automatiquement dans certaines conditions, ou uniquement à la demande ? Noter la réponse dans `constraints.md`.
5. Confirmer la création.

## Pas de cycle de vie intermédiaire

Contrairement aux projets, un agent n'a pas de statut actif/pause/archive. Il reste disponible dans `00_SYSTEM/agents/` tant que Collins ne demande pas explicitement sa suppression.
