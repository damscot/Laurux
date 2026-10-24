# Plancomptable — Dépendances

> Source : `.src/Compta/Impressions/Plancomptable.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/Plancomptable.class` — classe, formulaire associé `Plancomptable.form`
- Handlers GUI détectés : 14

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Ccompta` | `<type>`, `BasPage`, `Entete`, `Level0P`, `Level1P`, `Lines`, `level2P` |
| `DB_Connection` | `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `Societe` |
| `TriCpt` | `<type>`, `Sans_Solde` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.class:881` (`Menu70_Click`, « Plan comptable ») par
  `Plancomptable.Show` sur l'auto-instance.
- **Faux positif « portée réductible »** : `Bsel` et `Bval` sont écrites dynamiquement par
  `TriCpt.ColTri_MajSel` (`Object.SetProperty($obj, "Bsel", …)`, `TriCpt.class:112-113`) ; elles
  restent `Public`.
- `Btn_Click` est le handler du groupe `btn` (`Button2`, `Button3`) : `Button2_Click` n'est pas
  déclenché par l'événement mais appelé par `Btn_Click`.
- Aucune dépendance circulaire.
