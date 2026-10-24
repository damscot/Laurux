# Comptabilite — Tests

> Source : `.src/Compta/Utils/Comptabilite.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans fonction : il n'est testable qu'à travers le protocole de sélection d'écriture.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMPTABILITE-T01 | replay | Sélection d'écriture depuis `Saisecrit` | Saisie d'écritures, recherche d'écriture (F-touche / bouton), choix d'une ligne dans `TriEcritures` ; puis abandon | écriture chargée dans `Saisecrit` ; rien sur abandon | `tests/comptabilite_saisecrit/` | à faire |
| COMPTABILITE-T02 | replay | Sélection d'écriture depuis `Tresor` | idem depuis l'écran Trésorerie | numéro, libellé et journal repris | `tests/comptabilite_tresor/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** sur `Laurux01.sql`
  (log des valeurs des champs après sélection).
- Ces scénarios recoupent ceux de `SAISECRIT` et `TRESOR` ; ils seront fusionnés lors de la
  phase 2 si les mêmes enregistrements suffisent.
- `TresorFac`/`TriEcritures2` (apparemment morts) ne sont pas testés.
