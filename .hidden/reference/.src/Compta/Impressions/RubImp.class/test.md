# RubImp — Tests

> Source : `.src/Compta/Impressions/RubImp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran d'impression : scénarios lancés depuis `Fmenu` (Comptabilité > Compte de résultat >
Impression). Pour le compte de résultat, trois sorties sont comparées : texte du PDF
`~/tmp/Resultat.pdf` (`pdftotext -layout`, pied de page normalisé : date et utilisateur) produit
d'abord dans le clone Laurux non modifié, `~/tmp/Resultat.csv` (diff exact) et dump de la table de
travail `centralisation`. Les éditions bilan et SIG sont couvertes par IMP_BILAN-T* et IMP_SIG-T*
(mêmes scénarios, autre bouton radio). Jeu dérivé de `Laurux01.sql` (97 rubriques `R`) avec des
écritures de classes 6 et 7 dans `Fiches_Mvt` (2018) et `Fiches_Mvt1` (2017), validées et non
validées. L'horloge est fixée pour les dates proposées ; `Visualiseur.Prog` est neutralisé.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| RUBIMP-T01 | replay | Compte de résultat non détaillé, bénéfice | jeu « bénéfice », `E1`, Imprimer | PDF (texte normalisé), CSV, dump `centralisation` identiques à la référence | `tests/resultat_benefice/` | implémenté |
| RUBIMP-T02 | replay | Compte de résultat détaillé, perte | jeu « perte », `Impd` coché, `E1` | idem ; ordre des lignes de détail figé (A04) | `tests/resultat_perte_detail/` | implémenté |
| RUBIMP-T03 | replay | Exercices antérieurs | `N1`, `N4`, `N5` (sans N-1) | idem pour chaque exercice | `tests/resultat_exercices/` | implémenté |
| RUBIMP-T04 | replay | Aiguillage | Bilan puis SIG avec `Impd` coché avant de changer de bouton | appel de `Imp_Bilan`/`Imp_Sig` (log) ; `Resultat.csv` vide ; `centralisation` au format bilan/SIG | `tests/aiguillage/` | implémenté (Resultat.csv vide et centralisation ; PDF Bilan/SIG couverts par IMP_BILAN/IMP_SIG) |
| RUBIMP-T05 | replay | Dates proposées par exercice | `E1`, `N1`…`N5` sur `Fiches_Parametres` de `Laurux01.sql` ; puis jeu de dates de clôture non calendaires (30/06) | `DteN0`/`DteN1` et en-tête `Periode` (dates N-1 + 1 jour, A03) figés | `tests/dates_exercice/` | à faire : DteN0/DteN1 affichés seulement ; périodes N-1, N-4, N-5 vérifiées dans le PDF de T03 (dont la fin N-1 vide de N-5, A03) |
| RUBIMP-T06 | replay | Contrôle des dates saisies | début avant l'exercice, fin après la clôture précédente, fin < début | avertissements et remises à l'exercice en cours figés (A02) | `tests/controle_dates/` | à faire : avertissements ouverts depuis dteN0_LostFocus/dteN1_LostFocus (boîte depuis un LostFocus non rejouable) |
| RUBIMP-T07 | replay | Quitter | Imprimer puis Quitter | `~/tmp/Resultat.pdf` toujours présent (A01 figée) | `tests/quitter/` | à faire : seule la présence de ~/tmp/Resultat.pdf est à vérifier ; contenu PDF binaire horodaté non comparable |
| RUBIMP-T08 | replay | Base SQLite | T01 sur `Laurux01.sqlite` + jeu dérivé | PDF et dump comparés à la référence SQLite (ordre physique, A06) | `tests/resultat_sqlite/` | à faire : runner sans base SQLite |
| RUBIMP-T09 | gbtest | Bornes d'exercice (après RUBIMP-003) | `BornesExercice(k)` pour `k` = 0…5 sur `Laurux01.sql` | chaînes identiques aux dates de T05 | `tests/bornes_exercice/` | à faire : après extraction RUBIMP-003 (BornesExercice) |
| RUBIMP-T10 | replay | Performance | jeu `rubimp_perf` : 90 comptes de gestion, ~1 000 lignes d'écritures 2018 et 200 de 2017, compte de résultat détaillé (décision utilisateur 2026-11-13 : ~1 000 écritures suffisent, on mesure le code Gambas et le format des requêtes, pas MariaDB) | PDF (texte), `Resultat.csv`, centralisation identiques à ref ; durée de référence 10,7 s (ref et rework, hors charge) | `tests/perf/` | implémenté (scénario `rubimp_performance` ; jeu `rubimp_perf.sql` produit par `gen_rubimp_perf.py`, voir ci-dessous) |

## Détail des tests

- **Valeurs attendues** : produites dans le clone Laurux non modifié, même jeu, même locale
  (`LANG=fr_FR.UTF-8`), même horloge.
- **gen_input.py** : jeux « bénéfice » et « perte » (produits > charges et inverse, en N et N-1),
  rubriques `L` avec plusieurs comptes pour le détail.
- **check_output.py** : `pdftotext -layout`, normalisation du pied de page, diff texte ; diff exact
  du CSV ; dump trié de `centralisation`.
- **SQL** : diff `Exec_SQL` bloquant pour RUBIMP-005/006 (déclarés sans changement SQL).
- **Non testable automatiquement** : rendu graphique du PDF ; `Message.info` « traitement long »
  rejoué mais non vérifié.

## Implémentation (phase 2, vague 4)

- Scénarios `.hidden/Tests/Compta/assets/rubimp_{resultat_benefice,resultat_perte_detail,resultat_exercices,aiguillage}/` ;
  jeux : `Compta/extrait_shared/extrait_base` (lecture seule ; 2018 bénéficiaire, 2017 dans `Fiches_Mvt1`) et
  `rubimp_resultat_perte_detail/rubimp_perte.sql` (2018 en perte, une écriture non validée).
- PDF converti par `pdftotext -layout "$0" - >> {home}/resultat_pdf.txt` (CmdVis) : plusieurs éditions d'un même
  scénario s'ajoutent ; `tmp/Resultat.csv` comparé ; table de travail `centralisation` dans le dump.
- Constats figés : « TOTAL GENERAL » à 0 dans les deux colonnes ; dans `Resultat.csv`, dates au format
  `mm/dd/yyyy 22:00:00` (veille en UTC) et chaque ligne écrite deux fois (avec et sans `;` final) ; N-5 :
  période N-1 « du 31.12.2013 au » (fin vide, A03).

### RUBIMP-T10 : jeu de performance

Le jeu `.hidden/Tests/Compta/assets/rubimp_performance/rubimp_perf.sql` est produit par le générateur déterministe
`gen_rubimp_perf.py` du même répertoire (90 comptes de gestion, 500 écritures 2018 dans `Fiches_Mvt`, 100 écritures
2017 dans `Fiches_Mvt1`). Pour changer le volume ou la répartition, modifier le script puis, depuis la racine du dépôt :

```bash
python3 .hidden/Tests/Compta/assets/rubimp_performance/gen_rubimp_perf.py > .hidden/Tests/Compta/assets/rubimp_performance/rubimp_perf.sql
python3 $R harness apply && python3 $R replay Compta/rubimp_performance --clone ref --expected   # attendus régénérés
python3 $R compare Compta/rubimp_performance
```

Le volume (~1 000 écritures) suffit : on mesure l'exécution du code Gambas et l'effet du format des requêtes, pas
MariaDB. Durée de référence : 10,7 s (ref et rework, machine peu chargée) ; au-delà de 20 s, le délai se demande à
l'utilisateur (`timeout_accord`). Le générateur n'est pas recopié dans le clone de référence (seul le jeu y sert).
