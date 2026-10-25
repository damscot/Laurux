# EdDocs — Architecture

> Source : `.src/Gestion/Impressions/EdDocs.class` (+ `EdDocs.form`)

## Vue d'ensemble

Écran « Liste des documents clients en cours » (menu `Menu254`, Gestion > Facturation,
`Fmenu.class:2086`). Filtres : type de document (`RadioButton1` tous, `2` commandes, `3` BL,
`4` devis, `5` factures), plage de codes client (`Cli`/`Cli2`, liste `Colcli`), plage de dates
(`Datej`/`Datej2`, calendrier `DateChooser1` par double-clic ou F2), détail des lignes
(`RadioButton6`/`7`), ordre de tri (`RadioButton8`…`12`). Sortie paysage `~/tmp/ListeDocs.pdf`
(classe `Cdocuments`), avec total général et, en tri par compte, un total par client.

Le type est mémorisé dans `TypeD` par les handlers `RadioButton*_Click`. Proche
d'[`EdPrep`](../EdPrep.class/architecture.md) (≈ 118 lignes communes) et du socle « plage de codes »
d'[`EdClient`](../EdClient.class/architecture.md).

`Cli`/`Cli2` sont dans le groupe `Cmpt` mais aucun handler `Cmpt_*` n'existe (pas de navigation
clavier entre les champs).

Nature : **mixte** ; `Button1_Click` (CC 39) concentre la logique.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `PosY` | var | Private |  | Integer | 29 |
| `Coulfond` | var | Private |  | New String[] | 30 |
| `TypeD` | var | Private |  | String | 31 |
| `Tab` | var | Private |  | String | 32 |
| `Org` | var | Private |  | String | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-46 | Public | 1 | 8 | 0 | méthode spéciale |
| `Button1_Click` | 48-216 | Public | 39 | 166 | 0 | handler GUI |
| `Button2_Click` | 218-223 | Public | 3 | 4 | 0 | handler GUI |
| `RadioButton1_Click` | 225-229 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton4_Click` | 231-235 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton2_Click` | 237-241 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton3_Click` | 243-247 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton5_Click` | 249-253 | Public | 1 | 3 | 0 | handler GUI |
| `RadioButton12_Click` | 255-259 | Public | 1 | 3 | 0 | handler GUI |
| `ToggleButton1_Click` | 262-267 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 269-274 | Public | 1 | 4 | 0 | handler GUI |
| `Aff_Clients` | 276-311 | Public | 7 | 33 | 0 | portée réductible ? |
| `Colcli_Click` | 313-330 | Public | 3 | 15 | 0 | handler GUI |
| `Colcli_KeyPress` | 336-356 | Public | 6 | 17 | 0 | handler GUI |
| `Datej_DblClick` | 358-363 | Public | 1 | 4 | 0 | handler GUI |
| `Datej2_DblClick` | 365-370 | Public | 1 | 4 | 0 | handler GUI |
| `Select_Date` | 372-380 | Public | 2 | 7 | 0 | portée réductible ? |
| `DateChooser1_Activate` | 382-395 | Public | 3 | 11 | 0 | handler GUI |
| `Datej_KeyPress` | 397-411 | Public | 5 | 13 | 0 | handler GUI |
| `Datej2_KeyPress` | 413-427 | Public | 5 | 13 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : `Frmt` et `Coulfond` calculés et **jamais utilisés** ; `Utils.Observers(Me)`.
- **`Button1_Click()`** (CC 39) [handler] [mixte] :
  - bornes par défaut `19700101`–`99991231` et `411001`–`41199999` ; dates saisies converties en
    `aaaammjj` par découpage de chaîne ;
  - titre selon le bouton : ⚠️ `RadioButton2` (« Commandes », `TypeD = "C"`) produit « Liste des
    **devis** en cours » et `RadioButton4` (« Devis », `TypeD = "D"`) « Liste des **commandes** en
    cours » (titres inversés, EDDOCS-A01) ;
  - ordre : `RadioButton8`…`11` ; **`RadioButton12`** (« Par commentaire ») n'est pas traité : `Ordre`
    reste vide → `order by ` → erreur SQL, puis accès à un `Result` nul ; de plus son handler force
    `TypeD = "C"` (EDDOCS-A02) ;
  - SQL : `SELECT * FROM <TabBl> left join <TabCli> on cli_code = cdclibl where cli_code >= &1 and
    cli_code <= &2 and datebl >= &3 and datebl <= &4 [and type = &5] order by <ordre>`.
    `datebl` est un `datetime` comparé à `aaaammjj` : le dernier jour n'est inclus que pour les
    documents à 00:00 (à confirmer) ; sous SQLite, la comparaison texte `aaaa-mm-jj` / `aaaammjj`
    est fausse dès qu'une date est saisie (EDDOCS-A04, à confirmer) ;
  - par document : adresse du document, téléphones, total TTC ; facture imprimée (`type = "F"` et
    `imp = 1`) → numéro et date de facture ; en tri par compte, ligne « TOTAL des Documents du
    client » à chaque changement de client — **le total du dernier client n'est jamais imprimé**
    (EDDOCS-A03) ; détail (`RadioButton7`) : lignes article et, seulement pour les commandes
    (`RadioButton2`), commentaires `YY` ; sauts de page à 180 et 194 ; `Level4D(GdTotal)`.
  - Résidus : `Nbpage`, `Datefac` partiellement, `Fax`/`Mel` lus sans usage, `Shell "cd …"`.
