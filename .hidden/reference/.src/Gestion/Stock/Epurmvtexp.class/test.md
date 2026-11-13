# Epurmvtexp — Tests

> Source : `.src/Gestion/Stock/Epurmvtexp.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Mvtexp`. L'écran appelle `Utils.Observers` (instrumenté). Valeurs
attendues produites dans le clone **Laurux non modifié** : le défaut A01 (table entièrement vidée)
est figé tel quel.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EPURMVTEXP-T01 | replay | Purge nominale | `Fiches_Mvtexp` : 3 mouvements avant `dteclec`, 2 après ; ouverture, Traitement, « Oui » | dump de `Fiches_Mvtexp` (aujourd'hui : **vide**, A01 figée) | `tests/epur_nominale/` | implémenté |
| EPURMVTEXP-T02 | replay | Aucun mouvement antérieur | uniquement des mouvements postérieurs à `date2` | table inchangée | `tests/epur_rien/` | implémenté |
| EPURMVTEXP-T03 | replay | Abandon | Traitement, « Non » | table inchangée, fenêtre fermée | `tests/epur_abandon/` | implémenté |
| EPURMVTEXP-T04 | replay | Dates proposées | `dteclec1` en décembre, `dteclec` quelconque ; ouverture seule | texte de `date1` (janvier N+1) et `date2` relevés | `tests/epur_dates/` | implémenté |
| EPURMVTEXP-T05 | replay | Date saisie invalide | `date2 = "32.13.2025"` puis Traitement | comportement actuel figé (pas de contrôle : handlers inactifs) | `tests/epur_date_invalide/` | implémenté |

## Détail des tests

- **Implémentation (phase 2)** : T01 `Gestion/epurmvtexp_nominale`, T02 `Gestion/epurmvtexp_rien`,
  T03 `Gestion/epurmvtexp_abandon` (sql.log comparé, ordre), T05 `Gestion/epurmvtexp_date_invalide` (replay,
  `.hidden/Tests/Gestion/assets/<nom>/`) ; T04 en gb.test (`.src/Tests/Gestion/EpurmvtexpTest.test`,
  `T04DatesProposees` : `Form_Open` appelé sur la fenêtre non affichée, Laurux01 a déjà `dteclec1` en décembre).
  Jeux : `epurmvtexp_shared/mvtexp` (5 lignes, mind 1-3 ≤ 2018-12-31, 4-5 après) et `epurmvtexp_shared/posterieurs`
  (mind 4-5). T05 : date2 effacée puis saisie sans sortie de champ (pas de `LostFocus`), tous les mouvements
  supprimés (datec2 = « 20251332 »).

- **Données** : `Laurux01.sql` + jeu dérivé `mvtexp.sql` (5 lignes `Fiches_Mvtexp` de part et
  d'autre de `Fiches_Parametres.dteclec`, `dteclec1` fixé).
- **Horloge** : sans effet (les dates viennent de `Fiches_Parametres`).
- **Comparaison** : dump normalisé de `Fiches_Mvtexp` (`mind` conservé, c'est la clé testée).
- **Après validation de EPURMVTEXP-A01** : T01 attendra les 2 mouvements postérieurs ; prévoir un
  test croisé avec `CSTOCK` (stock recalculé avant/après purge).
- **gbtest** : après EPURMVTEXP-003 (`Purge` isolée), la purge pourra être testée sans GUI sur la
  base Docker.
