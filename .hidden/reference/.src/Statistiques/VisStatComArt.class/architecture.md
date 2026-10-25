# VisStatComArt — Architecture

> Source : `.src/Statistiques/VisStatComArt.class`

## Vue d'ensemble

Visualisation du « Chiffre d'affaires articles par commercial » calculé par
[`StatComArt`](../StatComArt.class/architecture.md) (`New VisStatComArt(Me, Start.Societe, son,
dteN0, dteN1)`). Lit la table de travail `Total` (article × commercial), l'affiche dans `Liste`
(ColumnView : code article, libellé, brut HT, quantité, code et nom du commercial ; 9 colonnes
déclarées, 6 remplies), filtre par commercial (ComboBox `Comm`), affiche le total net (`NetHT`)
et imprime un PDF `~/tmp/Statcli.pdf` (`Chistoriques.Level1A`/`level2A`/`Level5A`).

Nature globale : **GUI**, lecture seule (`Total`, `Fiches_Commerciaux`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `total` | var | Public |  | Integer | 27 |
| `value` | var | Public |  | Float[] | 28 |
| `Dtn0` | var | Public |  | String | 29 |
| `Dtn1` | var | Public |  | String | 30 |
| `Tri` | var | Public |  | String | 31 |
| `sens` | var | Public |  | String | 32 |
| `CoulZns` | var | Private |  | Integer | 33 |
| `CoulZnaf` | var | Private |  | Integer | 34 |
| `CoulFc` | var | Private |  | Integer | 35 |
| `PosY` | var | Private |  | Integer | 36 |
| `Page` | var | Private |  | Integer | 37 |
| `Filename` | var | Private |  | String | 38 |
| `son` | var | Private |  | Integer | 39 |
| `Coulfond` | var | Private |  | New String[] | 40 |
| `commercial` | var | Private |  | String | 41 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 43-97 | Public | 5 | 52 | 0 | méthode spéciale |
| `Affichage` | 99-143 | Public | 9 | 42 | 0 | portée réductible ? |
| `Sens_Aff` | 145-153 | Public | 2 | 7 | 0 | portée réductible ? |
| `Bcode_MouseDown` | 155-160 | Public | 1 | 4 | 0 | handler GUI |
| `Bnom_MouseDown` | 162-167 | Public | 1 | 4 | 0 | handler GUI |
| `Bbrut_MouseDown` | 169-174 | Public | 1 | 4 | 0 | handler GUI |
| `Brem_MouseDown` | 176-181 | Public | 1 | 4 | 0 | handler GUI |
| `Button2_Click` | 183-230 | Public | 5 | 45 | 0 | handler GUI |
| `Button1_Click` | 233-238 | Public | 3 | 4 | 0 | handler GUI |
| `Comm_Change` | 240-246 | Public | 1 | 5 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Hitniv, Soc, Sn, dte1, dte2)`** [portée : nécessaire (spéciale)] [nature : GUI].
  `Utils.Observers(Me)` une fois ; couleurs lues mais inutilisées ; `Try SELECT * FROM
  <TabCommerciaux> ORDER BY code` → `Comm.Add("<code> - <nom>")` pour chaque commercial puis
  `Comm.Add("Tous les commerciaux", "00")` (le second argument est l'**index** d'insertion :
  `"00"` → 0, l'entrée est insérée en tête). L'ajout d'éléments dans une ComboBox éditable peut
  lever `Comm_Change` pendant `_New`, avant la configuration des colonnes : filtre initial à
  confirmer par replay (VISSTATCOMART-A02). Colonnes, `Tri = "cdartfac"`, `Sens = "desc"`,
  `Affichage`.
- **`Affichage()`** (CC 9, max) [portée : réductible] [nature : mixte]. `SELECT * FROM Total
  [WHERE commercial = &1] ORDER BY <Tri> <Sens>` si `Bnom.value`, sinon `ORDER BY lpad(<Tri>,
  12, ' ')`. Boucle **vide** `Repeat … Until MoveNext()` puis `MoveFirst` (sans effet). Par ligne,
  `SELECT * FROM <TabCommerciaux> WHERE code = commercial` : **ligne ignorée si le commercial
  n'existe plus** (VISSTATCOMART-A03). Clé de ligne `cdartfac & commercial`. Total `NetHT`.
  Partie extractible : requête et lecture.
- **`Sens_Aff()`** [portée : réductible] [nature : calcul] : bascule asc/desc (5 copies
  identiques dans les `VisStat*`).
- **`Bcode_MouseDown`, `Bnom_MouseDown`, `Bbrut_MouseDown`, `Brem_MouseDown`** [handlers
  RadioButton, `Public` obligatoire] [nature : GUI] : `Tri` = `cdartfac`, `commercial`,
  `nethtfac`, `qte`, puis `Affichage`. Sur `MouseDown`, `Bnom.value` est encore l'ancienne
  valeur : le choix « tri brut / tri `lpad` » est décalé d'un clic (VISSTATCOMART-A01, à
  confirmer par replay).
- **`Comm_Change()`** [handler] [nature : GUI] : `commercial = Left$(Comm.Text, 2)` (« To » pour
  « Tous les commerciaux »), `Sens = "desc"`, `Affichage`.
- **`Button2_Click()`** (« Imprimer ») [handler] [nature : GUI] : `Shell "cd ~"` sans effet ; PDF
  `Entete`, `Level0F`, `Level1A`, `level2A` par ligne, saut de page à 283 mm, `Lines`, `Level5A`
  (total net), `Footer`, `Output`, `Visualiseur.Prog`. Fichier `~/tmp/Statcli.pdf` **identique
  à celui de** [`VisStatComm`](../VisStatComm.class/architecture.md).
- **`Button1_Click()`** (« Quitter ») : supprime le PDF puis ferme.

## État global utilisé

- `Start.LocalSettings["/Coul/…"]` (inutilisés), `Start.Son`, `User.Home`.
- `Utils.Observers`, `Utils.FColr`, `Utils.Coulfd`, `Utils.db`, `Cbase.Table("TabCommerciaux")`.
- Table de travail `Total` (structure de `StatComArt`, partagée : STATCOMART-A03).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la boucle vide, `total`, `value`, couleurs, `Frmt`, `Coulfond`, `Tab`, `Page`,
  `Shell`.
- Jointure `INNER JOIN Fiches_Commerciaux` au lieu d'une requête par ligne (SQL modifié, lecture
  seule, grille identique).

### Commonalisation avec d'autres fichiers

- Socle `VisStat*` (voir [VisStatComm](../VisStatComm.class/architecture.md)) : `SensInverse`,
  `RequeteTotal` (avec filtre optionnel), `ImprimeListe`. `dup.py` : 121 lignes communes avec
  `VisStatComm` (0,60), 103 avec [`VisStatTypCli`](../VisStatTypCli.class/architecture.md).
- Remplissage de la liste des commerciaux : comparer avec `StatComm`/`Histocliart` (liste
  `TabCommerciaux`) pour une fonction `ListeCommerciaux(hCombo, bTous)`.

### Réduction de portée

- `Affichage`, `Sens_Aff`, `Dtn0`, `Dtn1`, `Tri`, `sens` → `Private` ; `total`, `value`
  supprimés.

### Séparation traitement / GUI

- `Affichage` : extraire `LignesTotal(sCommercial, sTri, sSens, bBrut)`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir `StatComArt` (table `Total` temporaire ou par poste).
