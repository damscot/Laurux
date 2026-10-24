# Edsdepots — Architecture

> Source : `.src/Gestion/Depots/Edsdepots.class`

## Vue d'ensemble

Écran d'**impression des mouvements de dépôts** sur une période : entrées (type `E`) puis sorties
(type `S`) de `Fiches_Sdepots`, en PDF (`Cstocks`, `~/tmp/RegulDep.pdf`, ouvert par
`Visualiseur.Prog`), avec **purge optionnelle** des mouvements de la période (case `Effmvts`, « à
faire en début d'exercice »). Ouvert par `Fmenu.class:2176` (`Edsdepots.Show()`) et par le
dispatcher `Prgm.class:76` (programme `Edsdep`).

Contrôles : `Date1`/`Date2` (groupe `Cmpt`, tags 1-2 ; période par défaut : du même jour il y a
4 ans à aujourd'hui), `DateChooser1`, boutons `Button2` (imprimer), `Button3` (quitter), et deux
boutons **sans handler** : `Button1` (aide) et `Button6` (« Quitter »).

Nature : **mixte** (requêtes + mise en page PDF dans le même handler).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `jour` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `Org` | var | Private |  | String | 32 |
<!-- /AUTO:declarations -->

Remarque : `Filename`, `jour`, `son`, `PosY`, `Org` (lignes 28-32, sans mot-clé, donc `Private`)
ne figurent pas dans le tableau généré.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-45 | Public | 1 | 10 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 50-103 | Public | 15 | 43 | 0 | handler GUI |
| `Cmpt_dblclick` | 105-130 | Public | 5 | 22 | 0 | handler GUI |
| `Cmpt_GotFocus` | 135-141 | Public | 1 | 5 | 0 | handler GUI |
| `date1_LostFocus` | 143-155 | Public | 3 | 11 | 0 | portée réductible ? |
| `date2_GotFocus` | 157-161 | Public | 1 | 3 | 0 | portée réductible ? |
| `date2_LostFocus` | 163-182 | Public | 6 | 18 | 0 | portée réductible ? |
| `Button2_Click` | 184-281 | Public | 15 | 95 | 0 | handler GUI |
| `Level1` | 284-303 | Public | 1 | 18 | 0 | portée réductible ? |
| `Level2` | 306-318 | Public | 1 | 11 | 0 | portée réductible ? |
| `Button3_Click` | 320-325 | Public | 2 | 4 | 0 | handler GUI |
| `DateChooser1_Activate` | 327-336 | Public | 2 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers`, `Music.Load`, dates par
  défaut (fin = aujourd'hui, début = même jour 4 ans plus tôt), focus.
- **`Cmpt_KeyPress()`** [handler du groupe `Cmpt`] (CC 15, max avec `Button2_Click`) : validation
  d'une date → `date1_LostFocus`/`date2_LostFocus` et passage à l'autre ; F1 sans effet (appel
  commenté) ; F2 → calendrier positionné (`X` = 232 ou 96) et cible `Org`.
- **`Cmpt_dblclick()`** [handler du groupe `Cmpt`] : même bascule du calendrier.
- **`Cmpt_GotFocus()`** [handler du groupe `Cmpt`] : `Utils.SetEditColor`.
- **`date1_LostFocus()`** [portée : réductible] : pseudo-handler (contrôle groupé, appelé par
  `Cmpt_KeyPress`) : `Utils.Cdate_calc` + `Cdate_aff`, date du jour si résultat `00.00.0:00`,
  fond `&HF9F9BD&` ; `Catch` → retour au champ.
- **`date2_GotFocus()`** [handler inactif] : fond vert ; jamais levé (`Date2` est dans le groupe
  `Cmpt`) ni appelé : **code mort** (`handlers_inactifs`, `unused`).
- **`date2_LostFocus()`** [portée : réductible] : pseudo-handler ; même normalisation, et
  avertissement si la fin précède le début (la saisie est conservée).
- **`Button2_Click()`** [handler] [nature : mixte] (CC 15) :
  1. `Shell "cd ~"` (sans effet sur le programme) ; fichier `~/tmp/RegulDep.pdf` ;
  2. `SELECT * From <TabArt> Left join <TabSdepots> on art_code = cart WHERE date >= &1 and date
     <= &2 and type = "E" order by code, date, cart` ; si des lignes existent, **création du PDF**,
     en-tête « entrées », une ligne `Level2M` par mouvement, nouvelle page à `PosY >= 280` (sans
     `BasPage`, contrairement aux sorties) ;
  3. même requête pour `type = "S"` : en-tête « sorties » appelé sur `pdf`, qui **n'existe pas**
     si aucune entrée n'a été trouvée (erreur d'objet nul, anomalie A01) ;
  4. sans aucun mouvement : message ; sinon pied, sortie du PDF et visualisation ;
  5. si `Effmvts` est cochée et confirmée : `DELETE FROM <TabSdepots> WHERE datesortie >= &1 and
     datesortie <= &2` : **la colonne `datesortie` n'existe pas** (`db_control.csv` : `date`) ; la
     requête échoue (message d'erreur SQL de `DB_Connection.Exec`), puis « Les mouvements ont été
     effacés » s'affiche quand même (anomalie A02).
  La jointure part de `Fiches_Art` : les mouvements d'un article supprimé ne sont pas imprimés, et
  le libellé de repli « Article inexistant » n'est jamais utilisé. Variables `p`, `Nbpage`
  inutilisées.
- **`Level1()`**, **`Level2(...)`** [portée : réductible] : ancienne mise en page `Draw` (en-tête et
  ligne de détail), remplacée par `Cstocks.Level1M`/`Level2M` ; **jamais appelées** (`unused`,
  code mort).
- **`Button3_Click()`** [handler] : `Try Kill "~/Regul.ps"` (le `~` n'est pas développé par `Kill` :
  sans effet) puis fermeture.
- **`DateChooser1_Activate()`** [handler] : date choisie → zone cible, calendrier masqué.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.Cdate_calc`, `Utils.Cdate_aff`,
  `Utils.Cdate_Dbase`, `Cbase.Table` (`TabArt`, `TabSdepots`) ; `Cstocks`, `Visualiseur` ;
  `Start.Son`, `Start.Musique`, `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1`, `Level2`, `date2_GotFocus`, les variables `p`/`Nbpage`, le `Shell "cd …"` et le
  `Kill` inopérant.
- Factoriser les deux boucles (entrées/sorties) en `ImprimeMouvements(pdf, sType, sTitre)` (même
  sortie, en conservant la différence `BasPage` ou en la corrigeant via A01).

### Commonalisation avec d'autres fichiers

- Normalisation des dates de période (`Cdate_calc` + `Cdate_aff` + avertissement début/fin) et
  calendrier F2/double-clic : présents dans ≈12 écrans de période (voir notes transverses) et dans
  [Fpromo](../../Tables/Fpromo.class/architecture.md), [MvtDepots](../MvtDepots.class/architecture.md),
  [Sdepots](../Sdepots.class/architecture.md).
- Boucle PDF « en-tête / lignes / saut de page à 280 » identique dans
  [ImpDepots](../ImpDepots.class/architecture.md) et les éditions de stock (`Cstocks`).

### Réduction de portée

`date1_LostFocus`, `date2_LostFocus` (pseudo-handlers) → `Private` ; `date2_GotFocus`, `Level1`,
`Level2` supprimées.

### Séparation traitement / GUI

`MouvementsDepots(sDeb, sFin, sType) As Result` et `PurgeMouvements(sDeb, sFin)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Sdepots(date, type)` pour la sélection par période.
