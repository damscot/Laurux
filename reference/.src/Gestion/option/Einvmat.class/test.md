# Einvmat — Tests

> Source : `.src/Gestion/option/Einvmat.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

État d'impression en lecture seule (pas d'écriture comptable, pas un module complexe ; les
scénarios de clôture sont portés par [Caleditcmat](../Caleditcmat.class/test.md)). Sortie
comparée : texte du PDF `~/tmp/cmtmat.pdf` (`pdftotext -layout`, dates masquées) et lignes
`Exec_SQL`. Horloge figée (`faketime`), valeurs attendues produites dans le clone non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EINVMAT-T01 | replay | Déclaration provisoire, régime acquitté | jeu `cmat_base` ; Caleditcmat → mois du jeu, « Acquitté », « Edition provisoire » → Edition | texte PDF : en-tête société, exercice, une ligne par régie acquittée, totaux | `tests/declaration_acquitte/` | à faire |
| EINVMAT-T02 | replay | Formatage hl/l/cl (A01) | régie dont le volume de fin vaut 199,996 l, une autre 0,5 l | figer « 1 / 99 / (vide) » et « (vide) / (vide) / 50 » | `tests/formatage_volumes/` | à faire |
| EINVMAT-T03 | replay | Volume négatif (A03) | sorties > stock début + entrées (fin = -150 l) | figer la ligne imprimée | `tests/volume_negatif/` | à faire |
| EINVMAT-T04 | replay | Multi-sociétés (A02) | base à deux sociétés, session sur la 2e | figer la société imprimée (la 1re) | `tests/multi_societes/` | à faire |
| EINVMAT-T05 | gbtest | `Convers` (après EINVMAT-004) | volumes 0 ; 0,5 ; 99,994 ; 100 ; 199,996 ; -150 ; × `h`/`l`/`c`, avec et sans arrondi initial | chaînes de référence | `tests/convers/` | à faire |

## Détail des tests

- **Jeu `cmat_base`** : voir [atribvignette](../atribvignette.class/test.md) ; il doit contenir au
  moins deux régies acquittées et une suspendue (pour vérifier le filtrage par régime).
- **T05** : écrit après l'extraction de `Convers` dans le module commun ; ses valeurs attendues
  sont produites par un script `gbs3` reprenant le code actuel de `convers` des deux reports
  (clone non modifié), pour figer les deux variantes.
- **Cas non testables** : mise en page fine (largeurs, bordures) : vérification visuelle.
