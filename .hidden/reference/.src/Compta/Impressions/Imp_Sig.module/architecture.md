# Imp_Sig — Architecture

> Source : `.src/Compta/Impressions/Imp_Sig.module`

## Vue d'ensemble

`Imp_Sig` produit l'**édition PDF des soldes intermédiaires de gestion** (`~/tmp/SIG.pdf`, classe
`Csig`, format paysage) à partir des rubriques `S…` (`Fiches_Rubriques`, `Fiches_RubCompt`) et des
écritures d'un exercice. Appelé uniquement par [RubImp](../RubImp.class/architecture.md)
(`Button2_Click`, bouton radio « SIG ») via `Lancement(Detail, dteN0, dteN1, dte1, dte2, exercice)`.

Comme [Imp_Bilan](../Imp_Bilan.module/architecture.md), tout tient dans une fonction (442 lignes,
CC 60) en deux phases :

```
Fiches_Rubriques (S…) + Fiches_RubCompt + Fiches_Mvt<x> ──(C)──▶ centralisation (col1 = Σ crédit − débit par rubrique)
centralisation ──(D)──▶ Csig ──▶ ~/tmp/SIG.pdf
```

L'édition présente en vis-à-vis les produits (colonne gauche, rubriques `num = P`) et les charges
(colonne droite, autres valeurs de `num`), puis, après chaque rubrique d'entête `E`, un total et le
solde intermédiaire. La **chaîne des soldes** est codée en dur par numéro de rubrique, calée sur le
paramétrage de `Laurux01.sql` (49 rubriques `S`) :

| Rubrique | Rôle dans le code | Variable |
|---|---|---|
| `S0060` (E) | marge commerciale = charges + produits accumulés | `marge` |
| `S0105` (E) | production de l'exercice ; imprime ensuite « Production de l'exercice » et « Marge commerciale » | `prodexo`, `Valajout = prodexo + marge` |
| `S0130` (E) | valeur ajoutée (`Valajout + Σ charges`) | `Valajout` |
| `S0150` (L) | imprime « Valeur ajoutée » en tête de section | — |
| `S0180` (E) | excédent brut d'exploitation | `excexpl` |
| `S0200` (L) | imprime « Excédent brut d'exploitation » | — |
| `S0250` (E) | résultat d'exploitation | `resexpl` |
| `S0270` (L) | imprime « Résultat d'exploitation » | — |
| `S0310` (E) | résultat courant avant impôts | `rescour` |
| `S0350` (E) | résultat exceptionnel | `resexcept` |
| `S0360` (L) | imprime « Résultat courant avant impots » et, s'il est positif, « Résultat exceptionnel » | — |
| `S0380`, `S0410` (E) | calculent `resexo` et `plusmoins`, jamais imprimés | — |

Nature globale : **mixte** (SQL + calcul + PDF + `Message.Info`), sans accès à des contrôles.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dtes1` | var | Private | oui | String | 27 |
| `dtes2` | var | Private | oui | String | 28 |
| `Det` | var | Private | oui | String | 29 |
| `Filename` | var | Private | oui | String | 30 |
| `PosY` | var | Private | oui | Integer | 31 |
| `PosYdeb` | var | Private | oui | Integer | 32 |
| `Nbpage` | var | Private | oui | Integer | 33 |
| `Ste` | var | Private | oui | String | 34 |
| `dateedition` | var | Private | oui | String | 35 |
| `exo` | var | Private | oui | String | 36 |
| `pdf` | var | Private | oui | Csig | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Lancement` | 39-480 | Public | 60 | 389 | 1 |  |
| `Button1_Click` | 485-489 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### `Lancement(Detail, dteN0, dteN1, dte1, dte2, exercice)` — structure par blocs

[portée : nécessaire (appelée par `RubImp`)] [nature : mixte]. Seuls `dteN0`, `dteN1` et
`exercice` ont un effet ; `dte1`/`dte2` sont rangés dans `dtes1`/`dtes2` sans être relus et `Detail`
n'est transmis qu'à `Csig.Level0`, qui l'ignore. Aucune valeur N-1 n'est calculée.

