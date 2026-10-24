# Renech — Tests

> Source : `.src/Compta/Utils/Renech.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RENECH-T01 | gbtest | Réimport nominal | `Laurux01.sql` ; `~/Dtech.txt` produit par `RecupDech` (RECUPDECH-T01) après modification des `dateech` en base | dump `Fiches_Mvt` (colonne `dateech`) identique à l'état d'origine | `tests/renech_aller_retour/` | à faire |
| RENECH-T02 | gbtest | Fichier absent, ligne vide, date avec heure | `HOME` sans fichier ; fichier avec ligne vide ; date `08/31/2024 10:00:00` | erreurs d'exécution et valeur stockée figées (A01) | `tests/renech_cas_limites/` | à faire |
| RENECH-T03 | replay | Lancement par `Prgm` | saisie `Renech` | même dump que T01 ; `Message.Info` | `tests/renech_prgm/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié**, `HOME` isolé ; base
  restaurée avant chaque test.
- Variante SQLite de T01 pour figer la valeur stockée dans `dateech` (à confirmer).
