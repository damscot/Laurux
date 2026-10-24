# Facturefm — Synthèse

> Source : `.src/Gestion/Facturation/Facturefm.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de facturation de fin de mois : sélection des BL à facturer jusqu'à une date (avec
périodicité de regroupement décade/quinzaine/mois, filtres tournée, type de client, commercial,
clients divers, boissons/autres, entretien), préparation des tables de travail `Facturefm`
(clients) et `Bl` (BL), retraits manuels, puis édition par `OptFac`/`ObjFacB` en mode fin de mois.

## Points clés

- 30 fonctions ; `recup_bl` (CC 29) et `requete` (CC 23) portent la logique.
- ≈ 60 variables d'instance mortes, héritées de l'ancienne facturation directe.
- Les tables de travail sont le contrat avec `ObjFac.calcul` et `ObjFacB.editefm`.
- Frais de gestion comptés une seule fois par client.

## Dépendances principales

- Utilisé par : `Fmenu` (Menu138, `lblFacfm`).
- Utilise : `OptFac`, `AFacture`, `TriCpt`, `Rechtour`, `VerifDate`, `Utils` (orientation,
  dates, couleurs), `Fiches_Bl[M]`, `Fiches_Ligbl[M]`, `Fiches_Cli`, `Fiches_Typec`,
  `Fiches_Commerciaux`, `Fiches_Parametres`, `Fiches_Tvaav`.
- Copies proches : `FacturefmA`, `Facturergbl`.

## Risques

- Tables de travail globales partagées avec 5 autres écrans, sous d'autres structures
  (FACTUREFM-A02, VISIMPAYES-A02) : collisions multi-postes.
- Période incohérente signalée mais traitée (A01) ; mode « un client » sans les filtres (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 629 |
| Lignes de commentaire | 41 |
| Fonctions | 30 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 139 |
| Complexité max (fonction) | 29 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

11 tests `replay` (FACTUREFM-T01 à T11) sur le jeu `facturation_base` enrichi (périodicités,
dates en bornes de période, frais) : sélections, filtres, retraits, entretien, édition complète,
période close. Comparaison des tables de travail et du dump.

## Rework

7 étapes (FACTUREFM-001 à 007) : documentation, code mort, réduction de portée de 5 fonctions,
constantes de tables, séparation SQL/GUI de `recup_bl`/`requete`, base commune avec
`FacturefmA`/`Facturergbl`, helper des tables de travail partagé avec `SaiReg`. 3 anomalies
(A01 à A03) soumises à validation.
