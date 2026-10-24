# Csolde — Dépendances

> Source : `.src/Utils/Csolde.module` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Csolde.module` — module
- Handlers GUI détectés : 0

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `Solde_caisse` |
| `.src/Compta/Impressions/BordereauxC.class` | `Solde_caisse` |
| `.src/Compta/Utils/Epurjdv.class` | `Recalc_solde` |
| `.src/Compta/Utils/Fmontant.class` | `Recalc_solde` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Utils` | `PointBase`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelants vérifiés par grep (hors lignes commentées) : `Csolde.Solde_caisse` →
  `Caisse/Moulinage.class:939,940,941,1353,1403`, `Compta/Impressions/BordereauxC.class:332,362,372` ;
  `Csolde.Recalc_solde` → `Compta/Utils/Epurjdv.class:189`, `Compta/Utils/Fmontant.class:206`
  (`Moulinage:1442` est commenté).
- Tables écrites en dur (`Fiches_Comptes` en lecture et `UPDATE`, `Fiches_Mvt` en lecture) :
  correctement détectées par `deps.py` malgré l'absence de `Cbase.Table`.
- L'appel `.PointBase` dans un bloc `With Utils` n'est pas résolu par `deps.py`.
- Doublons : `Compta/Utils/Recalcsolde.module` (copie), `Utils/Calcsolde.class` (`Calcul`, version SQL).
- Ordre de rework : `Csolde`, `Recalcsolde` et `Calcsolde` dans le même lot de phase 3.
