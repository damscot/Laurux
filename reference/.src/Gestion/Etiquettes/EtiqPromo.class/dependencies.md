# EtiqPromo — Dépendances

> Source : `.src/Gestion/Etiquettes/EtiqPromo.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Etiquettes/EtiqPromo.class` — classe, formulaire associé `EtiqPromo.form`
- Handlers GUI détectés : 5
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Init`, `Connect`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colpromo_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `Cetiquettes` | `<type>`, `Barcode`, `Code`, `IntituleA`, `NewPage`, `PrixHt`, `PrixHtP`, `PrixTTC`, `PrixTTCP`, `Rectangle`, `Tva`, `volm` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `PdfWriter` | `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Utils` | `Cdate_Aff`, `Find_nbdec`, `Observers`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |
| `Zebra` | `Gondole1` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_ArtPromo`, `Fiches_Etiquettes`, `Fiches_Promo`

### Membres Public sans usage externe détecté (portée réductible ?)

`init_ComboBox`, `Init`, `fin_impression`, `Imprime`, `pos_Etiq`, `Connect`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant** : `Fmenu.Menu225_Click` (`Fmenu.class:1939`, `EtiqPromo.ShowModal()`).
- **`unused`** : `Init` et `Connect` — confirmés par grep ; la branche `ConnZbr = True` d'`Imprime`
  et l'appel `Zebra.Gondole1` (l. 287) sont morts par conséquence.
- **`replay_dynamic`** : `Colpromo_Click` → `Public` (rejeu). Autres signaux vides.
- **`scope_reducible`** : `init_ComboBox`, `fin_impression`, `Imprime`, `pos_Etiq` confirmés ;
  `Init`, `Connect` traités comme code mort.
- **Homonyme** : dans `Init` et à l'appel Zebra, `Code`/`code` désigne le **TextBox** `Code` (code
  promotion) ; `code = ""` dans `Init` affecterait une chaîne à un contrôle (erreur probable, à
  confirmer) — sans effet, `Init` étant morte.
- **Tables** : `Fiches_Promo`, `Fiches_ArtPromo`, `Fiches_Art`, `Fiches_Etiquettes` (tous via
  `Cbase` sauf `init_ComboBox`/`Init`).
- **Dépendances externes** : `Visualiseur.Prog`, `Doc.Open`, `Shell "cd ~"`,
  `~/tmp/EtiqGond.pdf`, `Socket` (mort).
- **Ordre de rework** : après ETIQART-010 ; décision ZEBRA-A01.
