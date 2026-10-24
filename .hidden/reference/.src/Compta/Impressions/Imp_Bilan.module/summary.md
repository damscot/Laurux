# Imp_Bilan — Synthèse

> Source : `.src/Compta/Impressions/Imp_Bilan.module` · Synthèse des autres documents.

## Rôle

Édition PDF du **bilan** (`~/tmp/Bilan.pdf`, classe `Cbilan`) à partir des rubriques `B…`, de leurs
plages de comptes et des écritures d'un exercice. Appelé uniquement par `RubImp` (bouton radio
« Bilan »).

## Points clés

- Une seule fonction `Lancement` de 805 lignes, **CC 335**, découpée en 9 blocs : initialisation,
  tables de travail, résultat N/N-1, soldes par compte, affectation des comptes aux rubriques,
  centralisation N, centralisation N-1, impression, fermeture.
- Deux tables de travail (`centralisation`, `Comptes`) recréées dans la base à chaque édition.
- Règles d'exclusion actif/passif codées en dur pour 10 rubriques, différentes entre N et N-1.
- Requêtes en N+1 (une par compte, plusieurs par compte retenu).
- Les valeurs N-1 sont calculées mais **jamais imprimées**.
- Produit aussi `BilanDetail.csv` et `BilanRub.csv` dans `~/tmp`.

## Dépendances principales

- Appelé par : `RubImp.Button2_Click`.
- Utilise : `Cbilan` (PdfWriter), `Utils.db`, `Utils.cpoint`/`PointBase`/`Cdate_Dbase`,
  `Visualiseur.Prog`, `Start.Societe`, `Cbase.Table("TabComptes")`.
- Tables : `Fiches_Rubriques`, `Fiches_RubCompt`, `Fiches_Comptes`, `Fiches_Mvt…Mvt5`,
  `Fiches_Societes` ; tables de travail `centralisation`, `Comptes`.

## Risques

- Calcul N-1 erroné et inutile (A01 à A04) ; incohérences N/N-1 à faire valider (A05).
- Tables de travail partagées entre postes et entre éditions (A06).
- Réécriture à haut risque : seule une comparaison PDF + CSV + dump sur un jeu d'écritures riche
  (toutes les règles d'exclusion) garantit l'identité ; l'ordre SQL doit être conservé.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 767 |
| Lignes de commentaire | 46 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 336 |
| Complexité max (fonction) | 335 (`Lancement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests (IMP_BILAN-T01 à T10) : 8 replays pilotés depuis `RubImp` (exercices E1, N1, N5, règles
d'exclusion, amortissements, éditions successives, rien à imprimer, performance) comparant le texte
du PDF (`pdftotext`, pied de page normalisé), les CSV et le dump des tables de travail ; 2 gbtest
après extraction (`Exclu`, `TablesExercice`).

## Rework

11 étapes (IMP_BILAN-001 à 011) : documentation, code mort, commonalisation avec `Imp_Sig`/`RubImp`
(tables par exercice, en-tête société, `Cbase`), règles d'exclusion en table, découpage de
`Lancement` et de l'impression (sans changement SQL), variables de module en locales (conditionnel),
séparation du message et du visualiseur, suppression du N+1 des soldes. 9 anomalies (A01 à A09).
