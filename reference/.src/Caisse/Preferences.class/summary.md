# Preferences — Synthèse

> Source : `.src/Caisse/Preferences.class` · Synthèse des autres documents.

## Rôle

Écran des préférences locales de la caisse : lit une trentaine de clés
`/Soc<XX>/caisse/…` de `Laurux.conf`, les présente et les réécrit toutes à la fermeture. Ouvert
par `Cmenu` (`Alt+P`, bouton « Préférences » ou après mot de passe administrateur). Accès à
`LauruxConf` et `Majversion`.

## Points clés

- Aucun accès à la base ; commande externe `lpc status` pour lister les imprimantes.
- Enregistrement systématique à la fermeture, sans annulation possible.
- `_new` (CC 41) et `Form_Close` répètent la même liste de clés : une table commune la réduirait.
- Membres morts : `Fontes`, `chkNbase`, `Lig`, `cs`, `cv`.

## Dépendances principales

- Appelant : `Cmenu` (auto-instance).
- Lecteurs des clés : `Caisse` (17 clés), `Impression`, `Visualiseur`, `Start`, `Ouverture`,
  `Fmenu`, `Cmenu`, `Cfacture`, `Tricartes`, `TriclientsD`.

## Risques

- Préférences d'impression des factures ignorées : `Impression.Facture` lit des clés globales
  (PREFERENCES-A01, liée à IMPRESSION-A01/A02).
- Clés sans effet : `caisse/son`, `caisse/tircarte`, `caisse/FACpdf` (A01, A02).
- Annuler le choix du répertoire des tickets Z le remplace par le dossier personnel (A03).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 183 |
| Lignes de commentaire | 3 |
| Fonctions | 15 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 65 |
| Complexité max (fonction) | 41 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

5 scénarios `replay` (PREFERENCES-T01 à T05 : aller-retour, configuration vide, modification de
chaque contrôle, répertoire Z, impression de facture) comparant le `Laurux.conf` produit, et 1
`gbtest` après séparation (T06).

## Rework

7 étapes sans changement de comportement (PREFERENCES-001 à 007) : documentation, code mort,
table des préférences, séparation traitement/GUI, liste d'imprimantes et filtre d'images communs,
survol des boutons, réduction de portée. 3 anomalies (PREFERENCES-A01 à A03).
