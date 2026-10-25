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
| TRIGEN-T01 | replay | Filtre et tri | écran `EdStk` → sélection article (TriArticles) ; saisie `VIS` dans le filtre « Intitulé », double-clic sur l'en-tête « Code », Raz | requêtes `Exec_SQL` de référence (`like "%VIS%"`, `order by art_code desc`), grille vidée puis rechargée | `tests/filtre_tri/` | à faire |
| TRIGEN-T02 | replay | Pagination | même écran : PageDown ×2, PageUp, molette, boutons `Descendre`/`Remonter`, saisie `40` dans le compteur | `LIMIT` successifs ; retour à 0 sans valeur négative ; nombre de requêtes par action (double requête `Count_Change` figée) | `tests/pagination/` | à faire |
| TRIGEN-T03 | replay | Sélection simple | TriArticles depuis `Etiqart` : clic sur une ligne ; puis réouverture et Échap | `Bsel`/`Bval` de l'appelant : code article, puis `False`/`Null` | `tests/selection_simple/` | à faire |
| TRIGEN-T04 | replay | Sélection à colonnes `cle` | `ValidBR1` : choix d'un fournisseur puis d'un BR (`TriFou`, `TriBr`), double-clic (`Activate`) | `Bval` = `Collection` des colonnes clés ; BR validé : dump `Fiches_Bl`/stock comme VALIDBR1 | `tests/selection_cle/` | à faire |
| TRIGEN-T05 | replay | Sélection multiple | `Pointage` : sélection de 3 lignes, « tout sélectionner » (`GetAllFiltered`), Raz | lignes colorées ; pointage enregistré : dump identique à POINTAGE (scénario mutualisé) | `tests/selection_multiple/` | à faire |
| TRIGEN-T06 | replay | Filtre sans résultat (A01) | TriArticles : filtre `ZZZZ` (aucun article) | figer : la grille garde le nombre de lignes précédent, cellules vides ; un clic ne transmet rien | `tests/filtre_vide/` | à faire |
| TRIGEN-T07 | replay | Caractères spéciaux (A02) | filtre `%`, `_`, `\`, `"` | figer : jokers actifs pour `%`/`_`, `"` retiré, erreur SQL (MySQL) pour `\` | `tests/filtre_special/` | à faire |
| TRIGEN-T08 | replay | Impression Ctrl+P | TriArticles, page 2, Ctrl+P ; puis filtre sans résultat et Ctrl+P | aperçu de la page affichée seulement ; figer l'erreur sur résultat vide (A03) | `tests/impression/` | à faire |
| TRIGEN-T09 | replay | Liste en fenêtre propre (`Parent = Null`) | `LGed` (« Existant ») ou `FClient` (GED) : choix d'un tag | tag ajouté ; fenêtre fermée ; `Utils.Observers` appliqué à la fenêtre créée | `tests/fenetre_propre/` | à faire |
| TRIGEN-T10 | gbtest | `Requete(bDesc, bLimite)` (après TRIGEN-005) | requête de base, filtres saisis/imposés, `GROUP BY`, `HAVING`, sens, page 0 et 2 | texte SQL **identique** à celui journalisé par le clone non modifié | `tests/requete/` | à faire |
| TRIGEN-T11 | gbtest | Construction du filtre (après TRIGEN-005) | `FilterRegex` avec champs normaux et `parse_having_*`, textes avec `"` | `Sel` et `Having` de référence | `tests/construit_filtre/` | à faire |

## Détail des tests

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
