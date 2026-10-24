# Cpostaux — Synthèse

> Source : `.src/Gestion/Tables/Cpostaux.class` · Synthèse des autres documents.

## Rôle

Écran de la table des codes postaux et bureaux distributeurs (`Fiches_Cpostaux`), utilisée pour
la saisie des adresses (clients, fournisseurs, société).

## Points clés

- Squelette « grille filtrable » (`Utils.Base` + `Utils.rs1`, filtres par en-têtes `CP`/`BD`,
  `Deb2`/`Deb3`/`Dbclk`) partagé avec Marques et Depots, et présent dans ~30 écrans.
- `Button1_Click` équivaut à `Enrgcp.Ecp` ; son UPDATE est inopérant (`WHERE cp = &2`).
- Code mort : `cpoint` (copie locale de `Utils.cpoint`, jamais appelée).
- Pseudo-handlers : `Cpostal_GotFocus`, `Burdist_GotFocus`, `Cpostal_LostFocus` (contrôles groupés).

## Dépendances principales

- Utilise : `Utils.Base`, `Utils.rs1`, `Utils.db`, `Utils.SetEditColor`, `Doc`.
- Utilisé par : `Fmenu` (`Show`) ; table écrite par `Enrgcp`, `Impcpostaux`, lue par `Tricp`,
  `FClient`, `FFournisseur`, `Facture`, `Fsoc`.
- `Colcpost_Click`, `Colcp_Click` rejoués par `ReplayObserver` : restent `Public`.

## Risques

- A01 : modification du bureau → doublon ; A02 : filtre concaténé ; A03 : suppression de la ligne
  sélectionnée, recherche seulement au clavier.
- Partage de `Utils.rs1` avec les autres écrans ouverts.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 286 |
| Lignes de commentaire | 23 |
| Fonctions | 34 |
| Fonctions Public | 34 |
| Complexité cyclomatique totale | 70 |
| Complexité max (fonction) | 8 (`Cpost_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 replays (création, modification, choix de bureau, filtre et tri, suppression, saisie numérique).

## Rework

7 étapes (001 à 007) : documentation, code mort, `Enrgcp.Ecp`, `Cbase.Table`, socle « grille
filtrable », séparation traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
