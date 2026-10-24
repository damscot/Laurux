# JournauxM — Rework

> Source : `.src/Compta/Impressions/JournauxM.module` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/JournauxM.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 338 |
| Lignes de commentaire | 21 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 62 |
| Complexité max (fonction) | 55 (`Imprime`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 338 | 62 | 55 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] JOURNAUXM-001 — [documentation] En-tête du module en français : rôle, paramètres de
  `Imprime`, contrat de la table de travail `centralisation`, règles provisoire/définitive et
  collectifs · appelants : aucun · tests : aucun · sources : [JournauxM.module:Imprime](../../../../../.src/Compta/Impressions/JournauxM.module#L28-L316)
- [ ] JOURNAUXM-002 — [code mort] Supprimer `Shell "cd "`, `Datep`, `Ccoll`, les cumuls jamais
  imprimés dans `Imprime` (`DebhP`, `CredhP`, `TotSldhP` et les mises à jour de
  `TotDeb`/`TotCred`/`TotSld` hors `Centralisation`), les blocs vides `If p1 <> 0 Then 'solde = 0`
  et le code commenté · appelants : aucun · tests : T01-T06 · sources : [JournauxM.module:75](../../../../../.src/Compta/Impressions/JournauxM.module#L75), [JournauxM.module:87-88](../../../../../.src/Compta/Impressions/JournauxM.module#L87-L88), [JournauxM.module:151-174](../../../../../.src/Compta/Impressions/JournauxM.module#L151-L174), [JournauxM.module:262-264](../../../../../.src/Compta/Impressions/JournauxM.module#L262-L264)
- [ ] JOURNAUXM-003 — [code mort] Retirer le paramètre `Cloture` (toujours `False`) et la branche
  « après clôture » ; signature Public modifiée · appelants : `Journaux.Button1_Click` (mis à jour
  dans le même commit) · tests : T01, T05 · sources : [JournauxM.module:28](../../../../../.src/Compta/Impressions/JournauxM.module#L28), [JournauxM.module:103-107](../../../../../.src/Compta/Impressions/JournauxM.module#L103-L107), [Journaux.class:607](../../../../../.src/Compta/Impressions/Journaux.class#L607)
- [ ] JOURNAUXM-004 — [complexité] Réutiliser `Nm` (l. 125) au lieu de la seconde lecture
  identique de `Fiches_Comptes` (l. 208) ; SQL modifié (une requête de moins par ligne), dump
  identique · appelants : aucun · tests : T01, T02, T12 · sources : [JournauxM.module:125](../../../../../.src/Compta/Impressions/JournauxM.module#L125), [JournauxM.module:208](../../../../../.src/Compta/Impressions/JournauxM.module#L208)
- [ ] JOURNAUXM-005 — [commonalisation] Créer `ImpCompta.CentralisationCree()` et
  `ImpCompta.CentralisationCumule(compte, intitule, debit, credit, journal)` (SELECT puis
  UPDATE/INSERT paramétrés, mêmes valeurs écrites) ; la variante collectif garde son `UPDATE` sans
  `intitule` ; l'`UPDATE` concaténé de la l. 242 devient paramétré (SQL modifié, dump identique) ·
  appelants : aucun (repris par JOURNAUXA-005, JOURCENT-004, EcrM) · tests : T01-T03, T06 · sources : [JournauxM.module:Createtable](../../../../../.src/Compta/Impressions/JournauxM.module#L362-L374), [JournauxM.module:209-220](../../../../../.src/Compta/Impressions/JournauxM.module#L209-L220), [JournauxM.module:236-245](../../../../../.src/Compta/Impressions/JournauxM.module#L236-L245)
- [ ] JOURNAUXM-006 — [commonalisation] Créer `ImpCompta.CentralisationImprime(pdf, journal,
  titre, posy, ipage)` à partir de `Centralisation`, paramétré pour reproduire les variantes de
  `JournauxA.Centralisation` et `Jourcent.Centralisation2` (titre de page, `Level0J`/`level5J`
  au saut de page, Y de reprise) ; rendu identique · appelants : aucun · tests : T01, T06,
  JOURCENT-T01 · sources : [JournauxM.module:Centralisation](../../../../../.src/Compta/Impressions/JournauxM.module#L333-L360), [JournauxA.class:Centralisation](../../../../../.src/Compta/Impressions/JournauxA.class#L782-L809), [Jourcent.class:Centralisation2](../../../../../.src/Compta/Impressions/Jourcent.class#L845-L876)
- [ ] JOURNAUXM-007 — [complexité] Extraire de `Imprime` des fonctions privées
  `NumeroPiece`, `LibelleLigne`, `TypeCollectif`, `EntetePage`, `FinJournal` (CC 55 → ≤ 20 visé) ;
  ordre des appels PDF et SQL inchangé · appelants : aucun · tests : T01-T11 · sources : [JournauxM.module:111-116](../../../../../.src/Compta/Impressions/JournauxM.module#L111-L116), [JournauxM.module:182-201](../../../../../.src/Compta/Impressions/JournauxM.module#L182-L201), [JournauxM.module:225-235](../../../../../.src/Compta/Impressions/JournauxM.module#L225-L235), [JournauxM.module:250-259](../../../../../.src/Compta/Impressions/JournauxM.module#L250-L259), [JournauxM.module:262-294](../../../../../.src/Compta/Impressions/JournauxM.module#L262-L294)
- [ ] JOURNAUXM-008 — [commonalisation] Noms de tables par `Cbase.Table("TabJour")`,
  `("TabParam")`, `("TabSoc")`, `("TabComptes")` (mêmes noms physiques, SQL identique) ·
  appelants : aucun · tests : T01 · sources : [JournauxM.module:62-66](../../../../../.src/Compta/Impressions/JournauxM.module#L62-L66)
- [ ] JOURNAUXM-009 — [séparation traitement/GUI] Fonctions privées sans GUI pour la lecture
  du contexte (`Ste`, `dtepc` → `Qual`) et le cumul de centralisation d'une ligne ;
  `Message.Error`, `message` et `Journaux.Mouse` restent dans `Imprime` aux mêmes endroits ·
  appelants : aucun · tests : T01, T04, T07, T08 · sources : [JournauxM.module:72-86](../../../../../.src/Compta/Impressions/JournauxM.module#L72-L86), [JournauxM.module:127-128](../../../../../.src/Compta/Impressions/JournauxM.module#L127-L128), [JournauxM.module:311](../../../../../.src/Compta/Impressions/JournauxM.module#L311)
- [ ] JOURNAUXM-010 — [réduction de portée] `Raz`, `Centralisation`, `Createtable` → `Private`
  (aucun appelant externe, vérifié par grep) · appelants : aucun · tests : T01-T06 · sources : [JournauxM.module:Raz](../../../../../.src/Compta/Impressions/JournauxM.module#L318-L331), [JournauxM.module:Centralisation](../../../../../.src/Compta/Impressions/JournauxM.module#L333-L360), [JournauxM.module:Createtable](../../../../../.src/Compta/Impressions/JournauxM.module#L362-L374)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] JOURNAUXM-A01 — [anomalie] Compte absent du plan comptable : `Return` après le message sans
  remettre `Journaux.Mouse` (curseur bloqué en attente), sans PDF, et sans remise à zéro de
  `Totdeb2`/`Totcred2` (la ligne « Total journal » de l'impression suivante est faussée) · tests :
  T07 · sources : [JournauxM.module:126-129](../../../../../.src/Compta/Impressions/JournauxM.module#L126-L129), [JournauxM.module:204-205](../../../../../.src/Compta/Impressions/JournauxM.module#L204-L205)
- [ ] JOURNAUXM-A02 — [anomalie] Filtre de dates en SQL au format `yyyymmdd` sur une colonne
  `datetime` : sous MySQL, les écritures du dernier jour avec une heure non nulle sont exclues ;
  sous SQLite, la comparaison texte `'2025-01-05' >= '20250101'` est fausse (journaux vides, à
  confirmer) · tests : T09, T10 · sources : [JournauxM.module:97](../../../../../.src/Compta/Impressions/JournauxM.module#L97), [JournauxM.module:99](../../../../../.src/Compta/Impressions/JournauxM.module#L99)
- [ ] JOURNAUXM-A03 — [anomalie] Table de travail `centralisation` physique et partagée (DROP /
  CREATE à chaque journal) : deux postes qui impriment en même temps se corrompent mutuellement ;
  la passer en `TEMPORARY` change le dump · tests : T01, T03 · sources : [JournauxM.module:Createtable](../../../../../.src/Compta/Impressions/JournauxM.module#L362-L374)
- [ ] JOURNAUXM-A04 — [anomalie] Libellé de collectif : `Type` n'est pas réinitialisé, un collectif
  qui n'est ni `40…`, ni `41…`, ni `453` reprend le libellé du collectif précédent (ou une chaîne
  vide) · tests : T11 · sources : [JournauxM.module:225-235](../../../../../.src/Compta/Impressions/JournauxM.module#L225-L235)
