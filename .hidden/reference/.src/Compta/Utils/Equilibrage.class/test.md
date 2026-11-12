# Equilibrage — Tests

> Source : `.src/Compta/Utils/Equilibrage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` lancés depuis `Prgm` (nom `Equilibrage`). Jeu dérivé de `Laurux01.sql` contenant des
écritures du journal `70` : équilibrées, déséquilibrées au crédit, déséquilibrées sans crédit,
avec deux lignes sur le même compte, et une écriture déséquilibrée en **dernière position**.
Comparaison : dump de `Fiches_Mvt` (dont `control`) et `Fiches_Comptes`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EQUILIBRAGE-T01 | replay | Rééquilibrage | jeu décrit ci-dessus, bouton Lancer | dump de référence (dernière écriture non corrigée, `control` inchangé) | `tests/reequilibrage/` | implémenté |
| EQUILIBRAGE-T02 | replay | Aucune écriture du journal 70 | `Laurux01.sql` brut | aucun UPDATE, message « Traitement terminé » | `tests/vide/` | implémenté |
| EQUILIBRAGE-T03 | replay | Fermeture | bouton Fermer | aucune requête de modification | `tests/fermeture/` | implémenté |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; T01 fige les anomalies A01 à
  A03.
- Pour un rework qui passe les cumuls en `Float`, le dump doit rester identique (arrondi `0.00`).
- **Implémentation (phase 2, vague 3)** : scénarios `.hidden/Tests/Compta/assets/equilibrage_{reequilibrage,vide,fermeture}/`
  (Prgm `Equilibrage`, boutons du groupe `Btn` : `Button2` tag 1, `Button6` tag 2). Jeu propre à T01 :
  `equilibrage_reequilibrage/equilibrage_jeu.sql` (n°1 équilibrée, n°2 crédit insuffisant → 707000 passé à 100,
  n°3 sans crédit ignorée, n°4 deux lignes 707000 toutes deux passées à 30 (A03), n°5 dernière non corrigée (A01),
  n°6 journal 60 ignorée ; `control` inchangé (A02)).
