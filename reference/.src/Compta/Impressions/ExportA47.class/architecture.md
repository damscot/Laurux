# ExportA47 — Architecture

> Source : `.src/Compta/Impressions/ExportA47.class`

## Vue d'ensemble

`ExportA47` est l'écran **« Export des écritures au format A47 (FEC) »** (menu Compta,
`Fmenu.Menu298_Click`, `ExportA47.ShowModal()`). Il produit le **fichier des écritures
comptables** prévu par l'article A47 A-1 du livre des procédures fiscales, format
**réglementaire** : tout écart d'un octet peut rendre le fichier non conforme. Le rework doit donc
le reproduire **à l'identique** (tests de comparaison octet par octet).

- Choix d'une période : boutons radio `EC` « Exercice en cours », `EN` « Exercice précédent »,
  `E1`…`E5` « Exercice N-1 … N-5 », qui fixent la table (`Fiches_Mvt` … `Fiches_Mvt5`) et les
  bornes `dte1`/`dte2` (objets [`LDate`](../../../Utils/LDate.class/architecture.md), propriétés
  `EDeb`/`EFin` calculées depuis `dteclec*`) ; saisie libre ou calendrier (`DateChooser1`),
  contrôlée par `CheckDate` dans ces bornes.
- Répertoire de sortie `Chmexport` (mémorisé dans `/Soc<XX>/Chemin-export`), adresse
  `Adrexport` (`/Soc<XX>/Adr-export`) et case « Envoi par Mail » (`/Soc<XX>/Expmail`), cette
  dernière **sans effet** (la fonction d'envoi `export()` n'est jamais appelée).
- Export (`Button2_Click`) : fichier `<Chmexport>/<SIREN>FEC<fin aaaammjj>-<début aaaammjj>`.

### Format produit (comportement actuel, à figer)

