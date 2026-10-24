# Variables — Architecture

> Source : `.src/Utils/Variables.module`

## Vue d'ensemble

`Variables` est un module **sans fonction** qui déclare 41 variables `Public` (globales) et 2
`Private`. Il sert de « boîte aux lettres » entre écrans : une fenêtre de recherche (`TriFac`,
`Tricp`, `TriEqu`…) écrit le résultat choisi dans `Variables.X`, puis la fenêtre appelante
(`Facture`, `FClientcarte`…) le relit après la fermeture du dialogue modal.

Huit variables sont **initialisées depuis `Start.LocalSettings`** au premier accès au module
(`son`, `Sprix`, `Sexport`, `Simport`, `Schmprix`, `SMajArt`, `SMajFour`, `SMajCli`) : elles figent
les réglages de la société active **au moment du premier accès** ; un changement de société ou de
préférences en cours de session n'est pas répercuté (à confirmer selon l'ordre d'ouverture des
écrans, voir VARIABLES-A01).

Nature : **état global pur**, aucun calcul.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Public | oui | String | 3 |
| `Sprix` | var | Public | oui | Boolean | 4 |
| `Sexport` | var | Public | oui | Boolean | 5 |
| `Simport` | var | Public | oui | Boolean | 6 |
| `Schmprix` | var | Public | oui | String | 7 |
| `SMajArt` | var | Public | oui | Boolean | 8 |
| `SMajFour` | var | Public | oui | Boolean | 9 |
| `SMajCli` | var | Public | oui | Boolean | 10 |
| `Musique` | var | Public | oui | String | 11 |
| `OrgTarCli` | var | Public | oui | String | 12 |
| `OrgTarTypeCli` | var | Public | oui | String | 13 |
| `OrgCoefTypeCli` | var | Public | oui | String | 14 |
| `$TarTypeCli` | var | Public | oui | String | 15 |
| `ArtCode` | var | Public | oui | String | 16 |
| `Artintitule` | var | Public | oui | String | 17 |
| `ArtTva` | var | Public | oui | String | 18 |
| `ArtHt` | var | Public | oui | String | 19 |
| `TypeL` | var | Public | oui | String | 20 |
| `Codearticle` | var | Public | oui | String | 21 |
| `Cfour` | var | Public | oui | String | 22 |
| `obs` | var | Public | oui | String | 23 |
| `$fic` | var | Public | oui | String | 24 |
| `$doc` | var | Public | oui | String | 25 |
| `EnvoiMail` | var | Public | oui | String | 26 |
| `$Codeclient` | var | Public | oui | String | 27 |
| `$Codearticle` | var | Public | oui | String | 28 |
| `$Codemo` | var | Public | oui | String | 29 |
| `numeroFac` | var | Public | oui | String | 30 |
| `codepostal` | var | Public | oui | String | 31 |
| `Bureaudistributeur` | var | Public | oui | String | 32 |
| `numerobl` | var | Public | oui | String[] | 33 |
| `inumr` | var | Public | oui | Integer | 34 |
| `Qte` | var | Public | oui | Float | 35 |
| `bRemise` | var | Public | oui | Boolean | 36 |
| `Bselection` | var | Public | oui | Boolean | 37 |
| `Bsel` | var | Public | oui | Boolean | 38 |
| `FMateriel` | var | Public | oui | Boolean | 39 |
| `impr` | var | Public | oui | String | 40 |
| `sTexte` | var | Public | oui | String | 41 |
| `bImpref` | var | Public | oui | Boolean | 42 |
| `hpb` | var | Private | oui | ProgressBar | 43 |
| `hlb` | var | Private | oui | Label | 44 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
_Aucune fonction._
<!-- /AUTO:fonctions -->

## Description des fonctions

