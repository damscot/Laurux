# Bordrx — Synthèse

> Source : `.src/Gestion/Lcr/Bordrx.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Écran « Gestion des bordereaux » : dernière étape de la chaîne LCR. Liste les bordereaux non envoyés
/ envoyés, imprime un bordereau (PDF), génère le **fichier bancaire LCR** (CFONB 160 :
`0360`/`0660`/`1660`/`0860`), marque le bordereau envoyé et l'adresse par mail à la banque ;
réinjection ou suppression des bordereaux.

## Points clés

- Cœur métier du lot : `Button3_Click` (CC 21) construit les enregistrements à positions fixes.
- Aucune écriture comptable (différence avec `BordereauxC` côté chèques).
- l. 383 : `Impression.Prog_Editeur` et `Start.Soc` inexistants → l'envoi par mail échoue toujours.
- Nombreuses fragilités de format : complétions `String$` qui lèvent une erreur, `Val` sans
  `cpoint`, dates dépendantes de la locale, suffixe de fin d'enregistrement littéral.
- Rejouable (`Utils.Observers`) ; `ColLcr` sans `ColLcr_Click`.

## Dépendances principales

- Ouvert par `Fmenu.MenuGbrd_Click`. Utilise `CLcr`, `EnvMail.Envoi2`, `Visualiseur`, `Utils`,
  `Cbase`, `LDate`.
- Tables : `Fiches_Bordereaux`, `Fiches_Lcr`, `Fiches_Banques`, `Fiches_Cli`. Fichiers sous
  `/Soc<XX>/Fichiers`.
- Amont : `Preparation` (bordereaux), `Banque` (coordonnées).

## Risques

- **A01 (grave)** : envoi par mail impossible, bordereau marqué envoyé quand même (A07).
- Fichier bancaire potentiellement non conforme ou non généré (A03-A06, A09) : rejet par la
  banque.

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 460 |
| Lignes de commentaire | 43 |
| Fonctions | 17 |
| Fonctions Public | 17 |
| Complexité cyclomatique totale | 78 |
| Complexité max (fonction) | 21 (`Button3_Click`) |
| Variables globales | 0 |
| Variables Public | 7 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

10 replays et 1 `gbtest` (BORDRX-T01 à T11) : listes, impression, fichier bancaire comparé **octet
par octet** (dates figées par `faketime`, locale fixée) selon les options de la banque, envoi,
champs longs, montants, réinjection, suppression. **Module complexe : liste de scénarios à valider
par l'utilisateur avant la phase 2.**

## Rework

7 étapes (BORDRX-001 à 007) : documentation, code mort, réduction de portée, extraction pure de la
construction du fichier, simplifications SQL, lecture commune de la banque. 9 anomalies
(BORDRX-A01 à A09).
