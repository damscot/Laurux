# Famille — Synthèse

> Source : `.src/Gestion/Tables/Famille.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran de gestion des familles d'articles (`Fiches_Fam`) : libellé, coefficient, remise, TVA,
comptes de vente / achat / remise (709), éco-taxe, remises par quantité (6 tranches), compte de
vente par dépôt (`Fiches_FamDep`) et statistiques (`gridvi`). Ouvert depuis le menu et la fiche
article.

## Points clés

- Zones regroupées dans le groupe d'événements `fam` ; les contrôles se font selon le `Tag`
  dans `fam_lostfocus`/`fam_KeyPress` ; les handlers nominaux (`Coef_LostFocus`…) ne sont pas
  levés mais appelés explicitement.
- `Button1_Click` (CC 28) concentre contrôles, deux `UPdate` de 32 colonnes ou un `INSERT`,
  synchronisation serveur et `Fiches_FamDep`.
- Drapeau d'erreur global `b` partagé entre fonctions.
- Code mort : `Btn_KeyPress`, `Colcompt2_KeyPress` (et `Colcompt2_Click`, conservé pour le rejeu).

## Dépendances principales

- Utilise : `Utils` (couleurs, observateurs, formats), `gridvi`, `Serveur`, `Variables`,
  `Cbase` (`TabFam`, `TabArt`, `TabMo`, `TabComptes`, `TabTvav`, `TabDepots`).
- Utilisé par : `Fmenu`, `Articles` (ouverture seulement).

## Risques

- F2 sur le 2ᵉ compte de vente remplit le compte de remise (A01).
- Suppression : pointeur bloqué en attente après refus, contrôle sur le code saisi mais
  suppression de la ligne sélectionnée (A02), `Fiches_FamDep` orphelines (A03).
- `Fiches_FamDep` alimentée même sans option dépôts (A04).
- Observateurs de rejeu recréés à chaque changement d'onglet (A05) : journal en double.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 761 |
| Lignes de commentaire | 52 |
| Fonctions | 40 |
| Fonctions Public | 40 |
| Complexité cyclomatique totale | 218 |
| Complexité max (fonction) | 28 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 scénarios `replay` (FAMILLE-T01 à T09) : création, modification et TVA, contrôles, listes F2,
suppression, remises par quantité, dépôts, onglets/rejeu, synchronisation serveur.

## Rework

8 étapes (FAMILLE-001 à 008) : documentation, code mort, boucle sur les tranches de remise,
fonctions de contrôle à retour booléen, séparation traitement/GUI, réduction de portée de 9
fonctions, composant commun d'édition de grille (avec `Articles`, `Txmo`) et listes communes.
6 anomalies (FAMILLE-A01 à A06).
