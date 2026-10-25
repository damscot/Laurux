# Einvmat — Architecture

> Source : `.src/Gestion/option/Einvmat.class` (+ `Einvmat.report`)

## Vue d'ensemble

**État `gb.report`** de la déclaration mensuelle de la comptabilité matières (option boissons)
pour les régies en **droits acquittés** (`suspendu = False`). Il est instancié par
[Caleditcmat](../Caleditcmat.class/architecture.md)`.Edit` (`Caleditcmat.class:431`,
`New Einvmat(tabl, mois, annee, False)`) quand l'option « Acquitté » est choisie ; la variante
« Suspendu » est [Ecomptamat](../Ecomptamat.class/architecture.md).

Entrée : une `Collection` de structures `Caleditcmat.Declaration`, indexée par code régie, déjà
calculée par `Caleditcmat.Edit` (volumes effectif `vae` et d'alcool pur `vap` : début de
période, entrées, sorties, fin de période). Le report ne recalcule rien : il formate chaque volume
en **hectolitres / litres / centilitres** (`convers`) dans des `ReportLabel` dont l'événement
`Data` est traité ici (une ligne `ReportHlig` par régie, `DataCount` = nombre de régies), puis
imprime une ligne de totaux (`*2_Data`).

Tables lues : `Fiches_Societes` (en-tête), `Fiches_Parametres` (`arrete`, exercice),
`Fiches_regie` (libellé de chaque régie). Aucune écriture, et **aucune écriture comptable** : ce
n'est pas un module complexe. Aucune table `*M` du matériel n'est concernée (« mat » = matières).

