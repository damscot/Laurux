# ValidBR — Tests

> Source : `.src/Gestion/Stock/ValidBR.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

**Module complexe, écran inaccessible** : Décision utilisateur du 2026-11-18 : hors des 10 classes à revue manuelle, tests implémentés sans validation individuelle (la décision sur VALIDBR-A01, suppression du couple
`.class`/`.form`, reste à prendre). Aucun menu ni écran n'ouvre `ValidBR` : un replay depuis l'interface est
impossible en l'état. Si l'écran est conservé, il faudrait l'ouvrir par le harnais (instanciation
directe du formulaire) ; les valeurs attendues seraient produites dans le clone **Laurux non
modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| VALIDBR-T01 | replay | Inaccessibilité (constat) | parcours des menus Gestion › Stock | aucun accès à `ValidBR` ; le menu ouvre `ValidBR1` | `tests/validbr_inaccessible/` | à faire : constat d'absence de point d'entrée (aucun appel de `ValidBR` hors de `Edbr`, menu Gestion › Stock → `ValidBR1.ShowModal`) ; un rejeu qui finit sur `ValidBR1` bute sur la fermeture d'un écran `ShowModal` (REPLAYOBSERVER-A15) |
| VALIDBR-T02 | replay | Traitement et visualisation (si conservé) | ouverture par le harnais, « Pour un fournisseur », Traitement, Visualiser | tables de travail `BRfm`/`Br`, PDF `Edbr` ; aucune BR validée | `tests/validbr_visu/` | implémenté (gb.test `ValidBRTest.T02TraitementVisualisation` : écran instancié par le test ; listes et tables `BRfm`/`Br` relues ; `Gen_ecr(0)` s'arrête sur « Type mismatch: wanted Number, got Null » (`Val()` d'un décimal lu en base, `Gen_ecr` l. 661), figé : ni PDF `Edbr`, ni fichier dans `~/BR`) |
| VALIDBR-T03 | replay | Clôture + compta (si conservé) | même jeu, « Cloture + Compta » | `validee`, `Fiches_Mvt`, soldes, `numecriture*` | `tests/validbr_compta/` | implémenté (gb.test `T03ClotureCompta` : même arrêt que T02 dans `Gen_ecr(2)` avant toute validation ; aucune BR validée, aucune écriture, figé) |

## Détail des tests

- **Recommandation** : valider VALIDBR-A01 (suppression) ; T01 suffit alors à documenter le
  constat et T02/T03 sont abandonnés.
- **Données** (si conservé) : jeu `receptions.sql` de [ValidBR1](../ValidBR1.class/test.md).
- **Implémentation (vague 9)** : module `.src/Tests/Gestion/ValidBRTest.test`, jeu `.hidden/Tests/Gestion/assets/validbr_shared/receptions.sql` (copie de `validbr1_shared/receptions.sql` + compte d'achat pour toutes les familles : sans lui, `Button1_Click` refuse le traitement, « La famille 10 n'a pas de compte d'achat »). Les tables `BRfm`/`Br` sont créées par `recup_bl` ; `Gen_ecr` lit `Colbl.Item` (curseur remis sur le premier fournisseur après la lecture de la liste).
- **Non testable** : rien de plus sans point d'entrée dans l'interface.
