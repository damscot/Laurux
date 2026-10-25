# VarMajTar — Dépendances

> Source : `.src/Gestion/Stock/VarMajTar.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Stock/VarMajTar.class` — classe
- Handlers GUI détectés : 0
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Delete`, `SauvColl`
- Fonctions mortes par transitivité (appelées seulement depuis du code mort) : `affecttar`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Entrées/Achat.class` | `<type>` |
| `.src/Gestion/Entrées/GesTar.class` | `<type>`, `DateTarif`, `IgnoreTarif`, `LecArt`, `MajTar`, `ResArt`, `TarCli`, `TarGen`, `TarTcli` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Exec`, `Execute`, `Set` |
| `GesTar` | `SupLigne`, `TarGen` |
| `LDate` | `<type>`, `_call` |
| `LPrix` | `<type>`, `Add_Taxe`, `G`, `PuNHT`, `PuNTC` |
| `LTaxe` | `<type>`, `Remise`, `TVA` |
| `ObjProp` | `<type>`, `NomControl`, `name` |
| `SaiTableau` | `<type>` |
| `Sailig` | `<type>`, `AutresObj`, `MonControle`, `valide` |
| `Utils` | `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_TarTemp`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Delete`, `SauvColl`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Faux `unused`** (vérifiés par `grep`) :
  - `Delete` est appelée dynamiquement par `Sailig.Delete` (`Sailig.class:101-105`, boucle
    `Try obj.Delete` sur `AutresObj`) ;
  - `SauvColl` est appelée par `GesTar.Ligne_lostfocus` (`GesTar.class:230`) via un `Variant`
    (`$ligach.AutresObj[Achat.Tarif]`) ;
  - `affecttar` (`unused_transitive`) est donc vivante.
  Les deux membres `Public` restent `Public`.
- **Appels via `Variant` non vus** : `GesTar.class:754, 767, 772, 780, 782` écrivent
  `IgnoreTarif`/`DateTarif` à travers `AutresObj[Achat.Tarif]` ; `Achat.class:517, 622, 951`
  lisent ou écrivent `IgnoreTarif` de la même façon. `Achat` dépend donc de plus que `<type>`.
- **Dépendance d'ordre d'exécution** : `LecArt` exécute les requêtes préparées `requ_cli` et
  `requ_typ`, créées par `commande1._new` (`commande1.class:83-84`, `Utils.db.Prepare`). Toute
  instance n'est créée que dans ce contexte (`commande1` → `New Achat` → `Achat.ajout`).
  Le texte SQL des requêtes est donc défini dans [`commande1`](../commande1.class/architecture.md) :
  tables `Fiches_Tarcli`, `Fiches_TarTypcli`, `Fiches_Typec`, `Fiches_Cli` lues indirectement,
  absentes du bloc « Tables SQL ».
- **SQLite** : `DB_Connection.Execute` est cassé (DB_CONNECTION-A05) ; `DB_Connection.Set`
  stocke la variable dans un contexte d'`Eval`. Voir VARMAJTAR-A02.
- Tables citées en dur (`Fiches_Art`, `Fiches_Tvaav`, `Fiches_TarTemp`), sans `Cbase.Table`.
- Pas de dépendance circulaire au sens des appels, mais couplage fort `GesTar` ↔ `VarMajTar` ↔
  `Achat` (énumérations `GesTar.TarGen`/`SupLigne` utilisées ici, instance créée par `Achat`) :
  rework à planifier dans le même lot que GESTAR-008 (phase 3).
