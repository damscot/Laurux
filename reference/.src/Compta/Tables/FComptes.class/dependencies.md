# FComptes — Dépendances

> Source : `.src/Compta/Tables/FComptes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FComptes.class` — classe, formulaire associé `FComptes.form`
- Handlers GUI détectés : 38
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cdate_EXT`, `lpad`, `cpoint`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colco_Click`, `Tvalist2_Click`, `tvalist_Click`, `Colposte_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Postes`, `Vents`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Parametre.class` | `<hérité>` |
| `.src/Compta/Saisecrit.class` | `<hérité>` |
| `.src/Compta/Tresor.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Ccomptes` | `Colco_Data`, `Deb2`, `Deb3`, `Tris` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TriCpt` | `<type>`, `General`, `Sans_Solde` |
| `Utils` | `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `PointBase`, `convBool`, `db` |

### Tables SQL référencées

`Fiches_Analytiques`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Mvt2`, `Fiches_Mvt3`, `Fiches_Mvt4`, `Fiches_Mvt5`, `Fiches_MvtM`, `Fiches_MvtM1`, `Fiches_MvtM2`, `Fiches_MvtM3`, `Fiches_MvtM4`, `Fiches_MvtM5`, `Fiches_Postes`, `Fiches_SousComptes`, `Fiches_Tvaac`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Cdate_EXT`, `lpad`, `cpoint`, `Maj_Zones`, `cleanChamps`, `Refresh`, `Button2_Click`, `Button1_Click`, `Tvaveman`, `Tvaacman`, `Comptman`, `Tris`, `Dbclk`, `Ref`, `Ventilations`, `CleanVtl`, `Ventilman`, `Button4_Click`, `Aff_Analytique`, `Quitter_Postes`, `collman`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée (vérifiés par `grep`) : `Fmenu.Menu114_Click` (`.src/Communs/Fmenu.class:535`,
  `Fcomptes.Show`) ; `Saisecrit` (`.src/Compta/Saisecrit.class:1205`), `Tresor`
  (`.src/Compta/Tresor.class:927`), `Parametre` (`.src/Communs/Parametre.class:342`, `558`) :
  `ShowModal` de l'auto-instance. Aucun membre de la classe n'est appelé de l'extérieur : toute la
  liste « portée réductible » de `deps.py` est confirmée, **sauf** `Bsel`/`Bval`, écrits par `TriCpt`
  via `Object.SetProperty` (`.src/Compta/TriCpt.class:112-113`).
- `Cdate_EXT`, `lpad`, `cpoint` : aucun appel, ni interne ni externe → code mort (et non simple
  réduction de portée).
- Dépendance forte au module `Ccomptes` (`Deb2`, `Deb3`, `Tris`, `Colco_Data`) : la grille est
  virtuelle, son contenu dépend de ce module.
- Tables `Fiches_Mvt1…5` et `Fiches_MvtM1…5` sont nommées en dur dans `Button1_Click` (détectées par
  `deps.py`). `Fiches_SousComptes` n'a pas de clé `Cbase`.
- `Start.LocalSettings["/Soc" & Start.Societe & "/Analytique"]` conditionne l'onglet analytique.
- Ordre de rework : après `Ccomptes` si son API change ; les replays de Saisecrit/Tresor/Parametre
  qui créent un compte doivent être repassés.
