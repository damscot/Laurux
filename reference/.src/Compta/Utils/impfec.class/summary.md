# impfec — Synthèse

> Source : `.src/Compta/Utils/impfec.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Intégration d'un fichier FEC » (menu Comptabilité > Outils > Import fichier FEC) :
contrôle puis import d'un Fichier des Écritures Comptables dans `Fiches_Mvt`, avec tables de
correspondance Ciel pour les comptes et journaux, renumérotation optionnelle, clé SHA1 par
écriture, puis recalcul des soldes (`Calcsolde`).

## Points clés

- Deux passes sur le fichier : `ctrl` (contrôle complet, messages cumulés dans `TextArea1`) puis
  `trat` (import en transaction, via `Create9`/`Update`).
- Colonnes FEC utilisées : journal, n° d'écriture, date, compte, compte auxiliaire, libellé de
  compte, pièce, libellé, débit, crédit, lettrage ; en-tête ignoré ; fin de ligne CRLF imposée.
- Compte auxiliaire complété par des zéros et préfixé (ex. `111` sur 4 → `4110111`).
- Ligne collectif ajoutée si le compte a un `coll_cc`.
- Calcul du compte dupliqué entre `ctrl` et `trat` ; tables en dur, aucune `Cbase.Table`.

## Dépendances principales

- Appelant unique : `Fmenu.Menuimpfec_Click`.
- Utilise `Utils.db` (`Exec`, `Create9`, `Begin`, `Commit`), `Utils.Ciel`, `Sha1Calc.CalcSha1`,
  `ProgBar`, `TextReg`, formulaires `Calcsolde`, `Cielcorsp`, `Cielcorspj`.
- Tables : `Fiches_Mvt` (écriture), `Fiches_Parametres.numecriture`, `Fiches_Comptes`,
  `Fiches_Journaux`, `Ciel_Lrx`, `Ciel_Lrx_Jo`.

## Risques

- Une erreur pendant l'import laisse la transaction ouverte et la fenêtre impossible à fermer
  (IMPFEC-A02).
- Verrou `LOCK TABLES` inopérant et jamais levé (A01, à confirmer sur MariaDB).
- FEC à fin de ligne Unix rejeté (A05) ; montants dépendants de la locale (A06).
- Intitulé de la ligne collectif non tronqué (A03), fichier jamais fermé (A04).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 294 |
| Lignes de commentaire | 11 |
| Fonctions | 10 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 61 |
| Complexité max (fonction) | 25 (`ctrl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

9 tests prévus : 8 `replay` (import nominal, renumérotation, contrôle bloquant, séparateurs,
comptes auxiliaires et correspondances, arrêt, fin de ligne LF, erreur en cours d'import) avec un
FEC d'entrée de référence et un diff de `Fiches_Mvt` / `Fiches_Parametres` / `Fiches_Comptes`, et
1 `gbtest` sur `CompteFec` après extraction.

## Rework

8 étapes (IMPFEC-001 à 008) : documentation, code mort, helpers `CompteFec`, `Correspondance`,
`LireFec`, réduction de complexité de `ctrl`, `Cbase.Table`, séparation traitement/GUI,
commonalisation des correspondances avec `Cielimp`. 6 anomalies (IMPFEC-A01 à A06) soumises à
validation utilisateur.
