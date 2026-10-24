# BalanceM — Architecture

> Source : `.src/Compta/Impressions/BalanceM.module`

## Vue d'ensemble

`BalanceM` est le **module d'impression PDF des balances**, appelé uniquement par
[`Balance.Button1_Click`](../Balance.class/architecture.md). Il a été extrait de `Balance.class`
(commit `9c368c25` « Separation impression balance et comptes ») ; ce n'est pas une classe
`Inherits PdfWriter` : le rendu est délégué à une instance de **`Cbalances`** (`.src/Reports/`,
`Inherits PdfWriter`, méthodes `Entete`, `Level0` … `Level4a`, `BasPage`), dont il pilote la
position verticale `PosY`.

Le module garde **tout son état en variables `Private` de module** (43 variables : cumuls de compte,
de classe, de balance, position, titre). Ces variables persistent d'un appel à l'autre : seules
certaines sont remises à zéro en fin d'impression (voir `Imprime` et `Raz`).

Mise en page (A4 portrait, `~/tmp/Balance.pdf`, ouvert par `Visualiseur.Prog`) :

| Élément | Méthode `Cbalances` | Quand |
|---|---|---|
| Bandeau de page | `Entete(titre)` | 1re page : « Impression de la balance <nom> » ; pages suivantes : « Impression des balances » |
| Titre, période, société | `Level0("Balance  " & nom, "du … au …", "Societe  <int_sc>")` | chaque page |
| En-tête de colonnes | `Level1` (avec cumuls hors période) / `Level1a` (sans) | chaque page |
| Ligne de compte | `Level2` (9 montants) / `Level2a` (débit, crédit) | chaque compte imprimé |
| Total de classe | `Level3` / `Level3a` | changement de 1er chiffre (balance générale) et en fin |
| Total de la balance | `Level4` / `Level4a` | fin |
| Pied de page | `BasPage` | saut de page dans `Bas_page` et en fin |

