# FTvac — Synthèse

> Source : `.src/Compta/Tables/FTvac.class` · Synthèse des autres documents.

## Rôle

Écran de la table des codes TVA sur achats (`Fiches_Tvaac`) : création, modification (avec recopie
du taux dans `Fiches_Comptes.taux_tachat`), suppression contrôlée, choix du compte de TVA.

## Points clés

- Jumeau de `FTvav` (80 % de code commun).
- Contrôles regroupés (`Tva`) : `Txtva_LostFocus` et `Tvacc_LostFocus` ne sont jamais déclenchés,
  donc le contrôle du compte (`Tvaman`) et la normalisation du taux ne s'exécutent pas.
- SQL par concaténation pour la table TVA ; `Cleanchamps` et `cpoint` morts de fait.

## Dépendances principales

- Utilise : `Utils` (`db`, `cpoint`, `PointBase`, `SetEditColor`, `Observers`), `Cbase`, `Doc`.
- Utilisé par : `Fmenu.Menu113_Click`.

## Risques

- A01 : compte de TVA inexistant accepté, saisie clavier bloquée sur le compte.
- A02 : apostrophe → erreur SQL ; A03 : suppression de la ligne sélectionnée et non du code saisi.
- A04 : toute touche sur Enregistrer enregistre ; A05 : unicité du compte non contrôlée (à confirmer).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 262 |
| Lignes de commentaire | 32 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 16 (`Tva_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 replays (création, modification de taux, suppression, saisie clavier, liste des comptes) avec
diff de `Fiches_Tvaac` et `Fiches_Comptes`.

## Rework

7 étapes (001 à 007) : documentation, code mort, `Utils.cpoint`, `Cbase.Table`, séparation,
module commun avec FTvav, réduction de portée. 5 anomalies (A01 à A05).
