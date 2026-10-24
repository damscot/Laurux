# VerifDate — Tests

> Source : `.src/Utils/VerifDate.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La classe lit la base et affiche des `Message.Warning` : les cas « date refusée » bloquent sans
GUI. Les tests `gbtest` couvrent la construction et les cas acceptés (renvoi `False` sans
message) ; les cas refusés sont couverts par des scénarios `replay` sur les écrans appelants,
jusqu'à la séparation traitement/GUI (VERIFDATE-004) qui rendra les prédicats purs testables.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VERIFDATE-T01 | gbtest (BDD) | Construction sans option B/T | `Laurux01.sql`, date du jour | `DateCom.DT`, `DateGes.DT` de référence ; `DateSus`/`DateAcq` Null | `tests/construction_std/` | à faire |
| VERIFDATE-T02 | gbtest (BDD) | Construction option B/T | jeu dérivé avec `Fiches_regie`/`Fiches_ligregie` (suspendu et acquitté) | `DateSus.DT`, `DateAcq.DT` | `tests/construction_bt/` | à faire |
| VERIFDATE-T03 | gbtest (BDD) | Repli sur `arrete` | jeu dérivé B/T sans mouvement de régie, `arrete = "12.2023"` | `DateSus` = `DateAcq` = 01/01/2024 | `tests/repli_arrete/` | à faire |
| VERIFDATE-T04 | gbtest (BDD) | `ClotFac` accepté | dates dans la fenêtre de deux mois | `False` | `tests/clotfac_ok/` | à faire |
| VERIFDATE-T05 | gbtest (BDD) | `ClotDroi` accepté | article sans droit, droit non suspendu, option standard | `False` | `tests/clotdroi_ok/` | à faire |
| VERIFDATE-T06 | replay | `ClotComptable` refusé | écran `SaiReg` : saisie d'un règlement daté avant `dtefedec` ; tables comparées : `Fiches_Reglements` inchangée | message + aucune écriture | `tests/replay_clotcompta/` | à faire |
| VERIFDATE-T07 | replay | `ClotGestion` refusé | écran `Facture` (validation d'une facture datée avant la période en cours, puis après la fin du mois suivant) ; `Fiches_HistoFac` inchangée | deux messages distincts | `tests/replay_clotgestion/` | à faire |
| VERIFDATE-T08 | replay | `ClotDroi` refusé (B/T) | écran `Mvtex` : mouvement d'un article à droit suspendu daté avant `DateSus` ; `Fiches_ligregie` inchangée | message + aucune écriture | `tests/replay_clotdroi/` | à faire |
| VERIFDATE-T09 | gbtest (BDD) | `arrete` vide en B/T | jeu dérivé sans mouvement ni `arrete` | erreur levée (texte figé) | `tests/arrete_vide/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié (gbtest : sortie `id;valeur` ;
  replay : capture `./Laurux -l --logfile …` puis dump normalisé des tables citées).
- **Données** : `Laurux01.sql` pour l'option standard ; un jeu dérivé `bt.sql` (option B/T dans la
  configuration de test, quelques lignes `Fiches_regie`/`Fiches_ligregie`, `arrete` renseigné ou
  non).
- **Non testable en gb.test** : tous les chemins `Message.Warning` (couverts par T06-T08).
- L'option `Utils.Option()` est lue depuis la configuration de test (`Laurux.conf` du répertoire du
  test).
