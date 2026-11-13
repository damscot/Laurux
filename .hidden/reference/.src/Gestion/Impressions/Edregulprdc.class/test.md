# Edregulprdc — Tests

> Source : `.src/Gestion/Impressions/Edregulprdc.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` (comparaison `pdftotext` de `~/tmp/Regul.pdf`, `Exec_SQL`, dump de
`Fiches_Mvtexpdc`), valeurs attendues produites dans le clone **Laurux non modifié**, horloge
figée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDREGULPRDC-T01 | replay | Impression | 2 fabrications (`mind` 1 et 2) partageant un composant, dans la période | texte du PDF avec séparateur entre `mind` ; dump inchangé | `tests/impression/` | implémenté |
| EDREGULPRDC-T02 | replay | Purge | idem + une 3e fabrication hors période utilisant le même composant ; `Effmvts`, « Oui » | lignes du composant de la 3e fabrication **aussi** supprimées (A01 figée) | `tests/purge/` | implémenté |
| EDREGULPRDC-T03 | replay | Période vide | période sans mouvement, `Effmvts`, « Oui » | message, question, message de succès (A02 figée) | `tests/periode_vide/` | implémenté |
| EDREGULPRDC-T04 | replay | Saisie des dates | abrégées + Entrée/Tab ; fin < début | dates normalisées, avertissement, fond `&HF9F9BD&` | `tests/saisie_dates/` | implémenté (couleur de fond non comparée) |
| EDREGULPRDC-T05 | replay | Saut de page | 60 lignes | 2 pages | `tests/saut_page/` | implémenté |

## Détail des tests

- **Données** : jeu dérivé `editions_gestion` (voir [Edbr](../Edbr.module/test.md)) ; les lignes
  `Fiches_Mvtexpdc` peuvent être produites par le replay de `MvtProdcomp` dans le clone non
  modifié, puis figées dans le script SQL du jeu.
- **Comparaison** : `pdftotext` sans date d'édition ; dump normalisé (`id` auto-incrémenté
  conservé : la purge ne recrée rien).
- **Non testable automatiquement** : son, couleurs de focus (seule la couleur de fond peut être
  lue dans le log des contrôles si `ReplayObserver` la journalise — à confirmer).
- **Implémentation (vague 5)** : jeu `.hidden/Tests/Gestion/assets/edregulprdc_shared/edregulprdc_base.sql`
  (fabrications 1 et 2 dans la période par défaut 15.06.2014 - 15.06.2018, fabrication 3 au 20/06/2018 avec les
  mêmes codes) ; scénarios `edregulprdc_impression` (T01), `edregulprdc_purge` (T02 : la table est vidée, y compris
  la fabrication 3, A01), `edregulprdc_periode_vide` (T03, jeu `edregulprdc_vide.sql`, A02),
  `edregulprdc_saisie_dates` (T04 : « 0101 » → 01.01.2018, « 010117 » → 01.01.2017, avertissement),
  `edregulprdc_saut_page` (T05, jeu `edregulprdc_soixante.sql`). Texte du PDF par `pdftotext` (`edition.txt`).
