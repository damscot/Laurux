# Btqart — Rework

> Source : `.src/Gestion/Tables/Btqart.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Btqart.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 153 |
| Lignes de commentaire | 35 |
| Fonctions | 12 |
| Fonctions Public | 12 |
| Complexité cyclomatique totale | 53 |
| Complexité max (fonction) | 17 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 153 | 53 | 17 | 0 | 12 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BTQART-001 — [documentation] En-tête en français (le nom de fichier de l'en-tête est
  `Btqqart.class`) : rôle, fichiers produits (`~/Prd.csv`, `~/Photo.csv`), table de travail
  `Art_Saisis`, paramètres `/Soc<XX>/…`, dépendance à `wput` · appelants : aucun · tests : T01 ·
  sources : [Btqart.class:_New](../../../../../.src/Gestion/Tables/Btqart.class#L40-L68)
- [ ] BTQART-002 — [code mort] Supprimer `ChkInput` (aucun appel, `unused` confirmé par grep), les
  variables `CoulZns`, `CoulZnaf`, `CoulFc` (écrites, jamais lues) et le second `Me.Center` ·
  appelants : aucun · tests : T01 · sources : [Btqart.class:ChkInput](../../../../../.src/Gestion/Tables/Btqart.class#L204-L212), [Btqart.class:32-34](../../../../../.src/Gestion/Tables/Btqart.class#L32-L34), [Btqart.class:61](../../../../../.src/Gestion/Tables/Btqart.class#L61)
- [ ] BTQART-003 — [commonalisation] Helper privé `RazSaisie()` : `DROP`/`CREATE` de `Art_Saisis` et
  ouverture des deux fichiers, appelé par `_New` et `Button2_Click` (SQL émis identique) ·
  appelants : aucun · tests : T01, T05 · sources : [Btqart.class:_New](../../../../../.src/Gestion/Tables/Btqart.class#L40-L68), [Btqart.class:Button2_Click](../../../../../.src/Gestion/Tables/Btqart.class#L172-L202)
- [ ] BTQART-004 — [séparation traitement/GUI] Fonction pure `LigneProduit(rArt, sLibFam, sTaux) As
  String` (texte identique, `";" ""` remplacé par `";"`) et `AjouteArticle(sCode, bPhoto) As String`
  (SQL + écriture des fichiers) appelée par `Button4_Click` ; `rarts`/`rtva`/`rfam` deviennent des
  locales · appelants : aucun · tests : T01, T02, T06 · sources : [Btqart.class:Button4_Click](../../../../../.src/Gestion/Tables/Btqart.class#L153-L167), [Btqart.class:Art_man](../../../../../.src/Gestion/Tables/Btqart.class#L124-L148), [Btqart.class:159](../../../../../.src/Gestion/Tables/Btqart.class#L159)
- [ ] BTQART-005 — [réduction de portée] `SelectionArt` et `Art_man` → `Private` ; `Bsel`/`Bval`
  restent `Public` (écrits par `TriArticles` via `Object.SetProperty`) · appelants : aucun ·
  tests : T01, T03 · sources : [Btqart.class:SelectionArt](../../../../../.src/Gestion/Tables/Btqart.class#L77-L88), [Btqart.class:Art_man](../../../../../.src/Gestion/Tables/Btqart.class#L124-L148)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] BTQART-A01 — [anomalie] `Button2_Click` transfère `Prd.csv` par un chemin **relatif** alors
  que le fichier est écrit dans `User.Home` : l'envoi échoue (ou envoie un autre fichier) si le
  répertoire courant n'est pas le répertoire personnel · tests : T05 · sources : [Btqart.class:62](../../../../../.src/Gestion/Tables/Btqart.class#L62), [Btqart.class:182](../../../../../.src/Gestion/Tables/Btqart.class#L182)
- [ ] BTQART-A02 — [anomalie] Identifiant et mot de passe FTP en clair sur la ligne de commande
  (`ps`) et non échappés, chemins de photos non quotés (espace → échec) ; mot de passe stocké en
  clair dans `Laurux.conf` (`Prefs`) · tests : T05 · sources : [Btqart.class:182](../../../../../.src/Gestion/Tables/Btqart.class#L182), [Btqart.class:185](../../../../../.src/Gestion/Tables/Btqart.class#L185), [Prefs.class:652](../../../../../.src/Communs/Prefs.class#L652)
- [ ] BTQART-A03 — [anomalie] Code retour de `wput` ignoré : « Transfert terminé ! » s'affiche et
  la sélection est effacée même en cas d'échec · tests : T05 · sources : [Btqart.class:Button2_Click](../../../../../.src/Gestion/Tables/Btqart.class#L172-L202)
- [ ] BTQART-A04 — [anomalie] `Button4_Click` lit la TVA et la famille sans tester `Available` :
  article dont la famille ou le code TVA n'existe pas → erreur d'exécution non interceptée (le code
  est déjà inséré dans `Art_Saisis`) · tests : T02 · sources : [Btqart.class:157](../../../../../.src/Gestion/Tables/Btqart.class#L157), [Btqart.class:158](../../../../../.src/Gestion/Tables/Btqart.class#L158)
- [ ] BTQART-A05 — [anomalie] Champs CSV non échappés : une désignation ou des caractéristiques
  contenant `;` ou un retour à la ligne décalent les colonnes de `Prd.csv` · tests : T06 · sources : [Btqart.class:159](../../../../../.src/Gestion/Tables/Btqart.class#L159)
- [ ] BTQART-A06 — [anomalie] `button4_KeyPress` relance l'enregistrement pour **toute** touche
  pressée sur `Button4` (Tab, flèches…) : message « Cet article n'existe pas ! » après un
  enregistrement (à confirmer, ainsi que le double déclenchement avec l'activation native par
  Entrée/Espace) · tests : T04 · sources : [Btqart.class:button4_KeyPress](../../../../../.src/Gestion/Tables/Btqart.class#L90-L94)
