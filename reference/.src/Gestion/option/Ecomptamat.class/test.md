# Ecomptamat — Tests

> Source : `.src/Gestion/option/Ecomptamat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Pas un module complexe** : Ecomptamat n'écrit aucune écriture comptable ni aucune ligne de
régie ; il imprime la déclaration du régime suspendu calculée par Caleditcmat. Les scénarios de
clôture, qui écrivent en base, sont dans [Caleditcmat](../Caleditcmat.class/test.md) (module
complexe, liste à valider par l'utilisateur). Sortie comparée : texte du PDF `~/tmp/cmtmat.pdf`
(`pdftotext -layout`, dates masquées) et lignes `Exec_SQL` ; horloge figée ; valeurs attendues
produites dans le clone non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ECOMPTAMAT-T01 | replay | Déclaration provisoire, régime suspendu | jeu `cmat_base` ; Caleditcmat → « Suspendu », « Edition provisoire » → Edition | texte PDF : vignettes, volumes, droits, sécurité sociale, total à payer | `tests/declaration_suspendu/` | à faire |
| ECOMPTAMAT-T02 | replay | Calcul sur fiche régie / sur montants des lignes | même jeu, case « Calcul sur fiche régie » cochée puis décochée | deux PDF de référence (droits et tarifs) | `tests/mode_calcul/` | à faire |
| ECOMPTAMAT-T03 | replay | Arrondis inférieur / supérieur, nombre de décimales | « Inferieur », « Superieur », décimales 0 et 2 | montants de référence | `tests/arrondis/` | à faire |
| ECOMPTAMAT-T04 | replay | Réédition d'un mois clôturé (CALEDITCMAT-A05) | mois clôturé du jeu → Rédition | figer la plage de vignettes imprimée (vide attendue) | `tests/reedition/` | à faire |
| ECOMPTAMAT-T05 | replay | Vignette mise à blanc (A02) | une ligne du mois avec `vignette = ''` | figer « à X » | `tests/vignette_vide/` | à faire |
| ECOMPTAMAT-T06 | replay | N° d'identification (A01) | société avec `ident` renseigné | figer la présence ou l'absence du n° dans le PDF | `tests/identifiant/` | à faire |
| ECOMPTAMAT-T07 | gbtest | `Convers` avec arrondi initial (après EINVMAT-004) | mêmes volumes qu'EINVMAT-T05 | chaînes de référence | `tests/convers/` | à faire |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md) ; ajouter des taux de
  droits et de sécurité sociale (`tauxa`, `tauxss`) non nuls sur la régie suspendue.
- **T02/T03** pilotent des options de Caleditcmat mais ne vérifient que l'impression ; les mêmes
  captures servent aux tests de Caleditcmat.
- **T07** : même méthode qu'EINVMAT-T05 (script `gbs3` dans le clone non modifié).
