# Centrales — Architecture

> Source : `.src/Gestion/Tables/Centrales.class`

## Vue d'ensemble

Écran de la **table des centrales d'achat** (`Fiches_Centrales` : `code` char(2) clé primaire,
`libelle` varchar(25)), ouvert par `Fmenu.Menu*` (`Centrales.Show()`, `Fmenu.class:2020`). Les
centrales sont proposées dans les fiches articles (`Articles`) et fournisseurs (`FFournisseur`) et
reprises par `TriArticles`, `Stockmvt`, `Impart`, `MajFbtarif1` et `Histocliart`.

L'écran suit le squelette **« table code/libellé à observateurs »** partagé à l'identique (ratio de
similarité 0,87 à 0,94 sur les lignes de code) avec [Identite](../Identite.class/architecture.md),
[Statut](../Statut.class/architecture.md) et [Typec](../Typec.class/architecture.md) :
- une `ColumnView` `Coltype` (code, libellé) remplie à l'ouverture ;
- deux zones `Cdtype` (code, 2 caractères) et `Libeltype` (25 caractères) ;
- des observateurs `OBS` posés par `SetObservers` sur chaque `TextBox` pour colorer le focus ;
- quatre boutons non groupés : `Button1` (aide, inactive), `Button2` (supprimer),
  `Button3` (enregistrer), `Button4` (quitter).

Centrales est la seule des quatre à utiliser `Cbase.Table("TabCentrales")` partout et à lire
`Start.son` directement (les trois autres déclarent `son As Integer = Start.Son`).

Nature : **GUI** avec SQL dans les handlers. Aucune fonction n'est appelée hors du fichier.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$bForceKey` | var | Private |  | Boolean | 27 |
| `CoulZns` | var | Private |  | Integer | 28 |
| `CoulFoc` | var | Private |  | Integer | 29 |
<!-- /AUTO:declarations -->

