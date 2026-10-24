# DocActif — Dépendances

> Source : `.src/Communs/DocActif.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Communs/DocActif.class` — classe, formulaire associé `DocActif.form`
- Handlers GUI détectés : 4
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `listdoc_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Caisse.class` | `Free_Lock`, `Get_Lock` |
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Parametre.class` | `Free_Lock`, `Get_Lock` |
| `.src/Compta/Tresor.class` | `Free_Lock`, `Get_Lock`, `Is_Lock` |
| `.src/Compta/Utils/EcrAuto.class` | `Free_Lock`, `Get_Lock`, `Is_Lock` |
| `.src/Gestion/Facturation/Facture.class` | `Free_Lock`, `Get_Lock`, `Is_Lock` |
| `.src/Gestion/Facturation/Facturergbl.class` | `Free_Lock`, `Get_Lock` |
| `.src/Gestion/Stock/commande1.class` | `Free_Lock`, `Get_Lock` |
| `.src/Gestion/Tables/Materiel.class` | `Is_Lock` |
| `.src/Gestion/option/ObjFacB.class` | `Free_Lock`, `Get_Lock` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Utils` | `Base2`, `Bip`, `db`, `rs2` |

### Tables SQL référencées

`Fiches_Docactif`

### Membres Public sans usage externe détecté (portée réductible ?)

`Deb1`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Usage statique d'une fenêtre** : tous les appelants utilisent l'auto-instance
  (`DocActif.Get_Lock` sans `New`) ; `deps.py` le détecte correctement. Casse variable chez les
  appelants (`get_lock`, `free_lock`, `is_lock`, `Get_lock`) : Gambas n'est pas sensible à la
  casse, `deps.py` les regroupe bien.
- **Appelants qui utilisent la valeur de retour** : `Caisse` (l.3489, 4265), `commande1` (l.351),
  `Facturergbl` (l.1274), `ObjFacB` (l.647, boucle active jusqu'à obtention), `Facture` (l.1966 pour
  `Get_Lock` ; l.1523 et 1946 pour **`Free_Lock`**, dont la valeur est toujours `False`), `Materiel`
  et `Facture` (l.6983) pour `Is_Lock`. Les autres ignorent le résultat (`Parametre`, `Tresor`,
  `EcrAuto`, `Facturergbl` l.1267, `Facture` l.1586).
- **Global partagé** `Utils.rs2` (via `Utils.Base2`) : couplage implicite avec tous les écrans qui
  utilisent `Base2` (non signalé par `deps.py` comme état partagé).
- **SQLite** : `LOCK TABLES`/`UNLOCK TABLES` renvoient `Null` (neutralisés par `DB_Connection`) ;
  l'exclusion repose alors sur la clé primaire de `Fiches_Docactif`.
- **Commandes externes** : `cat /etc/machine-id`, `hostname`, `hostid`, `ps -p`.
- **Ordre de rework** : la correction de `Free_Lock` (A01) impacte `Facture` ; la séparation
  traitement/GUI est un prérequis d'un futur module de verrous. À traiter avant les reworks des
  9 appelants qui toucheraient à l'enchaînement des verrous.

