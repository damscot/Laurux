# ExportJdv — Synthèse

> Source : `.src/Compta/Utils/ExportJdv.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Fenêtre « Export du Jdv » (Comptabilité > Outils > Export des journaux) : exporte les écritures
validées d'un journal sur une période, et le fichier des clients, vers six formats : fichier texte
Laurux (relu par `ImpJdv`), Quadra, Ciel, CCMX Winner, Cador et Sage. Marque les écritures
exportées, mémorise la période, copie le fichier en `JDV<date>` et peut l'envoyer par courriel.

## Points clés

- `Button2_Click` concentre tout le traitement (427 lignes, **CC 103**, max du lot) : sélection
  SQL, 6 formats imbriqués sur 6 niveaux de `If`, cumuls, ajustement d'arrondi < 0,03, table de
  travail `centralisations`, `UPDATE export` par ligne.
- Les lignes collectif ne sont pas exportées ; les codes clients Sage (`cli_sage`) sont contrôlés
  avant un export Sage.
- Nombreux restes morts : `finmois`, `donnees7`, `cpt_LostFocus` (handler inactif), membres et
  blocs jamais utiles.
- Saisie des dates contrôlée uniquement au clavier (groupe `Cmpt`).

## Dépendances principales

- Appelant unique : `Fmenu.Menu133_Click`.
- Utilise `Utils.db`, `Utils.Cdate_*`, `Utils.Accent`, `Utils.CSlash`, `Utils.Calc_mois`,
  `Cbase.Table`, `Editeur`, `EnvMail`, `Doc`, commandes `chmod`/`cp`, réglages `/Soc<XX>/…`.
- Tables : `Fiches_Mvt` (+ `export`), `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Journaux`,
  `Fiches_Parametres`, `Fiches_Societes`, `centralisations`.
- Couplé par le format à `ImpJdv` (format 1) et `ImpSage` (format 6).

## Risques

- **Format 4 (CCMX Winner) probablement inutilisable** : `Donnees4` est appelé avec 9 arguments
  pour 8 paramètres (EXPORTJDV-A11, l. 758).
- **Format 2 jamais envoyé par courriel** : `EnvMail.Envoi3` est appelé avec 5 arguments pour 4
  (EXPORTJDV-A12, l. 1000, vérifié).

- Contrôle d'équilibre inopérant (`totdeb - totdeb`) : journal déséquilibré exporté (A01).
- Écritures marquées exportées même quand l'export échoue ou est déclaré vide (A02, A03).
- Liste des clients sans code Sage écrite dans le fichier d'écritures (A04) ; copie `JDV` et
  réglages mis à jour même en erreur (A05) ; envoi d'un mauvais fichier clients (A06).
- En-tête de la première société en multi-sociétés (A07) ; SQL par concaténation dans
  `centralisations` (A08).
- Fichier texte non relisible tel quel par `ImpJdv` (en-tête société, A10 / IMPJDV-A05).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 839 |
| Lignes de commentaire | 60 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 205 |
| Complexité max (fonction) | 103 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

15 tests prévus : 13 `replay` (un par format, contrôle Sage, ré-export, erreurs de saisie,
déséquilibre, journal sans collectif, saisie des dates, apostrophe) comparant les fichiers produits
normalisés, `Fiches_Mvt.export`, `centralisations` et les réglages ; 1 `gbtest` sur les fonctions
de ligne par format après extraction ; 1 aller-retour avec `ImpJdv`.

## Rework

10 étapes (EXPORTJDV-001 à 010) : documentation, code mort, réduction de portée de 15 fonctions,
helpers de date et de code client, liste des journaux et choix de répertoire communs avec
`ImpJdv`, `Cbase.Table` et SQL simplifié, `UPDATE export` par écriture, découpage de
`Button2_Click` en fonctions de ligne pures par format, séparation traitement/GUI. 12 anomalies
(EXPORTJDV-A01 à A12) soumises à validation utilisateur.
