# FCloture — Dépendances

> Source : `.src/Compta/Clotures/FCloture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Clotures/FCloture.class` — classe, formulaire associé `FCloture.form`
- Handlers GUI détectés : 4

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Close`, `Exec` |
| `Doc` | `Open` |
| `ProgBar` | `<type>`, `Avancement` |
| `Sha1Calc` | `CalcSha1_Verify` |
| `Start` | `Musique`, `UnLock`, `son` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Observers`, `db`, `fermeTunnel` |

### Tables SQL référencées

`Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Aff_date`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Fmenu.Menu46_Click` (`Fmenu.class:769`, `FCloture.ShowModal()` sur
  l'auto-instance), précédé d'un contrôle `Utils.ControlTunnel()` si la réplication SSH est active.
- Auto-référence `FCloture.Close()` (l. 130) : appel sur l'auto-instance, sans effet de bord
  différent de `Me.Close` dans l'usage actuel.
- Tables en dur, hors `Cbase` : `Fiches_Mvt`, `Fiches_Parametres` (détectées par `deps.py`).
- `Sha1Calc.CalcSha1_Verify` lit aussi la table (clé `control`) : tout rework de `Sha1Calc`
  impose de rejouer FCLOTURE-T03.
- `ProgBar` : `Avancement` renvoie `True` si l'utilisateur a cliqué sur Arrêter ; la boucle fait
  alors `Break` (voir FCLOTURE-A01).
- Ordre de rework : après LDATE (si `FinMois`/`PFin` sont réutilisés) et en même temps que
  `FClotureAn` pour les helpers de dates communs.
