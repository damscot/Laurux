# Bordrx — Dépendances

> Source : `.src/Gestion/Lcr/Bordrx.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Bordrx.class` — classe, formulaire associé `Bordrx.form`
- Handlers GUI détectés : 11
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `ColBrd_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColLcr`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `CLcr` | `<type>`, `BasPage`, `Entete`, `Level1B`, `Level2B`, `Level3B`, `Level4B`, `Lines` |
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `EnvMail` | `Envoi2` |
| `Impression` | `<hérité>` |
| `LDate` | `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Base`, `Coulfd`, `Fcolr`, `Observers`, `Replace`, `cpoint`, `db`, `rs1` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Banques`, `Fiches_Bordereaux`, `Fiches_Cli`, `Fiches_Lcr`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Entete`, `Deb`, `Deb2`, `Gen_Bordereau`, `sCmpt`, `sdesg`, `Nb`, `sDate`, `iLind`, `ControleCombobox`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée : `Fmenu.MenuGbrd_Click` (`Bordrx.Show`, `Fmenu.class:2524`).
- **l. 383** : `Impression.Prog_Editeur` et `Start.Soc` n'existent pas (vérifié : `grep -n
  "Prog_Editeur" .src/Utils/Impression.module` sans résultat ; `Start.module` n'a pas de membre
  `Soc`). Déjà relevé par IMPRESSION-A03 ; `deps.py` ne signale ni membre inexistant d'un module ni
  `<inconnu>` ici (limite connue « membre inexistant d'un module »). La correction probable est
  `Visualiseur.Prog` ou `Editeur.Prog_Editeur` (`.src/Gestion/Impressions/Editeur.module`, éditeur de
  texte : inadapté à un PDF) avec `Start.Societe`.
- `replay_dynamic` : `ColBrd_Click` doit rester `Public`. `replay_missing` : `ColLcr` (`ColumnView`)
  sans `ColLcr_Click` → ne pas cliquer dans `ColLcr` pendant les scénarios.
- `scope_reducible` vérifié : `Tris`, `Entete`, `Deb`, `Deb2`, `Gen_Bordereau` (internes) ; `sCmpt`,
  `sdesg`, `Nb`, `sDate`, `iLind`, `ControleCombobox` (jamais utilisés).
- `EnvMail.Envoi2` (`.src/Gestion/Mails/EnvMail.module:155`, 4 à 6 paramètres) : appel à 5 arguments,
  arité correcte.
- Amont : `Preparation` écrit `Fiches_Bordereaux` et `Fiches_Lcr.bordereau` ; `Banque` fournit les
  coordonnées (longueurs non contrôlées). Ordre de rework : en dernier dans la chaîne LCR, après
  `CLcr` et `Preparation`.
