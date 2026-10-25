# Saisiedecons — Tests

> Source : `.src/Gestion/option/Saisiedecons.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran mixte : replays avec dump de `Fiches_ligcons` et `Fiches_Entrecpt`, plus `gbtest` des calculs
extraits (après SAISIEDECONS-002/003). Valeurs attendues produites dans le clone **Laurux non
modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAISIEDECONS-T01 | replay | Sélection d'une réception | fournisseur numérique saisi ; n° de réception saisi | en-tête HT/TTC/consignes/déconsignations/accise affiché (log) | `tests/selection_reception/` | à faire |
| SAISIEDECONS-T02 | replay | Déconsignation palette + colis proposés | article à `art_nbcol`/`art_nbbou` ; 2 palettes ; Valider | 3 lignes `Fiches_ligcons` `numlig = 'D'` ; `Fiches_Entrecpt.montant/mttc` diminués | `tests/deconsignation/` | à faire |
| SAISIEDECONS-T03 | replay | Modification d'une ligne | double-clic sur une ligne ; nouvelle quantité ; Valider | UPDATE de la ligne, totaux corrigés | `tests/modification/` | à faire |
| SAISIEDECONS-T04 | replay | Suppression d'une ligne | Suppr sur une ligne | DELETE ; `Fiches_Entrecpt` **inchangé** (A01 figée) | `tests/suppression/` | à faire |
| SAISIEDECONS-T05 | replay | Accise recumulée | sortir deux fois de la zone n° de réception | `Labelacc` doublé (A02 figée, log) | `tests/accise_cumul/` | à faire |
| SAISIEDECONS-T06 | replay | Calculette F5 | F5 dans une quantité ; `3*4` ; validation | quantité `12` | `tests/calculette/` | à faire |
| SAISIEDECONS-T07 | gbtest | Montant d'une déconsignation | code de consigne, nombre (après SAISIEDECONS-003) | `nb`, `montant` négatifs de référence | `tests/montant_ligne/` | à faire |

## Détail des tests

- **Données** : jeu `option_boisson` + une réception non validée d'un fournisseur à code
  numérique, avec lignes d'articles à régie (`drfac` vrai) et consignes existantes.
- **Rejeu** : les listes flottantes (`rechbl`, `rechcons`, créées par code) ne sont pas journalisées :
  saisir fournisseur, n° de réception et codes de consigne au clavier. `GridView1` sans
  `_Click` : utiliser double-clic (Activate) et Suppr (KeyPress).
- **Comparaison** : dump normalisé (identifiants auto-incrémentés exclus).
