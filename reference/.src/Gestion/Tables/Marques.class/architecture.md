# Marques — Architecture

> Source : `.src/Gestion/Tables/Marques.class`

## Vue d'ensemble

Écran de la **table des marques** (`Fiches_Marques` : `lind` auto-incrémenté clé primaire, `code`
char(5) **non unique**, `intitule` varchar(20) ; vide dans `Laurux01.sql`). Ouvert par
`Fmenu.class:1764` (`Marques.Show()`). Les marques sont proposées dans les fiches articles
(`Articles.class:111`, `:3197`) et matériels (`Materiel.class:440`), et reprises par `EdMat`,
`Stockmvt` et `Histocliart`.

Copie du squelette « grille filtrable » de [Cpostaux](../Cpostaux.class/architecture.md)
(similarité 0,70) : grille `Colmarque` alimentée par `Utils.Base`/`Utils.rs1`, filtres d'en-tête
`CP` (code) et `BD` (intitulé), zones `Cmarque` (5 caractères) et `Imarque` (20) du groupe
`Cpost`, boutons du groupe `Btn` (1 supprimer, 2 enregistrer, 3 quitter), aide `Button4`. Les noms
de variables et de groupes (`Cpost`, `CpTable`, `ChkCp`, `Cpman`) sont ceux de Cpostaux.

Différences : pas de liste de choix multiples ; l'enregistrement est correct (`UPdate … SET
intitule = &2 WHERE code = &1`) ; `CP_GotFocus`/`BD_GotFocus` colorent l'en-tête ; `Form_Open`
appelle `Utils.Base` directement (tri `code, intitule`) sans `Colmarque.Refresh`.

Nature : **GUI** avec SQL dans les handlers ; table nommée en dur alors que
`Cbase.Table("TabMarq")` existe.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tab` | var | Private |  | String | 28 |
| `son` | var | Private |  | Integer | 29 |
| `CpTable` | var | Private |  | New String[3] | 30 |
| `Tri` | var | Private |  | String | 31 |
| `sel` | var | Private |  | String | 32 |
| `Dbl` | var | Private |  | String | 33 |
<!-- /AUTO:declarations -->

Remarque : `Tab`, `son`, `CpTable`, `Tri`, `sel`, `Dbl` (lignes 28-33, sans mot-clé, donc
`Private`) ne figurent pas dans le tableau généré.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-45 | Public | 1 | 8 | 0 | méthode spéciale |
| `cpoint` | 47-51 | Public | 1 | 3 | 0 | portée réductible ? |
| `Form_Open` | 53-62 | Public | 1 | 8 | 0 | handler GUI |
| `Colmarque_Data` | 64-74 | Public | 3 | 9 | 0 | handler GUI |
| `Tris` | 76-86 | Public | 1 | 9 | 0 | portée réductible ? |
| `Deb2` | 88-92 | Public | 1 | 3 | 0 | portée réductible ? |
| `Deb3` | 94-98 | Public | 1 | 3 | 0 | portée réductible ? |
| `Refresh` | 100-106 | Public | 1 | 5 | 0 | portée réductible ? |
| `Maj_Zones` | 108-118 | Public | 2 | 9 | 0 | portée réductible ? |
| `Cleanchamps` | 120-125 | Public | 1 | 4 | 0 | portée réductible ? |
| `Cpost_GotFocus` | 127-131 | Public | 1 | 3 | 0 | handler GUI |
| `Cpost_KeyPress` | 133-161 | Public | 8 | 24 | 0 | handler GUI |
| `Btn_KeyPress` | 163-172 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 174-189 | Public | 4 | 10 | 0 | handler GUI |
| `Cmarque_LostFocus` | 191-195 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_Click` | 197-217 | Public | 3 | 18 | 0 | portée réductible ? |
| `Button3_Click` | 219-234 | Public | 4 | 13 | 0 | portée réductible ? |
| `Cpman` | 236-247 | Public | 2 | 9 | 0 | portée réductible ? |
| `ChkCp` | 249-257 | Public | 7 | 7 | 0 | portée réductible ? |
| `CP_GotFocus` | 259-269 | Public | 1 | 9 | 0 | handler GUI |
| `CP_Dblclick` | 271-280 | Public | 1 | 8 | 0 | handler GUI |
| `CP_KeyPress` | 282-294 | Public | 4 | 11 | 0 | handler GUI |
| `BD_GotFocus` | 296-306 | Public | 1 | 9 | 0 | handler GUI |
| `BD_DblClick` | 308-317 | Public | 1 | 8 | 0 | handler GUI |
| `BD_KeyPress` | 319-331 | Public | 4 | 11 | 0 | handler GUI |
| `Ref` | 333-340 | Public | 1 | 6 | 0 | portée réductible ? |
| `Dbclk` | 342-352 | Public | 2 | 9 | 0 | portée réductible ? |
| `Colmarque_Click` | 354-361 | Public | 1 | 6 | 0 | handler GUI |
| `Button4_Click` | 363-367 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Liste filtrable

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers`, `Music.Load`, libellés
  d'en-tête, focus code.
