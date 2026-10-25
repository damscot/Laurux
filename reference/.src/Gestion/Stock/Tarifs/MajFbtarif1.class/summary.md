# MajFbtarif1 — Synthèse

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif1.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran d'import d'une « future base tarif » depuis un fichier `référence;intitulé;prix;code-barre` :
écrit le futur prix de base (`art_pbfbt`) et sa date (`art_datefbt`) des articles trouvés par
code-barre, référence fournisseur ou référence centrale.

## Points clés

- **Écran mort** : aucune classe ni aucun menu ne l'ouvre (vérifié par `grep`) ; le menu
  « Future base tarif » propose `MajFbtarif2` et `Etiqfbtarif`. La fonction est reprise par
  l'option `MajFtbt` d'`Impart`.
- Tout le traitement (lecture de fichier, recherche, `UPDATE`) est dans `Button2_Click`.

## Dépendances principales

- Utilisé par : personne.
- Utilise : `Utils.db`, `Cbase.Table` (`TabArt`, `TabFour`, `TabCentrales`), `Utils.cpoint`,
  `Utils.Cdate_Dbase`, `Utils.Observers`.

## Risques

- Suppression du couple `.class` + `.form` à valider (MAJFBTARIF1-A01).
- Si l'écran était conservé : un code-barre vide en mode centrale écrase le prix futur d'un
  article quelconque (A02) ; pas de conversion d'encodage ni de transaction.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 161 |
| Lignes de commentaire | 11 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 21 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

Aucun test fonctionnel possible (écran inaccessible). Un seul contrôle (T01) accompagne la
suppression : recherche des références, `gbc3 -agt`, replays du menu « Future base tarif ».

## Rework

2 étapes conditionnelles (documentation, variable inutilisée) à ne faire que si la suppression
est refusée ; 2 anomalies (A01 suppression, A02 recherche en mode centrale).
