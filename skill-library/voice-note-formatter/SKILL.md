---
name: voice-note-formatter
description: Reformule une dictée vocale brute (hésitations, répétitions, tournures orales) en français propre et structuré, avant écriture dans un fichier Jarvis. Utiliser uniquement sur demande explicite de Collins (ex: "reformule ça avant de l'écrire", "nettoie ma dictée"), jamais automatiquement.
---

# Voice Note Formatter

## Rôle

Prendre un texte dicté vocalement (fautes de liaison, hésitations, répétitions, tournures orales type "tu vois", "voilà quoi") et le reformuler en français écrit correct et structuré, avant qu'il entre dans un fichier de `01_IDENTITY/`, `03_PROJECTS/`, ou tout autre fichier Jarvis.

## Déclenchement

**Uniquement sur demande explicite.** Ce skill ne s'active jamais de sa propre initiative, même si une dictée semble manifestement brouillonne. Collins garde le contrôle total : s'il veut qu'une formulation brute soit conservée telle quelle (par exemple pour se souvenir exactement de comment il pensait une idée sur le moment), c'est son choix.

## Règles de reformulation

- Supprimer les hésitations orales, répétitions, tics de langage ("tu vois", "voilà", "quoi").
- Corriger la syntaxe et la ponctuation pour un français écrit standard.
- **Ne jamais changer le sens** — reformuler la forme, jamais le fond. En cas de doute sur ce que voulait dire une phrase ambiguë, demander plutôt que de deviner.
- Garder un ton neutre et fidèle à ce qui a été dit, pas de réécriture stylistique excessive.

## Ce que ce skill ne fait pas

- Ne résume pas le contenu — reformule sans raccourcir le sens.
- Ne modifie jamais un fichier sans validation explicite de Collins sur le résultat final (cohérent avec la règle générale de `CLAUDE.md` : aucune écriture sans validation).
