# Comptabilite — Tests

> Source : `.src/Compta/Utils/Comptabilite.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module sans fonction : il n'est testable qu'à travers le protocole de sélection d'écriture.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMPTABILITE-T01 | replay | Sélection d'écriture depuis `Saisecrit` | Saisie d'écritures, recherche d'écriture (F-touche / bouton), choix d'une ligne dans `TriEcritures` ; puis abandon | écriture chargée dans `Saisecrit` ; rien sur abandon | `tests/comptabilite_saisecrit/` | à faire : passe par Saisecrit (écran complexe) |
| COMPTABILITE-T02 | replay | Sélection d'écriture depuis `Tresor` | idem depuis l'écran Trésorerie | numéro, libellé et journal repris | `tests/comptabilite_tresor/` | implémenté (`Compta/comptabilite_tresor`, jeu `ecritures_shared/ecritures_base` : journal 50, ToggleButton6, Choix1 index 2 → `ecritv`, 1re ligne de TriEcritures, « Oui » → écriture n° 2 recopiée dans Fiches_MvtM ; sql.log comparé, Fiches_MvtM vidée à la sortie) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** sur `Laurux01.sql`
  (log des valeurs des champs après sélection).
- Ces scénarios recoupent ceux de `SAISECRIT` et `TRESOR` ; ils seront fusionnés lors de la
  phase 2 si les mêmes enregistrements suffisent.
- `TresorFac`/`TriEcritures2` (apparemment morts) ne sont pas testés.
- **Phase 2, vague 5** : aucun test implémentable. `Comptabilite.Bsel` n'est mis à `True` que par `TriEcritures.Ecrit_Click`,
  ouvert par `Saisecrit.ecritnv/ecritv` (classe complexe) ou par les méthodes homonymes de `Tresor` (lignes 782-812),
  appelées par `Tresor.Choix1_Click` (l. 1366-1368) depuis la liste ouverte par `ToggleButton6_Click` : T02 est donc
  atteignable par l'écran Trésorerie (correction du 2026-11-13 : ce ne sont pas du code mort).
