# LVar — Tests

> Source : `.src/Utils/LVar.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LVAR-T01 | gbtest | `Evaluate` simple | contexte `{"$numbl": "BL12"}`, expressions `"$numbl & \"-x\""`, `""`, expression invalide | `"BL12-x"` ; `defout` ; `defout` | `tests/evaluate/` | à faire |
| LVAR-T02 | gbtest (BDD) | `ParseResult` | `SELECT * FROM Fiches_Comptes LIMIT 1` (`Laurux01.sql`), puis `Evaluate("$compte")` | valeur du champ ; collection de l'appelant modifiée | `tests/parse_result/` | à faire |
| LVAR-T03 | gbtest | `AddDate` | dates 05/01/2005, 15/06/2024, 31/12/2026 ; préfixe `""` et `"ech_"` | toutes les variables (anomalies `annee2` et `moistr` figées) | `tests/add_date/` | à faire |
| LVAR-T04 | gbtest | Priorité des sources | variable appelant `$compte` puis `ParseResult` avec un champ `compte` | valeur du champ (écrasement figé) | `tests/priorite/` | à faire |
| LVAR-T05 | gbtest | Infobulle | `Parent` = `TextBox` hors fenêtre avec infobulle `"Aide"`, sans séparateur, puis 2e `LVar` sur le même contrôle | infobulle exacte figée (perte de « Aide », lignes vides) | `tests/infobulle/` | à faire |
| LVAR-T06 | replay | Libellé automatique d'écriture | `Saisecrit` : saisie d'une écriture sur un compte ayant un `libel_def` utilisant `$moistr` et `$annee` ; table `Fiches_Mvt` | libellé généré identique | `tests/replay_libelle_auto/` | à faire |

## Détail des tests

- **Valeurs attendues** : gbtest exécutés dans le clone non modifié (`id;valeur`) ; T06 capturé
  puis rejoué, diff de `Fiches_Mvt`.
- **Données** : `Laurux01.sql` pour T02 et T06 ; T06 nécessite un compte avec `libel_def`
  renseigné (jeu dérivé : `UPDATE Fiches_Comptes SET libel_def = …`).
- T05 crée un contrôle sans l'afficher : faisable en gb.test si `gb.gui` est chargé (à confirmer en
  phase 2) ; sinon, à basculer en replay.
