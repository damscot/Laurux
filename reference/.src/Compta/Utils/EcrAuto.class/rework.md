# EcrAuto — Rework

> Source : `.src/Compta/Utils/EcrAuto.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/EcrAuto.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 601 |
| Lignes de commentaire | 10 |
| Fonctions | 17 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 99 |
| Complexité max (fonction) | 22 (`ecriture`) |
| Variables globales | 0 |
| Variables Public | 5 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 601 | 99 | 22 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECRAUTO-001 — [documentation] En-tête : cycle d'une écriture (contrôle, numérotation, états
  `L_*`, effets : solde, lettrage, traite, collectif, clé, GED), membres publics lus par les
  appelants, valeur de retour d'`ecriture` · appelants : aucun · tests : aucun · sources : [EcrAuto.class:ecriture](../../../../../.src/Compta/Utils/EcrAuto.class#L258-L343)
- [ ] ECRAUTO-002 — [code mort] Supprimer `Create Static`, la branche `Edit` inatteignable de
  `collectif`, les variables `i`/`resext` inutilisées de `Lettrage`/`DLettrage` · appelants :
  aucun · tests : T03-T06 · sources : [EcrAuto.class:3](../../../../../.src/Compta/Utils/EcrAuto.class#L3), [EcrAuto.class:collectif](../../../../../.src/Compta/Utils/EcrAuto.class#L528-L540), [EcrAuto.class:Lettrage](../../../../../.src/Compta/Utils/EcrAuto.class#L598-L637), [EcrAuto.class:DLettrage](../../../../../.src/Compta/Utils/EcrAuto.class#L639-L662)
- [ ] ECRAUTO-003 — [complexité] `Impression` : helper privé `Cellule(…)` pour les ~25 blocs
  d'étiquettes (rendu identique) · appelants : `ValidBR1`, `SaiReg` (inchangés) · tests : T10 ·
  sources : [EcrAuto.class:Impression](../../../../../.src/Compta/Utils/EcrAuto.class#L33-L235)
- [ ] ECRAUTO-004 — [complexité] `ecriture` : extraire `LibelleVente(var)` et la numérotation
  (CC 22 → ≤ 10 visé, SQL identique) · appelants : aucun · tests : T01, T07, T08 · sources :
  [EcrAuto.class:ecriture](../../../../../.src/Compta/Utils/EcrAuto.class#L258-L343)
- [ ] ECRAUTO-005 — [commonalisation] Séquence GED de `ged()` → `LGed.Archive(…)` (créé dans le
  rework de `LGed`) · appelants : aucun · tests : T11 · sources : [EcrAuto.class:ged](../../../../../.src/Compta/Utils/EcrAuto.class#L565-L595), [LGed.class:Search](../../../../../.src/Utils/LGed.class#L86-L93)
- [ ] ECRAUTO-006 — [commonalisation] Libellé de vente via le helper `LVar` commun (voir LVar) ·
  appelants : aucun · tests : T07 · sources : [EcrAuto.class:286-300](../../../../../.src/Compta/Utils/EcrAuto.class#L286-L300)
- [ ] ECRAUTO-007 — [commonalisation] `Cbase.Table("TabMvt"/"TabMvtM"/"TabComptes"/"TabCli"/
  "TabJour"/"TabParam"/"TabBl"/"TabBlM"/"TabHisFac"/"TabHisFacm")` pour les noms en dur, y compris
  l'argument de `Sha1Calc.CalcSha1` (SQL identique) · appelants : aucun · tests : T01-T07 · sources :
  [EcrAuto.class:25](../../../../../.src/Compta/Utils/EcrAuto.class#L25), [EcrAuto.class:337](../../../../../.src/Compta/Utils/EcrAuto.class#L337), [EcrAuto.class:facnum](../../../../../.src/Compta/Utils/EcrAuto.class#L345-L387), [EcrAuto.class:ajout](../../../../../.src/Compta/Utils/EcrAuto.class#L389-L462)
- [ ] ECRAUTO-008 — [commonalisation] `solde()` remplacé par la fonction de solde commune issue de la
  phase 3 (`Csolde`/`Calcsolde`), à condition de garder le même SQL et le même message · appelants :
  aucun · tests : T01, T06 · sources : [EcrAuto.class:solde](../../../../../.src/Compta/Utils/EcrAuto.class#L513-L526), [Csolde.module:Solde_caisse](../../../../../.src/Utils/Csolde.module#L30-L63)
- [ ] ECRAUTO-009 — [complexité] `facnum` : boucle au lieu de la récursion, vérification d'existence
  inchangée (mêmes 4 requêtes) · appelants : aucun · tests : T08 · sources : [EcrAuto.class:facnum](../../../../../.src/Compta/Utils/EcrAuto.class#L345-L387)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECRAUTO-A01 — [anomalie] `ajout` : compte inexistant → retour `True` **sans `UNLOCK TABLES`
  ni `Rollback`** : sous MySQL, les tables restent verrouillées pour la session (toute requête sur
  une autre table échoue ensuite) et la transaction reste ouverte ; les lignes déjà écrites de
  l'écriture ne sont pas annulées · tests : T09 · sources : [EcrAuto.class:394-399](../../../../../.src/Compta/Utils/EcrAuto.class#L394-L399), [EcrAuto.class:317](../../../../../.src/Compta/Utils/EcrAuto.class#L317)
- [ ] ECRAUTO-A02 — [anomalie] `Lettrage` modifie `var.compte` (compte de régularisation) sans le
  restaurer : `traite` et `collectif` s'appliquent ensuite au mauvais compte et l'impression affiche
  ce compte · tests : T04 · sources : [EcrAuto.class:623-628](../../../../../.src/Compta/Utils/EcrAuto.class#L623-L628), [EcrAuto.class:445-450](../../../../../.src/Compta/Utils/EcrAuto.class#L445-L450)
- [ ] ECRAUTO-A03 — [anomalie] Abandon après consommation des compteurs (`numecriture`,
  `numecriture2`, `dnfac`) : trous dans la numérotation définitive et des factures (annulation de
  `facnum`, compte inexistant, écart de collectif) · tests : T08, T09 · sources : [EcrAuto.class:272](../../../../../.src/Compta/Utils/EcrAuto.class#L272), [EcrAuto.class:279-282](../../../../../.src/Compta/Utils/EcrAuto.class#L279-L282), [EcrAuto.class:facnum](../../../../../.src/Compta/Utils/EcrAuto.class#L345-L387)
- [ ] ECRAUTO-A04 — [anomalie] `traite` : `insert … value (…)` refusé par SQLite (non traduit par
  `DB_Connection`) ; aucune traite créée en mode portable · tests : T12 · sources : [EcrAuto.class:558](../../../../../.src/Compta/Utils/EcrAuto.class#L558)
- [ ] ECRAUTO-A05 — [anomalie] Dialogues (`Message.Error`/`Info`) affichés tables verrouillées et
  transaction ouverte (`ajout`, `solde`, `facnum`) ; les déplacer après libération change l'ordre
  des dialogues · tests : T08, T09 · sources : [EcrAuto.class:397](../../../../../.src/Compta/Utils/EcrAuto.class#L397), [EcrAuto.class:451-453](../../../../../.src/Compta/Utils/EcrAuto.class#L451-L453), [EcrAuto.class:520](../../../../../.src/Compta/Utils/EcrAuto.class#L520)
- [ ] ECRAUTO-A06 — [anomalie] `collectif` : en cas d'échec, `var.compte` reste le compte
  collectif ; `DLettrage` utilise `Vecr.numlot` (racine) au lieu de `var.numlot` · tests : T05, T06 ·
  sources : [EcrAuto.class:530-537](../../../../../.src/Compta/Utils/EcrAuto.class#L530-L537), [EcrAuto.class:647](../../../../../.src/Compta/Utils/EcrAuto.class#L647)
- [ ] ECRAUTO-A07 — [anomalie] Police `"Serif, Blod, …"` (faute de frappe) : en-têtes du `Report`
  probablement non gras (à confirmer visuellement) · tests : T10 · sources : [EcrAuto.class:50](../../../../../.src/Compta/Utils/EcrAuto.class#L50), [EcrAuto.class:250](../../../../../.src/Compta/Utils/EcrAuto.class#L250)
