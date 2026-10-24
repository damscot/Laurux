# FClotureAn — Tests

> Source : `.src/Compta/Clotures/FClotureAn.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Module complexe (PLAN §0) : **la liste de scénarios ci-dessous doit être présentée à
l'utilisateur et validée avant implémentation.** Tous les tests sont des replays sur MariaDB
Docker. Critère : **diff complet** du dump normalisé de `Fiches_Mvt`…`Fiches_Mvt5`,
`Fiches_MvtA`…`A5`, `Fiches_MvtM`…`M5`, `Fiches_Comptes`, `Fiches_Parametres`, `Report`,
`ReportM` (structure **et** données), plus les fichiers produits dans `~/Sauve`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLOTUREAN-T01 | replay | Clôture nominale | jeu dérivé : exercice N complet (types C, F, B, G, collectifs), toutes périodes clôturées, balance équilibrée ; Oui à toutes les questions | rotation des 18 tables ; à-nouveaux datés `dterpt` ; résultat sur `cptrsplus`/`cptrsmoins` ; soldes recalculés ; `dteclec*`, `dtetdec`, `dtefedec`, compteurs décalés ; clés `control` recalculées | `tests/cloture_nominale/` | à faire |
| FCLOTUREAN-T02 | replay | Balance déséquilibrée | une écriture validée déséquilibrée sur un compte G | message « déséquilibrée », fermeture, base inchangée | `tests/balance_desequilibree/` | à faire |
| FCLOTUREAN-T03 | replay | Périodes non clôturées | `dtepc < dteclec` | message « dernière clôture inférieure », base inchangée | `tests/periodes_ouvertes/` | à faire |
| FCLOTUREAN-T04 | replay | Écritures postérieures à la fin d'exercice | écritures N+1 sur comptes C, F, B, G, clôturées ou non | réinsérées dans `Fiches_Mvt` avec les colonnes reprises par type (pertes de colonnes et `lind` renuméroté figés, A04) | `tests/ecritures_posterieures/` | à faire |
| FCLOTUREAN-T05 | replay | Analytique et modifiées postérieures | lignes `Fiches_MvtA`/`Fiches_MvtM` datées N+1 | reprises dans `MvtA`/`MvtM`, supprimées de `MvtA1`/`MvtM1` | `tests/analytique_modifiees/` | à faire |
| FCLOTUREAN-T06 | replay | Deux clôtures successives | base issue de T01, exercice N+1 complété | `Fiches_Mvt5` initial supprimé ; chaîne `Mvt1→Mvt2…` cohérente | `tests/clotures_successives/` | à faire |
| FCLOTUREAN-T07 | replay | Compte absent ou de type inconnu | écriture N+1 sur un compte absent de `Fiches_Comptes` (ou `type_cc` vide) | écriture non reprise, restée dans `Mvt1` (A05 figée) | `tests/compte_inconnu/` | à faire |
| FCLOTUREAN-T08 | replay | Provisoires de l'exercice suivant | écriture N+1 `provisoire = 1`, `validee = 0` | `validee = 1` après clôture (A06 figée) | `tests/provisoires_validees/` | à faire |
| FCLOTUREAN-T09 | replay | Sauvegarde | `~/Sauve` absent | `~/Sauve/<Base>AvCL_<date>.sql.gz` créé, réimportable (dump identique à la base avant clôture) | `tests/sauvegarde/` | à faire |
| FCLOTUREAN-T10 | replay | Échec de la sauvegarde | `mysqldump` absent du `PATH` | message d'erreur **puis clôture complète quand même** (A01 figée) | `tests/sauvegarde_echec/` | à faire |
| FCLOTUREAN-T11 | replay | Intégrité SHA-1 | base de T01 | `Sha1Calc.CalcSha1_Verify` vrai pour toutes les écritures de `Fiches_Mvt` | `tests/sha1_apres_cloture/` | à faire |
| FCLOTUREAN-T12 | replay | Moteur SQLite | `Laurux01.sqlite` | comportement actuel figé (échec de `RENAME`/`CopieTable`, A03) ; scénario documentaire | `tests/sqlite/` | à faire |
| FCLOTUREAN-T13 | gbtest | Dates (après FCLOTUREAN-008/011) | `dteclec` fin décembre, fin juin, 29 février | `dterpt`, mois de début affichés attendus | `tests/dates_exercice/` | à faire |

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
