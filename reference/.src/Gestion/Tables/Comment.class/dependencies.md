# Comment — Dépendances

> Source : `.src/Gestion/Tables/Comment.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Tables/Comment.class` — classe, formulaire associé `Comment.form`
- Handlers GUI détectés : 6
- ⚠️ Handlers nominaux inactifs (contrôle rattaché à un groupe d'événements du .form) : `Button3_Click`
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Button3_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `colcol_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/Facturation/Facture.class` | `<hérité>` |
| `.src/Gestion/Stock/MvtProdcomp.class` | `<hérité>` |
| `.src/Gestion/Stock/Mvtex.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Utils` | `Observers`, `ReplaceLb`, `SetEditColor`, `db` |

### Tables SQL référencées

`Fiches_Commentaires`

### Membres Public sans usage externe détecté (portée réductible ?)

`Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button3_Click`, `Button4_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée réels : `Fmenu.class:887` (`Comment.Show`) et `Facture.class:7818`
  (`Comment.ShowModal()` sur F4 dans la zone commentaire de la facture).
- **Faux positif** : `Mvtex.class:91`, `:362` utilisent le contrôle `Comment` de `Mvtex.form`
  (homonyme), pas ce formulaire.
- **Vérifié dans le lot Stock (MVTPRODCOMP-002)** : l'appel est réel mais latent (`RazBl` n'est jamais
  appelée) ; la ligne `MvtProdcomp` du tableau « Utilisé par » ne correspond donc à aucun usage effectif.
  Constat initial : `MvtProdcomp.class:78` (`RazBl`) appelle `Comment.clear` alors
  que `MvtProdcomp.form` n'a **aucun** contrôle `Comment` : l'appel vise donc l'auto-instance de ce
  formulaire (instanciation masquée, et `Clear` n'est pas une méthode de `Form` à notre
  connaissance : erreur d'exécution probable, à confirmer). Copie probable de `Mvtex`.
- Lecteurs de `Fiches_Commentaires` : `Facture` (`:7739`, `:7776`), `Dup` (`:263`).
- `Button3_Click` : handler inactif (contrôle groupé `Btn`) ; `Button1_Click`, `Button2_Click`,
  `Button4_Click` sont appelés uniquement par `Btn_Click`/`Btn_KeyPress`/`Lib_KeyPress`.
- `colcol_Click` rejoué par `ReplayObserver.Replay_Click` : doit rester `Public`.
- Ordre de rework : avec ComMail (module partagé).
