# Edinv — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv.class`

## Vue d'ensemble

Édition PDF de l'**inventaire valorisé**, **paramétrée** par le type d'inventaire :
`New Edinv("F")` (fin d'exercice, `Fiches_Inv`, menu 85, `Fmenu.class:1076`) ou `New Edinv("T")`
(tournant, `Fiches_InvT`, menu 99, `Fmenu.class:1115`) — voir
[Fmenu](../../../../../Communs/Fmenu.class/architecture.md). C'est le **seul écran déjà commun aux
deux variantes** : il a remplacé [Edinv1](../Edinv1.class/architecture.md) (87 % de lignes
communes) et [EdinvT](../../Tournant/EdinvT.class/architecture.md), devenus du code mort. Il sert
de modèle au socle commun proposé dans [Geninv](../Geninv.class/architecture.md).

Pour les lignes **comptées**, regroupées par famille selon l'arbre [`Trifam`](../../../../../Utils/Trifam.class/architecture.md)
(niveaux définis par `/SocXX/ipr`), il imprime code, désignation, quantité comptée, PU (PA),
valeur au PA et au PMP, des sous-totaux par famille (cumulés vers les familles parentes par les
propriétés `soustotpa`/`soustotpmp` de `Trifam`) et un total général. Fichier
`~/tmp/Inventaire.pdf`, gabarit `Cstocks` (`Entete`, `Entetefam`, `Level1`, `Level2`,
`Level3fam`, `Level3`), saut de page à 270 mm.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `Decm` | var | Private |  | Integer | 29 |
| `nbd` | var | Private |  | String | 30 |
| `nbdec` | var | Private |  | String | 31 |
| `PosY` | var | Private |  | Integer | 32 |
| `Coulfond` | var | Private |  | New String[] | 33 |
| `pdf` | var | Private |  | Cstocks | 34 |
| `$familles` | var | Private |  | Trifam | 35 |
| `Nbpage` | var | Private |  | Integer | 36 |
| `$schoix` | var | Private |  | String | 37 |
| `$fichier` | var | Private |  | String | 38 |
<!-- /AUTO:declarations -->

- `$schoix` (`"F"`/`"T"`) et `$fichier` (table) : fixés par `_New`.
- `$familles` : racine de l'arbre `Trifam`.
- `Coulfond`, `Nbpage` : affectés, jamais lus. `Decm`, `nbd`, `nbdec` : membres utilisés comme
  variables de travail de `TriArticles`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 40-74 | Public | 7 | 31 | 0 | méthode spéciale |
| `TriArticles` | 76-134 | Private | 15 | 56 | 0 |  |
| `sautpage` | 136-143 | Private | 1 | 7 | 0 |  |
| `Button1_Click` | 145-175 | Public | 2 | 22 | 0 | handler GUI |
| `button2_Click` | 177-182 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 184-188 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(choix)`** [portée : nécessaire (spéciale, 2 appelants dans `Fmenu`)] [nature : mixte].
  Titre de la fenêtre et table selon `choix` ; `Try SELECT * FROM $fichier` → date de la 1re ligne
  (`dd.mm.yyyy`) dans `dte` ; table vide ou absente → message « aucun inventaire » et `Me.Close`
  dans le constructeur, **puis `Fmenu` appelle `ed.Show`** sur l'objet fermé (à confirmer :
  fenêtre vide ou erreur, EDINV-A02). Un `choix` autre que `F`/`T` laisserait `$fichier` vide.
- **`TriArticles(fam)`** [portée : Private] [nature : mixte] (CC 15). Parcourt récursivement
  l'arbre `Trifam` (énumération `For Each` sur la chaîne `enfant`, appel récursif sur
  `precedant`) ; pour chaque nœud : en-tête de famille, puis `SELECT * FROM $fichier, Fiches_Art,
  Fiches_Fam WHERE inv_code = art_code AND art_fam = code_fam AND art_fam = &1 AND inv_comptee = '1'`
  (jointure implicite, `Fiches_Art`/`Fiches_Fam` en dur). Valorisation : `Pu * Val(qté)` et
  `Pmp * Val(qté)` formatés selon `art_nbd` (`Utils.Find_nbdec`), avec un espace ajouté pour aligner
  les montants à 2 décimales ; la quantité est complétée par des espaces si `art_dec < 3` avant
  `Val` (tolérance à confirmer). Sous-totaux par `fm.soustotpa = Pht` (l'écriture **cumule** et
  remonte au parent dans `Trifam`). Fermeture des familles par `Level3fam` en remontant les parents.
  ⚠️ `Print fm.cle, fm.Text` (l. 90) : trace de débogage sur la sortie standard. Les articles dont
  `art_fam` n'est pas un nœud de l'arbre (famille absente de `Fiches_Fam`, vide…) **n'apparaissent
  pas** et ne sont pas totalisés (EDINV-A01, à confirmer).
- **`sautpage()`** [Private] [GUI]. `Baspage`, `Entete(Me.Text & dte.Text)`, `Level1`. L'en-tête des
  pages suivantes est donc « Impression de l'inventaire25.10.2026 » (sans « du » ni espace), et
  « … tournant… » en mode `T`, différent de la 1re page (EDINV-A03).
- **`Button1_Click()`** [handler, « Imprimer »] [mixte]. Crée le PDF, `New Trifam("1")` (qui fait
  `Quit` si `/SocXX/ipr` n'est pas paramétré), `TriArticles($familles.enfant)`, total général,
  `Visualiseur.Prog`. Le cas « aucune ligne » est commenté : un PDF vide est produit.
  `Shell "cd ~"` sans effet.
- **`button2_Click()`** [handler] [GUI]. Supprime le PDF, ferme.
- **`Button4_Click()`** [handler] [GUI]. Aide `Doc.Open("Edinv")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/SocXX/ipr"]` (via `Trifam`) ;
  `Utils.db`, `Utils.Find_nbdec`, `Utils.PointBase`, `Utils.CDec`, `Utils.cpoint`, `Utils.Coulfd`,
  `Utils.Observers` ; `Trifam`, `Cstocks`, `Visualiseur`, `Doc`.
- Tables : `Fiches_Inv` ou `Fiches_InvT`, `Fiches_Art`, `Fiches_Fam` (lecture seule).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le `Print`, les membres morts ; valoriser sur des `Float` et formater à l'affichage.
- `TriArticles` : séparer le parcours de l'arbre de l'impression des lignes d'une famille.

### Commonalisation avec d'autres fichiers

- Modèle à généraliser : le paramètre `"F"`/`"T"` et `$fichier` deviennent `Inventaire.Table(sType)`
  / `Inventaire.Libelle(sType)` / `Inventaire.DateInv(sType)` du module commun (voir
  [Geninv](../Geninv.class/architecture.md)), réutilisés par [Ecarts](../Ecarts.class/architecture.md),
  [Ednsaisis](../Ednsaisis.class/architecture.md) et leurs jumeaux tournants.
- Fonction de valorisation (`Pu × qté`, `Pmp × qté`, format selon `art_nbd`) commune avec
  `Ecarts*`, `Ednsaisis*`.
- Parcours d'arbre de familles `Trifam` : à rapprocher des autres éditions par famille
  (`Stockmvt`, statistiques).

### Réduction de portée

- Aucune : `TriArticles` et `sautpage` sont déjà `Private`, le reste est méthode spéciale ou handler.

### Séparation traitement / GUI

- Lecture des lignes d'une famille (`LignesFamille(sCle) As Result`) et valorisation pure, sans
  contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Valorisation figée à la date d'inventaire (PA/PMP stockés dans la table d'inventaire).
- Clé étrangère `art_fam` → `Fiches_Fam` pour éviter les articles hors arbre.
