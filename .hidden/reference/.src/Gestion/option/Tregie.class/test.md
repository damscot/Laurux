# Tregie — Tests

> Source : `.src/Gestion/option/Tregie.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie avec recalcul en masse des articles : tests `replay` avec dump de `Fiches_regie` et
`Fiches_Art`, plus un `gbtest` sur le calcul extrait (après TREGIE-003). Valeurs attendues
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TREGIE-T01 | replay | Création | Création ; code `09`, libellé, alcool, `tauxa` 1 800, degré 18, `tauxss` 590, compte, TVA ; Valider | INSERT `Fiches_regie` | `tests/creation/` | à faire |
| TREGIE-T02 | replay | Contrôles | libellé vide ; `tauxa` non numérique ; degré sans `tauxss` ; compte inconnu ; TVA inconnue | ballons, aucune écriture | `tests/controles/` | à faire |
| TREGIE-T03 | replay | Modification régime suspendu, « Modifier le prix de vente » | régie à 2 articles ; Modification ; suspendu ; Valider ; choix 1 | UPDATE régie + `Fiches_Art` (`pbht`, `paht`, `prvt`, `pvht`, `pvttc`, `montdr`, `montss`, `frais`) | `tests/modif_suspendu_pv/` | à faire |
| TREGIE-T04 | replay | Modification régime acquitté, « Modifier le coeff » | même régie ; acquitté ; choix 2 | `Fiches_Art` (`coef`, `pbht` corrigé des anciens droits) | `tests/modif_acquitte_coef/` | à faire |
| TREGIE-T05 | replay | Option fioul `pp` | T03 avec `/Soc01/pp = True` | `frais` incluant `art_ecof` | `tests/modif_option_pp/` | à faire |
| TREGIE-T06 | replay | Fermeture pendant une saisie | Modification ; fermer ; « Oui » | erreur « Not enough arguments » figée (A01) | `tests/fermeture_saisie/` | à faire |
| TREGIE-T07 | gbtest | Calcul de prix extrait | valeurs d'article (pbht, tr, frais, droits anciens/nouveaux, coef, TVA, nbd) × 2 régimes × 2 choix | prix de référence (identiques à T03/T04) | `tests/calcul_prix_article/` | à faire |

## Détail des tests

- **Données** : jeu `option_boisson` (voir `Consigne/test.md`) avec 2 régies et 3 articles
  (`art_dra` renseigné, frais et transports non nuls, un article `art_prvt = 0` pour A03).
- **Comparaison** : dump normalisé de `Fiches_regie` et `Fiches_Art` ; le PDF `~/tmp/droit.pdf`
  est comparé en texte (`pdftotext`) à titre informatif.
- **Rejeu** : `Message.Question` du choix de recalcul doit être rejouée ; `ListBox1` sans `_Click`
  (sélection par activation). T07 n'existe qu'après TREGIE-003 (calcul sans contrôles).
- **SQLite** : T03 rejoué sur la base SQLite fige l'échec de `FOR UPDATE` (A02).
