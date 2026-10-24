# Cielimp — Dépendances

> Source : `.src/Compta/Cielimp.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Cielimp.class` — classe, formulaire associé `Cielimp.form`
- Handlers GUI détectés : 2
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Compta2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `Editeur` | `Prog_Editeur` |
| `Utils` | `Observers`, `PointBase`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Cli`, `Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`

### Membres Public sans usage externe détecté (portée réductible ?)

`controle_comptes`, `Compta`, `Compta2`, `Parametres`, `Ecritures`, `Maj_Parametres`, `Majnum`, `Button3_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Appelant unique : `Fmenu.Menu182_Click` (`Fmenu.class:1721`, `ShowModal` sur l'auto-instance).
- **Surestimation** : `Fiches_Cli` figure dans les tables détectées, mais seulement via la
  variable morte `Tabc` (jamais utilisée dans une requête).
- **Tables non détectées** : `Ciel_Lrx`, `Ciel_Lrx_Jo` (créées ici et par `Utils.Ciel`, lues
  par `Cielcorsp`, `Cielcorspj`, `impfec`) et `Cptabs` (table de travail créée et laissée en
  base). Colonnes de `Fiches_Parametres` lues ou écrites par nom construit : `numecriture`
  (`Ecritures`/`Majnum`), `imp_ciel`.
- `Compta2` : aucun appelant (`grep -rn "Compta2" .src`) ; `Ecritures`, `Majnum`,
  `Maj_Parametres`, `Parametres` : les homonymes de `Moulinage`, `ValidBR`, `Tresor`,
  `TresorFac`, `Facture`, `Facturergbl` sont locaux.
- Effets hors base : fichiers `~/tmp/FCompte`, `~/tmp/FJournaux`, `~/tmp/FClients` ;
  `Editeur.Prog_Editeur` ouvre un éditeur externe.
- Ordre de rework : après `Cielcorsp`/`Cielcorspj` si leur module commun expose le contrôle des
  correspondances ; la commonalisation de la numérotation se fait en phase 3 avec `Moulinage`,
  `Tresor`, `ValidBR`, `Facture`.
