# Tricp — Synthèse

> Source : `.src/Affichages/Tricp.class` · Synthèse des autres documents.

## Rôle

Fenêtre modale de **sélection d'un code postal** (`Fiches_Cpostaux` : code `cp`, bureau
`burdist`), paginée manuellement sur le résultat global `Utils.rs2`. Ouverte depuis `FClient`,
`FFournisseur`, `Facture` et `FClientcarte` (8 appels).

## Points clés

- `_new(sOrg, cdcp)` : l'appelant n'est **pas** passé ; la sélection est écrite en dur selon
  `sOrg` dans `FClient.*`, `FFournisseur.*` (auto-instances), `FClientcarte.*` (membres
  inexistants → erreur) ou `Variables.*` (`Facture`).
- Pas de remise à zéro de `Bsel` : une annulation réapplique la sélection précédente.
- Filtre par début de chaîne et pagination concaténés dans le SQL ; double-clic de tri inversé.
- Pagination (molette, PageUp/PageDown, boutons) identique à `Tricartes`, `TriclientsD`, `TriMat`,
  `TriEqu`… → `PaginationListe`.

## Dépendances principales

- Utilise : `Utils` (`Base2`, `rs2`, `Observers`, `ObsGotf`/`ObsLstf`, `Obstch`),
  `Cbase.Table("TabCpostaux")`, `Variables`, `Doc`.
- Écrit dans : `FClient`, `FFournisseur`, `FClientcarte`, `Variables` (membres à garder `Public`).

## Risques

- Sélection inopérante ou en erreur depuis `FClientcarte` et perdue pour une fiche fournisseur
  ouverte par `New` (A01) : la correction change la signature et les 4 appelants.
- Annulation qui réapplique l'ancien code (A02) ; tri incohérent (A03) ; caractères spéciaux (A04).
- `Utils.rs2` partagé avec d'autres listes ouvertes en cascade.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 220 |
| Lignes de commentaire | 2 |
| Fonctions | 24 |
| Fonctions Public | 24 |
| Complexité cyclomatique totale | 88 |
| Complexité max (fonction) | 13 (`colco_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests prévus (TRICP-T01 à T08) : 7 `replay` (client, facture, fournisseur menu/F11, carte de
fidélité, filtre/tri, pagination, annulation) et 1 `gbtest` sur la requête extraite.

## Rework

6 étapes sans changement de comportement (TRICP-001 à 006) : documentation, fusion `Deb2`/`Deb3`
et des saisies, nettoyage de `CoTable`, réduction de portée de 5 membres, requête en fonction pure,
pagination partagée. 5 anomalies (TRICP-A01 à A05).
