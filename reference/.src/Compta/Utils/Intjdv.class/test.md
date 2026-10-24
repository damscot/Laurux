# Intjdv — Tests

> Source : `.src/Compta/Utils/Intjdv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La fenêtre n'a **aucun point d'entrée** : aucun replay n'est possible. Le test ci-dessous n'est à
réaliser **que si l'anomalie INTJDV-A01 (suppression) est refusée**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| INTJDV-T01 | gbtest | Saisie et traitement sous Xvfb | `New Intjdv`, journal `VE` de `Laurux01.sql`, fichier texte à positions fixes de 3 lignes dont l'en-tête société | table `centralisation` recréée vide ; aucune autre table modifiée (dump identique) ; réglages `/Rep_Jdv`, `/Jdv` | `tests/integration_inoperante/` | à faire (conditionnel) |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié ; seul effet observable en base
  : la table `centralisation` (DROP/CREATE).
- Si INTJDV-A01 est acceptée, la validation se limite à `gbc3 -agt` et à un `grep` confirmant
  l'absence de référence.
