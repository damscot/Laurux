# Saisiedecons — Tests

> Source : `.src/Gestion/option/Saisiedecons.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran mixte : replays avec dump de `Fiches_ligcons` et `Fiches_Entrecpt`, plus `gbtest` des calculs
extraits (après SAISIEDECONS-002/003). Valeurs attendues produites dans le clone **Laurux non
modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAISIEDECONS-T01 | replay | Sélection d'une réception | fournisseur numérique saisi ; n° de réception saisi | en-tête HT/TTC/consignes/déconsignations/accise affiché (log) | `tests/selection_reception/` | implémenté |
| SAISIEDECONS-T02 | replay | Déconsignation palette + colis proposés | article à `art_nbcol`/`art_nbbou` ; 2 palettes ; Valider | 3 lignes `Fiches_ligcons` `numlig = 'D'` ; `Fiches_Entrecpt.montant/mttc` diminués | `tests/deconsignation/` | implémenté |
| SAISIEDECONS-T03 | replay | Modification d'une ligne | double-clic sur une ligne ; nouvelle quantité ; Valider | UPDATE de la ligne, totaux corrigés | `tests/modification/` | à faire : GridView1 sans `_Click` (double-clic / Activate non rejouable, REPLAYOBSERVER-A14) |
| SAISIEDECONS-T04 | replay | Suppression d'une ligne | Suppr sur une ligne | DELETE ; `Fiches_Entrecpt` **inchangé** (A01 figée) | `tests/suppression/` | à faire : GridView1 sans `_Click` (sélection de ligne non rejouable, REPLAYOBSERVER-A14) |
| SAISIEDECONS-T05 | replay | Accise recumulée | sortir deux fois de la zone n° de réception | `Labelacc` doublé (A02 figée, log) | `tests/accise_cumul/` | à faire : après la 1re sélection, `Panel1.Enabled = False` : la zone n° de réception ne reprend pas le focus (scénario d'essai : selectionbr exécuté une seule fois) ; à caractériser autrement |
| SAISIEDECONS-T06 | replay | Calculette F5 | F5 dans une quantité ; `3*4` ; validation | quantité `12` | `tests/calculette/` | à faire : touche F5 (FCalc) non rejouable |
| SAISIEDECONS-T07 | gbtest | Montant d'une déconsignation | code de consigne, nombre (après SAISIEDECONS-003) | `nb`, `montant` négatifs de référence | `tests/montant_ligne/` | à faire : exige une extraction (après SAISIEDECONS-003) |

## Détail des tests

- **Données** : jeu `option_boisson` + une réception non validée d'un fournisseur à code
  numérique, avec lignes d'articles à régie (`drfac` vrai) et consignes existantes.
- **Rejeu** : les listes flottantes (`rechbl`, `rechcons`, créées par code) ne sont pas journalisées :
  saisir fournisseur, n° de réception et codes de consigne au clavier. `GridView1` sans
  `_Click` : utiliser double-clic (Activate) et Suppr (KeyPress).
- **Comparaison** : dump normalisé (identifiants auto-incrémentés exclus).
- **Implémentation (vague 6)** : `/Soc01/bois` = -1, menu dynamique `decfour` (`Fmenu#Menu66#Menu77#decfour#`) ;
  jeu `saisiedecons_shared/decons_base.sql` (copie de `modfichier_shared/options_bois_pp` + régie 03 à droits sur
  facture, consignes P1/C1, article 001 consigné P1/C1/01 à 10 colis et 6 bouteilles, réception R0001 du 401001
  (HT 100, TTC 120), deux lignes `Fiches_ligcons`). Scénarios `saisiedecons_selection_reception` (T01, sql.log
  ordonné) et `saisiedecons_deconsignation` (T02 : 2 palettes → 20 colis → 120 bouteilles, lignes D -20 / -30 / -24,
  Entrecpt 26 / 46). Saisie au clavier + Entrée (focus suivant par `Tag`, LostFocus réels).
