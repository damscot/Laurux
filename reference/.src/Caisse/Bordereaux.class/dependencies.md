# Bordereaux — Dépendances

> Source : `.src/Caisse/Bordereaux.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Bordereaux.class` — classe, formulaire associé `Bordereaux.form`
- Handlers GUI détectés : 3

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Compta/Impressions/BordereauxC.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cbordereaux` | `<type>`, `Entete`, `Entete2`, `Level5`, `Ligne`, `Logo`, `TitreB` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Societe` |
| `Utils` | `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_LigTicketz`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Imp_Bordereaux`, `Imp_Entete`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants réels** : `Fmenu.Menu214_Click` (`Fmenu.class:1871`, `ShowModal`). La dépendance
  `BordereauxC → Bordereaux` (`BordereauxC.class:370`, `Bordereaux.Text`) est **accidentelle** :
  `BordereauxC` voulait lire son champ `Nbordereau` et charge à la place l'auto-instance de ce
  formulaire (BORDEREAUXC-A01). Si A01 est corrigée, ce lien disparaît.
- **Portée réductible** : `Imp_Bordereaux`, `Imp_Entete` confirmés (aucun autre appel, aucune
  chaîne dynamique). Les handlers `Button1..3_Click` restent `Public`. Aucun `unused`,
  `unused_transitive`, `handlers_inactifs`, `arity_errors`, `replay_dynamic`, `replay_missing`
  (aucune grille dans le `.form`).
- **Tables** : `Fiches_LigTicketz` (en dur, lecture), `Fiches_Societes` (`TabSoc`, lecture). Aucune
  écriture. Les lignes lues sont supprimées par le moulinage
  ([Moulinage](../Moulinage.class/dependencies.md)) : le contenu du bordereau dépend de l'ordre
  « bordereau puis moulinage ».
- **Éléments non vus par `deps.py`** : `Music.Play` (composant `gb.sdl2.audio`), `Shell`.
- Pas d'appel dynamique, pas de dépendance circulaire. Peut être reworké indépendamment ; la
  commonalisation de l'en-tête société suit LIGCLI-004.
