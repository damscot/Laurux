# LDate — Synthèse

> Source : `.src/Utils/LDate.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Objet date de référence de Laurux : une `Date` Gambas encapsulée avec des formats d'affichage
(`.L`, `.LT`), de base de données (`.D`, `.DT`), Gambas (`.G`, `.GnT`) et de nom de fichier
(`.F`, `.FT`), des composants (jour, semaine, mois, année, noms français), des bornes de période
(`FinMois`, `FinJour`, `PDeb`, `PFin`) et des bornes d'exercice comptable (`EDeb`, `EFin`, `EInd`)
lues dans `Fiches_Parametres`.

## Points clés

- `Export` + `Create Static` ; usage dominant `LDate(x).<format>` (75 fichiers).
- `Parse` accepte de nombreux formats (Laurux, DB, partiels, `..` = aujourd'hui, `yyyymmddHHMMSS`).
- `DateFilterDB` convertit une saisie avec jokers en motif `LIKE`.
- Les propriétés d'exercice exécutent une requête SQL à chaque lecture.
- Événement `change` observé par `TextReg`. `VerifDate` hérite de `LDate`.
- Fonctions les plus complexes : `DateFilterDB` et `Parse` (CC 20).

## Dépendances principales

- Utilise : `Utils.db`, `Cbase.Table("TabParam")` (`Fiches_Parametres`, lecture seule).
- Utilisé par 75 fichiers (Caisse, Moulinage, Extrait, Facture, LauruxMaj, TextReg, VerifDate,
  LVar, LGed…). `Fin_Jour` a un appelant externe non détecté par `deps.py` (`Histocliart`).

## Risques

- `Parse` : chaînes de 14 caractères (`dd/mm/yy hh:nn`) mal interprétées → `Null` (A01) ;
  formats partiels `a.m` invalides en fin de mois (A07).
- `EDeb` suppose des exercices de 12 mois (A02) ; `EFin` faux au-delà de la dernière clôture pour
  un exercice décalé (A03).
- `MonStr` renvoie des noms de mois incohérents (A04), visibles dans les libellés automatiques.
- Classe très utilisée : toute modification de `L`/`D`/`G`/`Parse` a un large rayon d'impact.

## Commonalisation

Nombreux traitements de dates « à la main » qui pourraient utiliser `LDate` : helpers
`Utils.Cdate_*`, `Calc_mois`, `lastday` (~50 fichiers chacun pour les principaux),
`Format$(Now, "dd.mm.yyyy")` (215 occurrences), lecture manuelle de `dteclec*` (~30 fichiers,
cible : `Exercice_Cloture`, aujourd'hui sans appelant), duplication de `Exercice_Debut/Fin` dans
`Anomalies`. Détail dans architecture.md.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 489 |
| Lignes de commentaire | 18 |
| Fonctions | 45 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 119 |
| Complexité max (fonction) | 20 (`DateFilterDB`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 tests prévus (LDATE-T01 à T14), tous `gbtest` ; T11 à T13 utilisent la base Docker
(`Laurux01.sql` et un jeu dérivé à exercice décalé). Les cas dépendant de `Now` sont comparés
relativement à la date courante.

## Rework

9 étapes sans changement de comportement (LDATE-001 à 009) : documentation, code mort local,
simplification de `DateFilterDB`, helper des clôtures, séparation `Parse`/messages, simplification
`Apres`/`Avant`, réduction de portée, préparation des commonalisations. 8 anomalies (LDATE-A01 à
A08) soumises à validation.
