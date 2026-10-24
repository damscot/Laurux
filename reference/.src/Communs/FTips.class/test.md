# FTips — Tests

> Source : `.src/Communs/FTips.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FTIPS-T01 | replay | Astuce au démarrage | `/Tips = 1`, `/LastTip = 3` | titre « Astuce du jour #4 » et texte de la 4ᵉ section | `tests/demarrage/` | à faire |
| FTIPS-T02 | replay | Parcours circulaire | depuis `#24` : Suivant ; depuis `#1` : Précédent ; fermeture | `#1`, puis `#24` ; `/LastTip` dans la conf après fermeture | `tests/parcours/` | à faire |
| FTIPS-T03 | replay | Case « afficher au démarrage » | décocher, fermer, relancer | `/Tips = False`, pas d'astuce au relancement | `tests/case_tips/` | à faire |
| FTIPS-T04 | replay | `/LastTip` hors bornes | `/LastTip = 30`, Précédent | message d'erreur figé (A02) | `tests/hors_bornes/` | à faire |
| FTIPS-T05 | gbtest | `IndiceSuivant` / `TexteAstuce` (après FTIPS-003) | indices 0, 1, 24, 30 × sens ; contenu `tips.fr` | indice et texte attendus | `tests/indices/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié avec le `tips/tips.fr` du dépôt.
- **Non testable automatiquement** : l'absence du fichier `tips/tips.fr` (A01) bloque le démarrage,
  test manuel ; rendu HTML et mise en page (`Form_Resize`).
