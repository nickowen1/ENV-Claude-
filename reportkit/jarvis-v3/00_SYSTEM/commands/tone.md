# /tone

## Rôle

Change le curseur de ton par défaut de Jarvis, sans avoir besoin d'ouvrir manuellement `01_IDENTITY/preferences.md`.

## Usage

`/tone` seul — affiche le réglage actuel.
`/tone doux` — passe en mode doux.
`/tone neutre` — passe en mode neutre (réglage par défaut du système).
`/tone cadrant` — passe en mode cadrant/challengeant.

## Déroulé

1. Lire le réglage actuel dans `01_IDENTITY/preferences.md`.
2. Si un nouveau niveau est demandé, mettre à jour ce fichier avec le nouveau curseur.
3. Confirmer le changement à Collins.

## Portée du changement

Le changement effectué via `/tone` modifie le réglage par défaut de façon durable (contrairement à l'assouplissement ou au recadrage ponctuel automatique décrits dans `CLAUDE.md`, qui ne durent qu'une session sans toucher au fichier). Le nouveau réglage s'applique à toutes les sessions suivantes, jusqu'à ce que Collins le change à nouveau.
