# TarArt — Tests

> Source : `.src/Utils/TarArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le calcul est dans le constructeur d'un formulaire : avant TARART-002, les tests **gbtest**
instancient `New TarArt(...)` sous affichage virtuel (Xvfb, à confirmer) et lisent les variables
publiques ; après, ils appellent `CalculTarif` directement. Base MariaDB restaurée à chaque test.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TARART-T01 | gbtest | Prix de base | article sans condition, client sans type | `prixht = art_pvht`, `nego = False`, 1 candidat | `tests/prix_base/` | implémenté |
| TARART-T02 | gbtest | Remise type client × famille | `Fiches_RemTypec` 2 lignes (dont le type du client) | prix remisé, `remise`, `detail` | `tests/remise_typec/` | implémenté |
| TARART-T03 | gbtest | Coefficient type client × famille | `Fiches_CoeffTypec` | `art_prvt × coeff` ; libellés identiques figés | `tests/coeff_typec/` | implémenté |
| TARART-T04 | gbtest | Coefficient type client × article | `Fiches_TarTypcli` | `art_prvt × coef` | `tests/tartypcli/` | implémenté |
| TARART-T05 | gbtest | Remise client × famille | `Fiches_RemCliFam` | prix remisé prioritaire | `tests/remclifam/` | implémenté |
| TARART-T06 | gbtest | Tarif client × article | `Fiches_Tarcli` + toutes les autres conditions | `Fiches_Tarcli` gagne | `tests/tarcli_priorite/` | implémenté |
| TARART-T07 | gbtest | Promotion | promo moins chère / plus chère | `promo`, `nego = False` ou inchangé | `tests/promo/` | implémenté |
| TARART-T08 | gbtest | Options B/T avec droits | `Utils.Option()` = B, article `art_dra` suspendu | prix diminués de `droit + secu` ; comparaison promo figée | `tests/droits_alcool/` | à faire : schéma « bois » (Fiches_regie, art_dra, art_volm, art_deg) absent de Laurux01.sql |
| TARART-T09 | gbtest | Cas d'erreur | article inconnu ; ni client ni type avec `Fiches_CoeffTypec` présent | figer les erreurs (A01, A02) | `tests/erreurs/` | implémenté |
| TARART-T10 | gbtest | Sans client, type fourni | `typec` seul (édition de tarif) | candidats et prix de référence | `tests/type_seul/` | implémenté |
| TARART-T11 | replay | Facture : choix d'un tarif | Facture, saisie client + article, ouverture de la grille, double-clic sur un tarif | `artpu` = prix choisi ; dump `Fiches_Ligbl` après enregistrement | `tests/replay_facture/` | à faire : choix par double-clic (GridView1_Activate) non rejouable ; Facture (module complexe) |
| TARART-T12 | replay | Édition de tarifs | Edart4 sur une famille, client donné | PDF/texte identique (comparaison du flux généré) | `tests/replay_edart4/` | à faire : comparaison de PDF non prise en charge par le runner |

## Détail des tests

- **Valeurs attendues** : produites dans le clone **Laurux non modifié** (sortie `id;valeur` des
  variables publiques et de la liste des candidats).
- **Données** : `Laurux01.sql` + jeu dérivé : 2 familles, 3 articles (dont un avec droits),
  2 types clients, 2 clients, une ligne dans chacune des 5 tables de conditions, une promotion.
  L'option de licence (`Utils.Option()`) est fixée par la configuration de test (`Laurux.conf`).
- **Non testable automatiquement** : couleur des lignes de la grille.
- Implémentation : `.src/Tests/Utils/TarArtTest.test` (formulaire instancié sous Xvfb avec une `Window` parente, candidats lus dans `GridView1` via `Controls`). Jeu de données : `.src/Tests/Framework/datasets/tarart_conditions.sql`.
