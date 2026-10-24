# Prgm — Dépendances

> Source : `.src/Communs/Prgm.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/Prgm.class` — classe, formulaire associé `Prgm.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Utils/Papmp.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CalcRem` | `<hérité>` |
| `Calcsolde` | `<hérité>` |
| `CompArt` | `<hérité>` |
| `DB_Connection` | `Exec` |
| `Dcfour` | `<hérité>` |
| `Deblockbl` | `<hérité>` |
| `Edsdepots` | `<hérité>` |
| `Epurfour` | `run` |
| `Equilibrage` | `<hérité>` |
| `Expcontact` | `<hérité>` |
| `Exprub` | `run` |
| `Fblocsoc` | `<hérité>` |
| `Fsoc` | `<hérité>` |
| `HistoCom` | `run` |
| `ImpDepots` | `<hérité>` |
| `Impclient` | `<hérité>` |
| `Impcpostaux` | `<hérité>` |
| `ImportStk` | `<hérité>` |
| `ImptartypeC` | `<hérité>` |
| `MajEqu` | `Recup` |
| `Papmp` | `run` |
| `Raz` | `<hérité>` |
| `RazClos` | `<hérité>` |
| `RazEcr` | `<hérité>` |
| `RazHistoFac` | `<hérité>` |
| `RazHistoFbl` | `<hérité>` |
| `RazHistoTk` | `<hérité>` |
| `RecupDech` | `run` |
| `RecupN` | `run` |
| `RenAN` | `run` |
| `RenMvt` | `Run` |
| `Renech` | `run` |
| `RenumBl` | `run` |
| `Sha1Calc` | `CalcSha1_all` |
| `Start` | `LocalSettings`, `Societe`, `son` |
| `TBord` | `<hérité>` |
| `Utils` | `Observers`, `db` |
| `VisPmp` | `<hérité>` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Docactif`, `Fiches_Mvt`

### Membres Public sans usage externe détecté (portée réductible ?)

`Mdp_LF`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- **Appelants** : `Fmenu.Menu282_Click` (« Gestion > Outils > Appel programme ») et
  `Fmenu.Menu141_Click` (séparateur sans texte, inatteignable) via l'auto-instance `Prgm.Show`.
  `Papmp.class:10, 18` modifie `Prgm.Mouse` pendant son traitement : dépendance de `Papmp` envers
  l'auto-instance de `Prgm` (si `Papmp.run` était appelé hors de `Prgm`, une fenêtre `Prgm` cachée
  serait créée).
- **Utilise** : la liste de `deps.py` est **complète** (36 cibles, vérifiées une à une). `Mdp` est un
  contrôle du `.form`, pas la classe `MDP`.
- **Tables** : `Fiches_Docactif` (`TRUNCATE`, nom en dur dans la variable `Tab`, `Cbase` a la clé
  `TabActif`) ; `Fiches_Mvt` n'est pas interrogée ici mais passée en nom de table à
  `Sha1Calc.CalcSha1_all` (avec un suffixe saisi par l'utilisateur). Les tables écrites par les
  scripts lancés (`Fiches_Art`, `Fiches_Mvt*`, `Fiches_Cequ`, `Fiches_HistoLigfac`, `Fiches_Ligbl`…)
  n'apparaissent pas : voir chaque script.
- **Appel non résolu à l'exécution** : `Fsoc.ShowModal()` (l. 81) sur une classe dont le
  constructeur exige un argument (`Fsoc._New(hform As Form)`), voir PRGM-A03.
- **Table absente** : `RenAN` écrit dans `Fiches_Mvtoc`, absente de `db_control.csv` (PRGM-A06).
- Aucun appel dynamique.

### Ordre de rework

- Après MDP-003 (`MDP.Verifie`) pour PRGM-003.
- La réarchitecture en module `Maintenance` (PAPMP-003) et la suppression des scripts de réparation
  (RECUPN-A01, EPURFOUR-A01, RENUMBL-A01, HISTOCOM-A01) modifient la liste des noms acceptés :
  `Prgm` doit être mis à jour dans le même commit que chacune.
