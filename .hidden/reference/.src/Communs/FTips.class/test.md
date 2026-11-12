# FTips — Tests

> Source : `.src/Communs/FTips.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FTIPS-T01 | replay | Astuce au démarrage | `/Tips = 1`, `/LastTip = 3` | titre « Astuce du jour #4 » et texte de la 4ᵉ section | `tests/demarrage/` | implémenté (gbtest : fenêtre construite sans affichage, textes lus par Controls) |
| FTIPS-T02 | replay | Parcours circulaire | depuis `#24` : Suivant ; depuis `#1` : Précédent ; fermeture | `#1`, puis `#24` ; `/LastTip` dans la conf après fermeture | `tests/parcours/` | implémenté (gbtest) |
| FTIPS-T03 | replay | Case « afficher au démarrage » | décocher, fermer, relancer | `/Tips = False`, pas d'astuce au relancement | `tests/case_tips/` | implémenté (gbtest, partiel : `/Tips` et case relue ; le non-affichage au relancement (Start.Lancement) n'est pas vérifié) |
| FTIPS-T04 | replay | `/LastTip` hors bornes | `/LastTip = 30`, Précédent | message d'erreur figé (A02) | `tests/hors_bornes/` | implémenté (gbtest) : aucun message, comportement figé (voir Détail) |
| FTIPS-T05 | gbtest | `IndiceSuivant` / `TexteAstuce` (après FTIPS-003) | indices 0, 1, 24, 30 × sens ; contenu `tips.fr` | indice et texte attendus | `tests/indices/` | à faire : exige l'extraction FTIPS-003 (`IndiceSuivant`/`TexteAstuce` absents) |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié avec le `tips/tips.fr` du dépôt.
- **Non testable automatiquement** : l'absence du fichier `tips/tips.fr` (A01) bloque le démarrage,
  test manuel ; rendu HTML et mise en page (`Form_Resize`).
- **Implémentation (phase 2)** : `.src/Tests/Communs/FTipsTest.test` (valeurs : `assets/FTipsTest/`). La
  configuration de test ne peut pas être surchargée par scénario : `/Tips` et `/LastTip` sont posés en mémoire,
  la fenêtre est construite sans affichage, les boutons actionnés par leurs gestionnaires publics.
- **FTIPS-T04 / A02** : avec `/LastTip = 30`, `_new` appelle `ShowNextTip` (sens avant) qui ramène l'indice à 1
  (`$iTip >= Count`) ; « Précédent » donne alors #24, sans erreur. A02 (indice hors bornes en reculant) est
  inatteignable par l'interface : l'indice est toujours dans 1…24 après `_new`. Comportement figé (Check).
