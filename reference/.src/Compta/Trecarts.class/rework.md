# Trecarts — Rework

> Source : `.src/Compta/Trecarts.class` · Message de commit (phase 4) : `reference/.src/Compta/Trecarts.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 224 |
| Lignes de commentaire | 34 |
| Fonctions | 9 |
| Fonctions Public | 9 |
| Complexité cyclomatique totale | 50 |
| Complexité max (fonction) | 24 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 224 | 50 | 24 | 0 | 9 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TRECARTS-001 — [documentation] En-tête en français : principe du traitement (lots non
  lettrés, seuil, comptes de régularisation, collectif, lettrage `E…`), tables touchées, verrou ;
  commentaires sur chaque étape de `Button2_Click` · appelants : aucun · tests : T01-T08 · sources : [Trecarts.class:Button2_Click](../../../../.src/Compta/Trecarts.class#L127-L292)
- [ ] TRECARTS-002 — [code mort] Supprimer `Ecarts_keypress` (aucun contrôle ni groupe `Ecarts`
  dans le `.form`), `clear()` (jamais appelée), les membres `TT`/`TD`/`TC` et les lignes commentées
  (`dte`, `numecr`, `IF … num`) · appelants : aucun · tests : T01, T04 · sources : [Trecarts.class:Ecarts_keypress](../../../../.src/Compta/Trecarts.class#L50-L74), [Trecarts.class:clear](../../../../.src/Compta/Trecarts.class#L92-L98), [Trecarts.class:28-30](../../../../.src/Compta/Trecarts.class#L28-L30)
- [ ] TRECARTS-003 — [commonalisation] Noms de tables via `Cbase.Table` (`TabComptes`, `TabParam`,
  `TabMvt`, `TabMvtM`), y compris dans la chaîne `LOCK TABLES` et l'appel `Sha1Calc.CalcSha1`
  (sans changement SQL) · appelants : aucun · tests : T01, T02, T08 · sources : [Trecarts.class:_New](../../../../.src/Compta/Trecarts.class#L37-L48), [Trecarts.class:154-156](../../../../.src/Compta/Trecarts.class#L154-L156), [Trecarts.class:222-223](../../../../.src/Compta/Trecarts.class#L222-L223)
- [ ] TRECARTS-004 — [complexité] Remplacer la boucle de lettrage (même `UPdate` répété pour chaque
  ligne) par un seul `UPdate`, et réutiliser `coll_cc` de `cptResult` au lieu de relire le compte
  (SQL modifié, dump identique) · appelants : aucun · tests : T01, T07 · sources : [Trecarts.class:256-273](../../../../.src/Compta/Trecarts.class#L256-L273)
- [ ] TRECARTS-005 — [commonalisation] Helpers privés `Insere_Ligne(...)` (3 `INSERT` quasi
  identiques) et `Maj_Solde(cpt, delta)` (4 séquences lecture/écriture du solde), en conservant les
  mêmes requêtes et le signe actuel ; `Maj_Solde` est candidat au helper commun avec `Tresor` et
  `Saisecrit` (phase 3) · appelants : aucun · tests : T01, T02, T05, T06 · sources : [Trecarts.class:226-266](../../../../.src/Compta/Trecarts.class#L226-L266), [Tresor.class:1636-1648](../../../../.src/Compta/Tresor.class#L1636-L1648)
- [ ] TRECARTS-006 — [séparation traitement/GUI] Extraire `Private Function Genere_Ecarts(type,
  seuil) As Integer` (tout le SQL, sans accès aux contrôles) ; `Button2_Click` garde contrôle du
  seuil, curseur et message · appelants : aucun · tests : T01-T08 · sources : [Trecarts.class:Button2_Click](../../../../.src/Compta/Trecarts.class#L127-L292)
- [ ] TRECARTS-007 — [réduction de portée] Membres `type`, `Tab2`, `Compt`, `b` → variables locales
  de `Genere_Ecarts` · appelants : aucun · tests : T01-T03 · sources : [Trecarts.class:31-34](../../../../.src/Compta/Trecarts.class#L31-L34)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TRECARTS-A01 — [anomalie] Solde des comptes de régularisation (`cptrplus`/`cptrmoins`) mis à
  jour avec le signe inverse de la ligne insérée (`+ Deb - Cred` alors que la ligne porte
  `montantd = Cred`, `montantc = Deb`) : `Fiches_Comptes.solde` des comptes 758/658 dérive
  (réparable par `Calcsolde`) · tests : T01, T02 · sources : [Trecarts.class:241](../../../../.src/Compta/Trecarts.class#L241), [Trecarts.class:251](../../../../.src/Compta/Trecarts.class#L251)
- [ ] TRECARTS-A02 — [anomalie] Compteur `B` non incrémenté pour la ligne `cptrmoins` : le message
  final sous-estime le nombre d'écritures · tests : T05 · sources : [Trecarts.class:237](../../../../.src/Compta/Trecarts.class#L237), [Trecarts.class:245-254](../../../../.src/Compta/Trecarts.class#L245-L254)
- [ ] TRECARTS-A03 — [anomalie] Aucun `Catch` : une erreur au milieu d'un lot laisse les tables
  verrouillées (`UNLOCK` jamais exécuté, MySQL) et le lot partiellement écrit ; pas de transaction ·
  tests : aucun (injection de faute manuelle) · sources : [Trecarts.class:222](../../../../.src/Compta/Trecarts.class#L222), [Trecarts.class:276](../../../../.src/Compta/Trecarts.class#L276)
- [ ] TRECARTS-A04 — [anomalie] Compte tiers sans collectif : une ligne `collectif = 1` est insérée
  sur le compte `""` (à confirmer) · tests : T06 · sources : [Trecarts.class:256-266](../../../../.src/Compta/Trecarts.class#L256-L266)
- [ ] TRECARTS-A05 — [anomalie] Écritures datées du jour sans contrôle d'exercice ni de clôture, et
  `numdoc` toujours vide · tests : T01 · sources : [Trecarts.class:139](../../../../.src/Compta/Trecarts.class#L139), [Trecarts.class:226](../../../../.src/Compta/Trecarts.class#L226)
- [ ] TRECARTS-A06 — [anomalie] `_New` lit `Fiches_Parametres` sans test `Available` (erreur si la
  table est vide) · tests : aucun · sources : [Trecarts.class:45-46](../../../../.src/Compta/Trecarts.class#L45-L46)
