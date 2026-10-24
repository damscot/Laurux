# Tresor — Synthèse

> Source : `.src/Compta/Tresor.class` · Synthèse des autres documents.

## Rôle

Écran de saisie des écritures de trésorerie (journaux `TR`) : lignes saisies avec contrepartie
banque automatique, lignes collectif, mise à jour des soldes, lettrage des factures, chaînage SHA1.
Il sert aussi à modifier une écriture validée (constructeur `New Tresor(num)` appelé depuis
`Extrait`, `Ecritures`, `Fmontant`), à rappeler une écriture non validée, à appliquer un masque
d'abonnement et à rattacher un document GED.

## Points clés

- 88 fonctions, toutes `Public` sauf une ; ~45 membres d'état privés ; logique comptable et SQL
  dans les handlers. CC max : `Cmpt_KeyPress` (82), puis `Ecrit3` (36), `EcritL_Click` (32).
- Cycle d'écriture : numéro réservé à la validation de la date, lignes **provisoires** écrites à
  chaque ligne, validation = suppression puis réécriture (`DelMvt2` + `Enrg_Ecr`), rappel d'une
  écriture validée = historique `Fiches_MvtM` + annulation des soldes (`Ecrit3`).
- Lettrage via `Listextcpt` (multi-exercices `Fiches_Mvt` … `Mvt5`).
- `Sha1Calc` reçoit `"Fiches_Mvt"` en dur ; `Fiches_MvtM` en dur ; séquence `LVar` répétée 3 fois.
- `Bsel`/`Bval` doivent rester `Public` (`Object.SetProperty` depuis `TriCpt`).

## Dépendances principales

- Utilise : `Listextcpt`, `TriCpt`, `TriEcritures`/`Comptabilite`, `Extrait`, `FCalc`, `LVar`,
  `LGed`, `DocActif`, `Sha1Calc`, `Abont`, `LDate`, `LPrix`, `Utils`, `Cbase.Table`.
- Utilisé par : `Fmenu`, `Extrait` (saisie et modification), `Ecritures`, `Fmontant` (modification).

## Risques

- **Soldes** : annulation partielle du collectif lors d'une modification (TRESOR-A02) ; délettrage
  sur le mauvais compte (A03, à confirmer).
- **Concurrence** : verrou `DocActif` ignoré (A04), numérotation non atomique (A05).
- **Saisie** : toute touche sur `Button2` valide l'écriture (A01) ; suppression sans confirmation
  (A08) ; lignes provisoires déséquilibrées en base (A07).
- SQL concaténé (A10) ; erreurs masquées ou suppression proposée sur erreur (A11, A12).
- Fichier volumineux et central pour la comptabilité : reworks ciblés uniquement.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 2185 |
| Lignes de commentaire | 107 |
| Fonctions | 88 |
| Fonctions Public | 87 |
| Complexité cyclomatique totale | 579 |
| Complexité max (fonction) | 82 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

17 replays (TRESOR-T01 à T17) : encaissement, décaissement avec lettrage, multi-lignes, saisie
abandonnée, rappel non validée, modification et refus, suppression, édition de lignes, masque
d'abonnement, contrôles de date et de compte, doublon de document, GED, clavier, lettrage
multi-exercices, verrou. Critère : dump de `Fiches_Mvt`, `Fiches_MvtM`, `Fiches_Comptes`,
`Fiches_Parametres`, `Fiches_Numabon` et des verrous, SHA1 compris.

## Rework

17 étapes (TRESOR-001 à 017) : documentation, code mort, `Cbase.Table` (dont `Sha1Calc`),
découpage de `Cmpt_KeyPress` et `EcritL_Click`, factorisation des duplications internes,
helpers communs avec `Saisecrit`/`Trecarts`/`Echeances`/`LVar` (archivage `MvtM`, solde,
numérotation, date, `LVar.Calcule`), séparation SQL/GUI d'`Enrg_Ecr`, `Ecrit3`, `QuitteDate`,
réduction de portée de 33 méthodes. 15 anomalies (A01 à A15) soumises à validation.
