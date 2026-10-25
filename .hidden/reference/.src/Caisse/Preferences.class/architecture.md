# Preferences — Architecture

> Source : `.src/Caisse/Preferences.class`

## Vue d'ensemble

`Preferences` est l'écran des **préférences locales de la caisse** : il lit une trentaine de clés
`Start.LocalSettings["/Soc<XX>/caisse/…"]` dans `_new`, les présente dans des cases à cocher et
zones de saisie, et les **réécrit toutes à la fermeture** (`Form_Close`, quel que soit le bouton
utilisé), puis sauvegarde le fichier `Laurux.conf`. Il est ouvert par
`Cmenu` (`Alt+P`, bouton « Préférences », ou après saisie du mot de passe administrateur) sur son
auto-instance. Il donne aussi accès à `LauruxConf` (connexion à la base) et, si Laurux n'est pas
installé dans `/usr/bin`, à `Majversion`.

Aucun accès à la base de données. Une commande externe : `lpc status` (liste des imprimantes CUPS).

### Clés gérées et lecteurs (vérifié par `grep`)

| Clé `/Soc<XX>/caisse/…` | Contrôle | Lue par |
|---|---|---|
| `logo`, `ilogo` | `Logo`, `Logo2` | `Cfacture` |
| `admin` | `admin` | `Caisse` |
| `admin2` | `admin2` | `Cmenu` |
| `qt1`, `ctrlstk`, `recapbonus`, `recapsoldecli`, `ordre`, `lieu`, `balance`, `Tbalance`, `portb`, `choiximp`, `choiximpn`, `choiximpc`, `histocli`, `nbf`, `Tfamilles`, `affusbwn`, `ChmZ` | idem | `Caisse` |
| `choiximp2` | `ChoixImp2` | `Caisse` (mais `Impression.Facture` lit `/choiximp2` global) |
| `tactile` | `Tactile` | `Caisse`, `Ouverture`, `Tricartes`, `TriclientsD` |
| `choixtouches` | `ChoixTouches` | `Start`, `Ouverture`, `Fmenu` |
| `Font` | `FontChooser1` | `Start` |
| `Cimp`, `CmdImp` | `Cimp`, `CmdImp` | `Impression.Ticket` (mais `Impression.Facture` lit `/Cimp`, `/CmdImp` globaux) |
| `CmdVis` | `CmdVis` | `Visualiseur` |
| `TKpdf` | `TKpdf` | `Impression.Ticket` |
| `FACpdf` | `FACpdf` | **personne** (`Impression.Facture` lit `/FACpdf` global) |
| `son` | `son` | **personne** (`Start.son` lit `/son`) |
| `tircarte` | `Tircarte` | **personne** |
| `intitule` | aucun contrôle | `Cmenu` (lu puis jamais utilisé) — simple aller-retour |

