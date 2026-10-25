# MajFbtarif2 — Rework

> Source : `.src/Gestion/Stock/Tarifs/MajFbtarif2.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Tarifs/MajFbtarif2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 236 |
| Lignes de commentaire | 35 |
| Fonctions | 18 |
| Fonctions Public | 18 |
| Complexité cyclomatique totale | 63 |
| Complexité max (fonction) | 15 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 236 | 63 | 15 | 0 | 18 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJFBTARIF2-001 — [documentation] En-tête de classe en français : rôle (application de la
  future base tarif importée par `Impart`), modes brut/net, ordre de la chaîne de calcul,
  variables de module ; commentaires `'''` sur chaque fonction de calcul · appelants : aucun ·
  tests : T01, T03 · sources : [MajFbtarif2.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L37-L87), [MajFbtarif2.class:prix_base](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L109-L129)
- [ ] MAJFBTARIF2-002 — [code mort] Supprimer `Calc_Marge` (résultats `Margem`/`Margep` jamais
  lus) et les variables de module `Margem`, `Margep`, `Pmp`, `Stocke` ; sans changement SQL ·
  appelants : aucun · tests : T01, T03 · sources : [MajFbtarif2.class:Calc_Marge](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L218-L231), [MajFbtarif2.class:prix_base](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L109-L129), [MajFbtarif2.class:Prix_achat](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L162-L185)
- [ ] MAJFBTARIF2-003 — [réduction de portée] `prix_base`, `PvTTcLF`, `TrC`, `Prix_achat`,
  `rTva`, `Tva_Calcul`, `Calc_Marge`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`, `Maj_Etiqp`,
  `Maj_Etiqg` → `Private` (couverts par les replays de `Button2_Click`) · appelants : aucun ·
  tests : T01-T03 · sources : [MajFbtarif2.class:prix_base](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L109-L129), [MajFbtarif2.class:Maj_Etiqg](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L312-L325)
- [ ] MAJFBTARIF2-004 — [commonalisation] Classe d'état `LTarifCalc` (à créer dans
  `.src/Utils`) recevant **sans modification** les fonctions identiques à `Etiqfbtarif` et
  `MajTarifP` (`TrC`, `rTva`, `Tva_Calcul`, `PvTTC_arrondi`, `Calc_Percent`, `Calc_coeff`,
  `PvTTcLF`, `prix_base`, `Prix_achat`) et les variables de module correspondantes ; même lot
  que MAJTARIFP-004 et la case équivalente d'`Etiqfbtarif` · appelants : `Etiqfbtarif`,
  `MajTarifP` (via leurs cases) · tests : T01, T03, T07 · sources : [MajFbtarif2.class:prix_base](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L109-L129), [MajFbtarif2.class:TrC](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L146-L160), [MajFbtarif2.class:Calc_coeff](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L287-L291), [MajTarifP.class:TrC](../../../../../../.src/Gestion/Stock/Tarifs/MajTarifP.class#L304-L318)
- [ ] MAJFBTARIF2-005 — [commonalisation] `Maj_Etiqp`/`Maj_Etiqg` remplacées par un module
  commun `EtiqMaj` (variante « gondole remise à 1 » partagée avec `Impart`) ; noms de tables via
  `Cbase.Table("TabEtiqp"/"TabEtiqg")` (même SQL émis) · appelants : aucun · tests : T02 ·
  sources : [MajFbtarif2.class:Maj_Etiqp](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L294-L309), [MajFbtarif2.class:Maj_Etiqg](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L312-L325), [Impart.class:Maj_Etiqp](../../../../../../.src/Gestion/Stock/Tarifs/Impart.class#L1330-L1346)
- [ ] MAJFBTARIF2-006 — [séparation traitement/GUI] Extraire de `Button2_Click` une fonction
  `AppliqueFutureBase(sDateDb, bBrut) As Integer` (requêtes, boucle, calcul) ; le handler garde
  messages, souris et son ; les `Message.Error` des `Catch` sont conservés à l'identique ·
  appelants : aucun · tests : T01-T05 · sources : [MajFbtarif2.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L37-L87)
- [ ] MAJFBTARIF2-007 — [commonalisation] Garde d'export `Variables.Sprix And Variables.Sexport
  And Variables.SMajArt` → `Serveur.Actif` (après SERVEUR-008) · appelants : aucun · tests : T02 ·
  sources : [MajFbtarif2.class:Button2_Click](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L37-L87)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJFBTARIF2-A01 — [anomalie] **Date vide** : `art_datefbt = ''` sélectionne les articles
  déjà traités (date et prix futurs remis à `''` par un passage précédent, soit `0000-00-00`/`0`
  en MySQL non strict, `''` en SQLite) et recalcule leurs prix à partir d'un prix de base nul.
  Correction : refuser une date vide et remettre `art_pbfbt`/`art_datefbt` à `NULL` · tests : T04 ·
  sources : [MajFbtarif2.class:44](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L44), [MajFbtarif2.class:68](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L68)
- [ ] MAJFBTARIF2-A02 — [anomalie] `LOCK TABLES` ne verrouille pas `Fiches_EtiProd` /
  `Fiches_EtiGond` : sous MySQL, `Maj_Etiqp`/`Maj_Etiqg` échouent dès le premier article à
  étiqueter, le traitement s'arrête sans `UNLOCK TABLES` (à confirmer par T02 ; `MajTarifP`
  verrouille ces tables) · tests : T02 · sources : [MajFbtarif2.class:47](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L47), [MajFbtarif2.class:Maj_Etiqp](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L294-L309)
- [ ] MAJFBTARIF2-A03 — [anomalie] `arr` n'est jamais affecté : `PvTTC_arrondi` n'applique pas
  l'arrondi `art_cdarr` de l'article ; le PV TTC enregistré n'est pas arrondi comme dans la fiche
  article · tests : T01 · sources : [MajFbtarif2.class:PvTTC_arrondi](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L236-L273)
- [ ] MAJFBTARIF2-A04 — [anomalie] `Prix_achat` utilise `Val(Txconv)`, `Val(Frais)`,
  `Val(Coeff)` sans `Utils.cpoint` sur des valeurs relues en base : résultat dépendant de la
  locale (à confirmer par T03) · tests : T03 · sources : [MajFbtarif2.class:Prix_achat](../../../../../../.src/Gestion/Stock/Tarifs/MajFbtarif2.class#L162-L185)
