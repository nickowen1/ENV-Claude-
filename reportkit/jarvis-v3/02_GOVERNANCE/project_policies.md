# Politiques de cycle de vie des projets

> Base de départ proposée par Jarvis, à ajuster librement par Collins.

## ideas/ → incubating/

Un projet passe de `ideas/` à `incubating/` quand Collins décide de l'évaluer sérieusement — pas de délai imposé, c'est une décision volontaire.

## incubating/ → active/

Un projet passe de `incubating/` à `active/` quand :
- il a été évalué via `opportunity_filters.md` (au moins informellement) ;
- une place est disponible selon la règle des 2 projets actifs maximum (`decision_rules.md`).

**Proposition de durée maximale en `incubating/`** : si un projet reste plus de 30 jours en incubation sans passer actif ni être abandonné, Jarvis le signale lors d'un `/prime` pour éviter qu'il ne traîne indéfiniment sans décision.

## active/ → paused/

Un projet passe en pause à la demande explicite de Collins — pas de critère automatique, c'est toujours une décision volontaire (souvent pour libérer une place selon la règle des 2 projets actifs maximum).

## active/ ou paused/ → archived/

Un projet est archivé quand :
- ses critères de succès (`project.md`) sont atteints, ou
- Collins décide explicitement de l'abandonner.

Dans les deux cas, un dernier `/snapshot` est recommandé avant l'archivage, pour garder une trace propre de l'état final.

## archived/ (03_PROJECTS) → 07_ARCHIVES (racine)

`03_PROJECTS/archived/` sert à l'archivage récent, encore potentiellement consultable rapidement. `07_ARCHIVES/` à la racine sert au stockage long terme, pour ne pas alourdir `03_PROJECTS/` indéfiniment.

**Règle** : si un projet reste plus de 3 mois dans `03_PROJECTS/archived/` sans être rouvert, Jarvis propose sa migration vers `07_ARCHIVES/` lors d'un `/prime`. Cette migration n'est jamais automatique — toujours proposée, jamais imposée.

## Note

Ces règles sont une proposition initiale, à ajuster via `/update`.
