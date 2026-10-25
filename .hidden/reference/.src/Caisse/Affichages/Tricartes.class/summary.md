# Tricartes — Synthèse

> Source : `.src/Caisse/Affichages/Tricartes.class` · Synthèse des autres documents.

## Rôle

Liste paginée (mode tactile) de sélection d'une fiche `Fiches_Carte` depuis la caisse : cartes de
fidélité (`divers = 0`, F8) ou clients divers des facturettes (`divers = -1`, Ctrl+N). Le code choisi
est renvoyé à l'écran appelant par `Object.SetProperty(ob, "Bsel"/"Bval")`. F4 ouvre la gestion des
cartes (`FClientcarte`).

## Points clés

- Contrat : `New Tricartes(Divers, ob)` ; `ob` doit exposer `Public Bsel`/`Bval` (`Caisse`).
  `Bsel` est bien remis à `False` à l'ouverture (pas de défaut de type MATERIEL-A09).
- Pagination par `LIMIT <début>, <lg>` ; filtre, tri et pagination concaténés dans le SQL.
- Pas d'héritage de `TriGen` : modèle `Tri*` historique, 60 % commun avec `TriclientsD`.
- Code inutile : lectures de couleurs à chaque cellule (`Colcli_Data`).

## Dépendances principales

- Utilisé par : `Caisse` (`CartesFidelite`, `ClientsDivers`).
- Utilise : `Utils.Base2`/`rs2`, `Utils.Obstch`, `Cbase.Table("TabCarte")`, `FClientcarte`.

## Risques

- **A01** : `Caisse.ClientsDivers` n'envoie pas l'écran appelant → le client divers choisi n'est
  jamais repris (`Caisse.class:7255`, plus `RecupClientd(Codearticle)` au lieu du code choisi).
- A02 : filtre concaténé (`\` → erreur SQL, `%`/`_` jokers).
- `lg` dépend de la géométrie de l'écran : rejeu sensible à la résolution.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 322 |
| Lignes de commentaire | 13 |
| Fonctions | 37 |
| Fonctions Public | 37 |
| Complexité cyclomatique totale | 102 |
| Complexité max (fonction) | 11 (`ColCli_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

7 tests : 6 `replay` en mode caisse (sélection fidélité, filtre/tri, pagination, clients divers,
F4, fermeture) et 1 `gbtest` sur la requête extraite (TRICARTES-T07).

## Rework

6 étapes (TRICARTES-001 à 006) : documentation, code mort de `Colcli_Data`, factorisation
`Deb3`/`Deb4` et des en-têtes, réduction de portée de 7 membres, pagination commune avec les
`Tri*`, extraction de la requête. 2 anomalies (TRICARTES-A01, A02) soumises à validation.
