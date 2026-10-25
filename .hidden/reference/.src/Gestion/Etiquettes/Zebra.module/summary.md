# Zebra — Synthèse

> Source : `.src/Gestion/Etiquettes/Zebra.module` · Synthèse des autres documents.

## Rôle

Envoie une étiquette de gondole au format ZPL (Zebra 203 dpi, 384 × 256 points) sur une socket TCP 9100 : code-barres Code 128, prix, intitulé, code, casier, prix au kg/l, référence fournisseur.

## Points clés

- Seule implémentation ZPL du projet (`Dymo.module` en est une copie morte).
- Appelée par EtiqPromo, Etiqart, Etigond, Etiqcasier **uniquement** sous `ConnZbr = True`, jamais vrai : `Connect` n'est appelée nulle part et `/Soc<XX>/IpZebra` (Prefs) n'est pas lu. Sortie Zebra inatteignable.
- Données non échappées (`^FH` + `_`, `^`), `^CI0` avec intitulés UTF-8, `>63` après le code-barres.

## Dépendances principales

- Utilise `Utils.Remplace`, `Socket` (gb.net) fourni par l'appelant.
- Utilisé par : EtiqPromo, Etiqart, Etigond, Etiqcasier (branches mortes).

## Risques

- Décision fonctionnelle à prendre (ZEBRA-A01) : brancher la connexion ou supprimer toute la chaîne Zebra.
- Rendu non vérifiable sans imprimante.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 19 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 1 |
| Complexité max (fonction) | 1 (`Gondole1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

3 tests `gbtest` (ZEBRA-T01 à T03) : flux reçu sur une socket locale, cas limites, socket fermée.

## Rework

2 reworks (documentation, construction du flux en fonction pure). 2 anomalies : ZEBRA-A01 (chaîne Zebra inatteignable, décision commune aux quatre écrans) et ZEBRA-A02 (échappement, jeu de caractères).
