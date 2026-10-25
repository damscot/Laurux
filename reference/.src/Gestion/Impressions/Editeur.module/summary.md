# Editeur — Synthèse

> Source : `.src/Gestion/Impressions/Editeur.module` · Synthèse des autres documents.

## Rôle

Ouvre un fichier produit par Laurux (export texte, CSV, journal) dans un programme externe : la
commande de la clé `/CmdEditor<n>` si elle existe, sinon `Desktop.Open`.

## Points clés

- `Prog_Editeur` : 37 appels dans 27 fichiers, toujours avec le seul chemin (clé `/CmdEditor0`).
- Déclarée `As String` sans valeur de retour ; variable `$Exec` inutilisée.
- `Prog_Email` : code mort (aucun appelant, choix de programme sans effet) ; seul utilisateur de
  `CheckProg`, qui deviendra mort à sa suppression.
- `Impression.Prog_Editeur` appelé par `Bordrx:383` n'existe pas (IMPRESSION-A03) : la cible
  correcte est ce module.

## Dépendances principales

- Utilise : `Start.LocalSettings`, `CheckProg.Chk` (code mort), `Desktop.Open`, `Shell`.
- Utilisé par : exports comptables (`Balance`, `Journaux`, `ImpSage`…), inventaires, étiquettes,
  `Facture`, `Achat`, `FSauve`/`FRestore`, `EdPrep`…

## Risques

- Chemin non quoté dans `Shell` (EDITEUR-A01) : échec si le chemin contient un espace.
- Point d'interception des tests : `/CmdEditor0` sert à neutraliser l'ouverture dans les replays.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 15 |
| Lignes de commentaire | 5 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Prog_Email`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 tests `gbtest` (EDITEUR-T01 à T04) : commande configurée, chemin avec espace (A01 figée), repli
`Desktop.Open` intercepté, type explicite.

## Rework

3 étapes (EDITEUR-001 à 003) : documentation, suppression de `Prog_Email` (puis `CheckProg`),
nettoyage de `Prog_Editeur`. 1 anomalie (EDITEUR-A01, quoting du chemin).
