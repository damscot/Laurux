# atribvignette — Tests

> Source : `.src/Gestion/option/atribvignette.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI qui **écrit** la colonne `vignette` de `Fiches_ligregie`. Il n'appelle pas
`Utils.Observers(Me)` : en l'état, il **n'est pas journalisé**, donc pas rejouable. Les scénarios
ci-dessous supposent l'une des deux solutions à valider en début de phase 2 : instrumentation
ajoutée dans les deux clones avant capture (ATRIBVIGNETTE-A03), ou exécution manuelle guidée avec
comparaison du dump. Valeurs attendues produites dans le clone Laurux non modifié.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ATRIBVIGNETTE-T01 | replay | Affichage de l'arbre et des manquants | jeu `cmat_base` (régie suspendue + régie acquittée ; BL, facture, réception, mouvement exceptionnel ; vignettes 1, 2, 5) | lignes `Exec_SQL` ; manquants 3 et 4 | `tests/affichage/` | à faire |
| ATRIBVIGNETTE-T02 | replay | Attribution d'un numéro à une ligne de BL | activer un nœud BL → saisir `3` → Entrée | `vignette` = `000…03` sur les lignes `numlig LIKE bl%` du document | `tests/attribution_bl/` | à faire |
| ATRIBVIGNETTE-T03 | replay | Attribution sur une réception | nœud « Réception B.R » → `4` → Tab | toutes les lignes non clôturées du document mises à jour | `tests/attribution_reception/` | à faire |
| ATRIBVIGNETTE-T04 | replay | Numéro déjà utilisé, saisie non numérique | saisir `1` sur une autre ligne ; saisir `abc` | aucun `UPDATE` ; ballon | `tests/refus/` | à faire |
| ATRIBVIGNETTE-T05 | replay | Mise à blanc | nœud avec vignette → `Button1` | `vignette = ''` sur les lignes visées | `tests/mise_a_blanc/` | à faire |
| ATRIBVIGNETTE-T06 | replay | Ligne déjà clôturée d'un même BL (A02) | jeu avec une ligne clôturée et une non clôturée sur le même `num`/BL | figer : la ligne clôturée est aussi modifiée | `tests/ligne_cloturee/` | à faire |
| ATRIBVIGNETTE-T07 | replay | Document de type `C` non clôturé (A01) | jeu avec une ligne `type='C'` en régie suspendue | figer le comportement (erreur ou libellé erroné) | `tests/type_c/` | à faire |
| ATRIBVIGNETTE-T08 | gbtest | Calcul des manquants (après ATRIBVIGNETTE-003) | listes de vignettes : `[1,2,5]`, `[]`, `[7]`, numéros > 2^53 | listes attendues (caractérisation du `Float`) | `tests/manquants/` | à faire |

## Détail des tests

- **Jeu `cmat_base`** (partagé avec [Caleditcmat](../Caleditcmat.class/test.md),
  [Ecomptamat](../Ecomptamat.class/test.md), [Einvmat](../Einvmat.class/test.md),
  [Visucmat](../Visucmat.class/test.md), [EditStkDepart](../EditStkDepart.class/test.md)) :
  `Laurux01.sql`, puis activation de l'option boissons dans le clone non modifié (Préférences →
  case `bois`, qui exécute `modfichier.fichierboisson`), puis insertion de deux régies
  (`Fiches_regie` : une `suspendu=1`, une `suspendu=0`, taux de droit et de sécurité sociale),
  d'articles avec `art_dra`/`art_volm`/`art_deg`, de `Fiches_Parametres.arrete`, et de lignes
  `Fiches_ligregie` de types `I`, `M`, `E`, `S` (non clôturées et clôturées) avec vignettes.
- **T08** ne peut être écrit qu'après l'extraction de `VignettesManquantes` en fonction `Public`
  testable (rework ATRIBVIGNETTE-003) ; ses valeurs attendues sont produites en appliquant
  l'algorithme actuel (même code déplacé) dans le clone non modifié via un script `gbs3`.
- **Cas non testables** : la durée d'affichage pour un trou de plusieurs millions de numéros
  (boucle sans limite) ; à documenter seulement.
