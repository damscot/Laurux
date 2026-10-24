# Achat — Synthèse

> Source : `.src/Gestion/Entrées/Achat.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Grille de saisie des achats fournisseurs (commandes et bons de réception), héritée de
`SaiTableau`, sans formulaire propre : elle est pilotée par l'écran `commande1`. Elle calcule
les prix de chaque ligne (cascade `LPrix`/`LTaxe` : remise, frais, TVA), enregistre les
documents (`Fiches_Entcom`/`Ligcom`, `Fiches_Entrecpt`/`Ligrecpt`), met à jour stock et PAMP,
gère les matériels (numéros de série), les reliquats, les consignes et droits (options
boissons B/T), l'import d'un inventaire portable, l'impression et l'envoi par mail.

## Points clés

- 1 741 lignes, 58 fonctions ; fonctions les plus complexes : `Import` (CC 19), `LitCommande`,
  `imprime` (229 lignes) et `valider_click`.
- Une vingtaine de handlers **dynamiques** (`Object.Attach` de `SaiTableau`) : `deps.py` les croit
  morts ou réductibles ; ils restent `Public`.
- Toutes les valeurs sont lues dans les contrôles des lignes au moment de l'enregistrement :
  séparation traitement/GUI à faire par petites étapes.
- `EnrAch` valide (`Commit`) la transaction ouverte par `commande1`, puis met à jour le stock
  hors transaction.
- Tables en dur (aucune via `Cbase`), alors que les clés existent.

## Dépendances principales

- Utilise : `SaiTableau`/`Sailig`/`ObjProp` (grille), `LPrix`/`LTaxe` (prix), `Consigne`
  (boissons), `VarMajTar` (tarifs par ligne), `TriArticles`, `ProgBar`, `EnvMail`,
  `Utils.db` (`RecArt`, `Lockstock`, `Create9`, `Edit`).
- Utilisé par : `commande1` (seul instanciateur, 30 membres), `GesTar` (énumération `Tarif`,
  `FicheArt`), `ValidBR1` et `Stockmvt` (énumération d'état).

## Risques

- Suppression d'une réception avec matériels toujours refusée (`IsNull` sur un tableau, A01).
- Commande de reliquat probablement vide (grille `rec` détruite avant lecture, A08, à confirmer).
- Contrôle d'unicité des numéros de série inopérant (A03) ; import portable qui réutilise le code
  précédent (A04) ; division par zéro sur une remise sans `%` (A05) ; erreur sur un document
  sans ligne (A02).
- Module complexe : scénarios à valider avant la phase 2.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1463 |
| Lignes de commentaire | 24 |
| Fonctions | 58 |
| Fonctions Public | 44 |
| Complexité cyclomatique totale | 293 |
| Complexité max (fonction) | 19 (`Import`) |
| Variables globales | 0 |
| Variables Public | 8 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

14 scénarios `replay` via `commande1` (ACHAT-T01 à T14) : commande saisie et générée,
modification, réception avec reliquat, réception directe, suppression, matériels, boissons,
import portable, doublons, impression, remise sans `%`. Valeurs de référence produites dans le
clone non modifié ; `mail()` reste manuel. Aucun gb.test tant que la logique lit les contrôles.

## Rework

10 étapes (ACHAT-001 à 010) : documentation, code mort (`$Mat`, `OptAr`, `Shell cd`,
affectations en double), factorisation de `imprime`, `calcul`, `Doublon` et des fenêtres
modales, `Cbase.Table`, requête unique dans `generer`, séparation de `EnrRec`/`generer`,
réduction de portée de 3 membres. 12 anomalies (ACHAT-A01 à A12) soumises à validation.
