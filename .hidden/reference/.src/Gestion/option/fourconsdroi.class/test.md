# fourconsdroi — Tests

> Source : `.src/Gestion/option/fourconsdroi.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe entièrement morte : aucun comportement observable à figer. Le seul contrôle est la
non-régression après suppression.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FOURCONSDROI-T01 | gbtest | Absence de référence | `grep -rni fourconsdroi .src` ; `gbc3 -agt` après suppression | aucune référence ; compilation sans erreur | `tests/suppression/` | à faire |
| FOURCONSDROI-T02 | replay | Non-régression réception boissons | rejouer CONSIGNE-T06 après suppression | dump identique | `tests/non_regression_reception/` | à faire |

## Détail des tests

- T01 vérifie en particulier que la structure `consigne` n'était pas utilisée comme type ailleurs
  (aucune référence `fourconsdroi.consigne` ni `New Consigne` sans argument dans un contexte de
  structure).
- Les valeurs de T02 sont celles de CONSIGNE-T06 (clone Laurux non modifié).
