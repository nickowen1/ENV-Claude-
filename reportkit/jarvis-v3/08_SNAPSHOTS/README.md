# Snapshots système

Points de restauration globaux, couvrant l'ensemble de `01_IDENTITY/` et de la structure générale du système — distincts des snapshots par projet (qui vivent dans `03_PROJECTS/[projet]/snapshots/`) et par agent (`00_SYSTEM/agents/[agent]/snapshots/`).

Un snapshot système est créé via `/snapshot` en précisant explicitement qu'il s'agit du niveau système, généralement avant un changement structurel majeur (ex : réorganisation de `01_IDENTITY`, changement de règles dans `02_GOVERNANCE`).
