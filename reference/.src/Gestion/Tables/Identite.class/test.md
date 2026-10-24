# Identite — Tests

> Source : `.src/Gestion/Tables/Identite.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : `replay` avec diff de `Fiches_Identite`. Scénarios communs avec
[Centrales](../Centrales.class/test.md). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IDENTITE-T01 | replay | Création | menu Identité ; `24`, `SARLU` ; Enregistrer | ligne insérée | `tests/creation/` | à faire |
| IDENTITE-T02 | replay | Modification | clic `01` ; libellé `SARL2` ; Enregistrer | UPDATE du libellé | `tests/modification/` | à faire |
| IDENTITE-T03 | replay | Relecture à la sortie du code | saisie `03`, Tab | libellé `SA` affiché (`Quitte_Cdtype`) | `tests/relecture_code/` | à faire |
| IDENTITE-T04 | replay | Suppression du code saisi | sélection `01`, code saisi `02` ; Supprimer, Oui | `02` supprimé | `tests/suppression/` | à faire |
| IDENTITE-T05 | replay | Code avec apostrophe | code `0'`, Tab | erreur SQL de `Quitte_Cdtype` (A01 figée) | `tests/apostrophe/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (23 lignes, codes `01` à `23`).
- **Comparaison** : dump normalisé de `Fiches_Identite` ; T03 vérifie la valeur affichée par le log
  de rejeu (pas d'écriture en base).
- **Non testable automatiquement** : couleurs `OBS_*`, ouverture de l'aide (`Doc.Open`).
