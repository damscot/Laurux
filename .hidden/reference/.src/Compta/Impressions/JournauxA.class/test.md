# JournauxA — Tests

> Source : `.src/Compta/Impressions/JournauxA.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests **replay** de l'écran « Impression des journaux analytiques ». Critères : texte
du PDF normalisé (`pdftotext`), messages d'erreur affichés, dump de la base (table
`centralisation`). Plusieurs tests **figent une erreur** : ils documentent l'état actuel avant
décision sur les anomalies.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| JOURNAUXA-T01 | replay | Liste des postes | F2 sur `Cpt` (postes existants) | erreur sur le champ `intitule` (A02 figée, message exact à capturer) | `tests/liste_postes/` | à faire : touche F2 non rejouée |
| JOURNAUXA-T02 | replay | Impression, tri postes/journaux | `Fiches_MvtA` : 2 postes, 2 journaux, écritures dans la période | comportement figé (erreur d'arguments de `level2J` attendue, A01 à confirmer) | `tests/tri_postes/` | implémenté |
| JOURNAUXA-T03 | replay | Impression, tri journaux/postes | mêmes données, `RadioButton2` | erreur SQL `intitule` (A02 figée) | `tests/tri_journaux/` | implémenté |
| JOURNAUXA-T04 | replay | Écritures toutes hors période | `Fiches_MvtA` avec dates hors période | PDF avec titres de rupture sans ligne + page de centralisation vide (A05 figée) | `tests/hors_periode/` | implémenté |
| JOURNAUXA-T05 | replay | Aucune écriture | postes `998`-`999` | message « Aucune ecriture pour cette demande » | `tests/aucune_ecriture/` | implémenté |
| JOURNAUXA-T06 | replay | Complétion de date | saisie `15` puis `15.03` dans `dteN0`/`dteN1` | `15.<mois>.<année>` et `15.03.<année>` courants | `tests/completion_date/` | à faire : dates complétées visibles seulement à l'écran et dans le PDF (non comparés) |
| JOURNAUXA-T07 | replay | Choix d'exercice | `N1`…`N5` puis impression | dates de référence ; lecture de `Fiches_MvtA` quel que soit l'exercice (A05 figée) | `tests/choix_exercice/` | à faire : dates de référence visibles seulement à l'écran et dans le PDF (non comparés) |
| JOURNAUXA-T08 | replay | Quitter | Quitter après impression | `~/tmp/Journaux.pdf` supprimé | `tests/quitter/` | implémenté |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** (base
  Docker du jeu dérivé). `Laurux01.sql` ne contient ni poste (`Fiches_Postes` vide) ni écriture
  analytique (`Fiches_MvtA` vide) : le jeu dérivé commun (voir [Balance](../Balance.class/test.md)) doit en
  ajouter.
- **Erreurs Gambas** : une erreur non interceptée (A01, A02) ouvre la boîte d'erreur de
  l'interpréteur ; le runner doit capturer le message et l'état (fichier PDF absent, curseur)
  plutôt qu'un PDF.
- **Mode SQL MariaDB** : le résultat de A04 (`njournal Char(2)` recevant un compte) dépend du
  mode strict ; fixer `sql_mode` dans le conteneur et le noter dans `tests/`.
- **Date système** : `_New`/`Ex1` dépendent de `Now` : horloge figée (`faketime`).
- **Non testable automatiquement** : visualiseur PDF, aide, sons.
- **Scénarios (vague 3)** : `.hidden/Tests/Compta/assets/journauxa_<nom>/` — `tri_postes` (T02, `code_sortie` 125 :
  « Not enough arguments » sur `pdf.level2J`, l. 695, A01 confirmée), `tri_journaux` (T03, `code_sortie` 125 :
  « Unknown column 'intitule' », A02), `hors_periode` (T04 et T08 : PDF ouvert puis supprimé par Quitter, `tmp/Journaux.pdf`
  comparé « <fichier absent> »), `aucune_ecriture` (T05, Laurux01). Jeux : `journauxa_shared/journauxa_base.sql` (postes 10/20,
  Fiches_MvtA 2018), `journauxa_hors_periode/journauxa_hors_periode.sql` (écritures 2016).
