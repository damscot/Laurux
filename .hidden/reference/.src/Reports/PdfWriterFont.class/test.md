# PdfWriterFont — Tests

> Source : `.src/Reports/PdfWriterFont.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de données pure : tests `gbtest` uniquement. Valeurs attendues produites dans le clone Laurux
non modifié (caractérisation, anomalies figées) et contrôlées par comparaison aux fichiers AFM.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| PDFWRITERFONT-T01 | gbtest | Tables de largeurs | `Font(n)` pour les 17 noms existants | nombre de valeurs (256, symbol 254) et somme de contrôle / liste complète par police ; écarts AFM connus (helvetica 0xD8, symbol) figés | `tests/tables_largeurs/` | à faire |
| PDFWRITERFONT-T02 | gbtest | Noms invalides | `Font("serifBI")`, `Font("arial")`, `Font("")`, `Font("Helvetica")` (casse) | texte d'erreur (`Unknown symbol` pour serifBI, `Could not include font definition` sinon) | `tests/noms_invalides/` | à faire |

## Détail des tests

- **Référence indépendante** : `check_output.py` relance
  `output/claude/2026-10-24_rework/phase1/reports/tools/afm_compare.py` (à copier dans le répertoire
  du test) et vérifie que les seuls écarts avec les AFM Adobe sont ceux documentés (A02, A03).
- Les 256 valeurs sont écrites une par ligne (`police;index;largeur`) pour un diff lisible.
- **Couverture visée** : 100 % (toutes les fonctions sont atteintes par T01/T02).
- La largeur réellement utilisée dans un PDF est testée côté `PdfWriter` (PDFWRITER-T03, T11).
