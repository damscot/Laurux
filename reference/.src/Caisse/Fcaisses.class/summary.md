# Fcaisses — Synthèse

> Source : `.src/Caisse/Fcaisses.class` · Synthèse des autres documents.

## Rôle

Écran de gestion de la table des caisses (`Fiches_Caisses`), ouvert par `Fmenu.Menu205_Click`
(auto-instance) : création, modification et suppression d'une caisse (code, intitulé,
imprimante et type d'imprimante ticket, type Monoposte/Réseau, poste, dépôt).

## Points clés

- Gabarit d'écran de table de 2009 (liste `Caisse` + zones du groupe `Cais` + boutons du groupe
  `Btn`), partagé avec `Fvendeurs` et les tables de Gestion.
- Les champs non affichés sont stockés dans des colonnes fantômes `Item[2..7]` de la liste.
- Règles : Monoposte ⇔ poste du serveur ; suppression refusée si la caisse est connectée ou sans
  bande Z.
- Liste des dépôts identique à `Famille` et `Facture` (module `Depot` proposé).
- Fonction la plus complexe : `Cais_KeyPress` (CC 26).

## Dépendances principales

- Appelant : `Fmenu.Menu205_Click`.
- Utilise : `Utils.db`, `Start.LocalSettings` (`/Depots`), `Doc`.
- Tables : `Fiches_Caisses`, `Fiches_Depots` (en dur une fois), `Fiches_EntTicketz` (en dur).
- Données lues ensuite par `Cmenu`, `Ouverture`, `Fondcaisse`, `Moulinage`, `Statcai`, `Caisse`.

## Risques

- Suppression de la ligne sélectionnée au lieu du code contrôlé, SQL par concaténation
  (FCAISSES-A01) ; contrôle des tickets restants inatteignable (A02).
- Touche sur « Enregistrer » sans contrôles Monoposte/Réseau (A03).
- Code dépôt tronqué à deux caractères (A04) ; défauts d'interface (A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 293 |
| Lignes de commentaire | 35 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 122 |
| Complexité max (fonction) | 26 (`Cais_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 scénarios `replay` (FCAISSES-T01 à T07) : création, modification et filtre de saisie,
contrôles Monoposte/Réseau, dépôt, suppression refusée, suppression et cible, Échap dans la liste.

## Rework

9 étapes sans changement de comportement (FCAISSES-001 à 009) : documentation, code mort,
`Cbase.Table`, simplification de `Cais_KeyPress`, séparation traitement/GUI, module `Depot`,
gabarit d'écran de table, filtre de touches commun, réduction de portée de 6 fonctions.
5 anomalies (FCAISSES-A01 à A05).
