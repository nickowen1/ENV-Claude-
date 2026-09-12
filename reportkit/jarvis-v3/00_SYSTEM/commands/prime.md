# /prime

## Rôle

Charge une vue d'ensemble opérationnelle pour démarrer une session. C'est le point d'entrée général — pas un chargement ciblé sur un projet (voir `/continue` pour ça).

## Déroulé

1. Lire `01_IDENTITY/profile.md`, `objectives.md` et `preferences.md` pour rappeler le cadre général (identité, priorités du moment, ton à adopter).
2. Lister les projets présents dans `03_PROJECTS/active/`.
3. Vérifier la date du dernier `/save` par projet actif.

### Cas 1 — Un seul projet actif récemment

Si un seul projet a fait l'objet d'un `/save` dans la période récente, proposer directement sa reprise :

> "Tu as travaillé sur [nom du projet] récemment. Tu veux continuer dessus ?"

Si Collins confirme, exécuter l'équivalent de `/continue [projet]` directement, sans étape supplémentaire.

### Cas 2 — Plusieurs projets actifs

Présenter la liste des projets actifs avec leur statut résumé (dernière action, dernier `/save`), et laisser Collins choisir plutôt que de tout charger en détail.

### Cas 3 — Aucun projet actif

Présenter un état général (objectifs en cours, éventuelles incohérences détectées) et demander à Collins ce qu'il souhaite faire.

## Skills intégrés

Ce déroulé s'appuie sur deux skills qui s'activent automatiquement dans le cadre de `/prime` :
- `00_SYSTEM/skills/weekly-digest/` — génère un résumé hebdomadaire chaque dimanche/lundi, en préambule.
- `00_SYSTEM/skills/snapshot-cleaner/` — signale les snapshots anciens ou redondants à nettoyer.

## Signalement d'urgence

Avant de présenter la vue d'ensemble, vérifier s'il existe au moins une tâche urgente dans un `roadmap.md` de `03_PROJECTS/active/` (voir règle de rappel dans `03_PROJECTS/templates/project/roadmap.md` : échéance dépassée/proche de 48h, ou priorité haute).

Si oui, le signaler brièvement en premier, sans détailler (le détail complet revient à `/continue` sur le projet concerné) :

> "Attention, tu as [N] tâche(s) urgente(s) en attente sur [projet(s)]."

## Migration vers 07_ARCHIVES

Vérifier si un projet dans `03_PROJECTS/archived/` y est depuis plus de 3 mois (voir règle dans `02_GOVERNANCE/project_policies.md`). Si oui, proposer sa migration vers `07_ARCHIVES/` — jamais automatique, toujours une proposition que Collins valide ou refuse.

## Détection d'incohérence

Si une contradiction est détectée entre deux fichiers consultés pendant le `/prime` (ex : un objectif contredit un autre, ou un projet semble en désaccord avec une valeur notée), la signaler avant de poursuivre — jamais de correction automatique sans validation.

## Ce que /prime ne fait pas

- Ne charge pas le détail complet d'un projet (roadmap, decisions, blockers) — ça, c'est le rôle de `/continue`.
- Ne modifie aucun fichier.
