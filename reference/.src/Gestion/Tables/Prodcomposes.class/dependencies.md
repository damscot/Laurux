# Prodcomposes — Dépendances

> Source : `.src/Gestion/Tables/Prodcomposes.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Prodcomposes.class` — classe, formulaire associé `Prodcomposes.form`
- Handlers GUI détectés : 15
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Code_KeyPress`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Code_KeyPress`, `CalcTTC`, `CalcHt`, `Calc_coeff`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colprdc_Click`, `Colartprdc_Click`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `Recup_Tva`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Articles` | `<hérité>` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `son` |
| `TriArticles` | `<type>` |
| `Utils` | `Base`, `Fcolr`, `Find_nbdec`, `Observers`, `cpoint`, `db`, `rs1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Ligbl`, `Fiches_Mo`, `Fiches_PrdComp`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Code_KeyPress`, `Cprdcomp`, `Cmpt_LF`, `Deb2`, `CleanChamps`, `delArt`, `SelectionArt`, `ChkPrx`, `Art_Man`, `CalcTTC`, `CalcHt`, `Recup_Tva`, `Calc_Pmp`, `Calc_coeff`, `Calc_Marge`, `Calc_Prvt`, `SelectionMo`, `Mo_man`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée unique : `Fmenu.Menu227_Click` (`.src/Communs/Fmenu.class:1951`,
  `Prodcomposes.ShowModal()` sur l'auto-instance). Aucun membre appelé de l'extérieur, hormis
  `Bsel`/`Bval`.
- **Appel dynamique entrant** : `TriArticles` (`.src/Affichages/TriArticles.class:30-31`,
  `165-166`) écrit `Bsel`/`Bval` par `Object.SetProperty(Obj, "Bsel"|"Bval", …)` sur l'objet passé
  en dernier argument (`Me`). Ces deux membres doivent rester `Public` ; `deps.py` ne les signale
  pas en portée réductible (chaînes protégées), c'est correct.
- `New TriArticles(…)` avec 9 arguments pour 8 paramètres déclarés : correct. Règle Gambas
  vérifiée par un essai (`gbc3`/`gbx3`) : les paramètres obligatoires de la classe fille sont
  consommés d'abord, puis ceux du constructeur hérité (`Form` : `Parent`, ici `Null`), puis les
  optionnels de la fille (`Dispo`, `Mat`, `ob = Me`). `deps.py` a raison de ne pas lever d'erreur
  d'arité.
- `Articles.ShowModal()` (F4) : ouvre l'auto-instance d'`Articles` (`_New(Optional prod)`), sans
  argument ; dépendance modale vers un très gros écran.
- **Écritures dans `Fiches_Art`** (`Calc_Pmp` : `art_pbht`, `art_pauaht`, `art_pmp`, `art_prvt`,
  `art_coef`) à chaque affichage d'un produit composé : tout rework de la fiche article ou du
  calcul de PMP doit repasser PRODCOMPOSES-T02/T03. `deps.py` liste `Fiches_Art` mais pas le fait
  qu'elle soit modifiée.
- Autres fichiers manipulant `Fiches_PrdComp` : `Facture.class:6773` (décomposition à la
  facturation), `Articles.class:525`, `MvtProdcomp` (mouvements de stock), `Changefam.class:532-533`
  (renommage de code), `Statbase`. Tables listées par `deps.py` : `Fiches_Tvaav` n'est lue que par
  `Recup_Tva` (code mort) ; `Fiches_Ligbl` seulement par le contrôle de retrait.
- `Code_KeyPress` : handler inactif confirmé (`Code` a le groupe `Cmpt` dans le `.form`).
  `CalcTTC`, `CalcHt`, `Calc_coeff` (signalés `unused`) et `Recup_Tva` (appelée seulement par les
  deux premiers) sont morts.
- `Utils.rs1` partagé avec la grille d'`Articles` : après `Articles.ShowModal()` (F4), `Articles`
  a pu remplacer `rs1` ; `Colartprdc_Data` relirait alors un autre résultat jusqu'au prochain
  `Deb2` (à confirmer par T05).
- Rejeu dynamique (REPLAYOBSERVER-A06) : `Colprdc_Click`, `Colartprdc_Click` restent `Public`.
- Ordre de rework : indépendant ; la commonalisation de `Calc_Marge` avec `Materiel` suit
  MATERIEL-007.
