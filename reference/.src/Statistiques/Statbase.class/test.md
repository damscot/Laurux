# Statbase — Tests

> Source : `.src/Statistiques/Statbase.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI modal en lecture seule : `replay` depuis Statistiques › « Statistiques utilisation
base Laurux » (`Fmenu.Menu250`). Rejouable (`Utils.Observers` une fois). Comparaisons : texte
des 10 `TextLabel` (journal ou capture), 10 lignes `Exec_SQL` ; base inchangée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATBASE-T01 | replay | Compteurs sur la base de référence | `Laurux01.sql` | 10 valeurs (1 article, 1 MO, …) | `tests/statbase_reference/` | à faire |
| STATBASE-T02 | replay | Compteurs sur le jeu de ventes | `statistiques_ventes` (tickets en cours **et** archivés, factures `HistoFacM`, BL `B`/`D`/`F`) | valeurs de référence ; « tickets archivés » = tickets en cours (A01 figée) ; factures d'entretien non comptées (A02 figée) | `tests/statbase_ventes/` | à faire |
| STATBASE-T03 | replay | SQLite | `Laurux01.sqlite` | mêmes valeurs que T01 | `tests/statbase_sqlite/` | à faire |
| STATBASE-T04 | gbtest | `Compteurs()` (après STATBASE-003) | jeu de T02 | collection identique aux valeurs de T02 | `tests/statbase_compteurs/` | à faire |

## Détail des tests

- Valeurs attendues produites dans le clone **non modifié**.
- Jeu `statistiques_ventes` décrit dans [StatComm/test.md](../StatComm.class/test.md).
