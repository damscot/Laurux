# Etiqart — Synthèse

> Source : `.src/Gestion/Etiquettes/Etiqart.class` · Synthèse des autres documents.

## Rôle

Impression des étiquettes produit (code, intitulés, EAN13, prix TTC optionnel) en PDF A4 ou Dymo, par plage d'articles (bornes article/famille/fournisseur, 5 tris) ou par liste (table de travail `Etiquettes`, saisie manuelle ou import du terminal portable).

## Points clés

- Souche d'une famille de 3 écrans : 92 % commun avec Etiqcasier, 85 % avec Etigond (`dup.py`).
- Documente le socle `PlancheEtiquettes` (modèles, format, ouverture PDF, 6 variantes de `pos_Etiq`, sortie) commun à tout le lot et à FClient/FFournisseur, et le module `EtiqArticles` propre à la famille.
- `Art1_man` et `Connect` morts ; branche Zebra inatteignable ; deux `Utils.Observers(Me)`.
- Code-barres imprimé tel quel (EAN13) : pas d'usage de `Utils.Calcode` ni du préfixe `299999`.

## Dépendances principales

- Appelants : `Fmenu.Menu157/161_Click`, `Articles.Btn_click` ; `TriArticles` écrit `Bsel`/`Bval`.
- Tables `Fiches_Art`, `Fiches_Fam`, `Fiches_Four`, `Fiches_Etiquettes`, table de travail `Etiquettes` ; `Portable`, `Visualiseur`, `Editeur`, `CEtiquettes`.

## Risques

- Zebra : `pdf.Open()` sur `Null` (A01) ; import portable qui ouvre le PDF au lieu du rapport (A02) ; article orphelin en liste → erreur (A03) ; table `Etiquettes` permanente partagée entre postes (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 848 |
| Lignes de commentaire | 74 |
| Fonctions | 38 |
| Fonctions Public | 38 |
| Complexité cyclomatique totale | 197 |
| Complexité max (fonction) | 24 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

12 tests (11 `replay` avec comparaison du dump et du PDF normalisé, 1 `gbtest` sur le calcul de position V1).

## Rework

11 reworks (documentation, code mort, 3 commonalisations `EtiqArticles`, découpage de `Button2_Click`, séparation, portée de 12 membres, `Cbase`, socle `PlancheEtiquettes`, observateurs). 6 anomalies (A01-A06).
