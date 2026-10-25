# TriFacture — Architecture

> Source : `.src/Affichages/TriFacture.class`

## Vue d'ensemble

`TriFacture` est une **liste de sélection multiple de documents de vente** (`Fiches_Bl` : proformas,
devis, commandes, BL, factures) bâtie sur le composant générique [`TriGen`](../TriGen.class/architecture.md),
créé dynamiquement dans `Panel2`. Introduite par le commit `7101bb39` (2022, « Modification
Reglement BL/Facture en caisse ») en remplacement de [`TriBl`](../TriBl.class/architecture.md), elle
est ouverte par la caisse (`Caisse.Button30_click`, choix 2 « Régler des bons de caisse ») avec le
filtre `BonFacNonPaye` et le numéro du ticket en cours.

Fonctionnement :

- la liste déroulante `CB1` choisit le type de document (énumération `Tous` … `BonFacNonPaye`,
  dans le même ordre que les entrées de `CB1`) ; `Filter_Calc` en déduit un filtre SQL
  (`type in (…)`, `acquitte`, client, ticket) passé à `TriGen.ExtraSel` ;
- un clic sur une ligne lève `TriGen_MajSel` (TriGen a d'abord écrit `Bsel`/`Bval` sur cette
  fenêtre par `Object.SetProperty`) : le numéro est ajouté ou retiré de `Selected`, puis
  `Stop Event` empêche TriGen de fermer la fenêtre ;
- `TriGen_Data` colore les lignes sélectionnées ; `TriGen_Raz` vide la sélection ;
  `SelectAllFil`/`DeSelectAllFil` (dé)sélectionnent toutes les lignes filtrées
  (`TriGen.GetAllFiltered`) ;
- `Total_Calc` affiche le nombre et les totaux HT/TTC de la sélection ;
- à la fermeture (`Form_Close`), la sélection est rendue à l'objet `ob` : si c'est un `LTrans`,
  dans la liste **statique** `LTrans.List` ; sinon par `Object.SetProperty(ob, "Bsel"/"Bval")`
  (premier élément seulement). Le seul appelant passe un `LTrans`.

Au démarrage, la sélection est initialisée avec les BL déjà rattachés au ticket (`numtick`).

