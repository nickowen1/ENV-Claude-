# Audit — claude-automation-recommender

**Origine** : externe.

**Résumé** : Analyse un dépôt de code (langage, frameworks, CI, tests) pour recommander des automatisations Claude Code adaptées — hooks, subagents, skills, plugins, serveurs MCP — sans jamais modifier de fichiers lui-même.

**Sécurité** : Le skill restreint explicitement ses propres outils à de la lecture seule (`Read, Glob, Grep, Bash` pour de la détection de dépendances) et l'affirme deux fois lui-même. Aucune clé/identifiant embarqué, aucun appel réseau caché (seul "réseau" mentionné : WebSearch pour enrichir les recommandations, légitime et transparent). Aucun snippet ne pré-autorise de commandes Bash destructrices. Point d'attention réel : `references/mcp-servers.md` recommande de committer `.mcp.json` pour le partage d'équipe sans avertir que certaines configs MCP embarquent des clés/tokens dans ce même fichier — risque de fuite de secret non signalé. Pas de métadonnées d'auteur/licence dans le frontmatter.

**Exactitude/fraîcheur** : La structure `.claude/settings.json`, la syntaxe frontmatter de skill, l'emplacement `.claude/agents/*.md` et `.mcp.json` correspondent aux conventions Claude Code connues. Les noms de matchers de hooks `Notification` cités ne sont pas vérifiables en l'état et pourraient être approximatifs — à confirmer avant usage réel.

**Qualité/utilité** : Bien organisé (tableaux "signal détecté → recommandation"), volontairement peu bruyant (1-2 recommandations par catégorie), pousse vers l'implémentation manuelle plutôt que d'agir seul. Défaut mineur : une table dupliquée dans `hooks-patterns.md` (copier-coller non nettoyé).

**Verdict** : VALIDÉ AVEC RÉSERVE — skill sûr et bien scopé en lecture seule ; corriger l'absence d'avertissement sur les secrets dans `.mcp.json` avant de le partager en équipe, et vérifier les noms de matchers de hooks avant de s'y fier.
