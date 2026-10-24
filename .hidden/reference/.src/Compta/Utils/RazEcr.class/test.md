# RazEcr — Tests

> Source : `.src/Compta/Utils/RazEcr.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RAZECR-T01 | replay | Lancement par `Prgm`, Lancer, Quitter | saisie `RazEcr`, clic Lancer puis Quitter | fenêtre ouverte puis fermée ; dump inchangé | `tests/razecr_sans_effet/` | à faire |

## Détail des tests

- Test de caractérisation qui prouve l'absence d'effet avant suppression (RAZECR-A01) ; recoupe
  PRGM-T02.
