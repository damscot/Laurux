# Fcaisses — Architecture

> Source : `.src/Caisse/Fcaisses.class`

## Vue d'ensemble

`Fcaisses` est l'écran de **gestion de la table des caisses** (`Fiches_Caisses`), ouvert depuis
le menu Gestion (`Fmenu.Menu205_Click`, auto-instance, `ShowModal`). Il suit le gabarit des
écrans de table de l'auteur historique (2009) : une liste `Caisse` (`ColumnView`), des zones de
saisie du groupe `Cais` (code, libellé, imprimante, type, poste) et trois boutons du groupe `Btn`
(Supprimer, Enregistrer, Quitter), plus l'aide (`Button4`).

Pour chaque caisse on saisit : code, intitulé, imprimante (`DéfautA4`, `Défaut80` ou port série
`/dev/tty…`), type d'imprimante ticket (`6000III`/`Tmu950`, ports série seulement), type de caisse
(`Monoposte`/`Réseau`), poste (nom d'hôte, `System.Host` par défaut), dépôt (si
`/Soc<XX>/Depots`) et caisse école (case **invisible** dans le `.form`, donc jamais modifiable).

Contrôles métier : type « Monoposte » interdit avec un poste différent du serveur, « Réseau »
interdit avec le poste du serveur ; suppression interdite si la caisse est connectée ou si sa
bande Z n'a pas été tirée.

