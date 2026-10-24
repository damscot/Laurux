# Prgm — Synthèse

> Source : `.src/Communs/Prgm.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Appel de programme » (Fmenu, « Gestion > Outils > Appel programme ») : l'utilisateur
saisit un nom, éventuellement suivi d'arguments, et `Button1_Click` lance l'écran ou le script
correspondant parmi **36 noms codés en dur** (liste exhaustive dans architecture.md).

## Points clés

- Dispatcher en 36 `If Prog = …` successifs (CC 38), comparaison sensible à la casse ; tout nom
  inconnu ferme simplement la fenêtre.
- 22 noms ouvrent des écrans (dont plusieurs aussi accessibles par menu) ; les autres lancent des
  scripts : `RecupN`, `Epurfour`, `Papmp`, `RenAN`, `RenMvt`, `RecupDech`, `Renech`, `HistoCom`,
  `RenumBl`, `MajEqu`, `CalcSha1 [suffixe]`, `Exprub`, et `RazDocactif` (`TRUNCATE` direct).
- Mot de passe administrateur (`/Admin`) demandé à l'ouverture par un panneau superposé, mais
  non contrôlé au lancement.
- `Mdp_LF` duplique `MDP.Mdp2_LF`.

## Dépendances principales

- Appelé par `Fmenu` (`Menu282`, et `Menu141` inatteignable) ; `Papmp` agit sur `Prgm.Mouse`.
- Utilise les 36 cibles (écrans et scripts des dossiers `Utils`, `Compta/Utils`, `Archivages`,
  `Gestion/Depots`, `Statistiques`, `Communs`), `hexdblKey`, `Sha1Calc`, `MajEqu`.
- Table : `Fiches_Docactif` (en dur).

## Risques

- **Scripts destructeurs sans confirmation ni transaction** (A02) : `RazDocactif`, `RecupN`,
  `Epurfour`, `RenMvt`, `Renech`, `RenAN`, `HistoCom`, `RenumBl`, `MajEqu`, `CalcSha1`.
- `Fsoc` lancé par l'auto-instance alors que son constructeur exige un argument (A03) ; `RenAN`
  vise une table absente (A06) ; suffixe de `CalcSha1` concaténé au nom de table (A04) ; champ vide
  (A05, à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 101 |
| Lignes de commentaire | 6 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 38 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests (PRGM-T01 à T09) : 8 `replay` (mot de passe, dispatch des 22 écrans, `RazDocactif`,
`CalcSha1`, `MajEqu`, déclenchement des scripts destructeurs, nom inconnu ou vide, `Fsoc`) et un
`gbtest` sur le découpage de la commande après extraction.

## Rework

6 étapes (PRGM-001 à 006) : documentation, `Select Case`, vérification du mot de passe partagée avec
`MDP`, extraction du découpage et du `TRUNCATE`, code mort et `Cbase`, regroupement des scripts dans
un module `Maintenance` (transverse). 6 anomalies (PRGM-A01 à A06).
