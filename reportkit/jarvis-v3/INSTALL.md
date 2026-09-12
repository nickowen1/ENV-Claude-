# Installer Jarvis

Ce guide sert à deux usages :
1. Le suivre toi-même, pas à pas, pour une installation propre.
2. Le donner tel quel à Claude ("installe Jarvis dans ce dossier en suivant INSTALL.md") pour qu'il exécute la partie technique à ta place — la section [Checklist pour Claude](#checklist-pour-claude) est écrite pour ça.

## Ce que tu es en train d'installer

`JARVIS/` (ce dossier) est le **cerveau** : toute ta mémoire (identité, projets, décisions, règles) vit dans ses fichiers `.md`, pas dans la mémoire d'un modèle. `.claude/` est un **adaptateur** léger propre à Claude Code — il ne contient jamais de logique dupliquée, seulement des pointeurs vers `00_SYSTEM/`. Le jour où tu branches un autre outil (Antigravity, etc.), tu crées un adaptateur équivalent pour cet outil, sans jamais toucher au cerveau.

## Prérequis

- [Claude Code](https://claude.com/claude-code) installé.
- Git installé et configuré.
- Python 3 disponible dans le PATH (utilisé par le hook de sauvegarde automatique — voir plus bas). Vérifier avec `python3 --version` (Linux/Mac) ou `python --version` (Windows).
- **Si tu es sous Windows** : active le **mode développeur** avant de cloner/utiliser ce dossier — Paramètres → Confidentialité et sécurité → Pour les développeurs → activer "Mode développeur". Ça permet de créer des liens symboliques sans droits administrateur (nécessaire pour l'étape des skills ci-dessous).

## Étapes d'installation

### 1. Placer JARVIS comme racine de travail

Ouvre Claude Code directement à la racine de ce dossier `JARVIS/` (celui qui contient ce fichier `INSTALL.md` et `CLAUDE.md`). C'est ce dossier que tu ouvres à chaque session — `CLAUDE.md` est chargé automatiquement parce qu'il est à la racine du dossier ouvert.

### 2. Vérifier les adaptateurs `.claude/`

Ce dossier fourni contient déjà :
- `.claude/commands/*.md` — un petit fichier par commande (`/prime`, `/save`, ...), qui importe le contenu réel depuis `00_SYSTEM/commands/`.
- `.claude/skills/*` — un lien symbolique par skill vers `00_SYSTEM/skills/`.
- `.claude/settings.json` — la règle qui demande confirmation avant toute écriture dans `01_IDENTITY/` ou `03_PROJECTS/`, et le hook qui sauvegarde automatiquement l'ancienne version d'un fichier avant modification.

**Sous Windows**, si Git n'a pas matérialisé les liens symboliques de `.claude/skills/` (voir [Dépannage](#dépannage-symlinks-windows) ci-dessous), recrée-les :

```powershell
cd .claude\skills
New-Item -ItemType SymbolicLink -Path "weekly-digest" -Target "..\..\00_SYSTEM\skills\weekly-digest"
New-Item -ItemType SymbolicLink -Path "snapshot-cleaner" -Target "..\..\00_SYSTEM\skills\snapshot-cleaner"
New-Item -ItemType SymbolicLink -Path "voice-note-formatter" -Target "..\..\00_SYSTEM\skills\voice-note-formatter"
New-Item -ItemType SymbolicLink -Path "consistency-checker" -Target "..\..\00_SYSTEM\skills\consistency-checker"
```

### 3. Premier lancement

Dans Claude Code, tape `/prime`. C'est la première commande à exécuter — elle amorce l'onboarding et te guide pour remplir `01_IDENTITY/profile.md`, `objectives.md` et `preferences.md`.

### 4. Vérifier que ça fonctionne

- Un fichier modifié dans `01_IDENTITY/` ou `03_PROJECTS/` doit déclencher une demande de confirmation avant l'écriture (règle de `.claude/settings.json`).
- Après une telle écriture, une copie horodatée doit apparaître dans le `_versions/` correspondant.
- `/snapshot [projet] "test"` doit créer un dossier dans `[projet]/snapshots/`.

## Sécurité — clés API

`05_APIS/*.md` sont des gabarits (nom du service, projet concerné) — **n'écris jamais une vraie clé directement dedans**. Le champ "Référence secret" attend le nom d'une variable d'environnement ou d'une entrée dans ton gestionnaire de secrets, pas la valeur elle-même. Les vraies valeurs vont dans un fichier local ignoré par Git (`.env`, `*.local.md`, `secrets/` — déjà exclus par `05_APIS/.gitignore`) ou directement dans un service externe (1Password, Vault, etc.).

## Dépannage symlinks Windows

Si `.claude/skills/<nom>/SKILL.md` semble vide ou si le dossier `<nom>` est en fait un petit fichier texte contenant un chemin (au lieu d'un vrai dossier) :

1. Vérifie que le mode développeur est actif (voir Prérequis).
2. Configure Git avant de recloner : `git config --global core.symlinks true`.
3. Si le dossier existe déjà avec des symlinks cassés, recrée-les avec les commandes PowerShell de l'étape 2 ci-dessus.
4. Si rien n'y fait, solution de repli : copie manuellement le contenu de `00_SYSTEM/skills/<nom>/` vers `.claude/skills/<nom>/` — ça fonctionne, mais tu perds la synchronisation automatique : toute modification du skill devra être recopiée à la main.

## Ajouter un futur outil (Antigravity, etc.)

Ne touche jamais à `00_SYSTEM/`, `01_IDENTITY/`, etc. Crée un nouveau dossier adaptateur au nom de l'outil (ex. `.antigravity/`), avec l'équivalent de ce que fait `.claude/` : un moyen de charger `CLAUDE.md` (ou un fichier d'instructions racine similaire) au démarrage, et un moyen d'accéder aux commandes/skills de `00_SYSTEM/`. Toute la mémoire accumulée (projets, décisions, historique) sera immédiatement disponible, puisqu'elle vit dans les fichiers, pas dans un outil en particulier.

---

## Checklist pour Claude

*Si on te demande d'installer Jarvis dans ce dossier, exécute ces étapes dans l'ordre et rapporte le résultat de chacune :*

1. Vérifier que `CLAUDE.md` est présent à la racine du dossier ouvert. Si non, prévenir l'utilisateur que ce dossier n'est probablement pas la racine de JARVIS.
2. Vérifier que `python3` (ou `python`) est disponible (`python3 --version`). Si absent, prévenir que le hook de sauvegarde automatique ne fonctionnera pas tant que Python n'est pas installé.
3. Vérifier que chaque fichier de `.claude/commands/*.md` référence bien un fichier existant dans `00_SYSTEM/commands/`.
4. Pour chaque dossier dans `.claude/skills/`, vérifier qu'il contient réellement un fichier `SKILL.md` lisible (pas un lien symbolique cassé). Si un lien est cassé, le recréer (voir section Dépannage) ou proposer la solution de repli (copie).
5. Vérifier que `.claude/settings.json` est un JSON valide et contient bien les règles `ask` et le hook `PreToolUse`.
6. Ne rien modifier dans `01_IDENTITY/` ou `03_PROJECTS/` sans validation explicite de l'utilisateur, conformément à la règle générale du système.
7. Une fois ces vérifications faites, proposer à l'utilisateur de lancer `/prime` pour démarrer l'onboarding.
