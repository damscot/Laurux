# Pointage — Synthèse

> Source : `.src/Compta/Pointage.class` · Synthèse des autres documents.

## Rôle

Écran de rapprochement bancaire : choix d'un compte de trésorerie, création ou rappel d'un relevé
(`Fiches_Rappro`), liste des écritures du compte sur une période (grille `TriGen` alimentée par
`Listextcpt`, multi-exercices), sélection, pointage/dépointage, suppression de relevé et
impression PDF. Ouvert depuis `Fmenu` (`Pointage.Show`).

## Points clés

- SQL de liste, totaux et pointage délégué à `Listextcpt` (6 tables `Fiches_Mvt` … `Mvt5`).
- Relevés, soldes (`soldep`) et impression codés directement dans les handlers.
- Sélection multiple `TriGen` dupliquée avec `GedR` et `TriFacture`.
- `Bsel`/`Bval` doivent rester `Public` (écrits par `Object.SetProperty` depuis `TriCpt`/`TriGen`).
- Couplage textuel `Left($lst.requete, -14)` avec la clause `ORDER BY` de `Listextcpt`.
- Fonction la plus complexe : `Imprime_Click` (CC 23).

## Dépendances principales

- Utilise : `Listextcpt`, `TriGen`, `TriCpt`, `ObjProp`, `Ccompta`, `Visualiseur`, `Calcsolde`,
  `LDate`, `LPrix`, `Utils.db`, `Cbase.Table` (`TabMvt`, `TabRappro`, `TabComptes`, `TabSoc`).
- Utilisé par : `Fmenu` uniquement.

## Risques

- **Grave** : la suppression d'un relevé s'exécute même si l'utilisateur répond « Non »
  (POINTAGE-A01).
- Suppression de relevé incomplète : dépointage de l'exercice courant seulement, `soldep` non
  recalculé (A02, A03 = CALCSOLDE-A01).
- Journal d'à-nouveaux `90` en dur (A04) ; syntaxe MySQL `IF()` en SQLite (A05, à confirmer) ;
  filtre de date partiel à l'impression (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 646 |
| Lignes de commentaire | 72 |
| Fonctions | 35 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 126 |
| Complexité max (fonction) | 23 (`Imprime_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

13 replays (POINTAGE-T01 à T13) : choix du compte, création/rappel/suppression de relevé (« Oui »
et « Non »), pointage, dépointage, sélection filtrée, filtres, multi-exercices, impression (texte
du PDF), mise à jour du relevé, SQLite. Critère : dump de `Fiches_Rappro`, `Fiches_Comptes` et des
6 tables `Fiches_Mvt`.

## Rework

11 étapes (POINTAGE-001 à 011) : documentation, code mort, fusion pointage/dépointage, découpage
de l'impression, sélection `TriGen` commune avec `GedR`/`TriFacture`, propriété « requête sans
tri » dans `Listextcpt`, suppression des doubles requêtes (dump identique), séparation SQL/GUI,
helper de solde pointé commun avec `Calcsolde`, réduction de portée de 6 méthodes, idiome
`Repeat`. 7 anomalies (A01 à A07) soumises à validation.
