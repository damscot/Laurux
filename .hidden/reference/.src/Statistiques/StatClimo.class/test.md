# StatClimo — Tests

> Source : `.src/Statistiques/StatClimo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : `replay` depuis Statistiques › « Chiffre d'affaire produits-Mo par client »
(`Fmenu.Menu117`). Rejouable (`Utils.Observers` une fois). Comparaisons : dump normalisé de
`Total` (trié par `cdclifac`), messages. Jeu `statistiques_ventes` (factures archivées avec
lignes `A`/`M`, BL `F`/`B`/`D` dans et hors période ; voir [StatComm/test.md](../StatComm.class/test.md)).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| STATCLIMO-T01 | replay | Factures hors entretien, sans BL | `Facn`, `Bl` décoché | `TotA`, `RemP`, `TotM`, `RemMo` par client (archivées + BL `F` de la période) | `tests/statclimo_facn/` | implémenté |
| STATCLIMO-T02 | replay | Inclure les BL | `Facn`, `Bl` coché, BL `B` hors période | BL `B` hors période comptés (A01 figée) | `tests/statclimo_avec_bl/` | implémenté (A01 figée) |
| STATCLIMO-T03 | replay | Toutes les factures, numéro commun | `Fact`, numéro présent dans `HistoFac` et `HistoFacM` ; deux lignes identiques | lignes croisées et dédoublonnées (A03 figée) | `tests/statclimo_union/` | implémenté (A03 figée) |
| STATCLIMO-T04 | replay | Ligne `M` au format point | `brut_ligfac = "12.50"` sur une ligne `M` archivée | erreur « Type mismatch » figée (A04) | `tests/statclimo_format_point/` | implémenté (A04 figée, code 125) |
| STATCLIMO-T05 | replay | Factures d'entretien | `Face` | entêtes et lignes `M` (`HistoFacM`, `Fiches_BlM`) | `tests/statclimo_entretien/` | implémenté |
| STATCLIMO-T06 | replay | Cas limites | période vide ; fin < début | messages | `tests/statclimo_cas_limites/` | implémenté |
| STATCLIMO-T07 | replay | SQLite | `Laurux01.sqlite` + jeu de T01 | même dump que T01 | `tests/statclimo_sqlite/` | à faire : rejeu sur base SQLite non outillé par le runner |
| STATCLIMO-T08 | gbtest | `CalculTotal` (après STATCLIMO-006) | jeu de T01-T03 | `Total` identique | `tests/statclimo_calcul/` | à faire : extraction STATCLIMO-006 requise (CalculTotal n'existe pas) |

## Détail des tests

- Valeurs attendues : clone **non modifié**, horloge figée.
- T02, T03, T04 caractérisent des anomalies.
- La période par défaut dépend de `dteclec1` : fixer `Fiches_Parametres.dteclec1` dans le jeu.

### Implémentation (phase 2, vague 6)
- Jeu partagé `.hidden/Tests/Statistiques/assets/statclimo_shared/statclimo_ventes.sql` (au lieu de
  `statistiques_ventes`, inexistant) : HistoFac/HistoLigfac, HistoFacM/HistoLigfacM, Bl/Ligbl (F, B hors période,
  B dans la période, D), BlM/LigblM ; lignes A et M. Jeux propres : `statclimo_union/statclimo_union.sql`
  (H00004 dans HistoFac et HistoFacM), `statclimo_format_point/statclimo_format_point.sql` (brut M `12.50`).
- Scénarios : `statclimo_facn` (T01, + Imprimer de VisStatClimo), `statclimo_avec_bl` (T02),
  `statclimo_union` (T03), `statclimo_format_point` (T04, code 125), `statclimo_entretien` (T05),
  `statclimo_cas_limites` (T06 : fin < début puis période vide, Bl décoché sinon A01 ramène des BL `B`).
