# Facturergbl — Dépendances

> Source : `.src/Gestion/Facturation/Facturergbl.class` · Généré par `reference/tools/deps.py` (heuristique statique).

<!-- AUTO:dependances -->
- Fichier : `.src/Gestion/Facturation/Facturergbl.class` — classe, formulaire associé `Facturergbl.form`
- Handlers GUI détectés : 17
- ⚠️ Appels avec un nombre d'arguments incompatible avec la signature : l. 948 `Cdocuments.Level6F` (5 donnés, attendus 6), l. 953 `Cdocuments.Level6F` (5 donnés, attendus 6), l. 960 `Cdocuments.Level6F` (5 donnés, attendus 6)
- Fonctions jamais référencées (ni dans le fichier, ni ailleurs ; code mort probable) : `Bl_Edit`, `Bl_Sup`, `ard`
- Appelés dynamiquement par `ReplayObserver.Replay_Click` (`Object.Call`, doivent rester `Public`) : `Colbl_Click`, `Coldetail_Click`

### Utilisé par

| Fichier appelant | Membres utilisés |
|---|---|
| `.src/Caisse/Moulinage.class` | `<type>`, `Ent_Bl`, `Maj_Parametres` |
| `.src/Communs/Fmenu.class` | `<hérité>` |

### Utilise

| Fichier utilisé | Membres |
|---|---|
| `AFacture` | `<type>` |
| `Cbase` | `Table` |
| `Cdocuments` | `<type>`, `Entete`, `Entete2`, `Level10F`, `Level11F`, `Level12F`, `Level13F`, `Level1F`, `Level2F`, `Level3F`, `Level4F`, `Level4aF`, `Level4bF`, `Level5F`, `Level6F`, `Level7F`, `Level8F`, `Level9F` |
| `DB_Connection` | `Engine`, `Exec` |
| `Doc` | `Open` |
| `DocActif` | `Free_Lock`, `Get_Lock` |
| `Impression` | `Facture` |
| `LDate` | `_call` |
| `PdfWriter` | `AliasNbPages`, `Open`, `Output` |
| `Start` | `LocalSettings`, `Musique`, `Societe`, `son` |
| `Syntheses` | `Message` |
| `Utils` | `Calcech`, `Cdate_Aff`, `Cdate_Dbase`, `Cdate_calc`, `Coulfd`, `Observers`, `cpoint`, `db` |
| `Variables` | `bRemise` |

### Tables SQL référencées

`Docs_Ged`, `Docs_Tag`, `Fiches_Art`, `Fiches_Bl`, `Fiches_Cli`, `Fiches_Comptes`, `Fiches_Echeances`, `Fiches_Fam`, `Fiches_HistoFac`, `Fiches_LibelFac`, `Fiches_Ligbl`, `Fiches_Mo`, `Fiches_Mvt`, `Fiches_Parametres`, `Fiches_RgLigbl`, `Fiches_Societes`, `Fiches_Suivis`, `Fiches_Tag`, `Fiches_Tleg`, `Fiches_Tvaav`

### Membres Public sans usage externe détecté (portée réductible ?)

`recup_bl`, `Quittedate`, `Bl_Edit`, `Parametres`, `Ventilation`, `Maj_Totalisation`, `Calc_tva`, `Selbl`, `Bl_Sup`, `ard`, `Cclient`
<!-- /AUTO:dependances -->

## Notes d'analyse

Vérifications faites par `grep -rn` sur `.src` (commit `6b6b9dfc`).

- Appelants :
  - `Fmenu.Menu306_Click` : `Facturergbl.ShowModal()` (auto-instance) ;
  - `Moulinage` : `RegroupBL = New Facturergbl` ([Moulinage.class:1007](../../../../../.src/Caisse/Moulinage.class#L1007)), puis
    `RegroupBL.Ent_Bl(Bl!cdclibl, numbon, False, rtck!numero, Date_Bl)` ([Moulinage.class:1307](../../../../../.src/Caisse/Moulinage.class#L1307))
    et `RegroupBL.Maj_Parametres(numbon)` ([Moulinage.class:1437](../../../../../.src/Caisse/Moulinage.class#L1437)). L'instanciation exécute
    `_New` : lecture de `Fiches_Parametres`, enregistrement des observateurs de rejeu sur un
    formulaire jamais affiché, **commande système `lpc status`**. `Ent_Bl` et `Maj_Parametres`
    doivent rester `Public` ; leur signature ne peut changer qu'avec `Moulinage` (lot Caisse).
- **Arité** (`arity_errors` de `deps.py`) : `Cdocuments.Level6F` appelé avec 5 arguments au lieu
  de 6 aux lignes 948, 953 et 960 ([Facturergbl.class:948](../../../../../.src/Gestion/Facturation/Facturergbl.class#L948), [Cdocuments.class:764](../../../../../.src/Reports/Cdocuments.class#L764)). Vérifié :
  le paramètre `frais` (5ᵉ) manque, `PosY` est passé à sa place. Ces appels sont dans
  `Button14_Click`, **inatteignable** (panneau `Edit` jamais affiché) : anomalie latente,
  traitée avec la décision FACTURERGBL-A01.
- `unused` : `Bl_Edit`, `Bl_Sup`, `ard` sont réellement morts (`grep` : les homonymes de
  `Facture` et `ValidBR` sont d'autres fonctions). `deps.py` ne détecte pas que
  `Button14_Click`, `Button16_Click`, `dtef_LostFocus`, `Ventilation`, `Maj_Totalisation` et
  `Calc_tva` sont inatteignables (handlers d'un panneau invisible) : code mort « par
  accessibilité ».
- Le contrôle public `!Entete` du `.form` n'est pas reconnu par `deps.py` (préfixe `!`) ; aucun
  handler `Entete_*` n'existe ici, sans conséquence.
- `replay_dynamic` : `Colbl_Click`, `Coldetail_Click` → `Public` obligatoire.
- Tables de travail `Facturefm`, `Bl` (structure propre : `Bl.numbl` au lieu de `num`) et
  `Totalisation` : sans clé `Cbase`, partagées avec `Facturefm`, `FacturefmA`, `SaiReg`,
  `Visimpayes`, `Visreglements` (voir FACTUREFM-A02). La table `Bl` créée ici n'est lue que par
  cet écran (`Ent_Bl`), pas par `ObjFac` (pas d'édition en sortie).
- `DocActif.Get_Lock`/`Free_Lock` (verrous applicatifs, [DocActif](../../../Communs/DocActif.class/architecture.md))
  exécutent `LOCK TABLES`/`UNLOCK TABLES` : interaction avec les `LOCK TABLES` de `Button9_Click`
  (FACTURERGBL-A03).
- Ordre de rework : `Ent_Bl` avec `Moulinage` (lot Caisse) ; base commune avec `Facturefm` et
  `FacturefmA`.
