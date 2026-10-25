# modfichier — Architecture

> Source : `.src/Gestion/option/modfichier.module`

## Vue d'ensemble

`modfichier` **modifie le schéma de la base à l'exécution** pour activer les options métier :
il est appelé par [`Prefs`](../../../Communs/Prefs.class/architecture.md) quand on coche
l'option carburant (`pp_Click` → `fichiercarbu`, `supf`) ou boisson (`bois_Click` →
`fichierboisson`, `supf`), à chaque coche, avant toute validation des préférences.

⚠️ **C'est une modification de schéma hors `LauruxMaj`** : les tables et colonnes créées ici sont
**absentes de `db_control.csv`** et des bases de référence `Laurux01.sql`/`.sqlite` (vérifié par
`grep`). `DB_Sanity` ne les connaît donc pas. Seule une partie est reprise par `Maj369`
(`LauruxMaj.module:5501-5510` : `tipp_ligbl` de `LigblM`, `tipp_ligfac` de `HistoLigfacM`,
`Fiches_Societes.tipp`, `ident`, `caution`, `arrete`, `volumess`). Conformément au plan, **aucun
rework de schéma** n'est proposé : ce document décrit précisément l'existant.

Toutes les instructions sont sous `Try` : les erreurs (colonne déjà présente, syntaxe refusée)
sont ignorées en silence, ce qui rend le traitement idempotent… et masque les échecs.

