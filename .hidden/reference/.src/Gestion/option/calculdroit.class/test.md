# calculdroit — Tests

> Source : `.src/Gestion/option/calculdroit.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de calcul avec lecture SQL : tests `gbtest` sur base MariaDB jetable (jeu dérivé
`option_boisson`, voir `Consigne/test.md`), valeurs attendues produites dans le clone **Laurux
non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CALCULDROIT-T01 | gbtest | Volumes et droit, assiette volume | régie `ap` faux ; vol 75, deg 12,5, qte 6 | `vol`, `volap` = 0, `droit`, `tvadroit` | `tests/droit_volume/` | implémenté |
| CALCULDROIT-T02 | gbtest | Volumes et droit, assiette alcool pur | régie `ap` vrai ; vol 70, deg 40, qte 12 | `vol`, `volap`, `droit` | `tests/droit_alcool_pur/` | implémenté |
| CALCULDROIT-T03 | gbtest | Seuil sécurité sociale | `degres` 18 ; deg 15 / 18 / 40 ; `degres` NULL | `secu`, `volumess`, `tvasec`, `tva` | `tests/secu_seuil/` | implémenté |
| CALCULDROIT-T04 | gbtest | Quantité `Variant` | `qte` = 6, `"6"`, `"1,5"`, `"1.5"`, `1.5` | même `vol` pour les formes équivalentes | `tests/quantite_variant/` | implémenté |
| CALCULDROIT-T05 | gbtest | Accesseurs de la régie | régie complète ; `dra` vide | `lib`, `type`, `cptreg`, `codetva`, `code`, `suspendu`, `drsurfac`, `famille` ; zéros si `dra` vide | `tests/accesseurs/` | implémenté (propriété `code` non déclarée : inaccessible) |
| CALCULDROIT-T06 | gbtest | Écritures `droit`, `secu`, `tauxtvadr`, `tauxtvass` | valeurs 10 ; `"0.055"` | `tvadroit`, `tvasec`, `tva` recalculés ; `tauxtvadr` lu `"0,06"` (à figer) | `tests/ecritures/` | implémenté |
| CALCULDROIT-T07 | gbtest | Régie ou TVA absente | code inconnu ; TVA de régie inconnue ; `tvass` absente | valeurs à 0 ; `Message.Error` (exécution sous Xvfb ou après CALCULDROIT-003) | `tests/erreurs_regie/` | à faire : Message.Error bloquant en gb.test (après CALCULDROIT-003) |
| CALCULDROIT-T08 | replay | Intégration facture boissons | facture `facopt`/`ObjFacB` d'articles à droits (option T) | dump `Fiches_ligregie`, lignes de facture | `tests/facture_droits/` | implémenté (gb.test CalculdroitTest.T08FactureDroits, jeu Gestion objfacb_shared/bois_bl, option T : ObjFacB.calcul, comptmat, transblfac ; Fiches_ligregie et lignes de facture) |

## Détail des tests

- **Implémentation (phase 2)** : module `.src/Tests/Gestion/CalculdroitTest.test`, jeu `modfichier_shared/options_bois_pp` (régie 01 en volume, régie 02 en alcool pur seuil 18, TVA 3 = 20 %) ; la régie à `degres` NULL est insérée dans T03.

- **Données** : jeu `option_boisson` ; régies `ap` vrai/faux, seuil `degres` 18, TVA 20 % et 5,5 %.
- **Locale** : `fr_FR.UTF-8` imposée (conversion `Val(Replace(…, ".", ","))`).
- **T07** : `Message.Error` exige un affichage ; à exécuter sous Xvfb tant que la séparation
  traitement/GUI (CALCULDROIT-003) n'est pas faite.
- **T08** dépend des scénarios de `ObjFacB`/`facopt` (même lot) : à aligner avec leurs test.md.
