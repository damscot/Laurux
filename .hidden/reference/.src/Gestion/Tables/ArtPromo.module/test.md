# ArtPromo — Tests

> Source : `.src/Gestion/Tables/ArtPromo.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module SQL sans GUI : tests `gbtest` sur une base MariaDB jetable (`Laurux01.sql` + jeu dérivé
`promo.sql` : une promotion `P1` active, une `P2` active simultanément, deux articles dans `P1` avec
`qte` renseignée et `Null`, un article hors promotion). Les valeurs attendues sont produites en
exécutant les mêmes appels dans le clone **Laurux non modifié** (sortie capturée dans
`tests/<nom>/expected/`), puis comparées avec le dump de `Fiches_ArtPromo`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ARTPROMO-T01 | gbtest | `art_Promo` | article dans `P1` ; article hors promotion ; code promotion inconnu ; chaînes vides | `"T"` / `""` (convention figée) et valeur booléenne après conversion | `tests/appartenance/` | à faire |
| ARTPROMO-T02 | gbtest | `Prix_Promo`, `Prix_Promottc` | mêmes cas | `pht`, `pttc` formatés tels que renvoyés par le driver ; `""` hors promotion | `tests/prix_promo/` | à faire |
| ARTPROMO-T03 | gbtest | `Intitule_Promo` | mêmes cas | `libelle` ; `""` hors promotion | `tests/intitule/` | à faire |
| ARTPROMO-T04 | gbtest | `Maj_qteplus`, `Maj_qtemoins` | +3 puis −1 sur un article à `qte` renseignée, puis sur `qte = Null` ; article hors promotion | dump `Fiches_ArtPromo` (`qte` attendue, `Null` traité comme 0, aucune ligne créée hors promotion) | `tests/quantites/` | à faire |
| ARTPROMO-T05 | replay | Promotion du jour (appelants) | `faketime` sur une date où `P1` et `P2` sont actives ; ouverture de la fiche d'un article de `P2` dans `Articles` | article de `P2` non signalé (A02 figée) ; après ARTPROMO-004, même résultat via `PromoDuJour` | `tests/promo_du_jour/` | à faire |
| ARTPROMO-T06 | gbtest | Concurrence (indicatif) | deux connexions qui appellent `Maj_qteplus` en parallèle sur la même ligne | perte d'incrément possible (A01 figée) ; test non déterministe, à titre indicatif | `tests/concurrence/` | à faire |

## Détail des tests

- **Harnais** : le module gb.test ouvre `Utils.db` sur la base jetable (configuration de test
  `Laurux.conf`), restaure `promo.sql` avant chaque test et compare un dump trié de
  `Fiches_ArtPromo`.
- **SQLite** : T01-T04 rejoués sur `Laurux01.sqlite` (requêtes portables, résultats identiques
  attendus).
- **Non testable de façon déterministe** : la concurrence réelle (T06 indicatif).
