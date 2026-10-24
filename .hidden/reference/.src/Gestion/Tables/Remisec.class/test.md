# Remisec — Tests

> Source : `.src/Gestion/Tables/Remisec.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de table : tests `replay` avec diff de `Fiches_RemTypec`. Valeurs attendues produites dans
le clone **Laurux non modifié** (anomalies figées).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| REMISEC-T01 | replay | Création | type `01` (liste `Coltype`), famille `F1` (liste `Colfam`), remise `7,5` ; Entrée sur le bouton | ligne `Fiches_RemTypec` (`remise = 7.5`) ; grille rafraîchie, ligne sélectionnée ensuite (A03 figée) | `tests/creation/` | à faire |
| REMISEC-T02 | replay | Modification | sélection d'une ligne de la grille, remise `10` ; Enregistrer | `remise` mise à jour | `tests/modification/` | à faire |
| REMISEC-T03 | replay | Saisie invalide | type et famille inexistants, remise `abc` | bulles ; ligne enregistrée quand même (REMISEC-A01 figée) | `tests/saisie_invalide/` | à faire |
| REMISEC-T04 | replay | Suppression | sélection, Supprimer, Oui | ligne supprimée | `tests/suppression/` | à faire |
| REMISEC-T05 | replay | Affichage de la grille | remises `7,5`, `12,345`, `0` ; tri par clic sur l'en-tête ; recherche (clic droit) | textes affichés dans la colonne « Remise » (format dégradé, A02 figée) ; ordre des lignes | `tests/affichage_grille/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (types de client, familles) + 3 lignes `Fiches_RemTypec`.
- **Comparaison** : dump normalisé de `Fiches_RemTypec` ; textes de la grille relevés par le
  replay (T01, T05).
- **Phase 2** : la grille `Tabtypec` est un `GridView` dont les événements sont détournés vers
  `RichDataGrid` ; `Remisec` n'a pas de `Tabtypec_Click` : vérifier que `ReplayObserver` rejoue
  bien la sélection (sinon adapter le harnais, comme pour `Saisecrit.Ecrit1`).
- **Non testable** : bulles (`Balloon`) autrement que par le journal, son.
