# Histocliart — Architecture

> Source : `.src/Statistiques/Histocliart.class`

## Vue d'ensemble

`Histocliart` est l'écran d'**historique des ventes croisé client / article / famille** (menu
`Fmenu.class:2411`, `Histocliart.Show()` sur l'auto-instance). Contrairement aux autres écrans du lot,
il ne passe pas par une table de travail : il **construit dynamiquement une requête d'agrégat**
(`crearequ`) sur l'union des sources cochées, l'exécute une fois (`$res`), puis :
- **Éditer** (`Butedit`) : rapport `gb.report` construit en code (`edition`, `afflig`, `afftot`) imprimé
  vers `~/tmp/Histo.pdf` puis ouvert par `Visualiseur.Prog` ;
- **Exporter** (`Butexp`) : fichier `~/tmp/HistoVente.csv` (séparateur `;`), ouvert dans l'éditeur
  sur demande.

Critères :
- regroupement : `Radiocli` (par client, détail article optionnel `Checkdetart`), `Radioart` (par
  article, détail client optionnel `Checkdetcli`), `Radiofam` (par famille, détail article optionnel) ;
- colonnes : quantité toujours, CA (`Checkca`) et marge (`Checkmarg`), qui fixent aussi le tri (qte,
  marge ou CA décroissant, sauf en mode détail : aucun `ORDER BY`) ;
- sources (`nbfic`) : documents en cours (`CheckDoc` → `Fiches_Bl`/`Ligbl`), documents matériel
  (`CheckDocE` → `Fiches_BlM`/`LigblM`), factures historisées (`CheckFacA`), factures matériel
  (`CheckFacEA`), tickets de caisse (`CheckTk`, exclusif : décoche et désactive toutes les autres) ;
- types de documents en cours : proforma, devis, commande, BL, facture (`'A','F'`) ;
- filtres : période (`TextReg` de type date, fin à `Fin_Jour`), plages client, article, fournisseur,
  type client, commercial, marque, centrale, familles (`TreeView1` multi-sélection, sauf
  `Checktfam` « toutes »).

Nature globale : **mixte** ; `crearequ` (CC 141, 350 lignes) lit directement une trentaine de
contrôles pour produire le SQL. `Utils.Observers(Me)` est appelé une fois dans `_New`. Le chaînage
des zones (`Chainage`) et le type `TextReg` gèrent la saisie et la validation par expression régulière.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `hfile` | var | Private |  | File | 29 |
| `son` | var | Private |  | Integer | 30 |
| `Coulfond` | var | Private |  | New String[] | 31 |
| `PosY` | var | Private |  | Integer | 32 |
| `PosX` | var | Private |  | Integer | 33 |
| `Cclient` | var | Public |  | String | 34 |
| `Bsel` | var | Public |  | Boolean | 35 |
| `Bval` | var | Public |  | String | 36 |
| `$familles` | var | Private |  | Trifam | 37 |
| `$rpt` | var | Private |  | Report | 38 |
| `$res` | var | Private |  | Result | 39 |
| `$ca` | var | Private |  | Float | 40 |
| `$marge` | var | Private |  | Float | 41 |
| `$srequete` | var | Private |  | String | 42 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 44-82 | Public | 4 | 31 | 0 | méthode spéciale |
| `TriArticles` | 84-100 | Private | 4 | 15 | 0 |  |
| `dteN1_LostFocus` | 106-119 | Public | 4 | 9 | 0 | handler GUI |
| `Cli_man` | 124-151 | Public | 5 | 25 | 0 | portée réductible ? |
| `Butcli_Click` | 154-168 | Public | 2 | 12 | 0 | handler GUI |
| `Butcli2_Click` | 170-183 | Public | 2 | 11 | 0 | handler GUI |
| `Butart_Click` | 185-207 | Public | 4 | 20 | 0 | handler GUI |
| `butfour_click` | 209-230 | Public | 4 | 19 | 0 | handler GUI |
| `Buttype_Click` | 232-251 | Public | 4 | 17 | 0 | handler GUI |
| `ColumnView2_Activate` | 253-259 | Public | 1 | 5 | 0 | handler GUI |
| `btn_Click` | 261-287 | Public | 6 | 24 | 0 | handler GUI |
| `ColumnView1_Activate` | 289-300 | Public | 3 | 10 | 0 | handler GUI |
| `Butedit_Click` | 303-314 | Public | 4 | 10 | 0 | handler GUI |
| `crearequ` | 316-666 | Private | 141 | 310 | 0 |  |
| `nbfic` | 668-679 | Private | 6 | 9 | 0 |  |
| `edition` | 681-806 | Private | 19 | 114 | 0 |  |
| `afflig` | 808-850 | Private | 3 | 40 | 0 |  |
| `afftot` | 852-890 | Private | 3 | 36 | 0 |  |
| `attribres` | 892-907 | Private | 4 | 13 | 0 |  |
| `attrires1` | 909-920 | Private | 2 | 9 | 0 |  |
| `Radiocli_Click` | 922-930 | Public | 2 | 7 | 0 | handler GUI |
| `Radioart_Click` | 932-940 | Public | 2 | 7 | 0 | handler GUI |
| `Radiofam_Click` | 942-950 | Public | 2 | 7 | 0 | handler GUI |
| `Butquit_Click` | 952-956 | Public | 1 | 3 | 0 | handler GUI |
| `Butexp_Click` | 958-987 | Public | 11 | 26 | 0 | handler GUI |
| `CheckTk_Click` | 989-1025 | Public | 2 | 32 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et sélections

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte]. `Coulfond`, `Frmt` (inutilisés),
  `Utils.Observers(Me)`, son ; `New Chainage([...11 zones])` ; types et regex des `TextReg` (dates,
  comptes `401…`/`411…`) ; période par défaut = début d'exercice (`LDate(Now).EDeb`) → fin du mois ;
  `SELECT * FROM Fiches_Commerciaux` (`Cbase.Table("TabCommerciaux")`) dans `Combcomm`, puis
  `Combcomm.Add(" ", "00")` (le second argument est l'**index** : l'entrée vide est insérée en tête,
  d'où « aucun commercial » par défaut) ; arbre des familles via `New Trifam("1")` et `TriArticles`.
- **`TriArticles(fam As Trifam)`** [portée : Private] [nature : GUI]. Remplit récursivement `TreeView1`
  (parents, frères précédents), déplie tout et sélectionne le premier nœud. Homonyme de la classe
  `TriArticles` (`Affichages`), sans conflit car privé, mais source de confusion.
- **`dteN1_LostFocus()`** [portée : nécessaire (handler, levé par `TextReg`/`ButtonBox` : à confirmer)]
  [nature : GUI]. Avertit si `dten0` est après `dten1` (`LDate.Apres`, strict).
- **`Cli_man(Org)`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Cli where cli_code =
  &1` avec **`Cli.Text` dans les deux cas** (même pour `Org = "Cli2"`) ; si absent : message, vide la
  zone `Org` et lui rend le focus.
- **`Butcli_Click()` / `Butcli2_Click()`** [portée : nécessaire (handlers)] [nature : GUI]. Ouvrent
  `TriCpt(Client, Sans_Solde, Me)` en modal ; `TriCpt` écrit `Bsel`/`Bval` dans l'appelant par
  `Object.SetProperty` **seulement si une ligne est choisie** : `Butcli` remet `Bsel = False` avant,
  `Butcli2` non (une annulation reprend la sélection précédente).
- **`Butart_Click()`** [portée : nécessaire (handler du groupe `butart`)] [nature : GUI]. `TriArticles`
  modal (qui remet `Bsel`/`Bval` à zéro), remplit `Textart` (tag 1) ou `Textart1` (tag 2).
- **`butfour_click()`** [portée : nécessaire (handler du groupe `butfour`)] [nature : GUI]. `TriCpt`
  fournisseurs ; ne remet pas `Bsel` à `False` (même défaut que `Butcli2`).
- **`Buttype_Click()` / `ColumnView2_Activate()`** [portée : nécessaire (handlers)] [nature : mixte].
  Liste `SELECT * FROM Fiches_Typec` (en dur) → `Texttype` reçoit la clé.
- **`btn_Click()` / `ColumnView1_Activate()`** [portée : nécessaire (handlers)] [nature : mixte]. Liste
  des marques (`SELECT * FROM Fiches_Marques`, `Textmarq` reçoit le **texte**) ou des centrales
  (`SELECT code, libelle as intitule FROM Fiches_Centrales`, `Textcentr` reçoit la clé) ; si `Last`
  n'est aucun des deux boutons, `res` est `Null` (impossible avec le `.form` actuel).
- **`Radiocli_Click` / `Radioart_Click` / `Radiofam_Click`** [portée : nécessaire (handlers)]
  [nature : GUI]. Activent la case de détail compatible et décochent l'autre.
- **`CheckTk_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Tickets exclusifs : décoche et
  désactive les 9 autres cases, ou les réactive.
- **`Butquit_Click()`** : `Me.Close`.

### Construction et exécution de la requête

- **`crearequ() As Boolean`** (CC 141) [portée : Private] [nature : mixte]. Construit, pour le
  regroupement choisi, jusqu'à 5 sous-requêtes (BL, BL matériel, factures, factures matériel,
  tickets) qui renvoient chacune `qte`, `ca`, `mrgart`, `mrgmo`, `dte` et la colonne de regroupement
  (`client`, `article` ou `famille`), avec les valeurs textuelles converties par `REPLACE(x, ',', '.')`
  et les `NULL` remplacés par `'0'`. Filtres paramétrés par `Utils.db.Subst` (`&1`…`&6` : bornes
  client, article, fournisseur), puis ajouts optionnels (`cli_typec`, `cli_comm` = 2 premiers
  caractères, `art_marque`, `art_centrale`, familles par `Utils.fam`). Les tickets prennent la
  **dernière version de chaque bloc** (`max(type)` parmi `A`/`S` par `numero, block`), excluent les
  tickets supprimés (`suppr != 1`) et calculent la marge `mht - art_paht * qte`. Requête finale :
  `SELECT SUM(qte), SUM(ca), SUM(mrgart)+SUM(mrgmo) as marge, <groupe>[, détail] FROM (<union>) AS a
  WHERE (dte BETWEEN &1 And &2) GROUP BY <groupe>[, détail] [ORDER BY …]`, exécutée avec
  `dteN0.dte.DT` et `dteN1.dte.Fin_Jour().DT`. Le SQL est aussi recopié dans `TextArea1` (journal ;
  la branche tickets fait `=` au lieu de `&=`).
  Défauts relevés :
  - `UNION ALL` n'est préfixé que si `un` est vrai, et seules les branches BL positionnent `un` : avec
    factures **et** factures matériel sans document en cours, les deux `SELECT` sont collés sans
    `UNION ALL` → SQL invalide (lignes 405/422, 507/524, 609/626) ;
  - `Utils.fam` sans nœud sélectionné renvoie `" AND champ IN)"` → SQL invalide (UTILS-A02) quand
    `Checktfam` est décochée et qu'aucune famille n'est sélectionnée ;
  - la sous-requête tickets a 10 colonnes contre 6 pour les autres : elle ne peut être combinée,
    d'où l'exclusivité imposée par `CheckTk_Click` ;
  - le texte final, déjà substitué, repasse dans `Exec` avec `&1`/`&2` : une valeur saisie contenant
    `&1` ou `&2` (marque, centrale…) serait re-substituée (cas marginal) ;
  - noms de tables et colonnes qualifiées en dur (`Fiches_Bl.type`, `Fiches_HisLigTickets.qte`…), sans
    `Cbase.Table`.
  `Me.Mouse = Mouse.Normal` en fin : constante absente des autres sources (à confirmer qu'elle existe ;
  sinon erreur d'exécution après chaque requête).
- **`nbfic() As Integer`** [portée : Private] [nature : GUI]. Nombre de sources cochées.
- **`Butedit_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Refuse si aucune source
  (« Veuillez sélectionner au moins un fichier »), appelle `crearequ`, puis `edition` si `$res` a des
  lignes (sinon rien, sans message).
- **`Butexp_Click()`** [portée : nécessaire (handler)] [nature : mixte]. Appelle `crearequ` **sans**
  contrôle `nbfic` ni test `$res.Available` (aucune source → SQL `FROM ( ) AS a` invalide ; résultat
  vide → erreur sur `$res!…`), écrit une ligne CSV par enregistrement (`groupe;[détail;]qte;marge;ca`,
  `Str` des valeurs), propose de l'ouvrir (`Editeur.Prog_Editeur`).

### Édition

- **`edition()`** (CC 19) [portée : Private] [nature : GUI]. Crée un `Report` en code : titre coloré
  (`Val("&H" & Hex(Start.R) & Hex(Start.G) & Hex(Start.B))`, composantes non complétées à 2 chiffres →
  couleur fausse si une composante < 16), en-têtes (N°, libellé, qté, CA, marge selon les cases), puis
  pour chaque enregistrement : libellé du groupe par `attribres` (une requête par ligne) ; en mode
  détail, une ligne de titre par groupe, une ligne par détail (`attrires1`, une requête de plus) et un
  sous-total `afftot` à chaque rupture ; total général à la fin. Une ligne dont le client/article/famille
  n'existe plus est **sautée** (`Continue`) et absente des totaux. Le mode détail suppose des lignes
  groupées dans l'ordre du `GROUP BY` (pas d'`ORDER BY` : ordre implicite de MySQL/MariaDB, non garanti
  partout). Le titre « des famille par article » est inversé pour `Radiofam`. Impression par
  `$rpt.Print(prt)` vers `~/tmp/Histo.pdf`.
- **`afflig(code, lib)`** / **`afftot(qte, ca, mrg)`** [portée : Private] [nature : GUI]. Ligne de détail
  (valeurs lues dans `$res`) et ligne de total (`Format` `0.000` / `0.00`).
- **`attribres()` / `attrires1()`** [portée : Private] [nature : calcul]. Libellé du client
  (`Fiches_Cli`), de l'article (`Fiches_Art`) ou de la famille (`Fiches_Fam`) de la ligne courante de
  `$res` (noms de tables en dur).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.R`/`G`/`B`, `Start.LocalSettings["/Coul/Fnets"]`.
- `Utils.Observers`, `Utils.Coulfd`, `Utils.FColr`, `Utils.db` (`Exec`, `Subst`), `Utils.fam`,
  `LDate` (`EDeb`, `FinMois`, `Fin_Jour`, `DT`, `Apres`), `Chainage`, `TextReg`, `Trifam`, `TriCpt`,
  `TriArticles`, `Visualiseur.Prog`, `Editeur.Prog_Editeur`.
- `Public Bsel`/`Bval` : écrits par `TriCpt` et `TriArticles` (`Object.SetProperty`) → doivent rester
  `Public`. `Public Cclient` n'est utilisé nulle part.

## Propositions d'amélioration

### Réécriture / refactorisation

- `crearequ` : les 3 regroupements × 5 sources répètent la même construction. Une table de
  description des sources (tables, préfixe de colonnes, colonne de date, clause propre) et deux
  helpers `SousRequete(source, champGroupe, champDetail, typedoc)` et `FiltresCommuns(prefixe)`
  produiraient **exactement le même texte SQL** (vérifiable par gbtest en comparant les chaînes) ;
  CC 141 → ≤ 20.
- Supprimer `Cclient`, `Coulfond`, `Frmt`, `PosY`, `PosX`, le membre `Filename` masqué par une
  variable locale dans `edition`, les variables inutilisées (`hv`, `i`, `j`, `cond2`, `cle`), le code
  commenté de `_New`.
- `Butcli_Click`/`Butcli2_Click`/`butfour_click` → helper privé `ChoisitTiers(type, zone, suivante)`.

### Commonalisation avec d'autres fichiers

- Sélection de tiers par `TriCpt` + `Bsel`/`Bval` : même idiome que dans de nombreux écrans
  (`Balance`, `EdArt1`…) ; la remise à `False` de `Bsel` relève de chaque appelant (voir EDART1-A03).
- Noms de tables via `Cbase.Table` (texte SQL identique), comme les autres écrans.
- Couleur de titre `Start.R/G/B` → helper de couleur (voir la commonalisation `/Coul/*` autour de
  [`LCoul`](../../Utils/LCoul.class/architecture.md)) ; la correction du padding hexadécimal est une
  anomalie (rendu modifié).
- `Utils.fam` est aussi utilisé par `Stockmvt` (même anomalie UTILS-A02) : la correction se fait dans
  [`Utils`](../../Utils/Utils.module/architecture.md).

### Réduction de portée

- `Cli_man` : aucun appelant externe → `Private`. `Cclient` : supprimé (jamais lu). `Bsel`/`Bval`
  restent `Public`. Les handlers restent `Public`.

### Séparation traitement / GUI

- `crearequ` → `ConstruitRequete(c As Collection) As String` **pure** (critères passés en collection :
  cases, bornes, filtres, familles sélectionnées) + lecture des contrôles dans une fonction
  `LitCriteres()` ; testable en gbtest (texte SQL attendu).
- `Butexp_Click` → `EcritCsv(res, mode, chemin)` (sans contrôle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les quantités, montants et marges des lignes (`qte_ligbl`, `netht_ligbl`, `mrgart_*`, `mht`…) sont
  textuels avec virgule possible, d'où les `REPLACE(…, ',', '.')` et les `CASE … IS NULL` : des
  colonnes `DECIMAL` non nulles simplifieraient la requête et permettraient l'usage d'index.
- Une vue SQL unifiant lignes en cours / historisées / matériel (mêmes noms de colonnes) remplacerait
  les 4 sous-requêtes recopiées.
