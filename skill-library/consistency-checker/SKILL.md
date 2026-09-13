---
name: consistency-checker
description: Vérifie systématiquement, à chaque exécution de /update, qu'une modification ne contredit pas une information déjà présente ailleurs dans le système (autre projet, 01_IDENTITY, 02_GOVERNANCE). Formalise la règle de détection d'incohérence déjà présente dans CLAUDE.md.
---

# Consistency Checker

## Rôle

Systématiser la vérification de cohérence qui est déjà mentionnée en principe dans `CLAUDE.md`, en l'intégrant précisément au moment où le risque d'incohérence apparaît réellement : une écriture volontaire via `/update`.

## Déclenchement

Automatique, à chaque exécution de `/update` — avant que la modification ne soit appliquée.

## Déroulé

1. Identifier le fichier ciblé par `/update` et son contenu proposé.
2. Vérifier les points de friction les plus probables :
   - Contradiction avec `01_IDENTITY/objectives.md` ou `values.md`.
   - Contradiction avec une règle de `02_GOVERNANCE/` (ex : une modification qui ferait dépasser la limite de 2 projets actifs).
   - Contradiction avec un autre projet actif si l'information les concerne tous les deux.
3. Si une contradiction est détectée, la signaler avant d'appliquer la modification :

> "Cette mise à jour semble contredire [élément]. Tu veux quand même l'appliquer, ou on ajuste ?"

4. Si aucune contradiction n'est détectée, procéder normalement à la mise à jour.

## Important

- Ne bloque jamais une écriture de sa propre initiative — signale, propose, mais Collins garde toujours la décision finale, y compris celle de passer outre une incohérence détectée.
- Ne remplace pas une vérification plus large du système (voir la passe de contrôle manuelle déjà pratiquée) — ce skill vérifie ponctuellement au moment d'une écriture, pas l'ensemble du système d'un coup.
