# Ouverture — Dépendances

> Source : `.src/Caisse/Ouverture.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Caisse/Ouverture.class` — classe, formulaire associé `Ouverture.form`
- Handlers GUI détectés : 9
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Rcai`, `Org`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Clavier.class` | `Button1_Click` |
| `.src/Caisse/Cmenu.class` | `<hérité>` |
| `.src/Caisse/Fondcaisse.class` | `Rvdr` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Clavier` | `<type>` |
| `DB_Connection` | `Exec` |
| `LDate` | `_call` |
| `Start` | `$tcai`, `LocalSettings`, `Musique`, `Societe`, `son` |
| `TestCaisses` | `TestCai` |
| `Utils` | `Observers`, `db` |
| `hexdblKey` | `Crypt` |

### Tables SQL référencées

`Fiches_Caisses`, `Fiches_Vendeurs`

### Membres Public sans usage externe détecté (portée réductible ?)

`SetObservers`, `Mdp_Vendeurs`, `Rcai`, `Org`, `$clav`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants (tous sur l'**auto-instance**) :
  - `Cmenu.Button1_Click` : `Ouverture.ShowModal()` ([Cmenu.class:150](../../../../.src/Caisse/Cmenu.class#L150)) ;
  - `Clavier.Clav_click` : `Ouverture.Mdp.text = $saisie` ([Clavier.class:16](../../../../.src/Caisse/Clavier.class#L16)) — contrôle `!Mdp` public dans le `.form` ;
  - `Clavier.Fermer_Click` : `Ouverture.Button1_Click()` ([Clavier.class:74](../../../../.src/Caisse/Clavier.class#L74)) ;
  - `Fondcaisse._new` : `Ouverture.Rvdr(Ncaisse)` ([Fondcaisse.class:30](../../../../.src/Caisse/Fondcaisse.class#L30)) —
    crée une instance cachée d'`Ouverture` si aucune n'existe (voir architecture.md).
- Le couplage par auto-instance avec `Clavier` interdit de remplacer `Ouverture.ShowModal()` par
  `New Ouverture` sans adapter `Clavier` dans le même commit.
- Écriture de `Start.$tcai` : désormais vue par `deps.py` (absente du `deps.json` initial).
- `TestCaisses.TestCai` renvoie un `String` (`"0"`/`"1"`) affecté au membre `b As Integer`
  (conversion implicite). `Dcaisses.TestCai` (même nom, autre module) n'a aucun appelant.
- Fichiers : `~/Caisse<n>.lock` (contrat partagé avec `Cmenu`, `TestCaisses`, `Dcaisses`).
- Paramètre `/Soc<XX>/caisse/Ncai` : écrit ici, lu par `Start.Lancement`, `Fmenu.Menu332_Click`,
  `Cmenu`, `Fondcaisse`, `Caisse` (format `<caisse>;<vendeur 2 car.>`).
- Ordre de rework : avec `Clavier` (auto-instance), `TestCaisses`, `Fondcaisse` (appelant de
  `Rvdr`), et après le helper `LVendeur` (ConVendeurs, Svendeur).
