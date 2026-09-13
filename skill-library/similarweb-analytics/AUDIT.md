# Audit — similarweb-analytics

**Origine** : externe.

**Résumé** : Fournit des métriques de trafic web (rang global, visites, taux de rebond, sources de trafic, répartition géographique) pour un domaine donné, via l'API SimilarWeb.

## Défaut initial constaté

Le code s'appuyait exclusivement sur `from data_api import ApiClient` chargé depuis `/opt/.manus/.sandbox-runtime` — un chemin propre à la plateforme **Manus.im**, absent d'un environnement Claude Code standard. Le skill avait manifestement été copié tel quel depuis une bibliothèque de skills Manus sans adaptation : tout appel `ApiClient()` échouait (erreur d'import) dans Claude Code. Aucune fuite de données, mais le skill était non fonctionnel hors de son environnement d'origine.

## Correctif appliqué (2026-09-13)

- Remplacé `ApiClient` par un client HTTP standard (`SimilarWebClient`, basé sur `requests`) authentifié via la variable d'environnement `SIMILARWEB_API_KEY` — jamais de clé en clair.
- Testé la logique du client : erreur explicite (`RuntimeError`) si la clé est absente, construction correcte des paramètres de requête sinon (vérifié en exécutant le code, pas juste en le relisant).
- Les 7 exemples d'appel (rang global, visites, visiteurs uniques, taux de rebond, sources desktop/mobile, trafic par pays) réécrits pour utiliser ce client, en gardant les mêmes paramètres documentés (domain, dates, granularité, pays, limit) pour ne pas changer le comportement attendu du skill.
- Le endpoint `global-rank` (`/v1/website/{domain}/global-rank/global-rank`) a été vérifié comme réel et stable via la documentation SimilarWeb publique. Les autres chemins (`/v5/website-analysis/websites/...`) suivent la structure documentée de l'API v5 au moment de la rédaction, mais SimilarWeb segmente l'accès à certains endpoints par plan d'abonnement (Standard/Enterprise) — signalé explicitement dans le `SKILL.md` corrigé pour que l'utilisateur vérifie le chemin exact dans sa propre documentation de compte avant un usage en production, plutôt que de laisser croire à une certitude que je n'ai pas pu vérifier à 100%.
- Ajouté une section gestion des erreurs (`raise_for_status()` + explication des codes 401/403/429) pour éviter les échecs silencieux constatés dans la version d'origine.

**Sécurité (après correctif)** : Aucune clé en clair, gestion d'erreur explicite, dépendance (`requests`) standard et largement auditée. Aucun appel réseau caché — un seul domaine (`api.similarweb.com`), documenté.

**Considération éthique/usage** : Utilise l'API commerciale officielle (pas de scraping du site cible) — pas de violation de ToS en soi. Nécessite un abonnement SimilarWeb payant avec accès API.

**Verdict** : VALIDÉ AVEC RÉSERVE — mécanisme corrigé et testé, fonctionnel dans Claude Code ; réserve unique : vérifier le chemin exact des endpoints non-`global-rank` contre son propre plan d'abonnement SimilarWeb avant un usage en production.
