# Audit — weekly-digest

**Origine** : JARVIS (créé par l'utilisateur).

**Résumé** : Génère un résumé hebdomadaire des projets actifs (décisions, tâches terminées/ajoutées) au premier `/prime` de la semaine.

**Sécurité** : Aucun appel réseau, aucun identifiant. Lecture de fichiers projet + une seule écriture (son propre fichier d'état).

**Correction apportée lors de l'audit JARVIS** : la version originale supposait que le modèle se souvienne, d'une session à l'autre, s'il avait déjà généré un digest cette semaine — un vrai trou, puisqu'une session Claude Code fraîche n'a pas cette mémoire. Corrigé en ajoutant un fichier d'état persistant (`09_DASHBOARD/.digest_state.md`) lu/écrit par le skill, rendant la règle "une fois par semaine" vérifiable plutôt que déclarative. C'est cette version corrigée qui est reprise ici.

**Qualité/utilité** : Périmètre bien limité (lecture + un seul write sur son propre état), ne remplace pas `/prime` mais s'y ajoute en préambule.

**Verdict** : VALIDÉ — après correction du trou de mémoire persistante, le skill est fiable.
