# Tricp — Dépendances

> Source : `.src/Affichages/Tricp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Affichages/Tricp.class` — classe, formulaire associé `Tricp.form`
- Handlers GUI détectés : 18
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colco_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/FClientcarte.class` | `<type>` |
| `.src/Gestion/Facturation/Facture.class` | `<type>` |
| `.src/Gestion/Tables/FClient.class` | `<type>` |
| `.src/Gestion/Tables/FFournisseur.class` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Doc` | `Open` |
| `FClient` | `Bsel`, `Bureaudistributeur`, `Codepostal` |
| `FClientcarte` | `<hérité>` |
| `FFournisseur` | `Bsel`, `Bureaudistributeur`, `Codepostal` |
| `Utils` | `Base2`, `ObsGotf`, `ObsLstf`, `Observers`, `Obstch`, `rs2` |
| `Variables` | `Bsel`, `Bureaudistributeur`, `codepostal` |

### Tables SQL référencées

`Fiches_Cpostaux`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deplacement`, `Tris`, `Dbclk`, `Deb2`, `Deb3`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelants (`New Tricp(…)`, 8 appels dans 4 fichiers)** : `FClient:2642` (`Cpman`), `:2805`
  (`ToggleButton5_Click`), `:2821` (`ToggleButton6_Click`) avec `"Client"` ; `FFournisseur:2382`
  (`ToggleButton3_Click`, `"Fournisseur"`) ; `Facture:2577` (`Cpman`) et `:2679`
  (`ToggleButton8_Click`) avec `"Facture"` ; `FClientcarte:924` (`Cpman`, `"Client"`) et `:1015`
  (`ToggleButton5_Click`, `"Clientcarte"`).
- **Écritures sortantes non paramétrées** (accès `Classe.membre` à des classes à formulaire) :
  `FClient.Bsel/codepostal/Bureaudistributeur` (l. 132-134), `FFournisseur.…` (l. 136-138, signal
  `auto_instance` : `Facture:5658` ouvre aussi `New FFournisseur`), `FClientcarte.…` (l. 140-142 :
  membres **inexistants**, erreur « Unknown symbol » vérifiée avec gbs3, FCLIENTCARTE-A02),
  `Variables.Bsel/codepostal/Bureaudistributeur` (l. 144-146). `deps.py` ne signale pas les
  symboles inexistants de `FClientcarte` (le compilateur non plus : résolution à l'exécution).
- Ces membres doivent rester `Public` : `FClient.Bsel`, `Codepostal`, `Bureaudistributeur`
  (l. 68-71), `FFournisseur.Bsel`, `Codepostal`, `Bureaudistributeur` (l. 65-68), `Variables.Bsel`,
  `codepostal`, `Bureaudistributeur`.
- **État global partagé** : `Utils.rs2` (également utilisé par `Tricartes`, `TriclientsD`,
  `TriEqu`, `TriMat` et d'autres listes) ; chaîne d'ouverture possible
  `Tricartes` → `FClientcarte` → `Tricp`.
- **Signaux `deps.py`** : `replay_dynamic` = `colco_Click` (doit rester `Public`) ;
  `scope_reducible` = `Deplacement`, `Tris`, `Dbclk`, `Deb2`, `Deb3` (vérifié par grep : aucun
  appel externe) ; aucun `unused`, `arity_errors`, `replay_missing`.
- **Lien entrant** : la documentation de `FClientcarte` pointe vers ce dossier
  (`../../Affichages/Tricp.class/architecture.md`, résolu).
- **Ordre de rework** : TRICP-A01 (passage de l'appelant en paramètre) modifie les 4 appelants et
  doit être traité avec FCLIENTCARTE-A02 et FFOURNISSEUR-A07 ; les reworks internes sont
  indépendants.
