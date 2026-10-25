# Carticles — Tests

> Source : `.src/Reports/Carticles.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans accès à la base : chaque méthode est testable en `gbtest` en
instanciant `New CArticles("Portrait", "mm", "A4")`, en appelant la méthode avec des valeurs fixes,
puis en écrivant le PDF (`Output(fichier, False)`). On compare deux sorties :
1. le texte `pdftotext -layout` (contenu et ordre des colonnes) ;
2. le flux de page non compressé (`SetCompression(False)` avant `Open`), qui fige les positions,
   les polices et les couleurs : c'est le critère bloquant des reworks « flux PDF identique ».

Les champs volatils sont masqués avant comparaison : `/CreationDate`, date et `User.Name` du pied
de page. Les valeurs attendues sont produites en phase 2 dans le clone **Laurux non modifié**
(anomalies comprises). `Start.R/G/B` et `/Soc01/Taxe` sont fixés par le `Laurux.conf` de test.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CARTICLES-T01 | gbtest | Stock chiffré et non chiffré : `Entete`, `Level1`, `Level3`, `Level5`, `Level2`, `Level4` | 2 lignes de chaque, totaux « 1234,56 » | texte et flux de référence ; titre décalé à x = 40 figé | `tests/carticles_stock/` | à faire |
| CARTICLES-T02 | gbtest | Tarif interne : `Level7`, `Level6`, `Level7M`, `Level6M`, `Level10`, `Ligne` | 2 articles, PV conseillé `Lg` = 184 et 8 | texte et flux de référence ; police de `Level10` héritée | `tests/carticles_tarif/` | à faire |
| CARTICLES-T03 | gbtest | Mode photo : `Level7bis`, `Level6bis`, `Photo` | une image PNG valide, une inexistante | `Level7bis` et `Photo` imprimés ; `Level6bis` lève « Undefined font: hel8vetica » (CARTICLES-A01 figée) ; photo inexistante ignorée | `tests/carticles_photo/` | à faire |
| CARTICLES-T04 | gbtest | Ruptures et ventes : `Level13`, `Level13R`, `Level13V`, `Level14`, `Level14V` | 2 lignes de chaque | texte et flux de référence | `tests/carticles_ruptures/` | à faire |
| CARTICLES-T05 | gbtest | Régularisations : `Level11`, `Level12` ; mains d'oeuvre : `Level1MO`, `Level2MO` | intitulé de 60 caractères ; `/Soc01/Taxe` = « TVA » | intitulé tronqué à 45 dans `Level2MO` ; libellé de taxe | `tests/carticles_regul_mo/` | à faire |
| CARTICLES-T06 | gbtest | Pied de page et pagination : `Footer` sur 3 pages, `AliasNbPages` | 3 × (`Entete` + `Footer`) | « Page 1/3 » … « Page 3/3 » (date et utilisateur masqués) | `tests/carticles_pied/` | à faire |
| CARTICLES-T07 | gbtest | Tarif client (`EdArt2`, mort) : `Level9`, `Level9bis`, `Level8`, `Level8bis`, `Ligne2` | 2 lignes de chaque | flux de référence ; test retiré si EDART2-A01 est validée | `tests/carticles_tarif_client/` | à faire |
| CARTICLES-T08 | replay | Éditions réelles via les écrans | jeu `editions_articles` ; scénarios EDART1-T01/T03, EDART3-T03 (photo), EDSTK, EDRUP, EDMO, EDREGUL (voir leurs `test.md`) | texte PDF identique entre les deux clones ; dump de base inchangé | `tests/carticles_editions/` | à faire |
| CARTICLES-T09 | gbtest | `FormatAligne` (après CARTICLES-006) | « 12,5 », « 12,50 », « 12,500 », « 12 », « » | « 12,5 », « 12,50␠ », « 12,500 », « 12 », « » (comportement de l'idiome actuel) | `tests/carticles_formataligne/` | à faire |

## Détail des tests

- **Génération des attendus** : un module `.test` (phase 2) appelle les méthodes publiques dans
  le clone **Laurux non modifié** et dépose `expected/*.pdf`, `expected/*.txt` (pdftotext) et
  `expected/*.flux` (flux non compressé, normalisé par `check_output.py`). Le même module tourne
  ensuite sur le clone reworké.
- **Données** : aucune base pour T01 à T07 et T09 (valeurs littérales) ; T08 utilise le jeu dérivé
  `editions_articles` décrit dans [EdArt1/test.md](../../Gestion/Impressions/EdArt1.class/test.md)
  (≈ 70 articles, plusieurs pages), et `Laurux01.sql` pour les régularisations.
- **Images** : T03 embarque une image PNG de test dans `tests/carticles_photo/data/`.
- **Erreur figée (T03)** : le test vérifie `Error.Text` après `Try pdf.Level6bis(…)` ; il sera
  mis à jour si CARTICLES-A01 est validée.
- **Non testable automatiquement** : rendu visuel (débordement du titre `Entete` à x = 40, décalage
  de 2 mm de `Level5`) : contrôle à l'oeil sur le PDF de référence.
- **Couverture visée** : 100 % des méthodes vivantes ; le code mort supprimé par CARTICLES-002 n'est
  pas testé.
