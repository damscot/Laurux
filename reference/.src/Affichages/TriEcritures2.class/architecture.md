# TriEcritures2 — Architecture

> Source : `.src/Affichages/TriEcritures2.class`

## Vue d'ensemble

`TriEcritures2` est une **copie antérieure et simplifiée** de
[`TriEcritures`](../TriEcritures.class/architecture.md) (493 lignes communes, ratio 0,88 mesuré par
`dup.py`) : liste modale de sélection d'une écriture de `Fiches_Mvt` avec retour par le module
[`Comptabilite`](../../Compta/Utils/Comptabilite.module/architecture.md).

**Classe morte** :

- aucun `New TriEcritures2`, aucune référence `TriEcritures2.` dans `.src` (`grep -rnw`) ;
- aucune chaîne `"TriEcritures2"` (pas de `Class.Load`/`Object.New`) ; `deps.py` :
  `jamais_reference` ;
- `git log -S "TriEcritures2" -- .src` ne trouve que l'import initial du dépôt (`5d9a8696`, 2016) :
  la classe n'a jamais été appelée dans l'historique git ;
- la documentation de `Comptabilite` la signalait déjà comme apparemment morte : **confirmé**.

La suppression du couple `TriEcritures2.class` + `TriEcritures2.form` est une **anomalie**
(TRIECRITURES2-A01), soumise à validation.

Différences avec `TriEcritures` (les défauts ne sont que latents) :

- 8 colonnes : pas de colonne « intitulé » du compte (`Nom`) ; `Ecrit_Click` lit le numéro en
  colonne 3 et le libellé en colonne 7 ;
- requêtes `Debn1`…`Debn4` **sans** les filtres `cloturee = 0` et `pointee` : elle listerait les
  écritures clôturées et pointées ;
- pas de `JO_Click` ni `JO_GotFocus` (seulement `JO_Dblclick`, `JO_KeyPress`, `JO_LostFocus`) ;
- pas de variables `numero`/`modif`, pas de `Print` d'erreur.

