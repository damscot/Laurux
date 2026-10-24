# Mreglement — Tests

> Source : `.src/Gestion/Tables/Mreglement.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Le référentiel (`RegMode2CodeCaisse`, `CodeCaisse2RegMode`, `Laision_Reg`, tableaux) est testable
en `gbtest` via l'API `Public` ; l'écran est couvert par des `replay` avec diff de
`Fiches_Reglements`. Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MREGLEMENT-T01 | gbtest | `RegMode2CodeCaisse` | modes 0 à 10 | `Null`, `N`, `Q`, `U`, `V`, `X`, `Y`, `E`, `B`, `1`, `Null` | `tests/regmode_codecaisse/` | à faire |
| MREGLEMENT-T02 | gbtest | `CodeCaisse2RegMode` | `N`, `1`, `Z`, `""` | 1, 9, 0, 0 | `tests/codecaisse_regmode/` | à faire |
| MREGLEMENT-T03 | gbtest | `Laision_Reg` | base `Laurux01.sql` (caisse = 0 partout) puis ligne `caisse = 4` | `Null` puis `V` | `tests/liaison_reg/` | à faire |
| MREGLEMENT-T04 | replay | Création | Création ; `45`, `Mandat`, journal `50` ; Valider | INSERT | `tests/creation/` | à faire |
| MREGLEMENT-T05 | replay | Modification avec compte interne | clic `05` ; Modification ; interne coché, compte `580002` ; Valider | UPDATE | `tests/modification/` | à faire |
| MREGLEMENT-T06 | replay | Contrôles de validation | création sans journal ; puis compte `411000` interne | messages, `Rollback`, aucune écriture | `tests/controles/` | à faire |
| MREGLEMENT-T07 | replay | Liaison caisse déjà prise | `10` lié à « Carte » ; `05` → choisir « Carte » | message « Liaison déjà définie », combo remis à « Sans » | `tests/liaison_doublon/` | à faire |
| MREGLEMENT-T08 | replay | Suppression | clic `40` ; Suppression ; Valider | DELETE | `tests/suppression/` | à faire |
| MREGLEMENT-T09 | replay | Modification sans sélection | Modification sans ligne choisie ; Valider | erreur figée (A02) | `tests/modif_sans_selection/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` (9 modes de règlement, journaux `50`/`53`) ; jeu dérivé pour T03 et T07.
- **gbtest** : T01-T03 instancient le formulaire (membres d'instance) : nécessitent un affichage
  (Xvfb) tant que le référentiel n'est pas statique ; après MREGLEMENT-002, appel direct.
- **Comparaison** : dump normalisé de `Fiches_Reglements`.
- **Transactions** : vérifier dans T04-T09 que la connexion n'est plus en transaction à la fin du
  scénario (fermeture de fenêtre pendant une saisie, A01).
