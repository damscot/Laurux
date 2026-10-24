# Raz — Tests

> Source : `.src/Communs/Raz.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZ-T01 | replay | Remise à non stocké | `Laurux01.sql` (articles stockés et non stockés) ; `Prgm` → `Raz` → Lancer → OK | dump `Fiches_Art` : `art_stocke = 0` partout, autres colonnes inchangées ; « Traitement terminé ! » | `tests/raz_ok/` | à faire |
| RAZ-T02 | replay | Refus | Lancer → Non | dump inchangé | `tests/raz_non/` | à faire |
| RAZ-T03 | replay | Table vide | jeu dérivé sans article ; Lancer → OK | aucun message, dump inchangé | `tests/raz_vide/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié. Après RAZ-002 (UPDATE unique), le
  dump doit rester identique ; le diff `Exec_SQL` est informatif.
