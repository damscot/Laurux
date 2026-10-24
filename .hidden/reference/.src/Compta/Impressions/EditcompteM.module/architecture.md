# EditcompteM — Architecture

> Source : `.src/Compta/Impressions/EditcompteM.module`

## Vue d'ensemble

`EditcompteM` est le **module d'impression PDF des grands livres**, appelé uniquement par
[`Editcompte.Button1_Click`](../Editcompte.class/architecture.md). Comme
[`BalanceM`](../BalanceM.module/architecture.md), il a été extrait de son écran (commit `9c368c25`) et
n'hérite pas de `PdfWriter` : il pilote une instance de **`Ccompta`** (`.src/Reports/`,
`Inherits PdfWriter`) par `PosY`. Son état tient dans 35 variables `Private` de module.

Rendu (A4 portrait, `~/tmp/Glivre.pdf`, ouvert par `Visualiseur.Prog`) :

| Élément | Méthode `Ccompta` | Contenu |
|---|---|---|
| Bandeau | `Entete` | « Grand livre client/fournisseur/gestion/bilan/général » (1re page), « Grand livre » (pages suivantes) |
| Période, société | `Level0C` | « Edition du … au … », « Societe  <int_sc> » |
| Colonnes | `Level1C` | Compte, Intitulé, Jal, Date, Numéro, Lot, Débit, Crédit, Solde |
| Compte | `Level3C` | numéro et intitulé |
| Écriture | `Level2C` | libellé (24 car.), journal, date `jj.mm.aa`, numéro, lot, débit, crédit, solde cumulé |
| Total sous-comptes | `Level2s` | « Total sous-comptes <compte> <intitulé> » |
| Total compte | `Level4C` + `Lines` | « Total compte <compte> » |
| Total bilan / gestion | `Level4T` | uniquement en grand livre général (`Bgen`) |
| Total général | `Level5C` + `Lines` | « Total grand livre » |
| Pied | `BasPage` | « Page n/N - date - Impression demandée par <utilisateur> » |

