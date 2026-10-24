# RenMvt — Tests

> Source : `.src/Compta/Utils/RenMvt.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Script destructeur : tests de caractérisation sur base jetable (MariaDB Docker), lancés par
`Prgm` (replay) ou directement (`gbtest`), résultat = dump normalisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RENMVT-T01 | gbtest | `Run` avec journal 80 | jeu dérivé : écritures `jour = 80` numérotées `5xxxx` dans `Fiches_Mvt`, dont une dont le numéro tronqué existe dans `Fiches_Mvt` et une déjà présente dans `Fiches_Mvt1` | dump `Fiches_Mvt`/`Fiches_Mvt1` (suppression de la mauvaise écriture figée, A01) | `tests/renmvt_run/` | à faire |
| RENMVT-T02 | gbtest | `Run` sans journal 80 | `Laurux01.sql` | erreur d'exécution figée (A02) ; base inchangée | `tests/renmvt_vide/` | à faire |
| RENMVT-T03 | replay | Lancement par `Prgm` | saisie `RenMvt` dans « Appel programme » | même dump que T01 ; `Message.Warning` | `tests/renmvt_prgm/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; base restaurée avant
  chaque test.
- `Ren` (code mort) n'est pas testé : aucun scénario ne l'atteint.
- La sortie standard (`Print`) n'est pas comparée.
