# EdReg — Architecture

> Source : `.src/Gestion/Impressions/EdReg.class` (+ `EdReg.report`, état gb.report)

## Vue d'ensemble

`EdReg` est un **état gb.report** (fichier `EdReg.report`, pas de `.form`) : le **bordereau des
règlements clients** saisis dans [`SaiReg`](../../Facturation/SaiReg.class/architecture.md). Il
est instancié par `SaiReg.editions_Click` (`EdReg.ajout` : seulement les règlements ajoutés) et
`SaiReg.editionb_Click` (`EdReg.tous` : tous sauf les supprimés), puis imprimé dans
`~/tmp/Bordereau.pdf` par `ed.Print(imp)` et affiché par `Visualiseur.Prog`.

Le constructeur prépare les en-têtes (société, utilisateur, numéro de bordereau saisi par
`InputBox`, mode de règlement, date du jour) et copie dans un `VarEcr` privé (`$ediecr`) les
écritures retenues. La bande répétée `ligne` (`DataCount = $ediecr.nb()`) est remplie par les
événements `Data` des quatre `ReportLabel` (`dte`, `cde`, `nom`, `montant`).

Nature : **mixte** (une requête SQL, sélection d'écritures, GUI `InputBox`, mise en forme).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `tous` | enum | Public | oui |  | 3 |
| `ajout` | enum | Public | oui |  | 3 |
| `$ediecr` | var | Private |  | New VarEcr | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-39 | Public | 10 | 29 | 0 | méthode spéciale |
| `dte_Data` | 41-50 | Public | 3 | 7 | 0 | handler GUI |
| `cde_Data` | 52-61 | Public | 3 | 7 | 0 | handler GUI |
| `nom_Data` | 63-72 | Public | 3 | 7 | 0 | handler GUI |
| `montant_Data` | 74-83 | Public | 3 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Lecr As VarEcr, choix As Integer, resreg As Result)`** (CC 10) [portée : nécessaire,
  appelé par `SaiReg`] [nature : mixte].
  - Couleur de fond des bandes `ReportHBox1`/`ReportHBox3` : `Val("&H" & Hex(Start.R) &
    Hex(Start.G) & Hex(Start.B))`, expression dupliquée. ⚠️ `Hex` ne complète pas à deux chiffres :
    une composante < 16 décale les autres (couleur fausse, EDREG-A02).
  - SQL : `SELECT * FROM Fiches_Societes` **sans `WHERE`** (nom en dur, clé Cbase `TabSoc`) : en
    multi-société, c'est la première ligne qui est imprimée, pas `Start.Societe` (EDREG-A01).
  - `qui` = `User.Name` ; si `choix = tous`, `InputBox` du numéro de bordereau (vide si annulé).
  - `bdx` = `resreg!code & " " & resreg!libel` (mode de règlement, sans test `Available`).
  - Sélection : `ajout` → écritures `etat = L_ajou` ; `tous` → toutes sauf `L_sup`. Les écritures
    collectives éventuelles sont comptées dans `nbch` mais exclues de `somme()` (à confirmer :
    `SaiReg` ne semble pas en placer dans `$Lecr`).
  - `nbch` = nombre de lignes, `tot` = `-somme()` formaté `0.00`.
- **`dte_Data`, `cde_Data`, `nom_Data`, `montant_Data(Index)`** [portée : nécessaire — **handlers**
  de l'événement `Data` des `ReportLabel` du `.report`] [nature : GUI]. Chacun lit
  `$ediecr.trouve(Index)` (renvoie `-1` Integer si absent → sortie), écrit la donnée (date `.L`,
  compte, intitulé, `montantc - montantd` en `0.00`) et alterne la police (italique une ligne sur
  deux). Les quatre corps sont identiques à la donnée près.
  `deps.py` les classe `unused` et « portée réductible » : **faux positif**, l'outil ne lit pas
  les fichiers `.report` ; ces handlers doivent rester `Public`.

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (couleurs du thème), `User.Name`.
- `VarEcr.L_ajou`, `VarEcr.L_sup` ; `LDate(Now).L`.
- Aucun `Utils.Observers` : un état gb.report n'est pas un écran rejouable ; il est couvert par
  le replay de `SaiReg`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Calculer la couleur une seule fois (variable locale), même expression (EDREG-002).
- Factoriser les quatre handlers `_Data` autour d'un helper privé `Ligne(Index) As VarEcr` et
  `Police(Index)` ; les handlers restent `Public` avec leur nom (EDREG-003).

### Commonalisation avec d'autres fichiers

- En-tête société : la ligne « type + intitulé » relève de l'en-tête société commun proposé
  `Creleve.EnteteSociete` (LIGCLI-004, voir [Ligcli](../../../Compta/Relances/Ligcli.class/architecture.md)) ;
  ici seule la raison sociale est utile, un accesseur `RaisonSociale()` suffirait.
- Couleur de thème `Start.R/G/B` → `Color` : même calcul dans d'autres états (à recenser avec le
  lot `Reports`).

### Réduction de portée

- Aucune : `_new` est appelé par `SaiReg`, les `_Data` sont des handlers.

### Séparation traitement / GUI

- Extraire la sélection des écritures (`Selection(Lecr, choix) As VarEcr`) et la lecture société
  (`RaisonSociale()`) du constructeur ; `InputBox` reste dans `_new` (EDREG-004).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce fichier.
