# RecupDech — Dépendances

> Source : `.src/Compta/Utils/RecupDech.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/RecupDech.class` — classe, formulaire associé `RecupDech.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `run` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Mvt`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Lancement** : uniquement `Prgm.class:83` (`RecupDech.Run()`, appel statique).
- **Formulaire mort** : grep `RecupDech` → aucune ouverture du formulaire (ni `Show`, ni `New`) ;
  `Button2_Click` n'est jamais exécuté, `Button1` n'a pas de handler.
- **Fichier produit** : `~/tmp/Dtech.txt`, consommé (à `~/Dtech.txt`) par
  [`Renech`](../Renech.class/dependencies.md).
- Aucun appel dynamique ; aucune dépendance circulaire.
