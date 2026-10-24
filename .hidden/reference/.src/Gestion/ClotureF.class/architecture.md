# ClotureF — Architecture

> Source : `.src/Gestion/ClotureF.class` · Formulaire : `.src/Gestion/ClotureF.form`

## Vue d'ensemble

`ClotureF` est l'écran de **clôture mensuelle de la facturation** (gestion commerciale). Ouvert en
modal par `Fmenu.Menu147_Click` (après contrôle du tunnel de réplication) et par
`Fmenu.lblClm_MouseDown` (raccourci du tableau de bord, **sans** ce contrôle), il :

1. affiche la période précédente (`Fiches_Parametres.dtepp`) et la période à clôturer
   (`Fiches_Parametres.dtepec`, format `mm.yyyy`) ;
2. après confirmation, **archive** toutes les factures imprimées (`imp = 1`, `type = 'F'`) de
   `Fiches_Bl` et `Fiches_BlM` dont la date de facture est antérieure à la fin du mois clôturé :
   pour chacune, `ObjFacB(numbl, ObjFac.facture)` → `calcul` → `transblfac` (copie dans
   `Fiches_HistoFac[M]`/`Fiches_HistoLigfac[M]`, puis suppression du BL) ;
3. avance la période : `dtepp = dtepec`, `dtepec = dtepec + 1 mois` ;
4. **recalcule le solde de tous les comptes** de `Fiches_Comptes` à partir des écritures validées
   de `Fiches_Mvt` (même algorithme que `Csolde.Solde_caisse`).

Aucune transaction n'encadre le traitement ; la période est avancée même si des factures n'ont pas
été transférées (`transblfac` affiche un avertissement et passe à la suivante quand la facture
existe déjà en archive).