Nature globale : **GUI** avec SQL (filtre, totaux) ; `Utils.Observers(Me)` est appelé.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tous` | enum | Public | oui |  | 3 |
| `Proforma` | enum | Public | oui |  | 3 |
| `Devis` | enum | Public | oui |  | 3 |
| `Commande` | enum | Public | oui |  | 3 |
| `Bon` | enum | Public | oui |  | 3 |
| `FacTous` | enum | Public | oui |  | 3 |
| `FacPaye` | enum | Public | oui |  | 3 |
| `FacNonPaye` | enum | Public | oui |  | 3 |
| `BonFacNonPaye` | enum | Public | oui |  | 3 |
| `tr` | var | Private |  | TriGen | 5 |
| `Client` | var | Private |  | String | 6 |
| `NumTick` | var | Private |  | String | 7 |
| `Col` | var | Private |  | Collection | 8 |
| `CB1Conv` | var | Private |  | Collection | 9 |
| `Obj` | var | Private |  | Object | 10 |
| `Bsel` | var | Public |  | Boolean | 11 |
| `Bval` | var | Public |  | String | 12 |
| `Coul` | var | Private |  | LCoul | 13 |
| `Selected` | var | Private |  | String[] | 14 |
<!-- /AUTO:declarations -->

| Membre | Usage |
|---|---|
| `Tous` … `BonFacNonPaye` | énumération publique utilisée par `Caisse` (`TriFacture.BonFacNonPaye`) ; valeurs = index de `CB1` |
| `Bsel`, `Bval` | **doivent rester `Public`** : écrits par `TriGen` (`Object.SetProperty(Obj, "Bsel"/"Bval")`, `TriGen.class:138`, `228-232`) puis lus dans `TriGen_MajSel` |
| `tr` | instance de `TriGen` (événements `TriGen_*`) |
| `Client`, `NumTick` | filtres client et ticket |
| `Col` | définition des colonnes (`ObjProp`) |
| `CB1Conv` | libellé de `CB1` → liste SQL de types (`("P","D",…)`) |
| `Obj` | destinataire du résultat (`LTrans` ou fenêtre) |
| `Coul` | `LCoul` : expression SQL de couleur de fond (`Fac_DB_bgcolor`) |
| `Selected` | numéros de BL sélectionnés |

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 17-91 | Public | 13 | 65 | 0 | méthode spéciale |
| `Update_Req` | 93-138 | Public | 2 | 41 | 0 | portée réductible ? |
| `Filter_Calc` | 140-167 | Public | 7 | 20 | 0 | portée réductible ? |
| `Total_Calc` | 169-184 | Public | 3 | 12 | 0 | portée réductible ? |
| `SelectAllFil_Click` | 186-204 | Public | 4 | 16 | 0 | handler GUI |
| `DeSelectAllFil_Click` | 206-224 | Public | 4 | 16 | 0 | handler GUI |
| `CB1_Click` | 226-230 | Public | 1 | 3 | 0 | handler GUI |
| `TriGen_MajSel` | 234-257 | Public | 4 | 20 | 0 | handler GUI |
| `TriGen_Raz` | 259-265 | Public | 1 | 5 | 0 | handler GUI |
| `TriGen_Data` | 267-278 | Public | 2 | 7 | 0 | handler GUI |
| `Form_Close` | 280-302 | Public | 6 | 21 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Option, Cl, Nt, ob)`** [portée : nécessaire (constructeur)] [nature : mixte]. Tous les
  paramètres sont optionnels : dans `New TriFacture(Null, TriFacture.BonFacNonPaye, Null, numero_tk,
  Selection)` (`Caisse.class:7160`), le premier argument est le `Parent` de la `Form` (règle Gambas :
  obligatoires de `_new`, puis `Parent`, puis optionnels), ce qui est correct. Remplit `CB1` et
  `CB1Conv` (9 entrées), positionne `CB1` selon `Option` (`Select Case` de 9 cas), lit les BL du
  ticket (`SELECT numbl FROM TabBl WHERE numtick = &1`, `Result.All`), initialise `LTrans.List` ou
  remet `Bsel`/`Bval` de `ob` à vide, puis `Update_Req`.
- **`Update_Req()`** [portée : réductible] [nature : mixte] : exécute
  `select *, <Fac_DB_bgcolor> from TabBl` **sans filtre** uniquement pour obtenir `Res.Fields`,
  construit les 9 colonnes `ObjProp` (tri par défaut sur le nom), crée le `TriGen` (`New TriGen(Panel2,
  Col, Res, Req, 20, Me) As "TriGen"`), puis `Filter_Calc` et `Total_Calc`.
- **`Filter_Calc()`** [portée : réductible] [nature : calcul + appel GUI] : filtre
  `type in <CB1Conv>` + `acquitte` (non payé : `= 0 or is null` ; payé : `= 1`) + client
  (`Utils.db.Subst`) + ticket (`numtick = &1 or numtick is Null`) ; appelle
  `tr.ExtraSel(filter, "and")` (qui relance la requête de TriGen). La branche `filter = ""` est
  inatteignable.
- **`Total_Calc()`** [portée : réductible] [nature : mixte] : `select sum(totalht), sum(totalttc)
  from TabBl where numbl in (<Selected.Join(",")>)` — liste **concaténée sans guillemets**
  (TRIFACTURE-A01) ; affiche les totaux.
- **`SelectAllFil_Click()` / `DeSelectAllFil_Click()`** [handlers] [nature : mixte] : parcourent
  `tr.GetAllFiltered()` (`Repeat … Until MoveNext`) et ajoutent/retirent chaque `numbl`, puis
  compteur, totaux et `tr.Refresh_Data`.
- **`CB1_Click()`** [handler] : `Filter_Calc`. La sélection n'est pas vidée (des lignes
  sélectionnées peuvent devenir invisibles).
