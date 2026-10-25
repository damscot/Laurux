# TriEqu — Synthèse

> Source : `.src/Affichages/TriEqu.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de **choix parmi les articles équivalents** d'un code saisi en facture
(`Fiches_Cequ` joint à `Fiches_Art`). Appelant unique : `Facture.Art_Equ`.

## Points clés

- `_new(sOrg, cdcp, retro, client, type, tclient)` : `client`/`tclient` ignorés.
- Retour par `Variables.Bsel` / `Variables.$Codearticle`, **remis à zéro à l'annulation**
  (seule fenêtre du lot à le faire correctement).
- Pagination manuelle sur `Utils.rs2` ; tri par code, quantité, prix d'achat.
- `Tarifclient` émet 2 requêtes par ligne affichée pour un prix jamais affiché (colonne
  « HT Pro » toujours vide).
- Double-clic de tri sans effet de bascule.

## Dépendances principales

- Utilise : `Utils` (`Base2`, `rs2`, `cpoint`, `Observers`), `Cbase.Table` (`TabCequ`, `TabArt`,
  `TabRemTypec`), `Variables`.
- Utilisé par : `Facture` (l. 4523).

## Risques

- Liée à `Facture` (module legacy) : tests à valider avec l'utilisateur.
- Colonne « HT Pro » trompeuse (A02) ; tri incohérent (A01).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 283 |
| Lignes de commentaire | 6 |
| Fonctions | 25 |
| Fonctions Public | 25 |
| Complexité cyclomatique totale | 85 |
| Complexité max (fonction) | 12 (`Colart_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests prévus (TRIEQU-T01 à T06) : 5 `replay` depuis `Facture` (choix, annulation, tri,
pagination, colonne HT Pro) et 1 `gbtest` sur la requête extraite.

## Rework

7 étapes sans changement de comportement (TRIEQU-001 à 007) : documentation, suppression du
calcul de prix inutile (SQL modifié, dump identique), factorisation des annulations et des
en-têtes, fusion `Deb2`/`Deb3`, requête pure, réduction de portée, pagination partagée.
3 anomalies (TRIEQU-A01 à A03).