Remarque : `CoulZns` et `CoulFoc` (lignes 28-29, déclarées sans mot-clé, donc `Private`) ne
figurent pas dans le tableau généré (limite du parseur pour les déclarations sans `Private`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 31-56 | Public | 1 | 20 | 0 | méthode spéciale |
| `Form_Open` | 58-71 | Public | 3 | 11 | 0 | handler GUI |
| `Coltype_Click` | 73-77 | Public | 1 | 3 | 0 | handler GUI |
| `Refresh` | 79-86 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj_Zones` | 88-94 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button2_Click` | 96-108 | Public | 4 | 11 | 0 | handler GUI |
| `Button3_Click` | 110-129 | Public | 3 | 17 | 0 | handler GUI |
| `Button3_KeyPress` | 131-135 | Public | 1 | 3 | 0 | handler GUI |
| `OBS_GotFocus` | 137-147 | Public | 6 | 9 | 0 | handler GUI |
| `OBS_LostFocus` | 149-157 | Public | 4 | 7 | 0 | handler GUI |
| `IsValidKey` | 159-164 | Public | 6 | 4 | 0 | portée réductible ? |
| `SetObservers` | 166-178 | Public | 4 | 10 | 0 | portée réductible ? |
| `Cdtype_LostFocus` | 180-184 | Public | 2 | 3 | 0 | handler GUI |
| `Cdtype_KeyPress` | 186-193 | Public | 2 | 6 | 0 | handler GUI |
| `Quitte_Cdtype` | 195-197 | Public | 1 | 2 | 0 | portée réductible ? |
| `Libeltype_LostFocus` | 199-203 | Public | 2 | 3 | 0 | handler GUI |
| `Libeltype_KeyPress` | 205-211 | Public | 2 | 5 | 0 | handler GUI |
| `Quitte_Libeltype` | 213-215 | Public | 1 | 2 | 0 | portée réductible ? |
| `Button4_Click` | 217-221 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 226-229 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et affichage

- **`_New()`** [portée : nécessaire] [nature : GUI] : lit les couleurs `/Coul/Focus` et `/Coul/Znss`
  (`Utils.FColr`), `Utils.Observers(Me)`, `Music.Load`, centre la fenêtre, pose les observateurs
  `OBS` (`SetObservers(Me, Me)`) et dimensionne les deux colonnes.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM <TabCentrales>` (sans `ORDER BY`)
  et remplissage de `Coltype` (clé = code). Partie extractible : la requête.
- **`Coltype_Click()`** [handler] [nature : GUI] : `Maj_Zones`. Appelé aussi par le rejeu
  (`ReplayObserver.Replay_Click`, `replay_dynamic`) : **doit rester `Public`**.
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide la liste et les deux zones, rappelle
  `Form_Open`.
- **`Maj_Zones()`** [portée : réductible] [nature : GUI] : recopie la ligne courante dans les zones.

### Enregistrement et suppression

- **`Button2_Click()`** [handler] [nature : mixte] — suppression : si `Cdtype` n'est pas vide,
  son (`Start.son`), confirmation, puis `DELETE FROM <TabCentrales> WHERE code = &1` avec
  **`Coltype.Current[0]`** (ligne 103) et non le code saisi. Sans ligne sélectionnée, `Current`
  vaut `Null` et l'accès lève une erreur ; avec une sélection différente du code saisi, c'est la
  ligne sélectionnée qui est supprimée (anomalie A02). Aucun contrôle d'usage (articles,
  fournisseurs).
- **`Button3_Click()`** [handler] [nature : mixte] — enregistrement : `SELECT … WHERE code = '<code>'`
  **par concaténation** (ligne 116, anomalie A01), puis `UPdate … SET code = &1, libelle = &2
  WHERE code = &1` (réécriture inutile de la clé) ou `INSERT (code, libelle)`. Le bloc
  `With utils … End With` est sans effet. Rafraîchit la liste.
- **`Button3_KeyPress()`** [handler] [nature : GUI] : **toute** touche pressée sur le bouton
  Enregistrer (y compris Tab, flèches) déclenche `Button3_Click`.
- **`Button4_Click()`** [handler] : ferme la fenêtre.
- **`Button1_Click()`** [handler] : vide (l'appel `Doc.Open("Centrales")` est commenté). F1
  (`IsValidKey`) l'appelle donc sans effet.

### Saisie et focus

- **`OBS_GotFocus()` / `OBS_LostFocus()`** [handlers du groupe d'observateurs `OBS`] [nature : GUI] :
  si `/Soc<XX>/Coul_fen` est actif, fond `CoulFoc`/`CoulZns`, sinon vert `&HAAFF7F&` /
  `Color.TextBackground` ; `GotFocus` sélectionne le texte. Même logique que
  `Utils.ObsGotf`/`ObsLstf`, mais avec un repli de couleur différent.
- **`IsValidKey()`** [portée : réductible] [nature : GUI] : F1 → `Button1_Click` ; renvoie vrai
  pour Entrée, Retour, Tab, BackTab ou `$bForceKey` (jamais affecté, toujours `False` : code mort).
- **`SetObservers(hClass, hCont)`** [portée : réductible] [nature : GUI] : parcours récursif des
  conteneurs, un `Observer` `OBS` par `TextBox` ; `hClass` est inutilisé.
- **`Cdtype_KeyPress()` / `Libeltype_KeyPress()`** [handlers] : navigation Cdtype → Libeltype →
  Button3 sur touche de validation.
- **`Cdtype_LostFocus()` / `Libeltype_LostFocus()`** [handlers] : appellent `Quitte_Cdtype` /
  `Quitte_Libeltype` si le texte n'est pas `Null`.
- **`Quitte_Cdtype()` / `Quitte_Libeltype()`** [portée : réductible] : **vides** (code mort ;
  dans [Identite](../Identite.class/architecture.md), `Quitte_Cdtype` relit le libellé).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.FColr`, `Cbase.Table("TabCentrales")`.
- `Start.LocalSettings["/Coul/Focus"]`, `["/Coul/Znss"]`, `["/Soc<XX>/Coul_fen"]`, `Start.Societe`,
  `Start.son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `$bForceKey`, les deux `Quitte_*` vides et leur appel, le `With utils` inutile.
- `UPdate … SET libelle = &2 WHERE code = &1` (la clé n'a pas à être réécrite) : SQL modifié,
  dump identique.

### Commonalisation avec d'autres fichiers

- **Socle « table code/libellé »** commun à Centrales, [Identite](../Identite.class/architecture.md),
  [Statut](../Statut.class/architecture.md) et [Typec](../Typec.class/architecture.md) : environ
  130 lignes de code identiques sur 135-156 par fichier, soit ~390 lignes dupliquées. Proposition :
  un module `TableCode` (nom à arrêter en phase 3) avec `Charger(hCol, sTable, sOrdre)`,
  `Existe(sTable, sCode)`, `Enregistrer(sTable, sCode, sLib)`, `Supprimer(sTable, sCode)` et les
  deux traitements de couleur des observateurs `OBS`. Les handlers restent dans chaque formulaire
  (noms et formulaires intouchables) et se réduisent à un appel.
- Le même socle couvrirait les écrans du lot Compta [FPostes](../../../Compta/Tables/FPostes.class/architecture.md),
  [FCollectif](../../../Compta/Tables/FCollectif.class/architecture.md) et
  [FLibelle](../../../Compta/Tables/FLibelle.class/architecture.md), ainsi que
  [Comment](../Comment.class/architecture.md)/[ComMail](../ComMail.class/architecture.md) (même
  logique SQL, formulaires différents).
- `OBS_GotFocus`/`OBS_LostFocus`/`SetObservers` : copies conformes dans les quatre fichiers ; à
  placer dans le socle (comportement identique, y compris le repli vert `&HAAFF7F&`).

### Réduction de portée

`Refresh`, `Maj_Zones`, `IsValidKey`, `SetObservers`, `Quitte_Cdtype`, `Quitte_Libeltype` →
`Private` (aucun appelant externe, vérifié par `grep`). Les handlers (`Coltype_Click`, `Button*_Click`,
`OBS_*`, `*_KeyPress`, `*_LostFocus`) restent `Public`.

### Séparation traitement / GUI

`EnregistreCentrale(sCode, sLib)` et `SupprimeCentrale(sCode)` sans accès aux contrôles, appelées
par `Button3_Click`/`Button2_Click` (ou fonctions du socle commun).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère des articles/fournisseurs vers `Fiches_Centrales.code` (suppression contrôlée).
- Une table unique `Fiches_Codes(type, code, libelle)` regroupant centrales, statuts, types clients
  et formes juridiques rendrait le socle commun trivial.
