# VarMajTar — Tests

> Source : `.src/Gestion/Stock/VarMajTar.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`VarMajTar` n'a pas d'écran propre : elle est pilotée par `GesTar` dans la saisie des achats
(`commande1` → `Achat`). `LecArt` exige une `Sailig` réelle (contrôles `Code`, `Px_Rev`) et les
requêtes préparées de `commande1` : ses tests sont des **replays** de l'écran d'achat. Seule la
cascade de prix (`constructiontableau`, lignes 123-137) est reproductible en gb.test, en appelant
directement `LPrix`/`LTaxe` avec les mêmes arguments.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VARMAJTAR-T01 | replay | `LecArt` tarif général | Gestion > Achats > réception : saisie d'un article sans tarif provisoire, ouverture du panneau tarif, modification de la marge, validation | dump `Fiches_TarTemp`, `Fiches_Art` ; lignes `Exec_SQL` (requête `LecArt`) | `tests/lecart_tarif_general/` | à faire |
| VARMAJTAR-T02 | replay | `LecArt` + `requ_cli`/`requ_typ` | article ayant des tarifs `Fiches_Tarcli` (2 clients) et `Fiches_TarTypcli` (2 types), tarif provisoire existant (`dtmaj = 1`, date future) | dump `Fiches_TarTemp` après validation ; prix affichés identiques (capture du log) | `tests/lecart_tarifs_cli_type/` | à faire |
| VARMAJTAR-T03 | gbtest | Cascade de `constructiontableau` | `pxrev` ∈ {0 ; 1,234 ; 10 ; 99,99}, marge ∈ {0 ; 25 ; 33,333 %}, TVA ∈ {5,5 ; 20 %}, arrondi `art_cdarr` ∈ {`0,01` ; `0,05` ; `0,10`} | `PuNHT.G`, `PuNTC.G` de référence ; même jeu que GESTAR-T05 / DATETAR-T05 pour prouver l'équivalence avec `PrixVente` | `tests/cascade_prix/` | à faire |
| VARMAJTAR-T04 | gbtest | Marge négative (A03) | `LTaxe("--5%", LTaxe.Remise)` appliquée à `LPrix(10, 1, "0,01")` | figer la valeur actuelle | `tests/marge_negative/` | à faire |
| VARMAJTAR-T05 | replay | Drapeau `sup` (A01) | article avec tarif provisoire général `temp_sup = 1` et tarif client provisoire `temp_sup = 0` ; ouverture du panneau puis validation | dump `Fiches_TarTemp` (ligne client supprimée ou non : comportement actuel figé) | `tests/drapeau_sup/` | à faire |
| VARMAJTAR-T06 | replay | SQLite (A02) | T01 rejoué sur une base SQLite | erreur à l'ouverture du panneau tarif (caractérisation) | `tests/lecart_sqlite/` | à faire |
| VARMAJTAR-T07 | replay | `SauvColl` / `Delete` (appels dynamiques) | deux lignes d'achat, passage d'une ligne à l'autre (perte de focus), suppression d'une ligne | dump `Fiches_TarTemp` ; aucune erreur dans le log | `tests/sauvcoll_delete/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** (`./Laurux -l --logfile …`
  pour les replays, sortie gb.test pour T03/T04), jamais déduites de la lecture du code.
- **Données** : `Laurux01.sql` + jeu dérivé `tests/<nom>/data.sql` ajoutant des lignes
  `Fiches_TarTemp`, `Fiches_Tarcli`, `Fiches_TarTypcli` pour un article de test.
- **Rejeu** : `GesTar`/`commande1` appellent `Utils.Observers` (à vérifier dans leur test.md) ;
  l'écran d'achat est un module complexe (`Achat`, scénarios soumis à validation, voir
  ACHAT) : les scénarios T01, T02, T05, T07 sont à intégrer à cette liste validée.
- **Non testable en gb.test** : `LecArt`, `SauvColl`, `affecttar` (objets `Sailig`/`SaiTableau`
  liés à des contrôles). Après VARMAJTAR-006, la fonction pure `LecArtCode` sera testable en
  gb.test avec la base Docker (requêtes préparées créées par le test).
