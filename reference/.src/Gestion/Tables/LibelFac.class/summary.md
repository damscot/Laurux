# LibelFac — Synthèse

> Source : `.src/Gestion/Tables/LibelFac.class` · Synthèse des autres documents.

## Rôle

Édition du texte de bas de facture (`Fiches_LibelFac`, une ligne), lu par `ObjFac`.

## Points clés

- Variante minimale du squelette « texte unique » (Tleg, Tmail).
- Nom de table en dur ; `UPdate` sans `WHERE` (toutes les lignes) ; `Music.Load` inutile ; aide
  désactivée.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.ReplaceLb`, `Utils.Observers`.
- Utilisé par : `Fmenu` (`Show`) ; table lue par `ObjFac`, verrouillée par `Facturergbl`, `Moulinage`.

## Risques

- A01 : texte vide impossible, `ReplaceLb`, pas de retour visuel ; colonne limitée à 250 caractères.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 35 |
| Lignes de commentaire | 23 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 4 (`Btn_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (modification, table vide, texte long).

## Rework

5 étapes (001 à 005) : documentation, code mort, `Cbase.Table`, fonctions communes, réduction de
portée. 1 anomalie (A01).