Nature globale : **GUI** (paramétrage), sans calcul.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Fontes` | var | Private |  | String | 3 |
| `chkNbase` | var | Private |  | Boolean | 4 |
| `Lig` | var | Private |  | String | 5 |
| `Intitule` | var | Private |  | String | 6 |
| `cs` | var | Private |  | String | 7 |
| `cv` | var | Private |  | String | 8 |
| `hImage` | var | Private |  | Image | 9 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 11-74 | Public | 41 | 61 | 0 | méthode spéciale |
| `SetObservers` | 76-88 | Public | 4 | 10 | 0 | portée réductible ? |
| `Obs_Enter` | 90-96 | Public | 1 | 4 | 0 | handler GUI |
| `Obs_Leave` | 98-104 | Public | 1 | 4 | 0 | handler GUI |
| `Button1_Click` | 106-110 | Public | 1 | 3 | 0 | handler GUI |
| `Logo_Click` | 112-120 | Public | 2 | 7 | 0 | handler GUI |
| `Lgo2_Click` | 122-133 | Public | 3 | 10 | 0 | handler GUI |
| `FileFilter` | 135-145 | Private | 1 | 8 | 0 |  |
| `aff_logo` | 147-156 | Public | 2 | 8 | 0 | portée réductible ? |
| `dwgImage_Draw` | 158-162 | Public | 2 | 3 | 0 | handler GUI |
| `Form_Close` | 164-201 | Public | 1 | 36 | 0 | handler GUI |
| `Button2_Click` | 203-207 | Public | 1 | 3 | 0 | handler GUI |
| `BchmZ_Click` | 209-219 | Public | 2 | 9 | 0 | handler GUI |
| `Balance_Click` | 221-229 | Public | 2 | 7 | 0 | handler GUI |
| `Button3_Click` | 231-235 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : mixte] (CC 41, dont ~30 `Try`) :
  `Utils.Observers(Me)` ; masque `Button2` (mise à jour) si `/usr/bin/<Application.Name>` existe ;
  affiche le chemin du fichier de configuration ; `SetObservers` ; lit chaque clé dans son contrôle
  (`Try`) ; affiche le logo (`aff_logo`) si `logo` ; `TypeB` lu deux fois (lignes 38 et 41) ;
  `Nbf` vaut `"1"` par défaut ; police : `Fontes` n'étant jamais affecté, la branche
  `FontChooser1.SelectedFont = Fontes` est morte (lecture de `caisse/Font`, défaut `Serif,9`) ;
  imprimantes par `Shell "lpc status 2>&1"` (lignes se terminant par `:`), identique à
  `Facturergbl._new`.
- **`SetObservers` / `Obs_Enter` / `Obs_Leave`** [portée : réductible / nécessaire (handlers
  d'`Observer`)] [nature : GUI] : survol des boutons (copie de [`Cmenu`](../Cmenu.class/architecture.md)).
- **`Button1_Click()`** (« Fermer ») [handler] : `Me.Close` → `Form_Close` enregistre tout.
- **`Logo_Click()`** [handler] : affiche/masque le panneau du logo.
- **`Lgo2_Click()`** [handler] [nature : GUI] : dialogue de choix d'image (`FileFilter`), puis
  `aff_logo`. `Catch` → `Message.Warning(Error.Text)`.
- **`FileFilter(Optional All)`** [`Private`] [nature : calcul] : filtres PNG/JPEG ; le paramètre
  `All` est inutilisé. Fonction homonyme dans 8 autres classes (`Prefs`, `FClient`, `Articles`…).
- **`aff_logo()`** [portée : réductible] [nature : GUI] : charge l'image et la dessine dans
  `dwgImage` (`Draw.Begin` hors événement `Draw`, erreurs ignorées par `Catch` vide).
- **`dwgImage_Draw()`** [handler] : redessine l'image.
- **`Form_Close()`** [handler] [nature : mixte] : écrit les 33 clés puis
  `Start.LocalSettings.Save`. Aucune annulation possible : toute fermeture (y compris par la
  croix) enregistre.
- **`Button2_Click()`** [handler] : `Majversion.Show()` (auto-instance).
- **`BchmZ_Click()`** [handler] : choix du répertoire des tickets Z ; **annulation → `ChmZ =
  User.Home`** (la valeur précédente est perdue) (PREFERENCES-A03).
- **`Balance_Click()`** [handler] : affiche/masque `TypeB`.
- **`Button3_Click()`** [handler] : `LauruxConf.ShowModal()`.

## État global utilisé

- `Start.LocalSettings` (lecture et écriture, `Save`), `Start.Societe`.
- `Utils.Observers`, auto-instances `LauruxConf`, `Majversion`.
- Fichier `/usr/bin/<Application.Name>` (test d'installation), commande `lpc`.
- Membres inutilisés : `Fontes` (jamais affecté), `chkNbase`, `Lig`, `cs`, `cv`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Table des préférences (clé, contrôle, propriété `Value`/`Text`) parcourue par `_new` et
  `Form_Close` (lecture `Try Object.SetProperty`, écriture dans le **même ordre** qu'aujourd'hui) :
  CC 41 → ≤ 5, et une seule liste de clés à maintenir.
- Supprimer les membres morts, la double lecture de `TypeB`, la branche `Fontes`.

### Commonalisation avec d'autres fichiers

- Liste des imprimantes par `lpc status` : identique à
  [`Facturergbl`](../../Gestion/Facturation/Facturergbl.class/architecture.md) → helper
  `Impression.ListeImprimantes()` (à rapprocher de `ChxImp`, qui utilise `lpstat`).
- `FileFilter` : 9 copies (`Prefs`, `FSetFormat`, `ValidBR`, `FFournisseur`, `Articles`,
  `FClient`, `Saisecrit`, `Tresor`) → `Utils.FiltreImages()`.
- Clés d'impression : à aligner avec [`Impression`](../../Utils/Impression.module/architecture.md)
  (IMPRESSION-A01/A02) — correction dans le même commit (anomalie PREFERENCES-A01).
- Survol des boutons : `SurvolBoutons` (CMENU-008).

### Réduction de portée

`SetObservers`, `aff_logo` → `Private` (aucun appelant externe, vérifié par `grep`).

### Séparation traitement / GUI

`ChargePreferences() As Collection` / `EnregistrePreferences(cPrefs)` (accès à
`Start.LocalSettings` sans contrôles) et `ListeImprimantes() As String[]`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune table concernée. Les préférences de caisse étant locales au poste, leur éventuel
  stockage par caisse dans `Fiches_Caisses` (imprimante, commande) éviterait les doublons entre
  `Laurux.conf` et la table des caisses (`imp`, `typeimp`).
