# Traites — Tests

> Source : `.src/Gestion/Impressions/Traites.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` avec comparaison du texte extrait du PDF (`pdftotext -layout`, date
d'édition masquée ou horloge figée), des lignes `Exec_SQL` du log et du dump normalisé de la base
(structure **et** contenu de `Fiches_Traites`). Valeurs attendues produites dans le clone **Laurux
non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRAITES-T01 | replay | Impression sans purge | `/Soc01/Lcr` = 0 ; 3 traites (dont une sans client) ; Imprimer, réponse « Non » | texte du PDF ; dump inchangé | `tests/impression/` | implémenté |
| TRAITES-T02 | replay | Impression avec purge | idem, réponse « Oui » | `Fiches_Traites` vide **et recréée** sans `imp` (A01 figée : `SHOW CREATE TABLE` dans le dump) | `tests/purge/` | implémenté |
| TRAITES-T03 | replay | Option LCR active | `/Soc01/Lcr` = 1 ; Imprimer | pas de question de purge ; texte d'accueil LCR | `tests/option_lcr/` | implémenté (texte d'accueil non comparé) |
| TRAITES-T04 | replay | Table vide | aucune traite | message « Aucune traite à imprimer ! » | `tests/table_vide/` | implémenté |
| TRAITES-T05 | replay | Saut de page | 12 traites | 2 pages, en-tête répété | `tests/saut_page/` | implémenté |

## Détail des tests

- **Données** : `Laurux01.sql` n'a aucune traite. Jeu dérivé `editions_gestion` (voir
  [Edbr](../Edbr.module/test.md)) avec des lignes `Fiches_Traites` liées aux clients `411001…`
  (coordonnées bancaires renseignées) et une ligne au code client inexistant.
- **Comparaison** : la structure de `Fiches_Traites` doit faire partie du dump pour T02 (la purge
  modifie le schéma). Les lignes `Exec_SQL` comptent les N+1 lectures client (informatif).
- **SQLite** : à rejouer aussi (le `DROP`/`CREATE` passe par `Utils.db.AutoIncrement/Engine`).
- **Non testable automatiquement** : visualisation du PDF (`Visualiseur.Prog` neutralisé).
- **Implémentation (vague 5)** : jeu `.hidden/Tests/Gestion/assets/traites_shared/traites_base.sql` (coordonnées
  bancaires de 411001/411002, 3 traites dont une au client 999999 inexistant, non imprimée) ; scénarios
  `traites_impression` (T01, `/Soc01/Lcr` = 0, « Non »), `traites_purge` (T02, « Oui » : table recréée vide sans
  `imp`, colonnes réordonnées, `acceptee`/`ecartee` en tinyint(4) au lieu de int(1)), `traites_option_lcr` (T03,
  `/Soc01/Lcr` = -1, aucune question), `traites_table_vide` (T04), `traites_saut_page` (T05, jeu
  `traites_douze.sql`, 2 pages). Texte du PDF par `pdftotext` (`edition.txt`). SQLite non rejoué.
