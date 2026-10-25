# Statcai — Tests

> Source : `.src/Caisse/Statcai.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` depuis le menu Gestion › Caisse › CA horaire (`Fmenu.Menu204`).
`Utils.Observers(Me)` est appelé une seule fois dans `_New` : rejouable. **Ne pas cliquer dans la
grille `Liste`** (`replay_missing`). Comparaisons : dump de la table de travail `Total`, valeurs
de la grille et de `Totc` relevées dans le journal, messages.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATCAI-T01 | replay | CA horaire d'une journée | `caisse_base` + tickets archivés (`Fiches_HisEntTickets`) à 7 h, 9 h, 9 h, 14 h, 21 h sur deux caisses ; date choisie, « Rafraîchir » | `Total` et grille : 7 h cumulé sur 8 h, 21 h sur 19 h, total général | `tests/ca_horaire/` | à faire |
| STATCAI-T02 | replay | Tickets en cours | mêmes heures dans `Fiches_EntTicketz` (`statut` `0` et `V`) | figer : tickets en cours ignorés (A01) | `tests/tickets_en_cours/` | à faire |
| STATCAI-T03 | replay | Doublon entre tables | même heure et même CA dans les deux tables | figer : une seule ligne comptée (`union`, A03) | `tests/doublon_union/` | à faire |
| STATCAI-T04 | replay | Aucune caisse / tickets supprimés | table des caisses vide ; ticket `suppr = 1` | message « Aucune donnée » ; ticket supprimé exclu | `tests/cas_limites/` | à faire |
| STATCAI-T05 | replay | Base SQLite | `Laurux01.sqlite` + jeu de T01 | figer le message « problème sur une ligne de CA » (`HOUR`, A02) | `tests/sqlite/` | à faire |
| STATCAI-T06 | gbtest | Calcul pur (après STATCAI-004) | jeu de T01, `CaHoraire(date)` | collection caisse × heure identique à T01 | `tests/ca_horaire_calcul/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié**.
- **Données** : jeu dérivé `caisse_base` + tickets `Fiches_HisEntTickets`/`Fiches_EntTicketz`
  (`mht` au format `"12,50"`) sur une date fixe.
- **Non testable automatiquement** : largeur des colonnes (dépend du `.form`).
- T02, T03 et T05 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
