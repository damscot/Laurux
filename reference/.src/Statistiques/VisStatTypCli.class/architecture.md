# VisStatTypCli — Architecture

> Source : `.src/Statistiques/VisStatTypCli.class`

## Vue d'ensemble

Visualisation du « Chiffre d'affaires par type client » calculé par
[`StatTypCli`](../StatTypCli.class/architecture.md) (`New VisStatTypCli(Me, Start.Societe, son,
dteN0, dteN1)`). Lit la table de travail `Total` (une ligne par type client), l'affiche dans
`Liste` (ColumnView, 7 colonnes : code, intitulé, brut HT, remise, net HT, net N-1, % N/N-1),
affiche les totaux (`Brutht`, `Remises`, `NetHT`, `Netnn`, `Netnn2` = évolution globale) et
imprime un PDF (`Chistoriques.Level1C`/`level2C`/`Level4C`/`Level5C`).

Nature globale : **GUI**, lecture seule de `Total`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `total` | var | Public |  | Integer | 29 |
| `value` | var | Public |  | Float[] | 30 |
| `Dtn0` | var | Public |  | String | 31 |
| `Dtn1` | var | Public |  | String | 32 |
| `Tri` | var | Public |  | String | 33 |
| `sens` | var | Public |  | String | 34 |
| `CoulZns` | var | Private |  | Integer | 35 |
| `CoulZnaf` | var | Private |  | Integer | 36 |
| `CoulFc` | var | Private |  | Integer | 37 |
| `PosY` | var | Private |  | Integer | 38 |
| `Filename` | var | Private |  | String | 39 |
| `son` | var | Private |  | Integer | 40 |
| `Coulfond` | var | Private |  | New String[] | 41 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 43-90 | Public | 1 | 45 | 0 | méthode spéciale |
| `Affichage` | 92-140 | Public | 10 | 46 | 0 | portée réductible ? |
| `Sens_Aff` | 142-150 | Public | 2 | 7 | 0 | portée réductible ? |
| `Bcode_Click` | 152-158 | Public | 1 | 4 | 0 | handler GUI |
| `Bnom_Click` | 160-165 | Public | 1 | 4 | 0 | handler GUI |
| `Bbrut_Click` | 167-172 | Public | 1 | 4 | 0 | handler GUI |
| `Brem_Click` | 174-179 | Public | 1 | 4 | 0 | handler GUI |
| `Bnet_Click` | 181-186 | Public | 1 | 4 | 0 | handler GUI |
| `Bnet2_Click` | 188-193 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 195-264 | Public | 8 | 67 | 0 | handler GUI |
| `Button1_Click` | 267-272 | Public | 3 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Hitniv, Soc, Sn, dte1, dte2)`** [portée : nécessaire (spéciale)] [nature : GUI].
  `Utils.Observers(Me)` une fois ; couleurs `CoulZnaf`, `Coulfc`, `CoulZns`, `Coulfond` lues
  mais jamais utilisées ; `Hitniv`, `Soc`, `Tab` ignorés. Colonnes, `Tri = "cdtypclifac"`,
  `Sens = "desc"`, `Affichage`.
- **`Affichage()`** (CC 10, max) [portée : réductible] [nature : mixte]. `SELECT * FROM Total
  ORDER BY <Tri> <Sens>` si `Bnom.value`, sinon `ORDER BY lpad(<Tri>, 12, ' ')` (tri « numérique »
  par chaîne complétée : faux pour les montants négatifs). Boucle `Totl` **inutilisée** puis
  `MoveFirst`. Par ligne : montants formatés `"0.00"`, N-1 par `Try`, % = `(totfac − totfacn1) ×
  100 / totfacn1` si `totfacn1 > 0` (format `"00.00"`). Totaux et `Netnn2` = évolution globale
  (`Try`, division par zéro ignorée). Partie extractible : lecture de `Total` et calcul des
  pourcentages.
- **`Sens_Aff()`** [portée : réductible] [nature : calcul] : bascule asc/desc (identique dans les
  5 `VisStat*`).
- **`Bcode_Click`, `Bnom_Click`, `Bbrut_Click`, `Brem_Click`, `Bnet_Click`, `Bnet2_Click`**
  [handlers des RadioButton, `Public` obligatoire] [nature : GUI] : fixent `Tri` puis
  `Affichage`. Événement `Click` : la valeur du RadioButton est à jour (contrairement à
  `VisStatComm`/`VisStatComArt`).
- **`Button2_Click()`** (« Imprimer ») [handler] [nature : GUI]. `Shell "cd ~"` sans effet ;
  fichier nommé `~/tmp/StatTypcli.ps` alors que le contenu est un PDF ; ligne `level2C` par ligne
  de grille ; **le saut de page teste `p >= 40` mais `p` n'est jamais incrémenté** : aucun saut
  de page, pas de `Footer` intermédiaire (VISSTATTYPCLI-A01). Total : `Level5C` reçoit `Totnn1`
  = **somme des pourcentages ligne à ligne** (Float converti implicitement en chaîne non
  formatée), alors que l'écran affiche l'évolution globale `Netnn2` (VISSTATTYPCLI-A02).
  `If IsNull(nn1) Or If IsNull(Val(nn1))` : une chaîne vide est `Null` en Gambas et `Or If`
  court-circuite, `Val` n'est donc évalué que sur une chaîne non vide (sans risque d'erreur).
- **`Button1_Click()`** (« Quitter ») : supprime le fichier puis ferme.

## État global utilisé

- `Start.LocalSettings["/Coul/…"]` (inutilisés), `Start.Son`, `User.Home`.
- `Utils.Observers`, `Utils.FColr`, `Utils.Coulfd`, `Utils.cpoint`, `Utils.db`.
- Table de travail `Total` (structure de `StatTypCli`, partagée : STATCOMM-A05).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la boucle `Totl`, `total`, `value`, couleurs, `Frmt`, `Tab`, `Shell`.
- Calcul du pourcentage dans une fonction pure `Evolution(n, n1) As String` (partagée avec
  `VisStatFour`, dont la formule diffère : VISSTATFOUR-A01).

### Commonalisation avec d'autres fichiers

- Socle `VisStat*` (voir [VisStatComm](../VisStatComm.class/architecture.md)) : `SensInverse`,
  `RequeteTotal`, `ImprimeListe`. `dup.py` : 120 lignes communes avec `VisStatComm` (0,56), 103
  avec [`VisStatComArt`](../VisStatComArt.class/architecture.md), 95-97 avec
  [`VisStatFour`](../VisStatFour.class/architecture.md) et [`VisStatClimo`](../VisStatClimo.class/architecture.md).

### Réduction de portée

- `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`, `sens` → `Private` (aucun accès externe) ;
  `total`, `value` supprimés.

### Séparation traitement / GUI

- `Affichage` : extraire `LignesTotal(sTri, sSens, bBrut)` (requête + pourcentages + totaux).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `StatTypCli` (table `Total` temporaire ou par poste).
