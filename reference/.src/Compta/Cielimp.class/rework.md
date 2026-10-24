# Cielimp — Rework

> Source : `.src/Compta/Cielimp.class` · Message de commit (phase 4) : `reference/.src/Compta/Cielimp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 520 |
| Lignes de commentaire | 45 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 140 |
| Complexité max (fonction) | 54 (`controle_comptes`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 520 | 140 | 54 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CIELIMP-001 — [documentation] En-tête en français : format de ligne Ciel (positions),
  séquence contrôle → import, tables et fichiers produits, import unique (`imp_ciel`) ;
  commentaire signalant que `Button3_Click` est l'aide · appelants : aucun · tests : aucun ·
  sources : [Cielimp.class:Btn_Click](../../../../.src/Compta/Cielimp.class#L43-L81), [Cielimp.class:Compta](../../../../.src/Compta/Cielimp.class#L259-L396), [Cielimp.class:Button3_Click](../../../../.src/Compta/Cielimp.class#L610-L614)
- [ ] CIELIMP-002 — [code mort] Supprimer `Compta2` (aucun appelant, 158 lignes), `Parametres`/`Jnl`
  (valeur jamais lue), `Tabc`, `dte1`, `dnc`, `ParaResult`, `Filetxt4`/`Nbe2` et la branche
  `Editeur` associée, les `SELECT` inutilisés des l. 347 et 594 (SQL modifié : `SELECT` en moins,
  dump identique) · appelants : aucun · tests : T01, T09 ·
  sources : [Cielimp.class:Compta2](../../../../.src/Compta/Cielimp.class#L399-L556), [Cielimp.class:Parametres](../../../../.src/Compta/Cielimp.class#L561-L569), [Cielimp.class:347](../../../../.src/Compta/Cielimp.class#L347), [Cielimp.class:594](../../../../.src/Compta/Cielimp.class#L594), [Cielimp.class:394](../../../../.src/Compta/Cielimp.class#L394)
- [ ] CIELIMP-003 — [commonalisation] Numérotation : `Ecritures`/`Majnum` remplacés par un helper
  commun `Utils.NumEcriture`/`Utils.MajNumEcriture` (à créer en phase 3 avec `Moulinage`,
  `Tresor`, `ValidBR`, `TresorFac`, `Facture`), SQL identique · appelants : aucun ·
  tests : T01 · sources : [Cielimp.class:Ecritures](../../../../.src/Compta/Cielimp.class#L574-L585), [Cielimp.class:Majnum](../../../../.src/Compta/Cielimp.class#L603-L608), [Moulinage.class:Ecritures](../../../../.src/Caisse/Moulinage.class#L2206-L2221)
- [ ] CIELIMP-004 — [commonalisation] Noms de tables par `Cbase.Table` (`TabParam`, `TabComptes`,
  `TabMvt`, `TabJour`) ; SQL identique · appelants : aucun · tests : T01-T05 ·
  sources : [Cielimp.class:108-112](../../../../.src/Compta/Cielimp.class#L108-L112), [Cielimp.class:296-302](../../../../.src/Compta/Cielimp.class#L296-L302)
- [ ] CIELIMP-005 — [séparation traitement/GUI] Fonction pure `LigneCiel(lig, nLong) As
  Collection` (positions fixes) utilisée par `controle_comptes` et `Compta` ; testable en
  gb.test · appelants : aucun · tests : T01, T10, T12 · sources : [Cielimp.class:142-189](../../../../.src/Compta/Cielimp.class#L142-L189), [Cielimp.class:314-333](../../../../.src/Compta/Cielimp.class#L314-L333)
- [ ] CIELIMP-006 — [complexité] `controle_comptes` : `TypeCompte(sCompte)` pour les tests de
  classe (l. 152-160), en-têtes de fichiers par une boucle, décision finale (l. 206-236) en
  fonction ; CC 54 → ≤ 20 visé, messages identiques · appelants : aucun · tests : T02-T08 ·
  sources : [Cielimp.class:controle_comptes](../../../../.src/Compta/Cielimp.class#L83-L245)
- [ ] CIELIMP-007 — [séparation traitement/GUI] `ControleFichier(...)` et `ImporteFichier(...)`
  sans accès aux contrôles (`Fimport`, `Lcpt`, `Me.Mouse`) ni messages ; `Btn_Click` garde
  l'interaction · appelants : aucun · tests : T01-T11 · sources : [Cielimp.class:controle_comptes](../../../../.src/Compta/Cielimp.class#L83-L245), [Cielimp.class:Compta](../../../../.src/Compta/Cielimp.class#L259-L396)
- [ ] CIELIMP-008 — [réduction de portée] `controle_comptes`, `Compta`, `Ecritures`,
  `Maj_Parametres`, `Majnum` → `Private` · appelants : aucun · tests : T01-T07 ·
  sources : [Cielimp.class:controle_comptes](../../../../.src/Compta/Cielimp.class#L83-L245), [Cielimp.class:Maj_Parametres](../../../../.src/Compta/Cielimp.class#L590-L598)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CIELIMP-A01 — [anomalie] Membre `b` jamais remis à 0 : après une création de comptes, toute
  nouvelle tentative dans la même fenêtre ne fait rien (ni message ni import) ; il faut rouvrir
  l'écran · tests : T03 · sources : [Cielimp.class:34](../../../../.src/Compta/Cielimp.class#L34), [Cielimp.class:172](../../../../.src/Compta/Cielimp.class#L172), [Cielimp.class:206](../../../../.src/Compta/Cielimp.class#L206)
- [ ] CIELIMP-A02 — [anomalie] Fichiers non fermés : sortie anticipée l. 148 (4 fichiers ouverts,
  souris non rétablie) ; fichier d'import jamais fermé dans `controle_comptes` ni `Compta` ;
  table `Cptabs` laissée en base · tests : T06 · sources : [Cielimp.class:148](../../../../.src/Compta/Cielimp.class#L148), [Cielimp.class:126](../../../../.src/Compta/Cielimp.class#L126), [Cielimp.class:308](../../../../.src/Compta/Cielimp.class#L308), [Cielimp.class:122-125](../../../../.src/Compta/Cielimp.class#L122-L125)
- [ ] CIELIMP-A03 — [anomalie] `Compta` : compte de tiers traduit absent de `Fiches_Comptes` →
  `rResult!coll_cc` sans `Available` → erreur en cours d'import, sans transaction : import
  partiel, `imp_ciel` non positionné, un réimport crée des doublons · tests : T11 ·
  sources : [Cielimp.class:350-351](../../../../.src/Compta/Cielimp.class#L350-L351), [Cielimp.class:365-366](../../../../.src/Compta/Cielimp.class#L365-L366)
- [ ] CIELIMP-A04 — [anomalie] Montants : `Mtd` converti implicitement (`Mtd = Mid$(…)`) alors que
  `Mtc` passe par `Val(Utils.cpoint(…))` ; `Mtd` inséré sans `PointBase` sur la ligne de tiers
  (résultat dépendant du séparateur décimal du fichier, à confirmer) · tests : T10 ·
  sources : [Cielimp.class:328](../../../../.src/Compta/Cielimp.class#L328), [Cielimp.class:331](../../../../.src/Compta/Cielimp.class#L331), [Cielimp.class:364](../../../../.src/Compta/Cielimp.class#L364)
- [ ] CIELIMP-A05 — [anomalie] Trésorerie : `Tresor` (booléen) reçoit `type_jo` puis est comparé à
  `"TR"` (comparaison booléen/chaîne, probablement toujours fausse, à confirmer) · tests : T09 ·
  sources : [Cielimp.class:337-342](../../../../.src/Compta/Cielimp.class#L337-L342)
- [ ] CIELIMP-A06 — [anomalie] Compte de trésorerie `51210000` en dur ; `UPDATE … where numero =
  &3` sans borne de date (touche toute écriture de même numéro) · tests : T09 ·
  sources : [Cielimp.class:380-385](../../../../.src/Compta/Cielimp.class#L380-L385)
- [ ] CIELIMP-A07 — [anomalie] DDL de `Ciel_Lrx` divergent : `Cciel Char(10)` ici, `Char(15)` dans
  `Utils.Ciel` ; remplacer le bloc par `Utils.Ciel()` change la structure créée · tests : T01,
  CIELCORSP-T01 · sources : [Cielimp.class:53-70](../../../../.src/Compta/Cielimp.class#L53-L70), [Utils.module:Ciel](../../../../.src/Utils/Utils.module#L1578-L1602)
- [ ] CIELIMP-A08 — [anomalie] `numerodef = numr` (compteur provisoire) et `numecriture2` non mis
  à jour : risque de collision avec les numéros définitifs attribués ensuite par `FCloture` (à
  confirmer) · tests : T01 · sources : [Cielimp.class:353](../../../../.src/Compta/Cielimp.class#L353), [Cielimp.class:377](../../../../.src/Compta/Cielimp.class#L377)
- [ ] CIELIMP-A09 — [anomalie] Message d'écriture déséquilibrée : affiche le journal de la ligne
  suivante (`Mid$(lig, 6, 2)` de la nouvelle écriture) · tests : T06 · sources : [Cielimp.class:147](../../../../.src/Compta/Cielimp.class#L147)
