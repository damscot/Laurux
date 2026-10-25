# Edregul — Tests

> Source : `.src/Gestion/Impressions/Edregul.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` avec comparaison du texte extrait de `~/tmp/Regul.pdf`
(`pdftotext -layout`, date d'édition masquée), des lignes `Exec_SQL` du log et du dump normalisé
de `Fiches_Mvtexp`. Valeurs attendues produites dans le clone **Laurux non modifié** ; horloge
figée (`faketime`) car les dates par défaut dépendent de `Now`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDREGUL-T01 | replay | Impression d'une période | dates saisies + Entrée ; Imprimer, `Effmvts` décochée | texte du PDF (dont « Article inexistant ») ; dump inchangé | `tests/impression_periode/` | à faire |
| EDREGUL-T02 | replay | Purge | `Effmvts` cochée, « Oui » | dump `Fiches_Mvtexp` : mouvements hors période du même article **aussi** supprimés (A01 figée) | `tests/purge/` | à faire |
| EDREGUL-T03 | replay | Purge refusée | `Effmvts` cochée, « Non » | dump inchangé | `tests/purge_refusee/` | à faire |
| EDREGUL-T04 | replay | Période vide | période sans mouvement, `Effmvts` cochée, « Oui » | « Aucun mouvement… », puis question et message de succès (A02 figée) | `tests/periode_vide/` | à faire |
| EDREGUL-T05 | replay | Saisie des dates | `0101` + Entrée, `1.1.20` + Tab, fin < début | dates normalisées ; avertissement | `tests/saisie_dates/` | à faire |
| EDREGUL-T06 | replay | Date quittée à la souris | `0101` puis clic sur Imprimer | date non normalisée transmise au SQL (A03, à observer) | `tests/date_souris/` | à faire |
| EDREGUL-T07 | replay | Saut de page | 60 mouvements dans la période | 2 pages, en-tête répété | `tests/saut_page/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` n'a aucun mouvement `Fiches_Mvtexp`. Jeu dérivé `editions_gestion`
  (voir [Edbr](../Edbr.module/test.md)) : régularisations sur 3 articles dans et hors de la
  période (dont un même article des deux côtés pour T02), un article supprimé de `Fiches_Art`,
  60 lignes pour T07.
- **Comparaison** : `pdftotext` (sans la date d'édition), dump normalisé, `Exec_SQL` (informatif :
  N+1 lectures d'articles, un `DELETE` par ligne).
- **Rejeu** : `Utils.Observers(Me)` est appelé dans `_New` ; pas de grille (pas de `replay_dynamic`).
- **Non testable automatiquement** : son (`Music.Play`), couleurs de focus.
