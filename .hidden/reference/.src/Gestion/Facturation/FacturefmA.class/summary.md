# FacturefmA — Synthèse

> Source : `.src/Gestion/Facturation/FacturefmA.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de facturation périodique des abonnements : sélection des BL d'abonnement (`type = "A"`)
à facturer selon la périodicité du client (`cli_aban`, `cli_datab`) et la date de dernière
facturation (`dtefac`), préparation des tables de travail `Facturefm`/`Bl`, retraits, puis
édition par `OptFac` (mode fin de mois).

## Points clés

- Copie adaptée de `Facturefm` ; `recup_bl` (CC 41) contient cinq branches de périodicité quasi
  identiques.
- L'envoi FTP (`EnvoiFTP`) est mort : COPIE-A02 ne peut pas se produire aujourd'hui.
- ≈ 80 variables d'instance, presque toutes mortes.
- `FtpClient1_Connect` est un gestionnaire d'événement (faux positif « jamais référencée »).

## Dépendances principales

- Utilisé par : `Fmenu.Menu299`.
- Utilise : `OptFac`, `TriCpt`, `Doc`, `hexdblKey` et `Copie` (code mort), `Fiches_Bl`,
  `Fiches_Ligbl`, `Fiches_Cli`, `Fiches_Parametres`, tables de travail `Facturefm`/`Bl`.

## Risques

- Règle de périodicité fragile : conversion implicite de `dtefac` en chaîne (A02), mois négatif
  mal corrigé en début d'année (A03).
- Table `Bl` sans `nom` → erreur pour un client divers à l'édition (A04).
- Date d'édition saisie ignorée, mode fin de mois au lieu d'abonnement (A05, à confirmer).
- Colonne Ville écrasée par le TTC lors d'un retrait de BL (A01).
- Tables de travail partagées (voir FACTUREFM-A02).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 517 |
| Lignes de commentaire | 34 |
| Fonctions | 26 |
| Fonctions Public | 26 |
| Complexité cyclomatique totale | 109 |
| Complexité max (fonction) | 41 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 3 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (FACTUREFMA-T01 à T08) : 7 `replay` (périodicités, client sans périodicité, retraits,
édition, client divers) et 1 `gbtest` de caractérisation de la conversion de `dtefac`. Date et
fuseau figés (`faketime`, `TZ`).

## Rework

7 étapes (FACTUREFMA-001 à 007) : documentation, code mort (`EnvoiFTP`, variables), réduction de
portée, table de périodicités à comportement identique, séparation SQL/GUI, `Quittedate` commune
avec `Facturergbl`. 5 anomalies (A01 à A05) soumises à validation.