- Ligne d'en-tête : `JournalCode|Journallib|EcritureNum|EcritureDate|CompteNum|CompteLib|
  CompAuxNum|CompAuxLib|PieceRef|PieceDate|EcritureLib|Debit|credit|EcritureLet|DateLet|
  ValidDate|MontantDevise|Idevise|` suivie de `\r\n` (`gb.Cr` + saut de ligne de `Print`).
- Une ligne par écriture validée **non collective** et de montant net non nul, 18 champs
  séparés par `|`, terminée par `|\r\n` :

| # | Champ | Valeur | Mise en forme |
|---|---|---|---|
| 1 | JournalCode | `jour` | complété à 2 caractères |
| 2 | JournalLib | `libelle_jo` (15 premiers caractères, `Utils.Accent`, `Trim`) | complété à 15 |
| 3 | EcritureNum | `numero` (édition provisoire) ou `numerodef` ; `Err:<7 derniers chiffres>` si `numerodef` est nul | complété à 11 |
| 4 | EcritureDate | `datee`, sinon `dte` | `aaaammjj` (`LDate.F`) |
| 5 | CompteNum | `compte` | complété à 8 |
| 6 | CompteLib | `intitule` de la ligne (40 car., `Accent`, `Trim`) | complété à 40 |
| 7-8 | CompAuxNum / CompAuxLib | toujours vides | 8 et 40 espaces |
| 9 | PieceRef | `numdoc`, sinon `numero` | complété à 10 |
| 10 | PieceDate | `dte` | `aaaammjj` |
| 11 | EcritureLib | `libelle` (30 car., `Accent`, `Trim`) | complété à 30 |
| 12-13 | Debit / Credit | solde net de la ligne (`montantd − montantc` d'un seul côté), `Format$(…, "0.00")` (séparateur décimal **de la locale**) | aligné à droite sur 15 |
| 14-15 | EcritureLet / DateLet | vides | |
| 16 | ValidDate | `dteval`, sinon `dte` | `aaaammjj` |
| 17-18 | MontantDevise / Idevise | vides | |

- Les libellés manquants sont remplacés par `Err intitule compte: …`, `Err jrnl: …`,
  `Err libelle ecriture: …` et signalés en fin d'export.
- « Provisoire » : fin de période postérieure à `dtepc` (dernière clôture de période) →
  numérotation `numero` ; sinon numérotation définitive `numerodef`.

Nature globale : **mixte** ; tout le traitement réglementaire est dans le handler
`Button2_Click` (CC 34, la plus forte du lot).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dte1` | var | Private |  | LDate | 27 |
| `dte2` | var | Private |  | LDate | 28 |
| `hfile` | var | Private |  | File | 29 |
| `Org` | var | Private |  | String | 30 |
| `rResult` | var | Private |  | Result | 31 |
| `Intitule_Soc` | var | Private |  | String | 32 |
| `dte` | var | Private |  | String | 33 |
| `dte4` | var | Private |  | String | 34 |
| `jour` | var | Private |  | String | 35 |
| `txt` | var | Private |  | String | 36 |
| `Tab0` | var | Private |  | String | 37 |
| `extension` | var | Private |  | String | 38 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 40-60 | Public | 5 | 19 | 0 | méthode spéciale |
| `Ex1` | 62-75 | Public | 1 | 11 | 0 | portée réductible ? |
| `finmois` | 79-90 | Public | 2 | 9 | 0 | portée réductible ? |
| `Exo` | 92-105 | Public | 1 | 11 | 0 | portée réductible ? |
| `Exo1` | 107-120 | Public | 1 | 11 | 0 | portée réductible ? |
| `Exo2` | 122-135 | Public | 1 | 11 | 0 | portée réductible ? |
| `Exo3` | 137-150 | Public | 1 | 11 | 0 | portée réductible ? |
| `Exo4` | 152-165 | Public | 1 | 11 | 0 | portée réductible ? |
| `Exo5` | 167-180 | Public | 1 | 11 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 182-208 | Public | 10 | 21 | 0 | handler GUI |
| `Btn_Click` | 210-226 | Public | 4 | 12 | 0 | handler GUI |
| `DteN0_GotFocus` | 228-235 | Public | 1 | 6 | 0 | portée réductible ? |
| `DteN0_LostFocus` | 237-241 | Public | 1 | 3 | 0 | portée réductible ? |
| `DteN1_GotFocus` | 243-248 | Public | 1 | 4 | 0 | portée réductible ? |
| `DteN1_LostFocus` | 250-254 | Public | 1 | 3 | 0 | portée réductible ? |
| `CheckDate` | 256-274 | Public | 7 | 15 | 0 | portée réductible ? |
| `EC_Click` | 277-282 | Public | 1 | 4 | 0 | handler GUI |
| `EN_Click` | 284-289 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 291-296 | Public | 1 | 4 | 0 | handler GUI |
| `E2_Click` | 298-303 | Public | 1 | 4 | 0 | handler GUI |
| `E3_Click` | 305-310 | Public | 1 | 4 | 0 | handler GUI |
| `E4_Click` | 312-317 | Public | 1 | 4 | 0 | handler GUI |
| `E5_Click` | 319-324 | Public | 1 | 4 | 0 | handler GUI |
| `Svs2_Click` | 326-336 | Public | 2 | 9 | 0 | handler GUI |
| `export` | 338-356 | Public | 3 | 16 | 0 | portée réductible ? |
| `Button2_Click` | 358-545 | Public | 34 | 155 | 0 | portée réductible ? |
| `donnees1` | 547-551 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees2` | 553-557 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees3` | 559-563 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button3_Click` | 565-569 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 571-580 | Public | 2 | 8 | 0 | handler GUI |
| `Button1_Click` | 582-591 | Public | 2 | 8 | 0 | handler GUI |
| `DateChooser1_Activate` | 593-603 | Public | 2 | 9 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et période

- **`_New()`** [portée : nécessaire] [nature : mixte]. Observateurs, son ; `SELECT * FROM
  Fiches_Societes` **sans `WHERE`** pour `Intitule_Soc` (jamais utilisé) ; restaure
  `Chmexport` (défaut : `User.Home`), `Adrexport`, `Envoi` ; message d'invite ; `EC_click`.
- **`Ex1()`** [portée : réductible] [nature : mixte]. « Exercice en cours » :
  `dte1 = LDate(Now + 1 an).EDeb`, `dte2 = LDate(dte1 + 1 an).EFin`. Avec un exercice civil et
  `dteclec` antérieure à l'année courante, `LDate.Exercice_Fin` renvoie la clôture de l'année de
  la date fournie : la période proposée est alors **N+1 à N+2** (deux exercices futurs) au lieu
  de l'exercice courant ; pour un exercice décalé, le décalage d'un an compense LDATE-A03
  (anomalie A02, à confirmer). Lit inutilement `Fiches_Parametres`.
- **`Exo()`, `Exo1()`…`Exo5()`** [portée : réductible] [nature : mixte]. `dte1`/`dte2` =
  `LDate(dteclec<n>).EDeb`/`.EFin` (un `SELECT * FROM Fiches_Parametres` plus deux requêtes par
  propriété `LDate`). Seule implémentation du lot fondée sur `LDate`.
- **`EC_Click`, `EN_Click`, `E1_Click`…`E5_Click`** [portée : nécessaire] [nature : GUI].
  `Tab0` en dur, puis la fonction d'exercice.
- **`finmois(Jrs)`** [portée : réductible] — **code mort** (dernier jour du mois, aucun appel).

### Saisie

- **`Cmpt_KeyPress()`** [nature : GUI]. Entrée/Tab : `DteN0` → `Dten1` ; F1 : aide.
- **`Btn_Click()`** [nature : mixte]. `Tag` 1 aide, 2 export, 4 enregistre `Adr-export` et
  `Chemin-export` (sans `Save` explicite) et ferme.
- **`DteN0_GotFocus/LostFocus`, `DteN1_GotFocus/LostFocus`** [nature : GUI]. Couleur de fond et
  `CheckDate()` à chaque entrée **et** sortie de champ.
- **`CheckDate()`** [portée : réductible] [nature : mixte]. Début hors `[dte1, dte2[` → message
  et remise à `dte1` ; fin hors `]dte1, dte2]` → message et remise à `dte2` ; renvoie `False`
  après correction. Utilise `LDate(Texte)` (message d'erreur de `LDate` si la saisie est
  illisible).
- **`Button4_Click`, `Button1_Click`, `DateChooser1_Activate`** [nature : GUI]. Calendrier pour
  le début (`Org = "1"`) ou la fin (`"2"`), recopie `dd.mm.yyyy`, `CheckDate`.
- **`Svs2_Click()`** [nature : GUI]. Choix du répertoire (annulation → `User.Home`).

### Export

- **`Button2_Click()`** (CC 34) [portée : nécessaire] [nature : mixte].
  1. `CheckDate()` ; SIREN = 9 premiers caractères de `siret_sc` sans espaces
     (`Cbase.Table("TabSoc")`, société courante).
  2. `dtepc` → qualification provisoire/définitive (voir ci-dessus).
  3. `DROP TABLE IF EXISTS centralisation` / `CREATE TABLE centralisation` (`FLOAT`,
     `Char(40)`) : **inutile** (A09).
  4. Supprime puis crée le fichier ; `SELECT * FROM <Tab0> a inner join Fiches_Journaux i on
     i.code_jo = a.jour WHERE a.validee = 1 And a.dte >= <début .D> And a.dte <= <fin .D> order
     by a.dte, a.numero, a.compte` (bornes `yyyy-mm-dd` sur une colonne `datetime` : A07).
  5. Barre de progression `ProgBar` ; en-tête ; pour chaque ligne :
     `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1` (**une requête par ligne**) — compte
     absent : `Message.Error` puis `Me.Close` **sans sortir de la boucle** (A01) ; `Type` lu mais
     inutilisé ; compensation débit/crédit ; dates ; numérotation ; libellés (`Utils.Accent`, qui
     transforme `'` en `\'` et `ô` en `e`) ; `PieceRef` ; ligne écrite par `donnees3` si non
     collective et non nulle. Annulation de la barre (`Avancement` → `True`) : `Break`.
  6. Fermeture du fichier ; message d'erreurs réglementaires (numéros des 20 premiers caractères
     d'écritures en défaut) ou proposition d'ouvrir le fichier dans l'éditeur. Sans écriture :
     « Aucune ecriture pour cette demande ».
  Bourrage par `String$(n - Len(x), " ")` : comportement de `String$` pour une longueur
  négative (champ plus long que prévu : `numdoc` > 10, `compte` > 8, `numero` > 11, intitulé de
  40 caractères contenant une apostrophe) à confirmer (A08). Variables locales inutilisées :
  `Tab`, `Tab2`, `Tab4`, `pl`, `TotSldHP`, `ColResult` partiellement, blocs commentés.
