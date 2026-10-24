# Lettragemontant — Synthèse

> Source : `.src/Compta/Lettrages/Lettragemontant.class` · Synthèse des autres documents.

## Rôle

Traitement de masse qui lettre, pour chaque compte client ou fournisseur, les écritures validées
non lettrées de `Fiches_Mvt` de même montant lorsque leur total s'équilibre (lot `M…`), puis
recalcule leur SHA1.

## Points clés

- Tout le traitement est dans `Button2_Click` (CC 16) ; aucune confirmation ni transaction.
- Seule la première écriture non lettrée de chaque compte sert de référence, deux passes par compte.
- Le même UPDATE est rejoué pour chaque ligne du groupe (seule la première exécution agit).
- `clear` et trois membres sont du code mort.

## Dépendances principales

- Utilise : `Utils.db`, `Sha1Calc.CalcSha1`, `Doc` ; tables `Fiches_Comptes`, `Fiches_Mvt` (en dur).
- Utilisé par : `Fmenu.Menu126_Click`.

## Risques

- A01 : un montant de référence nul transforme le traitement en lettrage de tout le compte.
- A02 : résultat d'un compte précédent réutilisé (ou erreur) si le montant est vide.
- A03 : lot commun `"M"` ; A04 : deux groupes au plus, égalité Float stricte, `Mvt1-5` ignorées.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 104 |
| Lignes de commentaire | 23 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 23 |
| Complexité max (fonction) | 16 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

4 replays (clients, fournisseurs, jeu contrôlé, rien à lettrer) avec dump de `Fiches_Mvt` et 1
gbtest sur la fonction extraite.

## Rework

6 étapes (001 à 006) : documentation, code mort, UPDATE unique par groupe (dump identique),
requête factorisée, `Cbase.Table`, séparation traitement/GUI. 4 anomalies (A01 à A04).
