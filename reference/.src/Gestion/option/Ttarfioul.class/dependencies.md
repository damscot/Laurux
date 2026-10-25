# Ttarfioul — Dépendances

> Source : `.src/Gestion/option/Ttarfioul.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Ttarfioul.class` — classe, formulaire associé `Ttarfioul.form`
- Handlers GUI détectés : 12

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/artopt.class` | `<type>` |
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Exec` |
| `TriArticles` | `<type>` |
| `Utils` | `Fcolr`, `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `Variables` | `Bsel` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Tvaav`, `Fiches_ligtarpp`, `Fiches_tarpp`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Ouvertures : `menuopt.class:63` (`Ttarfioul.Show`) et `artopt.class:337-347` (`New
  Ttarfioul(win, $numart)` : 2 arguments pour `_new(Optional num)` ; conformément à la règle
  vérifiée en lot 1, `win` est le `Parent` de la `Form` et `$numart` le paramètre `num` : correct).
- `Bsel`/`Bval` écrits par `TriArticles` via `Object.SetProperty` (`Me` passé en dernier argument) :
  doivent rester `Public`. `button1_Click` réinitialise `Variables.Bsel` (autre variable).
- `tableview1_Click`/`tableview2_Click` : handlers de `TableView` (non listés en `replay_dynamic`,
  qui ne couvre que GridView/ColumnView/ListBox) ; à garder `Public`.
- Lecteurs de `Fiches_tarpp`/`Fiches_ligtarpp` : à vérifier dans la facturation fioul (`Facture`,
  hors de ce lot) ; aucune autre écriture trouvée.
