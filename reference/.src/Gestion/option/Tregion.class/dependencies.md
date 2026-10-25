# Tregion — Dépendances

> Source : `.src/Gestion/option/Tregion.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/option/Tregion.class` — classe, formulaire associé `Tregion.form`
- Handlers GUI détectés : 16

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/option/menuopt.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `db` |
| `barselection` | `<type>`, `estcreer`, `estmodif` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_region`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `menuopt.tipp_click` (`menuopt.class:57`).
- **Table `Fiches_region`** : créée par `modfichier.fichiercarbu` (`modfichier.module:107`), absente
  de `db_control.csv` et de `Laurux01.sql` (vérifié par `grep`). Autres lecteurs (vérifiés) :
  `rechtipp.class:31-33`, `Edittipp.class:9-10`, `Facture.class:12214`, `FClient.class:805`. Toute
  évolution de la convention « `cart='0'` = intitulé » les concerne tous.
- **Arité non détectée** : `form_Close` (`Tregion.class:161`) appelle `bar1_valide` sans
  argument ; `deps.py` ne le signale pas (même limite que pour Ttourne). Erreur confirmée avec
  `gbs3` (TREGION-A01).
- **Observateurs `cmpt`** : `cmpt_gotfocus`/`cmpt_lostfocus` sont levés par des `Observer`
  créés par code (`New Observer(…) As "cmpt"`), et `bar1_*` par `Barselection` : tous doivent
  rester `Public` avec leur nom.
- Ordre de rework : TREGION-005 avec le helper `Barselection` commun (TTOURNE-005, MREGLEMENT-006).
