# FLibelle — Tests

> Source : `.src/Compta/Tables/FLibelle.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie : `replay` avec diff de `Fiches_Libelles`. Valeurs attendues produites dans le
clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FLIBELLE-T01 | replay | Création au clavier | `5`, Entrée, `Virement "SEPA" & frais`, Entrée, Enregistrer | ligne `5` avec le texte transformé par `Utils.Remplace` | `tests/creation/` | à faire |
| FLIBELLE-T02 | replay | Modification | sélection `3`, intitulé `Chèque` | UPDATE de la ligne `3` | `tests/modification/` | à faire |
| FLIBELLE-T03 | replay | Suppression | sélection `4` puis saisie `2` sans changer la sélection, Supprimer | c'est la ligne sélectionnée qui est supprimée (A01 figée) | `tests/suppression/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (libellés 1 à 4).
- **Comparaison** : dump normalisé de `Fiches_Libelles`.
- **Non testable** : couleurs de fond.
