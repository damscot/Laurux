# atribvignette — Architecture

> Source : `.src/Gestion/option/atribvignette.class`

## Vue d'ensemble

Écran **« Atribution des vignettes »** de l'option boissons (comptabilité matières des alcools,
régime **suspendu**) : il permet de saisir ou corriger le **numéro de vignette** (25 chiffres,
zéros à gauche) porté par les lignes de mouvements de régie `Fiches_ligregie` non encore
clôturées, et liste les numéros manquants dans la séquence. Ouvert par `menuopt.vign_click`
(`menuopt.class:81`, `atribvignette.Show`).

Les lignes `Fiches_ligregie` sont créées par la facturation boissons (`ObjFacB`, type `S`), les
réceptions (`Achat`, `fourconsdroi`, type `E`) et les mouvements exceptionnels (`Mvtex`, `S`/`E`) ;
elles sont clôturées par [Caleditcmat](../Caleditcmat.class/architecture.md). Le prochain numéro
de vignette est stocké dans `Fiches_Parametres.nvign` (géré par `ObjFacB`, pas par cet écran).

Tables : **`Fiches_ligregie`** (lecture, écriture de `vignette`), `Fiches_regie` (régime
`suspendu`), et pour le libellé du document `Fiches_Bl`, `Fiches_HistoFac`, `Fiches_Entrecpt`,
`Fiches_Four`. `Fiches_regie` et `Fiches_ligregie` sont créées à l'exécution par
[`modfichier.fichierboisson`](../modfichier.module/architecture.md) : absentes de
`db_control.csv`, de `Laurux01.sql` et de `Cbase`.

Interface : un `TreeView1` (document → lignes « B.L N° … Vignette N° … » ou « Réception B.R »),
une zone `Textvig` (nouveau numéro), une `ColumnView1` « Vignettes non attribuées » et un bouton
`Button1` « Mise à blanc » (efface la vignette de la ligne choisie).

