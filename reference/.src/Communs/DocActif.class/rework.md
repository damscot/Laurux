# DocActif — Rework

> Source : `.src/Communs/DocActif.class` · Message de commit (phase 4) : `reference/.src/Communs/DocActif.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 149 |
| Lignes de commentaire | 11 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 13 (`Get_Lock`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 149 | 37 | 13 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DOCACTIF-001 — [documentation] En-tête en français : double rôle (service de verrous via
  l'auto-instance, fenêtre d'administration), format d'une ligne de `Fiches_Docactif`, sémantique
  des valeurs de retour de `Is_Lock`/`Get_Lock`/`Free_Lock` (dont le `False` constant de
  `Free_Lock`) · appelants : aucun · tests : aucun · sources : [DocActif.class:_new](../../../../.src/Communs/DocActif.class#L10-L19), [DocActif.class:Get_Lock](../../../../.src/Communs/DocActif.class#L94-L136), [DocActif.class:Free_Lock](../../../../.src/Communs/DocActif.class#L138-L173)
- [ ] DOCACTIF-002 — [complexité] `Get_Lock` : `bok` typé `Boolean` (même valeur renvoyée,
  vérifiée par T01, T04 à T07) ; `Free_Lock` : supprimer la variable `Bok As String` au profit d'un
  `Boolean` local sans changer la valeur renvoyée · appelants : aucun · tests : T01 à T09 · sources : [DocActif.class:97](../../../../.src/Communs/DocActif.class#L97), [DocActif.class:141](../../../../.src/Communs/DocActif.class#L141)
- [ ] DOCACTIF-003 — [code mort] `_new` : `File.Load("/etc/machine-id")` au lieu de
  `Shell "cat …"` (contenu identique) ; `listdoc_Data` : tableau des colonnes en constante
  privée au lieu d'un tableau reconstruit à chaque cellule · appelants : aucun · tests : T01, T10 · sources : [DocActif.class:_new](../../../../.src/Communs/DocActif.class#L10-L19), [DocActif.class:listdoc_Data](../../../../.src/Communs/DocActif.class#L56-L72)
- [ ] DOCACTIF-004 — [séparation traitement/GUI] `LireVerrou`, `PoserVerrou`, `ReprendreVerrou`,
  `SupprimerVerrou` (SQL seul) et `Statut(rVerrou) As Integer` (pur) ; `Get_Lock`/`Free_Lock`
  conservent dialogues, ordre des requêtes et `LOCK`/`UNLOCK` (SQL identique) · appelants : aucun
  (signatures Public inchangées) · tests : T01 à T09, T12 · sources : [DocActif.class:Get_Lock](../../../../.src/Communs/DocActif.class#L94-L136), [DocActif.class:Free_Lock](../../../../.src/Communs/DocActif.class#L138-L173), [DocActif.class:Is_Lock](../../../../.src/Communs/DocActif.class#L77-L89)
- [ ] DOCACTIF-005 — [commonalisation] `MessageProprietaire(sAction, type, num, rVerrou) As String`
  pour les cinq messages longs (« Lock sur le document … pris par … ») ; textes identiques ·
  appelants : aucun · tests : T04 à T08 · sources : [DocActif.class:Get_Lock](../../../../.src/Communs/DocActif.class#L94-L136), [DocActif.class:Free_Lock](../../../../.src/Communs/DocActif.class#L138-L173)
- [ ] DOCACTIF-006 — [réduction de portée] `Deb1` → `Private` (aucun appelant externe ; couvert
  par T10) · appelants : aucun · tests : T10 · sources : [DocActif.class:Deb1](../../../../.src/Communs/DocActif.class#L48-L53)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] DOCACTIF-A01 — [anomalie] `Free_Lock` est déclarée `As Boolean` mais ne renvoie jamais de
  valeur (toujours `False`). `Facture` teste ce résultat : la branche « verrou libéré → désélection
  et sortie » n'est jamais prise. Corriger demande de valider la sémantique attendue dans
  `Facture` · tests : T03, T08, tests FACTURE · sources : [DocActif.class:Free_Lock](../../../../.src/Communs/DocActif.class#L138-L173), [Facture.class:1523](../../../../.src/Gestion/Facturation/Facture.class#L1523), [Facture.class:1946](../../../../.src/Gestion/Facturation/Facture.class#L1946)
- [ ] DOCACTIF-A02 — [anomalie] `Free_Lock` : `Return False` (cas `Count > 1` + « Annuler ») sans
  `UNLOCK TABLES` : la table reste verrouillée pour tous les postes jusqu'à la déconnexion (chemin
  inatteignable avec la clé primaire actuelle, mais à protéger) · tests : aucun (inatteignable) · sources : [DocActif.class:148](../../../../.src/Communs/DocActif.class#L148)
- [ ] DOCACTIF-A03 — [anomalie] Dialogues modaux affichés pendant `LOCK TABLES … WRITE` dans
  `Get_Lock`/`Free_Lock` : les autres postes sont bloqués tant que l'utilisateur n'a pas répondu.
  Proposition : relâcher le verrou de table avant le dialogue puis revérifier · tests : T05 à T08 · sources : [DocActif.class:107](../../../../.src/Communs/DocActif.class#L107), [DocActif.class:114](../../../../.src/Communs/DocActif.class#L114), [DocActif.class:155](../../../../.src/Communs/DocActif.class#L155), [DocActif.class:161](../../../../.src/Communs/DocActif.class#L161)
- [ ] DOCACTIF-A04 — [anomalie] `listdoc_Click` supprime n'importe quel verrou sans contrôle du
  propriétaire ni de la ligne sélectionnée (clic hors ligne : `listdoc.row = -1`, erreur à
  confirmer) ; `listdoc_Data` dépend du global partagé `Utils.rs2` · tests : T10 · sources : [DocActif.class:listdoc_Click](../../../../.src/Communs/DocActif.class#L175-L193), [DocActif.class:listdoc_Data](../../../../.src/Communs/DocActif.class#L56-L72)
