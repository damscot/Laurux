# Cielimp — Architecture

> Source : `.src/Compta/Cielimp.class`

## Vue d'ensemble

Écran d'**import des écritures Ciel** (fichier texte à positions fixes) dans `Fiches_Mvt`.
Ouvert en modal par `Fmenu.Menu182_Click` (`Fmenu.class:1721`, `Cielimp.ShowModal()`). L'import est **unique** par base : `Fiches_Parametres.imp_ciel = "1"`
le bloque ensuite.

Déroulement (bouton « Importer », `Btn_Click` Tag 2) :

1. création au besoin des tables `Ciel_Lrx`, `Ciel_Lrx_Jo` et de la colonne `imp_ciel`
   (bloc DDL recopié de `Utils.Ciel`, avec `Cciel Char(10)` au lieu de `Char(15)`) ;
2. **`controle_comptes`** : lecture complète du fichier ; contrôle de l'équilibre de chaque
   écriture ; **création automatique** dans `Fiches_Comptes` des comptes généraux absents (type
   déduit de la classe : 1-5 → B, 6-7 → G, 401 → F, 411 → C ; 512/530 → trésorerie) ; contrôle
   que les comptes 401/411 sont dans `Ciel_Lrx` et que les journaux existent (`Fiches_Journaux`
   ou `Ciel_Lrx_Jo`), les manquants étant listés dans la table de travail `Cptabs` et dans des
   fichiers `~/tmp/FCompte`, `~/tmp/FJournaux`, `~/tmp/FClients` ouverts dans l'éditeur ;
3. si aucun compte n'a été créé, aucune correspondance ne manque et tout est équilibré :
   confirmation puis **`Compta`** (insertion des écritures).

Format de ligne lu (positions 1-based, `Mid$`) :

| Champ | Position | Remarque |
|---|---|---|
| numéro d'écriture Ciel | 1-5 | rupture d'écriture |
| journal | 6-7 | traduit par `Ciel_Lrx_Jo` |
| date | 8-15 | insérée telle quelle dans `dte` |
| pièce | 24-35 | `numdoc = <numr> & pièce` |
| compte | 36-(36 + `Lcpt` - 1) | longueur choisie dans `Lcpt` (6 à 10) |
| libellé | 47-76 | 30 caractères (25 dans `Compta2`) |
| montant | 75-84 | chevauche la fin du libellé |
| sens | 85 | `D` débit, sinon crédit |
| intitulé du compte | 104-133 | 30 caractères (34 dans `Compta2`) |

Nature globale : **mixte** : lecture de fichier, SQL et messages dans les mêmes fonctions.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 27 |
| `rResult` | var | Private |  | Result | 28 |
| `ParaResult` | var | Private |  | Result | 29 |
| `collectif` | var | Private |  | String | 30 |
| `Jnl` | var | Private |  | String | 31 |
| `numecr` | var | Private |  | String | 32 |
| `numr` | var | Private |  | Integer | 33 |
| `b` | var | Private |  | Integer | 34 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-41 | Public | 1 | 4 | 0 | méthode spéciale |
| `Btn_Click` | 43-81 | Public | 11 | 33 | 0 | handler GUI |
| `controle_comptes` | 83-245 | Public | 54 | 158 | 0 | portée réductible ? |
| `Svs2_Click` | 247-257 | Public | 3 | 9 | 0 | handler GUI |
| `Compta` | 259-396 | Public | 24 | 132 | 0 | portée réductible ? |
| `Compta2` | 399-556 | Public | 40 | 147 | 0 | portée réductible ? |
| `Parametres` | 561-569 | Public | 2 | 6 | 0 | portée réductible ? |
| `Ecritures` | 574-585 | Public | 2 | 9 | 0 | portée réductible ? |
| `Maj_Parametres` | 590-598 | Public | 1 | 7 | 0 | portée réductible ? |
| `Majnum` | 603-608 | Public | 1 | 4 | 0 | portée réductible ? |
| `Button3_Click` | 610-614 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI]. Observateurs, centrage.
- **`Btn_Click()`** (CC 11) [handler du groupe `Btn`] [nature : mixte]. Tag 1 → aide
  (`Button3_Click`), Tag 2 → DDL Ciel puis `controle_comptes` si `imp_ciel <> "1"`, Tag 3 → fermer.
  Le DDL duplique `Utils.Ciel()` (16 lignes) avec une longueur `Cciel` différente pour `Ciel_Lrx`.
- **`controle_comptes()`** (CC 54, max du fichier) [portée : réductible] [nature : mixte].
  Décrit ci-dessus. SQL : `drop/CREATE TABLE Cptabs`, `SELECT` sur `Ciel_Lrx`, `Fiches_Comptes`,
  `Fiches_Journaux`, `Ciel_Lrx_Jo` par ligne lue, `INSERT INTO Fiches_Comptes (…)`,
  `INSERT INTO Cptabs`. Le cumul `Tot` (chaîne) mélange arithmétique et formatage
  (`Val(Format$(tot, "0.00"))`). Sortie anticipée (`Return`) sur écriture déséquilibrée sans
  fermer les quatre fichiers ni remettre la souris. Le membre `b` (comptes créés) n'est **jamais
  remis à 0** (voir CIELIMP-A01).
