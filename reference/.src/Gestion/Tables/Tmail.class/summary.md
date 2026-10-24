# Tmail — Synthèse

> Source : `.src/Gestion/Tables/Tmail.class` · Synthèse des autres documents.

## Rôle

Édition du texte par défaut des courriels de facturation (`Fiches_TxtMail`), lu par `ObjFacB`
quand aucun texte prédéfini (ComMail) n'a été choisi.

## Points clés

- Copie de Tleg (61 lignes communes sur 67), avec un `Try` sur le `SELECT`.
- Code mort : `CleanChamps`, `Lib_KeyPress`/`Lib_GotFocus`, `Button3_Click` (handler inactif).

## Dépendances principales

- Utilise : `Utils.db`, `Utils.ReplaceLb`, `Cbase.Table("TabTmail")`, `Doc`.
- Utilisé par : `Fmenu` (`Show`) ; table lue par `ObjFacB`.

## Risques

- A01 : lecture/écriture sur des lignes différentes possibles ; A02 : texte vide impossible,
  `ReplaceLb`.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 67 |
| Lignes de commentaire | 22 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 6 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 replays (création, modification, `lind` absent).

## Rework

5 étapes (001 à 005) : documentation, code mort, fonctions communes, séparation traitement/GUI,
réduction de portée. 2 anomalies (A01, A02).
