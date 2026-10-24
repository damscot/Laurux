# EcrAuto — Synthèse

> Source : `.src/Compta/Utils/EcrAuto.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Moteur d'écritures comptables automatiques : à partir d'un journal et d'un `VarEcr`, contrôle
l'équilibre, numérote (écriture, numéro définitif et facture en vente), écrit, modifie ou supprime
les lignes de `Fiches_Mvt` (historique dans `Fiches_MvtM`), met à jour les soldes, lettre, crée les
traites et les lignes de collectif, calcule la clé d'intégrité et archive un PDF en GED. Fournit
aussi l'impression (`Report`) des écritures passées.

## Points clés

- `ecriture()` renvoie `True` en cas d'abandon ; appelée par `ObjFac`, `ValidBR1`, `EcrReg`
  (`SaiReg`, `Moulinage`) et récursivement pour les régularisations de lettrage.
- Verrous `LOCK TABLES` imbriqués avec `Begin`/`Commit` ; verrou applicatif `DocActif`.
- Membres publics (`resjou`, `Vecr`, `numecr`, `numerodef`, `numfac`, `Imp`) lus par les appelants
  et par `EcrReg` (héritage).
- Fonction la plus complexe : `ecriture` (CC 22) ; `Impression` = 200 lignes de cellules dupliquées.

## Dépendances principales

- Utilise : `VarEcr`, `Utils.db`, `DocActif`, `Sha1Calc`, `LGed`, `LVar`, `LDate`, `Listextcpt`,
  `Mreglement`, gb.report.
- 12 tables, toutes en dur (`Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Comptes`, `Fiches_Parametres`…).

## Risques

- **Compte inexistant : tables laissées verrouillées et transaction ouverte** (ECRAUTO-A01).
- Compte de la ligne modifié par le lettrage avec régularisation (A02).
- Trous de numérotation définitive et de factures en cas d'abandon (A03).
- Traites non créées sous SQLite (A04) ; dialogues bloquants sous verrou (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 601 |
| Lignes de commentaire | 10 |
| Fonctions | 17 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 99 |
| Complexité max (fonction) | 22 (`ecriture`) |
| Variables globales | 0 |
| Variables Public | 5 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests (ECRAUTO-T01 à T12) : 8 `gbtest` sur base MariaDB jetable (écritures simples, trésorerie,
lettrage, régularisation, collectif, modification/suppression, impression, SQLite) et 4 `replay`
via `ObjFac`/`ValidBR1` (vente, doublon de facture, compte inexistant, GED).

## Rework

9 étapes : documentation, code mort, factorisation d'`Impression` et d'`ecriture`, `LGed.Archive`,
helper `LVar`, `Cbase.Table`, solde commun, `facnum` itératif. 7 anomalies (ECRAUTO-A01 à A07).