Nature : **GUI**, SQL concaténé.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `CoTable` | var | Private |  | New String[8] | 3 |
| `Dbl` | var | Private |  | Boolean | 4 |
| `NbEnreg` | var | Private |  | Integer | 5 |
| `Tri` | var | Private |  | String | 6 |
| `Type` | var | Private |  | String | 7 |
| `sel` | var | Private |  | String | 8 |
| `lg` | var | Private |  | Integer | 9 |
| `tsr` | var | Private |  | String | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 13-35 | Public | 3 | 20 | 0 | méthode spéciale |
| `Entete` | 37-48 | Public | 1 | 10 | 0 | portée réductible ? |
| `Dbclk2` | 50-70 | Public | 4 | 19 | 0 | portée réductible ? |
| `JO_LostFocus` | 72-76 | Public | 2 | 3 | 0 | handler GUI |
| `COM_GotFocus` | 78-83 | Public | 2 | 4 | 0 | handler GUI |
| `COM_LostFocus` | 85-89 | Public | 2 | 3 | 0 | handler GUI |
| `DA2_GotFocus` | 91-96 | Public | 2 | 4 | 0 | handler GUI |
| `DA2_LostFocus` | 98-102 | Public | 2 | 3 | 0 | handler GUI |
| `NUM2_GotFocus` | 104-109 | Public | 2 | 4 | 0 | handler GUI |
| `NUM2_LostFocus` | 111-115 | Public | 2 | 3 | 0 | handler GUI |
| `DOC2_GotFocus` | 117-122 | Public | 2 | 4 | 0 | handler GUI |
| `DOC2_LostFocus` | 124-128 | Public | 2 | 3 | 0 | handler GUI |
| `DEB_GotFocus` | 130-135 | Public | 2 | 4 | 0 | handler GUI |
| `DEB_LostFocus` | 137-141 | Public | 2 | 3 | 0 | handler GUI |
| `CRED_GotFocus` | 143-148 | Public | 2 | 4 | 0 | handler GUI |
| `CRED_LostFocus` | 150-154 | Public | 2 | 3 | 0 | handler GUI |
| `INTITULE_GotFocus` | 156-161 | Public | 2 | 4 | 0 | handler GUI |
| `INTITULE_LostFocus` | 163-167 | Public | 2 | 3 | 0 | handler GUI |
| `JO_Dblclick` | 169-174 | Public | 1 | 4 | 0 | handler GUI |
| `JO_KeyPress` | 176-195 | Public | 7 | 18 | 0 | handler GUI |
| `COM_Click` | 197-210 | Public | 2 | 12 | 0 | handler GUI |
| `COM_Dblclick` | 212-217 | Public | 1 | 4 | 0 | handler GUI |
| `COM_KeyPress` | 219-238 | Public | 7 | 18 | 0 | handler GUI |
| `DA2_Click` | 240-252 | Public | 2 | 11 | 0 | handler GUI |
| `DA2_Dblclick` | 254-259 | Public | 1 | 4 | 0 | handler GUI |
| `DA2_KeyPress` | 261-284 | Public | 8 | 22 | 0 | handler GUI |
| `NUM2_Click` | 286-299 | Public | 2 | 12 | 0 | handler GUI |
| `NUM2_Dblclick` | 301-306 | Public | 1 | 4 | 0 | handler GUI |
| `NUM2_KeyPress` | 308-327 | Public | 7 | 18 | 0 | handler GUI |
| `DOC2_Click` | 329-342 | Public | 2 | 12 | 0 | handler GUI |
| `DOC2_Dblclick` | 344-349 | Public | 1 | 4 | 0 | handler GUI |
| `DOC2_KeyPress` | 351-370 | Public | 7 | 18 | 0 | handler GUI |
| `DEB_Click` | 372-385 | Public | 2 | 12 | 0 | handler GUI |
| `DEB_Dblclick` | 387-392 | Public | 1 | 4 | 0 | handler GUI |
| `DEB_KeyPress` | 394-413 | Public | 7 | 18 | 0 | handler GUI |
| `CRED_Click` | 415-428 | Public | 2 | 12 | 0 | handler GUI |
| `CRED_Dblclick` | 430-435 | Public | 1 | 4 | 0 | handler GUI |
| `CRED_KeyPress` | 437-456 | Public | 7 | 18 | 0 | handler GUI |
| `INTITULE_Click` | 458-471 | Public | 2 | 12 | 0 | handler GUI |
| `INTITULE_Dblclick` | 473-478 | Public | 1 | 4 | 0 | handler GUI |
| `INTITULE_KeyPress` | 480-501 | Public | 8 | 19 | 0 | handler GUI |
| `Ecrit_Data` | 503-529 | Public | 8 | 25 | 0 | handler GUI |
| `Tris2` | 531-545 | Public | 1 | 13 | 0 | portée réductible ? |
| `Ecrit_Click` | 547-555 | Public | 4 | 7 | 0 | handler GUI |
| `Ecrit_KeyPress` | 557-583 | Public | 11 | 24 | 0 | handler GUI |
| `Ecrit_MouseWheel` | 585-594 | Public | 4 | 8 | 0 | handler GUI |
| `Descendre_Click` | 596-606 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 608-616 | Public | 4 | 7 | 0 | handler GUI |
| `Descendre_KeyPress` | 618-626 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 628-636 | Public | 5 | 7 | 0 | handler GUI |
| `Deplacement` | 638-647 | Public | 3 | 8 | 0 | portée réductible ? |
| `Debe1` | 649-654 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe2` | 656-661 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe3` | 663-668 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe4` | 670-675 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn1` | 677-682 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn2` | 684-689 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn3` | 691-696 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn4` | 698-703 | Public | 1 | 4 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les fonctions ont le même comportement que leurs homonymes de `TriEcritures` (voir son
architecture), aux différences ci-dessus près :

- **`_new($Type, $sel, $tr)`** [constructeur] : `Utils.Observers(Me)`, `Comptabilite.sCmpt = ""`,
  `Entete`, `Tris2`, puis `Debn1`/`Debn3`.
- **`Entete`, `Tris2`, `Dbclk2`, `Deplacement`** [portée : réductible] [nature : GUI].
- **`Ecrit_Data`** [handler] : 8 colonnes (`CoTable` de 8 éléments).
- **`Debn1`…`Debn4`** [réductible] [nature : mixte] : `SELECT * FROM TabMvt WHERE validee = <Type>
  AND tresorerie = <tsr> AND collectif is null AND <Tri> LIKE "%<sel>%" ORDER BY … LIMIT …`,
  `Debn1`≡`Debn3`, `Debn2`≡`Debn4`.
- **`Debe1`…`Debe4`** : jamais appelées (`unused`, vérifié), variantes sur `provisoire`/`validee`.
- **Handlers d'en-tête** (`COM_*`, `DA2_*`, `NUM2_*`, `DOC2_*`, `DEB_*`, `CRED_*`, `INTITULE_*`,
  `JO_Dblclick`, `JO_KeyPress`, `JO_LostFocus`) et de pagination (`Ecrit_KeyPress`,
  `Ecrit_MouseWheel`, `Descendre_*`, `Remonter_*`) : identiques à `TriEcritures`.
- **`Ecrit_Click`** [handler, rejoué par `Object.Call`] : écrit `Comptabilite.Bsel = True` **avant**
  les trois `Try` de lecture (`snum` colonne 3, `libelle` colonne 7, `journal` colonne 0), puis ferme.

## État global utilisé

- `Comptabilite.Bsel`, `snum`, `libelle`, `journal`, `sCmpt` (jamais exécuté).
- `Utils.rs1`, `Utils.Base`, `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **Suppression** de la classe et de son `.form` (TRIECRITURES2-A01). Aucune commonalisation avec
  `TriEcritures` n'est proposée : la copie disparaît.

### Commonalisation avec d'autres fichiers

- Sans objet (copie morte de `TriEcritures`).

### Réduction de portée

- `Entete`, `Dbclk2`, `Tris2`, `Deplacement`, `Debe1`-`Debe4`, `Debn1`-`Debn4` : aucun appelant
  externe (sans objet si suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Sans objet (classe morte).
