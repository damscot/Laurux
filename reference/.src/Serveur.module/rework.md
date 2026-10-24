# Serveur — Rework

> Source : `.src/Serveur.module` · Message de commit (phase 4) : `reference/.src/Serveur.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 295 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 143 |
| Complexité max (fonction) | 90 (`Pass`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 295 | 143 | 90 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] SERVEUR-001 — [documentation] En-tête du module : rôle (fichiers d'échange pour un serveur
  de mise à jour externe), contrat de format (tableau des origines, colonnes, doublons et absence de
  `;` final à conserver), préférences qui activent l'export · appelants : aucun · tests : T01-T05 ·
  sources : [Serveur.module:Pass](../../../.src/Serveur.module#L7-L224)
- [ ] SERVEUR-002 — [code mort] Supprimer `Docs`, `ReplaceFam` et `convBStr` (aucun appelant,
  grep) et le bloc `Origine = "Stock"` de `Pass` (aucun appel avec `"Stock"`) · appelants : aucun ·
  tests : T05 · sources : [Serveur.module:Docs](../../../.src/Serveur.module#L226-L272), [Serveur.module:ReplaceFam](../../../.src/Serveur.module#L274-L313), [Serveur.module:convBStr](../../../.src/Serveur.module#L315-L326), [Serveur.module:165-177](../../../.src/Serveur.module#L165-L177)
- [ ] SERVEUR-003 — [réduction de portée] Variables de module `hfile`, `Filename`, `Lig` → locales
  de `Pass` (après SERVEUR-002, plus aucun état partagé) · appelants : aucun · tests : T01-T06 ·
  sources : [Serveur.module:3-5](../../../.src/Serveur.module#L3-L5)
- [ ] SERVEUR-004 — [commonalisation] Helper privé `AjouteLigne(sFichier, sLigne)` (ouverture,
  positionnement en fin, `Print`, `Close`) utilisé par les 11 blocs de `Pass` ; même contenu de
  fichier (ouverture `For Append` si T06 confirme l'égalité octet par octet, sinon conservation de
  la lecture jusqu'à `Eof`) · appelants : aucun · tests : T01-T06 · sources : [Serveur.module:Pass](../../../.src/Serveur.module#L7-L224)
- [ ] SERVEUR-005 — [complexité] Lignes `Art`, `Fam`, `Four`, `Cli`, `Contact*` construites à
  partir de tableaux de noms de colonnes joints par `;` (ordre, doublons `art_ect`/`cli_typec` et
  absence de `;` final de `Fam` conservés), puis table `Origine` → (fichier, requête, colonnes) ;
  SQL inchangé (CC 90 → ≤ 15 visé) · appelants : aucun · tests : T01-T05 · sources : [Serveur.module:24-26](../../../.src/Serveur.module#L24-L26), [Serveur.module:76-78](../../../.src/Serveur.module#L76-L78), [Serveur.module:98-100](../../../.src/Serveur.module#L98-L100), [Serveur.module:139-140](../../../.src/Serveur.module#L139-L140)
- [ ] SERVEUR-006 — [commonalisation] Noms de table par `Cbase.Table` (`TabArt`, `TabFam`,
  `TabFour`, `TabComptes`, `TabCli`, `TabContactF`, `TabContact` pour `Fiches_ContactC`) ; SQL émis identique · appelants : aucun · tests : T01-T04 · sources : [Serveur.module:23](../../../.src/Serveur.module#L23), [Serveur.module:75](../../../.src/Serveur.module#L75), [Serveur.module:97](../../../.src/Serveur.module#L97), [Serveur.module:119](../../../.src/Serveur.module#L119), [Serveur.module:138](../../../.src/Serveur.module#L138), [Serveur.module:156](../../../.src/Serveur.module#L156)
- [ ] SERVEUR-007 — [séparation traitement/GUI] Extraire la construction de ligne en fonction pure
  `LigneServeur(Origine, type, code, code2, code3, rResult) As String` (testable sans fichier) ·
  appelants : aucun · tests : T01-T05 · sources : [Serveur.module:Pass](../../../.src/Serveur.module#L7-L224)
- [ ] SERVEUR-008 — [commonalisation] `Serveur.Actif(sDomaine) As Boolean` regroupant la garde
  `Variables.Sprix And Variables.Sexport And Variables.SMajArt|SMajFour|SMajCli` répétée dans les
  44 appels · appelants : `Articles`, `FClient`, `FFournisseur`, `Famille`, `Impart`, `MajTarifM`,
  `MajTarifP`, `MajFbtarif2`, `MajEqu` (mis à jour dans le même commit) · tests : T08 + replays des
  appelants · sources : [Articles.class:3908](../../../.src/Gestion/Tables/Articles.class#L3908), [FClient.class:1453](../../../.src/Gestion/Tables/FClient.class#L1453), [MajEqu.module:41](../../../.src/Gestion/Stock/Tarifs/MajEqu.module#L41)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] SERVEUR-A01 — [anomalie] `Pass` ne teste pas `rResult.Available` : un code absent provoque une
  erreur non interceptée chez l'appelant (écran de saisie) ; `Cli` n'a pas de cas `S` (suppression
  impossible à transmettre) · tests : T07 · sources : [Serveur.module:23-24](../../../.src/Serveur.module#L23-L24), [Serveur.module:138-139](../../../.src/Serveur.module#L138-L139)
- [ ] SERVEUR-A02 — [anomalie] Champs non échappés : un `;` ou un retour à la ligne dans une
  désignation ou une observation casse la ligne pour le consommateur externe (correction à
  coordonner avec lui) · tests : T07 · sources : [Serveur.module:24](../../../.src/Serveur.module#L24), [Serveur.module:139](../../../.src/Serveur.module#L139)
- [ ] SERVEUR-A03 — [anomalie] Échec d'ouverture du fichier ignoré par `Try`, puis erreur sur
  `Eof(hFile)` (répertoire `Schmprix` absent ou non accessible) : remplacer par un `Message.Error`
  explicite ou un abandon silencieux · tests : T07 · sources : [Serveur.module:14-21](../../../.src/Serveur.module#L14-L21)
