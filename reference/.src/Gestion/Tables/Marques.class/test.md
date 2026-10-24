# Marques — Tests

> Source : `.src/Gestion/Tables/Marques.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Marques`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MARQUES-T01 | replay | Création | menu Marques ; `100`, `Stihl` ; Enregistrer | INSERT | `tests/creation/` | à faire |
| MARQUES-T02 | replay | Modification | clic `100` ; `Stihl SA` ; Enregistrer | UPDATE de l'intitulé | `tests/modification/` | à faire |
| MARQUES-T03 | replay | Code alphabétique | frappe `ABC` dans le code | caractères refusés (A02 figée) | `tests/code_alpha/` | à faire |
| MARQUES-T04 | replay | Filtre et tri | en-tête Intitulé, frappe `St`, double-clic | filtre et tri décroissant (log) | `tests/filtre_tri/` | à faire |
| MARQUES-T05 | replay | Suppression | sélection `100` ; Supprimer, Oui | ligne supprimée | `tests/suppression/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (table vide) ; jeu dérivé de quelques marques pour T02-T05.
- **Comparaison** : dump normalisé de `Fiches_Marques` ; T03-T04 par le log de rejeu.
