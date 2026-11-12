# RenMvt — Tests

> Source : `.src/Compta/Utils/RenMvt.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Script destructeur : tests de caractérisation sur base jetable (MariaDB Docker), lancés par
`Prgm` (replay) ou directement (`gbtest`), résultat = dump normalisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RENMVT-T01 | gbtest | `Run` avec journal 80 | jeu dérivé : écritures `jour = 80` numérotées `5xxxx` dans `Fiches_Mvt`, dont une dont le numéro tronqué existe dans `Fiches_Mvt` et une déjà présente dans `Fiches_Mvt1` | dump `Fiches_Mvt`/`Fiches_Mvt1` (suppression de la mauvaise écriture figée, A01) | `tests/renmvt_run/` | implémenté (couvert par le rejeu Compta/renmvt_prgm : Message.Warning bloquant en gb.test) |
| RENMVT-T02 | gbtest | `Run` sans journal 80 | `Laurux01.sql` | erreur d'exécution figée (A02) ; base inchangée | `tests/renmvt_vide/` | implémenté (Compta/RenMvtTest.T02SansJournal80 : « Result is not available » figé, A02) |
| RENMVT-T03 | replay | Lancement par `Prgm` | saisie `RenMvt` dans « Appel programme » | même dump que T01 ; `Message.Warning` | `tests/renmvt_prgm/` | implémenté (Compta/renmvt_prgm, jeu renmvt_journal80) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; base restaurée avant
  chaque test.
- `Ren` (code mort) n'est pas testé : aucun scénario ne l'atteint.
- La sortie standard (`Print`) n'est pas comparée.
- Jeu : `.hidden/Tests/Compta/assets/renmvt_prgm/renmvt_journal80.sql`. Rejeu observé : 51001 recopiée en 1001 dans
  `Fiches_Mvt1`, le DELETE supprime la ligne 411000 de l'écriture 1001 du journal 10 et laisse 51001 (A01) ;
  52002 ignorée (déjà dans `Fiches_Mvt1`).
