# FRelance — Architecture

> Source : `.src/Compta/Relances/FRelance.class`

## Vue d'ensemble

`FRelance` est l'écran de **saisie des textes de relance** (menu Comptabilité › Relances › Saisie
des textes, `Fmenu.Menu27_Click`). Chaque niveau de relance (`niveau`, entier, clé primaire) porte
deux textes : `libell1` (texte d'introduction, imprimé avant le détail) et `libell2` (texte de
conclusion). Ces textes sont lus par [`FEditrel`](../FEditrel.class/architecture.md)
(`Impressionr`) et [`Ligcli`](../Ligcli.class/architecture.md) (`Buttonedit_Click`) lors de
l'édition des lettres, et par `Ligcli._new` pour remplir la liste des lettres disponibles.

Contrôles : `Niveau` (ComboBox éditable), `Rel1`/`Rel2` (TextArea), `Button2` (Enregistrer),
`Button1` (Supprimer), `Button4` (Aide), `Button6` (Fermer).

Nature globale : **GUI** avec SQL direct dans les handlers. Table unique `Fiches_Txt_Relances`
(en dur, aucune clé `Cbase` n'existe pour cette table).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-37 | Public | 1 | 5 | 0 | méthode spéciale |
| `Form_Open` | 39-57 | Public | 4 | 16 | 0 | handler GUI |
| `Button6_Click` | 59-63 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 65-81 | Public | 3 | 13 | 0 | handler GUI |
| `niveau_Click` | 83-98 | Public | 2 | 13 | 0 | handler GUI |
| `niveau_GotFocus` | 100-104 | Public | 1 | 3 | 0 | handler GUI |
| `niveau_LostFocus` | 106-110 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 112-128 | Public | 4 | 14 | 0 | handler GUI |
| `Button4_Click` | 130-134 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [spéciale] [GUI]. `Utils.Observers(Me)` (journalisation replay), chargement du son,
  centrage.
- **`Form_Open()`** [handler] [mixte]. `SELECT * FROM Fiches_Txt_Relances order by niveau` ; remplit
  `niveau` puis affiche le premier niveau (`MoveFirst`). Bloc `Catch` vide : toute erreur est
  ignorée silencieusement.
- **`Button2_Click()`** [handler] [mixte]. « Enregistrer » : si `niveau.Text` est vide, rien. Sinon
  `SELECT` du niveau ; s'il existe → `UPdate … SET libell1 = &2, libell2 = &3 WHERE niveau = &1`,
  sinon `INSERT` et ajout du niveau dans la liste. Un niveau non numérique est passé tel quel à une
  colonne `int(11)` (erreur SQL MySQL strict ou conversion en 0, à confirmer).
- **`niveau_Click()`** [handler] [mixte]. Relit les deux textes du niveau choisi, ou vide les
  zones si le niveau n'existe pas.
- **`niveau_GotFocus()` / `niveau_LostFocus()`** [handler] [GUI]. Couleur de fond en dur
  `&HAAFF7F&` puis `Color.TextBackground` (les autres écrans utilisent `Utils.SetEditColor`).
- **`Button1_Click()`** [handler] [mixte]. « Supprimer » : joue le son, pose la question **avant**
  de tester `niveau.Text` (`Message.Question(…) = 1 And niveau.Text`), puis
  `DELETE FROM Fiches_Txt_Relances WHERE niveau = &1` et retrait de la liste. Les zones sont vidées
  **dans tous les cas**, y compris si l'utilisateur répond « Non » (voir FRELANCE-A01).
- **`Button4_Click()`** [handler] [GUI]. `Doc.Open("Txtrelances")`.
- **`Button6_Click()`** [handler] [GUI]. Ferme.

Toutes les fonctions sont des handlers ou la méthode spéciale : [portée : nécessaire].

## État global utilisé

- `Start.Son`, `Start.Musique`, `Music` ; `Utils.Observers`, `Utils.db`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Le nom de table est répété dans 4 fonctions via une variable locale `Tab` : constante privée
  `TABLE_TXT = "Fiches_Txt_Relances"` (SQL identique).
- `Button2_Click` : le `SELECT` d'existence peut rester (pas de `REPLACE`/`UPSERT` portable
  MySQL/SQLite) ; extraire `EnregistreTexte(niveau, txt1, txt2) As Boolean` (vrai si insertion).

### Commonalisation avec d'autres fichiers

- La lecture `SELECT * FROM Fiches_Txt_Relances WHERE niveau = &1` est répétée dans
  [`FEditrel.Impressionr`](../FEditrel.class/architecture.md) et
  [`Ligcli.Buttonedit_Click`](../Ligcli.class/architecture.md) ; la liste des niveaux dans
  `Ligcli._new`. Un petit module d'accès (ex. fonctions `TexteRelance(niveau)` et
  `NiveauxRelance()` dans un futur module `Relances`) servirait aux trois fichiers.
- Couleur de focus en dur : `Utils.SetEditColor` (utilisé par `FEditrel.dteN1_GotFocus`) donne
  une couleur paramétrée (`/Coul/Focus`), différente de `&HAAFF7F&` : changement visuel, donc hors
  rework (même constat dans `FRelCompte`, `FRelFacture`, `FPrepRel2`).

### Réduction de portée

- Rien : uniquement des handlers et `_New`.

### Séparation traitement / GUI

- `ChargeNiveaux() As Integer[]`, `LitTexte(niveau) As String[]`, `EnregistreTexte(…)`,
  `SupprimeTexte(niveau)` privés, sans accès aux contrôles ; les handlers gardent l'affichage,
  le son et les questions.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Ajouter une clé `Cbase` (`TabTxtRel`) pour `Fiches_Txt_Relances` (pas un changement de schéma
  mais une évolution de `Cbase`, à traiter avec les autres tables de relance).
- Un libellé court (`titre`) par niveau permettrait d'afficher autre chose qu'un numéro dans les
  listes de `Ligcli`.
