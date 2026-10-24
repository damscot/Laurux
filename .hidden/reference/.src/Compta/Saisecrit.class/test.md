# Saisecrit — Tests

> Source : `.src/Compta/Saisecrit.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran de saisie comptable : l'essentiel des tests est en **replay** (journal de rejeu capturé avec
`./Laurux -l --logfile …`, puis rejoué avec `-r`). Le résultat comparé est le **dump normalisé**
des tables `Fiches_Mvt`, `Fiches_MvtA`, `Fiches_MvtM` (colonne `datem` masquée), `Fiches_Comptes`
(colonne `solde`), `Fiches_Parametres` (`numecriture`), `Fiches_Numabon`, `Ecrs` et des tables GED
selon le test. Les `gbtest` portent sur les fonctions pures extraites par le rework.

**Module complexe** (PLAN §0) : la liste des scénarios ci-dessous est à **présenter à
l'utilisateur pour validation** avant la génération des tests en phase 2.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAISECRIT-T01 | replay | Écriture d'achat avec TVA et ventilation automatiques | `Laurux01.sql` ; journal `AC` ; fournisseur 401 avec une seule ventilation et compte 6 soumis à TVA ; montant TTC saisi au crédit ; validation `Button2` | dump `Fiches_Mvt` (3 lignes validées, ligne 445 générée, `numcol`), soldes `Fiches_Comptes` (compte, collectif), `numecriture` + 1, `Fiches_MvtA` | `tests/achat_tva_ventilation/` | à faire |
| SAISECRIT-T02 | replay | Écriture de vente | journal `VE`, client 411 (libellé par défaut avec variables `LVar`, échéance `cli_cdech`), compte 7 avec TVA | dump `Fiches_Mvt` (libellé évalué, `dateech` calculée), soldes | `tests/vente_tva/` | à faire |
| SAISECRIT-T03 | replay | OD multi-lignes et collectif | journal `OD`, 4 lignes dont deux sur des comptes rattachés au même `coll_cc`, puis à deux collectifs différents | lignes `collectif = 1` cumulées, soldes des collectifs ; suppression de la ligne de collectif soldée (dernier collectif seulement, SAISECRIT-A02 figée) | `tests/od_collectifs/` | à faire |
| SAISECRIT-T04 | replay | Écriture abandonnée puis reprise | saisie de 2 lignes, `Necrit` ; reprise par `ToggleButton6` → « écritures non validées » (`Ecr1`, `TriEcritures`) ; validation | lignes provisoires après abandon ; contenu de `Ecrs` ; dump final | `tests/reprise_provisoire/` | à faire |
| SAISECRIT-T05 | replay | Rappel d'une écriture validée | depuis `Extrait` (`New Saisecrit(num, Me.Parent, True)`) et `Ecritures` : confirmation Oui puis Non ; écriture lettrée (lot `M<n>`) | `Fiches_MvtM` archivé (`datem` masqué), soldes décrémentés, délettrage (`lettree = 0`, lot sans préfixe), écriture provisoire, SHA1 recalculé ; fermeture si refus ; répartition des 3 arguments du constructeur observée (SAISECRIT-A09) | `tests/rappel_validee/` | à faire |
| SAISECRIT-T06 | replay | Suppression d'une écriture | `Suppr` (`DelMvt`) sur une écriture rappelée avec document GED et lignes analytiques | `Fiches_Mvt`/`Fiches_MvtA` vidés pour le numéro, `Fiches_MvtM.supprimee = 1`, document GED supprimé, soldes | `tests/suppression_ecriture/` | à faire |
| SAISECRIT-T07 | replay | Modification et suppression de lignes | `Ecrit1` : Entrée (rappel de ligne, `Ecrit1_Activate`), modification du montant, Suppr sur une ligne ; Entrée sur grille vide | dump intermédiaire et final ; comportement sur grille vide figé (SAISECRIT-A08) | `tests/lignes_modif/` | à faire |
| SAISECRIT-T08 | replay | Contrôles de date et numérotation | date ≤ `dtepc`, date > fin d'exercice, date invalide `"32.13.2025"`, date valide | avertissements ; numéro attribué une seule fois ; `numecriture` en base | `tests/dates_numero/` | à faire |
| SAISECRIT-T09 | replay | Masque d'abonnement | F7 sur le compte, choix d'un masque `Fiches_Numabon`/`Fiches_Ligabon` avec formules `$montant` et variables de date dans document/lot/libellé ; `Button4` puis validation ; puis abandon avant validation | lignes de `Ecrit1` (via dump après validation), compteur du masque (`Abont.Compteur_Incr`), aucune ligne en base si abandon (à confirmer) | `tests/masque_abonnement/` | à faire |
| SAISECRIT-T10 | replay | Refus et messages | journal `TR`, journal inexistant, compte principal, compte d'un autre type, compte inexistant, journal modifié en cours, numéro de document déjà utilisé (Oui/Non) | messages attendus dans le log ; aucune écriture ; réponse ignorée de `numdoc_LostFocus` figée (SAISECRIT-A07) | `tests/refus_controles/` | à faire |
| SAISECRIT-T11 | replay | Raccourcis clavier | F1, F2 (journal, compte, libellé), F4, F5 (`FCalc`), F6, F8 (`Extrait`), `<` sur le compte, `<`, `D`, `C` dans `Montant` puis dans `Dateech` | fenêtres ouvertes, valeurs des champs ; raccourcis du montant actifs seulement depuis `Dateech` (SAISECRIT-A06 figée) | `tests/raccourcis/` | à faire |
| SAISECRIT-T12 | replay | Analytique | `/Soc01/Analytique = 1`, compte présent dans `Fiches_Analytiques` ; saisie de la ventilation analytique ; validation | fenêtre `Analytique` ouverte ; `Fiches_MvtA.validee = 1` après validation | `tests/analytique/` | à faire |
| SAISECRIT-T13 | replay | GED de l'écriture | `Button5` sur une écriture fournisseur (401 avec `tag_def`) puis client ; annulation | `Docs_Ged`/`Docs_Tag` : TTC, HT, date, étiquettes (comptes + `tag_def`) ; aucun document après annulation | `tests/ged_ecriture/` | à faire |
| SAISECRIT-T14 | replay | Largeurs de colonnes | `/Soc01/Col/LcolS` absent, puis `col1:90;col6:200;` ; redimensionnement puis fermeture avec et sans écriture en cours | largeurs appliquées (`col6` plafonnée à 80) ; valeur `LcolS` écrite dans la conf | `tests/largeurs_colonnes/` | à faire |
| SAISECRIT-T15 | replay | Base SQLite | scénario T01 sur `Laurux01.sqlite` | même dump que T01 (hors identifiants) ; aucune erreur SQL | `tests/achat_sqlite/` | à faire |
| SAISECRIT-T16 | gbtest | Fonctions pures extraites | `MontantTva` (4 branches × taux 0/5,5/20 × `montantht` nul ou non), `ControleDate`, `MontantsGed` (après SAISECRIT-006/008) | valeurs de référence capturées en appelant le code actuel dans le clone non modifié (via un harnais temporaire) | `tests/fonctions_pures/` | à faire |
| SAISECRIT-T17 | replay | Saisie concurrente (numérotation) | deux instances sur la même base, validation de la date au même instant | deux écritures de même numéro possibles (SAISECRIT-A01 figée) ; test non déterministe, exécuté à titre indicatif | `tests/numero_concurrent/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées en rejouant chaque scénario dans le clone **Laurux non modifié**
  (base MariaDB jetable restaurée depuis `Laurux01.sql` ou un jeu dérivé décrit dans
  `tests/<nom>/*.sql`) ; les anomalies SAISECRIT-A01 à A09 sont figées telles quelles.
- **Normalisation du dump** : `lind` (auto-incrément) conservé seulement si la base de départ est
  identique ; `datem` de `Fiches_MvtM` et horodatages GED masqués ; `control` (SHA1) comparé tel
  quel (dépend du contenu de l'écriture).
- **Date système** : les écritures sont saisies avec une date explicite ; `Datej_GotFocus` propose
  `Now` : les tests tournent sous `faketime` pour figer cette proposition.
- **Dialogues modaux** (`Message.Question`, `TriEcritures`, `TriCpt`, `Analytique`, `LGed`) :
  rejoués par `ReplayObserver` ; les handlers `Jour_Click`, `Vtl_Click`, `Libview_Click`,
  `Colabt_Click`, `Choix1_Click` sont appelés dynamiquement par le rejeu et doivent garder leur nom.
- **Non testable automatiquement** : sélecteur `DateChooser1` (jamais affiché, SAISECRIT-A04) ;
  concurrence réelle (T17 indicatif) ; impression de la documentation (`Doc.Open`, F1) vérifiée
  seulement par l'appel.
