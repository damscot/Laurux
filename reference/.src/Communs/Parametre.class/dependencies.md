# Parametre — Dépendances

> Source : `.src/Communs/Parametre.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Parametre.class` — classe, formulaire associé `Parametre.form`
- Handlers GUI détectés : 13
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Dnbon_LostFocus`, `Dnfac_LostFocus`, `Dnclient_LostFocus`, `Dnfournisseur_LostFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Dnbon_LostFocus`, `Dnfac_LostFocus`, `Dnclient_LostFocus`, `Dnfournisseur_LostFocus`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Edit`, `Exec` |
| `Doc` | `Open` |
| `DocActif` | `Free_Lock`, `Get_Lock` |
| `FComptes` | `<hérité>` |
| `FJournaux` | `<hérité>` |
| `FTvav` | `<hérité>` |
| `LDate` | `G` |
| `ObjProp` | `<type>`, `AddChamp`, `ComboBox`, `Height`, `Width` |
| `SaiTableau` | `$prop`, `<type>`, `Netoyage`, `VisibleChoi`, `VisibleEntete`, `VisibleTot`, `VisibleTuto`, `ajout`, `ind`, `ligne`, `show` |
| `Sailig` | `<type>`, `MonControle` |
| `Start` | `LocalSettings`, `Musique`, `Societe` |
| `TextReg` | `<form>`, `<type>`, `EstDate`, `EstNum`, `Name`, `Select`, `Text`, `Type`, `Value`, `dte`, `nbdec`, `reg` |
| `Utils` | `Cdate_Aff`, `Cdate_calc`, `Observers`, `Option`, `db` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Dnbon_LostFocus`, `Dnfac_LostFocus`, `Dnclient_LostFocus`, `Dnfournisseur_LostFocus`, `mcdt`, `Button2_Click`, `meserrc`, `meserrt`, `Verif_Compte`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique : `Fmenu.Menu25_Click`** (l.693/697, `Parametre.ShowModal`, après `MDP` si
  `/Soc<XX>/Admin`). Aucun appel de méthode depuis l'extérieur (grep `Parametre\.`).
- **Verrou** : `DocActif.Get_Lock("Parametres", "0")` (résultat ignoré) et `Free_Lock` ; aucun autre
  fichier ne prend ce verrou. `Prefs` écrit la même ligne (`conf`) sans verrou.
- **Configuration** : lit `/Soc<XX>/Caisse` et, via `Utils.Option()`, `/Soc<XX>/bois` et `/pp`
  (écrites par [Prefs](../Prefs.class/architecture.md)). Dépendance de **schéma** : les colonnes
  des options B/P et la table `Art_Tipp` sont créées par `modfichier` (non vu par `deps.py` comme
  lien entre ces fichiers).
- **Lecteurs des données écrites** (dépendances par la base, non détectées par `deps.py`) :
  `Fiches_Parametres.version` est lu par `LauruxMaj.Verif_Version` (migrations) ; `dnc`, `dnf`,
  `dnbon`, `dnfac`, `dnart`, `dntk`, `jrnal*`, `jrnod`, `dteclec*` sont lus par la plupart des
  écrans de gestion et de comptabilité (numérotation, clôtures). Toute modification de
  l'enregistrement se vérifie par le dump de `Fiches_Parametres`.
- **Tables en dur** non vues par `Cbase.Table` : `Fiches_Parametres`, `Fiches_Societes`,
  `Fiches_Journaux`, `Fiches_Tvaav`, `Fiches_Art`, `Art_Tipp` (bien listées par `deps.py`, sauf
  `Art_Tipp` absente de la liste des tables).
- **Groupes d'événements** : `Par`, `Btn`, `cpts`, `jrnal` (`.form`), `code` et `tab` (observateurs
  créés dans le code). `deps.py` ne signale que `code` et `tab`. Conséquence vérifiée dans le
  `.form` : `Dnclient`, `Dnfournisseur`, `Dnbon`, `Dnfac` sont dans le groupe `Par`, donc leurs
  handlers nominaux `*_LostFocus` ne sont pas déclenchés (à confirmer par replay) ; `Button2`/
  `Button3` sont dans le groupe `Btn`.
- **Faux positif `deps.py`** : `chainage` est utilisé comme type (`Dim chn As Chainage`) avec une
  casse différente du fichier `chainage.class` ; sans conséquence.
- **Ordre de rework** : après `TextReg`, `SaiTableau`/`Sailig`/`ObjProp` (API utilisées) et
  `DocActif` ; la commonalisation `Utils.CompteExiste`/`TvaExiste` est à faire avant les autres
  fichiers qui dupliquent ces requêtes.

