# Audit — prompt-engineer

**Origine** : externe (auteur github.com/Jeffallan, licence MIT, v1.2.0).

**Résumé** : Cadre méthodique pour concevoir, tester et optimiser des prompts LLM (zero-shot/few-shot/CoT/ReAct/ToT, system prompts avec guardrails, sorties structurées, frameworks d'évaluation). Se déclenche sur des demandes de conception, refactoring ou évaluation de prompts, y compris migration entre modèles.

**Sécurité** : Aucun appel réseau, aucun script exécutable, aucune clé embarquée (la seule occurrence liée à une clé est `${{ secrets.ANTHROPIC_API_KEY }}` dans un exemple de workflow GitHub Actions — une référence à une variable d'environnement, pas un secret en clair). Contenu 100% documentaire. Le fichier `system-prompts.md` traite explicitement de la défense anti-injection (hiérarchie d'instructions, sandboxing des inputs) — un enseignement défensif, pas une instruction offensive. Attribution claire (auteur, licence, et crédit explicite pour du contenu communautaire repris) — bonne pratique de provenance.

**Exactitude/fraîcheur** : Les exemples spécifiques à Claude sont cohérents avec les conventions Anthropic actuelles. Les exemples OpenAI utilisent une API dépréciée (`function_call`/`functions` plutôt que `tools`) — daté, mais sans impact sur l'usage Claude.

**Qualité/utilité** : Bien structuré, non redondant (chaque fichier indique explicitement quand ne pas l'utiliser et renvoie vers les autres), riche en exemples concrets avant/après. Aucun bug ni contradiction interne repérée.

**Verdict** : VALIDÉ AVEC RÉSERVE — contenu solide, sûr et bien sourcé, mais les portions non-Claude (exemples OpenAI) sont notablement datées.
