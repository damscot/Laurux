# Expcontact — Dépendances

> Source : `.src/Utils/Exports-Imports/Expcontact.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Utils/Exports-Imports/Expcontact.class` — classe, formulaire associé `Expcontact.form`
- Handlers GUI détectés : 2

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Prgm.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_ContactC`, `Fiches_Four`, `Fiches_Statut`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_Statut`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux négatif** : ouverte par `.src/Communs/Fmenu.class:2224` (`Menu283_Click`, « Export des
  contacts ») et `.src/Communs/Prgm.class:62` ; deps.py ne détecte pas `Classe.Show`.
- `Aff_Statut` : portée réductible confirmée (`grep -rn Aff_Statut .src` : d'autres classes ont
  leur propre `Aff_Statut`, aucune n'appelle celle-ci).
- Effet de bord fichier : `~/Contacts.vcf` (chemin non paramétrable).
- Aucun appel dynamique ni dépendance circulaire.
