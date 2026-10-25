# VisStatComm — Tests

> Source : `.src/Statistiques/VisStatComm.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI ouvert par `StatComm` : les scénarios commencent par un scénario de
[StatComm](../StatComm.class/test.md) (jeu `statistiques_ventes`). `Utils.Observers(Me)` est
appelé une fois dans `_New` : rejouable. **Ne pas cliquer dans `Liste`** (`replay_missing`).
Comparaisons : contenu de la grille et des totaux relevés dans le journal, texte du PDF
(`~/tmp/Statcli.pdf`, capturé par le script de `/Soc01/caisse/CmdVis` puis `pdftotext -layout`,
date et pied normalisés comme pour [EdArt1](../../Gestion/Impressions/EdArt1.class/test.md)) ;
la base est inchangée (lecture seule).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VISSTATCOMM-T01 | replay | Affichage détail | STATCOMM-T01 puis ouverture | lignes par client ayant un commercial, commission = `totfac × comm / 100` si `comm > 0`, totaux | `tests/visstatcomm_detail/` | à faire |
| VISSTATCOMM-T02 | replay | Affichage synthèse | STATCOMM-T02 | une ligne par commercial ; commercial sans fiche absent | `tests/visstatcomm_synthese/` | à faire |
| VISSTATCOMM-T03 | replay | Tris | clics successifs `Bnom`, `Bnom`, `Bbrut`, `Brem`, `Bnet`, `Bcode` | ordre des lignes après chaque clic (A01 figée : tri forcé sur `commercial`) | `tests/visstatcomm_tris/` | à faire |
| VISSTATCOMM-T04 | replay | Impression | **Imprimer** sur T01 avec > 50 lignes | texte PDF (2 pages, pas de ligne de total) | `tests/visstatcomm_pdf/` | à faire |
| VISSTATCOMM-T05 | replay | Fermeture | **Imprimer** puis **Quitter** | `~/tmp/Statcli.pdf` supprimé | `tests/visstatcomm_fermeture/` | à faire |
| VISSTATCOMM-T06 | gbtest | `LignesTotal` (après VISSTATCOMM-006) | `Total` du jeu T01/T02, deux modes | tableau identique aux grilles de T01/T02 | `tests/visstatcomm_lignes/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié**, horloge figée.
- T03 doit être rejoué tel quel : l'ordre `MouseDown` / changement de valeur du RadioButton est
  justement ce que l'on caractérise (si le rejeu ne reproduit pas `MouseDown`, noter le scénario
  comme manuel).
- **Non testable automatiquement** : largeur des colonnes, curseur, `Visualiseur` (remplacé par
  le script de capture).