- **`Button2_Click()`** [handler] : supprime le PDF, ferme.
- **`RadioButton1/2/3/4/5/12_Click()`** [handlers] : `TypeD` = `""`, `C`, `B`, `D`, `F`, `C`.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [handlers] : `Org` puis `Aff_Clients`.
- **`Aff_Clients()`** [portée : réductible] [mixte] : bascule `Colcli` ; `SELECT * FROM Fiches_Cli
  where cli_code >= &1 order by cli_code` (à partir de `Cli` pour la borne haute).
- **`Colcli_Click()`** [handler ; `replay_dynamic` : reste `Public`] et **`Colcli_KeyPress()`**
  [handler] : recopie du code, F1 lance l'impression, Échap/F2 ferme.
- **`Datej_DblClick`, `Datej2_DblClick`** [handlers] → `Select_Date` ; **`Select_Date()`** [portée :
  réductible] : bascule le calendrier ; **`DateChooser1_Activate`** [handler] : écrit la date
  `dd.mm.yyyy` ; **`Datej_KeyPress`, `Datej2_KeyPress`** [handlers] : Échap/F2 sur le calendrier.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/Coul/Fnets"]` (inutile).
- `Utils.Cdate_Aff`, `cpoint`, `FColr`, `Coulfd`, `Observers`, `Cbase.Table` (`TabBl`, `TabCli`,
  `TabLigbl`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire `ClauseDocuments(…)` (bornes, type, ordre), `ImprimeTotalClient(…)` et la gestion de
  saut de page (quatre copies).
- Supprimer `Frmt`, `Coulfond`, `Nbpage`, variables lues sans usage, `Shell "cd"`.

### Commonalisation avec d'autres fichiers

- [`EdPrep`](../EdPrep.class/architecture.md) : liste identique dans sa structure (EDPREP-007).
- Calendrier (`DateChooser1` + double-clic/F2) : même schéma que `Fpromo`, `Edsdepots` (helper de
  saisie de période relevé au lot Gestion-1).
- `Aff_Clients` : variante de celle d'[`EdClient`](../EdClient.class/architecture.md) (socle
  « plage de codes »).

### Réduction de portée

- `Aff_Clients`, `Select_Date` → `Private`.

### Séparation traitement / GUI

- `DocumentsEnCours(bornes, type, ordre) As Result` sans contrôle ; le handler imprime.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `idx_type_date` déjà présent sur `Fiches_Bl(type, datebl)` ; les filtres de dates gagneraient
  à comparer des `DATE` plutôt que des chaînes (SQLite).
