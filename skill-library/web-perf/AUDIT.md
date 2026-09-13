# Audit — web-perf

**Origine** : externe.

**Résumé** : Guide d'audit de performance web (Core Web Vitals, Lighthouse) qui s'appuie sur les outils MCP `chrome-devtools`, avec seuils chiffrés (LCP, CLS, INP...), une checklist en 5 phases, et une phase optionnelle d'analyse du code source (bundler, tree-shaking, polyfills).

**Sécurité** : Référence trois URLs externes (web.dev, developer.chrome.com, github.com/ChromeDevTools) comme sources à consulter — domaines légitimes et connus, lecture seule, aucune exfiltration. Le skill indique explicitement de ne modifier une config MCP que dans le périmètre autorisé par l'utilisateur, sinon de demander d'abord — bon réflexe, pas un contournement de garde-fou. Aucun identifiant, aucun script.

**Qualité/utilité** : Très détaillé et actionnable (tableaux de seuils, exemples d'appels d'outils, format de sortie standardisé), avec de bons réflexes ("quantifier l'impact avant de recommander"). Dépend implicitement du MCP `chrome-devtools` sans le déclarer comme prérequis formel — sans ce MCP, les phases 1 à 4 échoueraient silencieusement.

**Verdict** : VALIDÉ AVEC RÉSERVE — contenu de qualité et sourcé correctement, mais dépendance MCP non déclarée et accès web supposé non vérifié avant usage.
