# Epurjdv — Tests

> Source : `.src/Compta/Utils/Epurjdv.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

La fenêtre n'a **aucun point d'entrée** (ni menu, ni appel) : aucun replay n'est possible. Les
tests ci-dessous ne sont à réaliser **que si l'anomalie EPURJDV-A01 (suppression) est refusée**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EPURJDV-T01 | gbtest | Calcul des dates (`Form_Open`, `Aff_date`) sous Xvfb | `New Epurjdv` + `Show` sur `Laurux01.sql` (dates de clôture connues) | textes de `datecl` / `dateprc` de référence | `tests/dates_periode/` | à faire (conditionnel) |
| EPURJDV-T02 | gbtest | Épuration complète sous Xvfb (`Button1_Click`, confirmation simulée) | copie jetable de `Laurux01.sql`, case cochée puis décochée | dump normalisé de `Fiches_Mvt*` et `Fiches_Parametres` ; fichier `~/Laurux_<AAAA>.sql` présent | `tests/epuration/` | à faire (conditionnel) |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié, sur une base MariaDB
  jetable (le traitement est destructeur et exige `/dbase/Host` = `127.0.0.1`).
- **Non testable** : SQLite (`ALTER TABLE … RENAME` sans `TO` échoue, `mysqldump` sans objet).
- Si EPURJDV-A01 est acceptée, la seule validation est `gbc3 -agt` après suppression et un `grep`
  confirmant l'absence de référence.
