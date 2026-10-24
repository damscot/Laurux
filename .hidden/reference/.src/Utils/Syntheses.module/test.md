# Syntheses — Tests

> Source : `.src/Utils/Syntheses.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SYNTHESES-T01 | gbtest | `Message`, `/son2` désactivé | `Laurux.conf` sans `/son2` ; `pico2wave`/`aplay` factices journalisant leurs appels | aucun appel externe | `tests/son2_off/` | à faire |
| SYNTHESES-T02 | gbtest | `Message`, `/son2` activé | `/son2 = True`, message accentué | séquence d'appels journalisée (`pico2wave -l fr-FR -w msg.wav <msg>`, puis `pico2wave`, `aplay msg.wav`) | `tests/son2_on/` | à faire |

## Détail des tests

- Les programmes externes sont remplacés par des scripts factices en tête du `PATH`. La séquence de
  référence est capturée dans le clone **Laurux non modifié** (le `Shell` asynchrone impose
  d'attendre la fin du processus avant de lire le journal).
- `Music.Play` n'est pas vérifiable (pas de sortie audio en test) ; le test exige seulement l'absence
  d'erreur.
