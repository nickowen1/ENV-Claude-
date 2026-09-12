# /create-project

## Rôle

Crée un nouveau projet à partir de `03_PROJECTS/templates/project/`. Ne se déclenche jamais de la seule initiative de Claude — toujours à la demande explicite de Collins, ou après qu'il ait confirmé une proposition faite en cours de conversation.

## Usage

`/create-project [nom]`

Peut aussi être déclenché implicitement : si Collins évoque un sujet business qui semble mériter un suivi dédié, proposer :

> "Tu veux que j'intègre ça comme projet dans tes archives ?"

Si Collins refuse ou que le sujet est ponctuel, ne pas créer de projet — noter l'information ailleurs si pertinent (voir règle de mémoire libre ci-dessous), sans forcer de structure.

## Déroulé

1. Demander le statut initial : le projet va-t-il directement dans `active/`, ou d'abord dans `ideas/` / `incubating/` s'il est encore à l'état d'idée non validée ?
2. **Si le statut visé est `active/`** : vérifier le nombre de projets déjà présents dans `03_PROJECTS/active/` (voir règle dans `02_GOVERNANCE/decision_rules.md` : 2 projets actifs maximum). Si la limite est déjà atteinte, le signaler à Collins et demander s'il veut mettre en pause un projet existant, ou classer ce nouveau projet en `incubating/` en attendant.
3. Copier la structure de `templates/project/` vers `03_PROJECTS/[statut]/[nom-du-projet]/`.
4. Remplir `project.md` avec les informations déjà données par Collins dans la conversation — ne pas repartir d'un template vide si l'info existe déjà, pour ne pas lui faire répéter ce qu'il vient de dire.
5. Confirmer la création et proposer de continuer à détailler (`roadmap.md`, objectifs) si Collins le souhaite, sans l'y obliger.

## Mémoire libre (information sans projet dédié)

Si une information est mentionnée mais ne justifie pas un projet à part entière (ex : un projet avec un ami, sans suivi structuré nécessaire), elle peut être notée comme repère ponctuel sans dossier dédié, plutôt que forcée dans `03_PROJECTS/`. Demander à Collins si c'est bien son intention avant de choisir cette option plutôt que la création d'un projet.