- **`TriGen_MajSel(val)`** [handler d'événement de `TriGen`] [nature : mixte] : si `Bsel`, bascule
  `val` dans `Selected`, met à jour compteur/totaux, remet `Bsel` à `False` ; `Val = ""` (affectation
  d'un paramètre, sans effet) ; `Stop Event` dans tous les cas (la fenêtre ne se ferme jamais sur un
  clic). `Dim Res` inutilisé.
- **`TriGen_Raz()`** [handler] : vide la sélection et les totaux.
- **`TriGen_Data(id, key, Data)`** [handler] : fond `Color.SelectedBackground` pour une ligne
  sélectionnée (`Stop Event`), sinon couleur par défaut de TriGen (`bgcolor`).
- **`Form_Close()`** [handler] [nature : mixte] : rend la sélection (voir vue d'ensemble).

## État global utilisé

- `LTrans.List` (tableau statique partagé entre `TriFacture` et `Caisse`).
- `Utils.db` (`Exec`, `Subst`), `Utils.Observers`, `Cbase.Table("TabBl")`.
- `LCoul.Fac_DB_bgcolor` (couleurs de fond par type / acquittement).

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : `CB1.Text = CB1.List[Option]` avec repli sur 0 hors bornes, et construction de `CB1` /
  `CB1Conv` à partir d'un tableau de couples (libellé, types) ; supprime le `Select Case` de 9 cas.
- `Update_Req` : la requête sans filtre ne sert qu'à obtenir `Fields` ; ajouter `LIMIT 0` (ou
  `WHERE 1 = 0`) évite un parcours complet de `Fiches_Bl` (SQL modifié, dump identique). À vérifier :
  `TriGen._new` utilise-t-il le contenu de `Resu` ou seulement ses champs ? (à confirmer dans la doc
  de `TriGen`).
- `TriGen_MajSel` : supprimer `Dim Res` et `Val = ""` ; `Filter_Calc` : supprimer la branche
  inatteignable.

### Commonalisation avec d'autres fichiers

- **Sélection multiple sur `TriGen`** (`Selected`, bascule dans `TriGen_MajSel`, `TriGen_Data`,
  `TriGen_Raz`, `SelectAllFil`/`DeSelectAllFil` via `GetAllFiltered`) : même code dans
  [`GedR`](../../Utils/GedR.class/architecture.md) et [`Pointage`](../../Compta/Pointage.class/architecture.md)
  → classe d'aide `TriSelection` ou méthodes de `TriGen` (POINTAGE-005, GEDR-008). Mesure : faible
  similarité textuelle globale (ratio ≤ 0,10 avec les autres `Tri*` du lot) car le reste de l'écran
  est délégué à `TriGen`.
- **Retour de sélection** (`LTrans` ou `Bsel`/`Bval`) : même protocole que `TriGen.Close` ; une
  aide `RenvoyerSelection(Obj, Liste)` servirait aux deux.
- **Totaux de BL** : `Caisse.Button30_click` (`Caisse.class:7166`) construit aussi `numbl in (…)` par
  `Join` ; une aide `Utils.SqlIn` (proposée au lot Compta) serait commune.

### Réduction de portée

- `Update_Req`, `Filter_Calc`, `Total_Calc` → `Private` (vérifié : aucun usage externe ; `TriGen`
  n'appelle aucune méthode de son parent par nom, seulement `SetProperty` sur `Bsel`/`Bval`).
- `Bsel`, `Bval` et l'énumération restent `Public`.

### Séparation traitement / GUI

- `FiltreDocuments(iType, sClient, sTicket) As String` pure (testable en gb.test) ; `Filter_Calc`
  ne fait plus que `tr.ExtraSel`.
- `TotauxSelection(aNumeros) As Float[]` (requête) ; `Total_Calc` n'affiche que le résultat.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Le rattachement d'un BL à un ticket se fait par `Fiches_Bl.numtick` (une seule valeur) : une table
  de liaison ticket ↔ documents permettrait plusieurs règlements partiels.
- `type` sur un caractère et `acquitte` nullable : une contrainte `NOT NULL DEFAULT 0` simplifierait
  `acquitte = 0 or acquitte is null`.
