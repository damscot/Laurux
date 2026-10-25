# Mvtex — Tests

> Source : `.src/Gestion/Stock/Mvtex.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`replay` avec diff de `Fiches_Mvtexp`, `Fiches_Art` (`art_qte`), `Fiches_ligregie` et
`Fiches_Parametres` (`nvign`). L'écran appelle `Utils.Observers` (instrumenté). Les tests figent
le comportement actuel ; valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MVTEX-T01 | replay | Entrée simple | date fixée, « Entrée », article stocké A1, qté 3, commentaire ; Enregistrer ; Valider la saisie | 1 ligne `Fiches_Mvtexp` (`qtep` 3, `qtem` vide) ; `art_qte` +3 ; PDF `~/tmp/mvtex.pdf` (texte) | `tests/mvtex_entree/` | à faire |
| MVTEX-T02 | replay | Sortie de plusieurs articles | « Sortie », A1 qté 2, A2 qté 1,5 (décimales) ; Valider | 2 lignes `qtem` ; `art_qte` décrémentés | `tests/mvtex_sortie/` | à faire |
| MVTEX-T03 | replay | Cumul et remplacement | A1 entrée 2, A1 sortie 5 → « 1 » (cumul) ; A2 entrée 1, A2 entrée 4 → « 2 » (remplacer) ; Valider | grille puis base : A1 sortie 3, A2 entrée 4 | `tests/mvtex_cumul/` | à faire |
| MVTEX-T04 | replay | Rappel et suppression de ligne | 3 lignes ; Entrée sur la 2e (rappel), qté modifiée, Enregistrer ; Suppr sur la 3e ; Valider | 2 mouvements en base | `tests/mvtex_rappel/` | à faire |
| MVTEX-T05 | replay | Fermeture avec saisie en cours | 1 ligne ; Quitter ; « Oui » | mouvement enregistré | `tests/mvtex_fermeture/` | à faire |
| MVTEX-T06 | replay | Article non stocké / inexistant / code-barre | `Cart` = article non stocké, code inconnu, `*<code-barre>` | messages ; aucune ligne pour les deux premiers ; article trouvé pour le code-barre | `tests/mvtex_article/` | à faire |
| MVTEX-T07 | replay | Option boissons : droits et vignette | base option `B`, article avec `art_dra` (régie `suspendu`), sortie 6 | `Fiches_ligregie` (num, volumes, droits, vignette), `nvign` +1, colonnes volume/degré du PDF | `tests/mvtex_regie/` | à faire |
| MVTEX-T08 | replay | Période de droits close | option `B`, date dans une période close (`VerifDate.ClotDroi`) | ligne refusée, rien en base | `tests/mvtex_droits_clos/` | à faire |
| MVTEX-T09 | replay | Raccourcis F1/F2 | F2 dans `Cart`, F1 | rien ne se passe (A01 figée) | `tests/mvtex_raccourcis/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` + jeu dérivé `stock_mvtex.sql` (articles stockés A1/A2 avec
  `art_dec`, un article non stocké, un code-barre) ; base `B` dérivée pour T07/T08 (régie,
  `Fiches_Parametres.nvign`, période de droits close).
- **Horloge** : `Datej` vaut `Now` par défaut : la date est saisie explicitement dans les
  scénarios ; le PDF est comparé hors pied de page.
- **Grille** : `Colrcp` n'a pas de `Colrcp_Click` (REPLAYOBSERVER-A06) ; les scénarios utilisent
  Entrée/double-clic (`Activate`) et le clavier.
- **Comparaison** : dump normalisé des tables (`mind` auto-incrément masqué, ordre par code).
- **Non testable automatiquement** : visualiseur PDF (fichier comparé à la place), son.
- **gbtest** : après MVTEX-004, `EnregistreMouvements` pourra être testé en gb.test sur la base
  Docker (sans formulaire).
