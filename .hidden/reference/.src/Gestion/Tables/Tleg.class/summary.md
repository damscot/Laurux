# Tleg — Synthèse

> Source : `.src/Gestion/Tables/Tleg.class` · Synthèse des autres documents.

## Rôle

Édition du texte « Réserve de propriété » (`Fiches_Tleg`, une ligne) imprimé sur les factures par
`ObjFac` et `Facturergbl`.

## Points clés

- Squelette « texte unique » partagé à 91 % avec Tmail, proche de LibelFac.
- Code mort : `CleanChamps`, `Lib_KeyPress`/`Lib_GotFocus` (groupe absent), `Button3_Click`
  (handler inactif, bouton groupé).
- Lecture de la première ligne, écriture sur `lind = 1`.

## Dépendances principales

- Utilise : `Utils.db`, `Utils.ReplaceLb`, `Cbase.Table("TabTleg")`, `Doc`.
- Utilisé par : `Fmenu` (`Show`) ; table lue par `ObjFac`, `Facturergbl`, verrouillée par
  `Moulinage` et `ValidBR`.

## Risques

- A01 : lignes insérées en double si `lind = 1` absent ; A02 : texte vide impossible, `ReplaceLb` ;
  A03 : page d'aide erronée.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 67 |
| Lignes de commentaire | 22 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 6 (`Lib_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (modification, texte vide, `lind` absent, lecture en facturation).

## Rework

5 étapes (001 à 005) : documentation, code mort, fonctions communes « texte unique », séparation
traitement/GUI, réduction de portée. 3 anomalies (A01 à A03).
