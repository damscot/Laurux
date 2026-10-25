# Cbalances — Tests

> Source : `.src/Reports/Cbalances.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit PDF sans accès à la base : tests gb.test directs (valeurs fixes, `Output`, `pdftotext
-layout`), plus deux replays de bout en bout sur le jeu comptable dérivé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CBALANCES-T01 | gbtest | Balance avec cumul hors période | `Entete`, `Level0`, `Level1`, 3 × `Level2`, `Level3`, `Level4`, `BasPage` | texte `pdftotext` de référence | `tests/balance_hors_periode/` | à faire |
| CBALANCES-T02 | gbtest | Balance sans cumul hors période | `Level1a`, `Level2a` avec (`"12.5"`, `"0"`), (`""`, `"3"`), (`"1234.56"`, `"1234.56"`), `Level3a`, `Level4a` | soldes et cellules vides de référence | `tests/balance_simple/` | à faire |
| CBALANCES-T03 | gbtest | État de TVA | `Level0T`, `Level1T`, `Level3T`, `Level2T` (`"0"`, `Null`), `Level4T`, `Level4TVA` (`"1"`, `"2"`), `Level5T` (tots ≤ 0 et > 0) | texte de référence (les deux branches de `Level5T` identiques) | `tests/tva/` | à faire |
| CBALANCES-T04 | gbtest | Multi-pages | `AliasNbPages`, 3 pages (`Entete` + 60 `Level2a` + `BasPage`) | `Page 1/3` … `Page 3/3` | `tests/multipages/` | à faire |
| CBALANCES-T05 | replay | Balance générale (`Balance` → `BalanceM`) | jeu comptable dérivé, plage 1… à 7…, avec et sans cumul hors période | `pdftotext` identique entre clones ; dump BDD identique | `tests/replay_balance/` | à faire |
| CBALANCES-T06 | replay | État de TVA (`FTVA`, bouton « Imprimer ») | jeu dérivé avec écritures 445…, période mensuelle puis annuelle | `pdftotext` de `~/tmp/TVA.pdf` identique entre clones | `tests/replay_tva/` | à faire |

## Détail des tests

- **Outil commun** : extraction et normalisation des PDF (date, utilisateur, métadonnées) par le
  script commun `check_output.py` décrit dans [PdfWriter/test.md](../PdfWriter.class/test.md).
- **Valeurs attendues** : produites par le même module gb.test (et les mêmes scénarios) dans le
  clone **Laurux non modifié**, stockées dans `tests/<nom>/expected/` (texte `pdftotext -layout`).
- **Normalisation** : date et `User.Name` du pied de page remplacés par des jetons (ou `faketime`).
- **Données** : jeu comptable dérivé de [Balance/test.md](../../Compta/Impressions/Balance.class/test.md)
  (`Laurux01.sql` n'a aucune écriture), complété d'écritures de TVA pour T06.
- **Rework sans changement de texte mais avec changement d'octets** (suppression du `SetFont`
  superflu de `Level3`) : comparaison `pdftotext` + rendu raster `pdftoppm`, pas d'égalité binaire.
- **Couverture visée** : 100 % hors `Level2s`, `Level2sbis`, `_free` (suppression prévue).
