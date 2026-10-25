# Cstocks — Tests

> Source : `.src/Reports/Cstocks.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans base : tests `gbtest` qui instancient
`New Cstocks("Portrait", "mm", "A4")` (avec `SetCompression(False)`), appellent chaque méthode
avec des valeurs fixes et comparent le texte `pdftotext -layout` et le flux de page non compressé
(`/CreationDate`, date et `User.Name` du pied masqués). Attendus produits dans le clone **Laurux
non modifié**. Le replay passe par les écrans d'inventaire et de dépôts.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CSTOCKS-T01 | gbtest | Valorisation : `Entete`, `Level1`, `Entetefam`, `Level2`, `level3fam`, `Level3`, `BasPage` | 2 familles × 2 lignes, sous-totaux et total « 1234,56 » | texte et flux de référence (recouvrement de `level3fam` figé) | `tests/cstocks_valorisation/` | à faire |
| CSTOCKS-T02 | gbtest | Feuille de comptage : `Level1G`, `Level2G`, `Lines` | 3 lignes avec casier | flux de référence | `tests/cstocks_comptage/` | à faire |
| CSTOCKS-T03 | gbtest | Non saisis et écarts : `Level1NS`/`Level2NS`/`Level3NS`, `Level1E`/`Level2E`/`Level3E` | écarts positifs et négatifs | flux de référence | `tests/cstocks_ecarts/` | à faire |
| CSTOCKS-T04 | gbtest | Dépôts : `Level1D`/`Level2D`, `Level3D`/`Level4D`, `Level1M`/`Level2M` | `/Soc01/Taxe` = « TVA » | libellé de taxe dans l'en-tête ; flux de référence | `tests/cstocks_depots/` | à faire |
| CSTOCKS-T05 | gbtest | Pagination : 3 × (`Entete` + `BasPage`) | — | « Page 1/3 » à « Page 3/3 » | `tests/cstocks_pied/` | à faire |
| CSTOCKS-T06 | gbtest | Squelette paginé (après CSTOCKS-006) : `DebutEdition` + 120 lignes + `SautDePageSi` aux seuils 270, 280, 283, 288 | mêmes lignes que les écrans | flux identique à la séquence d'appels actuelle (enregistrée dans le clone non modifié) | `tests/cstocks_squelette/` | à faire |
| CSTOCKS-T07 | replay | Éditions réelles | scénarios ECARTS-T01, ECARTST-T01, EDNSAISIS-T01, EDINV-T01/T02, GENINV-T01, GENINVT-T01, IMPDEPOTS-T01/T02, EDSDEPOTS-T01 (voir leurs `test.md`) | texte PDF identique entre les deux clones ; dump inchangé | `tests/cstocks_editions/` | à faire |

## Détail des tests

- **Génération des attendus** : module `.test` exécuté en phase 2 dans le clone non modifié,
  sorties `expected/*.txt` (pdftotext) et `expected/*.flux` (flux normalisé par
  `check_output.py`).
- **Données** : aucune base pour T01 à T06 ; T07 réutilise les jeux des écrans appelants
  (`Laurux01.sql` et jeux dérivés d'inventaire de [Geninv/test.md](../../Gestion/Stock/Inventaires/Fin-annee/Geninv.class/test.md),
  stock de dépôt de [ImpDepots/test.md](../../Gestion/Depots/ImpDepots.class/test.md)), avec plus
  d'une page par édition pour exercer les sauts de page.
- **T06** : la séquence de référence est produite en rejouant, dans le clone non modifié, le bloc
  de saut de page recopié de chaque écran (seuil, reprise, présence de `BasPage`).
- **Non testable automatiquement** : rendu visuel (recouvrement de `level3fam`).
- **Couverture visée** : 100 % des méthodes.
