# LGed — Rework

> Source : `.src/Utils/LGed.class` · Message de commit (phase 4) : `reference/.src/Utils/LGed.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 756 |
| Lignes de commentaire | 21 |
| Fonctions | 52 |
| Fonctions Public | 43 |
| Complexité cyclomatique totale | 215 |
| Complexité max (fonction) | 29 (`Enregistrer_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 756 | 215 | 29 | 0 | 43 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LGED-001 — [documentation] En-tête : double rôle objet/fiche, schéma des tables GED,
  arborescence des fichiers, valeurs de l'énumération stockées en base (ordre figé), convention
  `New LGed(Null, …)` · appelants : aucun · tests : T01-T14 · sources : [LGed.class:_New](../../../../.src/Utils/LGed.class#L34-L75)
- [ ] LGED-002 — [réarchitecture] `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` → `Cbase.Table("TabDocGed")`,
  `("TabDocTag")`, `("TabTag")` (mêmes noms physiques) · appelants : aucun · tests : T02-T06, T09 · sources : [LGed.class:trouve](../../../../.src/Utils/LGed.class#L96-L122), [LGed.class:AddTag](../../../../.src/Utils/LGed.class#L179-L197), [LGed.class:EpurationTags](../../../../.src/Utils/LGed.class#L243-L257)
- [ ] LGED-003 — [complexité] `trouve` : une requête avec clause construite par `Utils.db.Subst`
  au lieu de quatre branches · appelants : `Search`, `Exist` · tests : T03 · sources : [LGed.class:trouve](../../../../.src/Utils/LGed.class#L96-L122)
- [ ] LGED-004 — [séparation traitement/GUI] `Commit(tags As String[])` et
  `Default_URL(FileName, tags As String[])` reçoivent la liste de tags au lieu de lire `ListTags` ;
  `MoveURL` utilise `NewUrl` au lieu de `furl.Text` · appelants : internes uniquement
  (`Enregistrer_Click`, `PDFDupli`, `DefUrl_Click`) · tests : T06, T07, T10, T11 · sources : [LGed.class:Commit](../../../../.src/Utils/LGed.class#L410-L429), [LGed.class:Default_URL](../../../../.src/Utils/LGed.class#L442-L497), [LGed.class:MoveURL](../../../../.src/Utils/LGed.class#L376-L408)
- [ ] LGED-005 — [complexité] `Enregistrer_Click` : extraire `ControleSaisie()` et
  `RemplaceFichier(source, cible)` (messages et ordre identiques) (CC 29 → ≤ 12 visé) · appelants :
  aucun · tests : T10, T11, T12 · sources : [LGed.class:Enregistrer_Click](../../../../.src/Utils/LGed.class#L712-L814)
- [ ] LGED-006 — [commonalisation] Helpers privés `EstLocal(url)` / `Chemin(url)` pour les 10
  conversions `file:///` ; helper commun aux deux procédures de scan · appelants : aucun ·
  tests : T07, T10, T11 · sources : [LGed.class:ScanGUI_Click](../../../../.src/Utils/LGed.class#L862-L895), [LGed.class:ScanBatch_Click](../../../../.src/Utils/LGed.class#L897-L936), [LGed.class:MoveURL](../../../../.src/Utils/LGed.class#L376-L408)
- [ ] LGED-007 — [commonalisation] Méthode statique `Archive(type, origine, code, compte, pdf, nom,
  tags)` reproduisant la séquence Search/New/PDFDupli/Supprime/AddTags ; bascule des appelants dans
  leurs propres reworks · appelants : `ObjFac`, `commande1`, `Edbr`, `EcrAuto` (optionnel) ·
  tests : T06 · sources : [LGed.class:PDFDupli](../../../../.src/Utils/LGed.class#L990-L1009), [EcrAuto.class:580-592](../../../../.src/Compta/Utils/EcrAuto.class#L580-L592)
- [ ] LGED-008 — [complexité] `AddTag` : boucle bornée à la place du `Goto` (cas nominal identique) ·
  appelants : 9 fichiers (inchangés) · tests : T04 · sources : [LGed.class:AddTag](../../../../.src/Utils/LGed.class#L179-L197)
- [ ] LGED-009 — [réduction de portée] `Exist`, `DelTag`, `Get_Mime`, `Get_Default_Extension`,
  `MoveURL`, `Commit`, `Default_URL`, `ScannerFinalize` → `Private` ; **ne pas** toucher
  `Bsel`/`Bval`/`*Proc_Read` · appelants : aucun · tests : T03, T04, T06-T08, T10, T11 · sources : [LGed.class:Exist](../../../../.src/Utils/LGed.class#L77-L84), [LGed.class:DelTag](../../../../.src/Utils/LGed.class#L221-L240), [LGed.class:Get_Mime](../../../../.src/Utils/LGed.class#L302-L335), [LGed.class:Commit](../../../../.src/Utils/LGed.class#L410-L429), [LGed.class:ScannerFinalize](../../../../.src/Utils/LGed.class#L826-L860)
- [ ] LGED-010 — [documentation] Commenter les handlers vides `furl_Change` et `ListTags_Change`
  (conservés : les handlers sont intouchables selon PLAN.md) · appelants : aucun · tests : T10 · sources : [LGed.class:furl_Change](../../../../.src/Utils/LGed.class#L610-L612), [LGed.class:ListTags_Change](../../../../.src/Utils/LGed.class#L638-L640)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LGED-A01 — [anomalie] Aucun report de `fdte` dans `$dte` : une date modifiée dans la fiche
  n'est jamais enregistrée · tests : T12 · sources : [LGed.class:558-559](../../../../.src/Utils/LGed.class#L558-L559), [LGed.class:Enregistrer_Click](../../../../.src/Utils/LGed.class#L712-L814)
- [ ] LGED-A02 — [anomalie] `AddTag` sur un tag déjà porté par le document : `$tags.Add` sur clé
  existante (erreur de collection, à confirmer) ; cas réels : `Saisecrit.Lettrage` (même compte sur
  deux lignes), `GedR.AjoutTags_Click` · tests : T04 · sources : [LGed.class:187](../../../../.src/Utils/LGed.class#L187)
- [ ] LGED-A03 — [anomalie] `EpurationTags` supprime un tag encore utilisé si une ligne `Docs_Tag`
  pendante le référence, et ne purge jamais les lignes `Docs_Tag` orphelines · tests : T05 · sources : [LGed.class:247](../../../../.src/Utils/LGed.class#L247)
- [ ] LGED-A04 — [anomalie] `Default_URL` : `Replace(tag, …)` sans affectation, les espaces et
  points des tags restent dans le nom de fichier · tests : T07 · sources : [LGed.class:482-483](../../../../.src/Utils/LGed.class#L482-L483)
- [ ] LGED-A05 — [anomalie] SQL propre à MySQL (`insert ignore`, `LAST_INSERT_ID()`) : GED
  inutilisable sous SQLite · tests : à créer sur `Laurux01.sqlite` · sources : [LGed.class:189](../../../../.src/Utils/LGed.class#L189), [LGed.class:417](../../../../.src/Utils/LGed.class#L417)
- [ ] LGED-A06 — [anomalie] `Get_Mime` : chemin et URL non échappés dans `Shell` (espaces, `'`,
  injection) ; `curl -k` · tests : T08 · sources : [LGed.class:317](../../../../.src/Utils/LGed.class#L317), [LGed.class:325](../../../../.src/Utils/LGed.class#L325)
- [ ] LGED-A07 — [anomalie] (requalifiée après le lot Gestion, voir ARTICLES-A07) `Articles.class:4126`
  appelle `LGed.Supprime(True)` sur l'auto-instance : seule l'épuration des tags est faite, ce qui est
  conforme au commentaire ; les documents sont bien supprimés en base par la boucle `Lg.Supprime(False)`.
  Défaut restant : le fichier reste sur le disque. Remplacement par `LGed.EpurationTags()` (ARTICLES-015) · appelants : `Articles` ·
  tests : replay de la suppression d'article (lot Gestion/Tables) · sources : [Articles.class:4126](../../../../.src/Gestion/Tables/Articles.class#L4126)
