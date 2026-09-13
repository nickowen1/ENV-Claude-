# Skill Library

Bibliothèque personnelle de skills Claude auditées avant adoption — skills créées par l'utilisateur (issues de JARVIS) et skills trouvées intéressantes ailleurs (marketplace, GitHub).

## Process

1. Un skill candidat est fourni (fichier, zip, ou dépôt).
2. Audit systématique : lecture complète du `SKILL.md` et de tout fichier associé (références, scripts, manifestes), avec quatre axes :
   - **Résumé** — ce que le skill fait réellement et son déclencheur.
   - **Sécurité** — appels réseau, identifiants en clair, risque d'injection de prompt, code exécutable (lu en entier si présent, jamais juste survolé).
   - **Considération éthique/usage** (quand pertinent) — usage détourné possible, disclosure requise, conformité ToS d'un service tiers.
   - **Qualité/utilité** — clarté, cohérence interne, absence de contradiction, actionnabilité réelle.
3. Verdict final sur une échelle à 4 niveaux :
   - **VALIDÉ** — rien à signaler, utilisable tel quel.
   - **VALIDÉ AVEC RÉSERVE** — utilisable, mais avec un point de vigilance explicite à connaître avant usage.
   - **À CORRIGER AVANT USAGE** — un problème concret empêche un usage fiable tel quel (ex. dépendance cassée).
   - **À ÉVITER** — risque de sécurité ou de conformité qui déconseille l'usage.
4. Seuls les skills eux-mêmes (`SKILL.md` + `references/` éventuels) sont conservés ici, pas la tuyauterie de packaging (CI, manifestes de marketplace, scripts de build) sauf si elle fait l'objet d'un point d'audit spécifique.

## État actuel — 14 skills audités

| Skill | Origine | Verdict |
|---|---|---|
| `consistency-checker` | JARVIS (utilisateur) | VALIDÉ |
| `snapshot-cleaner` | JARVIS (utilisateur) | VALIDÉ |
| `weekly-digest` | JARVIS (utilisateur) | VALIDÉ |
| `voice-note-formatter` | JARVIS (utilisateur) | VALIDÉ AVEC RÉSERVE |
| `dispatching-parallel-agents` | Externe | VALIDÉ |
| `web-design-reviewer` | Externe | VALIDÉ |
| `chrome-devtools` | Externe | VALIDÉ AVEC RÉSERVE |
| `web-perf` | Externe | VALIDÉ AVEC RÉSERVE |
| `prompt-engineer` | Externe | VALIDÉ AVEC RÉSERVE |
| `claude-automation-recommender` | Externe | VALIDÉ AVEC RÉSERVE |
| `find-skills` | Externe | VALIDÉ AVEC RÉSERVE |
| `muapi-ugc-video-factory` | Externe | VALIDÉ AVEC RÉSERVE |
| `humanizer` | Externe | VALIDÉ AVEC RÉSERVE |
| `similarweb-analytics` | Externe | VALIDÉ AVEC RÉSERVE *(corrigé le 2026-09-13)* |

Détail de chaque verdict dans le `AUDIT.md` du dossier correspondant.

## À surveiller particulièrement (lire avant usage, pas juste le tableau)

- **`similarweb-analytics`** : corrigé — importait à l'origine un module propre à la plateforme Manus, remplacé par un vrai client HTTP testé. Réserve restante : vérifier le chemin exact des endpoints (hors `global-rank`, confirmé stable) contre son propre plan d'abonnement SimilarWeb avant un usage en production.
- **`muapi-ugc-video-factory`** : génère des vidéos publicitaires imitant un témoignage utilisateur authentique à partir d'une photo réelle — s'assurer du consentement de la personne et divulguer le caractère généré/synthétique avant toute diffusion publicitaire.
- **`humanizer`** : supprime les "signatures" stylistiques de texte généré par IA. Le skill est honnêtement cadré autour de la qualité d'écriture (pas de mention de contournement de détecteurs), mais le mécanisme reste par nature à double usage — à ne pas utiliser dans un contexte académique ou de conformité de plateforme sans réflexion préalable.
- **`find-skills`** : fait reposer la découverte/installation de skills sur un registre tiers non-Anthropic (skills.sh) et sur `npx skills add ... -y`, qui saute la confirmation d'installation — suivre les vérifications que le skill recommande lui-même (réputation, nombre d'installs) avant d'accepter une suggestion.
