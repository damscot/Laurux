# TresorFac — Tests

> Source : `.src/Gestion/Reglements/TresorFac.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRESORFAC-T01 | gbtest | Compilation sans le couple | suppression de `TresorFac.class` + `.form` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| TRESORFAC-T02 | replay | Saisie et validation d'un règlement | lanceur dédié (`TresorFac.Show`, aucun menu) ; mode « Especes », date dans la période, compte `411…` existant, montant, n° de document, Valider ligne puis Valider | dump de `Fiches_Mvt` (3 lignes : client, trésorerie, collectif), `Fiches_Comptes.solde`, `Fiches_Parametres.numecriture` identique ; fige l'erreur d'indice `Ecrit1.Item[6]` | `tests/saisie_reglement/` | à faire |

## Détail des tests

- Écran inatteignable : T02 ne sert que si TRESORFAC-A01 (suppression) est refusée ; il exige un
  lanceur de test. Si A01 est acceptée, seul T01 est conservé.
- Valeurs attendues produites dans le clone **Laurux non modifié** ; jeu dérivé de `Laurux01.sql`
  avec un client, son collectif et les journaux `jrnal2`/`jrnal3` renseignés (`cde_banque`).
- Non testable : recherche de compte F2 (`TriCpt` + `Comptabilite.Bsel`, erreur attendue), rappel
  d'écriture `Ecrit3_Click` (liste jamais remplie).
