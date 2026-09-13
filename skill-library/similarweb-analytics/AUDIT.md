# Audit — similarweb-analytics

**Origine** : externe.

**Résumé** : Fournit des métriques de trafic web (rang global, visites, taux de rebond, sources de trafic, répartition géographique) pour un domaine donné, via l'API SimilarWeb.

**Sécurité** : Aucune clé API ni identifiant en clair. Mais le code s'appuie exclusivement sur `from data_api import ApiClient` chargé depuis `/opt/.manus/.sandbox-runtime` — un chemin propre à la plateforme **Manus.im**, absent d'un environnement Claude Code standard. Le skill semble copié tel quel depuis une bibliothèque de skills Manus sans adaptation : tout appel `ApiClient()` échouera (erreur d'import/fichier introuvable) dans Claude Code. Pas de risque de fuite de données, mais non fonctionnel hors de son environnement d'origine.

**Considération éthique/usage** : Utilise une API commerciale officielle (pas de scraping direct du site cible) — pas de violation de ToS en soi. Si quelqu'un le remplaçait par du scraping HTML de similarweb.com pour éviter de payer, ce serait une violation des CGU SimilarWeb ; le skill ne met pas en garde contre cela.

**Qualité/utilité** : Bien documenté sur les paramètres et limites (12 mois d'historique, granularité mensuelle uniquement), mais inutilisable en l'état car câblé sur l'infrastructure Manus plutôt que sur une clé SimilarWeb classique. Aucun mécanisme d'authentification alternatif proposé.

**Verdict** : À CORRIGER AVANT USAGE — importe un module qui n'existe pas dans Claude Code ; à réécrire avec un vrai client API SimilarWeb + gestion de clé avant d'en faire un usage réel.
