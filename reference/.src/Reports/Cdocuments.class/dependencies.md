# Cdocuments — Dépendances

> Source : `.src/Reports/Cdocuments.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Reports/Cdocuments.class` — classe, hérite de `PdfWriter`
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `EnteteV`, `Level4V`, `Entete3`, `Logo2`, `Level1bis`, `Level3bis`, `Level4RB`, `Level1LV`, `Level1DP`, `Level2FAC`, `Level2Fa`, `Level3FAC`, `Level10F2`, `Level10F3`, `LevelM`, `Level2M`, `Level14F`, `Level15F`, `Level16F`, `EnteteD`, `Level1RL`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Signature`, `SignatureD`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Facturation/FacturefmA.class` | `<type>` |
| `.src/Gestion/Facturation/Facturergbl.class` | `<type>`, `Entete`, `Entete2`, `Level10F`, `Level11F`, `Level12F`, `Level13F`, `Level1F`, `Level2F`, `Level3F`, `Level4F`, `Level4aF`, `Level4bF`, `Level5F`, `Level6F`, `Level7F`, `Level8F`, `Level9F` |
| `.src/Gestion/Impressions/EdDocs.class` | `<type>`, `BasPageP`, `EnteteP`, `Level1D`, `Level2D`, `Level2DLG`, `Level2DLG2`, `Level4D`, `LinesLG`, `LinesP` |
| `.src/Gestion/Impressions/EdFam.class` | `<type>`, `BasPage`, `EnteteN`, `Level1FAM`, `Level2FAM`, `Lines` |
| `.src/Gestion/Impressions/EdPrep.class` | `<type>`, `BasPageP`, `EnteteP`, `Level1D`, `Level2D`, `Level2DLG`, `Level2DLG2`, `LinesLG`, `LinesP` |
| `.src/Gestion/Impressions/Edbr.module` | `<type>`, `BasPage`, `EnteteN`, `Level10F`, `Level11F`, `Level1br`, `Level2br`, `Level3br`, `Level7F`, `Level9F` |
| `.src/Gestion/Impressions/Edcom.class` | `<type>`, `Entete`, `Entete2`, `Level1`, `Level2`, `Level3`, `Level4` |
| `.src/Statistiques/RelMoprod.class` | `<type>`, `BasPage`, `EnteteN`, `Level2RL`, `Level4RL`, `Level5RL`, `Lines` |
| `.src/Statistiques/RelvMo.class` | `<type>`, `Entete`, `Entete2`, `Level1R`, `Level2R`, `Level3R`, `Level4R` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `PdfWriter` | `<type>`, `AddPage`, `Cell`, `EAN13`, `Image`, `Line`, `MultiCell`, `PageNo`, `SetFillColor`, `SetFont`, `SetLineWidth`, `SetXY`, `SetY` |
| `Start` | `B`, `B2`, `G`, `G2`, `LocalSettings`, `R`, `R2`, `Societe` |
| `Variables` | `EnvoiMail`, `Qte`, `TypeL`, `bImpref`, `bRemise` |

### Tables SQL référencées

_Aucune._

### Membres Public sans usage externe détecté (portée réductible ?)

`EnteteV`, `Level4V`, `Entete3`, `Logo3`, `Logo2`, `Logo`, `Level1bis`, `Level3bis`, `Level4RB`, `Level1LV`, `Level1DP`, `Level2FAC`, `Level2Fa`, `Level3FAC`, `Colonnes`, `Level10F2`, `Level10F3`, `LevelM`, `Level2M`, `Level14F`, `Signature`, `Level15F`, `Level16F`, `SignatureD`, `EnteteD`, `Level1RL`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants réels et atteignabilité** (vérifié par `grep -rn -i cdocuments .src`) :
  - `Edcom.Button2_Click` (`Edcom.class:234-286`) : `Entete`, `Entete2`, `Level1`, `Level2`,
    `Level3`, `Level4`. Les `pdf.Level1`…`pdf.Level4` visent **`Cdocuments`** (variable
    `pdf As Cdocuments`, `Edcom.class:40`) : les méthodes homonymes locales `Edcom.Level1`,
    `Level2`, `Level3`, `Level3bis`, `Level4` (`Edcom.class:299-366`) sont mortes (EDCOM-002).
    C'est le seul fichier appelant qui définit des `Level*` locaux.
  - `RelvMo` (`RelvMo.class:363-440`) : `Entete` (411 et **427**), `Entete2`, `Level1R`,
    `Level2R`, `Level3R`, `Level4R`.
  - `Edbr.Ed` / `Edbr.Calc_tva` (appelés par `Edbl` et `ValidBR`) : `EnteteN`, `Level1br`,
    `Level2br`, `Level3br`, `BasPage`, `Level7F`, `Level9F`, `Level10F`, `Level11F`. Le module
    déclare aussi une variable homonyme `Public Cdocuments As String` (`Edbr.module:11`, jamais
    lue, EDBR-002) ; `New Cdocuments(…)` (ligne 144) désigne bien la classe.
  - `EdDocs` et `EdPrep` (listes paysage) : `EnteteP`, `Level1D`, `Level2D`, `Level2DLG`,
    `Level2DLG2`, `LinesLG`, `LinesP`, `BasPageP` (+ `Level4D` pour `EdDocs`).
  - `EdFam` : `EnteteN`, `Level1FAM`, `Level2FAM`, `Lines`, `BasPage`.
  - `RelMoprod` : `EnteteN`, `Lines`, `Level2RL`, `Level4RL`, `Level5RL`, `BasPage`.
  - `Facturergbl` : 17 méthodes, toutes depuis `Button14_Click` et `Calc_tva`, **inatteignables**
    (panneau `Edit` invisible, [FACTURERGBL-A01](../../Gestion/Facturation/Facturergbl.class/rework.md)).
    `deps.py` les compte comme des usages vivants : `Level1F`, `Level2F`, `Level3F`, `Level4F`,
    `Level4aF`, `Level4bF`, `Level5F`, `Level6F`, `Level8F`, `Level12F`, `Level13F` et
    `Colonnes` n'ont **aucun appelant atteignable** (CDOCUMENTS-003).
  - `FacturefmA.class:93` : `Private pdf As Cdocuments` déclaré et jamais utilisé.
