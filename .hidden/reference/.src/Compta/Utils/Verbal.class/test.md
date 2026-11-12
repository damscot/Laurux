# Verbal — Tests

> Source : `.src/Compta/Utils/Verbal.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de contrôle en lecture seule : le critère est le texte des 21 champs (et la couleur de
`Sgenerale`) relevé dans le log de replay ; le dump de la base doit rester inchangé. `Laurux01.sql`
ne contient aucune écriture : un **jeu dérivé** ajoute des comptes `C`, `F`, `G`, `B` (dont des
collectifs `411`/`401` avec `coll = 1`) et des écritures validées et non validées dans
`Fiches_Mvt` (exercice 2018 : `dteclec = 2018-12-31`, `dteclec1 = 2017-12-31`). La date du jour
influence les dates proposées : l'horloge est fixée (`faketime` ou équivalent) pour T01.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VERBAL-T01 | replay | Dates proposées à l'ouverture | date du jour fixée avant, pendant et après l'exercice 2018 | `DteN0`/`DteN1` figés pour les 3 cas | `tests/dates_ouverture/` | implémenté (3 scénarios ; dates figées par les requêtes de sql.log) |
| VERBAL-T02 | replay | Balance équilibrée | jeu dérivé équilibré, Traitement | 21 valeurs `0,00`-formatées attendues ; `Sgenerale = 0,00` | `tests/balance_equilibree/` | implémenté (partiel : absence de synthèse vocale tracée ; texte des 21 champs non comparé) |
| VERBAL-T03 | replay | Balance déséquilibrée | jeu dérivé avec une écriture non soldée, montants à 3 décimales et écritures non validées | valeurs figées, fond rouge, écritures non validées ignorées | `tests/balance_desequilibree/` | implémenté (partiel : synthèse vocale tracée dans outils.trace ; valeurs et couleur non comparées ; 3 décimales impossibles en decimal(12,2)) |
| VERBAL-T04 | replay | Contrôle des dates saisies | `DteN0` avant `dte1`, `DteN1` au-delà de `année + 1`, fin < début | avertissements et dates remises figés | `tests/controle_dates/` | implémenté (DteN0 avant début et DteN1 au-delà ; cas fin < début non joué) |
| VERBAL-T05 | replay | Période dans un exercice antérieur | `01.01.2017`–`31.12.2017` avec écritures dans `Fiches_Mvt1` | valeurs à zéro (seul `Fiches_Mvt` lu, A03 figée) | `tests/exercice_anterieur/` | implémenté (figé : la période 2017 n'est pas saisissable, dates remises sur 2018 avant le traitement) |
| VERBAL-T06 | gbtest | `CalculeBalances` (après VERBAL-005) | même jeu que T02/T03 | 21 valeurs identiques aux champs de T02/T03 | `tests/calcule_balances/` | à faire : CalculeBalances n'existe qu'après l'extraction VERBAL-005 (Button2_Click finit par Message.Info, bloquant en gb.test) |
| VERBAL-T07 | replay | Performance | jeu dérivé de 2 000 comptes et 50 000 écritures | durée de référence (`gbx3 -p`) | `tests/perf/` | à faire : mesure de durée non comparée (jeu de 50 000 écritures, délai 20 s) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié avec le même jeu dérivé et la
  même locale (`LANG=fr_FR.UTF-8`, le séparateur décimal entre dans les comparaisons de texte).
- **gen_input.py** : génère le jeu dérivé (comptes, écritures) de T02, T03, T05 et T07.
- **Non testable automatiquement** : la synthèse vocale de `Syntheses.Message` (`/son2`), les sons.

- **Implémentation (phase 2, vague 3)** : scénarios `.hidden/Tests/Compta/assets/verbal_<nom>/` (`dates_ouverture_avant`
  2017-06-15, `dates_ouverture_pendant` 2018-06-15, `dates_ouverture` 2026-01-15, `balance_equilibree`,
  `balance_desequilibree`, `controle_dates`, `exercice_anterieur`) ; menu `Fmenu#Menu67#Menu75#Menu132`. Jeu partagé
  `verbal_shared/verbal_base.sql` (écritures 2018 équilibrées sur comptes C/F/G/B et collectifs 411000/401000, une
  non validée, une écriture 2017 dans `Fiches_Mvt1`) ; T03 : `verbal_balance_desequilibree/verbal_desequilibre.sql`
  (+ 512000 non soldé de 10,05). T02/T03 : `"/son2": "1"` et `@outils.trace` comparé (pico2wave/aplay tracés si
  déséquilibre). Les valeurs des champs ne sont pas comparées par le runner.
  Comportements figés : quelle que soit la date du jour (avant, pendant, après 2018), la période proposée est
  01.01.2018–31.12.2018 ; après un avertissement sur DteN0, `Ex1` remet DteN0 = 31.12.2018 et la borne haute
  devient la date du jour, si bien que DteN1 = 31.12.2020 est accepté sans avertissement (T04) ; une période 2017
  est remise sur 2018 avant le traitement (T05).
