# Edmo — Tests

> Source : `.src/Gestion/Impressions/Edmo.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests `replay` depuis le menu « Main d'oeuvre » : texte `pdftotext -layout` de `~/tmp/MO.pdf`
(date et utilisateur du pied normalisés), lignes `Exec_SQL`, dump inchangé. Valeurs attendues
produites dans le clone **non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EDMO-T01 | replay | Liste complète par code | défauts, **Imprimer** | `Level1MO`/`Level2MO` ; HT = `mo_valeurht` ou `mo_txht × mo_montant` ; TTC recalculé | `tests/edmo_code/` | implémenté |
| EDMO-T02 | replay | Tri par famille et plages | `RadioButton2`, plages Mo et famille restreintes | ordre et filtrage | `tests/edmo_famille/` | implémenté |
| EDMO-T03 | replay | Pagination | > 50 mains d'oeuvre | saut à 280 mm, en-tête répété | `tests/edmo_pagination/` | implémenté |
| EDMO-T04 | replay | Valeur invalide | `mo_valeurht` non numérique sur une ligne | message « Veuillez verifier le taux horaire… », pas de PDF, curseur en attente (A01 figée) | `tests/edmo_valeur_invalide/` | implémenté |
| EDMO-T05 | replay | Aucune ligne | plage vide | message puis erreur `Draw.End` éventuelle (A02 figée) | `tests/edmo_vide/` | implémenté |
| EDMO-T06 | replay | Listes et navigation | listes Mo/famille par bouton, clic, Échap ; Entrée sur `Fam2` | champs remplis ; focus renvoyé sur `Mo` (A03 figée) | `tests/edmo_listes/` | implémenté (sans Échap : non rejouable) |
| EDMO-T07 | gbtest | Calcul TTC (après EDMO-003) | HT `"12,50"`, taux 20 / 5,5 / 0 ; code TVA inconnu | chaînes TTC identiques à celles de T01 | `tests/edmo_ttc/` | à faire : après EDMO-003 (calcul TTC à extraire) |

## Détail des tests

- **Données** : jeu `editions_articles` ([EdArt1/test.md](../EdArt1.class/test.md#détail-des-tests)) :
  une dizaine de `Fiches_Mo` (`mo_tempmont` 0 et 1, deux codes TVA, un code TVA absent), plus de
  50 lignes pour T03, une ligne à `mo_valeurht` invalide pour T04 (jeu séparé).
- **Non testable automatiquement** : son, couleur du focus, aide F1 (`Edmo`).
- **Implémentation (vague 5)** : jeu `.hidden/Tests/Gestion/assets/edmo_shared/edmo_base.sql` (Mo 05 de Laurux01
  rendue imprimable, Mo 06 à 09 : famille 11, codes TVA 1, 2 et 9 inconnu) ; scénarios `edmo_code` (T01),
  `edmo_famille` (T02), `edmo_pagination` (T03, jeu `edmo_soixante.sql`, 65 Mo, 2 pages), `edmo_valeur_invalide`
  (T04 : Laurux01 seul, la Mo 05 a `mo_valeurht` NULL), `edmo_vide` (T05, code de sortie 125 : `Draw.End` de
  `Button2_Click`), `edmo_listes` (T06 : 4 listes, Entrée sur Fam2 puis sur Mo, bornes vérifiées dans la requête).
  Texte du PDF par `pdftotext` (`edition.txt`).