Nature globale : **GUI** avec SQL dans les handlers. Ne participe pas au cycle de caisse.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-43 | Public | 1 | 13 | 0 | méthode spéciale |
| `Form_Open` | 45-77 | Public | 12 | 30 | 0 | handler GUI |
| `Refresh` | 79-85 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Zones` | 87-116 | Public | 8 | 27 | 0 | portée réductible ? |
| `Cleanchamps` | 118-130 | Public | 1 | 11 | 0 | portée réductible ? |
| `Cais_GotFocus` | 135-142 | Public | 3 | 6 | 0 | handler GUI |
| `Cais_KeyPress` | 144-189 | Public | 26 | 37 | 0 | handler GUI |
| `Btn_KeyPress` | 191-200 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 202-231 | Public | 12 | 24 | 0 | handler GUI |
| `Caisse_Click` | 233-237 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 239-262 | Public | 6 | 21 | 0 | portée réductible ? |
| `Button3_Click` | 264-317 | Public | 14 | 51 | 0 | portée réductible ? |
| `Caisse_KeyPress` | 322-338 | Public | 7 | 14 | 0 | handler GUI |
| `Chkcaisse` | 340-348 | Public | 12 | 7 | 0 | portée réductible ? |
| `Cais_LostFocus` | 350-375 | Public | 12 | 20 | 0 | handler GUI |
| `Button4_Click` | 380-384 | Public | 1 | 3 | 0 | handler GUI |
| `Cais_Click` | 386-401 | Public | 3 | 14 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Affichage

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI] : `Utils.Observers(Me)`,
  `Music.Load`, centrage, deux colonnes (`code`, `Libellé`), focus sur `Code`.
- **`Form_Open()`** [handler, rappelé par `Refresh`] [nature : mixte] (CC 12) :
  `SELECT * FROM <TabCaisses>` (sans tri) ; chaque caisse est ajoutée avec la clé `code` et huit
  valeurs `Item[0..7]` (code, intitulé, imprimante, type, école, poste, type imp., dépôt) alors que
  la liste n'a que deux colonnes : les valeurs 2 à 7 servent de stockage caché relu par
  `Maj_Zones` (`Item[2]` sans `Try`, les autres avec). Si `/Soc<XX>/Depots` : remplit `Dep` par
  `select * from <TabDepots> order by code` en **excluant les codes commençant par `01`**
  (dépôt principal), format `code-libellé`.
- **`Refresh()`** [portée : réductible] : `Caisse.Clear`, `form_Open()`, `Maj_Zones()`.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : recopie l'élément courant de la liste
  dans les zones ; `Poste` vide → `System.Host` ; zone « Type imp. » visible seulement pour
  `/dev/ttyS*` (pas pour `/dev/ttyUSB*`/`/dev/ttyACM*` proposés dans la liste) ; dépôt relu par
  `select * from Fiches_Depots where code = &1` (**nom en dur**, clé `TabDepots` existante).
  `With Utils … End With` inutile.
- **`Cleanchamps()`** [portée : réductible] [nature : GUI] : vide les zones (sauf l'imprimante
  `ComboBox1`).
- **`Caisse_Click()`** [handler, `replay_dynamic`] : `Maj_Zones`. Doit rester `Public`
  (appelé par `ReplayObserver.Replay_Click` via `Object.Call`).
- **`Caisse_KeyPress()`** [handler] : Entrée/Retour/Tab → élément suivant + `Caisse_Click` ;
  Échap/F2 → **masque et vide la liste**, qui ne réapparaît qu'à la réouverture de l'écran
  (`Refresh` ne la rend pas visible) (FCAISSES-A05).

### Saisie

- **`Cais_GotFocus()`** [handler du groupe `Cais`] : `Poste` vide → `System.Host` (tag 5).
- **`Cais_KeyPress()`** [handler du groupe `Cais`] [nature : GUI] (CC 26, max du fichier) :
  tag 1 (code) → `Chkcaisse` ; Entrée/Retour/Tab → zone suivante (tags 1 à 5) ; le `Case 6`
  (vers `Button1`) ne correspond à aucun contrôle du groupe (code mort).
- **`Chkcaisse()`** [portée : réductible] [nature : GUI] : n'admet que les chiffres **1 à 9** (le
  `0` est refusé, donc aucun code « 10 ») et quelques touches d'édition ; proche de
  `Fondcaisse.ChkFDC`.
- **`Cais_LostFocus()`** [handler] : contrôle Monoposte/poste à la sortie du type (tag 4) et du
  poste (tag 5) ; `Stop Event` sans effet sur une perte de focus.
- **`Cais_Click()`** [handler] : sur l'imprimante (tag 3), affiche « Type imp. » pour
  `/dev/ttyS*` seulement.

### Boutons

- **`Btn_Click()`** [handler du groupe `Btn`] [nature : mixte] (CC 12) : tag 1 → `Button3_Click`
  (supprimer) ; tag 2 → contrôles Monoposte/Réseau puis `Button1_Click` ; tag 3 → fermeture.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : **toute touche** sur « Enregistrer » (tag 2)
  appelle directement `Button1_Click`, **sans** les contrôles Monoposte/Réseau de `Btn_Click`
  (FCAISSES-A03).
- **`Button1_Click()`** (Enregistrer) [portée : réductible — non levé par Gambas, `Button1` est
  dans le groupe `Btn`] [nature : mixte] : imprimante non série → `ComboBox3` vidé ;
  `SELECT … WHERE code = &1` puis `UPdate <TabCaisses> SET intitule, imp, type, ecole, poste,
  typeimp, depot` ou `INSERT INTO <TabCaisses> (…, fndtotp, fndtotg) VALUES (…, 0, 0)` ; dépôt
  enregistré par **`Left$(Dep.Text, 2)`** alors que `Fiches_Depots.code` est `char(8)`
  (FCAISSES-A04) ; `ecole` reçoit `Ecole.Value` (`Boolean`, stocké `-1`/`0`) ; `Refresh` +
  `Cleanchamps`. `Catch` : son + message.
- **`Button3_Click()`** (Supprimer) [portée : réductible — non levé, groupe `Btn`] [nature :
  mixte] (CC 14) : relit la caisse **`Code.Text`** ; caisse non école : refus si `connecte = 1`
  ou si `tkz = 0` (le second test `If Not rResult!ecole` est toujours vrai à cet endroit) ;
  confirmation ; puis `SELECT … FROM Fiches_EntTicketz WHERE caisse = &1` et
  `DELETE FROM <TabCaisses> WHERE code = '<Caisse.Current[0]>'` **par concaténation**, sur la
  ligne **sélectionnée dans la liste** et non sur le code contrôlé (FCAISSES-A01). La condition
  `Not rTkt.Available Or If moulinage = 1` est toujours vraie : le refus « il reste des tickets »
  est inatteignable (FCAISSES-A02). Caisse inconnue : rien ne se passe, sans message.
  Les variables `Tab2…Tab5` sont inutilisées ; le membre `Tab` ne sert qu'ici.
- **`Button4_Click()`** [handler] : aide `Table_Caisses`.

## État global utilisé

- `Start.LocalSettings["/Soc<XX>/Depots"]`, `Start.Societe`, `Start.Musique`.
- `Utils.db`, `Utils.Observers`, `System.Host`.
- Tables : `Fiches_Caisses` (`TabCaisses` : lecture, insertion, mise à jour, suppression),
  `Fiches_Depots` (`TabDepots`, et en dur dans `Maj_Zones`), `Fiches_EntTicketz` (en dur).
- Contrôle `tvalist2` (`ColumnView` invisible) : jamais utilisé par le code (`replay_missing`
  sans conséquence, la grille n'est pas cliquable).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cais_KeyPress` : table tag → contrôle suivant (CC 26 → ≤ 6 visé), suppression du `Case 6` mort.
