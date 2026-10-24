# Fpromo — Synthèse

> Source : `.src/Gestion/Tables/Fpromo.class` · Synthèse des autres documents.

## Rôle

Écran de la table des promotions (`Fiches_Promo` : code, libellé, période) ; la suppression d'une
promotion supprime aussi ses articles (`Fiches_ArtPromo`).

## Points clés

- Grille `Colpromo` sur `Utils.Base`/`Utils.rs1`, calendrier pour les dates.
- SQL paramétré et `Cbase.Table`.
- Code mort : `Deb3`, trois variables de couleur.
- `Button2_Click`/`Button3_Click` : pseudo-handlers (boutons groupés `Btn`).

## Dépendances principales

- Utilise : `Utils.Base`, `Utils.rs1`, `Utils.db`, `Utils.Cdate_Dbase`, `Cbase`, `Doc`.
- Utilisé par : `Fmenu` (`ShowModal`) ; tables lues par `Caisse`, `Facture`, `Articles`,
  `ArtPromo`, `EtiqPromo`, `StatPromo`.
- `ColPromo_Click` rejoué par `ReplayObserver` : reste `Public`.

## Risques

- A01 : dates non contrôlées ; A02 : cascade sans transaction, erreurs masquées.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 186 |
| Lignes de commentaire | 34 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 43 |
| Complexité max (fonction) | 8 (`Cmpt_Keypress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, modification, dates incohérentes, suppression en cascade, suppression refusée).

## Rework

6 étapes (001 à 006) : documentation, code mort, UPDATE simplifié, séparation traitement/GUI,
module `Promo` et calendrier communs, réduction de portée. 2 anomalies (A01, A02).
