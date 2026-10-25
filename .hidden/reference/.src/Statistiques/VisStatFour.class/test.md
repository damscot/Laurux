# VisStatFour — Tests

> Source : `.src/Statistiques/VisStatFour.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Écran non rejouable** : `_New` n'appelle pas `Utils.Observers(Me)`, ses clics ne sont ni
journalisés ni rejoués. Tant que VISSTATFOUR-A03 n'est pas validée, les tests sont soit
manuels (procédure écrite, captures comparées), soit des `gbtest` sur les fonctions extraites
après VISSTATFOUR-005. Après A03, les scénarios ci-dessous deviennent des `replay` (ne pas
cliquer dans `Liste`, `replay_missing`). Données : `Total` produit par
[StatFour](../StatFour.class/test.md) (jeu `statistiques_ventes`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISSTATFOUR-T01 | replay | Affichage initial (manuel avant A03) | STATFOUR-T01 | grille triée par code, % = (N − N-1) / N (A01 figée) | `tests/visstatfour_affichage/` | à faire |
| VISSTATFOUR-T02 | replay | Tris (manuel avant A03) | `Bnom`, `Ca`, `Ca1`, `Bcode` | ordres attendus | `tests/visstatfour_tris/` | à faire |
| VISSTATFOUR-T03 | replay | Impression (manuel avant A03) | > 60 fournisseurs, Imprimer | texte PDF ; titre 2e page « CA clients » (A02 figée) | `tests/visstatfour_pdf/` | à faire |
| VISSTATFOUR-T04 | gbtest | `LignesTotal` (après VISSTATFOUR-005) | `Total` de STATFOUR-T01 et T02 | lignes et % identiques aux captures T01 | `tests/visstatfour_lignes/` | à faire |

## Détail des tests

- Valeurs attendues capturées dans le clone **non modifié** (grille relevée à la main ou par
  capture d'écran pour T01-T02 avant A03 ; PDF par `CmdVis` + `pdftotext`).
- T04 est le seul test automatisable sans modifier le comportement : à privilégier en phase 2.