| Bloc | Lignes | Rôle | SQL émis |
|---|---|---|---|
| A. Initialisation | 101-146 | choix de `Tab5` selon `exercice` (`Tab6` affectée mais inutilisée), nom de la société | `SELECT * FROM Fiches_Societes Where cd_sc = &1` |
| B. Table de travail | 149-161 | `DROP` + `CREATE centralisation` (`numrub`, `intitrub`, `type`, `detail`, `compte`, `intitcpt`, `col1`, `prod`, clé `numrub, compte`) | DDL |
| C. Centralisation | 171-243 | pour chaque rubrique `S` : insère (ou réinitialise) la ligne d'en-tête (`compte = "0"`, `col1 = 0`, `prod = num`) ; pour une rubrique `L`, pour chaque plage, lit **toutes** les écritures de la plage et de la période (sans filtre `validee`) et cumule `montantc − montantd` sur **la ligne de la rubrique** (la requête de contrôle ne filtre que sur `numrub` : `compte` et `intitcpt` prennent la valeur de la dernière écriture lue) ; le bloc « type `O` » (l.230-240) ne s'exécute jamais (`RubE` reste `"0"`) | par rubrique : `SELECT` + `INSERT`/`UPdate` ; par plage : `SELECT Tab5` ; par écriture : `SELECT` + `UPdate centralisation` |
| D. Impression | 248-477 | parcours de `centralisation` (`Order by numrub, detail, compte`) ; lignes `L` à détail `O` : produit (`prod = P`) à gauche avec cumul `TotP`, charge à droite (`posydeb`) avec cumul `TotA` ; comptes `709…` (produits) et `609…` (charges) changent de signe ; entêtes `E` : calcul de la chaîne des soldes (tableau ci-dessus), `level2` (totaux + solde), filets, saut de colonne/page (`Posy >= 162`/`186`) ; titres `T` : nouvelle page | `SELECT * FROM centralisation …` + 1 `SELECT intitule_cc FROM Cbase.Table("TabComptes")` par ligne |

Particularités relevées :
- les variables de la chaîne des soldes sont déclarées `String` (`Dim marge, prodexo, … As String`) :
  les additions `+` convertissent texte ↔ nombre à chaque étape (format de conversion Gambas non
  localisé) ; `Format$(…, "0")` arrondit à l'unité à l'affichage ;
- `Resultat` n'est jamais affecté : la branche « Bénéfice » de `S0310` (l.383-387) est morte ;
- `If Left$(compte, 3) = "709" Then Otot3 = "-" & otot3` : si `otot3` est déjà négatif, la chaîne
  `--x` ne se convertit pas en `Float` (erreur d'exécution probable, anomalie IMP_SIG-A02) ; le
  `609` utilise `* -1`, sans ce défaut ;
- le résultat exceptionnel négatif n'est pas imprimé (branche `Else` commentée, l.312-316) ;
- `Imp3`/`Imp4` (remis à 0 pour `S0400`), `Brub`, `resexo`, `plusmoins`, `Otot1`, `Ttot1`,
  `Etot2`/`Etot4`, `Stot*`, `Ltot1`, `cpt3`, `RubO`, `p` sont écrits mais jamais utilisés.

### `Button1_Click()`

[portée : réductible] [nature : GUI] — **code mort** (handler dans un module, aucun appel).

## État global utilisé

- `Start.Societe`, `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Dbase`, `Cbase.Table("TabComptes")`,
  `Visualiseur.Prog`, `User.Home`.
- Variables de module : `pdf`, `PosY`, `PosYdeb`, `Filename`, `Ste`, `exo`, `Det` utilisées ;
  `dtes1`, `dtes2`, `Nbpage`, `dateedition` écrites sans être lues.

## Propositions d'amélioration

### Réécriture / refactorisation (résultat identique)

- Découper `Lancement` en `CreeCentralisation()`, `Centralise(sTabMvt, sDeb, sFin)` et `Imprime()`,
  même SQL dans le même ordre.
- Impression : remplacer la cascade de `If Tab1Rslt!numrub = "S0…"` par deux tables privées
  (rubriques qui **calculent** un solde, rubriques qui **impriment** un solde avant leur ligne) et
  un `Select Case` ; les variables restent `String` et les expressions sont recopiées telles quelles
  pour conserver les conversions.
- Supprimer le bloc « type `O` » mort, la branche `Resultat`, les variables inutilisées, `Shell "cd …"`
  et les blocs commentés.

### Commonalisation avec d'autres fichiers

- Choix des tables Mvt par exercice et en-tête société : communs avec
  [Imp_Bilan](../Imp_Bilan.module/architecture.md) et [RubImp](../RubImp.class/architecture.md)
  (IMP_BILAN-003/004).
- Table de travail `centralisation` : helper `Utils.TableTravail` (voir Imp_Bilan).
- Parcours rubrique → plages → écritures : même double boucle que `Imp_Bilan` (blocs F/G) et
  `RubImp`.

### Réduction de portée

- `Button1_Click` supprimé ; variables de module `pdf`, `PosY`, `PosYdeb`, `Filename`, `Ste`, `exo`,
  `Det` → locales (pas d'état utile entre deux appels : chaque valeur est réaffectée avant lecture,
  à confirmer par T05).

### Séparation traitement / GUI

- `Lancement` renvoie le chemin du PDF ou `""` ; `RubImp` gère `Message.Info` et le visualiseur
  (comme IMP_BILAN-010).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La chaîne des soldes dépend des numéros de rubrique en dur : une colonne « rôle SIG » dans
  `Fiches_Rubriques` permettrait de renuméroter le paramétrage sans casser l'édition.
- `centralisation` en table temporaire de connexion (voir Imp_Bilan).
- Agrégat `SUM(montantc - montantd)` par plage côté base au lieu d'un `UPdate` par écriture.
