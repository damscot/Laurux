# Fmontant — Dépendances

> Source : `.src/Compta/Utils/Fmontant.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Utils/Fmontant.class` — classe, formulaire associé `Fmontant.form`
- Handlers GUI détectés : 8
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Somme_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Facturation/SaiReg.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Csolde` | `Recalc_solde` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Saisecrit` | `<type>` |
| `Start` | `Musique`, `son` |
| `Tresor` | `<type>` |
| `Utils` | `Cdate_Aff`, `Observers`, `PointBase`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`affichage`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Ouverture** : `Fmenu.class:805` (`Menu40_Click`, « Recherche d'un montant ») et
  `SaiReg.class:1144` (`somme_Click`), par `Fmontant.Show` sur l'auto-instance (non modal).
- `affichage` : aucun appelant externe (grep `affichage` hors du fichier : homonymes dans d'autres
  classes seulement) ; portée réductible confirmée.
- `montant_GotFocus` est le handler du **groupe** `Montant` (contrôles `Mnt` et `Libelle`).
- Formulaires ouverts : `Saisecrit` (`New Saisecrit(numero, Me.Parent, True)`), `Tresor`
  (`New Tresor(numero)`) ; leurs constructeurs font partie du contrat.
- Aucun appel dynamique ; pas de dépendance circulaire.
- **Ordre de rework** : indépendant ; si la commonalisation sur `Csolde.Solde_caisse` est
  retenue, après CSOLDE.
