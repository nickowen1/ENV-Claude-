# Dashboard

> Ce fichier ne contient pas de données figées. Il décrit comment Jarvis génère la vue d'ensemble à la volée, à chaque consultation.

## Génération

À la demande de Collins ("montre-moi le dashboard", ou équivalent), Jarvis :

1. Lit `03_PROJECTS/active/` pour la liste des projets actifs (max 2, voir `02_GOVERNANCE/decision_rules.md`).
2. Pour chacun, résume : statut, dernière action (`/save`), tâches urgentes (voir `priorities.md` et `next_actions.md`).
3. Signale toute incohérence détectée entre les fichiers consultés.
4. Présente le tout de façon synthétique, sans détailler chaque projet en profondeur — pour le détail, `/continue [projet]` reste la commande adaptée.

## Figer le dashboard

Si Collins demande explicitement de "figer le dashboard" (langage naturel, pas de commande dédiée), Jarvis capture l'état généré à cet instant et le sauvegarde comme fichier daté, sans écraser ce fichier de méthode. Le fichier figé est rangé dans `08_SNAPSHOTS/dashboard/[date].md`.
