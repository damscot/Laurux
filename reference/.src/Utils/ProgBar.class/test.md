# ProgBar — Tests

> Source : `.src/Utils/ProgBar.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`ProgBar` est un formulaire mais sans base ni dialogue : il peut être piloté depuis gb.test
(instanciation, appels d'`Avancement`, lecture des contrôles), à condition que les tests tournent
avec un affichage (`xvfb-run` en Docker, à confirmer).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PROGBAR-T01 | gbtest | Constructeur | `New ProgBar("T", 10)`, `New ProgBar("T", 10, Null, True, "", True)` | `Title.Text`, visibilité de `Stop` et `DetailLog` | `tests/constructeur/` | à faire |
| PROGBAR-T02 | gbtest | `Avancement` cadence | 10 éléments, `refresh_increment` = 1, 3, puis 3 → 1 | valeurs successives de `ProgressionBar.Value`, `elemdone.Text`, `DetailLog.Text` | `tests/avancement/` | à faire |
| PROGBAR-T03 | gbtest | Arrêt et pause | `Stop_Click` puis `Avancement` ; `Pause_Click` ×2 | `Avancement` renvoie `True` ; libellé `Pause`/`Reprendre` | `tests/arret_pause/` | à faire |
| PROGBAR-T04 | gbtest | Fermeture | `Close` avant fin (non stoppable), après `Finalize`, et avec Stop visible | fenêtre fermée ou non ; `$stopped` lu par `Avancement` | `tests/fermeture/` | à faire |
| PROGBAR-T05 | gbtest | Cas limites | `nbelem = 0` puis `Avancement` ; `unit = "lignes"` | figer l'erreur actuelle et l'absence d'unité (A01, A02) | `tests/cas_limites/` | à faire |
| PROGBAR-T06 | replay | Intégration | Purge `RazDevis` sur `Laurux01.sql` | même diff de tables que sans ProgBar modifiée ; journal de progression | `tests/integration_raz/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées dans le clone Laurux non modifié (dump des propriétés des
  contrôles après chaque appel).
- **Temps** : `Avancement` contient des `Wait` (0,05 s par rafraîchissement) ; T02 limite le
  nombre d'éléments pour rester rapide. La performance des traitements appelants est mesurée dans
  leurs propres tests.
