# facopt — Tests

> Source : `.src/Gestion/option/facopt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`facopt` construit ses contrôles dans les panneaux de `Facture` : tous les tests sont des
`replay` enregistrés depuis l'écran de facturation avec l'option boisson (`/Soc01/bois = 1`).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FACOPT-T01 | replay | Consignes d'une ligne (`majlig`) | BL : article consigné P/C/B, client consigné puis non consigné | `Fiches_ligcons` (dump), grille et total | `tests/consignes_ligne/` | à faire |
| FACOPT-T02 | replay | Saisie de déconsignes (`valide`) | codes P/C/B saisis et par recherche (`Rechcons`), article (`textart`, `TriArticles`), quantités calculées | `Fiches_ligcons` `numlig D` ; recalcul de fin de facture | `tests/saisie_deconsignes/` | à faire |
| FACOPT-T03 | replay | Déconsigne par la grille des consignes | sélection d'une puis de plusieurs lignes non contiguës (A02) | lignes créées (dump) | `tests/deconsigne_grille/` | à faire |
| FACOPT-T04 | replay | Modification / suppression de déconsigne | Entrée puis abandon (A03) ; Suppr ; facture imprimée (A01) | `Fiches_ligcons` (dump) | `tests/modif_deconsigne/` | à faire |
| FACOPT-T05 | replay | `deplig` / `suplig` | déplacement d'une ligne consignée ; suppression | `numlig` des consignes | `tests/deplacement_ligne/` | à faire |
| FACOPT-T06 | replay | `copdecons` | facture avec déconsignes passée en avoir | déconsignes inversées sur le nouveau BL | `tests/avoir_deconsignes/` | à faire |
| FACOPT-T07 | replay | `affdroit` | BL non édité (régie suspendue, acquittée, `drfac`) ; facture éditée (`Fiches_ligregie`) | contenu de la grille régie et totaux (capturés par log) | `tests/affichage_regie/` | à faire |
| FACOPT-T08 | replay | Saisies invalides | code consigne inconnu, article inexistant / sans consigne, quantité non numérique (A05) | bulles, zones vidées ; aucune ligne créée | `tests/saisies_invalides/` | à faire |

## Détail des tests

- **Données** : jeu `facturation_boisson` (voir [ObjFacB/test.md](../ObjFacB.class/test.md)).
- **Valeurs attendues** : capturées dans le clone Laurux **non modifié** ; le dump de
  `Fiches_ligcons` fait foi (colonne auto-incrémentée `code` masquée dans le dump normalisé).
- **Rejeu** : `Utils.Observers(Me)` est commenté dans `facopt` ; vérifier en début de phase 2 que
  les contrôles créés par code (zones, boutons, grilles sans nom de `.form`) sont rejouables. Les
  grilles `gridcons`/`gridsaisie`/`gridregi` n'ont pas de `_Click` : éviter les clics simples
  rejoués sur ces grilles ou traiter REPLAYOBSERVER-A06.
- **Non testable en gbtest** : la classe exige des panneaux GUI ; `verifnb` est `Private`.
