# RelMoprod — Synthèse

> Source : `.src/Statistiques/RelMoprod.class` · Synthèse des autres documents.

## Rôle

Historique des ventes de main-d'oeuvre et d'articles, par client ou par produit, sur une période
(menu `Fmenu`). Le traitement copie les lignes MO/articles des factures en cours et historisées dans
la table de travail `Fiches_Stat`, les présente dans un arbre (`Rlcli`), affiche le détail d'une
facture au clic et imprime un PDF (`Cdocuments`).

## Points clés

- Table de travail `Fiches_Stat` recréée à chaque traitement (structure propre, partagée par nom
  avec `RelvMo` et `TriHistos`).
- `MajTab` (CC 30) reparcourt tout l'arbre pour chaque ligne et chaque ligne du client : coût
  cubique ; doublons écartés par des `Try` silencieux.
- `Catch` vides dans le traitement, l'arbre et le détail.
- Grille de recherche client par en-têtes recopiée d'autres écrans (`Tricartes`, `TriBl`…), filtre
  `LIKE` concaténé.
- Code mort : `compteMan`, `A1_KeyPress` (pas de contrôle `A1`).

## Dépendances principales

- Appelé par `Fmenu` (ligne 1829).
- Utilise `Cdocuments`, `Utils` (`Base2`/`rs2`, dates, `Observers`, `CDec`, `db`), `Cbase.Table`.
- `ColCli_Click` appelé dynamiquement par le rejeu : reste `Public`.

## Risques

- Lignes répétées d'un même code dans une facture perdues (A01) ; filtre sur `datebl` et dernier
  jour exclu (A02) ; détail de facture mal formaté (A03).
- Erreurs avalées (A04) ; double `Utils.Observers` (A05) ; code client saisi non contrôlé et `LIKE`
  concaténé (A06) ; mise en page de l'impression (A07).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 787 |
| Lignes de commentaire | 47 |
| Fonctions | 52 |
| Fonctions Public | 52 |
| Complexité cyclomatique totale | 189 |
| Complexité max (fonction) | 30 (`MajTab`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus (RELMOPROD-T01 à T09) : 8 replays (tous clients, un client, sans donnée, impression
par client et par produit, détail de facture, impression sans traitement, recherche client)
comparant le dump de `Fiches_Stat`, les lignes `Exec_SQL` et le texte du PDF, puis 1 gbtest du
remplissage après extraction. Le double `Utils.Observers` doit être toléré par la capture.

## Rework

9 étapes (RELMOPROD-001 à 009) : documentation, code mort, factorisation des passes, `MajTab` sans
reparcours (SQL modifié, dump identique), couleurs de grille, séparation calcul/GUI, dates et période
communes, clause de recherche commune, réduction de portée de 13 méthodes. 8 anomalies
(RELMOPROD-A01 à A08).
