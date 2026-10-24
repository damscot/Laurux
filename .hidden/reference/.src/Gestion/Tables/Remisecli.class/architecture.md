# Remisecli — Architecture

> Source : `.src/Gestion/Tables/Remisecli.class`

## Vue d'ensemble

`Remisecli` gère la table des **remises par client et par famille** (`Fiches_RemCliFam`, clé
`Cbase` `RemCliFam` : `codec` client, `codef` famille, `remise` ; clé primaire
`(codec, codef)`), lue par [`TarArt`](../../../Utils/TarArt.class/architecture.md) et `Facture`.
Ouvert depuis le menu (`Fmenu:1945`, `Remisecli.ShowModal()`).

La liste `Tabcli` (`GridView` en mode virtuel) est alimentée par `Utils.Base(Tabcli, requête)`,
qui place le résultat dans la variable **globale** `Utils.rs1`, relue par `Tabcli_Data`. Au-dessus
de la grille, trois `TextBox` servent d'en-têtes interactifs (`CO` client, `FA` famille, `Rem`) :
taper dans `CO` filtre les clients par préfixe, un double-clic inverse l'ordre de tri.

Même gabarit de saisie que [`Remisec`](../Remisec.class/architecture.md) et
[`CoefTypeC`](../CoefTypeC.class/architecture.md) (zones `Cdt` client, `Cdf` famille, `Remise`
dans le groupe `rem`, listes `Colcli`/`Colfam`, contrôles `Quitte_*`).

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoulZns` | var | Private |  | Integer | 29 |
| `CoulfOC` | var | Private |  | Integer | 30 |
| `Tri` | var | Private |  | String | 31 |
| `Sel` | var | Private |  | String | 32 |
| `son` | var | Private |  | Integer | 33 |
| `sKey` | var | Private |  | String | 34 |
| `Clitable` | var | Private |  | New String[3] | 35 |
| `Dbl` | var | Private |  | String | 36 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 38-52 | Public | 1 | 11 | 0 | méthode spéciale |
| `Form_Open` | 54-62 | Public | 1 | 7 | 0 | handler GUI |
| `Deb2` | 64-72 | Public | 3 | 6 | 0 | portée réductible ? |
| `Deb3` | 74-78 | Public | 1 | 3 | 0 | portée réductible ? |
| `Tris` | 80-89 | Public | 1 | 8 | 0 | portée réductible ? |
| `Tabcli_Data` | 91-101 | Public | 3 | 9 | 0 | handler GUI |
| `Maj_Zones` | 103-114 | Public | 3 | 9 | 0 | portée réductible ? |
| `CleanChamps` | 116-124 | Public | 1 | 5 | 0 | portée réductible ? |
| `Tabcli_Select` | 126-136 | Public | 1 | 9 | 0 | handler GUI |
| `ToggleButton1_Click` | 138-168 | Public | 4 | 28 | 0 | handler GUI |
| `colcli_KeyPress` | 170-183 | Public | 5 | 12 | 0 | handler GUI |
| `Colcli_Click` | 185-194 | Public | 1 | 8 | 0 | handler GUI |
| `ToggleButton2_Click` | 196-223 | Public | 4 | 25 | 0 | handler GUI |
| `Colfam_Click` | 225-234 | Public | 1 | 8 | 0 | handler GUI |
| `Quitte_Cdt` | 236-259 | Public | 3 | 18 | 0 | portée réductible ? |
| `Quitte_Cdf` | 261-285 | Public | 3 | 19 | 0 | portée réductible ? |
| `Quitte_Remise` | 287-303 | Public | 2 | 15 | 0 | portée réductible ? |
| `Button2_Click` | 305-323 | Public | 4 | 16 | 0 | handler GUI |
| `Button3_KeyPress` | 325-329 | Public | 4 | 3 | 0 | handler GUI |
| `Button3_Click` | 331-357 | Public | 10 | 24 | 0 | handler GUI |
| `Rem_KeyPress` | 359-386 | Public | 12 | 19 | 0 | handler GUI |
| `Button4_Click` | 388-392 | Public | 1 | 3 | 0 | handler GUI |
| `entete` | 395-401 | Public | 1 | 5 | 0 | portée réductible ? |
| `Co_GotFocus` | 403-413 | Public | 1 | 9 | 0 | handler GUI |
| `Co_Dblclick` | 415-424 | Public | 1 | 8 | 0 | handler GUI |
| `Co_KeyPress` | 426-438 | Public | 4 | 11 | 0 | handler GUI |
| `Cdf_GotFocus` | 440-450 | Public | 1 | 9 | 0 | portée réductible ? |
| `Cdf_Dblclick` | 452-461 | Public | 1 | 8 | 0 | portée réductible ? |
| `Cdf_KeyPress` | 463-475 | Public | 4 | 11 | 0 | portée réductible ? |
| `Dbclk` | 477-487 | Public | 2 | 9 | 0 | portée réductible ? |
| `Ref` | 489-495 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button1_Click` | 500-504 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste et en-têtes

