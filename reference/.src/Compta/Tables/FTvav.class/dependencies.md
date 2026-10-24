# FTvav — Dépendances

> Source : `.src/Compta/Tables/FTvav.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Compta/Tables/FTvav.class` — classe, formulaire associé `FTvav.form`
- Handlers GUI détectés : 10
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Cleanchamps`, `Tvaman`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Tvalist_Click`, `Tvavlist_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `tvalist2`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Communs/Parametre.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `Cbase` | `Table` |
| `DB_Connection` | `Exec` |
| `Doc` | `Open` |
| `Start` | `Musique`, `son` |
| `Utils` | `Find_nbdec`, `Observers`, `PointBase`, `SetEditColor`, `cpoint`, `db` |

### Tables SQL référencées

`Fiches_Art`, `Fiches_Bl`, `Fiches_BlM`, `Fiches_Comptes`, `Fiches_Fam`, `Fiches_Ligbl`, `Fiches_LigblM`, `Fiches_Mo`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`Refresh`, `Maj_Zones`, `Cleanchamps`, `Cdtva_GotFocus`, `Txtva_LostFocus`, `Tvacc_GotFocus`, `Button1_Click`, `Button3_Click`, `Tvaman`, `Recalcul`, `arrondi`
<!-- /AUTO:dependances -->

## Notes d'analyse

- Points d'entrée : `Fmenu.Menu112_Click` (`.src/Communs/Fmenu.class:541`) et `Parametre`
  (`.src/Communs/Parametre.class:248`, `282`, `567`, `FTvav.ShowModal` sur l'auto-instance après
  « Ce compte de TVA n'existe pas, voulez-vous le créer ? »). Aucun membre appelé de l'extérieur.
- `Tvaman` : jamais appelée (aucun `Tvacc_LostFocus` dans ce fichier) → code mort de fait, que
  `deps.py` présente comme simple « portée réductible ». `Cleanchamps` : aucun appel.
- `Txtva_LostFocus` : handler nominal inactif (groupe `tva`) mais appelé explicitement
  (`Tva_KeyPress`, `Btn_Click`) : à juste titre absent des handlers inactifs.
- `arrondi` est homonyme de `Utils.arrondi` (signature différente) : pas de conflit, l'appel interne
  est non qualifié.
- Tables modifiées par `Recalcul`, toutes via `Cbase.Table` : `Fiches_Fam`, `Fiches_Ligbl`,
  `Fiches_LigblM`, `Fiches_Art`, `Fiches_Mo` (et lecture de `Fiches_Bl`, `Fiches_BlM`). Tout rework
  de la facturation qui change le format de `nettc_ligbl` doit repasser FTVAV-T03.
- Ordre de rework : avec `FTvac` (module commun) ; `ArrondiPrix` à figer avant toute commonalisation
  avec `Utils.arrondi`/`LPrix`.
