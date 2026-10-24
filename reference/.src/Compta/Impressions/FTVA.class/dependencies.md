# FTVA — Dépendances

> Source : `.src/Compta/Impressions/FTVA.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Impressions/FTVA.class` — classe, formulaire associé `FTVA.form`
- Handlers GUI détectés : 11
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `ColumnViewTVAachat`, `ColumnViewTVAvente`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbalances` | `<type>`, `BasPage`, `Entete`, `Level0T`, `Level1T`, `Level2T`, `Level3T`, `Level4T`, `Level4TVA`, `Level5T` |
| `Cbase` | `Table` |
| `DB_Connection` | `Engine`, `Exec` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `Societe` |
| `Utils` | `Cdate_Aff`, `Cdate_Comp`, `Coulfd`, `cpoint`, `db` |
| `Visualiseur` | `Prog` |

### Tables SQL référencées

`Fiches_Comptes`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_Societes`

### Membres Public sans usage externe détecté (portée réductible ?)

`Affiche`, `trimestre`, `moiscalc`, `anneecalc`, `Raz`
<!-- /AUTO:dependances -->

## Notes d'analyse

- **Appelant unique** : `Fmenu.Menu263_Click` (`.src/Communs/Fmenu.class:2128`, menu « Récapitulatif
  TVA »), par l'auto-instance `FTVA.show()`. Aucun autre fichier n'appelle un membre de FTVA
  (`grep -rn "FTVA\." .src`) : la « portée réductible » de `Affiche`, `trimestre`, `moiscalc`,
  `anneecalc` est confirmée ; `Raz` (non listé par l'heuristique) l'est aussi.
- **Tables** : la liste AUTO est exacte pour les tables métier ; elle omet la table de travail
  `Ctrln` (DDL dans `button2_Click`, nom dans une variable). `Fiches_Journaux` n'est lu que par
  des requêtes dont le résultat est ignoré.
- **Table de travail partagée `Ctrln`** : même nom, structures différentes, dans `Editcompte`,
  `EditcompteM`, `Extrait`, `FTVA`, `EdImpayes` (et nom réservé dans `EdNjustifiees`) ; recréée à
  chaque compte et laissée en base : collision possible entre deux postes imprimant en même temps
  (voir EDITCOMPTE-A06 dans [Editcompte/rework.md](../Editcompte.class/rework.md)). FTVA ne
  l'alimente pas : FTVA-004 la retire.
- **`Cbalances`** (`.src/Reports/Cbalances.class`) : seuls FTVA et `BalanceM` l'instancient ; les
  méthodes `Level0T`…`Level5T`, `Level4TVA` ne servent qu'à FTVA. Un changement de signature de ces
  méthodes ne touche que ce fichier.
- **`Visualiseur.Prog`** : ouvre le PDF par `Desktop.Open` ou par la commande
  `/Soc<XX>/caisse/CmdVis` ; c'est le point d'interception des tests replay.
- **Handlers sans contrôle visible** : `Texercice_Click` (case invisible dans le `.form`).
- Aucun appel dynamique, aucune dépendance circulaire.
- **Ordre de rework** : après le socle commun d'édition (s'il est retenu) et après LDATE-008
  (`Exercice_Cloture`). Indépendant des autres éditions sinon.
