# LTrans — Tests

> Source : `.src/Utils/LTrans.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LTRANS-T01 | gbtest | État initial | `New LTrans` | `List` Null, `Text` = "" | `tests/etat_initial/` | à faire |
| LTRANS-T02 | gbtest | Copie à l'écriture | `t.List = a` puis modification de `a` ; affectation d'un `String[]` | `t.List` inchangé ; conversion acceptée | `tests/copie_liste/` | à faire |
| LTRANS-T03 | gbtest | Auto-instance | `LTrans.List = ["1","2"]` puis lecture depuis un autre module | même contenu | `tests/auto_instance/` | à faire |
| LTRANS-T04 | replay | Règlement de bons de caisse | caisse (`./Laurux -p`) : bon de caisse → choix 2 « Régler des bons » → sélection de 2 BL dans `TriFacture` → validation ; table `Fiches_Bl` (`numtick`) | `numtick` positionné sur les 2 BL | `tests/replay_caisse_bons/` | à faire |
| LTRANS-T05 | replay | Suppression de tags en masse | GED (`GedR`) : 2 documents sélectionnés → Supprimer tags → annuler, puis valider un tag ; tables `Docs_Tag`, `Fiches_Tag` | annulation : aucune modification ; validation : tag retiré | `tests/replay_ged_tags/` | à faire |

## Détail des tests

- **Valeurs attendues** : gbtest exécutés dans le clone non modifié ; replays capturés dans le clone
  non modifié puis rejoués sur les deux clones (diff du dump des tables citées).
- **Données** : `Laurux01.sql` ; pour T04, un jeu dérivé avec deux BL non réglés d'un client de
  caisse ; pour T05, deux documents `Docs_Ged` partageant des tags.
- T04 et T05 valident le contrat « `List = Null` sans sélection » dont dépendent `GedR` et `LGed`.
