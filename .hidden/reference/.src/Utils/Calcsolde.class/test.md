# Calcsolde — Tests

> Source : `.src/Utils/Calcsolde.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Logique comptable : `Calcul` est `Public` et testable en **gb.test** sur une base MariaDB restaurée
(l'appel instancie le formulaire caché : affichage virtuel requis, à confirmer). Les scénarios GUI
sont couverts par **replay** avec dump normalisé de `Fiches_Comptes` (`compte_cc`, `solde`,
`soldep`) et diff du log SQL.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALCSOLDE-T01 | gbtest | `Calcul` compte général | compte avec écritures validées et non validées | `solde` = Σ D − Σ C validées ; `soldep` inchangé si `Treso = False` | `tests/compte_general/` | à faire |
| CALCSOLDE-T02 | gbtest | `Calcul` trésorerie | compte 512 : écritures pointées, non pointées, report à nouveau clôturé du journal `jdr` | `solde` et `soldep` de référence | `tests/tresorerie/` | à faire |
| CALCSOLDE-T03 | gbtest | Compte sans écriture validée | `soldep` initial non nul | `solde = 0.00`, `soldep` inchangé (figé) | `tests/sans_ecriture/` | à faire |
| CALCSOLDE-T04 | gbtest | Appel style `Pointage` | `Calcul(cpt, True)` sans `jan` | `soldep` non recalculé (A01 figée) | `tests/appel_pointage/` | à faire |
| CALCSOLDE-T05 | gbtest | Arrondi | montants à 3 décimales, négatifs | format `LPrix(...).D` | `tests/arrondi/` | à faire |
| CALCSOLDE-T06 | replay | Recalcul global | menu Compta → recalcul des soldes, « Lancer » | dump de `Fiches_Comptes` | `tests/replay_global/` | à faire |
| CALCSOLDE-T07 | replay | Suppression d'un relevé | Pointage : supprimer un relevé | dump `Fiches_Mvt` (pointee, nrlv) + `Fiches_Comptes` | `tests/replay_pointage/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** sur la base restaurée.
- **Données** : `Laurux01.sql` + jeu dérivé : 4 comptes (dont un de trésorerie `comptr_cc = 1`),
  ~20 écritures `Fiches_Mvt` (validées ou non, pointées ou non, une écriture de report à nouveau
  clôturée dans le journal `jdr`), relevé `TabRappro` pour T07.
- **Non testable automatiquement** : son et message final (T06 par replay).
