# Edmo — Dépendances

> Source : `.src/Gestion/Impressions/Edmo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Impressions/Edmo.class` — classe, formulaire associé `Edmo.form`
- Handlers GUI détectés : 17
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colmo_Click`, `ColMo2_Click`, `Colfam_Click`, `Colfam2_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Carticles` | `<type>`, `Entete`, `Footer`, `Level1MO`, `Level2MO` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Musique`, `son` |
| `Utils` | `Observers`, `SetEditColor`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Fam`, `Fiches_Mo`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Button2_Click`, `Valeur2TTC_Calcul`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu59_Click` (`Fmenu.class:823`, `Edmo.Show`).
- **Tables** : `Fiches_Mo`, `Fiches_Fam` en dur ; `Fiches_Tvaav` via `Cbase.Table("TabTvav")`.
  Lecture seule.
- **Rendu** : `Carticles.Entete`, `Level1MO`, `Level2MO`, `Footer` ; `Level1MO` lit
  `/Soc<XX>/Taxe`.
- **`Draw`** (gb.qt) : `Draw.End` appelé sans contexte de dessin.
- **Rejeu** : `Colmo_Click`, `ColMo2_Click`, `Colfam_Click`, `Colfam2_Click` dans `replay_dynamic`
  (casse mixte `Colmo`/`ColMo2` : Gambas est insensible à la casse) → `Public`.
- **Portée** : `Button2_Click` (Button2 dans le groupe `btn`) et `Valeur2TTC_Calcul` réductibles
  (confirmé). `Valeur2TTC_Calcul` est aussi le nom d'une méthode de `Movr` : homonyme sans lien.
- **Signaux** : `unused`, `unused_transitive`, `handlers_inactifs`, `replay_missing`,
  `arity_errors` vides.
