# FClotureAn — Tests

> Source : `.src/Compta/Clotures/FClotureAn.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module complexe (PLAN §0) : Décision utilisateur du
2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle. Tous les tests sont des replays sur MariaDB
Docker. Critère : **diff complet** du dump normalisé de `Fiches_Mvt`…`Fiches_Mvt5`,
`Fiches_MvtA`…`A5`, `Fiches_MvtM`…`M5`, `Fiches_Comptes`, `Fiches_Parametres`, `Report`,
`ReportM` (structure **et** données), plus les fichiers produits dans `~/Sauve`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLOTUREAN-T01 | replay | Clôture nominale | jeu dérivé : exercice N complet (types C, F, B, G, collectifs), toutes périodes clôturées, balance équilibrée ; Oui à toutes les questions | rotation des 18 tables ; à-nouveaux datés `dterpt` ; résultat sur `cptrsplus`/`cptrsmoins` ; soldes recalculés ; `dteclec*`, `dtetdec`, `dtefedec`, compteurs décalés ; clés `control` recalculées | `tests/cloture_nominale/` | implémenté (scénario `Compta/fcloturean_cloture_nominale`) |
| FCLOTUREAN-T02 | replay | Balance déséquilibrée | une écriture validée déséquilibrée sur un compte G | message « déséquilibrée », fermeture, base inchangée | `tests/balance_desequilibree/` | implémenté (scénario `Compta/fcloturean_balance_desequilibree`) |
| FCLOTUREAN-T03 | replay | Périodes non clôturées | `dtepc < dteclec` | message « dernière clôture inférieure », base inchangée | `tests/periodes_ouvertes/` | implémenté (scénario `Compta/fcloturean_periodes_ouvertes`) |
| FCLOTUREAN-T04 | replay | Écritures postérieures à la fin d'exercice | écritures N+1 sur comptes C, F, B, G, clôturées ou non | réinsérées dans `Fiches_Mvt` avec les colonnes reprises par type (pertes de colonnes et `lind` renuméroté figés, A04) | `tests/ecritures_posterieures/` | implémenté (même scénario que T01 : écritures 2019 sur C, F, B, G) |
| FCLOTUREAN-T05 | replay | Analytique et modifiées postérieures | lignes `Fiches_MvtA`/`Fiches_MvtM` datées N+1 | reprises dans `MvtA`/`MvtM`, supprimées de `MvtA1`/`MvtM1` | `tests/analytique_modifiees/` | implémenté (même scénario que T01 : lignes MvtA/MvtM 2018 et 2019) |
| FCLOTUREAN-T06 | replay | Deux clôtures successives | base issue de T01, exercice N+1 complété | `Fiches_Mvt5` initial supprimé ; chaîne `Mvt1→Mvt2…` cohérente | `tests/clotures_successives/` | à faire : jeu « base issue de T01 + exercice 2019 complet et clôturé » à construire (deux clôtures dans un rejeu exigent 12 clôtures de période FCloture : > 20 s) |
| FCLOTUREAN-T07 | replay | Compte absent ou de type inconnu | écriture N+1 sur un compte absent de `Fiches_Comptes` (ou `type_cc` vide) | écriture non reprise, restée dans `Mvt1` (A05 figée) | `tests/compte_inconnu/` | implémenté (même scénario que T01 : écriture 9 sur le compte absent 999999) |
| FCLOTUREAN-T08 | replay | Provisoires de l'exercice suivant | écriture N+1 `provisoire = 1`, `validee = 0` | `validee = 1` après clôture (A06 figée) | `tests/provisoires_validees/` | implémenté (même scénario que T01 : écriture 8 provisoire non validée) |
| FCLOTUREAN-T09 | replay | Sauvegarde | `~/Sauve` absent | `~/Sauve/<Base>AvCL_<date>.sql.gz` créé, réimportable (dump identique à la base avant clôture) | `tests/sauvegarde/` | implémenté (scénario `Compta/fcloturean_sauvegarde` : contenu du .sql.gz comparé ; dépend de la version du serveur MariaDB écrite par mysqldump) |
| FCLOTUREAN-T10 | replay | Échec de la sauvegarde | `mysqldump` absent du `PATH` | message d'erreur **puis clôture complète quand même** (A01 figée) | `tests/sauvegarde_echec/` | implémenté (scénario `Compta/fcloturean_sauvegarde_echec` : aucun message, voir Détail) |
| FCLOTUREAN-T11 | replay | Intégrité SHA-1 | base de T01 | `Sha1Calc.CalcSha1_Verify` vrai pour toutes les écritures de `Fiches_Mvt` | `tests/sha1_apres_cloture/` | à faire : `CalcSha1_Verify` non atteignable depuis l'écran ; seule voie, enchaîner une clôture de période FCloture après T01 (durée mesurée de T01 : 17 s, > 20 s au total) |
| FCLOTUREAN-T12 | replay | Moteur SQLite | `Laurux01.sqlite` | comportement actuel figé (échec de `RENAME`/`CopieTable`, A03) ; scénario documentaire | `tests/sqlite/` | à faire : SQLite (le framework ne rejoue pas sur Laurux01.sqlite) |
| FCLOTUREAN-T13 | gbtest | Dates (après FCLOTUREAN-008/011) | `dteclec` fin décembre, fin juin, 29 février | `dterpt`, mois de début affichés attendus | `tests/dates_exercice/` | à faire : après FCLOTUREAN-008/011 (extraction : dates calculées dans `Form_Open`/`Calc_Daterpt` à partir des contrôles) |

## Détail des tests

- **Génération des valeurs attendues** : chaque scénario est joué dans le clone **Laurux non
  modifié** ; le dump normalisé (tables triées par clé, `AUTO_INCREMENT` retiré) est conservé
  dans `expected/`, puis le même scénario est rejoué dans `Laurux_reworked`.
- **Non-déterminisme** : date du jour (`dtetdec`, nom du fichier de sauvegarde) → horloge figée
  (`faketime`) ; `lind` réattribués par `AUTO_INCREMENT` → comparés après tri sur les autres
  colonnes ; `control` (SHA-1) dépend de l'ordre d'insertion : comparé tel quel (déterministe à
  données égales).
- **Données** : `Laurux01.sql` ne contient pas d'exercice complet clôturable ; `gen_input.py`
  dérive un jeu (exercice N et début N+1, toutes périodes clôturées par `FCloture`, clés SHA-1
  recalculées dans le clone de référence).
- **Prérequis** : client `mysqldump` sur l'hôte, `Host = 127.0.0.1`, `HOME` isolé (fichiers
  `~/<Base>_<date>.sql` et `~/Sauve`).
- **Non testable automatiquement** : l'arrêt brutal en cours de rotation (base intermédiaire) ;
  documentation HTML (`xdg-open`).
- **Implémentation (phase 2, vague 9)** : jeux `.hidden/Tests/Compta/assets/fcloturean_shared/` générés par
  `gen_fcloturean.py` (modèle `fcloture_shared/gen_fcloture.py`) : `cloturean_base` (exercice 2018 équilibré sur B/G :
  capital, achat, vente ; client/fournisseur 411001/401001 ; collectifs 411000/401000 ; écritures 2019 : 6 vente client
  clôturée, 7 fournisseur, 8 provisoire non validée, 9 sur le compte absent 999999 ; MvtA et MvtM 2018 et 2019 ;
  `dtepc = dteclec = 2018-12-31`), `cloturean_desequilibre` (+ écriture 10 au seul débit de 606100), `cloturean_ouvertes`
  (`dtepc` 2018-11-30). Clés `control` calculées par Laurux (`cles.txt`, date figée 2018-06-15, SHA1CALC-A01).
  Réponses : Oui (sauvegarde), Entrée (vérification), Entrée (balance), Oui (clôture), Entrée (Traitement terminé) ;
  la clôture dure ~4 s après la dernière question (écart allongé dans le scénario, REPLAYOBSERVER-A08).
  Constats figés (T01, T04, T05, T07, T08) : écritures 2019 reprises avec `numerodef` à 0 sauf la ligne déjà clôturée,
  `numlot` vide → NULL, `lind` renumérotés, `validee` à 1 pour la provisoire (A06) ; l'écriture 9 sur 999999 reste
  dans `Fiches_Mvt1` (A05) ; ligne MvtA reprise avec `validee` NULL ; ligne MvtM reprise sans `numerodef`, `collectif`,
  `numcol`, `lind2` ; `Report` 980000 porte « 707000 » comme intitulé (inversion des paramètres &2/&6 l. 532/534) ;
  `Report`/`ReportM` laissées dans la base (A07) ; à-nouveaux datés 2019-01-01, résultat 500 au crédit de 120000.
  T10 : la redirection `>` du `Shell` crée `~/Laurux01_<date>.sql` vide avant l'échec de `mysqldump` : `Exist()` est
  vrai, la sauvegarde vide est compressée (`~/Sauve/Laurux01AvCL_15062018.sql.gz`, 25 octets), **aucun message**
  (le `Message.Error` de `Sauve` n'est jamais atteint) et la clôture est complète (dump identique à T01).
