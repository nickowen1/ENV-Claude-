---
name: snapshot-cleaner
description: Détecte les snapshots anciens (plus de 3 mois) ou redondants (peu de changement entre deux points proches) dans les dossiers snapshots/ et _versions/, et propose leur nettoyage. Se déclenche à chaque /prime. Ne supprime jamais automatiquement, propose toujours.
---

# Snapshot Cleaner

## Rôle

Éviter l'accumulation silencieuse de snapshots inutiles dans `snapshots/` (niveau projet, agent, ou système) et `_versions/` (versions horodatées avant écriture), en signalant ce qui pourrait être nettoyé.

## Déclenchement

Intégré à `/prime`, comme la vérification de migration vers `07_ARCHIVES`. Vérifie l'état des snapshots à chaque ouverture de session.

## Critères de détection

1. **Ancienneté** : un snapshot vieux de plus de 3 mois (même délai que la règle de migration `03_PROJECTS/archived/` → `07_ARCHIVES/`, pour rester cohérent).
2. **Redondance** : deux snapshots proches dans le temps dont le contenu diffère très peu — signe qu'un des deux n'apporte pas d'information supplémentaire réelle.

## Déroulé

1. Parcourir les dossiers `snapshots/` et `_versions/` concernés.
2. Identifier les candidats selon les deux critères ci-dessus.
3. Si des candidats existent, le signaler brièvement lors du `/prime` :

> "Tu as [N] snapshot(s) qui pourraient être nettoyés (anciens ou redondants). Tu veux que je te montre lesquels ?"

4. Ne jamais supprimer sans validation explicite, projet par projet ou snapshot par snapshot.

## Ce que ce skill ne fait pas

- Ne touche jamais à `livrables/` — ce dossier reste hors de portée de toute opération de nettoyage, comme il l'est déjà pour `/snapshot` et `/rollback`.
- Ne supprime rien automatiquement, même après validation d'un principe général — chaque suppression reste une action explicite et confirmée.
