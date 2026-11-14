# VisStatClimo — Tests

> Source : `.src/Statistiques/VisStatClimo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran ouvert par `StatClimo` : chaque scénario part d'un scénario de
[StatClimo](../StatClimo.class/test.md). Rejouable (`Utils.Observers` dans `_New`). **Ne pas
cliquer dans `Liste`** (`replay_missing`). Comparaisons : grille (journal), texte du PDF
capturé (`CmdVis`, `pdftotext -layout`, date/pied normalisés) ; base inchangée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISSTATCLIMO-T01 | replay | Affichage initial | STATCLIMO-T01 | grille triée par code croissant, total net par client | `tests/visstatclimo_affichage/` | implémenté |
| VISSTATCLIMO-T02 | replay | Tris | les 6 RadioButton successivement, puis le même deux fois | ordres attendus, bascule asc/desc | `tests/visstatclimo_tris/` | implémenté (le 2e clic sur Bnom rend le même ordre : bascule non observée au rejeu, figé) |
| VISSTATCLIMO-T03 | replay | Impression | > 60 clients, Imprimer | texte PDF : lignes au format `12.5` non localisé (A01 figée), totaux `0,00` | `tests/visstatclimo_pdf/` | implémenté (A01 figée) |
| VISSTATCLIMO-T04 | replay | Fermeture | Imprimer puis Quitter | `~/tmp/Statpmc.pdf` supprimé | `tests/visstatclimo_fermeture/` | implémenté |
| VISSTATCLIMO-T05 | gbtest | `LignesTotal` (après VISSTATCLIMO-005) | `Total` de T01 | lignes identiques à T01 | `tests/visstatclimo_lignes/` | à faire : extraction VISSTATCLIMO-005 requise (LignesTotal n'existe pas) |

## Détail des tests

- Valeurs attendues : clone **non modifié**, horloge figée, locale `fr_FR.UTF-8` imposée (A01
  dépend de la conversion Float → String).

### Implémentation (phase 2, vague 6)
- Scénarios (`.hidden/Tests/Statistiques/assets/`) : `visstatclimo_affichage` (T01), `visstatclimo_tris` et `visstatclimo_tris_suite` (T02, découpé pour tenir dans 20 s :
  chaque tri suivi d'Imprimer, PDF ajouté à `edition.txt`), `visstatclimo_pdf` (T03, jeu `visstatclimo_pdf.sql` :
  65 clients, 2 pages, lignes `12.5` non localisées et totaux `812,50`), `visstatclimo_fermeture` (T04 :
  `tmp/Statpmc.pdf` absent après Quitter). Jeu `statclimo_shared/statclimo_ventes` (StatClimo par défaut).
- VisStatClimo s'ouvre comme fenêtre propre (`Button2#VisStatClimo#Button2#`), les tris dans `Frame1`.
