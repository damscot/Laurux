# Majversion — Rework

> Source : `.src/Communs/Majversion.class` · Message de commit (phase 4) : `reference/.src/Communs/Majversion.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 294 |
| Lignes de commentaire | 16 |
| Fonctions | 13 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 70 |
| Complexité max (fonction) | 21 (`Verif_Maj`) |
| Variables globales | 0 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 294 | 70 | 21 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MAJVERSION-001 — [documentation] En-tête en français : double rôle (écran de mise à jour et
  service de version sur l'auto-instance), fichiers temporaires, commandes `wget`/`tar`, contrat de
  `Version` · appelants : aucun · tests : aucun · sources : [Majversion.class:1-9](../../../../.src/Communs/Majversion.class#L1-L9), [Majversion.class:RecupVersion](../../../../.src/Communs/Majversion.class#L145-L156)
- [ ] MAJVERSION-002 — [code mort] Supprimer `_New` vide, la relecture de `ping.txt` (supprimé
  quelques lignes plus haut, test toujours vrai), la variable `VersionWeb` (calculée, jamais lue)
  et les noms d'événements `As "hClient"`/`As "hDoc"` sans handler · appelants : aucun · tests :
  T04-T06 · sources : [Majversion.class:_New](../../../../.src/Communs/Majversion.class#L12-L16), [Majversion.class:202-208](../../../../.src/Communs/Majversion.class#L202-L208), [Majversion.class:213](../../../../.src/Communs/Majversion.class#L213), [Majversion.class:28-29](../../../../.src/Communs/Majversion.class#L28-L29)
- [ ] MAJVERSION-003 — [commonalisation] Helper privé `ListeLiens(sUrl) As XmlElement[]` (GET
  synchrone + `GetElementsByTagName("a")`) pour `Form_Open` et `Update_Type` · appelants : aucun ·
  tests : T04, T05 · sources : [Majversion.class:Form_Open](../../../../.src/Communs/Majversion.class#L18-L60), [Majversion.class:Update_Type](../../../../.src/Communs/Majversion.class#L62-L128)
- [ ] MAJVERSION-004 — [commonalisation] `Verif_Maj` et `FRestore.Verif_Version` utilisent
  `RecupVersionApp()` au lieu de recalculer `"majeur.mineur"` · appelants : `FRestore` · tests :
  T01, T06, FRESTORE-T05 · sources : [Majversion.class:183-185](../../../../.src/Communs/Majversion.class#L183-L185), [FRestore.class:186-187](../../../../.src/Communs/FRestore.class#L186-L187)
- [ ] MAJVERSION-005 — [séparation traitement/GUI] Fonction pure privée
  `CompareVersions(aWeb, aApp) As Integer` (0 : rien, 1 : version, 2 : correctif) reproduisant la
  règle actuelle ; `Verif_Maj` garde les `Message.Question` · appelants : aucun · tests : T06 ·
  sources : [Majversion.class:214-238](../../../../.src/Communs/Majversion.class#L214-L238)
- [ ] MAJVERSION-006 — [séparation traitement/GUI] `RecupVersion` : extraire `LitVersionBase()`
  (SQL seul) ; table par `Cbase.Table("TabParam")`, SQL identique · appelants : `Fmenu`,
  `LauruxMaj` (inchangés) · tests : T02, T03 · sources : [Majversion.class:RecupVersion](../../../../.src/Communs/Majversion.class#L145-L156)
- [ ] MAJVERSION-007 — [réduction de portée] `Update_Type`, `Verif_Maj`, `Maj`, `Avancement` →
  `Private` · appelants : aucun · tests : T04-T07 (T07 passe alors par un replay de `Maj`, sinon
  `Avancement` reste `Public`) · sources : [Majversion.class:Update_Type](../../../../.src/Communs/Majversion.class#L62-L128), [Majversion.class:Verif_Maj](../../../../.src/Communs/Majversion.class#L173-L254), [Majversion.class:Maj](../../../../.src/Communs/Majversion.class#L256-L315), [Majversion.class:Avancement](../../../../.src/Communs/Majversion.class#L329-L367)
- [ ] MAJVERSION-008 — [complexité] `Maj` : construction de la fenêtre de progression dans un
  helper privé `FenetreProgression() As Form` ; suppression de `Shell "cd " & User.Home` (sans
  effet) · appelants : aucun · tests : aucun automatique (Maj non testable) · sources : [Majversion.class:Maj](../../../../.src/Communs/Majversion.class#L256-L315)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] MAJVERSION-A01 — [anomalie] `Verif_Maj` ne compare que le numéro mineur : une version
  `4.0` publiée n'est pas proposée à un poste en `3.69` · tests : T06 · sources : [Majversion.class:215](../../../../.src/Communs/Majversion.class#L215), [Majversion.class:220](../../../../.src/Communs/Majversion.class#L220)
- [ ] MAJVERSION-A02 — [anomalie] Site injoignable : `Verif_Maj` fait `Return` sans valeur (`Null`)
  et `Update_Type` lit `VersionWebArr.Length` → erreur non interceptée · tests : T04 · sources : [Majversion.class:198-200](../../../../.src/Communs/Majversion.class#L198-L200), [Majversion.class:115-116](../../../../.src/Communs/Majversion.class#L115-L116)
- [ ] MAJVERSION-A03 — [anomalie] Version web à deux composants avec mineur égal :
  `VersionWebArr[2]` hors bornes → `Catch` et message d'erreur (la compatibilité « ? » n'existe que
  dans `Update_Type`) · tests : T06 · sources : [Majversion.class:221](../../../../.src/Communs/Majversion.class#L221)
- [ ] MAJVERSION-A04 — [anomalie] `Form_Open` sans réseau : `Type.Current.Text` sur une liste vide
  (à confirmer : erreur `Null object`) · tests : T04 · sources : [Majversion.class:56-58](../../../../.src/Communs/Majversion.class#L56-L58)
- [ ] MAJVERSION-A05 — [anomalie] `Avancement` : attente active sans `Wait` sur l'apparition de
  `pb1.txt` (CPU à 100 %) et boucle infinie si le téléchargement échoue avant 100 % ; analyse du
  journal `wget` par positions de colonnes · tests : T07 · sources : [Majversion.class:339-340](../../../../.src/Communs/Majversion.class#L339-L340), [Majversion.class:342-363](../../../../.src/Communs/Majversion.class#L342-L363)
- [ ] MAJVERSION-A06 — [anomalie] `Maj` extrait l'archive dans `~` quel que soit
  `Application.Path` (alors que les `.old` sont créés dans `Application.Path`), `Kill` sans `Try`
  et son `son/warning.ogg` en chemin relatif (à confirmer : structure de l'archive) · tests :
  aucun automatique · sources : [Majversion.class:290-301](../../../../.src/Communs/Majversion.class#L290-L301), [Majversion.class:311](../../../../.src/Communs/Majversion.class#L311)
- [ ] MAJVERSION-A07 — [anomalie] `RecupVersion` lit `rResult!version` sans test `Available` ; avec
  `/Majver` actif, chaque démarrage déclenche un accès réseau bloquant (délai 5 s) et peut afficher
  `Message.Error` hors ligne · tests : T02, T03 · sources : [Majversion.class:149-152](../../../../.src/Communs/Majversion.class#L149-L152)
