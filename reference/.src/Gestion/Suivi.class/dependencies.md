# Suivi — Dépendances

> Source : `.src/Gestion/Suivi.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Suivi.class` — classe, formulaire associé `Suivi.form`
- Handlers GUI détectés : 22

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Archivages/Archives.class` | `<type>` |
| `.src/Gestion/Facturation/Facture.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Coulfonds`, `Formattage`, `ObsGotf`, `ObsLstf`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Suivis`, `Fiches_Txtmo`

### Membres Public sans usage externe détecté (portée réductible ?)

`Chkinput`, `Calc_MargeMo`, `Calc_MargeArt`, `Calc_MargeTotale`, `Calc_MargeMo2`, `Calc_MargeArt2`, `Calc_MargeTotale2`, `Calc_Emarge`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (grep `New Suivi`) : `Facture.class:3331`, `5664`, `7865` (F12, 11
  arguments, `hForm2.Showmodal()`) et `Archives.class:1435` (F12, `NumF = Num.Text`, devis = False,
  facture = True, imprimée = True). Aucune autre ouverture (pas d'auto-instance).
- Le mot « Suivi » apparaît aussi dans des libellés (`Edconsigne.form`, `menuopt.class:21` « Suivi
  des consignes ») sans lien avec cette classe.
- `scope_reducible` (`Chkinput`, 8 `Calc_*`) confirmé par grep : aucun appel externe ni dynamique.
- Pas de `handlers_inactifs`, `unused`, `replay_dynamic` ni `arity_errors`. L'arité des 4 appels
  (11 arguments) est conforme à `_new`.
- `Cbase.Table("TabTxmo")` → `Fiches_Txtmo`, `Cbase.Table("TabSuivis")` → `Fiches_Suivis`
  (vérifié dans `Cbase.module`).
- **Ordre de rework** : un changement de signature de `_new` impliquerait `Facture` et `Archives` ;
  aucun n'est proposé.
