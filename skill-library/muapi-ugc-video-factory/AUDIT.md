# Audit — muapi-ugc-video-factory

**Origine** : externe.

**Résumé** : Pipeline en 3 étapes (génération de prompt, image hero, puis vidéo) transformant une photo de personne + une photo de produit en une publicité vidéo verticale "style UGC" avec voix off synthétique synchronisée.

**Sécurité** : Aucune clé API en clair — utilise `$MUAPI_API_KEY` en variable d'environnement, avec instruction explicite de configurer l'authentification si absente. Service tiers payant (muapi.ai), l'utilisateur doit fournir/payer sa propre clé. L'appel réseau (`curl` vers l'API muapi) est visible et documenté, pas caché. Aucune instruction de contournement de sécurité ni d'action dissimulée.

**Considération éthique/usage** : Point important — ce skill génère délibérément du contenu vidéo imitant un témoignage utilisateur authentique ("style UGC", "voix naturelle", "regarde la caméra") à partir d'une photo réelle et d'un script fourni, sans aucune mention de divulgation obligatoire (contenu généré par IA / sponsorisé). Utilisé sans transparence, cela peut poser un problème de conformité publicitaire (règles sur les témoignages) et de consentement si la personne sur la photo n'a pas autorisé cet usage synthétique. Usage légitime possible (créatifs pub avec consentement explicite + mention IA), mais à traiter avec vigilance.

**Qualité/utilité** : Pipeline clair et bien scénarisé, valeurs par défaut sensées, notes pratiques sur les limites du service. Dépend entièrement d'un service payant tiers non vérifié indépendamment ici.

**Verdict** : VALIDÉ AVEC RÉSERVE — techniquement propre et transparent sur la gestion de clé API, mais nécessite le consentement de la personne photographiée et la divulgation du caractère synthétique du contenu avant toute diffusion publicitaire.
