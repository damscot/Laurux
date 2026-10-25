# ticpe — Tests

> Source : `.src/Gestion/option/ticpe.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul sans appelant : tests `gbtest` de caractérisation de l'API existante, valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TICPE-T01 | gbtest | Construction | `New Ticpe("411001")` ; code inexistant ; `Result` de `Fiches_Cli` ; `Result` de `Fiches_AdrlivC` ; `Null` | objet créé ; erreur « Client innexistant » ; objet créé ×3 | `tests/construction/` | à faire |
| TICPE-T02 | gbtest | Fabrique `_call` | `ticpe("411001")` ; `ticpe(Null)` | objet ; erreur figée (paramètre manquant, à confirmer) | `tests/fabrique/` | à faire |
| TICPE-T03 | gbtest | Propriétés | objet de T01 | `categorie` = `["GNR détaxé", "Carburant"]` ; `date`, `NumAgri`, `NumCarb`, `region` vides | `tests/proprietes/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + `modfichier.fichiercarbu` (jeu `option_carbu`).
- `Valide` n'est pas testée (requête invalide, code mort supprimé par TICPE-002).
