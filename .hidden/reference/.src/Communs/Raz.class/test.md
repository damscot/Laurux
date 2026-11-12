# Raz — Tests

> Source : `.src/Communs/Raz.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZ-T01 | replay | Remise à non stocké | `Laurux01.sql` (articles stockés et non stockés) ; `Prgm` → `Raz` → Lancer → OK | dump `Fiches_Art` : `art_stocke = 0` partout, autres colonnes inchangées ; « Traitement terminé ! » | `tests/raz_ok/` | implémenté |
| RAZ-T02 | replay | Refus | Lancer → Non | dump inchangé | `tests/raz_non/` | implémenté |
| RAZ-T03 | replay | Table vide | jeu dérivé sans article ; Lancer → OK | aucun message, dump inchangé | `tests/raz_vide/` | implémenté |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié. Après RAZ-002 (UPDATE unique), le
  dump doit rester identique ; le diff `Exec_SQL` est informatif.
- **Implémentation (phase 2)** : scénarios `.hidden/Tests/Communs/assets/raz_raz_ok`, `raz_raz_non` (jeu
  `.hidden/Tests/Communs/assets/raz_shared/raz_stockes.sql` : 2 articles sur 3 stockés, `Laurux01.sql` n'en a aucun) et `raz_raz_vide` (jeu
  `articles_vide`). Réponses : bouton 1 « OK » (Entrée), bouton 2 « Non » (Tab + Espace) ; l'absence de message
  final en T03 est vérifiée par le clic Quitter sur `Raz` (échouerait si `FMessage` était active).
