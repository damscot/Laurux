# FJournaux — Tests

> Source : `.src/Compta/Tables/FJournaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie d'une table : tests `replay` avec diff de `Fiches_Journaux`. Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FJOURNAUX-T01 | replay | Création d'un journal | menu Journaux ; `20`, `Achats divers`, `AC`, compte vide ; Enregistrer | ligne ajoutée | `tests/creation/` | à faire |
| FJOURNAUX-T02 | replay | Journal de trésorerie | `51`, `Banque 2`, `TR`, F2 → choix d'un compte 512 ; puis `TR` sans compte ; puis `AC` avec compte | ligne ajoutée ; messages de refus | `tests/tresorerie/` | à faire |
| FJOURNAUX-T03 | replay | Modification | sélection du journal `60`, libellé modifié ; puis code `70` saisi avec `60` sélectionné | UPDATE sur la ligne sélectionnée ; conflit de clé silencieux (A02 figée) | `tests/modification/` | à faire |
| FJOURNAUX-T04 | replay | Libellé avec apostrophe | `21`, `Journal d'achats`, `AC` | aucune écriture, aucun message (A01 figée) | `tests/apostrophe/` | à faire |
| FJOURNAUX-T05 | replay | Suppression et contrôles | suppression du journal `10` (utilisé par des écritures) ; code non numérique `AB` ; touche Tab sur Enregistrer | journal supprimé (A03 figée) ; message numérique ; enregistrement déclenché (A04) | `tests/suppression_controles/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (journaux 10, 50, 53, 60, 70, 90).
- **Comparaison** : dump normalisé de `Fiches_Journaux` ; messages relevés par le replay.
- **Non testable** : son et couleurs.
