# Ligcli — Rework

> Source : `.src/Compta/Relances/Ligcli.class` · Message de commit (phase 4) : `reference/.src/Compta/Relances/Ligcli.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 333 |
| Lignes de commentaire | 16 |
| Fonctions | 20 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 59 |
| Complexité max (fonction) | 25 (`Buttonedit_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 333 | 59 | 25 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LIGCLI-001 — [documentation] En-tête : rôle, arguments de construction (parent en dernier),
  événements `Up`/`Down`/`Gotf`, propriétés lues par `FEditrel` · appelants : aucun · tests : aucun ·
  sources : [Ligcli.class:_new](../../../../../.src/Compta/Relances/Ligcli.class#L21-L82)
- [ ] LIGCLI-002 — [code mort] Supprimer `EnvMail()` (aucun appelant), `Filetxt`, le
  `Shell "cd …"` et le corps vide de `numlet_Write` (la propriété passe en lecture seule si aucun
  écrivain n'existe, vérifié par grep) · appelants : aucun · tests : T04 · sources :
  [Ligcli.class:EnvMail](../../../../../.src/Compta/Relances/Ligcli.class#L346-L355), [Ligcli.class:229](../../../../../.src/Compta/Relances/Ligcli.class#L229), [Ligcli.class:234](../../../../../.src/Compta/Relances/Ligcli.class#L234), [Ligcli.class:numlet_Write](../../../../../.src/Compta/Relances/Ligcli.class#L409-L411)
- [ ] LIGCLI-003 — [code mort] Supprimer le paramètre inutilisé `devises` de `_new` · appelants :
  `FEditrel.affiche` (même commit) · tests : T01 · sources : [Ligcli.class:_new](../../../../../.src/Compta/Relances/Ligcli.class#L21-L82), [FEditrel.class:146](../../../../../.src/Compta/Relances/FEditrel.class#L146)
- [ ] LIGCLI-004 — [commonalisation] En-tête société via un helper commun (`Creleve.EnteteSociete`
  ou module de relances), partagé avec `FEditrel`, `FRelCompte`, `FRelFacture` · appelants : aucun ·
  tests : T04, T05 · sources : [Ligcli.class:238-254](../../../../../.src/Compta/Relances/Ligcli.class#L238-L254), [FEditrel.class:497-513](../../../../../.src/Compta/Relances/FEditrel.class#L497-L513)
- [ ] LIGCLI-005 — [commonalisation] Corps de la lettre (lignes, UPDATE `relance`, saut de page,
  soldes) dans une fonction commune avec `FEditrel.Impressionr`, en conservant la différence de
  signe du solde du compte comme paramètre (comportement identique) · appelants : aucun · tests :
  T04-T06 · sources : [Ligcli.class:Buttonedit_Click](../../../../../.src/Compta/Relances/Ligcli.class#L181-L343), [FEditrel.class:Impressionr](../../../../../.src/Compta/Relances/FEditrel.class#L438-L610)
- [ ] LIGCLI-006 — [séparation traitement/GUI] `ChargeClient(numcli)` et `RetireRelances(compte)`
  privés ; SQL identique · appelants : aucun · tests : T01, T03 · sources : [Ligcli.class:_new](../../../../../.src/Compta/Relances/Ligcli.class#L21-L82), [Ligcli.class:Checkselec_Click](../../../../../.src/Compta/Relances/Ligcli.class#L104-L114)
- [ ] LIGCLI-007 — [commonalisation] `Cbase.Table("TabCli")`, `("TabComptes")`, `("TabSoc")`,
  `("TabMvt")` au lieu des noms en dur (SQL identique) · appelants : aucun · tests : T01, T04 ·
  sources : [Ligcli.class:52](../../../../../.src/Compta/Relances/Ligcli.class#L52), [Ligcli.class:58](../../../../../.src/Compta/Relances/Ligcli.class#L58), [Ligcli.class:225-228](../../../../../.src/Compta/Relances/Ligcli.class#L225-L228)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LIGCLI-A01 — [anomalie] `_new` : `Fiches_Comptes` et `Fiches_Txt_Relances` lus sans test
  `Available` (erreur si le client n'a pas de compte ou si aucun texte n'est saisi) · tests : T07 ·
  sources : [Ligcli.class:58-64](../../../../../.src/Compta/Relances/Ligcli.class#L58-L64)
- [ ] LIGCLI-A02 — [anomalie] Solde du compte négatif imprimé sans changement de signe (colonne
  débit avec un « - »), contrairement à `FEditrel` · tests : T05 · sources : [Ligcli.class:322](../../../../../.src/Compta/Relances/Ligcli.class#L322), [FEditrel.class:583](../../../../../.src/Compta/Relances/FEditrel.class#L583)
- [ ] LIGCLI-A03 — [anomalie] Le niveau écrit dans `Fiches_Mvt.relance` est celui de la première
  écriture (`Niv`), pas le numéro de lettre choisi dans `Combolettre` · tests : T04 · sources :
  [Ligcli.class:266](../../../../../.src/Compta/Relances/Ligcli.class#L266), [Ligcli.class:296](../../../../../.src/Compta/Relances/Ligcli.class#L296)
- [ ] LIGCLI-A04 — [anomalie] Un seul `Observer` conservé sur 13 ; si les autres sont libérés, la
  navigation souris/clavier ne marche que sur `Checkmail` (à confirmer par LIGCLI-T02) · tests :
  T02 · sources : [Ligcli.class:37-49](../../../../../.src/Compta/Relances/Ligcli.class#L37-L49)
- [ ] LIGCLI-A05 — [anomalie] Décocher un client supprime sans confirmation toutes ses écritures de
  `Fiches_relances` ; les recocher ne les restaure pas · tests : T03 · sources : [Ligcli.class:Checkselec_Click](../../../../../.src/Compta/Relances/Ligcli.class#L104-L114)