- **`Svs2_Click()`** [handler] [nature : GUI]. Sélection du fichier (`Dialog.OpenFile`).
- **`Compta()`** (CC 24) [portée : réductible] [nature : mixte]. Relit le fichier ; nouveau
  numéro d'écriture `numr` à chaque rupture du numéro Ciel ; journal traduit ; trésorerie selon
  `Fiches_Journaux.type_jo` ; compte 401/411 traduit par `Ciel_Lrx`. Pour un compte de tiers, insère
  **deux lignes** : une sur le compte collectif (`coll_cc` du compte Laurux, `collectif = "1"`) et
  une sur le compte de tiers ; met à jour le solde de chacun. Les écritures sont insérées
  `validee = 1`, `cloturee = 1`, `numerodef = numr`. En fin : `Majnum("numecriture", numr)`,
  `imp_ciel = 1`, puis **`tresorerie = 1, datee = dte` pour toute écriture ayant une ligne sur
  le compte `51210000` en dur**. `Mtd` est converti implicitement (`Mtd = Mid$(…)`), `Mtc` par
  `Val(Utils.cpoint(…))` ; `Mtd` est inséré sans `PointBase` sur la ligne de tiers. Code mort :
  `Tabc`, `dte1`, `dnc`, `Filetxt4`, `Nbe2` (jamais incrémenté), `SELECT` l. 347.
- **`Compta2()`** (CC 40) [portée : réductible, **code mort**] [nature : mixte]. Variante « Sage
  au format Ciel expert » (comptes de tiers ramenés à `411001`/`401001`, création des comptes à
  la volée) : **aucun appelant**. 92 % de ses lignes sont identiques à `Compta`.
- **`Parametres()`** [portée : réductible] [nature : calcul]. Lit `Fiches_Parametres.jrnal` dans
  le membre `Jnl`, jamais utilisé ensuite (code mort fonctionnel).
- **`Ecritures(numecr2)`** [portée : réductible] [nature : calcul]. `SELECT <numecr2> FROM
  Fiches_Parametres` (nom de colonne concaténé, constant) ; écrit le membre `numr` et le renvoie
  en `String`.
- **`Maj_Parametres()`** [portée : réductible] [nature : calcul]. `SELECT` inutile puis
  `UPdate Fiches_Parametres SET imp_ciel = 1`.
- **`Majnum(numecr2, numr2)`** [portée : réductible] [nature : calcul]. `UPdate Fiches_Parametres
  set <numecr2> = &1`. Le compteur définitif `numecriture2` n'est pas mis à jour alors que
  `numerodef` reçoit `numr` (à confirmer, CIELIMP-A08).
- **`Button3_Click()`** [portée : nécessaire, appelé par `Btn_Click` Tag 1] [nature : GUI].
  `Doc.Open("Cielimport")`. Nom trompeur : le bouton `Button3` du `.form` est « Importer »
  (Tag 2) ; la méthode ne peut pas être renommée sans vérifier `ReplayObserver`.

## État global utilisé

- `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Utils.Observers`, `Editeur.Prog_Editeur`.
- `User.Home` (fichiers `~/tmp/F*`), contrôles `Fimport`, `Lcpt`.
- Membres d'instance : `Tab`, `rResult`, `ParaResult`, `collectif`, `Jnl`, `numecr`, `numr`, `b`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Compta2` (158 lignes, aucun appelant) et les variables mortes (CIELIMP-002).
- Une fonction pure `LigneCiel(lig, nLong) As Collection` (positions du tableau ci-dessus)
  utilisée par `controle_comptes` et `Compta` (CIELIMP-005).
- `TypeCompte(sCompte) As String` pour les 4 tests de classe (CIELIMP-006).
- Fermer les fichiers (`Close #hFile`) dans tous les chemins (anomalie A02, car la fermeture
  change l'état visible du système de fichiers).

### Commonalisation avec d'autres fichiers

- DDL Ciel : `Utils.Ciel()` (voir [`Utils`](../../Utils/Utils.module/architecture.md),
  UTILS-T19) ; unification impossible sans changer la longueur de `Cciel` (CIELIMP-A07).
- Numérotation des écritures `Ecritures`/`Majnum` : copies voisines dans
  [`Moulinage`](../../Caisse/Moulinage.class/architecture.md), `ValidBR`, `Tresor`, `TresorFac`,
  `Facture` → helper `Utils.NumEcriture(sChamp)` / `Utils.MajNumEcriture(sChamp, n)` (phase 3).
- Création de compte dans `Fiches_Comptes` (`INSERT … compte_cc, intitule_cc, type_cc …`) :
  également dans `impfec` et `FComptes`.
- Écrans de correspondance : [`Cielcorsp`](../Cielcorsp.class/architecture.md) et
  [`Cielcorspj`](../Cielcorspj.class/architecture.md).

### Réduction de portée

- `controle_comptes`, `Compta`, `Parametres`, `Ecritures`, `Maj_Parametres`, `Majnum` →
  `Private` (aucun appel `Cielimp.` dans le projet ; les fonctions homonymes de `Moulinage` et
  `Facture` sont locales).

### Séparation traitement / GUI

- `ControleFichier(sFichier, nLong) As Collection` (comptes à créer, tiers manquants, journaux
  manquants, déséquilibres) sans message ; `ImporteFichier(sFichier, nLong) As Integer` (nombre
  d'écritures) ; `Btn_Click` garde les messages, l'éditeur et la souris.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `imp_ciel` (drapeau d'import unique) et les tables `Ciel_*`, `Cptabs` hors schéma de
  référence : à intégrer par une migration ou à remplacer par un journal des imports.
- Clé d'idempotence (numéro d'écriture Ciel d'origine) dans `Fiches_Mvt` pour permettre un
  réimport partiel sans doublon.
