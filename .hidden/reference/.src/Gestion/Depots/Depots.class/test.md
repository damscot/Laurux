# Depots — Tests

> Source : `.src/Gestion/Depots/Depots.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Depots`, `Fiches_StkDepots` et `Fiches_Sdepots`. Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DEPOTS-T01 | replay | Création avec initialisation du stock | menu Dépôts ; `03`, `Dépôt 2`, adresse ; Enregistrer ; Oui | dépôt inséré + une ligne `Fiches_StkDepots` (qte 0) par article | `tests/creation_init/` | implémenté |
| DEPOTS-T02 | replay | Modification | clic `02` ; ville modifiée ; Enregistrer | UPDATE | `tests/modification/` | implémenté |
| DEPOTS-T03 | replay | Suppression | sélection `02` (stock + mouvements) ; Oui, Oui | dépôt, stock et mouvements supprimés | `tests/suppression/` | implémenté |
| DEPOTS-T04 | replay | Filtre et tri | en-tête Libellé, frappe `Dé`, double-clic | filtre/tri (log de rejeu) ; en-tête `CP` vidé après rafraîchissement (A03 figée) | `tests/filtre_tri/` | implémenté partiellement (gb.test `DepotsTest.T04FiltreTri` : BD_GotFocus, BD_DblClick × 2, CP_DblClick, Refresh appelés directement, ordre lu dans `Utils.rs1`, en-tête CP vidé par Refresh : A03 figée) ; à faire : frappe « Dé » dans l'en-tête (BD_KeyPress lit `Key.Text`, non simulable en gb.test ; clic d'en-tête non rejouable) |
| DEPOTS-T05 | replay | Protection du magasin | sélection `01` ; Supprimer | message, aucune écriture | `tests/protection_01/` | implémenté |

## Détail des tests

- **Données** : `Laurux01.sql` (dépôts `01`, `02`, articles de démonstration) ; jeu dérivé avec
  stock et mouvements pour `02` (T03).
- **Comparaison** : dump normalisé des trois tables.
- **Implémentation (vague 5)** : option `/Soc01/Depots` = -1 (meta.json) ; scénarios `depots_creation_init` (T01,
  libellé « Depot 3 » sans accent : 3 lignes `Fiches_StkDepots` à 0), `depots_modification` (T02 : les champs
  vides deviennent NULL), `depots_suppression` (T03, jeu `depots_stock02.sql` : stock et mouvements du 02 supprimés,
  ceux du 01 conservés), `depots_protection_01` (T05). Ligne de grille cliquée par `Click=<ligne>x0@Coldepot`.
