# Audit — snapshot-cleaner

**Origine** : JARVIS (créé par l'utilisateur).

**Résumé** : Détecte les snapshots anciens (plus de 3 mois) ou redondants dans `snapshots/` et `_versions/`, et propose leur nettoyage. Se déclenche à chaque `/prime`.

**Sécurité** : Aucun appel réseau, aucun script, aucun identifiant. Skill purement instructionnel.

**Qualité/utilité** : Critères de détection concrets (ancienneté, redondance de contenu), jamais de suppression automatique — chaque suppression reste une action explicite et confirmée, projet par projet. Exclut correctement `livrables/` de son périmètre, cohérent avec la règle générale du système.

**Verdict** : VALIDÉ — critères clairs, aucune action destructrice sans confirmation.
