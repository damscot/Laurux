# Lcr — Rework

> Source : `.src/Gestion/Lcr/Lcr.class` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/Lcr.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 562 |
| Lignes de commentaire | 45 |
| Fonctions | 48 |
| Fonctions Public | 48 |
| Complexité cyclomatique totale | 121 |
| Complexité max (fonction) | 17 (`Imp_Lcr`) |
| Variables globales | 0 |
| Variables Public | 4 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 562 | 121 | 17 | 0 | 48 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] LCR-001 — [documentation] En-tête en français : place de l'écran dans la chaîne LCR
  (traites → `Fiches_Lcr` → attribution → bordereau → fichier bancaire), sens des colonnes
  `banque`/`bordereau`/`codeentree`, rôle de `Bsel`/`Bval` (écrits par `TriCpt`) · appelants :
  aucun · tests : aucun · sources : [Lcr.class:_New](../../../../../.src/Gestion/Lcr/Lcr.class#L57-L85)
- [ ] LCR-002 — [code mort] Supprimer `Deb3`, les impressions `Draw` `Level1`, `Level2`, `Level3`,
  `Level4`, les membres `sCmpt`, `sdesg`, `tab`, `rs1`, `txt`, `B`, `rResult`, `sel`, `Dbl`,
  `CoulB`, `CoulF`, `Fnt`, `CoulZns`, `CoulZnaf`, `Coulfond`, `Dte1`, `PosX` s'ils restent
  inutilisés après vérification, et les locales inutilisées (`Imp_Lcr`, `Imp_Traites`,
  `Button2_Click`, `Button10_Click`, `_New`) · appelants : aucun · tests : T01-T10 ·
  sources : [Lcr.class:Deb3](../../../../../.src/Gestion/Lcr/Lcr.class#L291-L297), [Lcr.class:Level1](../../../../../.src/Gestion/Lcr/Lcr.class#L661-L686), [Lcr.class:Level2](../../../../../.src/Gestion/Lcr/Lcr.class#L689-L709), [Lcr.class:Level3](../../../../../.src/Gestion/Lcr/Lcr.class#L712-L735),
  [Lcr.class:Level4](../../../../../.src/Gestion/Lcr/Lcr.class#L738-L756), [Lcr.class:51](../../../../../.src/Gestion/Lcr/Lcr.class#L51)
- [ ] LCR-003 — [réduction de portée] `Entete`, `Tris`, `Deb2`, `Refresh`, `CleanChamps`,
  `Maj_Zones`, `compte`, `compteman`, `Imp_Traites`, `Imp_Lcr` → `Private` (`ColLcr_Click` et les
  handlers restent `Public`, `Bsel`/`Bval` aussi) · appelants : aucun · tests : T01-T10 ·
  sources : [Lcr.class:Tris](../../../../../.src/Gestion/Lcr/Lcr.class#L265-L281), [Lcr.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Lcr.class#L594-L658), [Lcr.class:Imp_Traites](../../../../../.src/Gestion/Lcr/Lcr.class#L522-L591)
- [ ] LCR-004 — [complexité] `ColLcr_Data` : initialiser `Lcrtable` une fois dans `_New` ; même
  affichage · appelants : aucun · tests : T01, T02 · sources : [Lcr.class:ColLcr_Data](../../../../../.src/Gestion/Lcr/Lcr.class#L230-L263)
- [ ] LCR-005 — [séparation traitement/GUI] Extraire `ImporteTraites() As Integer`,
  `EnregistreLcr(…)`, `SupprimeLcr(lind)` et la requête de `Imp_Lcr` dans des fonctions sans accès
  aux contrôles ; SQL inchangé · appelants : aucun · tests : T03-T09 ·
  sources : [Lcr.class:Button10_Click](../../../../../.src/Gestion/Lcr/Lcr.class#L380-L404), [Lcr.class:Button3_Click](../../../../../.src/Gestion/Lcr/Lcr.class#L409-L426), [Lcr.class:Button2_Click](../../../../../.src/Gestion/Lcr/Lcr.class#L431-L447),
  [Lcr.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Lcr.class#L594-L658)
- [ ] LCR-006 — [commonalisation] Boucle d'impression d'une liste de LCR commune avec
  `Attribution.Imp_Lcr` et `Preparation.Imp_Lcr` (paramètres : résultat, titre, niveau avec ou sans
  banque, réimpression de l'en-tête) ; PDF identiques · appelants : aucun · tests : T09 et replays
  d'impression d'`Attribution`/`Preparation` · sources : [Lcr.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Lcr.class#L594-L658),
  [Attribution.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Attribution.class#L646-L705), [Preparation.class:Imp_Lcr](../../../../../.src/Gestion/Lcr/Preparation.class#L767-L837)
- [ ] LCR-007 — [commonalisation] `compteman` (intitulé du compte client), `Maj_Zones` (lecture
  d'une LCR par `lind`) communs avec `Attribution` et `Preparation` (fonctions partagées appelées
  par les handlers, noms de handlers inchangés) · appelants : aucun · tests : T02, T10 ·
  sources : [Lcr.class:compteman](../../../../../.src/Gestion/Lcr/Lcr.class#L491-L498), [Attribution.class:compteman](../../../../../.src/Gestion/Lcr/Attribution.class#L616-L623), [Preparation.class:compteman](../../../../../.src/Gestion/Lcr/Preparation.class#L738-L745)
- [ ] LCR-008 — [commonalisation] `Imp_Traites` et `Traites.class` : fonction commune paramétrée
  (fichier de sortie, pas vertical, mode de purge, format de date) produisant des PDF et des purges
  identiques à l'existant · appelants : `Traites` (lot Impressions) · tests : T06 et tests de
  `Traites` · sources : [Lcr.class:Imp_Traites](../../../../../.src/Gestion/Lcr/Lcr.class#L522-L591)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] LCR-A01 — [anomalie] `Imp_Traites` lit la clé `"/Soc" & "/Lcr"` (sans code société) au lieu
  de `"/Soc" & Start.Societe & "/Lcr"` (comme `Traites.class` et `Fmenu`) : la purge des traites
  est toujours proposée. Intention à confirmer (dans cet écran, la purge après import est
  souhaitable) · tests : T06 · sources : [Lcr.class:581](../../../../../.src/Gestion/Lcr/Lcr.class#L581)
- [ ] LCR-A02 — [anomalie] Import des traites sans déduplication : si la purge est refusée, un nouvel
  import duplique les LCR (elles partiront deux fois à la banque si elles sont attribuées) ·
  tests : T07 · sources : [Lcr.class:Button10_Click](../../../../../.src/Gestion/Lcr/Lcr.class#L380-L404)
- [ ] LCR-A03 — [anomalie] SQLite : `insert … value (…)` et `TRUNCATE` ne sont ni acceptés par
  SQLite ni traduits par `DB_Connection` : création, import et purge impossibles en mode portable ·
  tests : T11 · sources : [Lcr.class:390](../../../../../.src/Gestion/Lcr/Lcr.class#L390), [Lcr.class:414](../../../../../.src/Gestion/Lcr/Lcr.class#L414), [Lcr.class:583](../../../../../.src/Gestion/Lcr/Lcr.class#L583)
- [ ] LCR-A04 — [anomalie] `Imp_Traites` : le pas vertical (10 + 5 par ligne d'adresse) est inférieur
  à la hauteur fixe de `Ccompta.Level2T` (25 mm) → blocs superposés pour les adresses incomplètes
  (`Traites.class` utilise 25) · tests : T06 · sources : [Lcr.class:566](../../../../../.src/Gestion/Lcr/Lcr.class#L566), [Lcr.class:570](../../../../../.src/Gestion/Lcr/Lcr.class#L570)
- [ ] LCR-A05 — [anomalie] `Imp_Lcr` imprime toutes les LCR de la table (y compris attribuées et
  remises) alors que l'écran n'affiche que les non attribuées ; en-tête de colonnes absent après un
  saut de page ; adresse de la LCR précédente utilisée si le client est introuvable · tests : T09 ·
  sources : [Lcr.class:612](../../../../../.src/Gestion/Lcr/Lcr.class#L612), [Lcr.class:643](../../../../../.src/Gestion/Lcr/Lcr.class#L643)
- [ ] LCR-A06 — [anomalie] `Button2_Click` sans ligne sélectionnée : erreur non interceptée
  (`ColLcr[-1, 8]`) ; `Button3_Click` affiche « cliquer sur Créer » pour toute erreur, y compris une
  modification sans sélection · tests : T05 · sources : [Lcr.class:Button2_Click](../../../../../.src/Gestion/Lcr/Lcr.class#L431-L447), [Lcr.class:423](../../../../../.src/Gestion/Lcr/Lcr.class#L423)
- [ ] LCR-A07 — [anomalie] `Bsel` n'est pas remis à `False` avant `TriCpt` : une recherche annulée
  réapplique le compte choisi lors de la recherche précédente · tests : T10 · sources :
  [Lcr.class:compte](../../../../../.src/Gestion/Lcr/Lcr.class#L474-L486)
- [ ] LCR-A08 — [anomalie] Écran non instrumenté (`Utils.Observers(Me)` absent) : pas de journal ni
  de rejeu ; l'ajout modifie le log produit (nécessaire aux replays T01-T11) · tests : T01-T11 ·
  sources : [Lcr.class:_New](../../../../../.src/Gestion/Lcr/Lcr.class#L57-L85)