- **`donnees3(p1 … p18)`** [portée : réductible] [nature : calcul (fichier)]. Écrit les 18
  champs séparés par `|`, puis `|` et `gb.Cr` (suivi du `\n` de `Print`).
- **`donnees1`, `donnees2`** — **code mort** (format `;` hérité de `Journaux`).
- **`export()`** [portée : réductible] — **code mort** : envoi par `EnvMail.Envoi2` d'un fichier
  `<Chemin-export>/ecritures.<extension>` (`extension` jamais renseignée).
- **`Button3_Click()`** [nature : GUI]. Aide `Doc.Open("Export")`.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Chemin-export"|"/Adr-export"|"/Expmail"]`, `Start.Societe`,
  `Start.Musique`, `Start.son`.
- `Utils.db`, `Utils.Accent`, `Utils.Observers` ; `LDate` (`EDeb`, `EFin`, `G`, `L`, `D`, `F`) ;
  `Cbase.Table("TabSoc")`, `("TabJour")` ; en dur : `Fiches_Parametres`, `Fiches_Comptes`,
  `Fiches_Mvt*`, `centralisation`.
- `ProgBar`, `Editeur.Prog_Editeur`, `Dialog`, `EnvMail` (code mort), `Doc.Open`.
- Locale du processus : `Format$(…, "0.00")` produit `12,50` en français ; le fichier dépend
  donc de `LANG`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Isoler la génération dans une fonction pure (voir séparation) et la décomposer :
  `MontantsNets(d, c)`, `NumeroEcriture(r, bDefinitif)`, `LibelleControle(valeur, n, defaut)`,
  `Bourre(s, n)` / `BourreGauche(s, n)` reproduisant exactement `String$(n - Len(s), " ")`.