- `Button3_Click` : supprimer le test redondant `If Not rResult!ecole` interne, sans changer le
  résultat ; le reste relève des anomalies A01/A02.
- `Form_Open`/`Maj_Zones` : stocker les champs cachés dans une `Collection` indexée par code
  plutôt que dans des colonnes fantômes (à valider : même affichage).

### Commonalisation avec d'autres fichiers

- **Liste des dépôts** : le remplissage de `Dep` (exclusion de `01`, format `code-libellé`,
  `Left$(…, 2)` à l'enregistrement) est identique dans [`Famille`](../../Gestion/Tables/Famille.class/architecture.md)
  et [`Facture`](../../Gestion/Facturation/Facture.class/architecture.md) ; avec
  `aff_Depot`/`Cman` de [`MvtDepots`](../../Gestion/Depots/MvtDepots.class/architecture.md),
  [`Sdepots`](../../Gestion/Depots/Sdepots.class/architecture.md) et
  [`ImpDepots`](../../Gestion/Depots/ImpDepots.class/architecture.md), cela forme le module
  `Depot` proposé par MVTDEPOTS-004 (`RemplitCombo(hCombo, bSaufPrincipal)`, `Libelle(sCode)`,
  `CodeDepuisLibelle(sTexte)`).
- **Écran de table code/libellé** : `Refresh`/`Maj_Zones`/`Cleanchamps`/`Btn_Click`/
  `Btn_KeyPress`/`<Liste>_KeyPress` suivent le même gabarit que [`Fvendeurs`](../Fvendeurs.class/architecture.md)
  et les écrans de tables de Gestion ([`Typec`](../../Gestion/Tables/Typec.class/architecture.md),
  [`Identite`](../../Gestion/Tables/Identite.class/architecture.md)…) : socle commun proposé
  par les lots précédents.
- **Filtre de touches** : `Chkcaisse` et [`Fondcaisse.ChkFDC`](../Fondcaisse.class/architecture.md).

### Réduction de portée

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Chkcaisse`, `Button1_Click`, `Button3_Click` → `Private`
(aucun appelant externe, vérifié par `grep` ; `Button1`/`Button3` appartiennent au groupe `Btn`,
leurs méthodes `_Click` ne sont donc pas des handlers levés par Gambas ni rejoués par
`ReplayObserver`, qui ne vise que les grilles). `Caisse_Click` reste `Public`.

### Séparation traitement / GUI

- `EnregistreCaisse(…)` (SELECT + UPDATE/INSERT) et `SupprimeCaisse(sCode)`,
  `ControleSuppression(sCode) As String` (message de refus) sans accès aux contrôles.
- `ControleTypePoste(sType, sPoste) As String` partagé par `Btn_Click` et `Cais_LostFocus`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Caisses.depot` (`char(8)`) ne reçoit que deux caractères : aligner la saisie sur la
  taille réelle, ou une clé étrangère vers `Fiches_Depots.code`.
- `ecole` est un `tinyint(4)` stockant `-1`/`0` ; `tkz`/`connecte` des `tinyint(1)` stockant
  `1`/`0` : uniformiser le codage des booléens.
- Index unique sur `Fiches_Caisses.code` (la clé primaire est `lind`).
