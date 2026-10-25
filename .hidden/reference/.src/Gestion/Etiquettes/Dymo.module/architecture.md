# Dymo — Architecture

> Source : `.src/Gestion/Etiquettes/Dymo.module`

## Vue d'ensemble

Module d'une seule procédure, `Gondole1`, qui écrit sur un `Socket` un flux **ZPL** (langage des
imprimantes Zebra) décrivant une étiquette de gondole : code-barres Code 128, prix, intitulé, code
article, casier, prix au kilo/litre et référence fournisseur.

Le module est une **copie exacte** de [`Zebra.module`](../Zebra.module/architecture.md) (seule une
ligne de commentaire vide diffère, mesure `diff`). Il n'est appelé nulle part : les écrans
d'étiquettes appellent `Zebra.Gondole1`, et le nom `Dymo` y désigne le **RadioButton** `Dymo` du
`.form` (choix de l'imprimante Dymo, qui produit un PDF au format `dymog`/`dymoc` via
`CEtiquettes`, et non du ZPL). Une imprimante Dymo ne comprend d'ailleurs pas le ZPL.

Nature globale : **code mort**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Gondole1` | 3-23 | Public | 1 | 19 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Gondole1(Mysock, barcode, Pvttc, Intitule, Code, ttc, Casier, Kgl, Cfourn)`** [portée :
  réductible (aucun appelant)] [nature : calcul, E/S réseau]. Écrit 17 commandes ZPL par `Write #`
  (sans fin de ligne) : configuration (`^XA~TA0~JSO…^XZ`), longueur/largeur d'étiquette
  (`^LL0256`, `^PW384`), code-barres `^BCN` avec le préfixe `>;` (Code 128 sous-ensemble C) et le
  suffixe `>6`, puis les zones texte `^FD…^FS`. L'intitulé passe par `Utils.Remplace` (guillemet →
  `''`, `&` → `et`, saut de ligne supprimé). Aucun accès à la base ; aucune gestion d'erreur
  d'écriture. Comportement strictement identique à `Zebra.Gondole1` (voir ce document pour le
  détail du flux et ses défauts).

## État global utilisé

- `Utils.Remplace`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : le module est à supprimer.

### Commonalisation avec d'autres fichiers

- Doublon intégral de [`Zebra.Gondole1`](../Zebra.module/architecture.md) : la suppression de
  `Dymo.module` est la commonalisation.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
