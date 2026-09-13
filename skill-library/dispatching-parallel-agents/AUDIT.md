# Audit — dispatching-parallel-agents

**Origine** : externe.

**Résumé** : Méthodologie pour décider quand décomposer un travail en sous-agents indépendants exécutés en parallèle, avec un modèle de prompt d'agent et un exemple réel de session de refactoring.

**Sécurité** : Rien à signaler. Aucun réseau, aucun script, aucun identifiant. Le seul risque théorique (des agents parallèles qui modifient du code sans supervision) est explicitement mitigé par le skill lui-même ("Constraints: Don't change other code", étape "Review and Integrate" avant intégration).

**Qualité/utilité** : Méta-processus clair et bien argumenté (arbre de décision, contre-exemples "Common Mistakes"), directement applicable. Limite mineure : l'exemple concret est très spécifique à son contexte d'origine et n'apporte rien de généralisable au-delà de l'illustration déjà donnée — un peu de remplissage, sans nuire à la clarté d'ensemble.

**Verdict** : VALIDÉ — instructions cohérentes, garde-fous explicites contre les conflits entre agents, aucun contenu à risque.
