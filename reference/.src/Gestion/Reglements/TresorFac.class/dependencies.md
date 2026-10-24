# TresorFac — Dépendances

> Source : `.src/Gestion/Reglements/TresorFac.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Reglements/TresorFac.class` — classe, formulaire associé `TresorFac.form`
- Handlers GUI détectés : 13
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Numcompte_GotFocus`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `ecritv`, `Journal_GotFocus`, `Numcompte_GotFocus`, `ToggleButton6_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `EcritL_Click`, `Ecrit3_Click`
- ⚠️ Classe jamais référencée (aucun appelant, nom absent des chaînes du projet) : code mort probable ; la suppression d'un couple .class + .form est une anomalie à valider
- ⚠️ Requêtes dont les arguments ne correspondent pas aux marqueurs `&N` : l. 159 (14 argument(s), marqueurs [1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15])
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `Ecrit1`

### Utilisé par

_Aucun usage externe détecté statiquement._

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Comptabilite` | `Bsel`, `sCmpt` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `FCalc` | `<type>`, `Resultat` |
| `Start` | `Musique`, `son` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client` |
| `Utils` | `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Observers`, `PointBase`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`Cleanchamps`, `Movt`, `compte`, `compteTiersman`, `Ecritures`, `Majnum`, `Lettrage`, `ecritv`, `Journal_GotFocus`, `Datej_GotFocus`, `Datej_LF`, `Numcompte_GotFocus`, `numcompte_LF`, `Montant_LF`, `numdoc_LF`, `QuitteDate`, `Button1_Click`, `ToggleButton4_Click`, `Button2_Click`, `Controle`, `ToggleButton6_Click`, `DelEcr`, `Lettre_Click`, `Quit_Click`, `Selct_Click`, `Necrit_Click`, `Clear`, `Suppr_Click`, `DelMvt`, `Calc_solde`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Aucun appelant** (vérifié) : `grep -rn "TresorFac" .src` ne renvoie que ce fichier et son
  `.form` ; absent de `Fmenu` (et de son historique git), du dispatcher `Prgm` (liste des noms
  l. 58-90), et d'aucune chaîne passée à `Object.New`/`Class.Load`. Confirme le signalement
  COMPTABILITE-A01 du lot Compta.
- **`Comptabilite.Bsel`/`sCmpt`** : lus l. 193-194 mais alimentés seulement par `TriEcritures` et
  `TriEcritures2` ; l'écran ouvre `TriCpt` (qui écrit `Bsel`/`Bval` sur la fenêtre appelante via
  `Object.SetProperty`, propriétés absentes de `TresorFac`). Dépendance fictive au module
  `Comptabilite`.
- **`Journaux()`** (l. 460) : appel de la classe `Journaux` (Compta/Impressions) comme fonction,
  sans `_call` ; non relevé par `deps.py` (ni `uses`, ni `arity_errors`). Branche morte (Tag 1
  absent du groupe `Cmpt`).
- `handlers_inactifs` : `Numcompte_GotFocus` (contrôle du groupe `Cmpt`, jamais levé) — vérifié
  dans `TresorFac.form:22` (`{ Numcompte TextBox Cmpt }`).
- `unused` : `ecritv`, `Journal_GotFocus`, `Numcompte_GotFocus`, `ToggleButton6_Click` — vérifiés
  (aucun contrôle `Journal`/`ToggleButton6`, aucun appel de `ecritv`). À ajouter : `Necrit_Click`
  n'est appelé que par `Btn_Click` Tag 1, qu'aucun bouton ne porte.
- `replay_dynamic` : `EcritL_Click`, `Ecrit3_Click` doivent rester `Public`. `Ecrit1` (ColumnView)
  n'a pas de `_Click` : un clic rejoué appellerait une méthode inexistante.
- `scope_reducible` contient des pseudo-handlers des groupes `Btn` et `Cmpt` (`Button1_Click`,
  `ToggleButton4_Click`, `Datej_GotFocus`…) : ils ne sont pas levés par Gambas (contrôles groupés)
  et sont bien réductibles ; les vrais handlers ne figurent pas dans la liste.
- Tables non relevées : aucune (toutes en dur).
- Dépendance de fond avec [`Tresor`](../../../Compta/Tresor.class/dependencies.md) (37 homonymes) :
  aucune contrainte d'ordre si le couple est supprimé.
