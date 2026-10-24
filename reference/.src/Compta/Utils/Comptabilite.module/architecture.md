# Comptabilite — Architecture

> Source : `.src/Compta/Utils/Comptabilite.module`

## Vue d'ensemble

Module de **6 variables globales** sans aucune fonction. Il sert de « boîte aux lettres » entre la
liste de sélection d'écritures `TriEcritures` (qui écrit le choix de l'utilisateur) et les écrans
de saisie `Saisecrit` et `Tresor` (qui le lisent après `ShowModal`). Ce n'est **pas un fichier
mort** : 5 fichiers y accèdent (grep), dont 2 eux-mêmes apparemment morts (`TriEcritures2`,
`TresorFac`, aucun appelant trouvé).

Nature : **état global** (aucun traitement).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public | oui | Boolean | 3 |
| `sCmpt` | var | Public | oui | String | 4 |
| `sdesg` | var | Public | oui | String | 5 |
| `snum` | var | Public | oui | String | 6 |
| `libelle` | var | Public | oui | String | 7 |
| `journal` | var | Public | oui | String | 8 |
<!-- /AUTO:declarations -->

| Variable | Écrite par | Lue par | Usage |
|---|---|---|---|
| `Bsel` | `Saisecrit` (False avant ouverture), `Tresor` (idem), `TriEcritures:636`, `TriEcritures2:549` (True) | `Saisecrit:641`, `660`, `Tresor:792`, `808`, `TresorFac:193` | une écriture a été choisie |
| `snum` | `TriEcritures:633`, `TriEcritures2:550` | `Saisecrit:2458`, `2546`, `Tresor:1943`, `2046` | numéro de l'écriture choisie |
| `libelle` | `TriEcritures:634`, `TriEcritures2:551` | `Tresor:1945` | libellé de l'écriture |
| `journal` | `TriEcritures:635`, `TriEcritures2:552` | `Tresor:1947` | journal de l'écriture |
| `sCmpt` | `TriEcritures:19`, `TriEcritures2:17` (toujours `""`) | `TresorFac:194` | jamais renseignée : valeur toujours vide |
| `sdesg` | personne | personne (seulement dans du code commenté : `FClient:1795`, `FFournisseur:1653`, `Extrait:306`, `Lettrage:201`, `FComptes:858`) | code mort |

## Fonctions

<!-- AUTO:fonctions -->
_Aucune fonction._
<!-- /AUTO:fonctions -->

## Description des fonctions

Aucune fonction.

## État global utilisé

Le module **est** l'état global. Protocole implicite : l'appelant met `Bsel = False`, ouvre
`TriEcritures` en modal, puis lit `Bsel`, `snum` (et `libelle`, `journal` pour `Tresor`). Les
valeurs persistent ensuite pour toute la session.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `sdesg` (jamais lue ni écrite hors commentaires).
- Documenter le protocole d'échange en tête du module.

### Commonalisation avec d'autres fichiers

- `TriCpt` utilise un autre protocole pour le même besoin : il écrit `Bsel`/`Bval` sur la fenêtre
  appelante par `Object.SetProperty` (voir `Plancomptable`). À terme (réarchitecture, hors rework
  autonome), `TriEcritures` pourrait adopter ce protocole ou exposer ses propres propriétés
  publiques (`Bsel`, `Numero`, `Libelle`, `Journal`) lues par l'appelant sur l'instance, ce qui
  supprimerait ce module. Appelants à mettre à jour dans le même commit : `Saisecrit`, `Tresor`,
  `TriEcritures`, et `TriEcritures2`/`TresorFac` s'ils ne sont pas supprimés auparavant.

### Réduction de portée

- Sans objet (variables de module, toutes utilisées sauf `sdesg`).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
