# BordereauxC — Synthèse

> Source : `.src/Compta/Impressions/BordereauxC.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Bordereaux chèques (ancienne version) » (menu Compta) : gestion de la liste des chèques en
attente de remise (`Fiches_BordereauxC`, saisie dans l'écran ; le moulinage ne l'alimente plus), impression du
bordereau (`~/tmp/Bordereau.pdf`, `Cbordereaux`, copie sous `FactcheminC`) et, sur confirmation,
**comptabilisation de la remise** dans `Fiches_Mvt` (lignes clients/caisse, banque, collectif),
mise à jour des soldes, SHA-1 et suppression des chèques remis.

## Points clés

- Rangé dans `Impressions` mais modifie la comptabilité : risque élevé.
- Logique d'écriture copiée de `Moulinage` (`Ecritures`, `Parametres`, `Maj_Collectif`).
- Compteurs d'écriture réservés dès l'impression ; aucune transaction.
- `Grd1_MouseUp` (CC 20) gère ajout, sélection, enregistrement et suppression, avec un `Catch`
  vide.

## Dépendances principales

- Appelé par `Fmenu.Menu321_Click` uniquement.
- Utilise `Utils.db`, `Cbase.Table`, `Csolde.Solde_caisse`, `Sha1Calc.CalcSha1`, `Cbordereaux`,
  `Visualiseur`, `Start.LocalSettings` (`FactcheminC`, couleurs) et, par erreur, le formulaire de
  caisse `Bordereaux`.
- Tables : `Fiches_BordereauxC`, `Fiches_Mvt`, `Fiches_Comptes`, `Fiches_Parametres`,
  `Fiches_Journaux`, `Fiches_ClientCaisse`.

## Risques

- Collectif crédité deux fois du dernier chèque (A02) et solde du collectif diminué du cumul
  (A03, défaut partagé avec `Moulinage`) : écritures et soldes faux, à confirmer par replay.
- Libellé de banque sans numéro de bordereau (A01).
- Trous de numérotation et état partiel possible (A04).
- Erreurs silencieuses dans la grille (A09), dates/montants saisis mal relus (A08).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 415 |
| Lignes de commentaire | 17 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 82 |
| Complexité max (fonction) | 30 (`Imp_Bordereaux`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests (BORDEREAUXC-T01 à T11) : 10 replays avec comparaison du **dump normalisé** (écritures,
soldes, compteurs, chèques) et du PDF après `pdftotext` (date du titre normalisée), et 1 `gbtest`
sur `Comptabilise_Remise` après séparation. Valeurs attendues capturées dans le clone non modifié.

## Rework

9 étapes (BORDEREAUXC-001 à 009) : documentation, code mort, `Ecritures` corrigé à valeur égale,
helpers d'insertion et de lettrage, découpage de `Grd1_MouseUp`, séparation impression /
comptabilisation, réduction de portée, `Cbase.Table`, service commun avec `Moulinage`. 9 anomalies
(BORDEREAUXC-A01 à A09).
