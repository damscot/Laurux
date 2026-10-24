# GesTar — Dépendances

> Source : `.src/Gestion/Entrées/GesTar.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Entrées/GesTar.class` — classe, formulaire associé `GesTar.form`
- Handlers GUI détectés : 20

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Gestion/Entrées/DateTar.class` | `TarCli`, `TarGen`, `TarTcli` |
| `.src/Gestion/Stock/VarMajTar.class` | `SupLigne`, `TarGen` |
| `.src/Gestion/Stock/commande1.class` | `<type>`, `Delete`, `EnrArt`, `EnrEtiqu`, `EnrTar`, `EnrTarTemp`, `LecArt`, `SupTarTemp`, `TarCli`, `TarTcli`, `ligachat` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Achat` | `FicheArt`, `Tarif` |
| `Articles` | `<type>` |
| `DB_Connection` | `Create9`, `Edit`, `Exec` |
| `EtiqRecpt` | `<hérité>` |
| `LDate` | `<type>`, `Avant`, `G`, `GnT`, `_call` |
| `LPrix` | `<type>`, `Add_Taxe`, `Arr_0001`, `G`, `Mnt`, `PuBHT`, `PuNHT`, `PuNTC` |
| `LTaxe` | `<type>`, `Marge`, `Remise`, `TVA` |
| `ObjProp` | `<type>`, `AddChamp`, `Button`, `Height`, `Width` |
| `SaiTableau` | `$prop`, `<type>`, `Delete`, `Netoyage`, `VisibleChoi`, `VisibleTot`, `VisibleTuto`, `ajout`, `ind`, `ligne`, `show` |
| `Sailig` | `<type>`, `AutresObj`, `Ind`, `MonControle`, `Y`, `chain`, `lecture`, `prx`, `valide` |
| `TextReg` | `<form>`, `EstDate`, `EstNum`, `Type`, `dte` |
| `TriCpt` | `<type>`, `Client`, `Sans_Solde` |
| `Utils` | `db`, `totobs` |
| `VarMajTar` | `<type>`, `DateTarif`, `IgnoreTarif`, `LecArt`, `MajTar`, `ResArt`, `TarCli`, `TarGen`, `TarTcli` |
| `chainage` | `sup` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Cli`, `Fiches_EtiGond`, `Fiches_EtiProd`, `Fiches_TarTemp`, `Fiches_TarTypcli`, `Fiches_Tarcli`, `Fiches_Tvaav`, `Fiches_Typec`

### Membres Public sans usage externe détecté (portée réductible ?)

`EnrTarArt`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Seul instanciateur** : `commande1:66` (`New GesTar(Ptarif) As "Tarif"`, formulaire incrusté).
  Événements reçus par `commande1` : `EnrTar` (`Tarif_EnrTar`, `commande1:867`), `CoulBout`
  (`Tarif_CoulBout`, `commande1:884`). Le préfixe `Tarif` est aussi celui des trois `SaiTableau`
  internes (`Tarif_ajou` dans `GesTar`).
- **Faux positifs `unused` / `scope_reducible`** : `Enreg_Click` et `majtarif_Click` sont les
  handlers des contrôles `!Enreg` et `!majtarif` du `.form` (le `!` marque un contrôle public) :
  `deps.py` ne reconnaît pas ces noms de contrôles. Ils doivent rester `Public`.
- **Handlers d'observateurs** non liés au `.form` : `ligne_gotfocus`, `Ligne_lostfocus`,
  `ligne_SupLig` (`New Observer(sl) As "Ligne"`), `Coef_lostfocus`, `Px_HT_lostfocus`,
  `Px_TTC_lostfocus`, `Rechc_click`, `Numero_lostfocus`, `Recht_click`, `Type_lostfocus`
  (observateurs de `Tarif_ajou`/`_ready`), `ListView_click`/`ListView_keypress` (ListView créé
  `As "ListView"`), `LpxTar_change` (`New LPrix(…) As "LpxTar"`).
- **Vraie réduction** : `EnrTarArt` (appel interne seulement, vérifié par `grep -rn`).
- **`Bsel`/`Bval`** : écrits par `TriCpt` (`Object.SetProperty`, `TriCpt:112-113`) : `Public`.
- **Données partagées non vues par `deps.py`** : `Sailig.AutresObj[Achat.Tarif]` est un
  `VarMajTar` (accès `Variant` : `IgnoreTarif`, `MajTar`, `DateTarif`, `TarGen`, `TarCli`,
  `TarTcli`, `ResArt`, `LecArt`, `SauvColl`) ; `AutresObj[Achat.FicheArt]` est le `Result` de la
  fiche article lu par `Achat.ligne_LecCode`.
- **Énumérations publiques lues ailleurs** : `TarGen`/`TarCli`/`TarTcli` (`DateTar:207-244`,
  `VarMajTar:46`, `commande1:83-84`, requêtes préparées), `SupLigne` (`VarMajTar:168`).
- **Transactions** : `commande1` ouvre `Utils.db.Begin` (lignes 599 et 807) avant
  `Achat.EnrAch`, qui valide lui-même (`Commit`, `Achat:895`) ; les appels suivants
  `EnrTar`/`EnrArt`/`EnrEtiqu` (`commande1:610-611`, `818-820`) s'exécutent donc **hors**
  transaction, puis `commande1:615` refait un `Commit`. `Tarif_EnrTar` (`commande1:872-874`)
  encadre `EnrTar` de sa propre transaction, elle-même imbriquée dans celle d'`Enreg_Click`.
- **Ordre de rework** : avec `Achat`, `VarMajTar` et `commande1` (données `AutresObj`
  partagées) ; la fabrique de prix commune (GESTAR-008) avec `DateTar`, `TarTypeCli`,
  `VarMajTar`.