Nature globale : **mixte** ; toute la logique est dans les handlers et deux procédures `Public`
qui manipulent aussi les contrôles et la fenêtre (`ProgBar`, `Message`, `Me.Close`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `Dtpc` | var | Private |  | LDate | 29 |
| `Dtepp` | var | Private |  | LDate | 30 |
| `Entbonl` | var | Private |  | Result | 31 |
| `Remmo` | var | Private |  | String | 32 |
| `Remart` | var | Private |  | String | 33 |
| `TotSldHP` | var | Private |  | Float | 34 |
| `TotDeb` | var | Private |  | Float | 35 |
| `TotCred` | var | Private |  | Float | 36 |
| `TotSld` | var | Private |  | Float | 37 |
| `debit` | var | Private |  | Float | 38 |
| `credit` | var | Private |  | Float | 39 |
| `Compt` | var | Private |  | String | 40 |
| `Nfac` | var | Private |  | String | 41 |
| `borientation` | var | Private |  | Boolean | 42 |
| `$soption` | var | Private |  | String | 43 |
<!-- /AUTO:declarations -->

Membres déclarés sans mot-clé de portée (donc `Private`) et absents du tableau généré :
`Tab` (l. 28), `Entbonl As Result` (l. 31, curseur des factures, pourrait être local),
`Remmo`, `Remart` (l. 32-33, jamais utilisés), `TotSldHP` (l. 34, écrit l. 171, jamais lu),
`TotDeb`, `TotCred`, `TotSld`, `debit`, `credit`, `Compt` (l. 35-40, accumulateurs de
`Calc_solde`). `Nfac`, `borientation` sont inutilisés ; `$soption` est écrit (l. 50) mais jamais lu.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 45-52 | Public | 1 | 6 | 0 | méthode spéciale |
| `Form_Open` | 54-58 | Public | 1 | 3 | 0 | handler GUI |
| `Aff_date` | 60-90 | Public | 8 | 27 | 0 | portée réductible ? |
| `Button3_Click` | 92-96 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 98-111 | Public | 3 | 11 | 0 | handler GUI |
| `Maj_Archives` | 116-156 | Public | 5 | 33 | 0 | portée réductible ? |
| `Calc_solde` | 161-215 | Public | 7 | 52 | 0 | portée réductible ? |
| `Button2_Click` | 217-220 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et affichage

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Music.Load`, centrage,
  `Utils.Observers(Me)` (journalisation/rejeu), `$soption = Utils.Option()` (inutilisé).
- **`Form_Open()`** [portée : nécessaire, handler] [nature : GUI]. Appelle `Aff_date`.
- **`Aff_date()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (nom
  en dur). Table vide : avertissement, puis `Start.UnLock`, `Utils.fermeTunnel`, `Utils.db.Close`
  et **`Quit`** de l'application (même comportement que `FCloture.Aff_date`). Sinon construit
  `Dtpc` (période à clôturer, `dtepec`) et `Dtepp` (période précédente, `dtepp`) en `LDate` du
  1er du mois ; une valeur nulle ou commençant par `00` est remplacée par `Now`. Affiche les deux
  périodes en `mmmm  yyyy` dans `Dateprc`/`datecl`. Partie extractible : lecture et conversion des
  deux dates (fonction pure renvoyant deux `LDate`).
- **`Button3_Click()`** [handler] [GUI] : ferme la fenêtre.
- **`Button2_Click()`** [handler] [GUI] : **vide** (l'appel `Doc.Open("ClotureF")` est commenté) ;
  le bouton d'aide ne fait rien.

### Traitement

- **`Button1_Click()`** [handler] [nature : mixte]. Affecte `Tab`/`Tab2` (inutiles), demande
  confirmation (`Message.Question`), appelle `Maj_Archives`, puis `Try Me.Close`.
- **`Maj_Archives()`** [portée : réductible] [nature : mixte] (l. 116-156).
  - SQL : `SELECT * FROM Fiches_Bl WHERE imp = 1 AND type = 'F' AND dtefac <= <fin du mois>
    UNION ALL SELECT * FROM Fiches_BlM WHERE imp = 1 AND type = 'F' AND dtefac < <fin du mois>`
    (l. 128, tables en dur, borne `dtpc.FinMois.D`). ⚠️ La borne diffère entre les deux tables
    (`<=` contre `<`) : une facture « entretien » (`Fiches_BlM`) datée du dernier jour du mois n'est
    pas archivée (anomalie CLOTUREF-A01).
  - Pour chaque facture : la condition l. 134 `If Right(Cdate_Aff(dtefac), 4) & Mid(…, 4, 2) Then`
    est une **chaîne** non vide, donc toujours vraie (une chaîne vide seule vaut `False`) : le
    filtre est sans effet. Puis `New ObjFacB(numbl, ObjFac.facture)`, `numcli = cdclibl`, `calcul`,
    `transblfac` (écritures dans `Fiches_HistoFac[M]`, `Fiches_HistoLigfac[M]`, `Fiches_Materiels`,
    suppression dans `Fiches_Bl[M]`/`Fiches_Ligbl[M]`, voir `ObjFacB`).
  - `ProgBar` non interruptible (2 arguments → `Stopable = False`) : le `Break` l. 141 n'est
    atteint que si `Avancement` renvoie vrai (à confirmer : fermeture de la fenêtre de progression).
  - Avance la période : `Dtepp = Dtpc`, `Dtpc + 1 mois`,
    `UPdate Fiches_Parametres SET dtepp = &1, dtepec = &2` (format `mm.yyyy`). Le
    `SELECT * FROM Fiches_Parametres` de la l. 150 (`Parmt`) est inutile.
  - Appelle `Calc_solde`.
- **`Calc_solde()`** [portée : réductible] [nature : mixte] (l. 161-215).
  Pour chaque compte (`SELECT compte_cc, intitule_cc FROM Fiches_Comptes ORDER BY
  cast(compte_cc AS char)`), lit toutes les écritures validées de `Fiches_Mvt`
  (`WHERE compte = &1 AND validee = 1 ORDER BY dte`), cumule débit − crédit et écrit
  `UPdate Fiches_Comptes SET solde = PointBase(total) WHERE compte_cc = &1`. Le corps de boucle
  est **identique** à [`Csolde.Solde_caisse`](../../Utils/Csolde.module/architecture.md) (même SQL,
  mêmes accumulateurs de module). Variables `i`, `Intit`, `p1` inutiles. Termine par `Music.Play`,
  `Message.Info("Traitement terminé")` et `Me.Close` (d'où le `Try Me.Close` de `Button1_Click`).
  Seul `Fiches_Mvt` est lu (pas `Fiches_Mvt1..5`), comme `Csolde`.

## État global utilisé

- `Utils.db` (toutes les requêtes), `Utils.Cdate_Aff`, `Utils.PointBase`, `Utils.Observers`,
  `Utils.Option`, `Utils.fermeTunnel`.
- `Start.Musique`, `Start.son`, `Start.UnLock`.
- `ObjFac.facture` (constante), classe `ObjFacB` (transfert en archive), `ProgBar`, `LDate`.
- Tables (en dur, sans `Cbase.Table`) : `Fiches_Parametres` (lecture/écriture `dtepp`, `dtepec`),
  `Fiches_Bl`, `Fiches_BlM` (lecture ; écriture via `ObjFacB`), `Fiches_Comptes` (écriture `solde`),
  `Fiches_Mvt` (lecture).

## Comparaison avec les autres clôtures (pré-conditions)

| Contrôle | ClotureF | [FCloture](../../Compta/Clotures/FCloture.class/architecture.md) | [FClotureAn](../../Compta/Clotures/FClotureAn.class/architecture.md) | [Calcstock](../../Utils/Calcstock.class/architecture.md) / `Moulinage` |
|---|---|---|---|---|
| Tunnel de réplication | dans `Fmenu.Menu147_Click` seulement (pas `lblClm_MouseDown`) | `Fmenu.Menu46_Click` | `Fmenu.Menu60_Click` | non |
| Caisses déconnectées, ticket Z tiré, moulinage fait | **non** | non | non | oui (`Calcstock.Button2_Click`) |
| Écritures / documents provisoires | non (factures non imprimées ignorées sans avertissement) | oui (écritures provisoires) | oui (périodes clôturées) | — |
| Période cohérente avec la date du jour / l'exercice | **non** (on peut clôturer un mois futur) | non | oui (`datec >= datec3`) | — |
| Table de paramètres vide | `Quit` de l'application | `Quit` | — | — |

Un helper commun de pré-contrôle (`Utils.ControlePreCloture()`, déjà proposé dans FClotureAn)
servirait aussi ici ; l'ajouter **change le comportement** (refus de clôturer) : anomalie
CLOTUREF-A04, pas un rework.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le filtre toujours vrai l. 134 (comportement identique tant que `dtefac` n'est pas
  nul, ce que garantit `dtefac <= …` dans la requête).
- Supprimer les variables et requêtes inutiles (`Remmo`, `Remart`, `Nfac`, `borientation`,
  `$soption`, `TotSldHP`, `Parmt`, `Tab2`, `i`, `Intit`, `p1`, blocs `With Utils` vides).
- Tables par `Cbase.Table("TabParam" | "TabBl" | "TabBlM" | "TabComptes" | "TabMvt")`.
- Non retenu : remplacer le recalcul (une requête par compte) par un seul
  `UPDATE … SET solde = (SELECT SUM(montantd - montantc) …)` ; l'arrondi pourrait différer de
  l'accumulation Float actuelle (dump non garanti identique).

### Commonalisation avec d'autres fichiers

- `Calc_solde` → boucle sur les comptes appelant
  [`Csolde.Solde_caisse(compte)`](../../Utils/Csolde.module/architecture.md) (même SQL à l'octet
  près) ; voir aussi la commonalisation Csolde / Recalcsolde / Calcsolde des notes transverses.
  Attention : `Csolde.Recalc_solde` lit `SELECT *` au lieu de `SELECT compte_cc, intitule_cc` et
  n'a pas de `ProgBar` : on garde la boucle locale (progression) et on délègue le corps.
- Le même calcul de solde par compte existe dans `Visreglements.Calc_solde` et
  `TresorFac.Calc_solde` (versions `Cbase.Table`) : voir
  [Visreglements](../Reglements/Visreglements.class/architecture.md).
- Lecture des dates de période de `Fiches_Parametres` : même schéma dans `FCloture.Aff_date` et
  `FClotureAn` → helper commun `LDate.Periode(mm.yyyy)` ou fonction de `Utils`.
- Contrôle du tunnel de réplication avant ouverture : dupliqué dans `Fmenu` (Menu46, Menu60,
  Menu147) et absent de `lblClm_MouseDown` (à signaler dans la doc de `Fmenu`).

### Réduction de portée

- `Aff_date`, `Maj_Archives`, `Calc_solde` : aucun appelant externe (grep) → `Private`, couverts
  par les replays CLOTUREF-T01 à T05.

### Séparation traitement / GUI

- Extraire `ArchiveFactures(dFin As LDate, PB As ProgBar)` (SQL + boucle `ObjFacB`) et
  `AvancePeriode(dtpc As LDate)` (calcul + UPDATE), sans accès aux contrôles ; `Button1_Click`
  garde la confirmation, les messages et `Me.Close`. Le calcul « période suivante » devient une
  fonction pure testable en gb.test.
- `Calc_solde` : séparer le recalcul (sans `Message`, sans `Me.Close`) de la fin de traitement
  (son, message, fermeture).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `dtepp`/`dtepec` stockés en chaîne `mm.yyyy` : un champ `DATE` (1er du mois) supprimerait les
  conversions et permettrait des comparaisons SQL directes.
- Un historique des clôtures de facturation (période, date, utilisateur, nombre de factures
  archivées) faciliterait les contrôles et le diagnostic d'une clôture interrompue.
