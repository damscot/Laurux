# Zebra — Architecture

> Source : `.src/Gestion/Etiquettes/Zebra.module`

## Vue d'ensemble

Module d'une seule procédure, `Gondole1`, qui envoie directement sur un `Socket` TCP (port 9100,
« raw printing ») une étiquette de gondole au format **ZPL** pour imprimante Zebra 203 dpi
(largeur 384 points ≈ 48 mm, longueur 256 points ≈ 32 mm).

Les appelants (`EtiqPromo`, `Etiqart`, `Etigond`, `Etiqcasier`) ne l'invoquent que dans une
branche `If ConnZbr = True`. Or `ConnZbr` n'est mis à vrai que par la méthode `Connect` de chacun
de ces écrans, et **`Connect` n'est jamais appelée** (`deps.py` : `unused`, confirmé par grep) ; la
variable `IpZebra` des écrans n'est jamais renseignée (le paramètre `/Soc<XX>/IpZebra` saisi dans
`Prefs` n'est lu nulle part ailleurs). La sortie Zebra est donc **inatteignable** dans l'état
actuel : `Gondole1` est du code mort par transitivité (voir ZEBRA-A01).

Nature : **calcul + E/S réseau**, sans accès à la base ni à la GUI.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Gondole1` | 4-24 | Public | 1 | 19 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Gondole1(Mysock As Socket, barcode, Pvttc, Intitule, Code, ttc, Casier, Kgl, Cfourn)`**
  [portée : nécessaire (4 écrans)] [nature : calcul + E/S]. Écrit 17 fragments par `Write #Mysock`
  (pas de séparateur de ligne) :

  | Commande | Rôle | Donnée |
  |---|---|---|
  | `^XA~TA0~JSO^LT0^MMT^MNW^MTT^PON^PMN^LH0,0^JMA^PR2,2^MD0^JUS^LRN^CI0^XZ` | configuration, sauvegardée (`^JUS`) à chaque étiquette | — |
  | `^XA^LL0256` / `^PW384` | début d'étiquette, longueur, largeur | — |
  | `^BY2,3,63^FT52,141^BCN,,Y,N` + `^FD>;…>63^FS` | Code 128 (sous-ensemble C `>;`, puis `>6` = passage en sous-ensemble B suivi du caractère `3`) | `barcode` |
  | `^FT6,180…^FD` | prix au kg/l | `Kgl` |
  | `^FT250,180…^FD` | référence fournisseur | `Cfourn` |
  | `^FT10,255^A0N,70,40…` | prix (grand corps) | `Pvttc` |
  | `^FT306,28…` | casier | `Casier` |
  | `^FT306,255…` | mention « HT »/« TTC » | `ttc` |
  | `^FT6,62…` | intitulé, via `Utils.Remplace` | `Intitule` |
  | `^FT4,28…` | code article | `Code` |
  | `^PQ1,0,1,Y^XZ` | une copie, fin d'étiquette | — |

  Points relevés (à confirmer avec le matériel) :
  - le suffixe `>63` ajoute vraisemblablement un caractère `3` imprimé après le code-barres ;
  - `^CI0` (jeu de caractères US) alors que les intitulés sont en UTF-8 : les accents sortent mal ;
    `Utils.Remplace` ne traite que `"`, `&` et le saut de ligne (la fonction voisine
    `Utils.Replace` convertit les accents en CP850) ;
  - `^FH` active l'échappement hexadécimal avec `_` : un `_` dans une donnée est interprété ;
    `^` et `~` ne sont pas échappés non plus (ZEBRA-A02) ;
  - les fragments `^FO,52^FS`, `^FO,37^FS`… sont des champs vides sans effet visible ;
  - aucune gestion d'erreur d'écriture : une socket fermée lève une erreur chez l'appelant.

## État global utilisé

- `Utils.Remplace`.
- Paramètres non lus mais liés : `/Soc<XX>/Impetiq = "2- Zebra"` (coche le RadioButton `Zbra` des
  écrans) et `/Soc<XX>/IpZebra` (saisi dans `Prefs`, jamais lu).

## Propositions d'amélioration

### Réécriture / refactorisation

- Séparer la construction du flux de l'écriture : fonction pure `Gondole1Zpl(…) As String`
  (testable sans socket), puis `Gondole1` = `Write #Mysock, Gondole1Zpl(…)` ; flux identique octet
  par octet (ZEBRA-002).
- Documenter les coordonnées et la signification de chaque commande ZPL (ZEBRA-001).

### Commonalisation avec d'autres fichiers

- [`Dymo.module`](../Dymo.module/architecture.md) en est une copie exacte, jamais appelée
  (DYMO-001 : suppression).
- La connexion (`Connect`, `IpZebra`, `ConnZbr`, `MySock`) est dupliquée à l'identique dans
  [`EtiqPromo`](../EtiqPromo.class/architecture.md), [`Etiqart`](../Etiqart.class/architecture.md),
  [`Etigond`](../Etigond.class/architecture.md) et [`Etiqcasier`](../Etiqcasier.class/architecture.md) :
  si ZEBRA-A01 est tranchée en faveur du branchement, elle doit migrer ici (`Zebra.Connecte(ip) As
  Socket`) ; si elle est tranchée en faveur de la suppression, ce module et les quatre copies
  disparaissent ensemble.

### Réduction de portée

- Sans objet (module, `Gondole1` appelée de l'extérieur).

### Séparation traitement / GUI

- Pas de GUI. Seule séparation utile : calcul du flux / écriture réseau (ZEBRA-002).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base. Les dimensions ZPL (`^LL`, `^PW`, positions) pourraient venir
  de `Fiches_Etiquettes` (une ligne « Zebra ») au lieu d'être codées en dur.
