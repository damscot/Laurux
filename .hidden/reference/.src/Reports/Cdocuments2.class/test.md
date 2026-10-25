# Cdocuments2 — Tests

> Source : `.src/Reports/Cdocuments2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe jamais instanciée : aucun comportement observable à figer. Les tests vérifient seulement
que la suppression prévue (CDOCUMENTS2-001) ne change rien.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CDOCUMENTS2-T01 | replay | Édition des documents de vente sans `Cdocuments2` | jeu `facturation_base` : impression d'une facture, d'un BL et d'un devis depuis `Facture` (chaîne `OptFac` → `ObjFacB` → `EditfacB`) avec trace `gbx3 -t` | aucune ligne de `Cdocuments2` exécutée ; PDF (texte `pdftotext`) identiques avant/après suppression | `tests/sans_cdocuments2/` | à faire |
| CDOCUMENTS2-T02 | gbtest | Compilation après suppression | suppression de la classe et de `Facture.class:200` | `gbc3 -agt` sans erreur ; `./Laurux -T all` vert | `tests/compilation/` | à faire |

## Détail des tests

- **Valeurs attendues** : T01 réutilise les PDF de référence produits pour
  [Editfac](../Editfac.class/test.md) dans le clone Laurux non modifié ; la trace `gbx3 -t`
  sert seulement à confirmer l'absence d'exécution.
- **Données** : jeu `facturation_base` défini dans
  [ObjFac/test.md](../../Gestion/Facturation/ObjFac.class/test.md).
- **Non testable** : le rendu « deux exemplaires » lui-même, jamais produit depuis 2019.
