# SaiTableau — Tests

> Source : `.src/Utils/SaiTableau.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Composant graphique sans SQL. Deux niveaux : des tests **gbtest sous affichage virtuel** (Xvfb, à
confirmer en début de phase 2 : gb.test doit pouvoir charger `gb.qt5`/`gb.gtk3`) qui instancient
la grille dans une `Window` non affichée et vérifient l'état (`ligne.Count`, `Ind`, `Background`,
ordre) ; et des **replays** des écrans qui l'utilisent (Achat, GesTar, Parametre).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| SAITABLEAU-T01 | gbtest | Construction + `show` | 3 `ObjProp` (TextReg, TextBox, Label), drapeaux `Visible*` à True/False | contrôles créés (`pchoix`, `tuto`, `entete`, `total` présents ou `Null`) | `tests/construction/` | à faire |
| SAITABLEAU-T02 | gbtest | `ajout` / énumération | 4 `ajout()` | `Count = 4`, `Ind` 0..3, fonds alternés, événement `ajou` levé 4 fois | `tests/ajout/` | à faire |
| SAITABLEAU-T03 | gbtest | `Netoyage` / `Extract` | 5 lignes dont 2 vides sur « Code » | 3 lignes, `Ind` renumérotés ; figer les couleurs non recalculées | `tests/netoyage/` | à faire |
| SAITABLEAU-T04 | gbtest | `ligne_Haut` / `ligne_Bas` | 3 lignes, déplacement de la 2ᵉ | ordre et couleurs attendus | `tests/deplacement/` | à faire |
| SAITABLEAU-T05 | gbtest | `ligne_InsLig` en lecture | `etat = lecture` | figer la création du panneau orphelin (A01) | `tests/insertion_lecture/` | à faire |
| SAITABLEAU-T06 | gbtest | `Delete` | 3 lignes puis `Delete` | `Count = 0`, `ind = -1`, nouveau `Tableau` | `tests/delete/` | à faire |
| SAITABLEAU-T07 | replay | Saisie d'un achat | écran Achat : 3 lignes, Ins, Suppr, Alt+↑/↓, validation | dump `Fiches_Entrecpt`/`Fiches_Ligrecpt` et log identiques | `tests/replay_achat/` | à faire |
| SAITABLEAU-T08 | replay | Tarifs | écran GesTar : ajout/suppression de lignes de tarif, sauvegarde | dump `Fiches_Tarcli`/`Fiches_TarTypcli` | `tests/replay_gestar/` | à faire |

## Détail des tests

- **Valeurs attendues** : générées en exécutant les mêmes appels dans le clone **Laurux non
  modifié** (sortie `id;valeur` dans `expected/`).
- **Données** : aucune base pour T01-T06 ; `Laurux01.sql` + jeu dérivé (fournisseur, 3 articles)
  pour T07-T08.
- **Non testable** : `ligne_SupLig` demande une confirmation `Message.Question` (couvert seulement par
  replay) ; le rendu visuel (couleurs réellement affichées, défilement).
