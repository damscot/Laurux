# TriEcritures — Synthèse

> Source : `.src/Affichages/TriEcritures.class` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Liste modale de sélection d'une **écriture comptable** (`Fiches_Mvt`) non clôturée, non validée ou
validée, en journaux (`Saisecrit`) ou en trésorerie (`Tresor`, hors écritures pointées). Le choix est
rendu par le module global `Comptabilite` (`Bsel`, `snum`, `libelle`, `journal`).

## Points clés

- 9 en-têtes `TextBox` triables (focus = colonne, frappe = filtre, double-clic = ordre) : 27
  méthodes quasi identiques.
- `Debn1`=`Debn3` et `Debn2`=`Debn4` (aux espaces près) : le paramètre `Type` ne sert que dans le SQL.
- `Debe1`-`Debe4`, `numero`/`modif` : code mort.
- SQL entièrement concaténé (`Utils.Base` → `Utils.rs1`).
- Écran instrumenté (`Utils.Observers`) : rejouable.

## Dépendances principales

- Appelants : `Saisecrit.ecritnv`/`ecritv`, `Tresor.ecritnv`/`ecritv`.
- Utilise : `Comptabilite` (état de retour), `Utils` (`Base`, `rs1`, `Observers`, `ObsGotf`,
  `ObsLstf`), `Cbase`.
- Copie morte : `TriEcritures2` (88 % identique).

## Risques

- **A03** : Entrée sur une grille vide → `Bsel = True` avec l'ancien `snum` : reprise de la mauvaise
  écriture.
- **A01** : filtre concaténé (erreur SQL sur `"`/`\`).
- A02 : en-tête non restauré (affichage).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 602 |
| Lignes de commentaire | 2 |
| Fonctions | 65 |
| Fonctions Public | 65 |
| Complexité cyclomatique totale | 198 |
| Complexité max (fonction) | 11 (`Ecrit_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

6 tests : 5 `replay` (reprise en saisie et en trésorerie, tri/filtre, pagination, fermeture et grille
vide), mutualisés avec SAISECRIT-T04 et TRESOR-T05, et 1 `gbtest` sur `RequeteEcritures`. Jeu
d'écritures dérivé commun aux éditions comptables.

## Rework

8 étapes (TRIECRITURES-001 à 008) : documentation, code mort (`Debe1`-`Debe4`), fusion des requêtes
identiques, aides pour les 27 méthodes d'en-tête, requête unique en saisie de date, réduction de
portée de 8 fonctions, séparation du SQL, `PaginationListe`. 3 anomalies (A01 à A03).
