# FEditrel — Tests

> Source : `.src/Compta/Relances/FEditrel.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : tests `replay` lancés depuis le menu Relances › Préparation des relances. Données :
`Laurux01.sql` + jeu dérivé `relances.sql` (clients 411 avec écritures non lettrées échues et non
échues, niveaux de relance 0 à 3, une écriture sans `numdoc`, un client sans fiche `Fiches_Cli`).
Comparaisons : dump de `Fiches_relances` et de `Fiches_Mvt` (colonne `relance`), texte du PDF.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FEDITREL-T01 | replay | Ouverture sans table de travail | base sans `Fiches_relances` | écran vide, aucune erreur | `tests/ouverture_vide/` | implémenté |
| FEDITREL-T02 | replay | Génération | date du jour, Générer | dump `Fiches_relances` (niveaux 1-3, écritures non échues exclues, `numdoc` de repli) | `tests/generation/` | implémenté (liste non réaffichée après génération : candidat anomalie, voir Détail) |
| FEDITREL-T03 | replay | Génération sans écriture / date vide | base sans écriture 411 ; date effacée | comportement actuel figé (erreur `prgb.Close`, A01) | `tests/generation_vide/` | implémenté (code_sortie 125 : prgb.Close sur objet nul, A01 ; variante date effacée non rejouée) |
| FEDITREL-T04 | replay | Navigation et tri | flèches, clic, tri par code puis par nom (2 sens) | ordre des lignes et extrait affiché | `tests/navigation_tri/` | implémenté (gb.test `FEditrelTest.T04NavigationTri` : ordre de `ScrollView1.Children` (numero, lib) après `Buttontrnom_Click`/`Buttontrn_Click` ×2 ; flèches remplacées par `lig_Down`/`Lig_up`, sans erreur ; jeu à 2 clients : ordre par nom et par code confondus ; l'extrait affiché n'est pas relu) |
| FEDITREL-T05 | replay | Sélection globale | décocher puis recocher « Tout sélectionner » ; `CheckBox2` | dump `Fiches_relances` après chaque étape | `tests/selection/` | implémenté (jeu feditrel_relances_prete) |
| FEDITREL-T06 | replay | Édition groupée | 3 clients sélectionnés (lettre 1, lettre 3, relevé), un non imprimé | texte PDF ; `Fiches_Mvt.relance` mis à jour pour les clients édités | `tests/edition_groupee/` | implémenté (Fiches_Mvt.relance ; texte PDF non comparé ; 1 dépassement de délai sur 4 rejeux observé sous charge) |
| FEDITREL-T07 | replay | Édition après édition individuelle | `Ligcli.Buttonedit` sur un client, puis édition groupée | client déjà traité exclu du PDF groupé | `tests/edition_traitement/` | implémenté (gb.test `FEditrelTest.T07EditionApresIndividuelle` : `Buttonedit_Click` du 1er `Ligcli` (411001 : relance F401 → 1, marqué traité), puis `FEditrel.Buttonedit_Click` : seul 411002 relancé (F403 2 → 3), 411001 exclu ; PDF non lu, CmdVis neutralisé) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié ; texte PDF extrait par
  `pdftotext -layout`, date du jour masquée.
- T03 fige l'anomalie A01 et T05 le comportement réel de la propriété `selection` (suppression
  possible de lignes de `Fiches_relances`).
- Non testable automatiquement : rendu visuel (couleurs, icônes de tri).
- **Assets (phase 2)** : jeux `.hidden/Tests/Compta/assets/feditrel_shared/feditrel_relances.sql` (écritures 411 échues/non échues, niveaux 0-3, sans numdoc, client sans fiche) et `feditrel_relances_prete.sql` (même jeu + `Fiches_relances` déjà générée) ; scénarios `feditrel_ouverture_vide/` (T01), `feditrel_generation/` (T02), `feditrel_generation_vide/` (T03), `feditrel_selection/` (T05), `feditrel_edition_groupee/` (T06, `@ouvrir.trace`).
- **Observé dans ref** : (1) si `Fiches_relances` n'existe pas au lancement, la génération remplit la table mais `affiche()` ne montre rien (`Utils.db.Tables.Exist` en cache) et Éditer plante ensuite (`FEditrel.Impressionr.519 : Out of bounds`) ; (2) T06 : l'écriture sans numdoc n'est pas marquée relancée (`UPdate … numdoc = NULL`) ; (3) T05 : après décochage/recochage, les lignes de 411002 réapparaissent dans `Fiches_relances` avec un niveau modifié (403 : 3 → 2).