Aucune fonction. La description porte sur les variables : lecteurs et écrivains obtenus par grep
(`Variables.X` hors commentaires, au commit `6b6b9dfc` ; `With Variables` n'est jamais utilisé).

### Réglages figés à l'initialisation (lecture seule de fait)

| Variable | Initialisation | Écrite par | Lue par |
|---|---|---|---|
| `son` (String) | `/son` | — | `TBord` |
| `Musique` (String) | `"son/warning.ogg"` | — | `TBord` (doublon de `Start.Musique`) |
| `Sprix` (Boolean) | `/Soc<XX>/Sprix` | — | `Impart` (11), `Articles` (10), `FFournisseur` (6), `MajTarifP` (5), `FClient` (5), `MajFbtarif2` (3), `MajTarifM` (3), `Famille` (2), `MajEqu` (1) |
| `Sexport` (Boolean) | `/Soc<XX>/Sexport` | — | mêmes fichiers que `Sprix` |
| `Simport` (Boolean) | `/Soc<XX>/Simport` | — | **personne** |
| `Schmprix` (String) | `/Soc<XX>/Schmprix` | — | `Serveur.module` (15 occ.) |
| `SMajArt` (Boolean) | `/Soc<XX>/SMajArt` | — | `Impart`, `Articles`, `MajTarifP`, `MajFbtarif2`, `MajTarifM`, `Famille`, `MajEqu` |
| `SMajFour` (Boolean) | `/Soc<XX>/SMajFour` | — | `FFournisseur` (6) |
| `SMajCli` (Boolean) | `/Soc<XX>/SMajCli` | — | `FClient` (5) |

### Échanges entre écrans (lecture et écriture)

| Variable | Écrite par (fichier:ligne) | Lue par |
|---|---|---|
| `Bsel` (Boolean) | `TriEqu` (55, 115, 127, 147, 158, 288, 319, 350), `TriFac` (416, 425), `TriFac2` (633, 647), `TriMo:62`, `Tricp:144`, `Facture` (4414, 10943), `Materiel:2527`, `Ttarfioul:199`, `Changefour:206` | `Facture` (2579, 2681, 4525, 12111…), `FClientcarte` (926, 1017), `Changefour`, `Materiel`, `TriEqu` |
| `numeroFac` (String) | `TriFac:417`, `TriFac2` (635, 637), `Facture:9729` | `Facture` (12 occ., 9909…10257) |
| `$Codearticle` (String) | `TriEqu` (56, 116, 128, 148, 159, 289, 320, 351), `Facture:4435` | `Facture` (4436, 4526, 4530, 4827, 4841) |
| `codepostal`, `Bureaudistributeur` (String) | `Tricp` (145, 146) | `Facture` (2580-2581, 2682-2683), `FClientcarte` (927-928, 1018-1019) |
| `bRemise` (Boolean) | `Facture` (1983, 2393), `Facturergbl` (605, 724), `Archives:1274` | `Cdocuments` (9 occ., impression), `Archives` |
| `ArtCode`, `Artintitule`, `ArtTva`, `ArtHt`, `OrgCoefTypeCli` (String) | `Articles` (4555-4559) | `CoefTypeC` (385-388) |
| `sTexte` (String, texte de courriel) | `ComMail:199`, `FClient:2373` | `ObjFacB` (662, 670, 876, 884), `FClient` (2389) |

### Écrites mais jamais lues

| Variable | Écrite par |
|---|---|
| `$Codemo` | `TriMo:63` |
| `inumr` (Integer) | `ValidBR:703` |
| `FMateriel` (Boolean) | `Facture` (12063, 12065) |
| `impr` (String) | `ChxImp:25` |

### Lues mais jamais écrites (valeur par défaut constante)

| Variable | Lue par | Valeur effective |
|---|---|---|
| `EnvoiMail` | `Cdocuments` (109, 113, 118, 272, 308) | `""` : les branches `= "Mail"` sont inatteignables |
| `TypeL` | `Cdocuments` (644, 672) | `""` : la branche `= "B"` est inatteignable |
| `Qte` (Float) | `Cdocuments` (646, 674) | `0` |
| `bImpref` | `Cdocuments` (512, 570) | `False` |

### Jamais utilisées (code mort)

`Simport`, `OrgTarCli`, `OrgTarTypeCli`, `$TarTypeCli`, `Codearticle`, `Cfour`, `obs`, `$fic`, `$doc`,
`$Codeclient`, `numerobl`, `Bselection`, et les privées `hpb` (ProgressBar), `hlb` (Label).

## État global utilisé

- Lu à l'initialisation : `Start.LocalSettings` (`/son`, `/Soc<XX>/…`) et `Start.Societe`.
- Le module est lui-même de l'état global : 41 globales (KPI), dont 14 jamais utilisées.

## Propositions d'amélioration

### Réécriture / refactorisation

- Regrouper les déclarations par usage (réglages / échanges entre écrans) avec un commentaire
  indiquant l'écrivain et le lecteur de chaque variable.

### Commonalisation avec d'autres fichiers

- `son`/`Musique` doublonnent `Start.son`/`Start.Musique` ([Start](../../Start.module/architecture.md)) :
  `TBord` peut lire `Start` directement (attention : `Start.son` est un `Integer` mis à jour par
  `Start`, `Variables.son` une `String` figée).
- Les réglages `Sprix`, `Sexport`, `SMaj*`, `Schmprix` sont lus directement ailleurs par
  `Start.LocalSettings["/Soc" & Start.Societe & "/…"]` : une fonction d'accès (par exemple dans
  `Serveur`) garantirait une lecture à jour.

### Réduction de portée (préparation à la réduction des globales)

Proposition par étapes, sans changement de comportement :
1. **Supprimer** les 14 variables jamais utilisées.
2. **Supprimer** les 4 variables écrites jamais lues (avec leurs affectations dans `TriMo`,
   `ValidBR`, `Facture`, `ChxImp`).
3. Les 4 variables lues jamais écrites (`EnvoiMail`, `TypeL`, `Qte`, `bImpref`) : leur suppression
   impose de simplifier les branches mortes de `Cdocuments` ; à faire dans le rework de
   [Cdocuments](../../Reports/Cdocuments.class/architecture.md) (même commit).
4. Les échanges écran → écran (`Bsel`, `numeroFac`, `$Codearticle`, `codepostal`…) deviennent à terme
   des propriétés `Public` de la fenêtre de recherche lues par l'appelant après `ShowModal`
   (hors périmètre de ce plan : changement d'API sur une quinzaine d'écrans, à planifier en phase 3).

### Séparation traitement / GUI

- Sans objet (pas de fonction). `hpb`/`hlb` (contrôles GUI privés) sont morts.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : le module n'accède pas à la base.
