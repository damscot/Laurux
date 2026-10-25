# Cetiquettes — Tests

> Source : `.src/Reports/Cetiquettes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Gabarit de rendu PDF sans base : tests `gbtest` qui instancient `New CEtiquettes(…)` dans les
formats utilisés (A4 portrait, `dymog`, `dymoc`), avec `SetCompression(False)`, appellent chaque
méthode à des positions fixes et pour `fontratio` 1,0 et 0,5, puis comparent le texte
`pdftotext -layout` et le flux de page non compressé (`/CreationDate` masquée). Le flux est le
critère principal (positions, tailles de police, rectangles des barres). Attendus produits dans
le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CETIQUETTES-T01 | gbtest | 14 textes simples (`Nom` … `Refour`) | texte « ABC », positions fixes, `fontratio` 1,0 et 0,5 | flux de référence ; `Code` ≡ `Intitule`, `Codec` ≡ `IntituleA` ; épaisseur 0,8 après `Adrexp` | `tests/cetiquettes_textes/` | à faire |
| CETIQUETTES-T02 | gbtest | Textes composés : `IntituleB`, `stockc`, `Poids`, `volm` (HT vrai/faux) | intitulé de 28, 29 et 40 caractères | troncature à 29 ; flux de référence | `tests/cetiquettes_composes/` | à faire |
| CETIQUETTES-T03 | gbtest | Prix : `Tva`, `PrixHt`, `PrixTTC`, `PrixTTCB`, `PrixHtP`, `PrixTTCP` | « 12,50 », `fontratio` 1,0 et 0,7 | flux de référence (opérateurs de couleur de `PrixHt`/`PrixHtP` compris) | `tests/cetiquettes_prix/` | à faire |
| CETIQUETTES-T04 | gbtest | `Barcode` | EAN valide de 13 chiffres ; `hauteur`/`largeur` par défaut, « 4.6666 », « 70 » (plafond 0,55) ; `fontratio` 0,3 et 1,0 ; code de 12 caractères | barres et texte de référence ; hauteur tronquée à 4 ; pas de texte si `fontratio` ≤ 0,3 ; aucune barre pour 12 caractères | `tests/cetiquettes_barcode/` | à faire |
| CETIQUETTES-T05 | gbtest | Cadres et pages : `Rectangle`, `Rectangle2`, `NewPage` | 2 pages A4, 1 page `dymog`, 1 page `dymoc` | dimensions de page et cadres de référence | `tests/cetiquettes_cadres/` | à faire |
| CETIQUETTES-T06 | replay | Étiquettes réelles | scénarios ETIQART-T01, ETIGOND-T01, ETIQCASIER-T01, ETIQPROMO-T01, ETIQRECPT-T01, ETIQFBTARIF-T01, ETICLI-T01, FCLIENT-T13, FFOURNISSEUR-T12 (voir leurs `test.md`) | texte et flux PDF identiques entre les deux clones ; dump identique (table de travail `Etiquettes` comprise) | `tests/cetiquettes_editions/` | à faire |

## Détail des tests

- **Génération des attendus** : module `.test` exécuté en phase 2 dans le clone non modifié ;
  `check_output.py` compare les flux normalisés (une opération par ligne).
- **Locale** : `Barcode` exige `LANG=fr_FR.UTF-8` (lecture des dimensions avec virgule).
- **Données** : aucune base pour T01 à T05 ; T06 réutilise les jeux des écrans d'étiquettes
  (modèles de planche, articles avec code-barres), voir
  [Etiqart/test.md](../../Gestion/Etiquettes/Etiqart.class/test.md).
- **Non testable automatiquement** : lisibilité réelle du code-barres par un lecteur (contrôle
  manuel sur une impression) ; chaîne Zebra (ZEBRA-A01).
- **Couverture visée** : 100 % des méthodes et des branches (`IntituleB`, `volm`, `Barcode`).
