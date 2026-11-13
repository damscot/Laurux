# EcrReg — Tests

> Source : `.src/Compta/Utils/EcrReg.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`reglement` est privé mais son résultat est observable sans écrire en base : après `New EcrReg(…)`,
on lit les lignes de `Vecr` (énumération). Tests `gbtest` sur base jetable (`Laurux01.sql` : modes
de règlement avec et sans `cptint`, journal de banque avec `cde_banque`), puis `replay` des écrans
appelants pour l'écriture complète.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECRREG-T01 | gbtest | `L_ajou` | règlement client 100 € ; mode avec/sans `cptint` | 2 lignes : client + contrepartie (`cptint` ou banque), montants inversés | `tests/ajout/` | implémenté |
| ECRREG-T02 | gbtest | `L_modif` | écriture existante (client + banque), nouveau montant | montants recopiés ou inversés selon le type de compte | `tests/modification/` | implémenté |
| ECRREG-T03 | gbtest | `L_valide` | 3 règlements d'un bordereau | comptes remplacés par `cptint` ; ligne de banque du total, intitulé et libellé | `tests/validation/` | implémenté |
| ECRREG-T04 | gbtest | `L_sup` | écriture existante | toutes les lignes en `L_sup`, racine ajoutée | `tests/suppression/` | implémenté |
| ECRREG-T05 | gbtest | `L_caisse` | 2 encaissements caisse | lignes `Treso`, ligne `L_caisse` du total arrondi | `tests/caisse/` | implémenté |
| ECRREG-T06 | gbtest | Mode de règlement inexistant | `nreg = "ZZ"` | erreur levée (`Error.Raise`), message figé | `tests/reglement_inconnu/` | implémenté |
| ECRREG-T07 | replay | Saisie et validation de bordereau | écran `SaiReg` : saisie de 2 règlements puis validation | dump `Fiches_Mvt`, `Fiches_Comptes` | `tests/bordereau/` | à faire : passe par SaiReg (écran complexe) |

## Détail des tests

- **Valeurs attendues** : produites par les mêmes appels dans le clone Laurux non modifié ; les
  `gbtest` comparent la liste (compte, débit, crédit, état, type) des lignes de `Vecr`.
- Le moulinage de caisse (`Moulinage`) est couvert par les replays du lot Caisse.
- **Implémentation (phase 2, vague 5)** : T01-T06 → `.src/Tests/Compta/EcrRegTest.test` (Laurux01, sans écriture en base) :
  `New EcrReg(mode, journal, VarEcr)` puis relevé de chaque ligne de `Vecr` (compte, débit, crédit, état, type, intitulé,
  libellé, pièce, lot, numéro, date, `racine` = la ligne est `Vecr` lui-même). Modes 05 (`cptint` 580002), 10 (580001),
  20 et 01 (sans `cptint`), journaux 50 (banque 512000) et 53. Constats figés : en `L_ajou` la contrepartie prend le
  libellé comme intitulé ; `L_ajou`, `L_modif`, `L_sup` et `L_caisse` ajoutent `Vecr` à sa propre liste (`plus(Me.Vecr)`),
  et en `L_caisse` la racine est elle-même convertie en ligne de trésorerie (compte remplacé) ; arrondi du total caisse
  `Round(-12.345, -2)` → 12,34 ; T06 : « Réglement innexistant ZZ\nImpossible d'enregistrer l'écriture ».
