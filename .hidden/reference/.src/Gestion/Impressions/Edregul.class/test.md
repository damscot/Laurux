# Edregul — Tests

> Source : `.src/Gestion/Impressions/Edregul.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` avec comparaison du texte extrait de `~/tmp/Regul.pdf`
(`pdftotext -layout`, date d'édition masquée), des lignes `Exec_SQL` du log et du dump normalisé
de `Fiches_Mvtexp`. Valeurs attendues produites dans le clone **Laurux non modifié** ; horloge
figée (`faketime`) car les dates par défaut dépendent de `Now`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDREGUL-T01 | replay | Impression d'une période | dates saisies + Entrée ; Imprimer, `Effmvts` décochée | texte du PDF (dont « Article inexistant ») ; dump inchangé | `tests/impression_periode/` | implémenté |
| EDREGUL-T02 | replay | Purge | `Effmvts` cochée, « Oui » | dump `Fiches_Mvtexp` : mouvements hors période du même article **aussi** supprimés (A01 figée) | `tests/purge/` | implémenté |
| EDREGUL-T03 | replay | Purge refusée | `Effmvts` cochée, « Non » | dump inchangé | `tests/purge_refusee/` | implémenté |
| EDREGUL-T04 | replay | Période vide | période sans mouvement, `Effmvts` cochée, « Oui » | « Aucun mouvement… », puis question et message de succès (A02 figée) | `tests/periode_vide/` | implémenté |
| EDREGUL-T05 | replay | Saisie des dates | `0101` + Entrée, `1.1.20` + Tab, fin < début | dates normalisées ; avertissement | `tests/saisie_dates/` | implémenté |
| EDREGUL-T06 | replay | Date quittée à la souris | `0101` puis clic sur Imprimer | date non normalisée transmise au SQL (A03, à observer) | `tests/date_souris/` | implémenté |
| EDREGUL-T07 | replay | Saut de page | 60 mouvements dans la période | 2 pages, en-tête répété | `tests/saut_page/` | implémenté |

## Détail des tests

- **Données** : `Laurux01.sql` n'a aucun mouvement `Fiches_Mvtexp`. Jeu dérivé `editions_gestion`
  (voir [Edbr](../Edbr.module/test.md)) : régularisations sur 3 articles dans et hors de la
  période (dont un même article des deux côtés pour T02), un article supprimé de `Fiches_Art`,
  60 lignes pour T07.
- **Comparaison** : `pdftotext` (sans la date d'édition), dump normalisé, `Exec_SQL` (informatif :
  N+1 lectures d'articles, un `DELETE` par ligne).
- **Rejeu** : `Utils.Observers(Me)` est appelé dans `_New` ; pas de grille (pas de `replay_dynamic`).
- **Non testable automatiquement** : son (`Music.Play`), couleurs de focus.
- **Implémentation (vague 5)** : jeu `.hidden/Tests/Gestion/assets/edregul_shared/edregul_base.sql` (3 mouvements
  dans la période par défaut 15.06.2014 - 15.06.2018 dont l'article inexistant ZZZ, 2 après dont l'article 001) ;
  scénarios `edregul_impression_periode` (T01, période par défaut non ressaisie), `edregul_purge` (T02 : le
  mouvement 001 du 20/06/2018 est aussi supprimé, A01), `edregul_purge_refusee` (T03), `edregul_periode_vide` (T04,
  jeu `edregul_vide.sql` : trois boîtes, A02), `edregul_saisie_dates` (T05), `edregul_date_souris` (T06),
  `edregul_saut_page` (T07, jeu `edregul_soixante.sql`). Texte du PDF par `pdftotext` (`edition.txt`).
- **Observé (T05)** : « 0101 » + Entrée donne bien 01.01.2018, mais « 1.1.17 » + Entrée n'est pas normalisé :
  la requête reçoit `daterecpt <= '....'` (l'avertissement fin < début s'affiche quand même).
- **Observé (T06, A03)** : « 0101 » quitté par un clic sur Imprimer est transmis tel quel : `daterecpt >= '0101101'`.
