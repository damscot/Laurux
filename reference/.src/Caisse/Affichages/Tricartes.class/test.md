# Tricartes — Tests

> Source : `.src/Caisse/Affichages/Tricartes.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Liste de sélection ouverte depuis la caisse : scénarios `replay` capturés dans le clone **Laurux non
modifié**, lancé en mode caisse (`./Laurux -p`) avec une caisse connectée (`Fiches_Caisses` du poste,
vendeur). Base `Laurux01.sql` + jeu dérivé `cartes_base` (commun avec FClientcarte et
EmailingCarte), complété pour la pagination : ≥ 3 pages de cartes `divers = 0` et quelques fiches
`divers = -1`. Comparaison : dump normalisé (ticket validé : `Fiches_EntTicketz.carte`/`points`,
`Fiches_Carte`) et lignes `Exec_SQL` (requêtes `LIMIT`) à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| TRICARTES-T01 | replay | Sélection d'une carte de fidélité | caisse : F8, clic sur une carte, vente d'un article, validation du ticket | carte reprise par `RecupCarte` ; ticket enregistré avec la carte et les points | `tests/selection_fidelite/` | à faire |
| TRICARTES-T02 | replay | Filtre et tri | F8, saisie `DU` dans `N1`, Retour arrière, flèches droite/gauche (changement de colonne), double-clic sur un en-tête | contenu de la grille et requêtes de référence ; pas de saisie de `"`/`&` (bloqués) | `tests/filtre_tri/` | à faire |
| TRICARTES-T03 | replay | Pagination | F8, PageDown ×2, PageUp, molette, boutons `Descendre`/`Remonter`, flèche bas en dernière ligne | `LIMIT` successifs de référence ; retour à 0 sans valeur négative | `tests/pagination/` | à faire |
| TRICARTES-T04 | replay | Clients divers (Ctrl+N) | caisse : Ctrl+N, clic sur une fiche `divers = -1` | figer : liste des seules fiches `-1`, **aucune reprise** du client (A01) | `tests/clients_divers/` | à faire |
| TRICARTES-T05 | replay | Gestion des cartes (F4) | F8, F4 dans `N1`, création d'une carte dans `FClientcarte`, fermeture | nouvelle carte visible dans la liste rechargée ; `Fiches_Carte` comme FCLIENTCARTE-T01 | `tests/f4_gestion/` | à faire |
| TRICARTES-T06 | replay | Fermeture sans choix | F8 puis Échap ; F8 puis F2 ; en mode tactile, bouton `Fermer` | aucune carte reprise (`Bsel` de la caisse à `False`) | `tests/fermeture/` | à faire |
| TRICARTES-T07 | gbtest | `RequeteCartes` (après TRICARTES-006) | tri `nom`/`code`, filtre vide ou `DU`, divers 0 / -1, sens, page 0 et 2 | texte SQL identique à celui journalisé par le clone non modifié | `tests/requete_cartes/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone non modifié ; A01 et A02 sont figées.
- **Rejeu** : `_new` appelle `Utils.Observers(Me)` (écran rejouable) ; `colcli_Click` est rejoué par
  `Object.Call` (doit rester `Public`). Pas de `replay_missing`.
- **Pagination** : `lg` dépend de la hauteur de la grille donc de la résolution et des polices ;
  fixer la géométrie (`QT_SCALE_FACTOR`, thème, police) entre capture et rejeu, sinon les `LIMIT`
  diffèrent.
- **Molette** : `Mouse.Delta` est rejoué par `ReplayObserver` (vérifier en phase 2 que la valeur `-1`
  est reproduite à l'identique).
- **Caisse** : les scénarios dépendent du lot Caisse (ouverture de caisse, vendeur) ; les mutualiser
  avec les scénarios de `Caisse` validés par l'utilisateur (module complexe, PLAN.md §4.5).
