# Attribution — Tests

> Source : `.src/Gestion/Lcr/Attribution.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

> ⚠️ **Module complexe** (chaîne LCR menant au fichier bancaire de `Bordrx`) : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle,
> tests implémentés sans validation individuelle.

Écran GUI. `Utils.Observers(Me)` n'est pas appelé : les replays supposent l'ajout de cet appel dans
les **deux** clones (ATTRIBUTION-A06) ou un pilotage direct par le harnais. Jeu de données dérivé
de `Laurux01.sql` : 2 banques, 8 LCR (non attribuées écartées/non écartées, attribuées banque 1 et
2, une LCR dans un bordereau, une acceptée), clients correspondants.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| ATTRIBUTION-T01 | replay | Ouverture (non attribuées) | ouverture | liste `banque = 0 and ecartee = 0 and bordereau = 0` ; totaux `0` / `0,00` (A01 figée) | `tests/ouverture/` | implémenté (`Gestion/attribution_ouverture`) |
| ATTRIBUTION-T02 | replay | Attribuées, toutes banques puis une banque | radio `A` ; choix banque 1 | listes et totaux affichés (total partiel figé) | `tests/attribuees/` | implémenté (`Gestion/attribution_attribuees`) |
| ATTRIBUTION-T03 | replay | Tri et recherche par échéance | focus sur chaque en-tête ; frappe `1503` puis `15032026` dans `DAE` | lignes `Exec_SQL` (`like "%-03-15%"`…) | `tests/recherche_echeance/` | implémenté (`Gestion/attribution_recherche_echeance` : 3006 puis BackSpace puis 30062018 ; la saisie de 8 chiffres après 4 donne `%02-06-%-%`, figé) |
| ATTRIBUTION-T04 | replay | Consultation et modification | clic sur une LCR, changement de banque `BQ2` et d'échéance, Valider | dump `Fiches_Lcr` | `tests/modification/` | implémenté (`Gestion/attribution_modification` : banque BQ2 et écartée ; l'échéance `datee` est ReadOnly à l'écran, non modifiée) |
| ATTRIBUTION-T05 | replay | Attribution en masse | banque 2 dans `BQ`, « Attribuer », Oui | dump `Fiches_Lcr` : `banque = 2` sur les LCR non écartées hors bordereau | `tests/attribution_masse/` | implémenté (`Gestion/attribution_attribution_masse` : un UPdate par LCR) |
| ATTRIBUTION-T06 | replay | Attribution sans banque / liste vide | « Attribuer » sans banque ; puis avec banque et aucune LCR attribuable | message « Vous devez sélectionner… » ; message d'erreur figé, base inchangée | `tests/attribution_erreurs/` | implémenté (`Gestion/attribution_attribution_erreurs`, jeu `sans_attribuable`) |
| ATTRIBUTION-T07 | replay | Suppression | sélection, Supprimer, Oui | dump `Fiches_Lcr` | `tests/suppression/` | implémenté (`Gestion/attribution_suppression`) |
| ATTRIBUTION-T08 | replay | Impression | `N` ; `A` sans banque ; `A` banque 1 ; « Imprimer » | 3 PDF `~/Lcr.pdf` par `pdftotext` (sélection sans filtre `bordereau`, A03 figée) | `tests/impression/` | implémenté (`Gestion/attribution_impression` : 3 PDF dans edition.txt, A03 figée) |
| ATTRIBUTION-T09 | replay | SQLite | T05 sur `Laurux01.sqlite` | même dump (verrous neutralisés) | `tests/sqlite/` | à faire : SQLite (base Laurux01.sqlite non jouable par le harnais) |

## Détail des tests

- Valeurs attendues capturées dans le clone **Laurux non modifié** : dump normalisé de `Fiches_Lcr`,
  PDF par `pdftotext` avec date (`faketime`) et utilisateur figés, totaux `Nb2`/`Mt2` lus dans le log.
- T05 vérifie aussi le nombre de lignes `UPdate` du log (une par LCR) : un rework en un seul
  `UPdate` sera déclaré « SQL modifié, dump identique ».
- Le comportement de `ColLcr.MoveTo` au-delà de la dernière ligne (fin de la boucle d'attribution)
  est observé par T05/T06 et documenté dans `expected/`.

- Phase 2 (vague 9) : jeu `Gestion/bordrx_shared/lcr_chaine` (voir Bordrx) ; T06 : `attribution_attribution_erreurs/sans_attribuable.sql`.
