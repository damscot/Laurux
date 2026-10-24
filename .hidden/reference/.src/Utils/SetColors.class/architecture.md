# SetColors — Architecture

> Source : `.src/Utils/SetColors.class` · Formulaire : `.src/Utils/SetColors.form`

## Vue d'ensemble

`SetColors` est l'écran de **paramétrage des couleurs** de l'interface, ouvert par
`Fmenu.class:1527` (`SetColors.ShowDialog`). Une barre de 6 `ToolButton` affiche l'un des
panneaux (`Panel2`-`5`, `Panel8`, `Panel9`). Chaque panneau contient des `TextBox` d'aperçu du
groupe d'événements `Coul`, dont le `Tag` est la clé de configuration (`/Coul/Stk`, `/Coul/Facts`,
`/Coul/Znss`, `/Coul/Coulfond`…). Un double-clic ouvre [`FSetFormat`](../FSetFormat.class/architecture.md)
sur le [`CFormat`](../CFormat.class/architecture.md) lu dans `Start.LocalSettings[Tag]`, puis
enregistre le résultat. Deux boutons rétablissent des valeurs par défaut.

Nature : **GUI** ; le seul « traitement » est l'écriture dans `Laurux.conf`
(`Start.LocalSettings`), aucun accès à la base.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `ToolButton1_Click` | 3-7 | Public | 2 | 3 | 0 | handler GUI |
| `ToolButton2_Click` | 9-13 | Public | 2 | 3 | 0 | handler GUI |
| `ToolButton3_Click` | 15-19 | Public | 2 | 3 | 0 | handler GUI |
| `ToolButton4_Click` | 21-25 | Public | 2 | 3 | 0 | handler GUI |
| `ToolButton5_Click` | 27-31 | Public | 2 | 3 | 0 | handler GUI |
| `ToolButton6_Click` | 33-37 | Public | 2 | 3 | 0 | handler GUI |
| `Coul_DblClick` | 39-66 | Public | 9 | 25 | 0 | handler GUI |
| `InitTxtB` | 68-86 | Private | 8 | 16 | 0 |  |
| `Form_Open` | 88-95 | Public | 1 | 6 | 0 | handler GUI |
| `Button1_Click` | 97-101 | Public | 1 | 3 | 0 | handler GUI |
| `Button2_Click` | 103-116 | Public | 1 | 12 | 0 | handler GUI |
| `Button3_Click` | 118-127 | Public | 1 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`ToolButton1_Click` … `ToolButton6_Click`** [handlers] [GUI]. Si le bouton est enfoncé,
  remonte respectivement `Panel2`, `Panel3`, `Panel4`, `Panel5`, `Panel8`, `Panel9`.
- **`Coul_DblClick()`** [handler du **groupe** `Coul` des `TextBox` du `.form` ; portée :
  nécessaire] [nature : mixte, CC 9]. Lit `CFormat[Start.LocalSettings[Tag]]`, le passe à
  `FSetFormat` (`Format` puis `Run`), applique le résultat à la zone (fond/texte avec repli
  `Color.TextBackground`/`TextForeground`, alignement avec repli `Align.Left`, police), écrit
  `Start.LocalSettings[Tag] = hFormat.ToString()`. Pour `/Coul/Other` et `/Coul/Coulfond`, écrit
  aussi la décomposition RVB `"R;V;B;"` du fond dans `/Coul/Others` ou `/Coul/Coulfonds` (lues par
  `Start.Coul` pour les couleurs de thème `Start.R/G/B`). Termine par `Start.LocalSettings.Save`.
- **`InitTxtB(hCont)`** [privé] [GUI, récursif]. Pour chaque `TextBox` descendante dont le `Tag`
  commence par `/`, applique le `CFormat` stocké (mêmes replis que ci-dessus).
- **`Form_Open()`** [handler] [GUI]. `Utils.Observers(Me)`, affiche `Panel1`, enfonce
  `ToolButton1`, initialise toutes les zones (`InitTxtB(Me)`).
- **`Button1_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [mixte]. Valeurs par défaut des fenêtres, boutons, zones de
  saisie/affichage et focus : fond des 5 zones + 5 clés `/Coul/Fnets`, `/Btns`, `/Znss`, `/Znaff`,
  `/Focus` au format `"Background: &H…&"`. Pas de `Save` explicite.
- **`Button3_Click()`** [handler] [mixte]. Valeurs par défaut des fonds de documents :
  `/Coul/Coulfond` et `/Coul/Other` au format `"Background: <décimal>"`, `/Coul/Coulfonds` =
  `"255;254;212;"`, `/Coul/Others` = `"229;233;255;"`. ⚠️ Les triplets RVB ne correspondent pas
  aux couleurs d'aperçu (`&FFEE81&` = 255;238;129 et `&FFE0B8&` = 255;224;184), mais aux replis de
  `Start.Coul` (à confirmer avec l'utilisateur). Pas de `Save` explicite.

## Événements gérés

`Form_Open`, `Button1`-`3_Click`, `ToolButton1`-`6_Click`, `Coul_DblClick` (groupe `Coul`) : noms
intouchables.

## État global utilisé

- `Start.LocalSettings` (`/Coul/*`, écriture et `Save`).
- `FSetFormat.Format` (statique partagé) et `FSetFormat.Run`.
- `Utils.Observers`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Coul_DblClick` : extraire la décomposition RVB dans une fonction pure `RVBTexte(couleur) As String`
  (`"R;V;B;"`) et la correspondance `Tag → clé RVB` (`/Coul/Other` → `/Coul/Others`,
  `/Coul/Coulfond` → `/Coul/Coulfonds`) dans une petite table.
- `Button2_Click` / `Button3_Click` : table `[contrôle, clé, valeur]` parcourue en boucle.

### Commonalisation avec d'autres fichiers

- Application d'un `CFormat` à un contrôle (`Coul_DblClick:51-55`, `InitTxtB:78-81`) → méthode
  `CFormat.Applique` (voir [CFormat](../CFormat.class/architecture.md), CFORMAT-004), partagée avec
  `FSetFormat` et `Attrib`.
- Valeurs par défaut des couleurs : les mêmes chaînes sont écrites en dur dans `Start.module`
  (lignes 132-149), `Fmenu.class` (lignes 437-450) et ici ; des constantes communes (par exemple
  dans `Start`) supprimeraient la triple saisie. Attention : les formats diffèrent légèrement
  (`"…&; "` avec espace final dans `Start`/`Fmenu`, sans dans `SetColors`, et `"255,252,216,"` avec
  virgules dans `Fmenu`) ; la commonalisation doit conserver chaque chaîne telle quelle ou être
  traitée comme anomalie.
- Décomposition RVB : même calcul (mort) dans [`FSetFormat.ColorButton1_Change`](../FSetFormat.class/architecture.md).

### Réduction de portée

- `deps.py` propose `Coul_DblClick` : **faux positif**, c'est le handler du groupe `Coul` du
  `.form` (21 `TextBox`) ; il doit rester `Public` avec ce nom.

### Séparation traitement / GUI

- `RVBTexte` (pure) et une fonction `EnregistreFormat(tag, hFormat)` (écriture `LocalSettings`) ;
  les handlers gardent la partie contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base. La configuration est locale au poste (`Laurux.conf`) ; un
  stockage par société dans le blob `conf` de `Fiches_Parametres` permettrait de la partager.
