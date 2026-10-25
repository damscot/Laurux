# Chistoriques — Tests

> Source : `.src/Reports/Chistoriques.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans base : tests `gbtest` qui instancient
`New Chistoriques("Portrait", "mm", "A4")` (avec `SetCompression(False)`), appellent les méthodes
avec des valeurs fixes et comparent le texte `pdftotext -layout` et le flux de page non compressé
(`/CreationDate`, date et `User.Name` du pied masqués). Attendus produits dans le clone **Laurux
non modifié**. Les replays passent par les écrans de statistiques sur le jeu
`statistiques_ventes`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CHISTORIQUES-T01 | gbtest | Cadre : `Entete`, `Level0F`, `Lines`, `Footer` sur 2 pages | titre, dates « 01/01/2026 », « 31/12/2026 » | texte et flux de référence ; « Page 1/2 », « Page 2/2 » | `tests/chistoriques_cadre/` | à faire |
| CHISTORIQUES-T02 | gbtest | Historique MO : `Level1`, `Level2` | désignation de 40 caractères | désignation tronquée à 30 ; flux de référence | `tests/chistoriques_histo/` | à faire |
| CHISTORIQUES-T03 | gbtest | Types de client, commerciaux, articles, hit-parade : `Level1C`/`level2C`/`Level4C`/`Level5C`, `Level1AC`/`level2AC`, `Level1A`/`level2A`/`Level5A`, `Level1H`/`level2H` | 2 lignes par édition, totaux « 1234,56 » | flux de référence (espace final des `Level5*`) | `tests/chistoriques_stats/` | à faire |
| CHISTORIQUES-T04 | gbtest | Pièces / MO : `Level1P`, `level2P`, `Level4P`, `Level5P` | lignes passées en `String` puis en `Float` (12.5) | « 12.5 » imprimé tel quel pour un `Float` (VISSTATCLIMO-A01 figée) | `tests/chistoriques_climo/` | à faire |
| CHISTORIQUES-T05 | gbtest | CA fournisseurs : `Level1FO`, `level2FO`, `Level4FO`, `Level5FO` | `ca` = « 1234,5 », « 0,00 » ; `pourcent` = « 12,50 », «  -3,20  », « » | « 1234,50 » ; « 12,50 » ; « -3,20 » ; « » → erreur « Type mismatch » (CHISTORIQUES-A01 figée) | `tests/chistoriques_four/` | à faire |
| CHISTORIQUES-T06 | replay | Impressions réelles | jeu `statistiques_ventes` ; scénarios VISSTATFOUR-T03, VISSTATCLIMO-T03, VISSTATCOMART-T05, VISSTATCOMM-T04, VISSTATTYPCLI-T03, VISHITCARTES-T01, HISTOVMO-T08 | texte PDF identique entre les deux clones ; dump inchangé (hors table de travail `Total`) | `tests/chistoriques_editions/` | à faire |
| CHISTORIQUES-T07 | replay | Fournisseur à CA nul sur la période (A01) | `statistiques_ventes` + un fournisseur vendu en N-1 seulement ; `VisStatFour`, **Imprimer** | erreur « Type mismatch » dans `level2FO` (comportement actuel figé, à confirmer) | `tests/chistoriques_four_ca_nul/` | à faire |

## Détail des tests

- **Génération des attendus** : module `.test` exécuté en phase 2 dans le clone non modifié ;
  `check_output.py` normalise le flux (dates, utilisateur) puis compare `expected/` et `actual/`.
- **Données** : aucune base pour T01 à T05 ; T06/T07 utilisent `statistiques_ventes` décrit dans
  [StatComm/test.md](../../Statistiques/StatComm.class/test.md) (replays en série : table de
  travail `Total` partagée).
- **Locale** : `level2FO` dépend de la locale (`Val` lit la virgule en fr_FR) : les tests tournent
  avec `LANG=fr_FR.UTF-8`.
- **Non testable automatiquement** : rendu visuel (alignements, espace final des totaux) : contrôle
  à l'oeil sur le PDF de référence.
- **Couverture visée** : 100 % des méthodes vivantes ; le code mort (CHISTORIQUES-002) n'est pas
  testé.
