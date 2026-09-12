# Audit — Jarvis v3

**Auditeur :** Claude (Sonnet 5), à la demande de Collins.
**Méthode :** lecture intégrale des 96 fichiers de l'archive `JARVIS-v3.zip` fournie, discussion contradictoire avec l'auteur sur les points de conception, puis application des corrections validées ensemble directement dans cette copie.

## Ce qu'est Jarvis

Ce n'est pas une application ou un script exécutable : c'est un système de contexte pour un assistant IA — un ensemble de fichiers Markdown (`CLAUDE.md`, commandes, skills, gabarits, dossiers d'identité et de gouvernance) destiné à faire d'un modèle comme Claude un "second cerveau" personnel durable, avec mémoire persistante dans les fichiers plutôt que dans une conversation.

## Points forts

- **Séparation des responsabilités claire** : identité (`01_IDENTITY`), gouvernance (`02_GOVERNANCE`), projets (`03_PROJECTS`), système (`00_SYSTEM`) ne se chevauchent pas.
- **Principe transverse tenu partout** : "jamais d'écriture, de suppression ou de migration sans validation explicite" — répété et appliqué de façon cohérente dans les 9 commandes et les 4 skills d'origine, jamais contredit d'un fichier à l'autre.
- **Distinction propre** entre `/save` (continuité de session, écrit dans `_versions/`), `/snapshot` (point de restauration nommé, écrit dans `snapshots/`) et l'archivage (`archived/` → `07_ARCHIVES/` après 3 mois, jamais automatique).
- **`livrables/` protégé par construction** : exclu explicitement des opérations de snapshot/rollback, pour ne jamais perdre un produit fini lors d'une restauration.
- **Skills bien délimités** : chaque `SKILL.md` a un déclencheur précis (automatique vs explicite) et une section "ce que ce skill ne fait pas" qui borne clairement son périmètre.
- **Conception pensée pour la portabilité** : la mémoire vit dans des fichiers texte ordinaires, pas dans la mémoire propriétaire d'un modèle — ce qui la rend en principe transportable vers n'importe quel outil capable de lire des fichiers et de suivre des instructions (voir section Architecture ci-dessous).

## Risques identifiés et corrections appliquées

### 1. Sécurité — clés API en clair (sévérité : haute)

**Constat initial** : `05_APIS/*.md` invitait à écrire une clé API en clair dans un fichier potentiellement versionné — en contradiction avec la règle énoncée dans `CLAUDE.md` elle-même ("je ne stocke jamais de clé API en clair de ma propre initiative").

**Correction appliquée** :
- Le champ "Clé API" a été remplacé, dans les 8 fichiers de `05_APIS/`, par un champ "Référence secret" (nom de variable d'environnement ou d'entrée dans un gestionnaire de secrets, jamais la valeur elle-même).
- Ajout de `05_APIS/.gitignore` excluant tout fichier `.env`, `*.local.md` ou dossier `secrets/` où une vraie valeur pourrait atterrir localement.

### 2. Aucune règle critique appliquée techniquement (sévérité : haute)

**Constat initial** : la validation avant écriture, la sauvegarde horodatée avant modification, et l'exclusion de `livrables/` des opérations de snapshot/rollback reposaient entièrement sur le fait que le modèle suive correctement des instructions en langage naturel — sans aucun garde-fou technique. Sur une session longue ou un contexte compressé, ce type de règle peut se diluer.

**Corrections appliquées** :
- `.claude/settings.json` exige désormais une confirmation explicite sur tout `Write`/`Edit` ciblant `01_IDENTITY/**` ou `03_PROJECTS/**` — la validation n'est plus une simple instruction, c'est une permission bloquante.
- Un hook `PreToolUse` (`00_SYSTEM/scripts/backup_before_write.py`) sauvegarde automatiquement l'ancienne version d'un fichier dans son `_versions/` avant toute écriture sur ces mêmes chemins — ce n'est plus une étape que le modèle doit se rappeler de faire.
- `00_SYSTEM/scripts/snapshot.sh` / `.ps1` et `rollback.sh` / `.ps1` : l'exclusion de `livrables/` est codée en dur dans les scripts, pas décrite en prose à suivre manuellement. `/snapshot` et `/rollback` ont été mis à jour pour les appeler.

### 3. État de `weekly-digest` non persisté (sévérité : moyenne — trou réel, pas juste une question de discipline)

**Constat initial** : la règle "une fois par semaine maximum" supposait que le modèle se souvienne, d'une session à l'autre, s'il avait déjà généré un digest — alors qu'aucune session Claude Code fraîche n'a de mémoire des sessions précédentes. Rien dans l'architecture ne permettait réellement de vérifier cette condition.

**Correction appliquée** : ajout de `09_DASHBOARD/.digest_state.md`, lu et mis à jour par le skill `weekly-digest` à chaque génération. La règle devient vérifiable par lecture de fichier, plus une question de mémoire conversationnelle.

### 4. Commandes et skills hors des emplacements natifs de Claude Code (sévérité : moyenne, débattue avec l'auteur)

**Constat initial** : `00_SYSTEM/commands/` et `00_SYSTEM/skills/` ne sont pas les emplacements que Claude Code reconnaît nativement (`.claude/commands/`, `.claude/skills/`). Tel quel, `/prime` ne fonctionnait que si le modèle choisissait de lui-même d'aller lire le bon fichier — un déclenchement "souple", jamais garanti.

**Discussion et décision** : l'auteur a été clair sur l'intention de fond — Jarvis doit rester un cerveau portable entre plusieurs outils (Claude Code aujourd'hui, potentiellement d'autres demain), pas un sous-dossier propriétaire de Claude Code. Solution retenue : `00_SYSTEM/` reste l'unique source de vérité, jamais dupliquée ; `.claude/` n'est qu'un adaptateur fin :
- `.claude/commands/*.md` importe le contenu réel via la syntaxe d'inclusion native de Claude Code (`@00_SYSTEM/commands/...`).
- `.claude/skills/*` sont des liens symboliques vers `00_SYSTEM/skills/*`.

Ce choix élimine le vrai problème (duplication de contenu qui aurait pu diverger avec le temps) sans sacrifier la fiabilité du déclenchement natif.

**Correction complémentaire** : la section "Commandes disponibles" de `CLAUDE.md` était purement descriptive ("voir 00_SYSTEM/commands/ pour le détail"), sans jamais dire explicitement au modèle *quand* aller lire ces fichiers. Elle a été réécrite en règle d'exécution impérative : toute commande tapée par Collins déclenche la lecture immédiate et obligatoire du fichier correspondant.

### 5. Absence de documentation d'installation (sévérité : moyenne — confirmée en pratique)

**Constat initial** : rien n'expliquait comment brancher concrètement ce dossier sur une session Claude Code réelle. L'auteur a rapporté s'être effectivement perdu en tentant d'installer le système sur sa machine (Windows), en particulier sur les liens symboliques.

**Correction appliquée** : ajout de `INSTALL.md` — guide pas-à-pas humain, section dédiée aux prérequis Windows (mode développeur, `git config core.symlinks`), section dépannage symlinks, et une checklist directement adressée à Claude pour une installation semi-automatisée.

### 6. Incohérence mineure de vocabulaire (sévérité : basse, non corrigée)

`CLAUDE.md` renvoie à "la mécanique de snapshot" à la fois pour `save.md` (qui écrit dans `_versions/`) et `snapshot.md` (qui écrit dans `snapshots/`), alors que ce sont deux mécanismes distincts. Signalé ici pour information ; non corrigé pour rester dans le périmètre validé avec l'auteur — à ajuster via `/update` si cela crée une confusion réelle à l'usage.

### 7. Dossiers/placeholders vides

`00_SYSTEM/agents/`, `00_SYSTEM/workflows/`, `00_SYSTEM/prompts/`, sous-dossiers de `04_KNOWLEDGE/` — normal pour un template fraîchement initialisé, pas un défaut.

## Architecture retenue : un cerveau, plusieurs corps

Point discuté en détail avec l'auteur, à conserver comme principe directeur pour la suite : la mémoire de Jarvis (historique, projets, décisions) vit exclusivement dans les fichiers Markdown de ce dossier, jamais dans la mémoire interne d'un modèle. Un changement d'outil (Claude Code → Antigravity, ou un autre modèle) ne fait donc pas disparaître l'historique : il suffit de construire, pour le nouvel outil, un adaptateur équivalent à `.claude/` qui sait charger `CLAUDE.md` et lire `00_SYSTEM/`. Le cerveau ne bouge jamais ; seul l'adaptateur change.

## Verdict global

Conception prompt-engineering cohérente et bien pensée pour un usage personnel durable. Pas de code applicatif, donc pas de vulnérabilité "classique" (injection, etc.), mais deux fragilités réelles ont été identifiées et corrigées dans cette copie : un vrai risque de fuite de secrets (gabarit de clé API en clair) et une dépendance totale à la discipline du modèle pour des règles critiques (validation, sauvegarde, exclusions) qui sont maintenant, en partie, garanties techniquement plutôt que déclaratives. L'intention de portabilité multi-outils, elle, était déjà correcte dans la conception d'origine — elle est maintenue et renforcée par le choix des adaptateurs fins plutôt que la duplication.

## Suite

La bibliothèque de skills (`skill-library/`) n'est pas traitée dans cet audit — mise en pause à la demande de l'auteur, pour un tour de discussion séparé une fois cette base validée.
