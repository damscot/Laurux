# Fcaisses — Tests

> Source : `.src/Caisse/Fcaisses.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI de table : tests `replay` depuis le menu Gestion › Tables › Caisses (`Fmenu.Menu205`).
`Utils.Observers(Me)` est appelé une seule fois dans `_New` : rejouable. Les clics dans la liste
`Caisse` sont rejouables (`Caisse_Click` existe) ; la grille `tvalist2` est invisible
(`replay_missing` sans objet). Comparaison : dump de `Fiches_Caisses`, messages.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCAISSES-T01 | replay | Création d'une caisse | code `4`, libellé, `Défaut80`, Monoposte, poste = hôte ; « Enregistrer » | ligne insérée (`fndtotp = fndtotg = 0`, `ecole = 0`) | `tests/creation/` | à faire |
| FCAISSES-T02 | replay | Modification et saisie | clic sur la caisse `1`, imprimante `/dev/ttyS0` + `Tmu950`, puis `/dev/ttyUSB0` ; touches non numériques dans le code | ligne mise à jour ; `typeimp` conservé pour USB (A05 du type imp. figée) ; touches refusées | `tests/modification/` | à faire |
| FCAISSES-T03 | replay | Contrôles Monoposte/Réseau | Monoposte + poste différent ; Réseau + poste du serveur ; via clic et via touche sur « Enregistrer » | messages via clic ; via touche : enregistrement sans contrôle (A03 figée) | `tests/controle_type_poste/` | à faire |
| FCAISSES-T04 | replay | Dépôt | `/Soc01/Depots` = 1, dépôt `02` puis dépôt de code long `DEP003` | liste sans `01` ; `depot = "02"` puis `"DE"` (A04 figée) | `tests/depot/` | à faire |
| FCAISSES-T05 | replay | Suppression refusée | caisse `1` connectée ; caisse `2` avec `tkz = 0` | deux messages, base inchangée | `tests/suppression_refusee/` | à faire |
| FCAISSES-T06 | replay | Suppression acceptée et cible | caisse `2` avec `tkz = 1` et tickets ; code `2` saisi mais caisse `1` sélectionnée dans la liste | figer : suppression de la ligne sélectionnée malgré les tickets (A01, A02) | `tests/suppression_cible/` | à faire |
| FCAISSES-T07 | replay | Échap dans la liste | Échap sur la liste puis enregistrement | liste masquée jusqu'à la réouverture (A05 figée) | `tests/echap_liste/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié** ; le dump normalisé de
  `Fiches_Caisses` fait foi (`lind` masqué).
- **Données** : `Laurux01.sql` (dépôts `01` et `02`) + jeu dérivé `caisse_base` ; T04 ajoute un
  dépôt `DEP003` ; T06 ajoute des tickets `Fiches_EntTicketz` sur la caisse `2`.
- **Non testable automatiquement** : aide HTML (`Button4`), sons.
- T03, T04, T06 et T07 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
