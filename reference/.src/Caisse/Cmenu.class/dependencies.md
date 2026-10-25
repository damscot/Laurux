# Cmenu — Dépendances

> Source : `.src/Caisse/Cmenu.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Cmenu.class` — classe, formulaire associé `Cmenu.form`
- Handlers GUI détectés : 18
- ⚠️ Appels dynamiques (Object.Call/New, Class.Load…) lignes : [254](../../../../.src/Caisse/Cmenu.class#L254)

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<type>` |
| `.src/Start.module` | `<type>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Attrib` | `<hérité>` |
| `Caisse` | `<type>` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `DB_Log` | `<type>` |
| `Doc` | `Open` |
| `Fmenu` | `<hérité>` |
| `Fondcaisse` | `<type>` |
| `LDate` | `_call` |
| `LauruxConf` | `<hérité>` |
| `Ouverture` | `<hérité>` |
| `Preferences` | `<hérité>` |
| `Start` | `$tcai`, `Arg_Pos`, `LocalSettings`, `Societe`, `UnLock`, `son`, `version_branch`, `version_sha1` |
| `Utils` | `Observers`, `db`, `glb`, `monteTunnel` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Caisses`, `Fiches_ClientCaisse`, `Fiches_EntTicketz`, `Fiches_Societes`, `Fiches_Vendeurs`

### Membres Public sans usage externe détecté (portée réductible ?)

`SetObservers`, `ControleCai`, `Config`, `mdp_admin2`, `mdp_admin3`, `init_ecole`, `Soc`, `intitule`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants (2) : `Start.Lancement` (`New Cmenu`, mode `-p`, [Start.module:307](../../../../.src/Start.module#L307)) et
  `Fmenu.Menu332_Click` (`New Cmenu` puis `Object.Call(CMenu, "Show")`, [Fmenu.class:2541](../../../../.src/Communs/Fmenu.class#L2541)).
  `Start` appelle aussi `Object.Call(Menu, "Show")` et `Object.GetProperty(Menu, "Window")` :
  seuls `Show` et `Window` (hérités de `Form`) sont utilisés dynamiquement.
- `Start.$tcai` (lu par `ControleCai`) : membre préfixé par `$`, désormais résolu par `deps.py`
  (il manquait au `deps.json` initial).
- Auto-instances (`<hérité>`) : `Fmenu.text` (CMENU-A01, FMENU-A13), `Ouverture.ShowModal`,
  `Preferences.ShowModal`, `Attrib.ShowModal`, `LauruxConf.ShowModal`. `Ouverture` et `Clavier`
  partagent l'auto-instance d'`Ouverture` (`Clavier` écrit `Ouverture.Mdp.Text`) : ne pas
  remplacer `Ouverture.ShowModal()` par `New Ouverture` sans traiter `Clavier`.
- Appel dynamique : `Object.Call(OCaisse, "Show")` (ligne 254) sur `New Caisse`.
- Tables : `Fiches_ClientCaisse` et `Fiches_EntTicketz` écrits en dur ; `deps.py` les détecte
  (littéraux), mais la seconde n'apparaît que dans une instruction inatteignable (`Quit 1` avant).
- Lecture de `Fiches_ClientCaisse` dupliquée dans `Fclientc`, `Moulinage:1528`, `BordereauxC:242` :
  helper `CompteClientCaisse()` (FCLIENTC-005), à reworker dans le même commit.
- Contrat avec `Ouverture` : format de `/Soc<XX>/caisse/Ncai` = `<caisse>;<vendeur sur 2 car.>`
  et fichier `~/Caisse<caisse>.lock` ; `Cmenu` relit le premier champ et supprime le fichier.
- Ordre de rework : après `Fmenu` (FMENU-A13), `Ouverture` (module de connexion commun) et
  `Fondcaisse` ; les commonalisations transverses (survol des boutons, `LVendeur`) avant.
