# LDateC — Synthèse

> Source : `.src/Utils/LDateC.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Boîte de dialogue modale de sélection de date (`DateChooser`), ouverte par `TextReg` (F2 ou
bouton) sur les champs date et date-heure. Met à jour l'objet `LDate` du champ ou en renvoie un
nouveau.

## Points clés

- Purement GUI ; appelée via l'auto-instance `LDateC.Select(dte)`.
- `update = True` modifie l'objet passé et déclenche `TextReg.dte_change`.
- Mode date-heure par défaut, y compris pour les champs date seule.

## Dépendances principales

- Utilise : `LDate`.
- Utilisé par : `TextReg` uniquement.

## Risques

- Faibles. Hypothèse à confirmer : l'indicateur `Escape` repart à `False` à chaque ouverture
  (auto-instance détruite à la fermeture).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 30 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 3 (`Select`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 scénarios `replay` (LDATEC-T01 à T03) : sélection validée, annulation puis nouvelle sélection,
champ date-heure.

## Rework

3 étapes (LDATEC-001 à 003) : documentation, code mort, réinitialisation explicite d'`Escape`.
1 anomalie (LDATEC-A01, mode du sélecteur, correction dans `TextReg`).
