# Edinv1 — Tests

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/Edinv1.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDINV1-T01 | replay | Non-régression de la suppression | parcours de tous les menus d'inventaire de `Fmenu` (81-100, 232, 233) | aucun écran ne référence `Edinv1` ; `gbc3 -agt` passe après suppression | `tests/suppression/` | à faire |

## Détail des tests

- Classe inatteignable depuis l'interface : aucun test fonctionnel possible. Le seul test vérifie
  que sa suppression (anomalie EDINV1-A01, si validée) ne casse rien : compilation `gbc3 -agt` et
  ouverture des écrans d'inventaire.
- Le comportement équivalent est couvert par EDINV-T01 à T07.
