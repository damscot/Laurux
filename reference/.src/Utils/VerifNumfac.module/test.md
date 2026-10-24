# VerifNumfac — Tests

> Source : `.src/Utils/VerifNumfac.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VERIFNUMFAC-T01 | gbtest | Compilation sans le module | suppression du fichier | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| VERIFNUMFAC-T02 | gbtest | `Dnfac` (si le module est conservé) | `Laurux01.sql` ; `Nfac` = dernier numéro, numéro avec trou, `Materiel` = 0/1 | numéros de référence | `tests/dnfac/` | à faire |

## Détail des tests

- T02 n'est utile que si l'utilisateur refuse la suppression (VERIFNUMFAC-001) ; il nécessite la base
  Docker (module gb.test avec connexion `Utils.db`). Valeurs attendues générées dans le clone non modifié.
