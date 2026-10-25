# Fondcaisse — Synthèse

> Source : `.src/Caisse/Fondcaisse.class` · Synthèse des autres documents.

## Rôle

Écran de saisie et de contrôle du fond de caisse (espèces du tiroir) de la caisse connectée,
ouvert par `Cmenu` et par la saisie `Caisse`. Deux modes selon `Fiches_Caisses.tkz` :
modification du fond initial après le ticket Z (écrit `fndc`), ou contrôle du fond réel contre un
fond théorique (fond initial + espèces − rendus des tickets non validés), avec saisie directe ou
par détail des 15 coupures.

## Points clés

- **Module complexe** (lié au ticket Z) : n'écrit ni ticket ni mouvement et ne clôture pas la
  journée ; seule écriture : `UPDATE Fiches_Caisses SET fndc` (modification, ou correction du fond
  initial par double-clic).
- Fond théorique calculé par la même requête que la section « Mouvements » du ticket Z de
  `Moulinage` (sans le filtre `e.date = l.date`) ; aucun lien avec `Csolde.Solde_caisse` (solde
  comptable de `Fiches_Mvt`) ni avec ses copies (`ClotureF`, `Visreglements`, `TresorFac`).
- Vendeur affiché via `Ouverture.Rvdr` sur l'auto-instance (fenêtre cachée créée).
- Code mort : `PictureBox6_MouseDown` (handler jamais levé), `Form_Close` vide, membre `Mon`.

## Dépendances principales

- Appelants : `Cmenu.Button10_Click`, `Caisse.button21_Click` (`New Fondcaisse`).
- Utilise : `Ouverture.Rvdr`, `Chainage`, `Utils.cpoint`/`PointBase`, `Start.LocalSettings`.
- Tables : `Fiches_Caisses`, `Fiches_LigTicketz`, `Fiches_EntTicketz`, `Fiches_Parametres` (en dur).

## Risques

- Caisse absente : erreur non interceptée du constructeur ; comparaison `tkz = 1` dépendante du
  type renvoyé par le pilote (FONDCAISSE-A01).
- Fond théorique potentiellement différent du fond final du ticket Z (A02, à confirmer).
- Édition des coupures (`Suppr`/`Retour arrière`) incorrecte (A03) ; correction du fond initial
  refusant le point et bloquant le focus (A04) ; images d'une autre devise absentes (A05) ;
  suppression d'un `~/Caisse.lock` jamais créé (A06).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 335 |
| Lignes de commentaire | 4 |
| Fonctions | 28 |
| Fonctions Public | 28 |
| Complexité cyclomatique totale | 98 |
| Complexité max (fonction) | 12 (`Qte_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

8 scénarios `replay` (FONDCAISSE-T01 à T08 : contrôle juste ou avec écart, détail des coupures,
correction du fond initial, modification après ticket Z, caisse absente, édition d'une coupure,
cohérence avec le ticket Z) et 2 `gbtest` après séparation (fond théorique, total des coupures).
**Liste à faire valider par l'utilisateur avant la phase 2** (module complexe).

## Rework

10 étapes sans changement de comportement (FONDCAISSE-001 à 010) : documentation, code mort,
`Cbase.Table`, boucles simplifiées, séparation traitement/GUI, requête commune avec `Moulinage`,
`Rvdr` déplacée, filtre de touches et survol communs, réduction de portée de 5 fonctions.
6 anomalies (FONDCAISSE-A01 à A06).
