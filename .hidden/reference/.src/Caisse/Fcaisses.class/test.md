# Fcaisses — Tests

> Source : `.src/Caisse/Fcaisses.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI de table : tests `replay` depuis le menu Gestion › Tables › Caisses (`Fmenu.Menu205`).
`Utils.Observers(Me)` est appelé une seule fois dans `_New` : rejouable. Les clics dans la liste
`Caisse` sont rejouables (`Caisse_Click` existe) ; la grille `tvalist2` est invisible
(`replay_missing` sans objet). Comparaison : dump de `Fiches_Caisses`, messages.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCAISSES-T01 | replay | Création d'une caisse | code `4`, libellé, `Défaut80`, Monoposte, poste = hôte ; « Enregistrer » | ligne insérée (`fndtotp = fndtotg = 0`, `ecole = 0`) | `tests/creation/` | implémenté (scénario `fcaisses_creation` : type Réseau et poste vide, car le focus sur Poste y écrit `System.Host`, variable selon l'hôte de test) |
| FCAISSES-T02 | replay | Modification et saisie | clic sur la caisse `1`, imprimante `/dev/ttyS0` + `Tmu950`, puis `/dev/ttyUSB0` ; touches non numériques dans le code | ligne mise à jour ; `typeimp` conservé pour USB (A05 du type imp. figée) ; touches refusées | `tests/modification/` | implémenté partiellement (gb.test `FcaissesTest.T02Modification` : `/dev/ttyS0` + `Tmu950` puis `/dev/ttyUSB0`, `typeimp` conservé) ; touches non numériques dans le code (`Cais_KeyPress` lit `Key`) non couvertes |
| FCAISSES-T03 | replay | Contrôles Monoposte/Réseau | Monoposte + poste différent ; Réseau + poste du serveur ; via clic et via touche sur « Enregistrer » | messages via clic ; via touche : enregistrement sans contrôle (A03 figée) | `tests/controle_type_poste/` | à faire : les contrôles passent par `Message.Error` (bloquant en gb.test) ; le poste du serveur (`System.Host`) varie selon l'hôte de test |
| FCAISSES-T04 | replay | Dépôt | `/Soc01/Depots` = 1, dépôt `02` puis dépôt de code long `DEP003` | liste sans `01` ; `depot = "02"` puis `"DE"` (A04 figée) | `tests/depot/` | implémenté (gb.test `FcaissesTest.T04Depot` : liste sans `01`, dépôt `02` puis `DEP003` → `DE`, A04 figée) |
| FCAISSES-T05 | replay | Suppression refusée | caisse `1` connectée ; caisse `2` avec `tkz = 0` | deux messages, base inchangée | `tests/suppression_refusee/` | à faire : messages `Message.Error` (bloquant en gb.test) ; à écrire en scénario |
| FCAISSES-T06 | replay | Suppression acceptée et cible | caisse `2` avec `tkz = 1` et tickets ; code `2` saisi mais caisse `1` sélectionnée dans la liste | figer : suppression de la ligne sélectionnée malgré les tickets (A01, A02) | `tests/suppression_cible/` | à faire : `Message.Question` puis `Message.Delete` (bloquant en gb.test) ; à écrire en scénario |
| FCAISSES-T07 | replay | Échap dans la liste | Échap sur la liste puis enregistrement | liste masquée jusqu'à la réouverture (A05 figée) | `tests/echap_liste/` | à faire : Échap non rejouable |

## Détail des tests

- **gb.test (phase 2, vague 6)** : module `.src/Tests/Caisse/FcaissesTest.test` (fenêtre instanciée sans affichage,
  `Form_Open` appelé à la main), jeu `.hidden/Tests/Caisse/assets/fcaisses_shared/caisses_base.sql` (2 caisses au poste
  fixe `postetest`, dépôt `DEP003`, gestion des caisses activée par le blob conf).

- **Valeurs attendues** : capturées dans le clone Laurux **non modifié** ; le dump normalisé de
  `Fiches_Caisses` fait foi (`lind` masqué).
- **Données** : `Laurux01.sql` (dépôts `01` et `02`) + jeu dérivé `caisse_base` ; T04 ajoute un
  dépôt `DEP003` ; T06 ajoute des tickets `Fiches_EntTicketz` sur la caisse `2`.
- **Non testable automatiquement** : aide HTML (`Button4`), sons.
- T03, T04, T06 et T07 caractérisent des anomalies ; ils seront mis à jour avec leur correction.
- **Phase 2, vague 5** : `fcaisses_creation` (jeu `fclientcarte_shared/cartes_base` pour la visibilité du menu Caisse).
  Les contrôles Monoposte/poste dépendent de `System.Host` (nom du conteneur de test) : à figer avec un poste saisi
  après effacement du nom d'hôte, longueur inconnue d'avance.
