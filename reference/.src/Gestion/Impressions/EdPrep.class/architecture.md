# EdPrep — Architecture

> Source : `.src/Gestion/Impressions/EdPrep.class` (+ `EdPrep.form`)

## Vue d'ensemble

Écran « Préparation des livraisons » (menu `Menu325`, Gestion > Stock, `Fmenu.class:2451`). Il
travaille sur toutes les **commandes clients en cours** (`Fiches_Bl` de type `C`) et propose :

- **Imprimer** (`Button1`) : une liste récapitulative paysage `~/tmp/ListeDocs.pdf`
  (`Cdocuments`, avec ou sans le détail des lignes selon `RadioButton7`), **puis** un bon de
  préparation par commande `~/tmp/Liste2Docs.pdf` (`Cdocuments3`) envoyé **directement à
  l'imprimante** par `Impression.Facture(Filename2, 1)` ; la liste est ensuite affichée.
- **Exporter** (`Button3`, visible si `RadioButton6` « sans détail ») : un CSV
  `~/tmp/Expedition.csv` (client ; immatriculation ; modèle ; série ; n° ; reliquat) tiré des
  lignes de commentaire véhicule (`XX`), ouvert ensuite par `Editeur.Prog_Editeur`.

Ordre de tri commun (`RadioButton8`…`11`). Grand frère d'[`EdDocs`](../EdDocs.class/architecture.md)
(≈ 118 lignes communes : boucle d'adresse, `level2d`, sauts de page).

Nature : **mixte** ; `Button1_Click` (CC 43, 264 lignes) est la fonction la plus complexe du lot.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `Filename2` | var | Private |  | String | 28 |
| `TypeD` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `Coulfond` | var | Private |  | New String[] | 32 |
| `hfile` | var | Private |  | File | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-45 | Public | 1 | 8 | 0 | méthode spéciale |
| `Button1_Click` | 47-317 | Public | 43 | 264 | 0 | handler GUI |
| `Button3_Click` | 319-373 | Public | 16 | 49 | 0 | handler GUI |
| `Button2_Click` | 375-381 | Public | 5 | 5 | 0 | handler GUI |
| `RadioButton6_Click` | 383-391 | Public | 2 | 7 | 0 | handler GUI |
| `RadioButton7_Click` | 393-401 | Public | 2 | 7 | 0 | handler GUI |
| `donnees1` | 403-407 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : calcule `Frmt` (`Utils.FColr`) et `Coulfond` (`Utils.Coulfd`), **jamais
  utilisés** ; `Utils.Observers(Me)`, `Music.Load`.
- **`Button1_Click()`** (CC 43) [handler] [mixte] :
  1. *Liste* : `SELECT * FROM <TabBl> left join <TabCli> on cli_code = cdclibl where type = &1
     order by <ordre>` (`"C"`) ; pour chaque commande, adresse du document, remplacée par l'adresse
     de livraison client (`SELECT * FROM Fiches_AdrlivC where code = &1`, nom en dur) puis par
     l'adresse de livraison du document (`Fiches_AdrlivBL`, sans clé Cbase) ; `level2d` (12
     arguments, `TypeD` toujours vide : jamais affecté) ; ligne de téléphones ; si détail, lignes
     article (`typel_ligbl = "A"`) et commentaires (`code_ligbl = "YY"`) ; sauts de page à 194.
  2. *Bons de préparation* : même requête, puis pour chaque commande `Entete(Start.LocalSettings
     ["/intitule"])` (clé globale, pas par société), `Entete2("Commande N° … du dd.mm.yyyy …")`,
     adresses de facturation et de livraison. ⚠️ `Burdis2 = Left$(Burdis, 30)` (lignes 225 et 238)
     remplace le code postal/ville **de livraison** par ceux de facturation (EDPREP-A01). Lignes :
     `SELECT * FROM Fiches_Ligbl left join Fiches_Art on art_code = code_ligbl where num_ligbl = &1
     or num_ligbl = &1 and code_ligbl = &2` (la seconde condition est redondante), nom du
     fournisseur (`Fiches_Four`, une requête par ligne), `Level2`/`carre` pour les articles,
     commentaires si détail ; sauts de page à 266 : dans la boucle des commentaires, sans
     `Entete` société, et dans les deux cas avec la date **brute** (`rResult!datebl` converti par
     Gambas) au lieu de `dd.mm.yyyy` (EDPREP-A02).
  3. `Output` des deux PDF, `Impression.Facture(Filename2, 1)` (impression directe, et
     visualisation si `/FACpdf`), `Wait 0.5`, `Visualiseur.Prog(Filename)`.
  Résidus : `Nbpage`, `Datefac`, `Numfac`, `CodeC` partiellement utiles, `Shell "cd …"`,
  affectations écrasées (`intitule` lignes 100-101 et 220-221).
