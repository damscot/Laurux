# gridvi2 — Tests

> Source : `.src/Utils/gridvi2.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe morte : aucun comportement observable à figer. La seule vérification utile est l'absence
de régression à la suppression.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| GRIDVI2-T01 | gbtest | Absence de référence | `gbc3 -agt` après suppression ; `grep -rni gridvi2 .src` | compilation sans erreur, aucune occurrence | `tests/suppression/` | à faire |

## Détail des tests

- T01 est un contrôle de build plus qu'un test fonctionnel ; il peut être porté par le script de
  validation de phase 4 plutôt que par un module gb.test.
- Les replays de [`gridvi`](../gridvi.class/test.md) (T01-T08) doivent rester verts après la
  suppression (ils prouvent que la classe vivante n'est pas touchée).