- **Arités** (`deps.py`, champ `arity_errors` des appelants, vérifiées à la lecture) :
  - `RelvMo:427` appelle `Entete` avec **18 arguments pour 19** (`Libre` absent) ; aucun
    paramètre n'est `Optional`, donc « Not enough arguments » à l'exécution, au premier saut de
    page (`PosY >= 283`) : aucun PDF n'est produit pour un client de plus d'une page
    ([RELVMO-A01](../../Statistiques/RelvMo.class/rework.md), CDOCUMENTS-A01). L'appel de la
    ligne 411 a bien 19 arguments.
  - `Facturergbl:948`, `:953`, `:960` appellent `Level6F` avec **5 arguments pour 6**
    (`frais` absent) dans du code inatteignable (FACTURERGBL-A01).
  - Le compilateur ne contrôle pas l'arité d'un appel de méthode sur un objet : l'erreur
    n'apparaît qu'à l'exécution.
- **Défauts côté appelants à reporter** (constatés en vérifiant les appels, hors de ce fichier) :
  - `RelvMo:412/428` : `Entete2(rs2, adr22, ville2, pays, "", "", False)` omet `adr21` : la
    première ligne d'adresse du client n'est pas imprimée et les lignes suivantes remontent d'un
    cran (`ville2` dans `adr2`, `pays` dans `ville`). À ajouter à RELVMO.
  - `Edcom:249` : `tel = fourResult!fo_tel_std` écrase le téléphone **de la société** préparé
    ligne 222 : l'en-tête société imprime le téléphone du fournisseur, sans le préfixe
    « Tel : ». À ajouter à EDCOM.
- **Appels homonymes non liés** (faux rapprochements à éviter) : `pdf.Entete3` dans
  `Caisse.class:5251/5253` (classe `Cfacture`), `pdf.level2M` dans `Edsdepots`/`EcrM`
  (`Cstocks`/`Ccompta`), `Logo2` dans `Prefs` (contrôle).
- **Variables globales jamais affectées** : `Variables.EnvoiMail`, `TypeL`, `Qte`, `bImpref`
  (seule `Variables.module` les déclare) ; les branches qui les testent sont mortes
  ([VARIABLES-003, VARIABLES-A02](../../Utils/Variables.module/rework.md)).
- **`pdf.Footer()` sans effet** : `RelvMo:440` et `RelMoprod:401/461` appellent `Footer` sur un
  `Cdocuments`, qui ne le surcharge pas ; `PdfWriter.Footer` est vide (« To be implemented in your
  own inherited class ») : aucun pied de page n'est produit par ces appels (seules `Carticles`,
  `Cbordereaux`, `Chistoriques`, `Cmat` et `Htickets` surchargent `Footer`). `RelMoprod` obtient
  son pied par `BasPage` ; `RelvMo` n'en a pas.
- **Héritage** : `Inherits PdfWriter`. Les méthodes de dessin appelées (`Cell`, `MultiCell`,
  `Image`, `EAN13`, `Line`, `SetXY`…) et le seuil de saut automatique dépendent de
  [`PdfWriter`](../PdfWriter.class/architecture.md) : tout rework de `PdfWriter` touchant
  `Cell`/`SetAutoPageBreak` repasse les tests de ce fichier.
- Aucun appel dynamique, aucune table, aucun `Utils.Observers` (classe sans fenêtre).
- **Ordre de rework** : (1) socle PDF commun avec `Cdocuments3`, `Creleve`… (phase 3, avant les
  `C*` consommateurs) ; (2) `LEnteteSoc` avec `Creleve`, `Edcom` (EDCOM-005), `Facturergbl` ;
  la migration de `RelvMo` attend la décision sur RELVMO-A01/CDOCUMENTS-A01 ; (3) suppression de
  la famille facture après la décision FACTURERGBL-A01 ; (4) suppression de `Cdocuments2`
  indépendante.
