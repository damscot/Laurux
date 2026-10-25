# FClientcarte — Tests

> Source : `.src/Caisse/FClientcarte.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Écran GUI : scénarios `replay` capturés dans le clone **Laurux non modifié** (`./Laurux -l
--logfile …`) et rejoués sur les deux clones. Ouverture par Fmenu › Carte de fidélité ›
Table des cartes (`Menu238`). Base `Laurux01.sql` + jeu dérivé `cartes_base` (commun avec EmailingCarte et
Tricartes) : ~8 cartes `Fiches_Carte` (codes `000001`…, une avec `divers = -1`, une avec
code-barres déjà attribué), tickets `Fiches_HisEntTickets`/`Fiches_HisLigTickets` rattachés à deux
cartes (dont un `suppr = 1`), quelques `Fiches_Cpostaux`. Comparaison : dump normalisé de
`Fiches_Carte` et `Fiches_Cpostaux` (dates du jour masquées), lignes `Exec_SQL` à titre informatif.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FCLIENTCARTE-T01 | replay | Création | Créer, nom/prénom/adresse/CP/ville/téléphones, points `1,50`/`10`, Enregistrer | ligne `Fiches_Carte` (code = dernier + 1, `cb = 299999…` + clé, fin +20 ans, `tp1` tronqué : A03 figée), couple CP ajouté à `Fiches_Cpostaux` | `tests/creation/` | à faire |
| FCLIENTCARTE-T02 | replay | Modification | clic sur une carte, téléphone domicile `01…` et bureau `02…`, Enregistrer | `Fiches_Carte` mise à jour avec téléphones **inversés** (A01 figée), points via `cpoint` | `tests/modification/` | à faire |
| FCLIENTCARTE-T03 | replay | Suppression | clic sur une carte avec historique, Supprimer, « Oui » puis une autre avec « Non » | 1 ligne supprimée, tickets inchangés (A07), aucune suppression sur « Non » | `tests/suppression/` | à faire |
| FCLIENTCARTE-T04 | replay | Contrôle du code-barres | `CB` : 7 caractères ; 13 caractères clé fausse ; code d'une autre carte ; `*` + code valide | messages de longueur / de clé / bulle « déjà attribué », focus rendu ; `*` retiré | `tests/code_barre/` | à faire |
| FCLIENTCARTE-T05 | replay | Dates | boutons date d'émission et de fin, choix dans `DateChooser1` | `datec`/`datef` enregistrées après Enregistrer | `tests/dates/` | à faire |
| FCLIENTCARTE-T06 | replay | Liste : tri et filtre | focus sur chaque en-tête, saisie `DU`, Retour arrière, double-clic (tri inverse) | contenu de la liste (ordre) et requêtes `Exec_SQL` de référence ; pas de saisie de `"` (A05) | `tests/liste_tri_filtre/` | à faire |
| FCLIENTCARTE-T07 | replay | Code postal | Entrée dans le code postal (`Cpman`) puis choix d'un CP ; bouton `ToggleButton5` puis choix | figer : CP non repris (A02), erreur « Unknown symbol » au second chemin (capturée dans le log) | `tests/code_postal/` | à faire |
| FCLIENTCARTE-T08 | replay | Historique | carte avec tickets : cocher « Historique des ventes » puis « Historique des points » | lignes affichées (log `Exec_SQL`, N+1 requêtes), cumul de points ; ticket `suppr = 1` absent ; aucun clic dans `Histo` | `tests/historique/` | à faire |
| FCLIENTCARTE-T09 | replay | Navigation clavier | Entrée sur chaque zone du groupe `Cmpt`, Entrée sur le nom sans code | ordre de focus de référence, message « cliquer sur Créer » | `tests/navigation/` | à faire |
| FCLIENTCARTE-T10 | gbtest | Code-barres interne (après FCLIENTCARTE-010) | codes `000001`, `123456`, `999999` | `299999` + code + clé `Utils.Calcode` (valeurs du clone non modifié) | `tests/code_barre_calc/` | à faire |

## Détail des tests

- **Valeurs attendues** : capturées dans le clone Laurux non modifié, jamais déduites du code ; les
  anomalies A01 à A05 sont figées telles quelles (tests de caractérisation).
- **Rejeu** : `_New` appelle `Utils.Observers(Me)` une fois (écran rejouable). `colcli_Click` et
  `Colcp_Click` sont rejoués par `Object.Call` ; **ne pas cliquer dans `Histo`** (pas de
  `Histo_Click`, REPLAYOBSERVER-A06). `Colcp` reste invisible : pas de scénario possible.
- **T07** ouvre `Tricp` (lot Affichages) : le scénario doit être rejoué avec les deux écrans
  instrumentés ; l'erreur « Unknown symbol » interrompt le handler de `Tricp` (à capturer telle quelle).
- **Non testables automatiquement** : `Button10_Click` (Google Maps) et `Button7_Click` (aide) lancent
  `xdg-open` ; on peut substituer un faux `xdg-open` dans le `PATH` qui journalise ses arguments.
- **T01/T04** dépendent de la date du jour (fin de validité +20 ans) : `faketime` ou masquage des
  colonnes `datec`/`datef`.
- **SQLite** : rejouer T01, T02 et T08 sur la base SQLite (`CAST(… AS unsigned)`, texte `"1,50"` stocké
  tel quel par l'INSERT).
