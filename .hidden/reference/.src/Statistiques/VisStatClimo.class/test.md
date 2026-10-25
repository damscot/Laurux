# VisStatClimo — Tests

> Source : `.src/Statistiques/VisStatClimo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran ouvert par `StatClimo` : chaque scénario part d'un scénario de
[StatClimo](../StatClimo.class/test.md). Rejouable (`Utils.Observers` dans `_New`). **Ne pas
cliquer dans `Liste`** (`replay_missing`). Comparaisons : grille (journal), texte du PDF
capturé (`CmdVis`, `pdftotext -layout`, date/pied normalisés) ; base inchangée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISSTATCLIMO-T01 | replay | Affichage initial | STATCLIMO-T01 | grille triée par code croissant, total net par client | `tests/visstatclimo_affichage/` | à faire |
| VISSTATCLIMO-T02 | replay | Tris | les 6 RadioButton successivement, puis le même deux fois | ordres attendus, bascule asc/desc | `tests/visstatclimo_tris/` | à faire |
| VISSTATCLIMO-T03 | replay | Impression | > 60 clients, Imprimer | texte PDF : lignes au format `12.5` non localisé (A01 figée), totaux `0,00` | `tests/visstatclimo_pdf/` | à faire |
| VISSTATCLIMO-T04 | replay | Fermeture | Imprimer puis Quitter | `~/tmp/Statpmc.pdf` supprimé | `tests/visstatclimo_fermeture/` | à faire |
| VISSTATCLIMO-T05 | gbtest | `LignesTotal` (après VISSTATCLIMO-005) | `Total` de T01 | lignes identiques à T01 | `tests/visstatclimo_lignes/` | à faire |

## Détail des tests

- Valeurs attendues : clone **non modifié**, horloge figée, locale `fr_FR.UTF-8` imposée (A01
  dépend de la conversion Float → String).
