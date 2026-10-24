# FRelCompte — Architecture

> Source : `.src/Compta/Relances/FRelCompte.class`

## Vue d'ensemble

`FRelCompte` édite des **relevés de compte** clients (411) ou fournisseurs (401) sur une période
(menu Comptabilité › Relevés › De compte, `Fmenu.Menu30_Click`). Il construit une table de travail
`Fiches_Relcomptes` (`DROP` + `CREATE` à chaque rafraîchissement, clé auto-incrémentée `lind`)
avec les écritures de la période, affiche un compte par ligne avec ses totaux, puis produit un PDF
(`~/tmp/RelCompte.pdf`, classe `Creleve`) pour tous les comptes ou les seuls comptes sélectionnés.

Contrôles : `DteN0`/`Dten1` (groupe `Dte`, tags 1/2), `RB1`/`RB2` (tous / sélection), `RB3`/`RB4`
(clients / fournisseurs), `Button2` (rafraîchir), boutons du groupe `Btn` : `Button7` (tag 1, aide),
`Button1` (tag 2, éditer), `Button6` (tag 3, fermer).

Son jumeau [`FRelFacture`](../FRelFacture.class/architecture.md) (relevés de factures) partage
environ 90 % du code.

Nature globale : **mixte** (SQL et PDF dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `jour` | var | Private |  | String | 29 |
| `dte1` | var | Private |  | String | 30 |
| `dte2` | var | Private |  | String | 31 |
| `Txt` | var | Private |  | String | 32 |
| `Enr` | var | Private |  | Integer | 33 |
| `son` | var | Private |  | Integer | 34 |
| `Coulfond` | var | Private |  | New String[] | 35 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 37-70 | Public | 1 | 31 | 0 | méthode spéciale |
| `MajTab` | 72-164 | Public | 13 | 90 | 0 | portée réductible ? |
| `dte_KeyPress` | 166-199 | Public | 11 | 29 | 0 | handler GUI |
| `Btn_Click` | 201-217 | Public | 6 | 11 | 0 | handler GUI |
| `dteN0_GotFocus` | 219-225 | Public | 1 | 5 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 227-241 | Public | 3 | 13 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 243-247 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 249-266 | Public | 4 | 16 | 0 | portée réductible ? |
| `Compdate` | 268-278 | Public | 3 | 9 | 0 | portée réductible ? |
| `Compdate2` | 280-291 | Public | 3 | 10 | 0 | portée réductible ? |
| `Releves` | 293-414 | Public | 23 | 119 | 0 | portée réductible ? |
| `Button1_Click` | 416-420 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button2_Click` | 422-426 | Public | 1 | 3 | 0 | handler GUI |
| `RB1_Click` | 428-432 | Public | 1 | 3 | 0 | handler GUI |
| `RB2_Click` | 434-438 | Public | 1 | 3 | 0 | handler GUI |
| `RB3_Click` | 440-444 | Public | 1 | 3 | 0 | handler GUI |
| `RB4_Click` | 446-450 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 452-456 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [spéciale] [GUI]. `Coulfond = Utils.Coulfd()` (**jamais utilisé**), observateurs,
  colonnes de `compteRel`, période par défaut du 1er du mois au jour, `dte1`/`dte2` = dates
  initiales, `Enr = 1`.
- **`MajTab()`** [portée : réductible, aucun appelant externe] [mixte] (CC 13). Recrée
  `Fiches_Relcomptes` (`Utils.db.AutoIncrement("lind")`, `Utils.db.Engine()`). Si les deux dates
  sont saisies : `SELECT * FROM Fiches_Mvt where left(compte,3) = &1 and dte >= &2 and dte <= &3
  and collectif is null order by compte` ; pour chaque écriture, fiche tiers (`Fiches_Cli` ou
  `Fiches_Four`, **sans test `Available`**) puis `INSERT` : côté client seulement si `cli_rlvc`
  (sous `Try`) ; côté fournisseur toujours (pas de `Try`, pas d'option de relevé). Puis liste des
  comptes avec cumul débit/crédit (`compteRel`). Sinon message « Veuillez saisir votre date ».
  Une requête de fiche par écriture (N+1).
- **`dte_KeyPress()`** [handler du groupe `Dte`] [GUI]. Validation de `DteN0` → focus sur `Dten1` ;
  validation de `Dten1` → `Button2` sauf si `Enr = 0` (date de fin refusée). F1 → aide.
- **`Btn_Click()`** [handler du groupe `Btn`] [GUI]. Tag 1 → aide, 2 → `Button1_Click`, 3 →
  suppression du PDF (`Kill`) et fermeture.
- **`dteN0_GotFocus()` / `dteN0_LostFocus()`** [handlers] [GUI]. Couleur en dur ; normalisation de
  la date ; `Catch` → refocus.
- **`dteN1_GotFocus()` / `dteN1_LostFocus()`** [handlers] [GUI]. Normalisation ; si la date de fin
  est **inférieure ou égale** à `dte1` → avertissement (`Compdate2`). `dte1` est la date de début
  **initiale** (fixée dans `_New`), pas la date saisie dans `DteN0` (FRELCOMPTE-A02).
- **`Compdate()`** [Public, **aucun appelant**] [GUI] — code mort.
- **`Compdate2()`** [portée : réductible] [GUI]. Avertissement, `Enr = 0`, refocus.
- **`Releves()`** [portée : réductible, appelée par `Button1_Click`] [mixte] (CC 23). En-tête
  société (`Fiches_Societes`, **sans test `Available`**) ; pour chaque ligne de `compteRel` (toutes
  ou sélectionnées selon `RB1`/`RB2`) : écritures du compte dans `Fiches_Relcomptes`, en-têtes
  `Entete`/`Entete2`/`Level1`/`Level2`, une ligne `Level3` par écriture (date `Format$`), cumuls
  `Totmtd`/`Totmtc` tenus en **chaînes** (`Val` + `Format$`, dépendant de la locale), saut de page à
  `PosY >= 283`, `Level4` totaux. `pdf.Output` + `Visualiseur.Prog` ; puis `MajTab()` (régénère la
  table et la liste après chaque édition). Le pays du client est aussi passé à l'en-tête société
  (`Entete(…, Pays, …)`), à confirmer.
- **`Button1_Click()`** [appelé par `Btn_Click`, `Button1` est dans le groupe `Btn`] [GUI].
  `Releves()`.
- **`Button2_Click()`, `RB1_Click()` … `RB4_Click()`** [handlers] [GUI]. `MajTab()`.
- **`Button7_Click()`** [appelé par `Btn_Click`] [GUI]. `Doc.Open("Releves")`.

## État global utilisé

- `Utils.db`, `Utils.Coulfd`, `Utils.Cdate_*`, `Utils.Observers` ; `Start.Son`, `Start.Musique`,
  `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Siret"]`.
- `Creleve`, `Visualiseur`, `Doc`.
- Table de travail `Fiches_Relcomptes` (absente de `db_control.csv`, citée dans un commentaire de
  `Fsoc.class:539`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Compdate` (mort) et `Coulfond` (affecté, jamais lu).
- `MajTab` : joindre la fiche tiers dans la requête (`LEFT JOIN Fiches_Cli ON cli_code = compte`)
  pour supprimer les N+1 requêtes ; SQL modifié, contenu de `Fiches_Relcomptes` identique (le
  replay compare le dump).
- Cumuls `Totmtd`/`Totmtc` en `Float`, formatés à l'affichage (même texte en locale française, à
  vérifier par replay).

### Commonalisation avec d'autres fichiers

- **Jumeau [`FRelFacture`](../FRelFacture.class/architecture.md)** : `_New`, `dte_KeyPress`,
  `Btn_Click`, `dteN*_*`, `Compdate*`, la construction de la liste et l'essentiel de `Releves` sont
  identiques. Une base commune (classe parente non graphique ou module `Releves` avec
  `ChargeListe(table, colonnes…)`, `EditeReleves(pdf, options)`) supprimerait environ 300 lignes.
  Les deux `.form` restent inchangés.
- **En-tête société** : même bloc que [`FEditrel`](../FEditrel.class/architecture.md),
  [`Ligcli`](../Ligcli.class/architecture.md), `Facturergbl`, `RelvMo` (voir LIGCLI-004).
- **Saisie de période** (`dte_KeyPress`, `dteN0/1_LostFocus`, `Compdate`, `Compdate2`) : idiome
  répété dans de nombreux écrans Compta (`Journaux`, `Balance`, `Editcompte`, `EcrM`, `Jourcent`,
  `RubImp`, `Verbal`, `ExportJdv`…) ; candidat à un contrôle ou helper commun en phase 3.

### Réduction de portée

- `MajTab`, `Compdate2`, `Releves` → `Private` (aucun appelant externe, vérifié par grep ; `MajTab`
  est couvert par les handlers `RB*`/`Button2`).
- `Button1_Click` et `Button7_Click` portent un nom de handler mais ne sont pas des handlers
  (boutons du groupe `Btn`) : les garder `Public` et sous ce nom par prudence (règle des noms
  `Objet_Evenement`).

### Séparation traitement / GUI

- `MajTab` : `ConstruitTable(type, dn0, dn1)` sans contrôle, puis `RemplitListe()`.
- `Releves` : la liste des comptes à éditer est construite à partir de `compteRel`/`RB*` puis
  passée à une fonction d'édition sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table de travail permanente par utilisateur ou requête directe sur `Fiches_Mvt` (la table
  intermédiaire ne sert qu'à trier et grouper).
- Option de relevé côté fournisseur (`fo_rlvc`) symétrique de `cli_rlvc`.
