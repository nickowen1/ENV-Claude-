---
name: weekly-digest
description: Génère un résumé hebdomadaire lisible de l'activité sur les projets actifs, à partir des fichiers decisions.md et roadmap.md. Se déclenche chaque dimanche ou lundi, au premier /prime de la semaine.
---

# Weekly Digest

## Rôle

Produire une vue synthétique d'une page maximum de ce qui s'est passé dans la semaine écoulée sur les projets actifs — pour garder une vue d'ensemble sans devoir tout relire projet par projet.

## Déclenchement

Au premier `/prime` du dimanche ou du lundi (selon le jour où Collins ouvre sa première session de la semaine).

**État persistant** : la dernière date de génération est lue dans `09_DASHBOARD/.digest_state.md`, pas déduite de la mémoire de la conversation en cours (une nouvelle session n'a par défaut aucun souvenir des sessions précédentes). Concrètement :
1. Lire `09_DASHBOARD/.digest_state.md` pour connaître la date du dernier digest généré.
2. Si cette date tombe dans la semaine calendaire en cours, ne pas régénérer (sauf demande explicite de Collins).
3. Sinon, générer le digest puis mettre à jour `09_DASHBOARD/.digest_state.md` avec la date du jour.

## Déroulé

1. Pour chaque projet dans `03_PROJECTS/active/`, lire `decisions.md` et `roadmap.md`.
2. Extraire : les décisions prises dans les 7 derniers jours, les tâches terminées, les nouvelles tâches ajoutées.
3. Générer un résumé condensé, par projet, présenté avant le reste du contenu habituel de `/prime`.
4. Mettre à jour `09_DASHBOARD/.digest_state.md` avec la date du jour (seule écriture faite par ce skill).

## Format

Court et scannable — quelques lignes par projet, pas un rapport détaillé. L'objectif est la vue d'ensemble rapide, pas l'exhaustivité (pour le détail, `/continue [projet]` reste la commande adaptée).

## Ce que ce skill ne fait pas

- Ne remplace pas `/prime` — s'ajoute en préambule à son déroulé habituel la semaine où il se déclenche.
- Ne modifie aucun fichier de projet ou d'identité — la seule écriture autorisée est la mise à jour de son propre fichier d'état `09_DASHBOARD/.digest_state.md`.
