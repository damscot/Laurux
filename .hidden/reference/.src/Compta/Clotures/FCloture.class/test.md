# FCloture — Tests

> Source : `.src/Compta/Clotures/FCloture.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de traitement : tests **replay** sur MariaDB Docker, critère = dump normalisé de
`Fiches_Mvt` et `Fiches_Parametres`. La clôture fait partie des **modules complexes** du plan
(PLAN §0) : la liste de scénarios ci-dessous est à présenter à l'utilisateur avant implémentation.

Scénarios validés par l'utilisateur le 2026-11-16 : T01-T04, T06, T07 ; T05 non retenu.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLOTURE-T01 | replay | Clôture d'un mois nominal | jeu dérivé de `Laurux01.sql` : mois M avec écritures validées, certaines avec `numerodef` déjà posé ; Oui | `cloturee = 1`, `dteval`, `numerodef` attribués dans l'ordre des `numero` ; `dtepc` = dernier jour de M ; `numecriture2` incrémenté | `tests/cloture_mois/` | implémenté (scénario `Compta/fcloture_cloture_mois` : menu Clôture de période (Fmenu.Menu46, ShowModal), Lancer, « Oui » ; arrêt sans Quitter (REPLAYOBSERVER-A15) ; juin 2018 : 10 → numerodef 7, 11 garde 4, 12 → 8, dteval 2018-06-15 ; dtepc 2018-06-30, numecriture2 6 → 8 ; clés `control` valides, relues et recalculées par CalcSha1_Verify) ; variante `Compta/fcloture_cle_nulle` : mêmes écritures à clé NULL, clôture identique (clé NULL non contrôlée, Sha1Calc.module:110, comportement figé) |
| FCLOTURE-T02 | replay | Écritures provisoires restantes | une écriture `provisoire = 1` dans M | message « non validées », aucune modification de la base | `tests/provisoires/` | implémenté (scénario `Compta/fcloture_provisoires` : écriture 12 provisoire, avertissement validé, base inchangée) |
| FCLOTURE-T03 | replay | Clé SHA-1 altérée | `control` d'une écriture de M modifié | message « clé calculée… », fermeture ; écritures précédentes de la boucle déjà clôturées (comportement figé), `Fiches_Parametres` inchangé | `tests/sha1_invalide/` | implémenté (scénario `Compta/fcloture_sha1_invalide` : clé de l'écriture 11 altérée ; Message.Error, écran fermé ; écriture 10 déjà clôturée (numerodef 7), 11/12 et Fiches_Parametres inchangés, A01 figée) |
| FCLOTURE-T04 | replay | Clôture de décembre | `dtepc` au 30/11/N | `dtepc` = 31/12/N ; affichage suivant « janvier N+1 » | `tests/decembre/` | implémenté (scénario `Compta/fcloture_decembre` : dtepc 2018-11-30 → 2018-12-31, écritures 20/21 clôturées, 22 de janvier 2019 inchangée) |
| FCLOTURE-T05 | replay | Interruption par la barre de progression | clic sur Arrêter après k écritures | k écritures clôturées, `dtepc` avancé malgré tout (A01 figée) | `tests/interruption/` | à faire : non retenu par l'utilisateur le 2026-11-16 (arrêt de la ProgBar dépendant du minutage) |
| FCLOTURE-T06 | replay | Mois sans écriture | aucun mouvement dans M | `Fiches_Mvt` inchangé ; `dtepc` avancé ; `numecriture2` inchangé | `tests/mois_vide/` | implémenté (scénario `Compta/fcloture_mois_vide` : mars 2018 vide ; Fiches_Mvt inchangé, dtepc 2018-03-31, numecriture2 réécrit à 6) |
| FCLOTURE-T07 | replay | Mois postérieur à la fin d'exercice | `dtepc` = `dteclec` | clôture acceptée (aucun contrôle, A02 figée) | `tests/hors_exercice/` | implémenté (scénario `Compta/fcloture_hors_exercice` : dtepc = dteclec = 2018-12-31 ; écriture 30 de janvier 2019 clôturée, dtepc 2019-01-31, A02 figée) |
| FCLOTURE-T08 | gbtest | Calcul période suivante / dernier jour (après FCLOTURE-005) | `dtepc` en fin de mois, décembre, février bissextile | mois suivant et dernier jour attendus | `tests/periode_suivante/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est capturé dans le clone **Laurux non
  modifié** puis rejoué sur les deux clones ; les dumps normalisés sont comparés.
- **Date du jour** : `dteval = Format$(Now, "yyyymmdd")`. Le runner fige la date (`faketime`) ou
  masque `dteval` dans la normalisation du dump.
- **Données (phase 2)** : jeux `fcloture_<scénario>.sql` générés par `Compta/assets/fcloture_shared/gen_fcloture.py` (clés `control` calculées par Laurux, `Sha1Calc.CalcSha1_all`, dans le clone de référence sous la date des scénarios 2018-06-15 et recopiées dans `fcloture_shared/cles.txt` ; T03 altère la clé de l'écriture 11 ; le jeu `fcloture_cle_nulle` garde des clés NULL). **La clé dépend de la saison de calcul** : `CStr` de `dte` est converti en UTC avec le décalage horaire courant (été/hiver), des clés calculées en janvier ne se vérifient pas sous une date de juin ; régénérer les clés à la date des scénarios (procédure dans `gen_fcloture.py`).
- **Variante `fcloture_cle_nulle` (FCLOTURE-T01), test à basculer** : décision utilisateur du 2026-11-16 : une clé `control` NULL doit être une erreur (anomalie SHA1CALC-A02, support temporaire de l'introduction du chaînage). Aujourd'hui le scénario passe sans erreur (écriture à clé NULL clôturée, conforme au code de référence) ; après correction de SHA1CALC-A02 il devra passer en constatant l'erreur (Message.Error « Clôture impossible ! La clé calculée… », écriture non clôturée, `Fiches_Parametres` inchangé) : changer alors son attendu (xfail pendant la transition, puis attendus régénérés). Les clés des jeux ne sont valides que sous la date figée de juin (SHA1CALC-A01).
- **Données (prévu)** : jeu dérivé de `Laurux01.sql` construit par `gen_input.py` (écritures d'un mois
  donné, clés `control` recalculées par `Sha1Calc.CalcSha1_all` dans le clone de référence).
- **Non testable automatiquement** : `Aff_date` sur table `Fiches_Parametres` vide (appelle
  `Quit` ; scénario manuel), son, documentation HTML (`xdg-open`).
