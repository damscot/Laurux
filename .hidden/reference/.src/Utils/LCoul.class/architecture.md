# LCoul — Architecture

> Source : `.src/Utils/LCoul.class`

## Vue d'ensemble

`LCoul` centralise les **couleurs de fond des listes** (articles, écritures, documents de vente)
et produit des fragments SQL `CASE WHEN … END as bgcolor` que les écrans de tri (`TriGen` et
dérivés) ajoutent à leur `SELECT` pour colorer chaque ligne.

Chaque catégorie est une structure `SColor` (`Bg` fond, `Ft` police, `Fg` texte) :
- articles (`Art_Stk`, `Art_NStk`, `Art_Epuise`, `Art_Suspendu`) : lus dans la configuration
  `/Coul/Stk`, `/Coul/Nstk`, `/Coul/Eps`, `/Coul/Spd` via `Utils.Fcolr` (format
  `"background: …; font: …; foreground: …"`) ;
- écritures (`Ecr_*`) et documents (`Fac_*`) : **valeurs en dur** (commentaire : « Pour l'instant
  valeur en dur »).

Usage : `New LCoul` dans `TriArticles`, `TriFacture`, `Articles` ; appel statique sur
l'auto-instance (`Create Static`) `LCoul.Ecr_DB_bgcolor(…)` dans `Listextcpt`.

Nature globale : **calcul** (construction de chaînes SQL à partir de la configuration).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bg` | var | Private |  | String | 6 |
| `Ft` | var | Private |  | String | 7 |
| `Fg` | var | Private |  | String | 8 |
| `Art_Stk` | var | Public |  | SColor | 11 |
| `Art_NStk` | var | Public |  | SColor | 12 |
| `Art_Epuise` | var | Public |  | SColor | 13 |
| `Art_Suspendu` | var | Public |  | SColor | 14 |
| `Ecr_provisoire` | var | Public |  | SColor | 16 |
| `Ecr_lettree` | var | Public |  | SColor | 17 |
| `Ecr_pointee` | var | Public |  | SColor | 18 |
| `Ecr_cloture` | var | Public |  | SColor | 19 |
| `Ecr_oldex` | var | Public |  | SColor | 20 |
| `Fac_Proforma` | var | Public |  | SColor | 22 |
| `Fac_Devis` | var | Public |  | SColor | 23 |
| `Fac_Commande` | var | Public |  | SColor | 24 |
| `Fac_Bon` | var | Public |  | SColor | 25 |
| `Fac_Acquite` | var | Public |  | SColor | 26 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-96 | Public | 5 | 59 | 0 | méthode spéciale |
| `Art_DB_bgcolor` | 98-102 | Public | 1 | 3 | 2 |  |
| `Fac_DB_bgcolor` | 104-108 | Public | 1 | 3 | 1 |  |
| `Ecr_DB_bgcolor` | 110-120 | Public | 2 | 7 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Montant, Quantite, Arr, Cpt)`** [portée : nécessaire] [nature : calcul].
  ⚠️ La signature est **copiée de `LPrix._New`** : les quatre paramètres sont inutilisés (aucun
  appelant n'en passe). Charge les 4 couleurs d'article (si `Utils.Fcolr` renvoie `Null` :
  `Bg = "&HFFFFFF&"`, sinon `Bg`/`Ft`/`Fg` = éléments 0/1/2), puis les couleurs en dur des
  écritures et documents.
  ⚠️ Ligne 56 : `Art_Epuise = "&HFFFFFF&"` affecte une chaîne à la **structure** au lieu de
  `Art_Epuise.Bg` : si `Fcolr` renvoie `Null` (exception dans `Fcolr`, par exemple une entrée de
  configuration sans `:`), la construction échoue avec une erreur de type (à confirmer ; une clé
  absente donne en principe un tableau de `Null` et non `Null`, donc `Bg = Null`).
  Les blocs article sont identiques quatre fois.
- **`Art_DB_bgcolor()`** [portée : nécessaire] [nature : calcul]. `CASE` sur `art_suspendu`,
  `art_qte`, `art_stocke` → fond ; défaut `&H00FFFF&` (jaune). Appelants : `TriArticles:102`,
  `Articles:4700`.
- **`Fac_DB_bgcolor()`** [portée : nécessaire] [nature : calcul]. `CASE` sur `acquitte` et `type`
  (`D`, `C`, `B`) ; `Fac_Proforma` n'est **pas** utilisé (type `P` → défaut blanc). Littéraux en
  guillemets doubles (`type = "D"`) : accepté par MySQL et, en repli, par SQLite. Appelant :
  `TriFacture:102`.
- **`Ecr_DB_bgcolor(OldExe)`** [portée : nécessaire] [nature : calcul]. `CASE` sur `lettree`,
  `pointee`, `cloturee`, `provisoire` ; défaut blanc ou `Ecr_oldex` pour les exercices antérieurs.
  Appelant : `Listextcpt:109/114/121/127` (statique).

Les valeurs de couleur sont **concaténées** dans le SQL entre apostrophes : une valeur de
configuration contenant `'` casserait la requête (configuration locale, risque faible).

## État global utilisé

- `Start.LocalSettings["/Coul/Stk" | "/Coul/Nstk" | "/Coul/Eps" | "/Coul/Spd"]`.
- `Utils.Fcolr` (analyse du format de couleur).
- `LPrix.Arr_001` (valeur par défaut du paramètre inutilisé `Arr`).
- Auto-instance statique utilisée par `Listextcpt`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `LitCouleur(cle As String) As SColor` pour les quatre blocs article (et
  correction de la ligne 56 seulement si l'utilisateur valide LCOUL-A01).
- Helper privé `Case(champs_valeurs, defaut)` pour les trois fragments `CASE WHEN … END`.
- Supprimer les paramètres inutilisés de `_New` (aucun appelant n'en passe : `New LCoul` partout).

### Commonalisation avec d'autres fichiers

- Les mêmes clés `/Coul/*` sont lues ailleurs : `Start.module:122-131` (`Proform`, `Devis`,
  `Bon`, `Epuises`, `Stockes`…), `Cprod.class:43-48`, `SetColors` (édition), `Cdoc` (édition,
  code mort, voir [`Cdoc`](../Cdoc.class/architecture.md)). Un point d'accès unique aux couleurs
  (`LCoul`) éviterait les lectures dispersées : à étudier en phase 3 avec
  [`Start.module`](../../Start.module/architecture.md).
- Les couleurs de documents (`Fac_*`) sont en dur alors que `/Coul/Devis`, `/Coul/Cmde`,
  `/Coul/Bl`, `/Coul/Prf` existent dans la configuration (édités par `SetColors`) : les relier
  changerait l'affichage (anomalie LCOUL-A03).

### Réduction de portée

- Les 14 champs `SColor` sont signalés « réductibles » par `deps.py` : ils ne sont lus qu'en
  interne (vérifié par `grep` : aucun `.Art_Stk`, `.Fac_Devis`… hors du fichier). Passage en
  `Private` possible (`Public Struct SColor` doit rester déclaré).
- `Ft`/`Fg` : jamais lus (ni en interne ni ailleurs) ; conservés car ils reflètent le format de
  configuration.

### Séparation traitement / GUI

- Sans objet (aucun contrôle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les états (`art_suspendu`, `lettree`, `pointee`…) sont des `tinyint` : la coloration côté SQL
  convient. Une table de paramétrage des couleurs par société (au lieu du fichier local
  `Laurux.conf`) permettrait un affichage homogène entre postes.