Remarque de cohérence : malgré son nom, cette famille de fichiers (`atribvignette`, `Caleditcmat`,
`Ecomptamat`, `Einvmat`, `Visucmat`, `EditStkDepart`) concerne la **comptabilité « matières »**
(alcools, droits d'accises et cotisation sécurité sociale), **pas** le matériel suivi en
entretien : aucune des tables `*M` (`Fiches_BlM`, `Fiches_HistoFacM`, `Fiches_EntMat`,
`Fiches_HisentMat`) décrites dans [Materiel](../../Tables/Materiel.class/architecture.md) n'y
est lue ou écrite.

Nature : **mixte** (SQL et GUI entremêlés dans `affiche` et `Modif`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$ancienval` | var | Private |  | String | 3 |
| `$bmod` | var | Private |  | Boolean | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 6-13 | Public | 1 | 5 | 0 | méthode spéciale |
| `affiche` | 15-58 | Private | 12 | 42 | 0 |  |
| `manquant` | 60-80 | Private | 5 | 18 | 0 |  |
| `suspendu` | 82-89 | Private | 1 | 5 | 0 |  |
| `Modif` | 91-113 | Private | 4 | 20 | 0 |  |
| `TreeView1_Activate` | 115-127 | Public | 2 | 10 | 0 | handler GUI |
| `Textvig_LostFocus` | 129-154 | Public | 5 | 23 | 0 | handler GUI |
| `Textvig_KeyPress` | 156-163 | Public | 5 | 7 | 0 | handler GUI |
| `Button1_Click` | 166-172 | Public | 2 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (constructeur)] [nature : GUI] : titre de colonne puis `affiche`.
- **`affiche()`** [Private] [nature : mixte] (CC 12, max du fichier) : vide l'arbre ;
  `SELECT num,type FROM Fiches_ligregie WHERE cloture=False GROUP BY num,type` ; pour chaque
  document dont la régie est en régime suspendu (`suspendu(num)`), et qui n'est pas déjà dans
  l'arbre (un même `num` peut exister en type `S` et `E` : seul le premier est affiché) :
  - libellé : type `S` → `nmclibl` de `Fiches_Bl` (par `numfac`), sinon `nmclifac` de
    `Fiches_HistoFac`, sinon « mouvements exceptionnels » (par un `SELECT` constant) ; type `E` →
    `fo_nom` de `Fiches_Entrecpt` ⨝ `Fiches_Four`, sinon « mouvements exceptionnels » ;
    **autre type** (`C`, par exemple, transformé en `S` par `ObjFacB.class:1014`) : `res` n'est pas
    réaffecté → erreur « Null object » au premier document, ou libellé du document précédent
    (ATRIBVIGNETTE-A01, à confirmer selon les données) ;
  - nœuds fils : `SELECT LEFT(numlig,6) AS bl, vignette … WHERE num=&1 AND type='S' AND
    cloture=False GROUP BY bl,vignette` (un nœud par BL et vignette, clé `num/bl/vignette`) ;
    à défaut, la **première** ligne `E` du document (clé `num//vignette`), sans test `Available`.
  Appelle ensuite `manquant`.
- **`manquant()`** [Private] [nature : mixte] : `SELECT vignette … WHERE vignette<>'' GROUP BY
  vignette ORDER BY vignette` (toutes lignes, clôturées comprises) ; parcourt la séquence et ajoute
  à `ColumnView1` chaque numéro absent entre le plus petit et le plus grand. Calcul en **`Float`**
  sur des numéros de 25 chiffres : au-delà de 2^53 (≈ 9·10^15) les numéros ne sont plus exacts
  (ATRIBVIGNETTE-A04) ; un trou important produit une liste très longue (boucle sans limite).
- **`suspendu(num)`** [Private] [nature : calcul] : vrai si une ligne non clôturée du document
  porte une régie `suspendu=True` (`Fiches_regie` ⨝ `Fiches_ligregie`).
- **`Modif()`** [Private] [nature : mixte] : découpe la clé du nœud courant ; si un BL est présent,
  `UPDATE Fiches_ligregie SET vignette=&1 WHERE num=&2 AND numlig LIKE &3` (**sans** filtre
  `cloture=False` ni `type='S'` : ATRIBVIGNETTE-A02), sinon `UPDATE … WHERE num=&2 AND
  cloture=False` (toutes les lignes non clôturées du document, tous types). Met à jour le texte du
  nœud, vide la zone, relance `manquant`. `If Not txt` ne peut pas être vrai (`Split` renvoie
  toujours un tableau).
- **`TreeView1_Activate()`** [handler] [nature : GUI] : sur un nœud de ligne, recopie la vignette
  courante dans `Textvig`, mémorise `$ancienval`, `$bmod = True`.
- **`Textvig_LostFocus()`** [handler] [nature : mixte] : si `$bmod` : refuse un texte non entier
  (`Stop Event` sans effet dans un `LostFocus`) ; formate sur 25 chiffres ; si le numéro a changé,
  refuse un numéro déjà attribué ailleurs (`SELECT * FROM Fiches_ligregie WHERE vignette=&1`,
  ballon « N° vignette existant »), sinon `Modif`.
- **`Textvig_KeyPress()`** [handler] [nature : GUI] : Échap restaure ; Entrée/Retour/Tab appellent
  directement `Textvig_LostFocus` (pseudo-appel de handler) puis `Stop Event`.
- **`Button1_Click()`** [handler] [nature : mixte] : « Mise à blanc » : si une vignette est
  affichée, vide la zone puis `Modif` → la vignette de la ligne est remise à `''` (comportement
  voulu, d'après le libellé du bouton).

## État global utilisé

- `Utils.db.Exec` uniquement ; **pas d'`Utils.Observers(Me)`** : écran non journalisé, donc non
  rejouable en l'état (voir test.md).
- État d'instance : `$ancienval` (vignette avant modification), `$bmod` (édition en cours).

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire de `affiche` : `LibelleDocument(num, type) As String` (remplace les trois
  `SELECT 'mouvements exceptionnels' AS lib` par une constante : SQL modifié, dump identique) et
  `AjouteLignes(num)` ; CC 12 → ≤ 5 visé.
- Supprimer le test `If Not txt` (toujours faux) de `Modif`.
- `Cbase.Table("TabBl")`, `("TabHisFac")`, `("TabEntrecpt")`, `("TabFour")` pour les tables qui ont
  une clé (SQL identique).

### Commonalisation avec d'autres fichiers

- Le contrôle « régie en régime suspendu » (`suspendu`) existe aussi dans
  [Caleditcmat](../Caleditcmat.class/architecture.md) (`ctrlachat`, requêtes `suspendu=&3`) et
  dans [calculdroit](../calculdroit.class/architecture.md) (propriété `suspendu`) : une fonction
  unique `RegieSuspendue(code)` (dans `calculdroit` ou un module de l'option boissons).
- Le format de vignette sur 25 chiffres (`Format(…, "0000000000000000000000000")`) est répété ici
  (×2), dans [ObjFacB](../ObjFacB.class/architecture.md) et `Mvtex` : constante ou fonction
  `FormatVignette(n)` commune.

### Réduction de portée

Rien à réduire : `_new` et les handlers doivent rester `Public` ; le reste est déjà `Private`.

### Séparation traitement / GUI

- `VignettesManquantes() As String[]` (calcul pur à partir de la requête) appelée par `manquant`.
- `AttribueVignette(num, bl, vignette)` (les deux `UPDATE` de `Modif`) sans accès aux contrôles.
- `VignetteExiste(vignette) As Boolean` pour `Textvig_LostFocus`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Créer `Fiches_regie` et `Fiches_ligregie` par une migration (et les ajouter à `db_control.csv`)
  plutôt que par `modfichier.fichierboisson`.
- Stocker la vignette en entier (`DECIMAL(25,0)` ou `BIGINT` si 18 chiffres suffisent) : tri,
  recherche des trous et unicité deviendraient exacts ; index unique sur `vignette` non vide.
- Index `(cloture, num, type)` sur `Fiches_ligregie` pour la requête principale.
