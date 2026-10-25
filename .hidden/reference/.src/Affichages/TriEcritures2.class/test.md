# TriEcritures2 — Tests

> Source : `.src/Affichages/TriEcritures2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe **morte** : aucun écran ne l'ouvre, aucun replay n'est possible.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIECRITURES2-T01 | gbtest | Absence de référence (avant TRIECRITURES2-A01) | `grep -rnw "TriEcritures2"` sur `.src`, recherche en chaîne ; `gbc3 -agt` après suppression | aucune référence ; compilation sans erreur | `tests/absence_reference/` | à faire |

## Détail des tests

- **Pas de replay** : la sélection d'écritures est couverte par `TRIECRITURES-T01` à `T05`.
- T01 est un contrôle de construction (étape de validation de l'anomalie), pas un module gb.test au
  sens strict.
