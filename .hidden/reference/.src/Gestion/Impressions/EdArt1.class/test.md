# EdArt1 — Tests

> Source : `.src/Gestion/Impressions/EdArt1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'édition : les tests sont des `replay` lancés depuis le menu Gestion > Impression des
tables > Tarif > Interne. Le PDF `~/tmp/Tarif1.pdf` est capturé par le script déclaré dans
`/Soc01/caisse/CmdVis`, converti par `pdftotext -layout`, puis normalisé (date « au jj.mm.aaaa »
du titre, date et utilisateur du pied de page). On compare ce texte et les lignes `Exec_SQL` du log ;
le dump de la base doit être identique avant et après (écran en lecture seule). Les valeurs
attendues sont produites dans le clone **Laurux non modifié** (anomalies comprises).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDART1-T01 | replay | Tarif interne, tri par code | plages par défaut, `RadioButton1`, **Imprimer** | texte PDF (`Level7`/`Level6`, 2 pages au moins) ; 1 `SELECT … order by lpad(art_code…)` | `tests/edart1_tri_code/` | à faire |
| EDART1-T02 | replay | Les 3 autres tris | `RadioButton2`, `3`, `4` successivement | ordre des lignes par famille, fournisseur, désignation | `tests/edart1_tris/` | à faire |
| EDART1-T03 | replay | Option marge | `Mg` coché, tri par code | colonnes `Level7M`/`Level6M`, marge = PV HT − PMP par article | `tests/edart1_marge/` | à faire |
| EDART1-T04 | replay | Prix consommateur | `/Soc01/Pvcons` vrai, articles avec et sans `art_pvcons` | ligne `Level10` seulement pour `art_pvcons <> 0` | `tests/edart1_pvcons/` | à faire |
| EDART1-T05 | replay | Plages restreintes | `Art`–`Art2`, une famille, un fournisseur | seuls les articles des 3 plages ; SQL avec les 6 paramètres | `tests/edart1_plages/` | à faire |
| EDART1-T06 | replay | Aucun article | plage article vide (`ZZZZY`–`ZZZZZ`) | message « Aucun article pour cette demande », pas de PDF | `tests/edart1_vide/` | à faire |
| EDART1-T07 | replay | Saisie manuelle d'article | `Art` = code existant, puis code fournisseur, puis code inconnu (Entrée) ; même chose dans `Art2` | focus suivant / `Message.Warning` ; `Art2` contrôle `Art.Text` (anomalie EDART1-A02 figée) | `tests/edart1_art_man/` | à faire |
| EDART1-T08 | replay | Listes familles / fournisseurs | F2 (ou bouton) sur `Fam`, `Fam2`, `Four`, `Four2`, clic sur une ligne ; Échap sur une liste | champ rempli, liste fermée, focus (anomalie de focus `Colfam2`/`Colfour2` figée) | `tests/edart1_listes/` | à faire |
| EDART1-T09 | replay | Sélection par `TriArticles` | `ToggleButton1`, choix d'un article ; puis `ToggleButton2`, annulation | `Art` rempli ; `Art2` reçoit l'ancien `Bval` (EDART1-A03 figée) | `tests/edart1_triarticles/` | à faire |
| EDART1-T10 | replay | Fermeture | **Fermer** après une impression | `~/tmp/Tarif1.pdf` supprimé | `tests/edart1_fermeture/` | à faire |
| EDART1-T11 | gbtest | Formatage d'une ligne de tarif (après EDART1-005) | enregistrements de `editions_articles` avec `art_nbd` 0, 2, 3 | tableau de chaînes identique au texte imprimé par T01/T03 | `tests/edart1_ligne_tarif/` | à faire |

## Détail des tests

- **Jeu de données `editions_articles`** (commun aux éditions d'articles et de stock : `EdArt1`,
  `EdArt3`, `Edart4`, `EdStk`, `EdRup`, `EdMat`, `Edmo`) : `Laurux01.sql` ne contient qu'**un**
  article, une famille, un fournisseur, une main d'oeuvre et aucun matériel. Le jeu dérivé ajoute
  par script SQL : 3 familles (dont une à sous-familles pour `Edart4`), 2 fournisseurs `401…`,
  ≈ 70 articles (plus d'une page à 5 mm par ligne) avec `art_nbd` 0, 2 et 3, des remises, des
  coefficients, des `art_pvcons` nuls et non nuls, des articles stockés et non stockés
  (`art_stocke`), suspendus (`art_suspendu`), avec `art_cfour`, `art_cbarre`, `art_cequ`,
  `art_refcentrale`, `art_stkmin`/`art_stkmax`/`art_mincom` renseignés pour une partie ; 2 types
  client (`Fiches_Typec`) avec des coefficients par famille (`Fiches_CoeffTypec`) pour un seul des
  deux ; des clients `411…` avec `cli_typec` ; des commandes fournisseurs (`Fiches_Entcom`,
  `Fiches_Ligcom`), des commandes clients (BL de type `C`, lignes `A`), des tickets archivés des
  10 derniers jours (`Fiches_HisEntTickets`/`Fiches_HisLigTickets`) ; une dizaine de matériels
  vendus et en stock avec 3 marques ; une dizaine de mains d'oeuvre (`mo_tempmont` 0 et 1, deux
  codes TVA). S'inspirer du jeu des éditions comptables décrit dans
  [`Balance/test.md`](../../../Compta/Impressions/Balance.class/test.md).
- **Normalisation** : la date du titre et du pied, `User.Name` et le nombre de pages `{nb}` restent
  dans le texte ; on fixe l'horloge (`faketime`) et l'utilisateur, ou on remplace ces champs par
  expression régulière avant comparaison.
- **Capture** : `/Soc01/caisse/CmdVis` pointe vers un script qui copie le PDF reçu dans
  `tests/<nom>/actual/` ; `Doc.Open` (F1) n'est pas exercé.
- **Paramètres** : `/Soc01/Pvcons` et `/Soc01/ipr` (obligatoire pour `textfamille`, sinon `Quit`)
  sont fixés dans le `Laurux.conf` de test.
- **Non testable automatiquement** : son (`Music.Play`), couleur du champ actif (`SetEditColor`),
  mode photo (case `Phot` invisible), double impression à la barre d'espace (EDART1-A04 : à
  observer manuellement si le rejeu ne reproduit pas l'enchaînement `KeyPress` + `Click`).
- **Couverture visée** : toutes les branches de `Button2_Click` sauf la branche photo.
