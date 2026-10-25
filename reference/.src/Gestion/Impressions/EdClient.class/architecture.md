# EdClient — Architecture

> Source : `.src/Gestion/Impressions/EdClient.class` (+ `EdClient.form`)

## Vue d'ensemble

Écran « Liste des clients » (menu `Menu101`, `Fmenu.class:1272`). Filtres facultatifs : plage de
codes client (`Cli` = `00000`, `Cli2` = `4199999` par défaut), plage de statuts (`Stat1`/`Stat2`,
`Fiches_Statut`), plage de types client (`Type1`/`Type2`, `Fiches_Typec`) et mode de règlement
(`Mreg`, liste fixe du `.form`) ; tri par code ou par nom. Impression portrait `~/tmp/Clients.pdf`
(classe `Cclients`, `Level1`/`Level2`). Une **seule** liste `Colcli` sert aux six champs : la
variable `Org` mémorise le champ à remplir.

Gabarit commun avec [`EdFour`](../EdFour.class/architecture.md) (141 lignes communes) et
[`EdFam`](../EdFam.class/architecture.md).

Groupes : les six champs dans `Cmpt` (tags 1 à 6), `Button2`/`Button3` dans `Btn` (tags 2/3) ;
`Button1` (aide) non groupé. En-tête de fichier recopié (`EdCli.class`).

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 11 |
| `Tab` | var | Private |  | String | 12 |
| `son` | var | Private |  | Integer | 13 |
| `PosY` | var | Private |  | Integer | 14 |
| `Org` | var | Private |  | String | 15 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 17-28 | Public | 1 | 9 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 31-36 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton2_Click` | 38-43 | Public | 1 | 4 | 0 | handler GUI |
| `Aff_Clients` | 45-80 | Public | 7 | 33 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 83-88 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton4_Click` | 90-95 | Public | 1 | 4 | 0 | handler GUI |
| `Aff_Statuts` | 97-131 | Public | 7 | 32 | 0 | portée réductible ? |
| `ToggleButton5_Click` | 134-139 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton6_Click` | 141-146 | Public | 1 | 4 | 0 | handler GUI |
| `Aff_Types` | 148-183 | Public | 7 | 33 | 0 | portée réductible ? |
| `Colcli_KeyPress` | 189-209 | Public | 6 | 17 | 0 | handler GUI |
| `Btn_Click` | 211-227 | Public | 6 | 11 | 0 | handler GUI |
| `Cmpt_KeyPress` | 229-282 | Public | 14 | 44 | 0 | handler GUI |
| `Cmpt_GotFocus` | 287-293 | Public | 1 | 5 | 0 | handler GUI |
| `Colcli_Click` | 295-341 | Public | 7 | 40 | 0 | handler GUI |
| `Button2_Click` | 343-428 | Public | 15 | 82 | 0 | portée réductible ? |
| `Button1_Click` | 430-434 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : `Utils.Observers(Me)`, bornes de codes par défaut, focus.
- **`ToggleButton1..6_Click()`** [handlers] [GUI] : fixent `Org` (`Cli1`, `Cli2`, `Stat1`, `Stat2`,
  `Type1`, `Type2`) puis appellent `Aff_Clients`, `Aff_Statuts` ou `Aff_Types`.
- **`Aff_Clients()`** [portée : réductible] [mixte] : bascule `Colcli`, la place à gauche du bouton
  appelant, `SELECT * FROM Fiches_Cli order by cli_code` (code, nom).
- **`Aff_Statuts()`** [portée : réductible] [mixte] : idem avec `SELECT * FROM <TabStatut>`
  (code, libellé).
- **`Aff_Types()`** [portée : réductible] [mixte] : idem avec `SELECT * FROM Fiches_Typec` (nom en
  dur alors que la clé `TabTypec` existe). Les trois fonctions ne diffèrent que par la requête, les
  colonnes lues et la largeur de la première colonne.
- **`Colcli_KeyPress()`** [handler] : Entrée → `Colcli_Click`, F1 → aide, Échap/F2 → ferme et
  revient sur `Cli` (quel que soit le champ d'origine).
- **`Colcli_Click()`** [handler ; `replay_dynamic` : reste `Public`] : selon `Org`, recopie le code
  dans le champ et passe au suivant.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 2 → `Button2_Click` ; tag 3 → suppression du
  PDF, fermeture ; `Case 1` inatteignable.
- **`Cmpt_KeyPress()`** (CC 14) [handler] : Entrée/Tab fait le tour des six champs ; F1 aide ; F2
  n'ouvre la liste que pour `Cli`/`Cli2` (tags 1, 2).
- **`Cmpt_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Button2_Click()`** (CC 15) [portée : réductible — bouton groupé, appelé par `Btn_Click`]
  [mixte] : construit dynamiquement le `WHERE` :
  `AND CAST(cli_code AS CHAR) BETWEEN &1 AND &2` (comparaison **lexicale** des codes),
  `AND cli_statut >= &3 AND cli_statut <= &4`, `AND cli_typec >= &5 AND cli_typec <= &6`, puis
  ⚠️ **`req = " AND cli_reg = &7"`** (affectation au lieu de `&=`) : choisir un mode de règlement
  **annule** les autres filtres (EDCLIENT-A01). `Right(req, -4)` retire le premier `AND`. Si tous
  les champs sont vides, la requête devient `WHERE  ORDER BY …` : erreur SQL (EDCLIENT-A02).
  `SELECT * FROM Fiches_Cli WHERE … ORDER BY <tri>` avec sept paramètres. PDF : `Entete` (titre
  complété du mode de règlement), `Level1`, `Level2` (13 arguments) + `Lines`, saut de page à 280
  avec un titre **sans** le mode de règlement (EDCLIENT-A03), `Baspage`, `Output`,
  `Visualiseur.Prog`. Résidus : `dte`, `Nbpage`, `Shell "cd …"`, ligne commentée.
- **`Button1_Click()`** [handler] : `Doc.Open("Edclient")`.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.Observers`, `SetEditColor`, `Utils.db`, `Cbase.Table("TabStatut")`, `Doc`.
- Membres : `Filename`, `Tab`, `son`, `PosY`, `Org`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Fusionner `Aff_Clients`, `Aff_Statuts`, `Aff_Types` en `AfficheListe(sSql, sCode, sLibelle,
  iLargeur, hBouton)` (EDCLIENT-004).
- Construire la clause `WHERE` dans une fonction pure `FiltreClients(…) As String` (testable en
  gbtest), sans changer le texte SQL produit tant qu'A01/A02 ne sont pas validées.

### Commonalisation avec d'autres fichiers

- Socle « plage de codes + listes » avec [`EdFour`](../EdFour.class/architecture.md),
  [`EdFam`](../EdFam.class/architecture.md), [`EdDocs`](../EdDocs.class/architecture.md)
  (`EdDocs.Aff_Clients` est une variante d'`Aff_Clients` avec un filtre `cli_code >= &1`).
- Listes statuts/types : mêmes tables de référence code/libellé que les écrans `Statut`, `Typec`
  (socle « table code/libellé » relevé au lot Gestion-1).

### Réduction de portée

- `Aff_Clients`, `Aff_Statuts`, `Aff_Types`, `Button2_Click` → `Private`.

### Séparation traitement / GUI

- `FiltreClients` (pur) + `ListeClients(…) As Result` ; le handler imprime.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `cli_code` entier comparé en chaîne (`CAST … AS CHAR`) : empêche l'usage de la clé primaire ;
  une comparaison numérique serait plus rapide (changement de résultat pour les codes de longueurs
  différentes : à traiter comme anomalie si souhaité).