- **`Button3_Click()`** (CC 16) [handler] [mixte] : ouvre `~/tmp/Expedition.csv` **avant** la
  requête (jamais fermé si aucune commande) ; pour chaque commande, lit les lignes `typel_ligbl =
  "C"` : `XX` → véhicule (`Split` du commentaire), `Reliquat…` → drapeau ; `Try Donnees1(…)` (index
  hors bornes si le commentaire véhicule est incomplet → ligne sans véhicule) ; question puis
  `Editeur.Prog_Editeur`.
- **`Button2_Click()`** [handler] : supprime les deux fichiers, ferme.
- **`RadioButton6_Click()` / `RadioButton7_Click()`** [handlers] : visibilité de `Button3`.
- **`donnees1(p1…p6)`** [portée : réductible, appelé seulement par `Button3_Click`] [calcul] :
  écrit une ligne `;` dans `hFile`.

## État global utilisé

- `Start.LocalSettings["/intitule"]` (raison sociale globale, écrite par `Fsoc`/`LauruxConf`),
  `["/Coul/Fnets"]` (inutile), `Start.Son`, `Start.Musique`.
- `Utils.Cdate_Aff`, `cpoint`, `FColr`, `Coulfd`, `Observers`, `Cbase.Table`.
- `Impression.Facture`, `Editeur.Prog_Editeur`, `Visualiseur.Prog`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Button1_Click` : `ImprimeListe(sOrdre, bDetail)`, `ImprimeBonsPreparation(sOrdre,
  bDetail)`, `AdresseLivraison(numbl, cli)` (deux copies aujourd'hui), `NouvellePageBon(…)`
  (deux copies divergentes : à unifier seulement après A02).
- Simplifier la requête des lignes (`where num_ligbl = &1` : résultat identique) et lire le nom du
  fournisseur par jointure (SQL modifié, dump identique).
- Supprimer `Frmt`, `Coulfond`, `TypeD`, les affectations écrasées.

### Commonalisation avec d'autres fichiers

- [`EdDocs`](../EdDocs.class/architecture.md) : même liste (`level2d`, `LinesLG`, détail des lignes,
  sauts de page) ; une procédure commune `ImprimeListeDocuments(rResult, bDetail, …)` servirait aux
  deux (sorties à comparer : seuils de saut de page 180/194 différents).
- Adresse de livraison (`Fiches_AdrlivC` puis `Fiches_AdrlivBL`) : même cascade dans `ObjFac` et
  `Facture` (lot Gestion-1) → helper commun à recenser en phase 3.

### Réduction de portée

- `donnees1` → `Private`.

### Séparation traitement / GUI

- `CommandesEnCours(sOrdre) As Result`, `LignesCommande(numbl)`, `LigneExpedition(numbl)` (pure,
  testable) séparées de l'impression et du CSV.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les données véhicule sont stockées dans un commentaire multi-lignes (`XX`) et relues par
  découpage de texte : des colonnes dédiées éviteraient le `Try`.
- Clé Cbase pour `Fiches_AdrlivBL`.
