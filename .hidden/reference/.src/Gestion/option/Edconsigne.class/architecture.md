# Edconsigne — Architecture

> Source : `.src/Gestion/option/Edconsigne.class` · Formulaire : `Edconsigne.form`

## Vue d'ensemble

`Edconsigne` est l'**édition du suivi des consignes** (option boissons) : sur une période
(`Dateinf`/`Datesup`, par défaut du début d'exercice à aujourd'hui), elle liste les mouvements de
consignes (`Fiches_ligcons`) par code de consigne, par client ou par fournisseur, en détail ou en
cumul, avec ou sans valorisation, dans un état `Report` (gb.report) imprimé en PDF
(`~/tmp/consigne.pdf`) puis affiché par `Visualiseur.Prog`. Ouvert par `menuopt` (`suivcons_click`,
`Edconsigne.Show`).

Règle métier telle que le code l'applique :

- trois sources réunies par `UNION` : réceptions fournisseurs (`Fiches_ligcons.type = 'E'`, jointes
  à `Fiches_Ligrecpt`/`Fiches_Entrecpt`, date `ddate`), bons de livraison (`type <> 'E'`, joints à
  `Fiches_Ligbl`/`Fiches_Bl`, date `dte_ligbl`) et factures historisées (joints à
  `Fiches_HistoLigfac`/`Fiches_HistoFac`, date `dtligbl_ligfac`) ;
- quantités et montants affichés **avec le signe inversé** (`nb × −1`) : une quantité positive est
  affichée en colonne « Consignes », une négative (en valeur absolue) en « Déconsignes » ;
- mode « par code » : les trois sources ; « par client » : BL + factures avec bornes `cdclibl` /
  `cdclifac` ; « par fournisseur » : réceptions avec bornes `Fiches_Ligrecpt.four` ; bornes de codes
  de consigne `Textinf`/`Textsup` (défaut `00`/`ZZ`) dans tous les cas.

