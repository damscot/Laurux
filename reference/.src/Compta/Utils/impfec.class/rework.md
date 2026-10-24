# impfec — Rework

> Source : `.src/Compta/Utils/impfec.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/impfec.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 294 |
| Lignes de commentaire | 11 |
| Fonctions | 10 |
| Fonctions Public | 7 |
| Complexité cyclomatique totale | 61 |
| Complexité max (fonction) | 25 (`ctrl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 294 | 61 | 25 | 0 | 7 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMPFEC-001 — [documentation] En-tête en français : colonnes FEC utilisées (index), règle de
  calcul du compte auxiliaire, tables de correspondance Ciel, fin de ligne CRLF attendue, tables
  écrites · appelants : aucun · tests : aucun · sources : [impfec.class:ctrl](../../../../../.src/Compta/Utils/impfec.class#L91-L204), [impfec.class:trat](../../../../../.src/Compta/Utils/impfec.class#L206-L338)
- [ ] IMPFEC-002 — [code mort] Supprimer le membre `$fname` et la variable locale `s` de `_new`
  (jamais utilisés) · appelants : aucun · tests : T01 · sources : [impfec.class:4](../../../../../.src/Compta/Utils/impfec.class#L4), [impfec.class:_new](../../../../../.src/Compta/Utils/impfec.class#L8-L18)
- [ ] IMPFEC-003 — [commonalisation] Fonction pure privée `CompteFec(sCompte, sAux, iNbCar) As
  String`, utilisée par `ctrl` (qui garde ses messages « non bloquant ») et par `trat` ; même
  résultat dans tous les cas · appelants : aucun · tests : T01, T05, T09 · sources : [impfec.class:163-185](../../../../../.src/Compta/Utils/impfec.class#L163-L185), [impfec.class:285-301](../../../../../.src/Compta/Utils/impfec.class#L285-L301)
- [ ] IMPFEC-004 — [commonalisation] Helper privé `Correspondance(sTable, sCode) As Result`
  (lookups `Ciel_Lrx` / `Ciel_Lrx_Jo`) et `LireFec(sChemin, sSep) As String[][]` (ouverture,
  `gb.Windows`, saut de l'en-tête, `Split`, **fermeture** du fichier) ; même SQL émis · appelants :
  aucun · tests : T01, T03, T05 · sources : [impfec.class:ctrl](../../../../../.src/Compta/Utils/impfec.class#L91-L204), [impfec.class:trat](../../../../../.src/Compta/Utils/impfec.class#L206-L338), [impfec.class:123-133](../../../../../.src/Compta/Utils/impfec.class#L123-L133), [impfec.class:222-233](../../../../../.src/Compta/Utils/impfec.class#L222-L233)
- [ ] IMPFEC-005 — [complexité] `ctrl` : extraire le contrôle d'une ligne dans
  `ControleLigne(aCol, bRenum, iNbCar) As String` (CC 25 → ≤ 10 visé), mêmes messages dans le même
  ordre · appelants : aucun · tests : T03, T04, T05 · sources : [impfec.class:ctrl](../../../../../.src/Compta/Utils/impfec.class#L91-L204)
- [ ] IMPFEC-006 — [réarchitecture] Noms de tables via `Cbase.Table("TabMvt")`, `"TabJour"`,
  `"TabComptes"`, `"TabParam"` (SQL identique), y compris l'argument de `Sha1Calc.CalcSha1` ·
  appelants : aucun · tests : T01, T02 · sources : [impfec.class:141-152](../../../../../.src/Compta/Utils/impfec.class#L141-L152), [impfec.class:217-219](../../../../../.src/Compta/Utils/impfec.class#L217-L219), [impfec.class:234](../../../../../.src/Compta/Utils/impfec.class#L234), [impfec.class:240](../../../../../.src/Compta/Utils/impfec.class#L240), [impfec.class:335](../../../../../.src/Compta/Utils/impfec.class#L335)
- [ ] IMPFEC-007 — [séparation traitement/GUI] Extraire `ControleFec(sChemin, sSep, bRenum,
  iNbCar) As String[]` et `ImporteFec(sChemin, sSep, bRenum, iNbCar) As Integer` sans accès aux
  contrôles (progression par paramètre `ProgBar` optionnel, arrêt par membre `$stp`) ; les
  handlers gardent `TextArea1`, les boutons et `Calcsolde` · appelants : aucun · tests : T01-T08 · sources : [impfec.class:ctrl](../../../../../.src/Compta/Utils/impfec.class#L91-L204), [impfec.class:trat](../../../../../.src/Compta/Utils/impfec.class#L206-L338), [impfec.class:Buttontra_Click](../../../../../.src/Compta/Utils/impfec.class#L28-L64)
- [ ] IMPFEC-008 — [commonalisation] Correspondances Ciel partagées avec `Cielimp` (même helper que
  IMPFEC-004, déplacé dans un module commun) ; à planifier avec le rework de `Cielimp` · appelants :
  `Cielimp` · tests : T05 + tests de Cielimp · sources : [impfec.class:186-193](../../../../../.src/Compta/Utils/impfec.class#L186-L193), [impfec.class:278-307](../../../../../.src/Compta/Utils/impfec.class#L278-L307), [Cielimp.class:_New](../../../../../.src/Compta/Cielimp.class#L36-L41)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMPFEC-A01 — [anomalie] `LOCK TABLES` suivi de `Utils.db.Begin` : sous MySQL, le début de
  transaction libère les verrous (verrou inopérant) et aucun `UNLOCK TABLES` n'est émis ; si le
  verrou était effectif, les `SELECT` sur `Ciel_Lrx*` (non verrouillées) échoueraient (à confirmer
  sur MariaDB) · tests : T01, T02 · sources : [impfec.class:216-224](../../../../../.src/Compta/Utils/impfec.class#L216-L224)
- [ ] IMPFEC-A02 — [anomalie] Aucune gestion d'erreur dans `trat`/`Buttontra_Click` : une erreur
  (date invalide, colonne vide) laisse la transaction ouverte sans `Rollback` et `Buttonquit`
  désactivé, donc `Form_Close` bloque la fermeture de la fenêtre · tests : T08 · sources : [impfec.class:Buttontra_Click](../../../../../.src/Compta/Utils/impfec.class#L28-L64), [impfec.class:Form_Close](../../../../../.src/Compta/Utils/impfec.class#L20-L26), [impfec.class:259](../../../../../.src/Compta/Utils/impfec.class#L259)
- [ ] IMPFEC-A03 — [anomalie] Ligne collectif : `intitule = Trim(CompteLib)` non tronqué à 40
  caractères (colonne `varchar(40)`), contrairement à la ligne principale ; erreur SQL en mode
  strict (à confirmer) · tests : T01 · sources : [impfec.class:317](../../../../../.src/Compta/Utils/impfec.class#L317), [impfec.class:258](../../../../../.src/Compta/Utils/impfec.class#L258)
- [ ] IMPFEC-A04 — [anomalie] `$hfile` n'est jamais fermé (ni après `ctrl`, ni après `trat`, ni
  sur sortie anticipée) ; le fichier est réouvert dans le même membre · tests : T01, T03 · sources : [impfec.class:123](../../../../../.src/Compta/Utils/impfec.class#L123), [impfec.class:137](../../../../../.src/Compta/Utils/impfec.class#L137), [impfec.class:222](../../../../../.src/Compta/Utils/impfec.class#L222)
- [ ] IMPFEC-A05 — [anomalie] `EndOfLine = gb.Windows` impose CRLF : un FEC à fin de ligne Unix
  (LF) est lu comme une seule ligne et rejeté (« problème soit sur le séparateur… ») · tests : T07 · sources : [impfec.class:124](../../../../../.src/Compta/Utils/impfec.class#L124), [impfec.class:223](../../../../../.src/Compta/Utils/impfec.class#L223)
- [ ] IMPFEC-A06 — [anomalie] Montants lus par `Val(Trim(Debit/Credit))` : dépend de la locale
  pour le séparateur décimal (FEC usuel « 1234,56 ») ; un FEC au format « Montant + Sens » (variante
  légale, même nombre de colonnes) est mal interprété (à confirmer) · tests : T01 · sources : [impfec.class:268-269](../../../../../.src/Compta/Utils/impfec.class#L268-L269)
