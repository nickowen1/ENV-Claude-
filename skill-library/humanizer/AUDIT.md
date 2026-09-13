# Audit — humanizer

**Origine** : externe (auteur github.com/blader, licence MIT, copyright Siqi Chen — dépôt github.com/blader/humanizer).

**Résumé** : Réécrit un texte "à consonance IA" pour qu'il sonne comme écrit par une personne, sans changer le contenu factuel. Basé explicitement sur la page Wikipédia "Signs of AI writing" (WikiProject AI Cleanup). Catalogue 25 "tells" (contrastes not-X-but-Y, tirets partout, mots IA surutilisés, listes en gras décoratif, résidus de chatbot...), avec règle stricte anti-fabrication : ne jamais ajouter un fait, nom, chiffre, date ou citation absent de la source ou fourni par l'utilisateur.

**Script `scripts/validate-package.py`** : Purement local et en lecture seule — vérifie la cohérence des versions entre fichiers, la numérotation des patterns, la présence d'un unique `SKILL.md`. Aucun appel réseau, aucune écriture, aucune obfuscation.

**Workflow CI (`.github/workflows/validate.yml`)** : Tourne uniquement dans GitHub Actions au push/PR — un contrôle de dépôt côté mainteneur, jamais exécuté sur la machine de l'utilisateur final. Actions tierces épinglées par SHA (bonne pratique anti-supply-chain).

**`agents/openai.yaml`** : Pas un sous-agent appelant l'API OpenAI — un manifeste de métadonnées de portabilité (équivalent d'un `plugin.json`) pour charger le même skill dans des outils compatibles OpenAI (type Codex). Aucune dépendance croisée à l'API OpenAI, aucune clé requise, non utilisé quand le skill tourne dans Claude Code.

**Sécurité** : Skill = pur prompt Markdown sans exécution de code au moment de l'usage. Permissions minimales (le validateur interdit même les champs `allowed-tools`/`compatibility`).

**Considération éthique/usage** : Le texte du skill est honnêtement cadré autour de la qualité d'écriture, jamais de l'évasion de détection. Citations exactes : *"Rewrite AI-sounding text so it reads like the writer, not a chatbot. Keep what it says. Do not make anything up."* Le changelog v3.0.0 précise même avoir retiré le mot-clé `ai-detection` des fichiers du package — distanciation délibérée et documentée. Aucune mention de "detector", "plagiarism" ou "academic" nulle part. Cela dit, mécaniquement, supprimer les signatures statistiques d'un texte IA est exactement la technique qui réduirait aussi le score d'un détecteur IA — un usage détourné (devoirs académiques, faux avis, spam SEO) reste possible malgré l'intention affichée.

**Qualité/utilité** : Documentation soignée et très itérée (25 versions historisées), règles anti-invention robustes, adaptation de "voix" à un échantillon fourni par l'utilisateur. Solide pour de la relecture éditoriale légitime (marketing auto-généré, docs).

**Verdict** : VALIDÉ AVEC RÉSERVE — techniquement propre (pas d'exécution au runtime, script de validation local et CI-only, pas de dépendance cachée à OpenAI, permissions minimales) et honnêtement cadré sur la qualité d'écriture ; la réserve tient à la nature intrinsèquement double-usage du mécanisme, à connaître avant tout usage académique ou de conformité de plateforme.
