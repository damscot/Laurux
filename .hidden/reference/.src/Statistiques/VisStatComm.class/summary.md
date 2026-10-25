# VisStatComm — Synthèse

> Source : `.src/Statistiques/VisStatComm.class` · Synthèse des autres documents.

## Rôle

Visualisation et impression du « Chiffre d'affaires des commerciaux » calculé par `StatComm` :
lecture de la table de travail `Total`, grille `Liste` (client ou commercial, brut, remise, net,
taux et montant de commission), totaux et PDF `~/tmp/Statcli.pdf`.

## Points clés

- Deux modes selon la case `Detail` de `StatComm` : détail (jointure `Fiches_Cli`) ou synthèse.
- Une requête `Fiches_Commerciaux` par ligne ; lignes sans commercial masquées.
- Tris par RadioButton sur `MouseDown` (et non `Click`) : comportement décalé.
- Beaucoup de code mort : `Bnet2_MouseDown` (aucun contrôle), couleurs, boucle `Totl`, totaux
  d'impression jamais imprimés.
- Famille des 5 `VisStat*` : `Sens_Aff` identique, requête de tri et boucle d'impression
  similaires (socle `StatCommun` proposé, voir StatComm).

## Dépendances principales

- Ouvert uniquement par `StatComm.Traitement` ; dépend de la structure de `Total`.
- Utilise `Chistoriques` (PDF), `Visualiseur`, `Utils`, `Cbase.Table("TabCli"/"TabCommerciaux")`.

## Risques

- **A01** : tris Brut/Remise/Net inopérants, tri par nom décalé.
- **A02** : lignes sans commercial masquées et hors totaux.
- **A03** : PDF sans total, nom de fichier partagé avec `VisStatComArt`.
- Table `Total` partagée (STATCOMM-A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 219 |
| Lignes de commentaire | 26 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 32 |
| Complexité max (fonction) | 14 (`Affichage`) |
| Variables globales | 0 |
| Variables Public | 6 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 5 `replay` (détail, synthèse, tris, impression, fermeture), 1 `gbtest` après
séparation. Ne pas cliquer dans `Liste` (`replay_missing`).

## Rework

6 étapes (VISSTATCOMM-001 à 006) : documentation, code mort, réduction de portée, socle commun
`VisStat*`, jointure au lieu de N+1 requêtes, séparation `LignesTotal`. 3 anomalies (A01 à A03).