- **`Form_Open()`** [handler] [nature : mixte] : `Tab`, `Tri = "code"`, `Tris`, puis
  `Utils.Base(Colmarque, "select … where code like \"<sel>%\" order by code, intitule")`.
- **`Colmarque_Data(Row, Column)`** [handler] : affichage depuis `Utils.rs1` (`code`, `intitule`, `lind`).
- **`Tris()`** [portée : réductible] : 4 colonnes (la 3e, `lind`, en largeur 1).
- **`Deb2()` / `Deb3()`** [portée : réductible] [nature : mixte] : `Utils.Base` avec `Tri` et `sel`
  concaténés, ordre croissant/décroissant.
- **`CP_GotFocus()`, `BD_GotFocus()`** [handlers] : `Utils.SetEditColor` sur l'en-tête, `sel`
  remis à vide, `Ref`, colonne de tri, `Deb2`.
- **`CP_Dblclick()`, `BD_DblClick()`** [handlers] : idem puis `Dbclk`.
- **`CP_KeyPress()`, `BD_KeyPress()`** [handlers] : mise à jour de `sel` et `Deb2`.
- **`Ref()`**, **`Dbclk()`**, **`Refresh()`**, **`Maj_Zones()`** (avec `Catch` muet),
  **`Cleanchamps()`** [portée : réductible] : comme Cpostaux.
- **`Colmarque_Click()`** [handler] : `CleanChamps`, `Maj_Zones`, en-têtes rétablis. Rejoué par
  `ReplayObserver` (`replay_dynamic`) : **reste `Public`**.

### Saisie et enregistrement

- **`Cpost_GotFocus()`** [handler du groupe `Cpost`] : `Utils.SetEditColor`.
- **`Cpost_KeyPress()`** [handler du groupe `Cpost`] : Entrée/Tab sur le code →
  `Cmarque_LostFocus` (recherche), focus intitulé ; sur l'intitulé → retour au code ; toute autre
  touche sur le code → `ChkCp`, qui **n'accepte que des chiffres** (contrôle hérité des codes
  postaux : un code de marque alphabétique est impossible à saisir, anomalie A02) ; F1 → aide.
- **`Cmarque_LostFocus()`** [portée : réductible] : pseudo-handler (contrôle groupé), appelle `Cpman`.
- **`Cpman()`** [portée : réductible] [nature : mixte] : `SELECT … where code = &1` ; si une seule
  ligne, l'intitulé est recopié.
- **`ChkCp()`** [portée : réductible] : filtre numérique.
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 `Button3_Click`, 2 `Button1_Click`, 3 fermeture.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : toute touche sur Enregistrer enregistre.
- **`Button1_Click()`** [portée : réductible] [nature : mixte] : `SELECT … WHERE code = &1` puis
  `UPdate … SET intitule = &2 WHERE code = &1` (toutes les lignes de ce code) ou `INSERT` ;
  pseudo-handler.
- **`Button3_Click()`** [portée : réductible] [nature : mixte] : son, confirmation,
  `DELETE … WHERE lind = &1` de la **ligne sélectionnée** ; aucun contrôle d'usage (articles,
  matériels) ; pseudo-handler.
- **`Button4_Click()`** [handler] : `Doc.Open("Marques")`.
- **`cpoint(mtt)`** [portée : réductible] : copie locale de `Utils.cpoint`, **jamais appelée**
  (`unused`, code mort).

## État global utilisé

- `Utils.db`, `Utils.Base`, **`Utils.rs1`**, `Utils.Observers`, `Utils.SetEditColor` ;
  `Start.Son`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `cpoint` ; `Cbase.Table("TabMarq")` ; `CpTable` initialisé une fois.

### Commonalisation avec d'autres fichiers

- Socle « grille filtrable » avec [Cpostaux](../Cpostaux.class/architecture.md) et
  [Depots](../../Depots/Depots.class/architecture.md) (voir Cpostaux) : 183 lignes communes avec
  Cpostaux, 169 avec Depots.
- `cpoint` : copie locale à remplacer par `Utils.cpoint` (6 copies dans le projet).

### Réduction de portée

`cpoint` (supprimée), `Tris`, `Deb2`, `Deb3`, `Refresh`, `Maj_Zones`, `Cleanchamps`,
`Cmarque_LostFocus`, `Button1_Click`, `Button3_Click`, `Cpman`, `ChkCp`, `Ref`, `Dbclk` → `Private`.

### Séparation traitement / GUI

`EnregistreMarque(sCode, sLib)`, `SupprimeMarque(iLind)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index unique sur `Fiches_Marques.code` ; référence des articles par code plutôt que par
  intitulé (à confirmer : `Articles` lit le champ `intitule`).