Nature globale : **mixte** (DDL + fenêtre d'attente + question à l'utilisateur).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$win` | var | Private | oui | Window | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `fichierboisson` | 10-99 | Public | 31 | 76 | 1 |  |
| `fichiercarbu` | 101-169 | Public | 32 | 55 | 1 |  |
| `commun` | 171-194 | Private | 3 | 19 | 0 |  |
| `modiffrais` | 196-216 | Private | 4 | 18 | 0 |  |
| `supf` | 218-222 | Public | 1 | 3 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`fichierboisson()`** [portée : nécessaire (`Prefs:1355`)] [nature : calcul] (CC 31). `commun`,
  puis :

  | Objet | Création / modification |
  |---|---|
  | `Fiches_regie` (nouvelle) | `code char(2)` PK, `nom`, `tauxa`, `degres`, `tauxss`, `type`, `suspendu`, `ap`, `drfac`, `cdcompt`, `ttva` |
  | `Fiches_consigne` (nouvelle) | `code char(2)` PK, `libelle`, `prix decimal(6,2)`, `type` (⚠️ l. 31 sans `&` : concaténation implicite de littéraux, à confirmer avec `gbc3`) |
  | `Fiches_ligcons` (nouvelle) | `num`, `numlig`, `type`, `codecons`, `nb`, `montant`, `envaleur`, `bloc`, `code` auto-incrément (`Utils.db.AutoIncrement`) |
  | `Fiches_ligregie` (nouvelle) | `dtmouv`, `num`, `numlig`, `type`, `codeart`, `coderegie`, `qte`, `volume`, `degres`, `volumeap`, `montdr`, `txtvadr`, `montss`, `txtvass`, `vignette`, `cloture`, `code` auto-incrément ; puis `ADD volumess` |
  | `Fiches_Art` | `art_trspa`, `art_trspr`, `art_tsuc`, `art_remv`, `art_dra`, `art_volm`, `art_deg`, `art_montdr`, `art_montss`, `art_consp`, `art_nbcol`, `art_consc`, `art_nbbou`, `art_consb` |
  | `Fiches_Cli` | `cli_cons boolean DEFAULT TRUE` |
  | `Fiches_Parametres` | `conscli`, `consfou`, `nvign`, `css`, `tvass`, `arrete` |
  | `Fiches_Ligcom` | `palet`, `coli` |
  | `Fiches_Societes` | `ident`, `caution` |

- **`fichiercarbu()`** [portée : nécessaire (`Prefs:1345`)] [calcul] (CC 32). `commun`, puis :

  | Objet | Création / modification |
  |---|---|
  | `Fiches_region` (nouvelle) | `code`, `cart`, `libelle`, `taux`, PK `(code, cart)` |
  | `Fiches_tarpp`, `Fiches_ligtarpp` (nouvelles) | tarifs fioul aux particuliers |
  | `Art_Tipp` (nouvelle) | `code` PK, `ticpe` (`Utils.db.Engine()`) |
  | `Fiches_Art` | `art_ecof` |
  | `Fiches_Cli` | `cli_tipp`, `cli_dfin`, `numtipp`, `numagri`, `dtagri` |
  | `Fiches_AdrlivC` | `tipp`, `numtipp`, `numagri`, `dtagri` |
  | `Fiches_Ligbl` / `Fiches_LigblM` | `tipp_ligbl`, `numagri_ligbl`, `numadr_ligbl integer … DEFAULT -1` |
  | `Fiches_HistoLigfac` / `Fiches_HistoLigfacM` | `tipp_ligfac`, `numagri_ligfac`, `numadr_ligfac` |
  | `Fiches_Societes` | `tipp` |
  | **Types modifiés** (`MODIFY`) | `Fiches_Ligbl.qte_ligbl` → `char(8)` (référence : `varchar(12)`, **réduction**), `Fiches_HistoLigfac.qte_ligfac` → `char(10)` (réf. `varchar(6)`), `Fiches_Ligrecpt.qte` → `char(9)`, `Fiches_Ligcom.qte` → `char(9)` (réf. `decimal(9,3)`, **changement de type**) ; ni `LigblM` ni `HistoLigfacM` |

  Les colonnes texte ajoutées en juillet 2024 portent `COLLATE utf8mb4_general_ci` (la base est
  en `utf8mb4_unicode_ci`) ; `numadr_*` sont des **entiers** déclarés avec `COLLATE`, syntaxe
  probablement refusée par MySQL (erreur masquée par `Try`, à confirmer).

- **`commun()`** [Private] [mixte]. Affiche une fenêtre sans bordure « Traitement en cours »,
  puis `ADD art_trsp` ; si l'ajout réussit (première activation), `modiffrais`.
- **`modiffrais()`** [Private] [mixte]. Question (`Message.Question`) : recopier les frais dans le
  champ transport ; si oui, `Begin`, `Edit("Fiches_Art", "art_frais <> 0")` et `art_trspr =
  art_frais` sur chaque ligne, `Commit` (seulement si au moins un article). ⚠️ `art_trspr` n'existe
  pas encore à ce moment (ajoutée plus loin par `fichierboisson`, jamais par `fichiercarbu`) :
  erreur à la première affectation ; sans article concerné, `Begin` sans `Commit` (A03).
- **`supf()`** [portée : nécessaire (`Prefs:1346/1356`)] [GUI]. Ferme la fenêtre d'attente.

## Utilisateurs du schéma créé

`ObjFacB`, `facopt`, `artopt`, `Calculdroit`, `Caleditcmat`, `fourconsdroi`, `Edittipp`,
`Tregion`, `Ttarfioul`, `Tconsigne`, `Tregie`, `Facture` (`tipp_ligbl`), `VerifDate`,
`Utils.orientation`, `Parametre`, `Prefs`. `numagri_ligbl`/`numadr_ligbl` ne sont lus que par
`ObjFacB.transblfac` et jamais écrits.

## Compatibilité SQLite

Sous SQLite, échouent (en silence) : les `ADD (col type)` entre parenthèses (`art_dra`,
`art_consp`, `art_nbcol`, `art_consc`, `art_nbbou`, `art_consb`, `cli_tipp`, `cli_dfin`, `tipp` de
`AdrlivC`), tous les `MODIFY`, les `COLLATE utf8mb4_…`. L'option n'est donc utilisable que
partiellement sous SQLite (A02).

## État global utilisé

`Utils.db` (`Exec`, `AutoIncrement`, `Engine`, `Edit`, `Begin`, `Commit`), `Message.Question`,
`Window`, `TextLabel`. Variable de module `$win`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer les ~60 `Try Utils.db.Exec(…)` par des tableaux de requêtes parcourus par une boucle
  (même ordre, même `Try`) ; ajouter le `&` manquant l. 31 (texte SQL identique).
- Doublon d'en-tête (`' Gambas module file` ×2).

### Commonalisation avec d'autres fichiers

- `LauruxMaj.Maj369` répète une partie de ces `ALTER` : interdiction de toucher à `LauruxMaj`
  (PLAN §0) ; à traiter par une future migration.
- Fenêtre d'attente de `commun` : proche de `ProgBar` (Utils).

### Réduction de portée

Aucune.

### Séparation traitement / GUI

- `commun` : séparer la fenêtre (`AfficheAttente`) du DDL ; `modiffrais` : question dans
  l'appelant, copie dans `CopieFraisTransport()`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Porter tout ce schéma dans une migration `MajXYZ` de `LauruxMaj`, l'ajouter à
  `db_control.csv` et aux bases de référence, et ne plus modifier le schéma depuis `Prefs`.
- Rétablir les types de référence (`qte_ligbl varchar(12)`, `Fiches_Ligcom.qte decimal(9,3)`) ou
  aligner la référence ; traiter `LigblM`/`HistoLigfacM` comme leurs homologues.
- Collation unique (`utf8mb4_unicode_ci`) et `numadr_*` sans `COLLATE`.
