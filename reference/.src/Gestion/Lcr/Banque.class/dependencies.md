# Banque — Dépendances

> Source : `.src/Gestion/Lcr/Banque.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Lcr/Banque.class` — classe, formulaire associé `Banque.form`
- Handlers GUI détectés : 18
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbanque_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `TextReg` | `<form>`, `Name`, `Select`, `Text`, `reg` |
| `Utils` | `Base`, `Fcolr`, `ObsLstf`, `Remplace`, `db`, `rs1` |
| `chainage` | `<type>` |

### Tables SQL référencées

`Fiches_Banques`

### Membres Public sans usage externe détecté (portée réductible ?)

`Tris`, `Deb2`, `Deb3`, `Maj_Zones`, `Refresh`, `CleanChamps`, `code_LF`, `Dbclk`, `Ref`, `banques_man`, `Button3_Click`, `Button4_Click`, `Button7_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Point d'entrée unique : `Fmenu.MenuTbq_Click` (`Banque.Show`, `Fmenu.class:2500`), menu
  « Banque ».
- `scope_reducible` confirmé par `grep -rn "Banque\.\(Tris\|Deb\|Maj_Zones\|Refresh\|Button\)" .src` :
  aucun appel externe. `Button3_Click`, `Button4_Click`, `Button7_Click` sont des pseudo-handlers
  (contrôles du groupe `Btn`, `Banque.form` l. 8-36) : jamais levés par Gambas, appelés en interne.
- `replay_dynamic` : `Colbanque_Click` (grille `ColBanque`) doit rester `Public`.
- Écran non instrumenté (`Utils.Observers(Me)` absent) : voir BANQUE-A04.
- Données consommées ailleurs : `Fiches_Banques` est lue par `Attribution`, `Preparation`, `Bordrx`
  (fichier bancaire, bordereau, mail) et, via la clé absente `TabBanques`, par `Glcr` (CBASE-A01).
  Un changement du format des champs (longueurs) impacte directement le fichier généré par
  `Bordrx.Button3_Click` (paddings `String$`).
- Aucun appel dynamique ni dépendance circulaire ; indépendant des autres fichiers LCR.
