# Audit — chrome-devtools

**Origine** : externe.

**Résumé** : Documente les catégories d'outils du serveur MCP `chrome-devtools` (navigation, interaction, debug, performance) et propose des workflows (repérage d'éléments, dépannage d'erreurs, profilage de perf). Skill de référence/orchestration : elle indique à Claude quels outils MCP appeler et dans quel ordre, sans exécuter quoi que ce soit elle-même.

**Sécurité** : Rien à signaler. Aucun script, aucune URL externe, aucun identifiant. Toutes les actions décrites passent par les outils MCP eux-mêmes (avec confirmation d'outil à chaque appel) — aucune instruction à agir en cachette ni à exfiltrer des données.

**Qualité/utilité** : Bien structuré (table d'outils, patterns avec exemples), utile comme aide-mémoire si le MCP `chrome-devtools` est effectivement installé. Ne vérifie jamais sa disponibilité ni ne référence de version/dépôt du serveur MCP — rien ne garantit que les noms d'outils cités correspondent à la version réellement installée.

**Verdict** : VALIDÉ AVEC RÉSERVE — contenu sûr et bien écrit, mais suppose sans le vérifier que le MCP `chrome-devtools` exact est présent et à jour.
