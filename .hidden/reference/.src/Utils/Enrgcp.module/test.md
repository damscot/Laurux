# Enrgcp — Tests

> Source : `.src/Utils/Enrgcp.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ENRGCP-T01 | gbtest | `Ecp` nouveau couple | `Laurux01.sql` ; `("99999", "TESTVILLE")` | une ligne ajoutée dans `Fiches_Cpostaux` (dump comparé) | `tests/ecp_ajout/` | à faire |
| ENRGCP-T02 | gbtest | `Ecp` couple existant, casse différente, CP vide, ville vide | couple déjà présent ; `("99999", "testville")` ; `("", "X")` ; `("99998", "")` | dump `Fiches_Cpostaux` de référence (MySQL et SQLite) | `tests/ecp_cas_limites/` | à faire |

## Détail des tests

- Données : `Laurux01.sql` importé dans le MariaDB Docker, puis `Laurux01.sqlite` pour la variante
  SQLite. Dump normalisé de `Fiches_Cpostaux` comparé à celui du clone **Laurux non modifié**.
