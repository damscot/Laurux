# Fclientc — Synthèse

> Source : `.src/Caisse/Fclientc.class` · Synthèse des autres documents.

## Rôle

Paramétrage du **compte client caisse** : le client (`Fiches_Cli`) auquel le moulinage rattache
les ventes de caisse. Donnée stockée dans la table d'une ligne `Fiches_ClientCaisse (code, nom)`.
Ouvert par Fmenu › Constantes › « Compte client caisse ».

## Points clés

- Écran simple : lecture à l'ouverture, Enregistrer (UPDATE sans `WHERE` ou INSERT), Supprimer,
  recherche dans la liste de tous les clients.
- Noms de tables en dur (`Fiches_ClientCaisse`, `Fiches_Cli`) alors que `TabCliCaisse` existe.
- Code mort : `Maj_Zones`, `Cleanchamps`, `Compteman`.
- Pas d'`Utils.Observers(Me)` : écran non rejouable.
- `Refresh` masque `Control.Refresh` : rester `Public`.

## Dépendances principales

- Utilisé par : `Fmenu` (menu).
- Lecteurs de la même donnée : `Moulinage`, `BordereauxC`, `Cmenu` (contrôle avant ouverture de la
  caisse), `LauruxMaj`.
- Utilise : `Utils.db`, `Doc.Open`, `Start.Son`/`Musique`.

## Risques

- A01 : après suppression, le compte reste affiché (et peut être recréé par erreur).
- A04 : aucun contrôle du code client saisi ; liste non triée chargeant toute la table des clients.
- A02 : son joué même désactivé ; A03 : écran non journalisé.
- Une mauvaise valeur casse le moulinage et les bordereaux de caisse (effet différé).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 122 |
| Lignes de commentaire | 31 |
| Fonctions | 13 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 28 |
| Complexité max (fonction) | 5 (`Button4_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests : 3 scénarios GUI (création/modification, recherche, suppression) joués à la main tant que
l'écran n'est pas journalisé (A03), et 1 `gbtest` sur la lecture partagée après extraction.

## Rework

5 étapes (FCLIENTC-001 à 005) : documentation, code mort, `Cbase.Table`, séparation SQL/GUI et
fonction `CompteClientCaisse()` partagée avec `Moulinage`, `BordereauxC` et `Cmenu`. 4 anomalies
(FCLIENTC-A01 à A04).
