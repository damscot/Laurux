# Ecomptamat — Tests

> Source : `.src/Gestion/option/Ecomptamat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Pas un module complexe** : Ecomptamat n'écrit aucune écriture comptable ni aucune ligne de
régie ; il imprime la déclaration du régime suspendu calculée par Caleditcmat. Les scénarios de
clôture, qui écrivent en base, sont dans [Caleditcmat](../Caleditcmat.class/test.md) (module
complexe ; Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle). Sortie comparée : texte du PDF `~/tmp/cmtmat.pdf`
(`pdftotext -layout`, dates masquées) et lignes `Exec_SQL` ; horloge figée ; valeurs attendues
produites dans le clone non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECOMPTAMAT-T01 | gbtest | Déclaration provisoire, régime suspendu | jeu `cmat_base` ; Caleditcmat → « Suspendu », « Edition provisoire » → Edition | texte PDF : vignettes, volumes, droits, sécurité sociale, total à payer | `tests/declaration_suspendu/` | implémenté (EcomptamatTest.T01DeclarationSuspendu : rapport construit en gb.test avec la Collection de Declaration ; champs Data et textes relevés) |
| ECOMPTAMAT-T02 | replay | Calcul sur fiche régie / sur montants des lignes | même jeu, case « Calcul sur fiche régie » cochée puis décochée | deux PDF de référence (droits et tarifs) | `tests/mode_calcul/` | à faire : le choix du mode de calcul est fait par Caleditcmat.Edit (privé) ; l’édition imprimée n’est pas relevable (gb.report, pdftotext vide) : après extraction CALEDITCMAT-003 |
| ECOMPTAMAT-T03 | replay | Arrondis inférieur / supérieur, nombre de décimales | « Inferieur », « Superieur », décimales 0 et 2 | montants de référence | `tests/arrondis/` | à faire : arrondis calculés par Caleditcmat.Edit (privé) avant l’édition ; même raison que T02 |
| ECOMPTAMAT-T04 | gbtest | Réédition d'un mois clôturé (CALEDITCMAT-A05) | mois clôturé du jeu → Rédition | figer la plage de vignettes imprimée (vide attendue) | `tests/reedition/` | implémenté (T04Reedition ; plage de vignettes vide figée) |
| ECOMPTAMAT-T05 | gbtest | Vignette mise à blanc (A02) | une ligne du mois avec `vignette = ''` | figer « à X » | `tests/vignette_vide/` | implémenté (T05VignetteVide ; « à 0000000000000000000000000 » figé : vignette  en tête, valeur tronquée à 25 caractères par le jeu) |
| ECOMPTAMAT-T06 | gbtest | N° d'identification (A01) | société avec `ident` renseigné | figer la présence ou l'absence du n° dans le PDF | `tests/identifiant/` | implémenté (T06Identifiant) |
| ECOMPTAMAT-T07 | gbtest | `Convers` avec arrondi initial (après EINVMAT-004) | mêmes volumes qu'EINVMAT-T05 | chaînes de référence | `tests/convers/` | implémenté (T07Convers par les champs vae*dp) |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md) ; ajouter des taux de
  droits et de sécurité sociale (`tauxa`, `tauxss`) non nuls sur la régie suspendue.
- **T02/T03** pilotent des options de Caleditcmat mais ne vérifient que l'impression ; les mêmes
  captures servent aux tests de Caleditcmat.
- **T07** : même méthode qu'EINVMAT-T05 (script `gbs3` dans le clone non modifié).