- **`_New()`** [portée : nécessaire (spéciale)] [GUI]. Couleurs (`CoulFoc`/`CoulZns`, jamais
  utilisées), `Utils.Observers(Me)`, musique, centrage, `entete`.
- **`Form_Open()`** [handler] [mixte]. Tri par client, `Tris`, `Deb2`, focus.
- **`Deb2()`** / **`Deb3()`** [portée : réductible] [mixte]. `Utils.Base(Tabcli, "select * from
  <RemCliFam> where <Tri> like \"<sel>%\" order by …")` : tri croissant sur `Tri` puis l'autre
  colonne (`Deb2`) ou décroissant (`Deb3`). ⚠️ `sel` (texte tapé) est **concaténé** entre
  guillemets doubles : un `"` casse la requête ; sous SQLite les guillemets doubles désignent un
  identifiant (repli en chaîne seulement si aucune colonne ne porte ce nom).
- **`Tris()`** [portée : réductible] [GUI]. Largeurs des colonnes = largeurs des en-têtes.
- **`Tabcli_Data(Row, Column)`** [handler] [GUI]. `Utils.rs1.MoveTo(Row)` puis texte de la
  colonne (`codec`, `codef`, `remise`) via `Str`.
- **`entete()`** [portée : réductible] [GUI]. Textes des en-têtes.
- **`Co_GotFocus` / `Co_Dblclick` / `Co_KeyPress`** [handlers de l'en-tête `CO`] [mixte]. Remise
  à zéro du filtre (`Ref`), tri par client, filtre par préfixe frappe par frappe (`Deb2`),
  inversion du tri (`Dbclk`).
- **`Cdf_GotFocus` / `Cdf_Dblclick` / `Cdf_KeyPress`** [handlers inactifs] : `Cdf` (zone de saisie
  de la famille) appartient au groupe `rem` ; ces trois procédures, symétriques de `Co_*` pour
  le tri par famille, ne sont **jamais levées** (aucun appel explicite). L'en-tête `FA`, auquel
  elles étaient manifestement destinées, n'a aucun handler : le tri / filtre par famille
  n'existe pas.
- **`Dbclk()`** [portée : réductible] [mixte]. Alterne `Deb3`/`Deb2` (`Dbl` en chaîne `"1"`/`""`).
- **`Ref()`** [portée : réductible] [GUI]. Tri par client, `CleanChamps`, `Tris`.

### Saisie

- **`Tabcli_Select()`** [handler] [mixte]. `CleanChamps`, `Maj_Zones`, `Quitte_Cdt`, `Quitte_Cdf`,
  `entete`, focus sur le client.
- **`Maj_Zones()`** [portée : réductible] [mixte]. `SELECT * FROM <RemCliFam> where codec = &1 and
  codef = &2` (valeurs de la ligne courante) sous `Try` ; lecture des champs sans test
  `Available`.
- **`CleanChamps()`** [portée : réductible] [GUI]. Vide famille, libellé, remise (pas le client).
- **`ToggleButton1_Click` / `colcli_KeyPress` / `Colcli_Click`** [handlers, `Colcli_Click` en
  `replay_dynamic`] [mixte]. Liste des clients (`<TabCli>`, code, nom, prénom).
- **`ToggleButton2_Click` / `Colfam_Click`** [handlers, `Colfam_Click` en `replay_dynamic`]
  [mixte]. Liste des familles (`<TabFam>`).
- **`Quitte_Cdt()`**, **`Quitte_Cdf()`**, **`Quitte_Remise()`** [portée : réductible] [mixte].
  Existence du client (`<TabCli>`) et de la famille (`<TabFam>`), validité de la remise ;
  `Balloon.Warning` + `Stop Event` ; aucune valeur de retour.
- **`Rem_KeyPress()`** [handler du groupe `rem`, aussi levé par l'en-tête `Rem`] [GUI].
  Entrée/Tab : `Quitte_*` selon le `Tag` ; F2 sur le client : liste des clients.
- **`Button3_Click()`** / **`Button3_KeyPress()`** [handlers] [mixte]. `Quitte_*` puis,
  **quel que soit leur résultat**, `UPdate` ou `INSERT` (sous `Try`, message si la clé existe) ;
  `Try Tabcli.MoveTo(skey, 0)` avec `skey` = ligne courante ou **code client** (création) ;
  `CleanChamps` ; `Form_Open`.
- **`Button2_Click()`** [handler] [mixte]. Suppression de la ligne courante de la grille
  (`codec`, `codef`) après confirmation ; `Form_Open` ; `Tabcli.MoveTo(skey, 0)` **sans `Try`**
  sur l'ancien numéro de ligne (dernière ligne supprimée : erreur probable, à confirmer).
- **`Button4_Click`** (fermer), **`Button1_Click`** (`Doc.Open("RemClientFamille")`).

## État global utilisé

- `Utils.Base` / `Utils.rs1` (résultat global partagé avec les autres écrans qui utilisent
  `Utils.Base`), `Utils.Observers`, `Utils.FColr`, `Utils.cpoint`, `Cbase.Table("RemCliFam"|
  "TabCli"|"TabFam")`, `Start.LocalSettings["/Coul/…"]`, `Start.Son`, `Start.Musique`, `Doc.Open`.
- Membres privés implicites : `Tri`, `Sel`, `sKey`, `Clitable` (recalculé à chaque appel de
  `Tabcli_Data`), `Dbl`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb2`/`Deb3` : une seule fonction `Liste(ordre)` ; `Clitable` initialisé une fois dans
  `_New`.
- `Co_*` : regrouper la remise à zéro commune (`sel = ""`, `Ref`, `entete`, texte vidé).

### Commonalisation avec d'autres fichiers

- Gabarit de saisie commun avec [`Remisec`](../Remisec.class/architecture.md) et
  [`CoefTypeC`](../CoefTypeC.class/architecture.md) (listes, `Quitte_*`, enregistrement,
  suppression), le client remplaçant le type.
- Grille virtuelle `Utils.Base` + `<Grille>_Data` + en-têtes `TextBox` de tri : patron ancien
  présent dans d'autres écrans (`Utils.Base` / `rs1`, voir
  [Utils](../../../Utils/Utils.module/architecture.md)) ; `RichDataGrid` (utilisé par `Remisec`)
  offre déjà tri et recherche.

### Réduction de portée

- `Deb2`, `Deb3`, `Tris`, `Maj_Zones`, `CleanChamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Remise`,
  `entete`, `Dbclk`, `Ref` : aucun appel externe (vérifié par `grep -rn`) → `Private`.
- `Cdf_GotFocus`, `Cdf_Dblclick`, `Cdf_KeyPress` : noms de handlers (contrôle du groupe), voir
  REMISECLI-A01 ; `Colcli_Click`, `Colfam_Click` (`replay_dynamic`) restent `Public`.

### Séparation traitement / GUI

- `EnregistreRemise(client, famille, remise)`, `SupprimeRemise(client, famille)` et
  `RequeteListe(tri, filtre, ordre) As String` (texte SQL) sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clés étrangères `codec` → `Fiches_Cli`, `codef` → `Fiches_Fam` (aujourd'hui contrôle
  applicatif non bloquant).
- Même forme que `Fiches_RemTypec` et `Fiches_CoeffTypec` : table unique typée possible.
