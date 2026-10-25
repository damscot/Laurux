# Fondcaisse — Tests

> Source : `.src/Caisse/Fondcaisse.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe (fond de caisse, lié au ticket Z)** : la liste des scénarios ci-dessous est
> **à faire valider par l'utilisateur avant la phase 2** (PLAN.md §0 et §4.5).

Écran GUI ouvert depuis `Cmenu` (« Saisie fond de caisse ») ou depuis la saisie `Caisse`.
`Utils.Observers(Me)` est appelé une seule fois dans `_new` : rejouable ; aucune grille (pas de
`replay_missing`). Comparaisons : dump de la base (`Fiches_Caisses.fndc`), valeurs affichées
(`FDC_The`, `Box1`, `Mon*`) relevées dans le journal de rejeu, messages.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FONDCAISSE-T01 | replay | Contrôle, fond juste | caisse `1` connectée, `tkz = 0`, `fndc` 150,00, tickets non validés : espèces `N` 80,00, rendus `Q` 12,50 | `FDC_The` = 217,50 ; « OK » ferme sans écriture | `tests/controle_juste/` | à faire |
| FONDCAISSE-T02 | replay | Contrôle, écart | mêmes données, réel saisi 200,00 ; « Annuler » puis « Sortir » | avertissement d'écart, base inchangée | `tests/controle_ecart/` | à faire |
| FONDCAISSE-T03 | replay | Détail des coupures | « Détail caisse », quantités sur 5 coupures, pavé numérique, « Correction », « Préc. »/« Suiv. » | montants `Mon*` et total `Box1` attendus | `tests/detail_coupures/` | à faire |
| FONDCAISSE-T04 | replay | Correction du fond initial | double-clic `FDC_Ini`, « Oui », `160,00` ; variante `160.00` | `fndc = 160.00`, `FDC_The` recalculé ; variante : message répété (A04 figée) | `tests/correction_initial/` | à faire |
| FONDCAISSE-T05 | replay | Modification après ticket Z | `tkz = 1`, saisie 200,00, « OK » ; variante « annuler » | `fndc = 200.00` ; variante : base inchangée | `tests/modification_tkz/` | à faire |
| FONDCAISSE-T06 | replay | Caisse absente | `Ncai = "9;1 "` (caisse inexistante), ouverture depuis `Cmenu` | figer l'erreur non interceptée du constructeur (A01) | `tests/caisse_absente/` | à faire |
| FONDCAISSE-T07 | replay | Édition d'une coupure | `Suppr` et `Retour arrière` en milieu et en début de champ | figer le texte et la position obtenus (A03) | `tests/edition_coupure/` | à faire |
| FONDCAISSE-T08 | replay | Cohérence avec le ticket Z | jeu de T01 avec des tickets sur deux dates et des en-têtes `mespeces` ; fond théorique puis ticket Z (`Moulinage`) | figer les deux montants (fond théorique, fond final du ticket Z) (A02) | `tests/coherence_ticket_z/` | à faire |
| FONDCAISSE-T09 | gbtest | Fond théorique (après FONDCAISSE-005) | jeux de T01 et T08 ; `FdcTheorique("1", 150)` | 217,50 et valeur de T08 | `tests/fdc_theorique/` | à faire |
| FONDCAISSE-T10 | gbtest | Total des coupures (après FONDCAISSE-005) | quantités sur les 15 coupures, valeur vide, valeur non numérique | montants et total ; cas d'erreur | `tests/total_coupures/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié** ; T09/T10 réutilisent
  les valeurs de T01/T03/T08 (même calcul, appelé sans GUI après la séparation traitement/GUI).
- **Données** : jeu dérivé `caisse_base` + tickets non validés (`Fiches_EntTicketz` `statut = '0'`,
  `suppr = 0`, et `Fiches_LigTicketz` de types `N`, `Q`, `U`), un ticket supprimé (`suppr = 1`)
  à exclure ; T08 ajoute des lignes dont la date diffère de l'en-tête.
- **Type de `tkz`** : T05 vérifie aussi que le mode « modification » est bien atteint avec la base
  MariaDB du harnais (`tinyint(1)` lu comme `Boolean` ou `Integer`, à confirmer).
- **Non testable automatiquement** : agrandissement des images (`btn_Enter`), survol des boutons,
  images d'une autre devise.
- T04, T06, T07 et T08 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
