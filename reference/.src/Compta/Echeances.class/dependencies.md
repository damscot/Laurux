# Echeances — Dépendances

> Source : `.src/Compta/Echeances.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Echeances.class` — classe, formulaire associé `Echeances.form`
- Handlers GUI détectés : 6
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colech_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `colech2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Start` | `Musique`, `son` |
| `Utils` | `Calcech`, `Cdate_Aff`, `Cdate_calc`, `Observers`, `SetEditColor`, `convBool`, `db` |

### Tables SQL référencées

`Fiches_Echeances`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `echman`, `Button1_Click`, `Button2_Click`, `Quittedate`, `Button5_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse
- **Point d'entrée unique** : `Fmenu.class:1326` (`Menu131_Click`, `echeances.ShowModal` sur
  l'auto-instance, casse différente du nom de classe). Aucun autre appelant (`grep -rn`).
- **Portées réductibles confirmées** : `Maj_Zones`, `CleanChamps`, `Refresh`, `echman`, `Quittedate`
  ne sont appelés que depuis la classe. Les handlers `ech_*` et `Btn_*` sont des handlers de
  **groupe** (`.form`) : ils restent `Public` (ReplayObserver).
- **Dépendance de données** : `Fiches_Echeances` est lue par `FClient` (l.1984, 2055),
  `FFournisseur`, `Facture`, `ObjFac`, `Facturergbl`, `ValidBR`, `Moulinage` et `Prefs` : une
  modification ou suppression faite ici change les échéances calculées ailleurs (scénarios de replay
  à croiser).
- **Utils.Calcech** : le simulateur (`Button5_Click`) est le seul usage GUI direct ; la logique est
  testée avec `Utils` (voir [Utils](../../Utils/Utils.module/test.md)).
- `deps.py` ne signale pas l'usage de la table via le nom en dur dans une variable `Tab` : il le
  détecte ici car le littéral est dans la classe. Aucun appel dynamique, aucune dépendance
  circulaire ; aucune contrainte d'ordre de rework hors du helper de date commun avec `Tresor`.
