# Depots — Tests

> Source : `.src/Gestion/Depots/Depots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Depots`, `Fiches_StkDepots` et `Fiches_Sdepots`. Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DEPOTS-T01 | replay | Création avec initialisation du stock | menu Dépôts ; `03`, `Dépôt 2`, adresse ; Enregistrer ; Oui | dépôt inséré + une ligne `Fiches_StkDepots` (qte 0) par article | `tests/creation_init/` | à faire |
| DEPOTS-T02 | replay | Modification | clic `02` ; ville modifiée ; Enregistrer | UPDATE | `tests/modification/` | à faire |
| DEPOTS-T03 | replay | Suppression | sélection `02` (stock + mouvements) ; Oui, Oui | dépôt, stock et mouvements supprimés | `tests/suppression/` | à faire |
| DEPOTS-T04 | replay | Filtre et tri | en-tête Libellé, frappe `Dé`, double-clic | filtre/tri (log de rejeu) ; en-tête `CP` vidé après rafraîchissement (A03 figée) | `tests/filtre_tri/` | à faire |
| DEPOTS-T05 | replay | Protection du magasin | sélection `01` ; Supprimer | message, aucune écriture | `tests/protection_01/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (dépôts `01`, `02`, articles de démonstration) ; jeu dérivé avec
  stock et mouvements pour `02` (T03).
- **Comparaison** : dump normalisé des trois tables.
