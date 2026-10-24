# Equilibrage — Dépendances

> Source : `.src/Compta/Utils/Equilibrage.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Equilibrage.class` — classe, formulaire associé `Equilibrage.form`
- Handlers GUI détectés : 1

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `PointBase`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Seul appelant : `Prgm.class:112` (`If Prog = "Equilibrage" Then Equilibrage.ShowModal()`) : appel
  par **nom saisi** dans le lanceur `Prgm`, donc invisible depuis le menu.
- `Button2_Click` n'est pas un handler direct (bouton du groupe `Btn`, tag 1).
- Effet transverse non détecté : modifie `Fiches_Mvt.montantc` sans recalcul de `control`
  (`Sha1Calc`) ni des soldes (`Fiches_Comptes`).
- Aucune contrainte d'ordre de rework.
