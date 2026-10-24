# SaiTableau — Synthèse

> Source : `.src/Utils/SaiTableau.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Composant de grille de saisie dynamique : une suite de lignes `Sailig` dans une `ScrollView`, avec
en-tête, totaux, bandeau d'aide et choix MO/Articles/Stock optionnels ; navigation et édition au
clavier (retour ligne, insertion, suppression, déplacement), couleurs alternées.

## Points clés

- Aucun SQL ; purement graphique.
- Hérité par `Achat`, qui redéfinit `ajout`, `Delete` et les handlers `ligne_*` ; instancié par
  `Parametre`, `GesTar`, `Achat`.
- Événements des contrôles rattachés dynamiquement à l'instance (`Object.Attach`) : l'héritier reçoit
  `<Controle>_<Evenement>`, `LPrix_*`, `Ltaxe_*`.
- 19 membres `Public`, dont `$prop`/`$parent` (préfixe `$` trompeur).

## Dépendances principales

- Utilise `Sailig`, `ObjProp`, `TextReg`, `Utils.Option`, `Utils.Accent`.
- Utilisé par `Achat` (héritage), `GesTar`, `Parametre`, `commande1`, `VarMajTar`.

## Risques

- Contrat implicite avec l'héritier `Achat` (noms de handlers, membres lus via `Me.`) : toute
  réduction de portée doit être vérifiée par grep, l'heuristique ne voit pas ces usages.
- `ligne_InsLig` crée un panneau orphelin en lecture ; en-tête qui ne défile pas.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 284 |
| Lignes de commentaire | 2 |
| Fonctions | 19 |
| Fonctions Public | 15 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 9 (`ligne_SupLig`) |
| Variables globales | 0 |
| Variables Public | 19 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 tests (SAITABLEAU-T01 à T08) : 6 gb.test sous affichage virtuel (construction, ajout, nettoyage,
déplacement, insertion en lecture, suppression totale) et 2 replays (Achat, GesTar).

## Rework

5 étapes (SAITABLEAU-001 à 005) : documentation, code mort, factorisation des échanges et du
recoloriage, simplification de `show`, réduction de portée de 7 membres. 3 anomalies
(SAITABLEAU-A01 à A03).
