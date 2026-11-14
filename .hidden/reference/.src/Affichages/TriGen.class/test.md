# TriGen — Tests

> Source : `.src/Affichages/TriGen.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`TriGen` n'a pas d'écran propre : il est testé **à travers ses écrans hôtes** (`TriArticles`,
`TriCpt`, `GedR`, `TriFacture`, `Pointage`, `ValidBR1`…), dans le clone **Laurux non modifié**
(capture des journaux `Exec_SQL` et du dump). Les fonctions pures extraites par TRIGEN-005
(`Requete`, construction du filtre) sont testées en `gbtest`. Base : `Laurux01.sql` + jeu dérivé
`liste_paginee` (≥ 3 pages d'articles, de comptes et de documents GED ; articles dont le code
contient `"`, `\`, `%`, `_`).

**Banc d'essai dédié** : [`Tests/TriTest`](../../Tests/TriTest.class/test.md) est l'implémentation
d'un test de TriGen (décision utilisateur). Ses tests TRITEST-T01 à T03 couvrent la création en mode
`Panel`, `ExtraSel` et l'annulation ; son enrichissement (TRITEST-002) doit reprendre les scénarios
TRIGEN-T01 à T09 ci-dessous, ce qui permettra de tester TriGen sans passer par un écran hôte.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIGEN-T01 | replay | Filtre et tri | écran `EdStk` → sélection article (TriArticles) ; saisie `VIS` dans le filtre « Intitulé », double-clic sur l'en-tête « Code », Raz | requêtes `Exec_SQL` de référence (`like "%VIS%"`, `order by art_code desc`), grille vidée puis rechargée | `tests/filtre_tri/` | implémenté (gb.test `TriGenTest.T01FiltreTri` : filtre et Raz par l'API ; tri décroissant par double-clic non couvert, `Filter_DblClick` lit `Last`) |
| TRIGEN-T02 | replay | Pagination | même écran : PageDown ×2, PageUp, molette, boutons `Descendre`/`Remonter`, saisie `40` dans le compteur | `LIMIT` successifs ; retour à 0 sans valeur négative ; nombre de requêtes par action (double requête `Count_Change` figée) | `tests/pagination/` | implémenté (gb.test `TriGenTest.T02Pagination` : Descendre/Remonter/compteur ; PageDown/molette non rejouables) |
| TRIGEN-T03 | replay | Sélection simple | TriArticles depuis `Etiqart` : clic sur une ligne ; puis réouverture et Échap | `Bsel`/`Bval` de l'appelant : code article, puis `False`/`Null` | `tests/selection_simple/` | implémenté (gb.test `TriGenTest.T03SelectionSimple` : `Close(valeur)`/`Close(Null)` directement, sans Etiqart) |
| TRIGEN-T04 | replay | Sélection à colonnes `cle` | `ValidBR1` : choix d'un fournisseur puis d'un BR (`TriFou`, `TriBr`), double-clic (`Activate`) | `Bval` = `Collection` des colonnes clés ; BR validé : dump `Fiches_Bl`/stock comme VALIDBR1 | `tests/selection_cle/` | implémenté (gb.test `TriGenTest.T04SelectionCle` : `Coltri_Click`/`Coltri_Activate` sur une ligne ; validation du BR par ValidBR1 : à faire, à mutualiser avec VALIDBR1) |
| TRIGEN-T05 | replay | Sélection multiple | `Pointage` : sélection de 3 lignes, « tout sélectionner » (`GetAllFiltered`), Raz | lignes colorées ; pointage enregistré : dump identique à POINTAGE (scénario mutualisé) | `tests/selection_multiple/` | implémenté (gb.test `TriGenTest.T05ToutFiltre` : MajSel annulé, `GetAllFiltered`, Raz ; pointage enregistré : voir POINTAGE) |
| TRIGEN-T06 | replay | Filtre sans résultat (A01) | TriArticles : filtre `ZZZZ` (aucun article) | figer : la grille garde le nombre de lignes précédent, cellules vides ; un clic ne transmet rien | `tests/filtre_vide/` | implémenté (gb.test `TriGenTest.T06FiltreVide` : en tri croissant la grille est vidée (0 ligne) ; l'A01 ne concerne que `DB_Decr`, non atteignable sans double-clic) |
| TRIGEN-T07 | replay | Caractères spéciaux (A02) | filtre `%`, `_`, `\`, `"` | figer : jokers actifs pour `%`/`_`, `"` retiré, erreur SQL (MySQL) pour `\` | `tests/filtre_special/` | implémenté (gb.test `TriGenTest.T07FiltreSpecial` : `%`/`_` jokers, `"` retiré, `\` : 0 ligne sans erreur SQL) |
| TRIGEN-T08 | replay | Impression Ctrl+P | TriArticles, page 2, Ctrl+P ; puis filtre sans résultat et Ctrl+P | aperçu de la page affichée seulement ; figer l'erreur sur résultat vide (A03) | `tests/impression/` | à faire : aperçu `Report` de `imprime` (vérification visuelle) et Ctrl+P non rejouable |
| TRIGEN-T09 | replay | Liste en fenêtre propre (`Parent = Null`) | `LGed` (« Existant ») ou `FClient` (GED) : choix d'un tag | tag ajouté ; fenêtre fermée ; `Utils.Observers` appliqué à la fenêtre créée | `tests/fenetre_propre/` | implémenté (gb.test `TriGenTest.T09FenetrePropre` : Parent Null, fenêtre 800 x 480, Bsel/Bval ; ajout de tag par LGed : à faire) |
| TRIGEN-T10 | gbtest | `Requete(bDesc, bLimite)` (après TRIGEN-005) | requête de base, filtres saisis/imposés, `GROUP BY`, `HAVING`, sens, page 0 et 2 | texte SQL **identique** à celui journalisé par le clone non modifié | `tests/requete/` | à faire : après extraction TRIGEN-005 (texte SQL ; lignes obtenues couvertes par T01, T12) |
| TRIGEN-T11 | gbtest | Construction du filtre (après TRIGEN-005) | `FilterRegex` avec champs normaux et `parse_having_*`, textes avec `"` | `Sel` et `Having` de référence | `tests/construit_filtre/` | à faire : après extraction TRIGEN-005 (filtre `parse_having_*` couvert par les lignes obtenues en T12) |
| TRIGEN-T12 | gbtest | `ExtraSel`, `ExtraHave`, `GroupBy` imposés par l'appelant | requête groupée par famille (`parse_having_nb`), `ExtraSel("art_stocke = 1")`, `ExtraHave("count(*) > 13")`, filtre famille | lignes obtenues de référence | `TriGenTest.T12ExtraSel` | implémenté |

## Détail des tests

- **Implémentation (phase 2, vague 6)** : la grille n'étant pas sélectionnable au rejeu, TriGen est piloté par son API
  publique dans le module gb.test `.src/Tests/Affichages/TriGenTest.test` (mode `Panel` 800 x 300, hauteur 20 : 13 lignes
  par page), le module recevant `Bsel`/`Bval` et les événements. Jeu `.hidden/Tests/Affichages/assets/trigen_shared/liste_paginee.sql`
  (40 articles T001-T040, 1 sur 5 « Vis tete », 4 articles `S%1`, `S_2`, `S\3`, `S"4`). La saisie dans un filtre se fait
  par `TextReg.Text` (déclenche `Filter_Change`). Remarque : `GroupBy(Grp)` n'ajoute pas le préfixe `GROUP BY` alors que
  `_new` l'ajoute (l'appelant doit le passer).

- **Valeurs attendues** : capturées dans le clone non modifié (journal `Exec_SQL` activé, dump
  normalisé). Les anomalies A01 à A03 sont figées (tests de caractérisation).
- **Instrumentation** : dans un `Panel`, les contrôles créés par `TriGen` ne sont pas instrumentés
  par `Utils.Observers` (appelé avant leur création par `TriArticles`, jamais par `TriCpt`). Avant
  la phase 2, vérifier si `ReplayObserver` journalise les clics de `Coltri` et la saisie dans les
  `TextReg` ; sinon, ces scénarios ne sont pas rejouables tels quels et il faut soit instrumenter
  (`Utils.Observers` sur le panneau après création, changement de comportement à valider), soit
  piloter les écrans par un script de clics (xdotool) en dehors du rejeu.
- **Géométrie** : `lg` dépend de la hauteur du conteneur et de la police : fixer
  `QT_SCALE_FACTOR`, thème et police entre capture et rejeu.
- **Mutualisation** : T04 avec les scénarios de `ValidBR1`, T05 avec `Pointage`, T03 avec
  `TriArticles`, T09 avec `LGed`/`FClient`.
- **Non testable automatiquement** : l'aperçu `Report` de `imprime` (vérification visuelle).
