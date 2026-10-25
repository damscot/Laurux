# StatComm — Synthèse

> Source : `.src/Statistiques/StatComm.class` · Synthèse des autres documents.

## Rôle

Écran de critères et de calcul du « Chiffre d'affaires des commerciaux (sur factures archivées
exclusivement) » (menu Statistiques › CA clients/commerciaux). Il remplit la table de travail
`Total` (par client si `Detail` est coché, sinon par commercial) à partir de `Fiches_HistoFac`
et/ou `Fiches_HistoFacM` sur la période N et la même période N-1, puis ouvre `VisStatComm`.

## Points clés

- Toute la logique est dans `Traitement` (CC 37) : SQL ligne à ligne (SELECT puis UPDATE ou
  INSERT dans `Total` pour chaque facture), mêlé à la lecture des contrôles.
- Famille de 5 écrans quasi identiques (`StatComArt`, `StatFour`, `StatTypCli`, `StatClimo`,
  `StatComm`) : 117 à 172 lignes communes ; `dateN1`, `Btn_Click`, `dte_KeyPress`,
  `dte_GotFocus`, `dteN0_LF`/`dteN1_LF` copiés à l'identique. Le socle commun proposé
  (`StatCommun.module`) est décrit dans architecture.md.
- Sources : factures archivées seulement (voulu, libellé du `.form`) ; le tableau comparatif des
  sources des écrans de la famille est dans architecture.md.

## Dépendances principales

- Ouvert par `Fmenu.Menu313_Click` (auto-instance, non modal) ; ouvre `VisStatComm`.
- Utilise `Utils` (dates, `cpoint`, `db`), `Cbase.Table` (`TabCli`, `TabCommerciaux`), tables en
  dur `Fiches_Parametres`, `Fiches_HistoFac`, `Fiches_HistoFacM`, table de travail `Total`.

## Risques

- **A01** : en synthèse, une facture d'un client supprimé est attribuée au commercial de la
  facture précédente (variables affectées par `Try`).
- **A02** : en détail, client supprimé → erreur d'exécution.
- **A03** : le N-1 est calculé mais jamais affiché, et incomplet.
- **A05** : table `Total` partagée entre postes et écrans (cf. STATCAI-A04).
- Pas de test existant.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 224 |
| Lignes de commentaire | 36 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 37 (`Traitement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests prévus : 8 `replay` (détail, synthèse, sources, N-1, client supprimé, cas limites,
option matériel, SQLite) et 2 `gbtest` après séparation (`CalculTotal`, `StatCommun` dates).
Jeu de données commun au lot : `statistiques_ventes` (décrit dans test.md). Replays du lot en
série (table `Total` partagée).

## Rework

7 étapes (STATCOMM-001 à 007) : documentation, code mort, `Cbase.Table`, réduction de portée de
4 fonctions, socle `StatCommun.module`, séparation `CalculTotal`, cumul en mémoire. 5 anomalies
(STATCOMM-A01 à A05) soumises à validation.
