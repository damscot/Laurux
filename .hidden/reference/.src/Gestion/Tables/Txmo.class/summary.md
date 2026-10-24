# Txmo — Synthèse

> Source : `.src/Gestion/Tables/Txmo.class` · Synthèse des autres documents.

## Rôle

Écran de paramétrage des **taux de main-d'œuvre** (`Fiches_Txtmo`) : code, libellé, taux horaire
de vente, compte de vente (classe 7) et prix de revient horaire. Ouvert en non modal depuis le
menu Gestion (`Fmenu.Menu28_Click`).

## Points clés

- Enregistrer un taux modifié **répercute** taux, prix de revient et marge recalculée sur toutes
  les MO de `Fiches_Mo` qui l'utilisent (`MajMo` + `Calc_MargeMo`, une requête par MO).
- Calcul de marge identique à celui de `Movr.Calc_MargeMo` (commonalisation prévue).
- Zones de saisie groupées (`Tmo`) : les `*_LostFocus` nominaux ne sont jamais levés ; la
  validation ne se fait qu'au clavier (`Tmo_KeyPress`).
- SQL paramétré, mais noms de tables en dur (`Fiches_Txtmo`, `Fiches_Comptes`) à côté de
  `Cbase.Table`.
- Fonction la plus complexe : `Tmo_KeyPress` (CC 14).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.cpoint`, `Utils.SetEditColor`, `Utils.Observers`, `Cbase.Table`,
  `Doc.Open`.
- Tables : `Fiches_Txtmo` (gérée), `Fiches_Mo` (mise à jour en masse), `Fiches_Comptes` (lecture).
- Appelée par `Fmenu` uniquement ; `Fiches_Txtmo` est aussi lue par `Movr`, `Prefs`, `Suivi`.

## Risques

- Champs obligatoires manquants : le message s'affiche mais la répercussion et le rafraîchissement
  continuent (A01).
- Suppression de la ligne sélectionnée au lieu du code saisi (A02).
- Sortie de zone à la souris sans contrôle (A03) ; écrasement du prix de revient des MO (A04, à
  confirmer métier).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 356 |
| Lignes de commentaire | 43 |
| Fonctions | 21 |
| Fonctions Public | 21 |
| Complexité cyclomatique totale | 80 |
| Complexité max (fonction) | 14 (`Tmo_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests prévus : 5 replays (création, modification avec répercussion sur `Fiches_Mo`, contrôles,
suppression, liste des comptes) sur `Laurux01.sql` sans jeu dérivé, et 1 `gbtest` du calcul de
marge après séparation traitement/GUI.

## Rework

7 étapes sans changement de comportement (TXMO-001 à 007) : documentation, code mort,
`Cbase.Table`, calcul de marge pur et commun avec `Movr`, extraction SQL de l'enregistrement,
réduction de portée de 6 fonctions. 4 anomalies (TXMO-A01 à A04) soumises à validation.
