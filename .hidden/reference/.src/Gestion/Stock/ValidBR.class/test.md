# ValidBR — Tests

> Source : `.src/Gestion/Stock/ValidBR.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Module complexe, écran inaccessible** : **la liste ci-dessous est à faire valider par
l'utilisateur avant la phase 2**, après décision sur VALIDBR-A01 (suppression du couple
`.class`/`.form`). Aucun menu ni écran n'ouvre `ValidBR` : un replay depuis l'interface est
impossible en l'état. Si l'écran est conservé, il faudrait l'ouvrir par le harnais (instanciation
directe du formulaire) ; les valeurs attendues seraient produites dans le clone **Laurux non
modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDBR-T01 | replay | Inaccessibilité (constat) | parcours des menus Gestion › Stock | aucun accès à `ValidBR` ; le menu ouvre `ValidBR1` | `tests/validbr_inaccessible/` | à faire |
| VALIDBR-T02 | replay | Traitement et visualisation (si conservé) | ouverture par le harnais, « Pour un fournisseur », Traitement, Visualiser | tables de travail `BRfm`/`Br`, PDF `Edbr` ; aucune BR validée | `tests/validbr_visu/` | à faire |
| VALIDBR-T03 | replay | Clôture + compta (si conservé) | même jeu, « Cloture + Compta » | `validee`, `Fiches_Mvt`, soldes, `numecriture*` | `tests/validbr_compta/` | à faire |

## Détail des tests

- **Recommandation** : valider VALIDBR-A01 (suppression) ; T01 suffit alors à documenter le
  constat et T02/T03 sont abandonnés.
- **Données** (si conservé) : jeu `receptions.sql` de [ValidBR1](../ValidBR1.class/test.md).
- **Non testable** : rien de plus sans point d'entrée dans l'interface.