- Remplacer la requête `Fiches_Comptes` par ligne par une jointure ou un cache des comptes
  existants (même fichier ; seul le journal SQL change).

### Commonalisation avec d'autres fichiers

- `Exo`…`Exo5` → variante `LDate` du socle `Bornes(index)` (BALANCE-004) décrit dans
  [Journaux](../Journaux.class/architecture.md) ; idéalement `LDate.Exercice_Cloture(n)`, fonction
  aujourd'hui sans appelant (voir [LDate](../../../Utils/LDate.class/architecture.md)), après
  vérification que les bornes produites sont identiques.
- `Tab0` → `ImpCompta.TableMvt(index)` (`Cbase.Table("TabMvt…")`).
- SIREN depuis `siret_sc` : à partager avec `CTestTVA.Siren` (Fsoc, FFournisseur ; notes
  transverses du lot Communs).
- Export texte délimité : `ExportJdv` (`.src/Compta/Utils/`) partage la lecture des exercices et
  `Utils.Accent` ; un module d'export comptable commun reste à évaluer avec le lot `Compta/Utils`.

### Réduction de portée

- `Ex1`, `Exo`…`Exo5`, `CheckDate`, `donnees3` → `Private` ; `finmois`, `export`, `donnees1`,
  `donnees2` → suppression (code mort ; aucun appel `ExportA47.` hors `Fmenu`).

### Séparation traitement / GUI

- `GenereFEC(sFichier, dDeb, dFin, sTab, bDefinitif, hProgression) As String` (renvoie la liste
  des écritures en erreur) sans accès aux contrôles ; le handler garde `CheckDate`, le curseur,
  les messages et la question d'ouverture. Cette fonction devient testable en `gbtest`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Stocker le SIREN dans une colonne dédiée de `Fiches_Societes` (aujourd'hui extrait de
  `siret_sc`).
- Renseigner `CompAuxNum`/`CompAuxLib` exige de relier chaque compte de tiers à son collectif
  (`coll_cc` de `Fiches_Comptes`, code commenté l. 427-434) : à arbitrer avec l'expert-comptable.
