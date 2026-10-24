# ClotureF — Dépendances

> Source : `.src/Gestion/ClotureF.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/ClotureF.class` — classe, formulaire associé `ClotureF.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Close`, `Exec` |
| `LDate` | `<type>`, `D`, `FinMois`, `G` |
| `ObjFac` | `facture`, `numcli` |
| `ObjFacB` | `<type>`, `calcul`, `transblfac` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `Musique`, `UnLock`, `son` |
| `Utils` | `Cdate_Aff`, `Observers`, `Option`, `PointBase`, `db`, `fermeTunnel` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_Comptes`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_date`, `Maj_Archives`, `Calc_solde`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants vérifiés** (grep) : `Fmenu.class:1390` (`Menu147_Click`, après contrôle du tunnel
  de réplication si `/dbase/Con-ssh` et `/Soc<XX>/Replique`/`Breplique`) et `Fmenu.class:1554`
  (`lblClm_MouseDown`, **sans** ce contrôle). Les deux font `ClotureF.ShowModal` sur
  l'auto-instance.
- `deps.py` ne liste pas les membres déclarés sans `Private`/`Public` (l. 28, 31-40) dans les
  déclarations ; ils sont bien `Private` (règle Gambas) et documentés dans architecture.md.
- Effets indirects non vus par l'heuristique : `ObjFacB.transblfac` écrit dans
  `Fiches_HistoFac[M]`, `Fiches_HistoLigfac[M]`, `Fiches_Materiels` et supprime dans
  `Fiches_Bl[M]`/`Fiches_Ligbl[M]` (tables construites par concaténation `"Fiches_Bl" & Me.tab`).
  Le replay doit donc comparer toutes ces tables.
- `Fiches_BlM` est citée en dur par concaténation (`Entbon & "M"`, l. 128) : non détectée dans
  « Tables SQL référencées ».
- Portée réductible confirmée par grep pour `Aff_date`, `Maj_Archives`, `Calc_solde` (aucun appel
  externe, aucun appel dynamique).
- Pas d'appel dynamique ; `Utils.Observers(Me)` enregistre les événements pour le rejeu.
- **Ordre de rework** : la délégation à `Csolde.Solde_caisse` (CLOTUREF-005) suppose que `Csolde`
  garde sa signature ; à traiter après ou avec le rework de
  [Csolde](../../Utils/Csolde.module/rework.md).
