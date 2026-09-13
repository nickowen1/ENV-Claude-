# Audit — consistency-checker

**Origine** : JARVIS (créé par l'utilisateur).

**Résumé** : Vérifie, à chaque exécution de `/update`, qu'une modification ne contredit pas une information déjà présente ailleurs dans le système (autre projet, identité, gouvernance).

**Sécurité** : Aucun appel réseau, aucun script, aucun identifiant. Skill purement instructionnel.

**Qualité/utilité** : Rôle clair et étroitement scopé, déclenchement précis (uniquement à `/update`), et surtout : ne bloque jamais une écriture de sa propre initiative — il signale, propose, mais laisse toujours la décision finale à l'utilisateur. Pas de contradiction interne.

**Verdict** : VALIDÉ — instructions cohérentes, périmètre clair, aucun risque.
