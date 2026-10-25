# VisStatTypCli — Tests

> Source : `.src/Statistiques/VisStatTypCli.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran ouvert par `StatTypCli` : chaque scénario part d'un scénario de
[StatTypCli](../StatTypCli.class/test.md). Rejouable (`Utils.Observers` dans `_New`).
**Ne pas cliquer dans `Liste`** (`replay_missing`). Comparaisons : grille et totaux (journal),
texte du PDF capturé (`/Soc01/caisse/CmdVis`, `pdftotext -layout`, date/pied normalisés) ;
base inchangée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISSTATTYPCLI-T01 | replay | Affichage initial | STATTYPCLI-T01 | grille triée par code croissant, % N/N-1 par type, `Netnn2` global | `tests/visstattypcli_affichage/` | à faire |
| VISSTATTYPCLI-T02 | replay | Tris | `Bnom`, `Bbrut`, `Brem`, `Bnet`, `Bnet2`, `Bcode`, puis `Bnet` deux fois | ordres attendus (bascule asc/desc à chaque clic) | `tests/visstattypcli_tris/` | à faire |
| VISSTATTYPCLI-T03 | replay | Impression longue | `Total` de > 60 types (jeu dérivé) | PDF sans saut de page ni pied intermédiaire (A01 figée), total des % = somme (A02 figée) | `tests/visstattypcli_pdf/` | à faire |
| VISSTATTYPCLI-T04 | replay | Fermeture | Imprimer puis Quitter | `~/tmp/StatTypcli.ps` supprimé | `tests/visstattypcli_fermeture/` | à faire |
| VISSTATTYPCLI-T05 | gbtest | `LignesTotal` (après VISSTATTYPCLI-006) | `Total` de T01 | lignes et totaux identiques à T01 | `tests/visstattypcli_lignes/` | à faire |

## Détail des tests

- T03 nécessite un `Total` volumineux : l'insérer directement (script SQL) puis ouvrir l'écran
  via `StatTypCli` sur une période vide n'est pas possible (`Total` recréé) ; utiliser un jeu
  avec > 60 types client (`Fiches_Typec`) et une facture par type.
- Valeurs attendues capturées dans le clone **non modifié**.