Nature globale : **mixte** (SQL, table de travail `Ctrln`, calcul, PDF, accès au formulaire).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebHP` | var | Private | oui | Float | 3 |
| `CredHP` | var | Private | oui | Float | 4 |
| `TotSldHP` | var | Private | oui | Float | 5 |
| `TotDeb` | var | Private | oui | Float | 6 |
| `TotCred` | var | Private | oui | Float | 7 |
| `TotSld` | var | Private | oui | Float | 8 |
| `Slddeb` | var | Private | oui | Float | 9 |
| `Sldcred` | var | Private | oui | Float | 10 |
| `Sldtot` | var | Private | oui | Float | 11 |
| `debit` | var | Private | oui | Float | 12 |
| `credit` | var | Private | oui | Float | 13 |
| `solde` | var | Private | oui | Float | 14 |
| `montantd` | var | Private | oui | Float | 15 |
| `montantc` | var | Private | oui | Float | 16 |
| `mnt` | var | Private | oui | Float | 17 |
| `mnt1` | var | Private | oui | Float | 18 |
| `dte` | var | Private | oui | String | 19 |
| `Filename` | var | Private | oui | String | 20 |
| `Tab1` | var | Private | oui | String | 21 |
| `jour` | var | Private | oui | String | 22 |
| `Centr` | var | Private | oui | Boolean | 23 |
| `Mois` | var | Private | oui | String | 24 |
| `Datj` | var | Private | oui | String | 25 |
| `libelle` | var | Private | oui | String | 26 |
| `Compt` | var | Private | oui | String | 27 |
| `IntituleCpt` | var | Private | oui | String | 28 |
| `cResult` | var | Private | oui | Result | 29 |
| `rResult` | var | Private | oui | Result | 30 |
| `rrResult` | var | Private | oui | Result | 31 |
| `Tab2` | var | Private | oui | String | 32 |
| `PosY` | var | Private | oui | Integer | 33 |
| `son` | var | Private | oui | Integer | 34 |
| `dateedition` | var | Private | oui | String | 35 |
| `Ste` | var | Private | oui | String | 36 |
| `pdf` | var | Private | oui | Ccompta | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Imprime` | 42-276 | Public | 35 | 229 | 1 |  |
| `bas_page` | 278-289 | Public | 2 | 10 | 0 | portée réductible ? |
| `Centralisation` | 294-317 | Public | 2 | 21 | 0 | portée réductible ? |
| `finmois` | 322-333 | Public | 2 | 9 | 0 | portée réductible ? |
| `Raz` | 338-351 | Public | 1 | 12 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Imprime(cpt, cpt2, type, dten0, dten1, Bgen, Tab0)`** (CC 35, 229 LOC, max du fichier)
  [portée : nécessaire, appelée par `Editcompte.Button1_Click`] [nature : mixte]. Pas de `Catch`.
  1. `Shell "cd ~"` sans effet ; `Ccompta` ; société (`Fiches_Societes` en dur) ; intitulé selon
     `type` ; première page ; `Editcompte.Mouse = Wait` (auto-instance de l'écran).
  2. Comptes de `Fiches_Comptes` (en dur) : plage `cast(compte_cc as char)` et `type_cc = type`, ou
     pour `BG` `type_cc = 'G'` **ou** `'B'` (chaque branche avec la plage), tri `type_cc, compte`
     (donc bilan `B` puis gestion `G`).
  3. Pour chaque compte :
     - **total de type** (`Bgen` seulement) : si `type_cc` change par rapport à `typecompte`
       (initialisé à `"B"`), imprime « Total classe Bilan » avec les cumuls `Slddeb2`… puis les remet à
       zéro. Si le premier compte n'est pas de type `B`, un total « Bilan » à zéro est imprimé en tête
       (anomalie EDITCOMPTEM-A02) ;
     - **sous-comptes** : `SELECT * FROM Fiches_SousComptes WHERE code = compte order by code_vtl`
       (en dur, pas de clé `Cbase`). Si le compte a des sous-comptes, il ouvre un groupe jusqu'au
       dernier `code_vtl` ; les comptes suivants dont le numéro (comparaison de **chaînes**) dépasse ce
       dernier sous-compte ferment le groupe et impriment « Total sous-comptes » (débits/crédits non
       nuls). Un groupe encore ouvert à la fin de la plage n'est **jamais imprimé** (anomalie
       EDITCOMPTEM-A01) ;
     - écritures : `SELECT * FROM <Tab0> WHERE compte = &1 and validee = 1 and dte >= aaaammjj and
       dte <= aaaammjj order by dte` (filtre SQL ; une écriture du dernier jour portant une heure non
       nulle serait exclue, à confirmer selon le stockage de `dte`) ;
     - compte mouvementé : `DROP`/`CREATE TABLE Ctrln` (à chaque compte), `Level3C`, puis une ligne
       `Level2C` par écriture avec solde cumulé (`"-0,00"` remplacé par `"0,00"`, test dépendant de la
       virgule décimale de la locale) ; cumul des sous-comptes ; compte centralisé : `Centralisation()`
       par écriture, puis une ligne par mois lue dans `Ctrln` avec le **journal de la dernière
       écriture lue** (variable `jour`) et non celui de `Ctrln` (anomalie EDITCOMPTEM-A03) ;
     - totaux : `Level4C` (« Total compte »), cumul général `Slddeb`/`Sldcred`/`Sldtot`, cumul de
       type `Slddeb2`… ; `totsld + totsldhp` (toujours + 0) ;
     - compte sans écriture : rien n'est imprimé (`None = True`).
     `Typecompte = type_cc` du compte courant, `bas_page()` après chaque bloc.
  4. Fin : si au moins un compte imprimé, « Total classe Gestion » (`Bgen`), `Level5C`, `BasPage`,
     `Output`, `Visualiseur.Prog` ; sinon « Aucune ecriture pour cette demande ». Remise à zéro des
     totaux généraux ; curseur `Editcompte.Mouse = Mouse.Pointing` (et non `Default`).
  Restes : `p`, `Nbpage`, `Lib`, `Libel`, `sldssc`, `DebHP`/`CredHP`/`TotSldHP` (jamais cumulés),
  `totdeb = totdeb`, `totcred = totcred`.
- **`bas_page()`** [portée : réductible] [nature : PDF]. Si `PosY >= 273` : `BasPage`, nouvelle page
  « Grand livre » (sans la nature), `Level0C`, `Level1C`, `PosY = 31`.
- **`Centralisation()`** [portée : réductible] [nature : calcul + SQL]. Identique à
  `Editcompte.Centralisation` : cumul mensuel dans `Ctrln` (`SELECT`, puis `UPDATE` ou `INSERT`).
  `IntituleCpt` n'est jamais affecté dans ce module : la colonne `intitule` est insérée vide.
- **`finmois(Jrs As Date) As Integer`** [portée : réductible] [nature : calcul]. Dernier jour du mois
  (identique à 5 autres copies ; équivalent de `LDate.Fin_Mois`). Seule fonction **pure** des cinq
  fichiers : testable en `gbtest`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro des cumuls du compte.

## État global utilisé

- `Utils.db` ; tables en dur `Fiches_Comptes`, `Fiches_Societes`, `Fiches_SousComptes` ; table
  d'écritures reçue en paramètre (`Tab0`) ; table de travail `Ctrln` (DDL + écritures).
- `Utils.Cdate_dbase`, `Cdate_Aff`, `db.Engine()` ; `Start.Societe`, `Start.Son`.
- **`Editcompte.Mouse`** (auto-instance de l'écran) ; `Visualiseur.Prog` ; `Ccompta`.
- Fichier `~/tmp/Glivre.pdf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Imprime` (CC 35) en fonctions privées : `TotalType()`, `FermeSousComptes()`,
  `ImprimeEcritures()`, `ImprimeCentralisation()`, `TotalCompte()` ; état passé en paramètres ou
  conservé en variables de module documentées. Objectif CC ≤ 12, rendu identique.
- `NouvellePage(premiere As Boolean)` pour l'en-tête initial et `bas_page` (titres actuels gardés).
- `SoldeAffiche(x As Float) As String` pour les deux conversions `"-0,00"` → `"0,00"`.
- `Cbase.Table("TabComptes")`, `Cbase.Table("TabSoc")` à la place des noms en dur (SQL identique) ;
  `Fiches_SousComptes` n'a pas de clé `Cbase` (en ajouter une touche `Cbase.module`, hors de ce
  fichier).

### Commonalisation avec d'autres fichiers

- **Centralisation** (`Centralisation`, `finmois`, `Raz`, DDL de `Ctrln`) : identique à
  [Editcompte](../Editcompte.class/architecture.md), quasi identique à
  [EditcompteA](../EditcompteA.class/architecture.md) (`Ctrlnc`) et à
  [Extrait](../../Extrait.class/architecture.md) : helper commun (voir EDITCOMPTE-006).
- **Impression d'extrait** : `EditcompteA.Button1_Click` reprend 126 lignes de `Imprime` (ratio
  0,62). Socle visé : `Imprime` paramétré (table d'écritures, filtre analytique `Fiches_Analytiques`,
  niveaux `Level1C`/`Level2C` ou `Level1CA`/`Level2CA`, titre, sous-comptes et totaux de type
  activables), après décision sur EDITCOMPTEA-A01/A02.
- **Édition PDF paginée** : même squelette que `BalanceM` (état de module, en-tête répété, curseur du
  formulaire, `Shell "cd"`) et `JournauxM` : un socle commun (classe d'aide « page » : `PosY`, seuil,
  rappel d'en-tête, pied) réduirait les quatre modules.

### Réduction de portée

- `bas_page`, `Centralisation`, `finmois`, `Raz` → `Private` : aucun appelant externe
  (`grep -rn "EditcompteM\."` ne trouve que `Imprime`). `finmois` reste testable via un test
  `gbtest` tant qu'il est `Public` : le passage en `Private` se fait après sa délégation à
  `LDate.Fin_Mois` (couverte par les tests LDate).

### Séparation traitement / GUI

- `Editcompte.Mouse` (l. 100, 274) : à déplacer dans `Editcompte.Button1_Click`.
- `Message` / `Music.Play` : `Imprime` renvoie un booléen « rien à imprimer », l'écran affiche le
  message.
- Le parcours comptes → écritures → centralisation peut produire une liste de lignes (calcul + SQL)
  rendue ensuite par une fonction PDF pure.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Ctrln` table permanente partagée (voir Editcompte) : table temporaire ou calcul `GROUP BY` mensuel.
- `Fiches_SousComptes` : une colonne « compte parent » dans `Fiches_Comptes` (ou un index sur
  `Fiches_SousComptes.code`, qui n'est pas indexé : seul `code_vtl` est clé) éviterait une requête par
  compte et la comparaison de chaînes sur `Dersouscomptes`.
- Voir `Balance` pour `compte_cc` numérique et les 6 tables d'écritures.
