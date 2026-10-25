# TriEcritures — Tests

> Source : `.src/Affichages/TriEcritures.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Liste modale de la comptabilité, rejouable (`Utils.Observers(Me)`). Scénarios lancés depuis
`Saisecrit` et `Tresor` ; comparaison du dump normalisé (écriture reprise puis validée) et, à titre
informatif, des lignes `Exec_SQL` (requêtes `LIMIT`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRIECRITURES-T01 | replay | Reprise d'une écriture non validée en saisie | `Saisecrit` : « écritures non validées », clic sur une écriture, validation (scénario de SAISECRIT-T04) | écriture reprise et validée ; `Fiches_Mvt` de référence | `tests/reprise_saisie/` | à faire |
| TRIECRITURES-T02 | replay | Reprise en trésorerie | `Tresor` : écritures non validées puis validées, choix d'une ligne (TRESOR-T05) | `snum`/`libelle`/`journal` repris ; écritures pointées absentes de la liste | `tests/reprise_tresor/` | à faire |
| TRIECRITURES-T03 | replay | Tri et filtre par en-tête | focus sur chaque en-tête, saisie `41` dans `COM`, retour arrière ; `DA2` : `01/01/2025` | grilles et requêtes de référence ; figer la double requête de `DA2_KeyPress` et l'en-tête non restauré (A02) | `tests/tri_filtre/` | à faire |
| TRIECRITURES-T04 | replay | Double-clic et pagination | double-clic `NUM2` ×2, PageDown ×2, PageUp, molette, boutons, flèche bas en dernière ligne | `LIMIT` successifs de référence ; pas de décalage négatif | `tests/pagination/` | à faire |
| TRIECRITURES-T05 | replay | Fermeture sans choix et grille vide | Échap ; F2 ; filtre sans résultat puis Entrée | 1) appelant inchangé ; 2) figer la reprise de l'ancienne écriture (A03) | `tests/fermeture/` | à faire |
| TRIECRITURES-T06 | gbtest | `RequeteEcritures` (après TRIECRITURES-007) | `validee` 0/1, `tresorerie` 0/1, tri, filtre, sens, pages | texte SQL identique au clone non modifié (aux espaces près, après normalisation) | `tests/requete_ecritures/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone **Laurux non modifié** ; A02 et A03 figées.
- **Données** : `Laurux01.sql` ne contient aucune écriture. Jeu dérivé commun aux éditions comptables
  (décrit dans `Compta/Impressions/Balance.class/test.md`) complété de ≥ 3 pages d'écritures
  `validee = 0` et `= 1`, en journaux et en trésorerie, pointées ou non, dont une clôturée et une
  ligne collectif (exclues).
- **Rejeu** : `Ecrit_Click` est appelé par `Object.Call` (doit rester `Public`). Les en-têtes sont
  pilotés par la prise de focus (`*_GotFocus`) : le scénario doit rejouer les changements de focus.
- **Pagination** : `lg` dépend de la hauteur de la grille ; fixer la géométrie entre capture et
  rejeu.
- **T06** : le texte SQL actuel contient des doubles espaces différents selon `Debn1`/`Debn3` ;
  comparer après normalisation des espaces.
