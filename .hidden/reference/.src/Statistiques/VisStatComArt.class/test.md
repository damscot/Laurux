# VisStatComArt — Tests

> Source : `.src/Statistiques/VisStatComArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran ouvert par `StatComArt` : chaque scénario part d'un scénario de
[StatComArt](../StatComArt.class/test.md). Rejouable (`Utils.Observers` dans `_New`).
**Ne pas cliquer dans `Liste`** (`replay_missing`). Comparaisons : grille et `NetHT` (journal),
texte du PDF capturé (`CmdVis`, `pdftotext -layout`, normalisation date/pied) ; base inchangée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISSTATCOMART-T01 | gbtest | Affichage initial | STATCOMART-T01, 3 commerciaux | contenu de `Comm`, filtre et ordre initiaux (A02 figée), `NetHT` | `tests/visstatcomart_affichage/` | implémenté (gb.test `VisStatComArtTest.T01Affichage` : Comm avec « Tous les commerciaux » en tête (A02), lignes, NetHT) |
| VISSTATCOMART-T02 | gbtest | Filtre commercial | choix de `02 - …` puis « Tous les commerciaux » | lignes du commercial 02, puis toutes | `tests/visstatcomart_filtre/` | implémenté (gb.test `VisStatComArtTest.T02Filtre` : Comm_Change appelé après le choix) |
| VISSTATCOMART-T03 | gbtest | Tris | `Bnom`, `Bbrut`, `Brem`, `Bcode` | ordres après chaque clic (A01 figée) | `tests/visstatcomart_tris/` | implémenté (gb.test `VisStatComArtTest.T03Tris` : *_MouseDown appelés avant le changement de Value (MouseDown de RadioButton non rejoué), A01 figée) |
| VISSTATCOMART-T04 | gbtest | Commercial supprimé | `Total` contenant un commercial absent de `Fiches_Commerciaux` | ligne masquée et hors `NetHT` (A03 figée) | `tests/visstatcomart_comm_absent/` | implémenté (gb.test `VisStatComArtTest.T04CommAbsent` : commercial 03 absent, ligne masquée et hors NetHT, A03 figée) |
| VISSTATCOMART-T05 | replay | Impression et fermeture | Imprimer (> 50 lignes) puis Quitter | texte PDF 2 pages + total ; `~/tmp/Statcli.pdf` supprimé | `tests/visstatcomart_pdf/` | implémenté (`Statistiques/visstatcomart_pdf` : 59 lignes, texte PDF sur 2 pages et total ; Quitter : `tmp/Statcli.pdf` absent) |
| VISSTATCOMART-T06 | gbtest | `LignesTotal` (après VISSTATCOMART-006) | `Total` de T01 | lignes identiques à T01/T02 | `tests/visstatcomart_lignes/` | à faire : extraction VISSTATCOMART-006 (LignesTotal) non faite |

## Détail des tests

- T04 : `VisStatComArt` s'ouvre dès la fin du traitement, on ne peut donc pas supprimer le
  commercial entre les deux ; le jeu contient un client dont `cli_comm` désigne un code absent
  de `Fiches_Commerciaux`.
- T03 dépend de l'ordre `MouseDown`/changement de valeur : si le rejeu ne le reproduit pas,
  scénario manuel.
- Valeurs attendues : clone **non modifié**.