Nature globale : **mixte** (SQL + calcul + rendu PDF + accès au formulaire `Balance`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebHP` | var | Private | oui | Float | 3 |
| `CredHP` | var | Private | oui | Float | 4 |
| `TotSldHP` | var | Private | oui | Float | 5 |
| `TotDeb` | var | Private | oui | Float | 6 |
| `TotCred` | var | Private | oui | Float | 7 |
| `TotSld` | var | Private | oui | Float | 8 |
| `debit` | var | Private | oui | Float | 9 |
| `credit` | var | Private | oui | Float | 10 |
| `solde` | var | Private | oui | Float | 11 |
| `Totbaldeb` | var | Private | oui | Float | 12 |
| `Totbalcred` | var | Private | oui | Float | 13 |
| `Totbalsld` | var | Private | oui | Float | 14 |
| `dte` | var | Private | oui | String | 15 |
| `Filename` | var | Private | oui | String | 16 |
| `Tab0` | var | Private | oui | String | 17 |
| `Nom` | var | Private | oui | String | 18 |
| `Compt` | var | Private | oui | String | 19 |
| `Debclass` | var | Private | oui | Float | 20 |
| `Credclass` | var | Private | oui | Float | 21 |
| `Sldclass` | var | Private | oui | Float | 22 |
| `TotDeb2` | var | Private | oui | Float | 23 |
| `TotCred2` | var | Private | oui | Float | 24 |
| `TotSld2` | var | Private | oui | Float | 25 |
| `Debclasshp` | var | Private | oui | Float | 26 |
| `Credclasshp` | var | Private | oui | Float | 27 |
| `Sldclassdeb` | var | Private | oui | Float | 28 |
| `Sldclasscred` | var | Private | oui | Float | 29 |
| `Totdebclass` | var | Private | oui | Float | 30 |
| `Totcredclass` | var | Private | oui | Float | 31 |
| `Totbaldebhp` | var | Private | oui | Float | 32 |
| `Totbalcredhp` | var | Private | oui | Float | 33 |
| `sldbaldeb` | var | Private | oui | Float | 34 |
| `sldbalcred` | var | Private | oui | Float | 35 |
| `Sldbal` | var | Private | oui | Float | 36 |
| `Clas` | var | Private | oui | String | 37 |
| `p` | var | Private | oui | Integer | 38 |
| `PosY` | var | Private | oui | Integer | 39 |
| `PosX` | var | Private | oui | Integer | 40 |
| `Nbpage` | var | Private | oui | Integer | 41 |
| `Ste` | var | Private | oui | String | 42 |
| `dateedition` | var | Private | oui | String | 43 |
| `pdf` | var | Private | oui | Cbalances | 44 |
| `Impcumul` | var | Private | oui | Boolean | 45 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Imprime` | 50-259 | Public | 30 | 207 | 1 |  |
| `Bas_page` | 261-279 | Public | 3 | 17 | 0 | portée réductible ? |
| `Classe` | 285-325 | Public | 6 | 39 | 0 | portée réductible ? |
| `Classe2` | 330-364 | Public | 4 | 33 | 0 | portée réductible ? |
| `Raz` | 369-386 | Public | 1 | 16 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Imprime(cpt, cpt2, Type, Type2, dteN0, dteN1, Impcumule, Impc, sTab0, snom, typecl As TypeClient)`**
  (CC 30, 207 LOC) [portée : nécessaire, appelée par `Balance.Button1_Click`] [nature : mixte].
  1. Initialise le titre (`dateedition = "du <dteN0> au <dteN1>"`), crée `Cbalances`, lance un
     `Shell "cd ~"` sans effet, met `Balance.Mouse = Wait` (auto-instance du formulaire).
  2. `SELECT * FROM Fiches_Societes WHERE cd_sc = Start.Societe` → `Ste`.
  3. Liste des comptes (`Cbase.Table("TabComptes")`, plage `cast(compte_cc as char)`,
     `type_cc = Type or Type2`) ; si `typecl.where` est non vide **et** `Type = "C"`, jointure
     `,Fiches_Cli WHERE cli_code = compte_cc AND <where>` (table `Fiches_Cli` en dur ; l'expression
     `String And Boolean` repose sur la conversion implicite de la chaîne, à confirmer par
     BALANCEM-T06).
  4. Pour chaque compte : la requête `SELECT * FROM <Tab0> WHERE compte = &1 and validee = 1 order by
     dte` est émise **deux fois** (l. 102 et 106, la première est inutile). Le test l. 103 porte sur
     `rrResult.count` (liste des comptes, toujours > 0) au lieu de `rResult.count` : la branche
     `Else` (l. 182-191, comptes sans écriture) est **inatteignable** (anomalie BALANCEM-A01).
     - Balance générale (`Type <> "C" And Type2 <> "F"`) : `Classe()` imprime le total de la classe
       précédente quand le 1er chiffre du compte change.
     - Toutes les écritures du compte sont lues ; celles comprises entre `dteN0` et `dteN1`
       (`Cdate_Comp` vs `Cdate_Dbase`, comparaison `aaaammjj`) alimentent `TotDeb`/`TotCred`, **toutes
       les autres**, antérieures **et postérieures** à la période, alimentent `DebHP`/`CredHP`
       (« hors période », anomalie BALANCEM-A02).
     - Solde final ventilé en `totdeb2` (solde débiteur) ou `totcred2` (solde créditeur) ;
       montants nuls affichés vides (`Format$(Val(Str(x)), ",0.00")`).
     - Le compte est imprimé si débit ou crédit de période non nul, ou si `Impc` ; `Level2` ou
       `Level2a` selon `Impcumul`, puis `PosY += 5` et `Bas_page()`.
     - Cumuls de classe (`Debclass`, `Credclass`, `Debclasshp`, `Credclasshp`, `Sldclassdeb`,
       `Sldclasscred`, `Sldclass`) et de balance (`totbaldeb`, `totbalcred`, `totbaldebhp`,
       `totbalcredhp`). `Totdebclass`/`Totcredclass` sont calculés mais jamais imprimés.
  5. Fin : libellé de classe (« Client », « Fournisseur », ou dernier chiffre de classe en balance
     générale), `Level3`/`Level3a`, `Level4`/`Level4a`, remise à zéro de la plupart des cumuls
     (`totbaldeb` et `Debclass` deux fois), `BasPage`, `Output`, `Visualiseur.Prog`.
  6. Aucun compte : son + « Aucune ecriture pour cette demande ». `Catch` : son + `Message.Error`.
  ⚠️ `PosY` n'est pas remis à 26 en début d'appel : il l'est par la première séquence d'en-tête ;
  `p`, `p1`, `PosX`, `Nbpage`, `solde`, `dte`, `totbalsld`, `Sldbal` partiel… sont des restes.
- **`Bas_page()`** [portée : réductible] [nature : GUI/PDF]. Si `PosY >= 268` : `BasPage`, nouvelle
  page « Impression des balances », `Level0`, `Level1`/`Level1a`, `PosY = 35`.
- **`Classe()`** [portée : réductible] [nature : mixte]. Rupture sur le 1er chiffre du compte. Avant
  d'imprimer le total, saut de page si `PosY >= 274` **sans** `BasPage` (page sans pied de page,
  anomalie BALANCEM-A03) ; puis `Level3`/`Level3a`, `PosY += 8`, remise à zéro des cumuls de classe.
- **`Classe2()`** [portée : réductible] — **code mort** (aucun appel ; variante « comptes tiers » de
  `Classe` ; utilise `Format$(…, "0.00")` sans séparateur de milliers pour `Sldclasscred`).
- **`Raz()`** [portée : réductible] [nature : calcul]. Remet à zéro les cumuls du compte courant.

## État global utilisé

- `Utils.db`, `Cbase.Table("TabSoc" | "TabComptes")`, `Fiches_Cli` en dur, table d'écritures reçue
  en paramètre (`sTab0`, `Fiches_Mvt` … `Fiches_Mvt5`).
- `Utils.Cdate_Comp`, `Cdate_Dbase`, `CDate_Aff` ; `Start.Societe`, `Start.son` ; `Music`.
- **`Balance.Mouse`** : accès à l'auto-instance du formulaire appelant (couplage GUI).
- `TypeClient.where` (contrôle passé en paramètre) ; `Visualiseur.Prog` ; `Cbalances`.
- Fichier `~/tmp/Balance.pdf` (le répertoire `~/tmp` doit exister).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la requête dupliquée l. 102 (SQL modifié : une requête de moins par compte, dump
  identique) et la branche `Else` inatteignable l. 182-191.
- Regrouper les 4 séquences d'en-tête de page (début d'`Imprime`, `Bas_page`, `Classe`, `Classe2`)
  dans un helper privé `EntetePage(titre As String)`, en gardant les deux titres actuels et
  l'absence de `BasPage` dans `Classe` (comportement figé tant que A03 n'est pas tranchée).
- Helper privé `MontantOuVide(x As Float) As String` pour les 4 conversions `Str`/`Val`/`Format$`.
- Extraire de la boucle un calcul pur `CumulCompte(compte, tab0, d0, d1) As Float[]` (débit, crédit,
  débit HP, crédit HP), puis une fonction de rendu par compte : la boucle principale passe de CC 30 à
  moins de 10.
- À terme (après décision sur A02), le cumul peut être fait par
  `SUM(CASE WHEN dte BETWEEN … THEN montantd END)` … `GROUP BY compte` en une seule requête
  (SQL modifié, dump identique).

### Commonalisation avec d'autres fichiers

- [`EditcompteM`](../EditcompteM.module/architecture.md) suit le même schéma (module d'impression
  appelé par un écran, état en variables de module, en-tête de page répété, `Raz`, accès à
  l'auto-instance du formulaire, `Shell "cd"`) : 78 lignes communes en séquence. Un socle commun
  « édition PDF paginée » (classe de base ou helper : `PosY`, seuil de saut, rappel de l'en-tête,
  pied de page) servirait aussi à `EditcompteA`, `JournauxM`, `FTVA` (qui utilise aussi
  `Cbalances`).
- `Raz` est identique à [`Balance.Raz`](../Balance.class/architecture.md) (14 lignes) : il disparaît
  si l'export de `Balance` réutilise `CumulCompte`.
- Nom de société : voir `Utils.NomSociete()` proposé dans Balance.

### Réduction de portée

- `Bas_page`, `Classe`, `Raz` → `Private` ; `Classe2` supprimé (code mort). Aucun appelant externe
  (vérifié par `grep -rn "BalanceM\."` : seul `Imprime` est appelé).

### Séparation traitement / GUI

- `Balance.Mouse` (l. 78, 251, 257) : déplacer la gestion du curseur dans `Balance.Button1_Click`
  (même rendu), ce qui supprime la dépendance du module envers l'auto-instance.
- Passer `typecl.where` (chaîne) au lieu du contrôle `TypeClient` (signature `Public` modifiée,
  appelant unique `Balance.Button1_Click`).
- `Message`/`Music.Play` : renvoyer un booléen « rien à imprimer » et laisser l'écran afficher le
  message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Même remarque que pour `Balance` : `compte_cc` numérique comparé par `cast(… as char)` ; écritures
  réparties en 6 tables. Un index `(compte, validee, dte)` sur `Fiches_Mvt*` accélérerait la lecture
  par compte (l'index actuel `idx_compte` est `(compte, dte)`).