Nature : **GUI** (report) avec un calcul de formatage (`convers`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$resreg` | var | Private |  | Result | 5 |
| `$snumed` | var | Private |  | String[] | 6 |
| `$tabl` | var | Private |  | Collection | 7 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-48 | Public | 3 | 34 | 0 | méthode spéciale |
| `lib_Data` | 50-57 | Public | 1 | 5 | 0 | handler GUI |
| `vaehldp_Data` | 60-65 | Public | 1 | 4 | 0 | handler GUI |
| `vaeldp_Data` | 67-72 | Public | 1 | 4 | 0 | handler GUI |
| `vaecldp_Data` | 74-79 | Public | 1 | 4 | 0 | handler GUI |
| `vaehle_Data` | 82-87 | Public | 1 | 4 | 0 | handler GUI |
| `vaele_Data` | 89-94 | Public | 1 | 4 | 0 | handler GUI |
| `vaecle_Data` | 96-101 | Public | 1 | 4 | 0 | handler GUI |
| `vaehls_Data` | 104-109 | Public | 1 | 4 | 0 | handler GUI |
| `vaels_Data` | 111-116 | Public | 1 | 4 | 0 | handler GUI |
| `vaecls_Data` | 118-123 | Public | 1 | 4 | 0 | handler GUI |
| `vaehlfp_Data` | 126-131 | Public | 1 | 4 | 0 | handler GUI |
| `vaelfp_Data` | 133-138 | Public | 1 | 4 | 0 | handler GUI |
| `vaeclfp_Data` | 140-145 | Public | 1 | 4 | 0 | handler GUI |
| `vaphldp_Data` | 148-153 | Public | 1 | 4 | 0 | handler GUI |
| `vapldp_Data` | 155-160 | Public | 1 | 4 | 0 | handler GUI |
| `vapcldp_Data` | 162-167 | Public | 1 | 4 | 0 | handler GUI |
| `vaphle_Data` | 170-175 | Public | 1 | 4 | 0 | handler GUI |
| `vaple_Data` | 177-182 | Public | 1 | 4 | 0 | handler GUI |
| `vapcle_Data` | 184-189 | Public | 1 | 4 | 0 | handler GUI |
| `vaphls_Data` | 192-197 | Public | 1 | 4 | 0 | handler GUI |
| `vapls_Data` | 199-204 | Public | 1 | 4 | 0 | handler GUI |
| `vapcls_Data` | 206-211 | Public | 1 | 4 | 0 | handler GUI |
| `vaphlfp_Data` | 214-219 | Public | 1 | 4 | 0 | handler GUI |
| `vaplfp_Data` | 221-226 | Public | 1 | 4 | 0 | handler GUI |
| `vapclfp_Data` | 228-233 | Public | 1 | 4 | 0 | handler GUI |
| `vaehldp2_Data` | 235-248 | Public | 2 | 10 | 0 | handler GUI |
| `vaehle2_Data` | 250-263 | Public | 2 | 10 | 0 | handler GUI |
| `vaehls2_Data` | 265-278 | Public | 2 | 10 | 0 | handler GUI |
| `vaehlfp2_Data` | 280-293 | Public | 2 | 10 | 0 | handler GUI |
| `vaphldp2_Data` | 295-308 | Public | 2 | 10 | 0 | handler GUI |
| `vaphle2_Data` | 310-323 | Public | 2 | 10 | 0 | handler GUI |
| `vaphls2_Data` | 325-338 | Public | 2 | 10 | 0 | handler GUI |
| `vaphlfp2_Data` | 340-353 | Public | 2 | 10 | 0 | handler GUI |
| `convers` | 355-382 | Private | 6 | 26 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(tabl, mois, anne, edit)`** [portée : nécessaire (constructeur, appelé par Caleditcmat)]
  [nature : mixte] : mémorise `tabl` et la liste de ses clés (`$snumed`), fixe
  `ReportHlig.DataCount` ; dates du jour ; **`SELECT * FROM Fiches_Societes` sans `WHERE`** : en
  multi-sociétés, c'est la première société de la table qui est imprimée, pas `Start.Societe`
  (EINVMAT-A02) ; `SELECT * FROM Fiches_Parametres` : si `arrete` est renseigné, exercice du mois
  suivant l'arrêté sur 12 mois (`Left(arrete,2)` = mois, `Right(arrete,4)` = année) ; adresse,
  n° d'identification (`ident`) ; période déclarée (`mois/anne`). Le paramètre `edit` est
  **inutilisé** ; les variables `i`, `res` et le membre `$resreg` aussi. Termine par
  `Application.Busy = 0` (remise à zéro brutale, qui masque le compteur de l'appelant).
- **`lib_Data(Index)`** [handler `Data` d'un contrôle du `.report`] : `SELECT * FROM Fiches_regie
  WHERE code=&1` → nom de la régie.
- **24 handlers `va{e,p}{h,l,c}l{dp,e,s,fp}_Data(Index)`** [handler `Data`] [nature : GUI] :
  chacun recopie `$tabl[$snumed[Index]]` dans **`Caleditcmat.ddcl`** (membre `Public` du
  formulaire Caleditcmat, auto-instance affichée en modal) puis écrit
  `convers(<volume>, "h"|"l"|"c")`. Corps identiques à un champ près, et identiques aux 24 mêmes
  handlers d'`Ecomptamat`.
- **8 handlers `va{e,p}h{ldp,le,ls,lfp}2_Data(Index)`** [handler `Data`] [nature : mixte] : somme
  du volume sur toutes les régies et écriture des trois cellules (hl dans `.Data`, l et cl dans
  `.Text` des contrôles voisins).
- **`convers(vol, choix)`** [Private] [nature : calcul] : `"h"` → `Fix(vol/100)` ;
  `"l"` → litres restants (sur la valeur absolue si `|vol| ≥ 100`) ; `"c"` → centilitres après
  `Round(vol, -2)`. Renvoie `"  "` pour 0. **Différence avec Ecomptamat** : ici l'arrondi au
  centilitre n'est appliqué qu'au cas `"c"`, donc 199,996 l s'imprime « 1 hl 99 l 0 cl » au lieu
  de « 2 hl 0 l 0 cl » (EINVMAT-A01) ; le signe est perdu sur les litres d'un volume négatif
  ≤ -100 (EINVMAT-A03).

`deps.py` signale les 33 handlers `*_Data` comme `unused`/`scope_reducible` et `convers` comme
`unused_transitive` : **faux positifs**, les contrôles (`lib`, `vaehldp`…) existent dans
`Einvmat.report`, que l'outil n'analyse pas. Ces handlers doivent rester `Public` avec leur nom.

## État global utilisé

- `Caleditcmat.ddcl` (écrit à chaque cellule : variable de travail globale déguisée).
- `Application.Busy` (mis à 0), `Utils.db.Exec`, `Utils.lastday`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer `Caleditcmat.ddcl` par une variable locale (`Dim dcl As Declaration = $tabl[…]`) :
  même valeur lue, plus de dépendance à l'auto-instance de Caleditcmat (préalable à la
  suppression de `ddcl`, CALEDITCMAT-005).
- Chaque handler `Data` se réduit à `Cellule(Index, "vae", "vdp", "h")` (fonction privée
  générique lisant le champ de la structure) ; les 8 handlers de totaux à
  `Total("vae", "vdp", hl, l, cl)`.
- Supprimer `$resreg`, `i`, `res`, le doublon de commentaire `' Gambas class file`.

### Commonalisation avec d'autres fichiers

- **[Ecomptamat](../Ecomptamat.class/architecture.md)** : `_new` (en-tête société et exercice,
  ~30 lignes), les 24 handlers de volumes, les 8 handlers de totaux et `convers` sont des copies
  (seule différence : l'arrondi initial de `convers`). Proposition : un module de l'option
  boissons (nom à arrêter en phase 3, par exemple `CmatEdition`) avec `EnteteDeclaration(report,
  mois, annee)`, `Convers(vol, choix, arrondiInitial)` et `Total(tabl, regime, champ)`. Les
  handlers restent dans chaque report (noms intouchables). `Convers` garde le paramètre
  `arrondiInitial` pour préserver le comportement des deux fichiers tant qu'EINVMAT-A01 n'est pas
  tranchée.
- **En-tête société** : `Creleve.EnteteSociete` proposé dans
  [Ligcli](../../../Compta/Relances/Ligcli.class/architecture.md) (LIGCLI-004) ; ici les champs
  sont `type_sc`, `int_sc`, `ident`, `burdis_sc`, `adr1_sc`, `adr2_sc`, `cp_sc`.
- **Exercice matières** depuis `arrete` : même calcul dans Ecomptamat, calcul différent dans
  [Visucmat](../Visucmat.class/architecture.md) (VISUCMAT-A02).

### Réduction de portée

Rien à réduire : `_new` est appelé par Caleditcmat ; les `*_Data` sont des handlers du report.

### Séparation traitement / GUI

`convers` est un calcul pur : déplacé dans le module commun en `Public`, il devient testable en
gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Parametres.arrete` en `DATE` ; n° d'identification d'entrepositaire (`ident`) par
  société dans une table dédiée de l'option.
