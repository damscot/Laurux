# SaiReg — Dépendances

> Source : `.src/Gestion/Facturation/SaiReg.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/SaiReg.class` — classe, formulaire associé `SaiReg.form`
- Handlers GUI détectés : 31
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 975 `SaiReg.Raise RegCaisse` (4 donnés, attendus 3), l. 992 `SaiReg.Raise RegCaisse` (4 donnés, attendus 3)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `impecr`, `quite_Click`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `selection_Click`
- ⚠️ Grilles rejouées par `ReplayObserver.Replay_Click` sans handler `<Grille>_Click` (`Object.Call` d'une méthode inexistante, voir REPLAYOBSERVER-A06) : `borderaux`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Communs/Fmenu.class` | `<hérité>` |
| `.src/Gestion/option/ObjFacB.class` | `<type>`, `Form_Close` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `DB_Connection` | `Create9`, `Engine`, `Exec` |
| `EcrAuto` | `FinImp`, `Imp`, `Impression`, `ecriture` |
| `EcrReg` | `<type>` |
| `EdReg` | `<type>`, `ajout`, `tous` |
| `Fmontant` | `<hérité>` |
| `LDate` | `<type>`, `G`, `L`, `_call` |
| `Listextcpt` | `<type>`, `rechechelot`, `rechedoc`, `resext` |
| `Mreglement` | `autre`, `sans_caisse` |
| `ObjFac` | `archive`, `bl`, `facture`, `finmois` |
| `OptFac` | `<type>` |
| `ProgBar` | `<type>`, `Avancement` |
| `Start` | `LocalSettings`, `Societe` |
| `TextReg` | `<form>`, `<type>`, `EstDate`, `EstNum`, `MaxLength`, `RechX`, `RechY`, `Text`, `Type`, `Value`, `champs`, `conteneur`, `dte`, `nbdec`, `recherche`, `reg` |
| `TriCpt` | `<type>`, `Avec_Solde`, `Client_Fournisseur` |
| `Utils` | `Observers`, `arrondi`, `cpoint`, `db` |
| `VarEcr` | `<type>`, `Caisse`, `L_ajou`, `L_modif`, `L_sans`, `L_sup`, `L_valide`, `Max`, `Tbl`, `Tlettrage`, `Treso`, `collectif`, `compte`, `dte`, `dtee`, `dteech`, `etat`, `intitul`, `journal`, `libelle`, `lind`, `modifi`, `moins`, `montantc`, `montantd`, `nb`, `newTbl`, `numdoc`, `numero`, `numlot`, `plus`, `trouve`, `type` |
| `VerifDate` | `<type>`, `ClotComptable` |
| `Visualiseur` | `Prog` |
| `chainage` | `<type>`, `add` |

### Tables SQL référencées

`Fiches_Bl`, `Fiches_BlM`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Reglements`

### Membres Public sans usage externe détecté (portée réductible ?)

`check_reg`, `selection_choose`, `vldsaisie_Click`, `vldbordereau_Click`, `editions_Click`, `editionb_Click`, `quite_Click`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants :
  - `Fmenu` : `SaiReg.ShowModal` (auto-instance) depuis `brdreg_Click`, `rglmt_Click` et
    `lbsr_MouseUp` (l. 1514, 1811, 2579) ;
  - `ObjFacB.editef` : `$sreg = New SaiReg($win, VarEcr.caisse, Me.numcli) As "win"`
    ([ObjFacB.class:740](../../../../../.src/Gestion/option/ObjFacB.class#L740)) puis `$sreg.Form_Close()` dans `win_close` ([ObjFacB.class:751](../../../../../.src/Gestion/option/ObjFacB.class#L751)).
    `$win` est consommé par le constructeur de `Form`. Aucun gestionnaire `win_RegCaisse`.
- `unused` de `deps.py` : `impecr` (privée, jamais appelée) et `quite_Click` (aucun contrôle
  `quite` dans le `.form`) sont réellement morts.
- `scope_reducible` : confirmé pour `check_reg`, `selection_choose`, `vldsaisie_Click`,
  `vldbordereau_Click`, `editions_Click`, `editionb_Click` (noms de handlers sans contrôle
  correspondant ; appelés par `valide_Click`/`edite_Click`/`nreg_LostFocus`/`Form_Close`).
  `quite_Click` : suppression plutôt que réduction.
- `replay_dynamic` : `selection_Click` (GridView) → `Public` obligatoire.
- **`Listreg` est une `ListView`** : `ReplayObserver` n'enregistre ni ne rejoue ses clics
  (REPLAYOBSERVER-A06) ; tant que A06 n'est pas validée, le choix d'un règlement dans la liste
  doit être remplacé dans les scénarios par la saisie directe du code dans `nreg`.
- Groupes du `.form` : `rdoc` (`tdcs`, `fcts`, `bl`) ; observateurs `sel` (`client`, `ndoc`,
  `nlot`) ; `btval`/`btaba` (boutons créés dynamiquement).
- **Event `RegCaisse`** : déclaré à 3 paramètres, levé à 4 (l. 975, 992). `deps.py` ne contrôle
  pas l'arité des `Raise` (faux négatif). Vérifié sur projet minimal : sans gestionnaire, aucune
  erreur ; avec un gestionnaire, « Too many arguments ».
- Tables en dur (`Fiches_Reglements`, `Fiches_Journaux`, `Fiches_Mvt`, `Fiches_Comptes`,
  `Fiches_Bl[M]`, `Fiches_HistoFac[M]`, `Fiches_Cli`) ; tables de travail `Facturefm`/`Bl`
  partagées (FACTUREFM-A02).
- Ordre de rework : `VarEcr`, `Listextcpt`, `EcrReg` (lot Compta, documentés) avant ; `ObjFacB`
  (lot Gestion/option) pour l'usage incrusté.
