# CoefTypeC — Dépendances

> Source : `.src/Gestion/Tables/CoefTypeC.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/CoefTypeC.class` — classe, formulaire associé `CoefTypeC.form`
- Handlers GUI détectés : 13
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Coltype_Click`, `Colfam_Click`, `Tabtypec_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Tables/Articles.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `Utils` | `Fcolr`, `Observers`, `cpoint`, `db` |
| `Variables` | `ArtCode`, `ArtHt`, `ArtTva`, `Artintitule`, `OrgCoefTypeCli` |
| `textfamille` | `<form>`, `Clear`, `Select`, `setfocus`, `text` |

### Tables SQL référencées

`Fiches_CoeffTypec`, `Fiches_Fam`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_TabTypec`, `Cleanchamps`, `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Coeff`, `AffProduit`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Points d'entrée** : `Fmenu:2248` (`CoefTypeC.Show()`) et `Articles:4560`
  (`CoefTypeC.ShowModal()`), auto-instance. Aucun membre utilisé de l'extérieur.
- **État partagé non vu comme dépendance d'appel** : `Variables.OrgCoefTypeCli`, `ArtCode`,
  `Artintitule`, `ArtTva`, `ArtHt` écrits par `Articles.Button9_Click` (`Articles:4555-4559`) et
  lus ici ; `OrgCoefTypeCli` jamais remis à vide (COEFTYPEC-A02).
- **`replay_dynamic`** : `Coltype_Click`, `Colfam_Click`, `Tabtypec_Click` (`ColumnView`) restent
  `Public`.
- **Vraies réductions** (aucun appel externe, `grep -rn`) : `Maj_TabTypec`, `Cleanchamps`,
  `Quitte_Cdt`, `Quitte_Cdf`, `Quitte_Coeff`, `AffProduit`.
- **Lecteurs de la table** `Fiches_CoeffTypec` : `TarArt` (calcul du prix client), `Facture`,
  `EdArt3` (via `Cbase.Table("TabCtcli")`) : le format de `coeff` (multiplicateur) est un contrat.
- `Tables SQL` : `deps.py` voit `Fiches_CoeffTypec`, `Fiches_Typec`, `Fiches_Fam` (en dur et via
  `Cbase`).
- **Ordre de rework** : COEFTYPEC-006 avec `Remisec` (REMISEC-005) et `Remisecli`.