Nature globale : **édition (GUI) + SQL** de lecture.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$obs` | var | Private |  | Observer | 3 |
| `$rep` | var | Private |  | Report | 4 |
| `$coul` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 7-35 | Public | 1 | 19 | 0 | méthode spéciale |
| `dte_lostfocus` | 38-47 | Public | 2 | 8 | 0 | handler GUI |
| `Butedit_Click` | 49-126 | Public | 12 | 68 | 0 | handler GUI |
| `edition` | 128-273 | Private | 15 | 125 | 0 |  |
| `tcli` | 275-286 | Private | 2 | 9 | 0 |  |
| `tfou` | 288-299 | Private | 2 | 9 | 0 |  |
| `Butquit_Click` | 301-305 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire] [nature : GUI]. `Utils.Observers(Me)` ; observateurs `dte` sur
  les deux dates ; `Chainage` des 8 zones ; masques `TextReg` (clients `4…`/`411…`, fournisseurs
  `40…`/`401…`, codes de consigne sur 1-2 caractères) ; `$coul` calculé et jamais utilisé ;
  dates par défaut (`LDate.EDeb`).
- **`dte_lostfocus()`** [handler] [nature : GUI]. Date vide → ballon « Date invalide », focus,
  `Stop Event`.
- **`Butedit_Click()`** (CC 12) [handler] [nature : mixte, extractible : construction de la
  requête]. Construit `reqf` (réceptions), `reqcb` (BL), `reqcf` (factures) en détail ou en somme
  (`GROUP BY`), choisit les colonnes `cdclibl`/`cdclifac`/`four` selon le mode, exécute
  `Utils.db.Exec(req, dteinf.DT, dtesup.DT, Textinf, Textsup, Textcinf, Textcsup, Textfinf,
  Textfsup)` (8 paramètres `&1`…`&8`, chaque mode n'en utilise qu'une partie), puis `edition` et
  impression. Aucun message si la sélection est vide.
  ⚠️ **Jointure** `Fiches_consigne.code = Fiches_ligcons.code` dans les trois requêtes : selon
  `modfichier.fichierboisson`, `Fiches_ligcons.code` est l'**identifiant auto-incrémenté** et le
  code de consigne est `codecons` (utilisé partout ailleurs : `Consigne`, `Saisiedecons`,
  `fourconsdroi`). L'état rapproche donc des numéros de ligne et des codes de consigne (sous MySQL,
  conversion implicite `'01' = 1`) : résultats faux ou vides (EDCONSIGNE-A01, à confirmer sur une
  base réelle). La colonne affichée « code » est aussi `Fiches_ligcons.code` (l'identifiant).
  ⚠️ Jointures sans le numéro de ligne : chaque mouvement est répété autant de fois que le document
  a de lignes (`Fiches_ligcons.num = Fiches_Ligrecpt.numrecpt`, `num = num_ligbl`,
  `num = num_ligfac`), ce qui multiplie aussi les sommes (A02). ⚠️ En mode cumul, la requête BL
  ne filtre pas `type <> 'E'` (le détail le fait) (A03). ⚠️ Pas d'`ORDER BY` : en mode client ou
  fournisseur, les ruptures de `edition` (`cde <> res!cdclibl`) répètent l'en-tête de tiers.
- **`edition(res, dteinf, dtesup)`** (CC 15) [privée] [nature : GUI/édition]. Construit le `Report`
  (titre avec la période et les bornes, en-têtes, une ligne par résultat ; ruptures par client ou
  fournisseur via `tcli`/`tfou`).
- **`tcli(cde)`**, **`tfou(cde)`** [privées] [nature : calcul]. `SELECT cli_nom FROM Fiches_Cli WHERE
  cli_code = &1` / `SELECT fo_nom FROM Fiches_Four WHERE fo_code = &1` ; « Client inconnu » /
  « Fournisseur inconnu ».
- **`Butquit_Click()`** [handler] : `Me.Close`.

Les boutons `Butcli`, `Butclis`, `Butfou`, `Butcli4`, `But`, `Buts` du `.form` (recherche de
bornes) n'ont **aucun gestionnaire** : ils sont sans effet.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Start.R/G/B` (couleur inutilisée), `User.Home`, `Visualiseur.Prog`,
  `Chainage`, `LDate`.
- Tables : `Fiches_consigne`, `Fiches_ligcons` (créées par `modfichier`, absentes de
  `db_control.csv`), `Fiches_Ligrecpt`, `Fiches_Entrecpt`, `Fiches_Bl`, `Fiches_Ligbl`,
  `Fiches_HistoFac`, `Fiches_HistoLigfac`, `Fiches_Cli`, `Fiches_Four` (noms en dur).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Butedit_Click` : fonction privée `RequeteSuivi(mode, detail) As String` (texte SQL identique),
  séparée de l'exécution et de l'impression.
- Suppression de la variable `$coul` (calculée, jamais lue).
- `Cbase.Table` pour les tables qui ont une clé (`TabCli`, `TabFour`, `TabBl`, `TabLigbl`,
  `TabHisFac`, `TabHisLigFac`, `TabEntrecpt`, `TabLigrecpt`) : texte SQL identique.

### Commonalisation avec d'autres fichiers

- `tcli`/`tfou` : lecture de nom de tiers répétée dans le projet (candidat à une fonction utilitaire
  commune, phase 3).
- Construction de `Report` par code : même style que les éditions de `Impressions` (lot voisin).

### Réduction de portée

Aucune (handlers et `_new`).

### Séparation traitement / GUI

`RequeteSuivi` (texte SQL) et `tcli`/`tfou` sont déjà sans contrôle ; `edition` reste GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_ligcons` : remplacer `num`/`numlig`/`bloc` texte par des clés typées vers le document et
  sa ligne, ce qui permettrait des jointures exactes.
- Intégrer `Fiches_consigne`/`Fiches_ligcons` dans `db_control.csv`.
