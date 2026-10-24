# VisPmp — Tests

> Source : `.src/Utils/VisPmp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISPMP-T01 | replay | PMP négatifs | jeu dérivé : 2 articles `art_pmp < 0` | `~/Pmp.txt` de référence | `tests/pmp_negatifs/` | à faire |
| VISPMP-T02 | replay | Aucun PMP négatif | `Laurux01.sql` | message « aucun pmp », fichier vide | `tests/aucun/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `Pmp` ; `HOME` de test,
  éditeur neutralisé. Comparaison du fichier ; diff BDD vide.
