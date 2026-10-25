# MvtProdcomp — Dépendances

> Source : `.src/Gestion/Stock/MvtProdcomp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/MvtProdcomp.class` — classe, formulaire associé `MvtProdcomp.form`
- Handlers GUI détectés : 10
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `RazBl`, `Quantite`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colart_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Colrcp`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Comment` | `<hérité>` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `CDec`, `Cdate_Dbase`, `Find_cbarre`, `Observers`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Mvtexpdc`, `Fiches_PrdComp`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`CleanChamps`, `RazBl`, `art_man`, `SelectionArt`, `Quantite`, `qterecue_LF`, `Maj_qte`, `Maj_qtem`, `Maj_colrcp`, `Maj_Composants`, `Maj_qtec`, `Maj_qtemc`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.class:1971` (`Menu230_Click`, `MvtProdcomp.ShowModal()` après
  contrôle du tunnel de réplication).
- **`Comment.clear` (l. 78, `RazBl`) — confirmé** : `MvtProdcomp.form` n'a aucun contrôle
  `Comment` ; l'identifiant désigne donc la classe formulaire `.src/Gestion/Tables/Comment.class`
  (auto-instance), qui n'expose pas de `Clear` (méthodes : `_New`, `Form_Open`, `Maj_Zones`,
  `CleanChamps`, `Refresh`, handlers). L'appel échouerait à l'exécution, mais `RazBl` n'est
  jamais appelée (`unused`, vérifié par grep) : défaut latent, supprimé avec MVTPRODCOMP-002. La
  dépendance `Comment` « <hérité> » listée par `deps.py` (et dans
  `reference/.src/Gestion/Tables/Comment.class/dependencies.md`) est donc fictive.
- **`unused` vérifiés** : `RazBl`, `Quantite` (aucun appel, copies de `Mvtex`).
- **`replay_dynamic`** : `Colart_Click` est appelé par `ReplayObserver.Replay_Click` via
  `Object.Call` → doit rester `Public` (REPLAYOBSERVER-A06).
- **`replay_missing`** : `Colrcp` sans `Colrcp_Click` : ne pas cliquer dans la grille du journal
  pendant les scénarios.
- **Tables** : `Fiches_Art` (lecture et **écriture** de `art_qte`, produit et composants),
  `Fiches_Mvtexpdc` (écriture, `UPDATE` latents), `Fiches_PrdComp` (lecture) ; `Fiches_Tvaav`
  n'est citée que dans une affectation inutilisée (`Tab2`, faux positif).
- **Lecteurs de `Fiches_Mvtexpdc`** : `Cstock` (recalcul de `art_qte`), `Stockmvt:119-120`,
  `Edregulprdc`, `Articles:545`, `Changefam:530`.
- **Cohérence avec Prodcomposes** : `Prodcomposes` gère `Fiches_PrdComp` (nomenclature) et
  recalcule le PMP à l'affichage (PRODCOMPOSES-A01/A02) ; `MvtProdcomp` ne lit que `codec`/`qte`
  et ne touche pas au PMP. Les docs de `Prodcomposes` citent `MvtProdcomp` en texte (« lot
  Stock ») : le lien `../../Stock/MvtProdcomp.class/architecture.md` peut désormais être posé.
- **Ordre de rework** : indépendant ; commonalisation « saisie d'article » avec `Mvtex`,
  `MvtDepots`, `Sdepots` (MVTEX-008).
