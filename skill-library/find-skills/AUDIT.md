# Audit — find-skills

**Origine** : externe.

**Résumé** : Aide à découvrir d'autres skills via le "Skills CLI" (`npx skills find/add/update`) et **skills.sh**, un annuaire tiers (non officiel Anthropic) de skills communautaires classé par nombre d'installations.

**Sécurité** : Le skill ne fait pas lui-même d'appel réseau — il indique à Claude d'exécuter `npx skills find [query]` puis `npx skills add <owner/repo@skill> -g -y`, qui délègue à un package npm tiers interrogeant skills.sh et téléchargeant du code depuis GitHub. Le skill inclut de bonnes pratiques de vérification avant recommandation (compter les installs, réputation de la source, étoiles GitHub). L'installation n'est proposée que si l'utilisateur veut procéder — pas d'auto-install. Point d'attention réel : le flag `-y` dans la commande suggérée saute la confirmation *au sein de* la commande d'installation elle-même, et le mécanisme revient à exécuter du code tiers non audité récupéré sur un registre non-Anthropic — le risque vient de l'écosystème skills.sh/npm en général, pas d'une malveillance du fichier lui-même.

**Verdict** : VALIDÉ AVEC RÉSERVE — outil légitime avec garde-fous de vérification inclus, mais fait reposer la confiance sur un registre tiers non officiel et invite à installer avec `-y` ; suivre les vérifications manuelles que le skill recommande lui-même.
