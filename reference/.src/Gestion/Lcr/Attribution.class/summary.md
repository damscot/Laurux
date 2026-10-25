# Attribution — Synthèse

> Source : `.src/Gestion/Lcr/Attribution.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Attribution banques » : étape 2 de la chaîne LCR. Affiche les LCR non attribuées ou
attribuées (par banque), permet de modifier ou supprimer une LCR et d'attribuer en masse une banque
de remise à toutes les LCR non écartées hors bordereau ; impression PDF de la liste.

## Points clés

- Copie quasi conforme de `Preparation` (et en partie de `Lcr`) : forte duplication.
- Totaux calculés en parcourant la grille jusqu'à `Enrg` lignes : nuls en mode « non attribuées ».
- Attribution en masse : une requête `UPdate` par ligne, sous `LOCK TABLES`, sans transaction, fin
  de boucle fondée sur la répétition du `lind`.
- Une requête `Fiches_Banques` par cellule affichée.
- Code mort : `Deb3`, `Button5_Click`, bouton invisible `Button7` et `compte`, `Nb`.
- Non instrumenté (`Utils.Observers` absent).

## Dépendances principales

- Ouvert par `Fmenu.MenuAbq_Click`. Utilise `CLcr`, `TriCpt`, `Utils`, `Cbase`, `LDate`,
  `Visualiseur`, `Doc`.
- Tables : `Fiches_Lcr` (lecture, mise à jour, suppression), `Fiches_Banques`, `Fiches_Cli`,
  `Fiches_Comptes`.

## Risques

- Totaux affichés faux (A01) : l'utilisateur contrôle une remise sur des chiffres erronés.
- Liste imprimée différente de la liste affichée (A03).
- Attribution partielle en cas d'erreur (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 517 |
| Lignes de commentaire | 42 |
| Fonctions | 47 |
| Fonctions Public | 47 |
| Complexité cyclomatique totale | 125 |
| Complexité max (fonction) | 19 (`Imp_Lcr`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 replays (ATTRIBUTION-T01 à T09) : listes et totaux, recherche, modification, attribution en
masse et ses erreurs, suppression, impression, SQLite. **Module complexe : liste de scénarios à
valider par l'utilisateur avant la phase 2.** Replays conditionnés à l'instrumentation (A06).

## Rework

6 étapes (ATTRIBUTION-001 à 006) : documentation, code mort, réduction de portée, cache des banques,
séparation traitement/GUI, commonalisation avec `Preparation`/`Lcr`. 6 anomalies
(ATTRIBUTION-A01 à A06).
