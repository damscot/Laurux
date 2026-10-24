# Editcompte — Synthèse

> Source : `.src/Compta/Impressions/Editcompte.class` · Synthèse des autres documents.

## Rôle

Écran d'édition des **grands livres** (Comptabilité > Impressions > Grands livres ; l'en-tête du
source dit à tort « extraits de compte ») : client, fournisseur, gestion, bilan ou général, sur
l'exercice choisi (`Fiches_Mvt` … `Fiches_Mvt5`). Impression déléguée à `EditcompteM.Imprime`
(`~/tmp/Glivre.pdf`) ; export texte local (`~/tmp/Glivre.txt`) avec centralisation mensuelle des
comptes `cent_cc = 1` dans la table de travail `Ctrln`.

## Points clés

- Modèle copié pour créer `EditcompteA` (29 fonctions identiques, 491 lignes communes) ; partage
  `Centralisation`, `finmois`, `Raz` à l'identique avec `EditcompteM`.
- Mêmes fonctions de bornes d'exercice que `Balance`, avec les tables en dur (pas de `Cbase`).
- `Cmpt_KeyPress` (CC 56) contrôle le préfixe des comptes selon la nature ; la condition de fin de
  plage en gestion est fausse (`Or`).
- `dteN0_LostFocus`/`dteN1_LostFocus` ne sont pas de vrais handlers (champs groupés `Cmpt`).
- L'export recrée `Ctrln` (DROP/CREATE) à chaque compte et calcule des totaux jamais écrits.

## Dépendances principales

- Appelé par `Fmenu.Menu38_Click` (auto-instance) ; `EditcompteM` modifie `Editcompte.Mouse`.
- Utilise `EditcompteM`, `TriCpt`, `Utils` (dates, `db`), `Editeur`, `Doc`.
- Tables : `Fiches_Parametres`, `Fiches_Comptes`, `Fiches_Mvt*` (lecture), `Ctrln` (écriture).

## Risques

- **EDITCOMPTE-A01** : en mode Gestion, le compte de fin est toujours refusé au clavier.
- **EDITCOMPTE-A06** : `Ctrln` partagée par nom avec 5 autres éditions de structures différentes
  (collision possible en multi-poste) et laissée en base.
- Export sans `Catch`, fichier laissé ouvert quand aucun compte n'est trouvé (A05).
- Aucun test existant.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 579 |
| Lignes de commentaire | 123 |
| Fonctions | 38 |
| Fonctions Public | 38 |
| Complexité cyclomatique totale | 136 |
| Complexité max (fonction) | 56 (`Cmpt_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 tests `replay` (EDITCOMPTE-T01 à T10) : ouverture et bornes (horloge fixée), contrôle des comptes
par nature, contrôles de date, exports client / centralisé / général / vide / exercice archivé,
`TriCpt`. Le dump de la base (table `Ctrln`) est comparé. Le rendu PDF est couvert par EDITCOMPTEM.

## Rework

9 étapes (EDITCOMPTE-001 à 009) : documentation, code mort, chargeur de bornes et `Cbase`, extraction
du contrôle de compte (CC 56 → ~10), simplification de `_New` sous condition, helper commun de
centralisation (avec EditcompteM, EditcompteA, Extrait), helpers communs de bornes et de dates
(avec Balance), séparation de l'export, réduction de portée. 7 anomalies (EDITCOMPTE-A01 à A07).
