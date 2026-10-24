# Extrait — Rework

> Source : `.src/Compta/Extrait.class` · Message de commit (phase 4) : `reference/.src/Compta/Extrait.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1127 |
| Lignes de commentaire | 157 |
| Fonctions | 55 |
| Fonctions Public | 52 |
| Complexité cyclomatique totale | 236 |
| Complexité max (fonction) | 31 (`_New`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 1127 | 236 | 31 | 0 | 52 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EXTRAIT-001 — [documentation] En-tête en français : appelants et paramètres de `_New`
  (`Org = "S"`), périodes `E0`/`E1`/`N1-5`, modes détaillé/centralisé, table `Ctrln`, contrat
  `Bsel`/`Bval` avec `TriCpt` · appelants : aucun · tests : aucun · sources : [Extrait.class:_New](../../../../.src/Compta/Extrait.class#L81-L216)
- [ ] EXTRAIT-002 — [code mort] Supprimer `Compdate`, `compdate2`, `Txt`, les membres inutilisés
  (`Tab0`, `TT`, `TD`, `TC`, `Ncode`, `Tri`, `$Intitule`, `sCmpt`, `sDesg`), les locales
  inutilisées d'`affichage`, et l'appel `$lstex.litleres(num)` dont le résultat est écrasé (SQL
  modifié : requêtes de `litleres` en moins, dump identique) · appelants : aucun ·
  tests : T01, T09 · sources : [Extrait.class:Compdate](../../../../.src/Compta/Extrait.class#L421-L435), [Extrait.class:compdate2](../../../../.src/Compta/Extrait.class#L437-L451), [Extrait.class:73-74](../../../../.src/Compta/Extrait.class#L73-L74), [Extrait.class:1152](../../../../.src/Compta/Extrait.class#L1152)
- [ ] EXTRAIT-003 — [commonalisation] `finmois` → `LDate(...).FinMois.Day` ; périodes de `Ex1`,
  `Exo`, `nmoins_click` via `LDate` (`Exercice_Fin`, `Exercice_Cloture`) avec dates affichées
  identiques · appelants : aucun · tests : T01, T06, T07 · sources : [Extrait.class:finmois](../../../../.src/Compta/Extrait.class#L755-L766), [Extrait.class:Ex1](../../../../.src/Compta/Extrait.class#L221-L248), [Extrait.class:Exo](../../../../.src/Compta/Extrait.class#L253-L273), [LDate.class:Fin_Mois](../../../../.src/Utils/LDate.class#L564-L573)
- [ ] EXTRAIT-004 — [complexité] Huit handlers `T*_MouseDown` → helper privé `TriSur(sChamp)` ;
  handlers conservés (une ligne chacun) · appelants : aucun · tests : T05 ·
  sources : [Extrait.class:Tdate_MouseDown](../../../../.src/Compta/Extrait.class#L1002-L1013), [Extrait.class:Tlettree_MouseDown](../../../../.src/Compta/Extrait.class#L1093-L1104)
- [ ] EXTRAIT-005 — [complexité] `Bclient_Click`…`Bbilan_Click` → helper privé
  `ChoixType(sType, bSiOrgVide)` (même SQL, même enchaînement) · appelants : aucun · tests : T03,
  T12 · sources : [Extrait.class:Bclient_Click](../../../../.src/Compta/Extrait.class#L824-L836), [Extrait.class:Bbilan_Click](../../../../.src/Compta/Extrait.class#L875-L887)
- [ ] EXTRAIT-006 — [complexité] `_New` : lecture des largeurs par boucle sur `colN` (même
  traitement spécial de `col1` par `Val`) et calage des en-têtes par tableau ; CC 31 → ≤ 10 visé ·
  appelants : aucun · tests : T01, T11 · sources : [Extrait.class:106-172](../../../../.src/Compta/Extrait.class#L106-L172)
- [ ] EXTRAIT-007 — [complexité] `affichage` : extraire `PositionneCompte()` (bloc `Compt` 0-5) et
  `AfficheTotaux()` (l. 659-671) ; CC 31 → ≤ 15 visé, SQL identique · appelants : aucun ·
  tests : T01-T07 · sources : [Extrait.class:affichage](../../../../.src/Compta/Extrait.class#L517-L674)
- [ ] EXTRAIT-008 — [complexité] `cpt_LF` : table des préfixes autorisés par type au lieu des
  conditions répétées (CC 30 → ≤ 8 visé), messages identiques · appelants : aucun · tests : T08 ·
  sources : [Extrait.class:cpt_LF](../../../../.src/Compta/Extrait.class#L370-L405)
- [ ] EXTRAIT-009 — [séparation traitement/GUI] Fonction pure `CumulsExtrait(resext, dDeb, dFin)`
  pour les totaux ; `EtatEcriture(numero) As Integer` (clôturée / pointée) pour
  `Colcli_Activate` ; SQL identique · appelants : aucun · tests : T01-T04, T09, T14 ·
  sources : [Extrait.class:affichage](../../../../.src/Compta/Extrait.class#L517-L674), [Extrait.class:Colcli_Activate](../../../../.src/Compta/Extrait.class#L1138-L1199)
- [ ] EXTRAIT-010 — [commonalisation] Noms de tables par `Cbase.Table` (`TabParam`, `TabComptes`,
  `TabMvt`) comme déjà fait l. 1166 ; SQL identique · appelants : aucun · tests : T01, T09 ·
  sources : [Extrait.class:226-227](../../../../.src/Compta/Extrait.class#L226-L227), [Extrait.class:1144](../../../../.src/Compta/Extrait.class#L1144), [Extrait.class:1166](../../../../.src/Compta/Extrait.class#L1166)
- [ ] EXTRAIT-011 — [réduction de portée] `Ex1`, `Exo`, `cpt_LF`, `compteman`, `clear`,
  `affichage`, `aff`, `Raz`, `Centralisation`, `finmois`, `Appel_Saisie`, `Appel_Tresor` →
  `Private` (`Bsel`/`Bval` restent `Public`) · appelants : aucun · tests : T01-T12 ·
  sources : [Extrait.class:Ex1](../../../../.src/Compta/Extrait.class#L221-L248), [Extrait.class:affichage](../../../../.src/Compta/Extrait.class#L517-L674), [Extrait.class:Appel_Tresor](../../../../.src/Compta/Extrait.class#L1242-L1249)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EXTRAIT-A01 — [anomalie] Mode centralisé : `aff` écrase `DebP`/`CredP` avec la dernière
  ligne de `Ctrln` (totaux « période » faux) et reconstruit toute la grille à chaque écriture
  (coût quadratique) ; les écritures antérieures ne sont pas cumulées hors période ·
  tests : T07 · sources : [Extrait.class:aff](../../../../.src/Compta/Extrait.class#L698-L722), [Extrait.class:716-717](../../../../.src/Compta/Extrait.class#L716-L717), [Extrait.class:641-649](../../../../.src/Compta/Extrait.class#L641-L649)
- [ ] EXTRAIT-A02 — [anomalie] Table de travail physique `Ctrln` : `ENGINE = MYISAM` en dur
  (échec sous SQLite), table partagée entre postes (deux consultations simultanées se
  détruisent mutuellement), laissée dans la base · tests : T07, T13 · sources : [Extrait.class:596-606](../../../../.src/Compta/Extrait.class#L596-L606)
- [ ] EXTRAIT-A03 — [anomalie] `compteman` : saisie concaténée dans `like '<cpt>%'` (une
  apostrophe provoque une erreur SQL) ; passer en `like &1` change le comportement sur ces
  saisies · tests : T08 · sources : [Extrait.class:462](../../../../.src/Compta/Extrait.class#L462)
- [ ] EXTRAIT-A04 — [anomalie] `compteman` : `If Cmpts Then` toujours vrai → `detail` coché pour
  tout compte saisi ; pour un compte centralisé, la vue centralisée n'est jamais proposée après
  une saisie manuelle (à confirmer) · tests : T07, T08 · sources : [Extrait.class:469-473](../../../../.src/Compta/Extrait.class#L469-L473)
- [ ] EXTRAIT-A05 — [anomalie] `Necrit_Click` teste `Journaux.Visible`, auto-instance d'un autre
  formulaire (impression des journaux), au lieu d'un contrôle local ; `Message.Delete` utilisé
  pour une information · tests : T09 · sources : [Extrait.class:1210](../../../../.src/Compta/Extrait.class#L1210), [Extrait.class:1227](../../../../.src/Compta/Extrait.class#L1227)
- [ ] EXTRAIT-A06 — [anomalie] `butedit_Click` : fiche client/fournisseur lue sans `Available`
  (compte sans fiche `Fiches_Cli`/`Fiches_Four` de même code → erreur) ; en-tête pris sur la
  première ligne de `Fiches_Societes` sans filtre de société · tests : T10 ·
  sources : [Extrait.class:1309](../../../../.src/Compta/Extrait.class#L1309), [Extrait.class:1338-1343](../../../../.src/Compta/Extrait.class#L1338-L1343)
- [ ] EXTRAIT-A07 — [anomalie] `nmoins_click` sur un exercice archivé absent (`dteclecX` nul) :
  erreur `DateAdd` non interceptée ; `affichage` sans test `Available` sur `rrResult` (type sans
  compte) · tests : T06 · sources : [Extrait.class:286](../../../../.src/Compta/Extrait.class#L286), [Extrait.class:529-533](../../../../.src/Compta/Extrait.class#L529-L533)
- [ ] EXTRAIT-A08 — [anomalie] `Raz` : `CdP.Text = "" = 0` affecte le résultat d'une comparaison
  (sans effet visible, écrasé ensuite) · tests : T02 · sources : [Extrait.class:994](../../../../.src/Compta/Extrait.class#L994)
