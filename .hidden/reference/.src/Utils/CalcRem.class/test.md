# CalcRem — Tests

> Source : `.src/Utils/CalcRem.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Traitement de masse sur l'historique des factures : tests **replay** sur MariaDB avec diff de
`Fiches_HistoFac` (colonnes `numfac`, `remmofac`, `remartfac`) et des lignes `Exec_SQL` ; après
CALCREM-002, un test **gbtest** de `RecalculeRemises()`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALCREM-T01 | replay | Recalcul nominal | Admin → Programmes → `CalcRem`, « Lancer » ; 3 factures (lignes M, A, autres) | dump `Fiches_HistoFac` ; la **dernière** facture inchangée (A01 figée) | `tests/recalcul/` | implémenté (`.hidden/Tests/Utils/assets/calcrem_recalcul/`, FA3 inchangée : A01 figée) |
| CALCREM-T02 | replay | Montants à décimales longues | lignes dont `brut − net` cumulés donnent un Float non représentable (0,1 + 0,2) | figer la valeur écrite ou l'erreur SQL (A02) | `tests/decimales/` | implémenté (`.hidden/Tests/Utils/assets/calcrem_decimales/`, valeur écrite `0.3` figée) |
| CALCREM-T03 | replay | Historique vide | `Fiches_HistoLigfac` vide | aucune écriture, pas de message | `tests/vide/` | implémenté (`.hidden/Tests/Utils/assets/calcrem_vide/`) |
| CALCREM-T04 | gbtest | `RecalculeRemises()` (après CALCREM-002) | base dérivée de T01 | même dump que T01 | `tests/recalcul_unitaire/` | à faire : après extraction CALCREM-002 |

## Détail des tests

- **Valeurs attendues** : générées dans le clone **Laurux non modifié** (dump normalisé de
  `Fiches_HistoFac` trié par `numfac`).
- **Données** : `Laurux01.sql` + jeu dérivé de 3 factures (5 lignes `M`/`A`/texte) ; pour T02,
  montants `0.1`/`0.2`.
- **Non testable** : son (`Music.Play` sans `Load`).
- **Phase 2** : écran ouvert par Gestion › Utilitaires › Appel programme (`Prgm`, saisie « CalcRem »). Jeux `datasets/calcrem.sql` (FA1 à FA3) et `datasets/calcrem_decimales.sql` (FD1, FD2) ; scénarios `.hidden/Tests/Utils/assets/calcrem_{recalcul,decimales,vide}/`.
