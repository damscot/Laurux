# ExportA47 — Rework

> Source : `.src/Compta/Impressions/ExportA47.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/ExportA47.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 426 |
| Lignes de commentaire | 47 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 95 |
| Complexité max (fonction) | 34 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 426 | 95 | 34 | 0 | 33 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

Règle propre à ce fichier : **chaque étape doit laisser le FEC identique octet par octet**
(T01-T08, T11, T13). Toute étape qui touche à la génération repasse l'ensemble de ces tests.

- [ ] EXPORTA47-001 — [documentation] En-tête en français : référence A47 A-1, description des 18
  champs et de leur mise en forme actuelle (tableau d'architecture.md), règles provisoire /
  définitive, lignes exclues · appelants : aucun · tests : aucun · sources : [ExportA47.class:1-25](../../../../../.src/Compta/Impressions/ExportA47.class#L1-L25), [ExportA47.class:Button2_Click](../../../../../.src/Compta/Impressions/ExportA47.class#L358-L545)
- [ ] EXPORTA47-002 — [code mort] Supprimer `finmois`, `export`, `donnees1`, `donnees2`,
  `Intitule_Soc` et sa requête sans `WHERE`, la lecture inutile de `Fiches_Parametres` dans
  `Ex1`, les variables `dte`, `dte4`, `jour`, `txt`, `extension`,
  les locales `Tab`, `Tab2`, `Tab4`, `pl`, `TotSldHP` et le code commenté ; SQL modifié (requêtes
  en moins), dump et fichier identiques · appelants : aucun · tests : T01, T09, T12 · sources : [ExportA47.class:finmois](../../../../../.src/Compta/Impressions/ExportA47.class#L79-L90), [ExportA47.class:export](../../../../../.src/Compta/Impressions/ExportA47.class#L338-L356), [ExportA47.class:donnees1](../../../../../.src/Compta/Impressions/ExportA47.class#L547-L551), [ExportA47.class:donnees2](../../../../../.src/Compta/Impressions/ExportA47.class#L553-L557), [ExportA47.class:44-45](../../../../../.src/Compta/Impressions/ExportA47.class#L44-L45), [ExportA47.class:68](../../../../../.src/Compta/Impressions/ExportA47.class#L68), [ExportA47.class:385-390](../../../../../.src/Compta/Impressions/ExportA47.class#L385-L390), [ExportA47.class:423-435](../../../../../.src/Compta/Impressions/ExportA47.class#L423-L435)
- [ ] EXPORTA47-003 — [commonalisation] `Exo`…`Exo5` → une fonction privée `Periode(index)`
  fondée sur `LDate` (puis `LDate.Exercice_Cloture(n)` si les bornes sont identiques, voir LDATE),
  en cohérence avec `Bornes(index)` (BALANCE-004) (JOURNAUX-003) ; `Ex1` inchangé (A02) ·
  appelants : aucun · tests : T09, T10 · sources : [ExportA47.class:Exo](../../../../../.src/Compta/Impressions/ExportA47.class#L92-L105), [ExportA47.class:Exo5](../../../../../.src/Compta/Impressions/ExportA47.class#L167-L180), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)
- [ ] EXPORTA47-004 — [commonalisation] `Tab0` par `ImpCompta.TableMvt(index)`
  (`Cbase.Table("TabMvt…")`), et `Fiches_Parametres`/`Fiches_Comptes` par `Cbase.Table` ; SQL
  identique · appelants : aucun · tests : T01, T09 · sources : [ExportA47.class:EC_Click](../../../../../.src/Compta/Impressions/ExportA47.class#L277-L282), [ExportA47.class:E5_Click](../../../../../.src/Compta/Impressions/ExportA47.class#L319-L324), [ExportA47.class:415](../../../../../.src/Compta/Impressions/ExportA47.class#L415), [ExportA47.class:436](../../../../../.src/Compta/Impressions/ExportA47.class#L436)
- [ ] EXPORTA47-005 — [séparation traitement/GUI] Extraire `GenereFEC(sFichier, dDeb, dFin, sTab,
  bDefinitif, hProgression) As String` (requête, contrôles réglementaires, écriture du fichier,
  sans accès aux contrôles ni message) ; `Button2_Click` garde `CheckDate`, curseur, messages,
  `Me.Close` du cas « compte absent » à l'identique (A01 conservée) · appelants : aucun · tests :
  T01-T08, T11 · sources : [ExportA47.class:Button2_Click](../../../../../.src/Compta/Impressions/ExportA47.class#L358-L545)
- [ ] EXPORTA47-006 — [complexité] Décomposer la boucle : `MontantsNets`, `NumeroEcriture`,
  `LibelleControle`, `Bourre`/`BourreGauche` (reproduisant exactement `String$(n - Len(s), " ")`,
  y compris pour une longueur négative), ligne écrite par `donnees3` (CC 34 → ≤ 12 visé) ·
  appelants : aucun · tests : T01-T06, T08 · sources : [ExportA47.class:443-458](../../../../../.src/Compta/Impressions/ExportA47.class#L443-L458), [ExportA47.class:477-501](../../../../../.src/Compta/Impressions/ExportA47.class#L477-L501), [ExportA47.class:512-520](../../../../../.src/Compta/Impressions/ExportA47.class#L512-L520)
- [ ] EXPORTA47-007 — [complexité] Supprimer la requête `Fiches_Comptes` par ligne : jointure
  `LEFT JOIN` ou `Collection` des comptes existants chargée une fois ; détection du compte absent
  au même moment de la boucle ; SQL modifié, dump et fichier identiques · appelants : aucun ·
  tests : T01, T07, T14 · sources : [ExportA47.class:436-441](../../../../../.src/Compta/Impressions/ExportA47.class#L436-L441)
- [ ] EXPORTA47-008 — [réduction de portée] `Ex1`, `Exo`…`Exo5`, `CheckDate`, `donnees3` →
  `Private` (aucun appelant externe) · appelants : aucun · tests : T01, T09, T10 · sources : [ExportA47.class:Ex1](../../../../../.src/Compta/Impressions/ExportA47.class#L62-L75), [ExportA47.class:CheckDate](../../../../../.src/Compta/Impressions/ExportA47.class#L256-L274), [ExportA47.class:donnees3](../../../../../.src/Compta/Impressions/ExportA47.class#L559-L563)
- [ ] EXPORTA47-009 — [commonalisation] Extraction du SIREN depuis `siret_sc` partagée avec
  `CTestTVA.Siren` (Fsoc, FFournisseur), résultat identique (9 premiers caractères sans espaces) ·
  appelants : aucun · tests : T01 · sources : [ExportA47.class:392-393](../../../../../.src/Compta/Impressions/ExportA47.class#L392-L393)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.
Les anomalies A04 et A05 portent sur la **conformité réglementaire** : à valider avec
l'expert-comptable et l'outil de contrôle de la DGFiP avant toute correction.

- [ ] EXPORTA47-A01 — [anomalie] Compte absent du plan comptable : `Message.Error` puis
  `Me.Close` sans `Return` ; la lecture de `type_cc` sur un résultat vide lève une erreur, le
  fichier reste ouvert et partiel · tests : T07 · sources : [ExportA47.class:436-441](../../../../../.src/Compta/Impressions/ExportA47.class#L436-L441)
- [ ] EXPORTA47-A02 — [anomalie] « Exercice en cours » calculé sur `Now + 1 an` : pour un
  exercice civil, période proposée N+1 à N+2 au lieu de l'exercice courant (à confirmer, dépend
  de LDATE-A03) · tests : T09 · sources : [ExportA47.class:69-70](../../../../../.src/Compta/Impressions/ExportA47.class#L69-L70)
- [ ] EXPORTA47-A03 — [anomalie] Annulation de la barre de progression : fichier tronqué mais
  message « correctement copié » · tests : T08 · sources : [ExportA47.class:525](../../../../../.src/Compta/Impressions/ExportA47.class#L525), [ExportA47.class:532-537](../../../../../.src/Compta/Impressions/ExportA47.class#L532-L537)
- [ ] EXPORTA47-A04 — [anomalie] Conformité de structure (à confirmer) : noms d'en-tête
  `Journallib`, `credit`, `MontantDevise` (norme : `JournalLib`, `Credit`, `Montantdevise`) ;
  séparateur `|` final sur chaque ligne (19e champ vide) ; nom de fichier
  `<SIREN>FEC<fin>-<début>` au lieu de `<SIREN>FEC<date de clôture>` · tests : T01 · sources : [ExportA47.class:376](../../../../../.src/Compta/Impressions/ExportA47.class#L376), [ExportA47.class:412](../../../../../.src/Compta/Impressions/ExportA47.class#L412), [ExportA47.class:561](../../../../../.src/Compta/Impressions/ExportA47.class#L561)
- [ ] EXPORTA47-A05 — [anomalie] Conformité de contenu (à confirmer) : champs bourrés d'espaces
  dans un format délimité ; apostrophes exportées `\'` et `ô` → `e` (`Utils.Accent`, UTILS-A12) ;
  `CompAuxNum`/`CompAuxLib` toujours vides et comptes de tiers exportés en `CompteNum` ;
  séparateur décimal dépendant de la locale · tests : T01, T06 · sources : [ExportA47.class:487-501](../../../../../.src/Compta/Impressions/ExportA47.class#L487-L501), [ExportA47.class:520](../../../../../.src/Compta/Impressions/ExportA47.class#L520)
- [ ] EXPORTA47-A06 — [anomalie] Case « Envoi par Mail » sans effet : `export()` n'est jamais
  appelée et viserait `ecritures.<extension>` avec `extension` vide · tests : T12 · sources : [ExportA47.class:49-53](../../../../../.src/Compta/Impressions/ExportA47.class#L49-L53), [ExportA47.class:export](../../../../../.src/Compta/Impressions/ExportA47.class#L338-L356)
- [ ] EXPORTA47-A07 — [anomalie] Borne de fin `yyyy-mm-dd` sur `dte datetime` : écritures du
  dernier jour avec une heure non nulle exclues (à confirmer selon les données réelles) · tests :
  T11 · sources : [ExportA47.class:415](../../../../../.src/Compta/Impressions/ExportA47.class#L415)
- [ ] EXPORTA47-A08 — [anomalie] Bourrage `String$(n - Len(x))` avec une longueur négative quand
  un champ dépasse sa largeur (`numdoc`, `compte`, `numero`, intitulé allongé par `\'`) :
  comportement à confirmer (erreur ou chaîne vide) · tests : T06 · sources : [ExportA47.class:512-513](../../../../../.src/Compta/Impressions/ExportA47.class#L512-L513), [ExportA47.class:520](../../../../../.src/Compta/Impressions/ExportA47.class#L520)
- [ ] EXPORTA47-A09 — [anomalie] `DROP`/`CREATE` de la table `centralisation` sans usage ; la
  suppression change le dump · tests : T01 · sources : [ExportA47.class:404-411](../../../../../.src/Compta/Impressions/ExportA47.class#L404-L411)
