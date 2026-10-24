# AffRdv — Tests

> Source : `.src/Utils/AffRdv.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| AFFRDV-T01 | replay | Annonce d'un rendez-vous | `Laurux01.sql` + ligne `Fiches_Agenda` à l'heure figée (`faketime`) pour l'utilisateur de test ; `Fmenu` ouvert 1 min | `Message.Warning` capturé avec le texte de référence ; appel `pico2wave` factice si `/son2` | `tests/replay_rdv/` | à faire |
| AFFRDV-T02 | replay | Pas de rendez-vous / autre utilisateur / `iaction` nul | mêmes données, variantes | aucun message | `tests/replay_rdv_aucun/` | à faire |

## Détail des tests

- L'heure est figée par `faketime` dans les deux clones ; les messages attendus sont capturés dans le
  clone **Laurux non modifié**.
- Après la séparation traitement/GUI (AFFRDV-003), la fonction pure devient testable en `gbtest`.
- Non testable automatiquement : double annonce dans la même minute (dépend du temps de réaction de
  l'utilisateur).
