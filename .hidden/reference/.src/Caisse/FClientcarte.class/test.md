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
| FCLIENTCARTE-T01 | replay | Création | Créer, nom/prénom/adresse/CP/ville/téléphones, points `1,50`/`10`, Enregistrer | ligne `Fiches_Carte` (code = dernier + 1, `cb = 299999…` + clé, fin +20 ans, `tp1` tronqué : A03 figée), couple CP ajouté à `Fiches_Cpostaux` | `tests/creation/` | implémenté (scénario `fclientcarte_creation` : nom, prénom, CP, ville ; code 000004, cb 2999990000047, champs non saisis à NULL) |
| FCLIENTCARTE-T02 | replay | Modification | clic sur une carte, téléphone domicile `01…` et bureau `02…`, Enregistrer | `Fiches_Carte` mise à jour avec téléphones **inversés** (A01 figée), points via `cpoint` | `tests/modification/` | implémenté (gb.test `FClientcarteTest.T02Modification` : `colcli_Click`, téléphones, `Button4_Click` ; A01 figée : domicile et bureau inversés en base) |
| FCLIENTCARTE-T03 | replay | Suppression | clic sur une carte avec historique, Supprimer, « Oui » puis une autre avec « Non » | 1 ligne supprimée, tickets inchangés (A07), aucune suppression sur « Non » | `tests/suppression/` | implémenté (scénario `fclientcarte_suppression` : « Oui » sur 000002 puis « Non » sur 000001 ; sans tickets dans le jeu, A07 non vérifiée) |
| FCLIENTCARTE-T04 | replay | Contrôle du code-barres | `CB` : 7 caractères ; 13 caractères clé fausse ; code d'une autre carte ; `*` + code valide | messages de longueur / de clé / bulle « déjà attribué », focus rendu ; `*` retiré | `tests/code_barre/` | à faire : les contrôles de longueur et de clé passent par `Message.Warning` (bloquant en gb.test) et `Cb_LostFocus` (boîte depuis un LostFocus, non rejouable) |
| FCLIENTCARTE-T05 | replay | Dates | boutons date d'émission et de fin, choix dans `DateChooser1` | `datec`/`datef` enregistrées après Enregistrer | `tests/dates/` | implémenté (gb.test `FClientcarteTest.T05Dates` : Button6/Button11, DateChooser1.Value posé puis DateChooser1_Activate appelé directement, Enregistrer) |
| FCLIENTCARTE-T06 | replay | Liste : tri et filtre | focus sur chaque en-tête, saisie `DU`, Retour arrière, double-clic (tri inverse) | contenu de la liste (ordre) et requêtes `Exec_SQL` de référence ; pas de saisie de `"` (A05) | `tests/liste_tri_filtre/` | implémenté (gb.test `FClientcarteTest.T06Tri` : tri et tri inverse par appel direct de *_Click / *_Dblclick ; scénario `fclientcarte_filtre` : filtre DU / Retour arrière par frappe dans N1, sql.log ordonné) ; saisie de `"` (A05) non tentée |
| FCLIENTCARTE-T07 | replay | Code postal | Entrée dans le code postal (`Cpman`) puis choix d'un CP ; bouton `ToggleButton5` puis choix | figer : CP non repris (A02), erreur « Unknown symbol » au second chemin (capturée dans le log) | `tests/code_postal/` | implémenté (gb.test FClientcarteModalTest.T07CodePostal : Timer pendant le ShowModal de Tricp, colco_Click sur la 1re ligne : CP non repris (A02) ; ToggleButton5 : erreur « 'FClientcarte.Bsel' is not a property » dans Tricp.colco_Click figée) |
| FCLIENTCARTE-T08 | replay | Historique | carte avec tickets : cocher « Historique des ventes » puis « Historique des points » | lignes affichées (log `Exec_SQL`, N+1 requêtes), cumul de points ; ticket `suppr = 1` absent ; aucun clic dans `Histo` | `tests/historique/` | implémenté (gb.test `FClientcarteTest.T08Historique` : tickets insérés par le test, ventes par `Hisv` (tri `numlig` numérique), points cumulés par `Hisp`, ticket `suppr = 1` absent ; nombre de requêtes non relevé) |
| FCLIENTCARTE-T09 | replay | Navigation clavier | Entrée sur chaque zone du groupe `Cmpt`, Entrée sur le nom sans code | ordre de focus de référence, message « cliquer sur Créer » | `tests/navigation/` | implémenté partiellement (scénario `fclientcarte_navigation` : message « cliquer sur Créer » ; ordre de focus non relevé) |
| FCLIENTCARTE-T10 | gbtest | Code-barres interne (après FCLIENTCARTE-010) | codes `000001`, `123456`, `999999` | `299999` + code + clé `Utils.Calcode` (valeurs du clone non modifié) | `tests/code_barre_calc/` | à faire : extraction FCLIENTCARTE-010 requise |

## Détail des tests

- **gb.test (phase 2, vague 6)** : module `.src/Tests/Caisse/FClientcarteTest.test` (fenêtre instanciée sans affichage,
  `Form_Open` appelé à la main, carte relue en base), jeu `fclientcarte_shared/cartes_base`.

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
- **Phase 2, vague 5** : lot `.hidden/Tests/Caisse/assets/`, jeu partagé `fclientcarte_shared/cartes_base.sql` (3 cartes
  000001-000003 dont une `divers = -1`, `conf` `Caisse=-1` pour rendre le menu Caisse visible). Saisie par `Focus` puis
  frappes, sans Entrée (Entrée sur les zones `Cmpt` enchaîne les focus et le CP ouvre `Cpman`). Ligne de la liste :
  `Click=<ligne>x0@Colcli#FClientcarte#Colcli#` (`colcli_Click`).
- **Implémentation (phase 2, vague 7)** : module séparé `.src/Tests/Caisse/FClientcarteModalTest.test` (sélection modale : un Timer du module retrouve la fenêtre de sélection ouverte en ShowModal parmi `Windows` et simule le choix ou la fermeture), distinct du module principal de la classe pour la fusion.
