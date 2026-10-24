# Equilibrage — Tests

> Source : `.src/Compta/Utils/Equilibrage.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` lancés depuis `Prgm` (nom `Equilibrage`). Jeu dérivé de `Laurux01.sql` contenant des
écritures du journal `70` : équilibrées, déséquilibrées au crédit, déséquilibrées sans crédit,
avec deux lignes sur le même compte, et une écriture déséquilibrée en **dernière position**.
Comparaison : dump de `Fiches_Mvt` (dont `control`) et `Fiches_Comptes`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EQUILIBRAGE-T01 | replay | Rééquilibrage | jeu décrit ci-dessus, bouton Lancer | dump de référence (dernière écriture non corrigée, `control` inchangé) | `tests/reequilibrage/` | à faire |
| EQUILIBRAGE-T02 | replay | Aucune écriture du journal 70 | `Laurux01.sql` brut | aucun UPDATE, message « Traitement terminé » | `tests/vide/` | à faire |
| EQUILIBRAGE-T03 | replay | Fermeture | bouton Fermer | aucune requête de modification | `tests/fermeture/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; T01 fige les anomalies A01 à
  A03.
- Pour un rework qui passe les cumuls en `Float`, le dump doit rester identique (arrondi `0.00`).
